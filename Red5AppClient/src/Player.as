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
	public class Player extends MovieClip{
		private var streamName:String;
		private var serverURL:String;
		
		private var videoPlayback:VideoPlayback;
		private var video:Video;
		private var startButton:MovieClip;
		private var pauseButton:MovieClip;
		
		public function Player() {
			var params:Object = LoaderInfo(this.root.loaderInfo).parameters;
CONFIG::debug {
			serverURL = "rtmp://127.0.0.1/Red5App";
			streamName = "../videos/1364924614446";
}
CONFIG::release {
			serverURL = params.serverURL;
			streamName = params.streamName;
			
}
			video = new Video(300,300);
			addChild(video);

			startButton = new MovieClip();
			startButton.graphics.beginFill(0xFF0000);
			startButton.graphics.lineStyle(2,0x000000);
			startButton.graphics.drawCircle(20,20,20);
			startButton.graphics.beginFill(0x000000);
			startButton.graphics.drawRect(15, 15, 10, 10);
			startButton.addEventListener(MouseEvent.CLICK, onStartPlaying);
			startButton.visible = false;
			startButton.x = stage.stageWidth / 2 - startButton.width / 2;
			startButton.y = stage.stageHeight - startButton.height;
			addChild(startButton);
			
			pauseButton = new MovieClip();
			pauseButton.graphics.beginFill(0xCCCCCC);
			pauseButton.graphics.lineStyle(2,0x000000);
			pauseButton.graphics.drawCircle(20,20,20);
			pauseButton.graphics.beginFill(0x000000);
			pauseButton.graphics.drawRect(15, 15, 10, 10);
			pauseButton.addEventListener(MouseEvent.CLICK, onPausePlaying);
			pauseButton.visible = false;
			pauseButton.x = stage.stageWidth / 2 - pauseButton.width / 2;
			pauseButton.y = stage.stageHeight - pauseButton.height;
			addChild(pauseButton);

			ServerConnector.instance.connect(serverURL, onConnectionSuccess);
		}
		
		private function onConnectionSuccess():void {
			videoPlayback = new VideoPlayback(streamName);
			video.attachNetStream(videoPlayback.netStream);
			//videoPlayback.netStream.pause();
		}
		
		private function onStartPlaying(me:MouseEvent):void {
			videoPlayback.netStream.resume();
			startButton.visible = false;
			pauseButton.visible = true;
		}
		
		private function onPausePlaying(me:MouseEvent):void {
			videoPlayback.netStream.pause();
			startButton.visible = true;
			pauseButton.visible = false;
		}

		
	}
}