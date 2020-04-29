
#include <iostream>
#include <fstream>
#include <string>
#include <cassert>

#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h"
#include "ns3/applications-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/flow-monitor-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("FifthScriptExample");
Ptr<PacketSink> sinks1; 
Ptr<PacketSink> sinks2; 

class MyApp : public Application 
{
public:

  MyApp ();
  virtual ~MyApp();

  void Setup (Ptr<Socket> socket, Address address, uint32_t packetSize, uint32_t nPackets, DataRate dataRate);

private:
  virtual void StartApplication (void);
  virtual void StopApplication (void);

  void ScheduleTx (void);
  void SendPacket (void);

  Ptr<Socket>     m_socket;
  Address         m_peer;
  uint32_t        m_packetSize;
  uint32_t        m_nPackets;
  DataRate        m_dataRate;
  EventId         m_sendEvent;
  bool            m_running;
  uint32_t        m_packetsSent;
};

MyApp::MyApp ()
  : m_socket (0), 
    m_peer (), 
    m_packetSize (0), 
    m_nPackets (0), 
    m_dataRate (0), 
    m_sendEvent (), 
    m_running (false), 
    m_packetsSent (0)
{
}

MyApp::~MyApp()
{
  m_socket = 0;
}

void
MyApp::Setup (Ptr<Socket> socket, Address address, uint32_t packetSize, uint32_t nPackets, DataRate dataRate)
{
  m_socket = socket;
  m_peer = address;
  m_packetSize = packetSize;
  m_nPackets = nPackets;
  m_dataRate = dataRate;
}

void
MyApp::StartApplication (void)
{
  m_running = true;
  m_packetsSent = 0;
  m_socket->Bind ();
  m_socket->Connect (m_peer);
  SendPacket ();
}

void 
MyApp::StopApplication (void)
{
  m_running = false;

  if (m_sendEvent.IsRunning ())
    {
      Simulator::Cancel (m_sendEvent);
    }

  if (m_socket)
    {
      m_socket->Close ();
    }
}

void 
MyApp::SendPacket (void)
{
  Ptr<Packet> packet = Create<Packet> (m_packetSize);
  m_socket->Send (packet);

  if (++m_packetsSent < m_nPackets)
    {
      ScheduleTx ();
    }
}

void 
MyApp::ScheduleTx (void)
{
  if (m_running)
    {
      Time tNext (Seconds (m_packetSize * 8 / static_cast<double> (m_dataRate.GetBitRate ())));
      m_sendEvent = Simulator::Schedule (tNext, &MyApp::SendPacket, this);
    }
}
static void
CwndTracer (uint32_t oldCwnd, uint32_t newCwnd)
{
  NS_LOG_UNCOND ( Simulator::Now ().GetSeconds () << "\t" << newCwnd);
}

void
CwndConnect(){

 Config::ConnectWithoutContext ("/NodeList/*/$ns3::TcpL4Protocol/SocketList/*/CongestionWindow", MakeCallback (&CwndTracer));
}

static void
RxDrop (Ptr<const Packet> p)
{
  NS_LOG_UNCOND ("RxDrop at " << Simulator::Now ().GetSeconds ());
}


int 
main (int argc, char *argv[])
{
  NodeContainer c;
  c.Create (6);

  PointToPointHelper p2ph1;
  p2ph1.SetDeviceAttribute ("DataRate", StringValue ("3Mbps"));
  p2ph1.SetChannelAttribute ("Delay", StringValue ("10ms"));
  p2ph1.SetQueue("ns3::DropTailQueue",  "MaxPackets",UintegerValue(1));



  PointToPointHelper p2ph2;
  p2ph2.SetDeviceAttribute ("DataRate", StringValue ("1.5Mbps"));
  p2ph2.SetChannelAttribute ("Delay", StringValue ("10ms"));
  p2ph2.SetQueue("ns3::DropTailQueue",  "MaxPackets",UintegerValue(1));

  
  NodeContainer n0n1 = NodeContainer (c.Get (0), c.Get (2)); // creation of links
  NodeContainer n2n1 = NodeContainer (c.Get (1), c.Get (2));
  NodeContainer n1n3 = NodeContainer (c.Get (2), c.Get (3));
  NodeContainer n3n4 = NodeContainer (c.Get (3), c.Get (4));
  NodeContainer n3n5 = NodeContainer (c.Get (3), c.Get (5));





  InternetStackHelper internet;
  internet.Install (c);


  NetDeviceContainer internetDevices1 = p2ph1.Install (n0n1);
  NetDeviceContainer internetDevices2 = p2ph1.Install (n2n1);
  NetDeviceContainer internetDevices3 = p2ph2.Install (n1n3);
  NetDeviceContainer internetDevices4 = p2ph1.Install (n3n4);
  NetDeviceContainer internetDevices5 = p2ph1.Install (n3n5);

  Ipv4AddressHelper ipv4h1;
  Ipv4AddressHelper ipv4h2;
  Ipv4AddressHelper ipv4h3;
  Ipv4AddressHelper ipv4h4;
  Ipv4AddressHelper ipv4h5;
  ipv4h1.SetBase ("1.0.0.0", "255.0.0.0");
  ipv4h2.SetBase ("2.0.0.0", "255.0.0.0");
  ipv4h3.SetBase ("3.0.0.0", "255.0.0.0");
  ipv4h4.SetBase ("4.0.0.0", "255.0.0.0");
  ipv4h5.SetBase ("5.0.0.0", "255.0.0.0");
  
  Ipv4InterfaceContainer interfaces1 = ipv4h1.Assign (internetDevices1);
  Ipv4InterfaceContainer interfaces2 = ipv4h2.Assign (internetDevices2);
  Ipv4InterfaceContainer interfaces3 = ipv4h3.Assign (internetDevices3);
  Ipv4InterfaceContainer interfaces4 = ipv4h4.Assign (internetDevices4);
  Ipv4InterfaceContainer interfaces5 = ipv4h5.Assign (internetDevices5);

  Ipv4GlobalRoutingHelper::PopulateRoutingTables ();

   Ptr<RateErrorModel> em = CreateObject<RateErrorModel> ();
  em->SetAttribute ("ErrorRate", DoubleValue (0.00001));
  internetDevices1.Get (1)->SetAttribute ("ReceiveErrorModel", PointerValue (em));

   uint16_t port = 9;
  BulkSendHelper source1 ("ns3::TcpSocketFactory", //installing application 
                         InetSocketAddress (interfaces4.GetAddress (1), port));
     // Set the amount of data to send in bytes.  Zero is unlimited.
      source1.SetAttribute ("MaxBytes", UintegerValue (0));
    // Set the segment size
     source1.SetAttribute ("SendSize", UintegerValue (10000));
  ApplicationContainer sourceApps1 = source1.Install (c.Get (0));
  sourceApps1.Start (Seconds (1.0));
  sourceApps1.Stop (Seconds (10.0));

    OnOffHelper onoff1 ("ns3::UdpSocketFactory",InetSocketAddress (interfaces5.GetAddress (1), port));
    onoff1.SetConstantRate (DataRate ("5Mbps"));
    onoff1.SetAttribute ("PacketSize", UintegerValue (1000));
    onoff1.SetAttribute ("MaxBytes", UintegerValue (0));

  ApplicationContainer sourceApps2 = onoff1.Install (c.Get (1));
  sourceApps2.Start (Seconds (1.0));
  sourceApps2.Stop (Seconds (10.0));



  PacketSinkHelper sink1 ("ns3::TcpSocketFactory", //installing sink
                         InetSocketAddress (Ipv4Address::GetAny (), port));
  ApplicationContainer sinkApps1 = sink1.Install (c.Get (4));
  sinks1 = StaticCast<PacketSink> (sinkApps1.Get (0));
  sinkApps1.Start (Seconds (0.0));
  sinkApps1.Stop (Seconds (10.0));

  PacketSinkHelper sink2 ("ns3::UdpSocketFactory", //installing sink
                         InetSocketAddress (Ipv4Address::GetAny (), port));
  ApplicationContainer sinkApps2 = sink2.Install (c.Get (5));
  sinks2 = StaticCast<PacketSink> (sinkApps2.Get (0));
  sinkApps2.Start (Seconds (0.0));
  sinkApps2.Stop (Seconds (10.0));




  c.Get (1)->TraceConnectWithoutContext ("PhyRxDrop", MakeCallback (&RxDrop));

   FlowMonitorHelper flowmon;
  Ptr<FlowMonitor> monitor = flowmon.InstallAll();


  Simulator::Stop (Seconds (10));
  //Simulator::Schedule(Seconds(1.001), &CwndConnect);
  Simulator::Run ();

  monitor->CheckForLostPackets ();
  Ptr<Ipv4FlowClassifier> classifier = DynamicCast<Ipv4FlowClassifier> (flowmon.GetClassifier ());
  std::map<FlowId, FlowMonitor::FlowStats> stats = monitor->GetFlowStats ();
  std::map<FlowId, FlowMonitor::FlowStats>::const_iterator i;
  for (std::map<FlowId, FlowMonitor::FlowStats>::const_iterator i = stats.begin (); i != stats.end (); ++i)
    {
	 Ipv4FlowClassifier::FiveTuple t = classifier->FindFlow (i->first);
	
    	 NS_LOG_DEBUG ("Flow " << i->first  << " (" << t.sourceAddress << " -> " << t.destinationAddress << ")");

     std::cout << "Flow " << i->first << " (" << t.sourceAddress << " -> " << t.destinationAddress << ")\n";           
         std::cout << "  Tx Bytes:   " << i->second.txBytes << "\n";
          std::cout << "  Rx Bytes:   " << i->second.rxBytes << "\n";
          std::cout<<"Throughput" << i->second.rxBytes * 8.0 / (i->second.timeLastRxPacket.GetSeconds()-i->second.timeFirstTxPacket.GetSeconds()) / 1024 / 1024  << " Mbps\n";
         // std::cout << (i->second.delaySum)/(i->second.rxPackets)<<"\n";
	}
  Simulator::Destroy ();

  return 0;
}


