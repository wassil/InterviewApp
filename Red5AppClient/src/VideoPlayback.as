package  {
	import flash.net.NetStream;
	/**
	 * ...
	 * @author wassil
	 */
	public class VideoPlayback {
		public var netStream:NetStream;				
		public function VideoPlayback(streamName:String) {
			netStream = new NetStream(ServerConnector.instance.connection);
			netStream.client = this;
			netStream.play(streamName+".flv");
		}
		
		public function onMetaData(...rest):void {
			trace("metadata");
		};
		
	}

}