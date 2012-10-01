package com.knowledgehorizon.videoplayer.modal{
	
	public class Modal{
		public static const PLAY_STATE:String ="playState";
		public static const PAUSE_STATE:String ="pauseState";
		public static const STOP_STATE:String ="stopState";
		private var VIDEO_STATE:String = "stopState"; // 
		private static var instance:Modal = new Modal();
		public static function getInstance():Modal{
			return instance;
		}
		
		public function setState(setId:String){
			VIDEO_STATE = setId;
			trace("Current VIDEO_STATE = "+VIDEO_STATE);
			
		}
		public function getState():String{
			return VIDEO_STATE;
		}
		
		
		
						
	}
}