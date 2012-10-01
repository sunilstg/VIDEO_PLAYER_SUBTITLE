package com.knowledgehorizon.videoplayer.external{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	//import com.knowledgehorizon.videoplayer.webservices.InitErrorWebService;
	import com.knowledgehorizon.videoplayer.controller.*;
	
	//ShowError.getInstance()
	public class ShowError extends MovieClip {
		private var _streamController:StreamController;
		private var errorBg:MovieClip;
		private var myText:TextField;
		private var txtFormate:TextFormat;
		private var base:MovieClip;
		private var errorVisible:Boolean = false;
		private var storage:Storage;
		private var drawing:Drawing;
		private var msg:ErrorMessage;
		private var _logView:LogView;
		private var _childControl:ChildControl;
		private var sw:Number;
		private var sh:Number;
		//private var initErrorReport:InitErrorWebService;
		private var errorCode:String
		private var errorMsg:String;
		private var completeMsg:String
		private var _centerButton:CenterButton;

		private static var instance:ShowError =  new ShowError();
		public static function getInstance():ShowError {
			return instance;
		}
		public function ShowError(){
			if(instance){
				throw new Error("Access id denied! Please use ShowError.getInstance() to access this class.");
			}else{
				InitError();
			}
		}
		
		private function createChildControl():void {
			_childControl = ChildControl.getInstance();
			_childControl.clearChildren();
		}
		
		public function InitError() {
			storage = Storage.getInstance();
			drawing = new Drawing();
			base = drawing.createHolder();
			msg = ErrorMessage.getInstance();
			_logView = LogView.getInstance();
			this.addChild(base);
		}
		
		public function resetErrorText(str:String, ErrorCode:String):void {
			// ===== @ Sunil Kumar 
			
			//createChildControl();
			
			// 
			
			errorCode = formatErrorMsg(ErrorCode, 0);
			errorMsg =  formatErrorMsg(ErrorCode, 1);
			
			sw=storage.getStageWidth()
			sh=storage.getStageHeight();
			var switching:Boolean = false; //Setting.getInstance().getIsSwitching();
			if(!switching){
				Preloader.getInstance().deleteChildren();
				errorVisible = true;
				base.addChild(createBg());
				base.addChild(ctext());
				if (sw>445) {
					errorBg.width=445;
				} else {
					errorBg.width=sw;
				}
				if (sh>250) {
					errorBg.height=205;
				} else {
					errorBg.height = (sh);
				}
				myText.width=errorBg.width;
				myText.height=errorBg.height;
				myText.htmlText=str;
				errorBg.height=myText.textHeight+10;
				errorBg.x = (sw-errorBg.width)/2;
				errorBg.y = (sh-errorBg.height)/2;
				myText.x=errorBg.x;
				myText.y=errorBg.y;
				completeMsg = errorMsg+", Product Id = "+storage.getPid()+", Session Id = "+storage.getSid()+", User Id = "+storage.getUid()+", domain = "+storage.getDomain();
				_logView.InsetLogText("<b>:: Error Code: </b>"+ErrorCode);				
				//initErrorReport = new InitErrorWebService(errorCode, completeMsg);
				//trace("CAlling error message"+str)
			}else{
				trace("Not able to load error message")
				LogView.getInstance().InsetLogText("========By pass error message");
			}
		}
		
				
		
		private function formatErrorMsg(str, id:Number):String{
			var tempArr:Array = str.split("_");
				return String(tempArr[id]);
		}
		
		
		public function hideErrorText():void{
			if(errorVisible){
				errorVisible = false;
				base.removeChild(errorBg)
				base.removeChild(myText)
			}
		}
		private function createBg():MovieClip {
			errorBg = new MovieClip();
			errorBg.graphics.beginFill(0x000000);
			errorBg.graphics.drawRect(0,0,445, 205);
			return errorBg;
		}
		private function ctext():TextField {
			myText= new TextField();
			myText.selectable = false;
			myText.wordWrap=true;
			myText.width=errorBg.width;
			myText.height=errorBg.height;
			myText.defaultTextFormat=createFormate();
			return (myText);
		}

		private function createFormate():TextFormat {
			txtFormate = new TextFormat();
			txtFormate.font="Arial";
			txtFormate.size=11;
			txtFormate.align=TextFormatAlign.CENTER;
			txtFormate.color=0xFFFFFF;
			return (txtFormate);
		}




	}
}