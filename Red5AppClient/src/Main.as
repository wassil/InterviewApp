package {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	
	/**
	 * ...
	 * @author wassil
	 */
	public class Main extends Sprite{
		private var videoStreamer:VideoStreamer;
		private var video:Video;
		private var startButton:MovieClip;
		private var stopButton:MovieClip;
		public function Main():void{
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			video = new Video();
			addChild(video);

			startButton = new MovieClip();
			startButton.graphics.beginFill(0x00FF00);
			startButton.graphics.drawRect(0, 0, 40, 40);
			startButton.addEventListener(MouseEvent.CLICK, onStartRecording);
			startButton.visible = false;
			addChild(startButton);
			
			stopButton = new MovieClip();
			stopButton.graphics.beginFill(0xFF0000);
			stopButton.graphics.drawRect(0, 0, 40, 40);
			stopButton.addEventListener(MouseEvent.CLICK, onStopRecording);
			stopButton.visible = false;
			addChild(stopButton);

			ServerConnector.instance.connect(onConnectionSuccess);
		}
		
		
		private function onConnectionSuccess():void {
			ServerConnector.instance.call("sayHello", helloHandler, "test");
			videoStreamer = new VideoStreamer(streamerReady);
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
		}
		
		private function helloHandler(str:String):void {
			trace(str);
		}
		
	}

}