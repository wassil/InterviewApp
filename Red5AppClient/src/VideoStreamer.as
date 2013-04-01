package  {
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author wassil
	 */
	public class VideoStreamer {
		public var netStream:NetStream;		
		private var mic:Microphone;
		public var cam:Camera;
		private var micAllowed:Boolean = false;
		private var camAllowed:Boolean = false;
		
		private var readyCallback:Function;
		
		public function VideoStreamer(callback:Function) {
			this.readyCallback = callback;
			initStream();
			attachDevices();
		}
		
		private function initStream():void{
			netStream = new NetStream(ServerConnector.instance.connection);
			netStream.addEventListener(NetStatusEvent.NET_STATUS,onStreamStatus);
		}
			
		private function onStreamStatus(e:NetStatusEvent):void {
			trace(e.info.code);
		}

		private function attachDevices():void {
			mic = Microphone.getMicrophone();
			cam = Camera.getCamera();
			if(mic != null) configureMic();
			if(cam != null) configureCam();
		}

		private function configureMic():void {
			mic.rate = 22;
			mic.gain = 50;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true);
			mic.addEventListener(StatusEvent.STATUS, onMicStatus);
		}

		private function configureCam():void{
			cam.setLoopback(true);
			cam.setMode(800,600,15);
			cam.setKeyFrameInterval(5);
			cam.setQuality(0,70);
			cam.addEventListener(StatusEvent.STATUS, onCamStatus);
		}

		private function onMicStatus(s:StatusEvent):void {
			switch(s.code) {
				case "Microphone.Unmuted":
				micAllowed = true;
				break;
				case "Microphone.Muted":
				micAllowed = false;
				break;
			}
			mic.setLoopBack(false);
			validateRecorder();
		}

		private function onCamStatus(s:StatusEvent):void {
			switch(s.code) {
				case "Camera.Unmuted":
				camAllowed = true;
				break;
				case "Camera.Muted":
				camAllowed = false;
				break;
			}
			validateRecorder();
		}

		private function validateRecorder():void {
			if (camAllowed && micAllowed) {
				readyCallback();
			}
		}

		public function startRecording():void{
			netStream.attachAudio(mic);
			netStream.attachCamera(cam);
			netStream.publish("stream","live");
		}

		public function stopRecording():void{
			netStream.close();
		}
		
	}

}