package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	/**
	 * ...
	 * @author wassil
	 */
	public class Main extends Sprite{
		
		private var connection:NetConnection;
		public function Main():void{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			connection = new NetConnection();
			connection.connect("rtmp://127.0.0.1/Red5App");
			connection.addEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
			connection.client = this;
		}
		
		public function onConnectionNetStatus(event:NetStatusEvent):void {
			if (event.info.code == "NetConnection.Connect.Success") {
				trace("Successful Connection");
				onConnectionSuccess();
			} else {
				trace("Unsuccessful Connection");
			}
		}
		
		private function onConnectionSuccess():void {
			var resultObj = new Responder(function(str) {
				trace(str);
			});
			connection.call("sayHello", resultObj,"test");
		}
	
	}

}



















import flash.events.NetStatusEvent;
import flash.events.StatusEvent;
import flash.media.*;
import flash.system.*;
import flash.events.MouseEvent;
import fl.controls.Button;

var mic:Microphone;
var cam:Camera;
var micAllowed:Boolean = false;
var camAllowed:Boolean = false;
var nc:NetConnection = new NetConnection();
var ns:NetStream;

nc.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
nc.connect("rtmp://localhost/customstreamer");

function onNetStatus(e:NetStatusEvent):void
{
switch(e.info.code)
{
case "NetConnection.Connect.Success":
initStream();
attachDevices();
break;
}
}

function onStreamStatus(e:NetStatusEvent):void
{
trace(e.info.code);
}

function initStream()
{
ns = new NetStream(nc);
ns.addEventListener(NetStatusEvent.NET_STATUS,onStreamStatus);
}

function attachDevices():void
{
mic = Microphone.getMicrophone();
cam = Camera.getCamera();
if(mic != null) configureMic();
if(cam != null) configureCam();
}

function configureMic()
{
mic.rate = 22;
mic.gain = 50;
mic.setLoopBack(true);
mic.setUseEchoSuppression(true);
mic.addEventListener(StatusEvent.STATUS, onMicStatus);
}

function configureCam()
{
cam.setLoopback(true);
cam.setMode(176,144,15);
cam.setKeyFrameInterval(5);
cam.setQuality(0,70);
cam.addEventListener(StatusEvent.STATUS, onCamStatus);
vid.attachCamera(cam);
}

function onMicStatus(s:StatusEvent):void
{
switch(s.code)
{
case "Microphone.Unmuted":
micAllowed = true;
break;

case "Microphone.Muted":
micAllowed = false;
break;
}

validateRecorder();
}

function onCamStatus(s:StatusEvent):void
{
switch(s.code)
{
case "Camera.Unmuted":
camAllowed = true;
break;

case "Camera.Muted":
camAllowed = false;
break;
}

validateRecorder();
}

function validateRecorder()
{
if(camAllowed || micAllowed)
{
btnStart.addEventListener(MouseEvent.CLICK,onStart);
btnStop.addEventListener(MouseEvent.CLICK,onStop);
}
}

function onStart(me:MouseEvent):void
{
ns.attachAudio(mic);
ns.attachCamera(cam);
ns.publish("demostream","live");
}

function onStop(me:MouseEvent):void
{
ns.close();
}