package  {
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;

	/**
	 * ...
	 * @author wassil
	 */
	public class ServerConnector {
		private static const URL:String = "rtmp://127.0.0.1/Red5App";
		
		private static var _instance:ServerConnector;
		public static function get instance():ServerConnector { 
			if (_instance == null)_instance = new ServerConnector; 
			return _instance; 
		}
		
		private var connectedCallback:Function;
		public var connection:NetConnection;
		public function ServerConnector() {
			
		}

		public function connect(callback:Function):void {
			connectedCallback = callback;
			connection = new NetConnection();
			connection.connect(URL);
			connection.addEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
			connection.client = this;
		}
		
		private function onConnectionNetStatus(event:NetStatusEvent):void {
			if (event.info.code == "NetConnection.Connect.Success") {
				trace("Successful Connection");
				connectedCallback();
			} else {
				trace("Unsuccessful Connection");
			}
		}
		
		public function call(command:String, callback:Function, ... rest):void {
			var resultObj:Responder = new Responder(callback);
			connection.call("sayHello", resultObj, rest);
		}
	
		
		//TODO
		public function onBWCheck(... rest):Number { 
			return 0; 
		} 
		public function onBWDone(... rest):void { 
			var p_bw:Number; 
			if (rest.length > 0) p_bw = rest[0]; 
				// your application should do something here 
				// when the bandwidth check is complete 
				trace("bandwidth = " + p_bw + " Kbps."); 
		}  
		
	}

}