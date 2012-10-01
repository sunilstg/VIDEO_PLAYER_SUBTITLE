package khcom.dev.videoplayer.events{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.sensors.Accelerometer;

	public class GlobalEvents extends EventDispatcher {

		// Define you all your evetns here including Course player and templetes
		public static const PLAY_CLICK:String = "playClik";
		public static const PAUSE_CLICK:String = "pauseClick";
		
		public static const SUBTITLE_ON:Accelerometer = "subTitleOn";
		public static const SUBTITLE_OFF:Accelerometer = "subTitleOff";
		
		// Singleton pattern of EventDispatcher instance 
		private static var instance:GlobalEvents;
		public static function getInstance():GlobalEvents {
			if (! instance) {
				instance = new GlobalEvents();
			}
			return instance;
		}

		// Constructor of Singlepattern of GlobalEvents 
		public function GlobalEvents() {
			if (instance) {
				throw new Error("Access is denied! Please use GlobalEvents.getInstance() to access this class. ");
			} else {
				trace("Singleton pattern of GlobalEvents.getInstance() has created successfully!");
			}
		}

		//================================================

	}
}