package com.knowledgehorizon.videoplayer.external{

	public class ErrorMessage {
		
		private var fontTop:Number=24;
		private var fontBottom:Number=14;
		private var weAreSorry:String;
		private var regionMsg:String;
		private var unable:String;
		private var fairuseEN:String;
		private var fairuseAR:String;
		
		
		
		public static const OUTSIDE_DOMAIN:String = "101_User trying to access from out side domain!";
		public static const NET_CONN_ERROR:String = "102_Unable to create NetConnection i.e. Wrong URL calling or disconnect internet"
		public static const NET_STREAM_ERROR:String ="103_Unable to create NetStream!"
		public static const FILE_NOT_FOUND:String = "104_NetStream URL not found!";
		public static const WEBSERVICE_UNABLE_TOCONNECT:String = "105_Either Web Service URL not found or Server shutted down!"
		public static const WEBSERVICE_PARAMS_NOTFOUND:String = "106_Web Service connected successfully but params not match for requesting URL!"
		public static const FAIRUSE_QUOTA:String = "Sorry, you have exceeded the Fair-use quota of 45hrs viewing time per month! ";
				
		
		private static var instance:ErrorMessage;
		public static function getInstance():ErrorMessage {
			if (instance==null) {
				instance = new ErrorMessage();
				instance.InitMessage();
			}
			return instance;
		}
		
		public function InitMessage():void {
			weAreSorry="<font size ='"+String(fontTop)+"'>We are sorry, file not found!</font>\n<font size='"+String(fontBottom)+"' color=\'#484848\'>If you are seeing this error repeatedly then please report it to us by using the </font><a href=''><font size = '"+String(fontBottom)+"' color=\'#FFFFFF\'><b>Contact Us </b></font><font size='"+String(fontBottom)+"' color=\'#484848\'> section.</font>";
			unable="<font size ='"+String(fontTop)+"'>We are sorry, Unable to load video!</font>\n<font size='"+String(fontBottom)+"' color=\'#484848\'>If you are seeing this error repeatedly then please report it to us by using the </font><a href=''><font size = '"+String(fontBottom)+"' color=\'#FFFFFF\'><b>Contact Us </b></font><font size='"+String(fontBottom)+"' color=\'#484848\'> section.</font>";						
			regionMsg = "<font size ='"+String(fontTop)+"'>We are sorry, this video is not available in your region! \n<font size='"+String(fontBottom)+"' color=\'#484848\'>Some videos have distribution rights only in specific regions of the World.";
			//fairuse = "<font size ='"+String(fontTop)+"'>We are Sorry, you have exceeded the Fair-use quota of 45hrs viewing time per month! \n<font size='"+String(fontBottom)+"' color=\'#484848\'>";
			fairuseEN="<font size ='"+String(fontTop-4)+"'>Sorry! You have exceeded the fair-use quota of 45hrs viewing time per month!</font>\n<font size='"+String(fontBottom)+"' color=\'#484848\'>Please &nbsp;</font><a href='javascript:TermsAndConditons()'><font size = '"+String(fontBottom)+"' color=\'#FFFFFF\'>Click here</font><font size='"+String(fontBottom)+"' color=\'#484848\'> for more details.</font>";			
			fairuseAR="<font size ='"+String(fontTop-4)+"'>Sorry! You have exceeded the fair-use quota of 45hrs viewing time per month!</font>\n<font size='"+String(fontBottom)+"' color=\'#484848\'>Please &nbsp;</font><a href='javascript:TermsAndConditons()'><font size = '"+String(fontBottom)+"' color=\'#FFFFFF\'>Click here</font><font size='"+String(fontBottom)+"' color=\'#484848\'> for more details.</font>";			
		}
		
		public function getWeAreMsg():String {
			return (weAreSorry);
		}
		public function getRegionMsg():String{
			return (regionMsg);
		}
		
		public function getUnableMsg():String{
			return (unable);
		}
		public function getFaireUseEN():String{
			return (fairuseEN);
		}
		public function getFaireUseAR():String{
			return (fairuseAR);
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







