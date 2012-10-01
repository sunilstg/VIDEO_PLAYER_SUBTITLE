package com.knowledgehorizon.videoplayer.external{

	public class CustomErrorMessage {
		
		private var fontTop:Number=24;
		private var fontBottom:Number=14;
		private var weAreSorry:String;
		private var regionMsg:String;
		//CustomErrorMessage.getInstance().getWeAreMsg();
		private static var instance:CustomErrorMessage;

		public static function getInstance():CustomErrorMessage {
			if (instance==null) {
				instance = new CustomErrorMessage();
				instance.InitMessage();
			}
			return instance;
		}

		public function InitMessage():void {
			weAreSorry="<font size ='"+String(fontTop)+"'>We are sorry, file not found!</font>\n<font size='"+String(fontBottom)+"' color=\'#484848\'>If you are seeing this error repeatedly then please report it to us by using the </font><a href=''><font size = '"+String(fontBottom)+"' color=\'#FFFFFF\'><b>Contact Us </b></font><font size='"+String(fontBottom)+"' color=\'#484848\'> section.</font>";
			regionMsg = "<font size ='"+String(fontTop)+"'>We are sorry, this video is not available in your region! \n<font size='"+String(fontBottom)+"' color=\'#484848\'>Some videos have distribution rights only in specific regions of the World."
		}
		

		public function getWeAreMsg():String {
			return (weAreSorry);
		}
		public function getRegionMsg():String{
			return (regionMsg);
		}



	}

}
/*var e1:String ="We are sorry, something went wrong!";
var e2:String = "If you are seeing this error repeatedly then please report it to us by using the <a href=''><font color=\'#FFFFFF\'><b>Contact Us </b></font> section."
var geo1:String = "We are sorry, this video is not available in your region!";
var geo2:String = "Some videos have distribution rights only in specific regions of the World."
var speed1:String = "At this moment, your connection speed is slower than required for streaming this video. <br>Please try again after some while."
var speed2:String = "If this problem persists please contact your ISP.";
var videoinfoNA:String="Video information not available at this time."
*/







