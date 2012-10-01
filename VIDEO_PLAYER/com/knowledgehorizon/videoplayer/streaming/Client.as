package com.knowledgehorizon.videoplayer.streaming{
	import com.knowledgehorizon.videoplayer.modal.Storage;
	
	
	public class Client {
		private var storage:Storage;
		private var Kbps:Number = 0;
		
		public function Client(){
			storage = Storage.getInstance();
		}
		
		
		
		public function onBWCheck(... rest):Number {
			return 0;
		}
		
		public function onBWDone(... rest):void {
			var p_bw:Number;
			if (rest.length>0) {
				p_bw=rest[0];
			}// your application should do something here 
			// when the bandwidth check is complete 
			var fmt:Number = (p_bw>0)? p_bw:0
			trace("---------Client bandwidth = " + fmt + " Kbps.");
			storage.setBandWidth(fmt)
			//BufferStatus.getInstance().setSpeed(fmt)
			Kbps =  p_bw;
		}
	}

}