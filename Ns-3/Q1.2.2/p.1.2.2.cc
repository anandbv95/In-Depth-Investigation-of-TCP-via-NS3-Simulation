
#include "ns3/point-to-point-layout-module.h"
#include "ns3/internet-module.h"
#include "ns3/network-module.h"
#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/netanim-module.h"
#include "ns3/flow-monitor-module.h"




using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("Case1");

class TestApp:public Application
{
public :
	TestApp();
	virtual ~TestApp();
	static TypeId GetTypeId(void);
	void setupTest(Ptr<Socket> socket , Address address,uint32_t packetSize,uint32_t nPackets,DataRate dataRate);
private :
	virtual void StartApplication(void);
	virtual void StopApplication(void);
	void ScheduleTx(void);
	void SendPacket(void);

	Ptr<Socket> m_socket;
	Address m_peer;
	uint32_t m_packetSize;
	uint32_t m_nPackets;
	DataRate m_dataRate;
	EventId m_sendEvent;
	bool m_running;
	uint32_t m_packetsSent;
};

TestApp::TestApp()
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
TestApp::~TestApp()
{
	m_socket=0;
}

TypeId TestApp::GetTypeId()
{
	static TypeId tid = TypeId("TestApp")
			.SetParent<Application>()
			.SetGroupName("Tutorial")
			.AddConstructor<TestApp>()
			;
	return tid;

}
void TestApp::setupTest(Ptr<Socket> socket,Address address,uint32_t packetSize,uint32_t nPackets,DataRate dataRate)
{
	m_socket=socket;
	m_peer=address;
	m_packetSize=packetSize;
	m_nPackets=nPackets;
	m_dataRate=dataRate;
}
void TestApp::StartApplication(void)
{
	NS_LOG_INFO ("Start Application");
	m_running = true;
	m_packetsSent=0;
	m_socket->Bind();
	m_socket->Connect(m_peer);
	SendPacket();
}

void TestApp::StopApplication(void)
{
//	NS_LOG_INFO ("Stop Application");
	m_running=false;
	if(m_sendEvent.IsRunning())
	{
		Simulator::Cancel(m_sendEvent);
	}
	if(m_socket)
	{
		m_socket->Close();
	}

}
void TestApp::SendPacket(void)
{
//	NS_LOG_INFO ("Send Packet");
	Ptr<Packet> packet = Create<Packet> (m_packetSize);
	m_socket->Send(packet);
	if(++m_packetsSent <m_nPackets)
	{
		ScheduleTx();
	}
}

void TestApp::ScheduleTx(void)
{
//	NS_LOG_INFO ("Schedule Tx");
	if(m_running)
	{
		Time tNext(Seconds(m_packetSize *8/static_cast<double> (m_dataRate.GetBitRate())));
		m_sendEvent=Simulator::Schedule(tNext,&TestApp::SendPacket,this);
	}
}
///Defination of TestApp Class is over

static void SendData (Ptr<const Packet> p)
{
  std::cout<<" Send Data at " << Simulator::Now ().GetSeconds()<<std::endl;
}

static void ReceiveData (Ptr<const Packet> p)
{
  std::cout<<" Receive Data at " << Simulator::Now ().GetSeconds()<<std::endl;
}

bool firstCwnd = true;
bool firstRtt = true; 
bool firstRto = true;

  static void
CwndChange (Ptr<OutputStreamWrapper> stream, uint32_t oldCwnd, uint32_t newCwnd)
{
   if (firstCwnd)
	{
  	  *stream->GetStream () <<Simulator::Now ().GetSeconds () << "\t" << newCwnd; 
  	  firstCwnd=false;
	}

  *stream->GetStream () << Simulator::Now ().GetSeconds () << "\t" << oldCwnd << "\t" << newCwnd << std::endl;
}


static void
RttTracer (Ptr<OutputStreamWrapper> stream, Time oldval, Time newval)
{
  if (firstRtt)
    {
      *stream->GetStream () << "0.0 " << oldval.GetSeconds () << std::endl;
      firstRtt = false;
    }
  *stream->GetStream () << Simulator::Now ().GetSeconds () << " " << newval.GetSeconds () << std::endl;
}

static void
RtoTracer (Ptr<OutputStreamWrapper> stream,Time oldval, Time newval)
{
  if (firstRto)
    {
      *stream->GetStream () << "0.0 " << oldval.GetSeconds () << std::endl;
      firstRto = false;
    }
  *stream->GetStream () << Simulator::Now ().GetSeconds () << " " << newval.GetSeconds () << std::endl;
}


int main(int argc , char * argv[])
{
	  LogComponentEnable ("Case1", LOG_LEVEL_INFO);
	  std::string tcpType = "NewReno";
	  std::string animFile = "Case-1.xml" ;  // Name of file for animation output
	  Config::SetDefault("ns3::TcpL4Protocol::SocketType",TypeIdValue(TypeId::LookupByName("ns3::Tcp" + tcpType)));
	  uint32_t    nLeftLeaf = 2;
	  uint32_t    nRightLeaf = 2;
	  double errorprob = 0.01;

	  //Bottleneck Router link connecting left , right Nodes
	  PointToPointHelper Link1;
	  Link1.SetQueue("ns3::DropTailQueue", "MaxPackets",UintegerValue(uint32_t(100)));
	  Link1.SetDeviceAttribute  ("DataRate", StringValue ("1.5Mbps"));
	  Link1.SetChannelAttribute ("Delay", StringValue ("10ms"));



      Ptr<UniformRandomVariable> uv = CreateObject<UniformRandomVariable> ();
      uv->SetStream (50);
      RateErrorModel error;
      error.SetRandomVariable (uv);
      error.SetUnit (RateErrorModel::ERROR_UNIT_PACKET);
      error.SetRate (errorprob);

      Link1.SetDeviceAttribute ("ReceiveErrorModel", PointerValue (&error));
	  // Leaf node on right , left side of the bottleneck routers
	  PointToPointHelper Link2;
	  Link2.SetQueue("ns3::DropTailQueue");
	  Link2.SetDeviceAttribute    ("DataRate", StringValue ("3Mbps"));
	  Link2.SetChannelAttribute   ("Delay", StringValue ("10ms"));

	  PointToPointDumbbellHelper helper (nLeftLeaf, Link2,
	                                nRightLeaf, Link2,
	                                Link1);
	  InternetStackHelper stack;
	  helper.InstallStack(stack);
	  helper.AssignIpv4Addresses (Ipv4AddressHelper ("10.1.1.0", "255.255.255.0"),
              Ipv4AddressHelper ("10.2.1.0", "255.255.255.0"),
              Ipv4AddressHelper ("10.3.1.0", "255.255.255.0"));

	  Ipv4GlobalRoutingHelper::PopulateRoutingTables ();
	  Address anyAddress,sinkAddress;
	  uint16_t sinkPort = 5000;

	  anyAddress = InetSocketAddress (Ipv4Address::GetAny (), sinkPort);
	  sinkAddress = InetSocketAddress (helper.GetRightIpv4Address(0), sinkPort);

	  std::cout<<"Sink IP Address is ";
	  helper.GetRightIpv4Address(0).Print(std::cout);
	  std::cout<<std::endl;

	  PacketSinkHelper packetSinkHelper ("ns3::TcpSocketFactory", anyAddress);
	  ApplicationContainer sinkApps = packetSinkHelper.Install (helper.GetRight(0));
	  sinkApps.Start (Seconds (0.));
	  sinkApps.Stop (Seconds (10.));

	  Ptr<Socket> ns3TcpSocket = Socket::CreateSocket (helper.GetLeft(0), TcpSocketFactory::GetTypeId ());
	  std::cout<<"Source IP Address is ";
	  helper.GetLeftIpv4Address(0).Print(std::cout);
	  std::cout<<std::endl;
	  AsciiTraceHelper asciiTraceHelper;
  	  Ptr<OutputStreamWrapper> streamCwnd = asciiTraceHelper.CreateFileStream ("cwnd.out");
  	  Ptr<OutputStreamWrapper> streamRtt = asciiTraceHelper.CreateFileStream ("rtt.out");
  	  Ptr<OutputStreamWrapper> streamRto = asciiTraceHelper.CreateFileStream ("rto.out");
  
	  Ptr<TestApp> app = CreateObject<TestApp> ();
	  app->setupTest (ns3TcpSocket, sinkAddress, 2000, 10000, DataRate ("50Mbps"));
	  helper.GetLeft(0)->AddApplication(app);

	  ns3TcpSocket->TraceConnectWithoutContext ("CongestionWindow", MakeBoundCallback (&CwndChange, streamCwnd));
      ns3TcpSocket->TraceConnectWithoutContext ("RTT", MakeBoundCallback (&RttTracer, streamRtt));
      ns3TcpSocket->TraceConnectWithoutContext ("RTO", MakeBoundCallback (&RtoTracer, streamRto));

	  app->SetStartTime (Seconds (0.));
	  app->SetStopTime (Seconds (10.));



	  helper.BoundingBox (1, 1, 100, 100);
	  // Create the animation object and configure for specified output
	  AnimationInterface anim (animFile);
	  anim.EnablePacketMetadata ();


	  Ptr<Object>traceObjClient=helper.GetLeft(1)->GetDevice(0);
	  traceObjClient->TraceConnectWithoutContext("PhyTxBegin",MakeCallback(&SendData));
	  traceObjClient->TraceConnectWithoutContext("PhyTxEnd",MakeCallback(&SendData));
	  traceObjClient->TraceConnectWithoutContext("MacTx",MakeCallback(&SendData));


	  Ptr<Object> traceObjServer = helper.GetRight(1)->GetDevice(0);
	  traceObjServer->TraceConnectWithoutContext("PhyRxBegin",MakeCallback(&ReceiveData));
	  traceObjServer->TraceConnectWithoutContext("PhyRxEnd",MakeCallback(&ReceiveData));
	  traceObjServer->TraceConnectWithoutContext("MacRx",MakeCallback(&ReceiveData));



	  FlowMonitorHelper flowmon;
	  Ptr<FlowMonitor> monitor = flowmon.InstallAll ();


      AsciiTraceHelper ascii;
      Link1.EnableAsciiAll (ascii.CreateFileStream ("1q2.tr"));
  	  Link1.EnablePcapAll ("1q2");



	  Simulator::Stop (Seconds (10));
	  Simulator::Run ();

	  monitor->CheckForLostPackets ();
	  Ptr<Ipv4FlowClassifier> classifier = DynamicCast<Ipv4FlowClassifier> (flowmon.GetClassifier ());
	  std::map<FlowId, FlowMonitor::FlowStats> stats = monitor->GetFlowStats ();
	  for (std::map<FlowId, FlowMonitor::FlowStats>::const_iterator i = stats.begin (); i != stats.end (); ++i)
	   {
	  	 Ipv4FlowClassifier::FiveTuple t = classifier->FindFlow (i->first);
	       if ((t.sourceAddress=="10.1.1.1" && t.destinationAddress == "10.2.1.1"))
	       {
	            
	            std::cout << "Flow is from " << i->first  << " (" << t.sourceAddress << " to " << t.destinationAddress << ")\n";
	            std::cout << "Transmitted bytes   " << i->second.txBytes << "\n";
	            std::cout << "Received bytes   " << i->second.rxBytes << "\n";
	        	std::cout << "  Throughput is " << i->second.rxBytes * 8.0 / (i->second.timeLastRxPacket.GetSeconds() - i->second.timeFirstTxPacket.GetSeconds())/1024/1024  << " Mbps\n";
	        }
	        
	   }
	  Simulator::Destroy ();

	  return 0;
}


