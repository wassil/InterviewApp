package  {
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author wassil
	 */
	public class Recorder extends MovieClip{
		private var streamName:String;
		private var publishURL:String;
		private var serverURL:String;
		
		private var videoStreamer:VideoStreamer;
		private var video:Video;
		private var startButton:MovieClip;
		private var stopButton:MovieClip;
		
		public function Recorder() {
			var params:Object = LoaderInfo(this.root.loaderInfo).parameters;
CONFIG::debug {
			serverURL = "rtmp://127.0.0.1/Red5App";
			streamName = "../videos/test" + new Date().getTime().toString();
			publishURL = "";
}
CONFIG::release {
			serverURL = params.serverURL;
			streamName = params.streamName;
			publishURL = params.publishURL;	
			
}
			video = new Video(300,300);
			addChild(video);

			startButton = new MovieClip();
			startButton.graphics.beginFill(0xFF0000);
			startButton.graphics.lineStyle(2,0x000000);
			startButton.graphics.drawCircle(20,20,20);
			startButton.graphics.beginFill(0x000000);
			startButton.graphics.drawRect(15, 15, 10, 10);
			startButton.addEventListener(MouseEvent.CLICK, onStartRecording);
			startButton.visible = false;
			startButton.x = stage.stageWidth / 2 - startButton.width / 2;
			startButton.y = stage.stageHeight - startButton.height;
			addChild(startButton);
			
			stopButton = new MovieClip();
			stopButton.graphics.beginFill(0xCCCCCC);
			stopButton.graphics.lineStyle(2,0x000000);
			stopButton.graphics.drawCircle(20,20,20);
			stopButton.graphics.beginFill(0x000000);
			stopButton.graphics.drawRect(15, 15, 10, 10);
			stopButton.addEventListener(MouseEvent.CLICK, onStopRecording);
			stopButton.visible = false;
			stopButton.x = stage.stageWidth / 2 - stopButton.width / 2;
			stopButton.y = stage.stageHeight - stopButton.height;
			addChild(stopButton);

			ServerConnector.instance.connect(serverURL, onConnectionSuccess);
		}
		
		private function onConnectionSuccess():void {
			videoStreamer = new VideoStreamer(streamName, streamerReady);
		}
		
		private function streamerReady():void {
			video.attachCamera(videoStreamer.cam);
			startButton.visible = true;
		}

		private function onStartRecording(me:MouseEvent):void {
			startButton.visible = false;
			stopButton.visible = true;
			videoStreamer.startRecording();
		}
		
		private function onStopRecording(me:MouseEvent):void {
			stopButton.visible = false;
			videoStreamer.stopRecording();
			navigateToURL(new URLRequest(unescape(publishURL)),"_self");
		}
		
	}

}