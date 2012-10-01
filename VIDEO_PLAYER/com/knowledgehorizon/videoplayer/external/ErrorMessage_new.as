package com.knowledgehorizon.videoplayer.external{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.assets.Drawing;

	//import com.mybigflix.videoplayer.pattern.*;
	//import com.mybigflix.externalassets.*;
	//import com.mybigflix.videoplayer.controller.*;
	
	
	//ErrorMessage.getInstance()
	public class ErrorMessage extends MovieClip {
		private var errorBg:MovieClip;
		private var myText:TextField;
		private var txtFormate:TextFormat;
		private var base:MovieClip;
		private var errorVisible:Boolean = false;
		private var storage:Storage;
		private var drawing:Drawing;
		private var sw:Number;
		private var sh:Number;
		
		
		private static var instance:ErrorMessage =  new ErrorMessage();
		public static function getInstance():ErrorMessage {
			return instance;
		}
		
		public function ErrorMessage(){
			if(instance){
				throw new Error("Access id denied! Please use ErrorMessage.getInstance() to access this class.");
			}else{
				InitError();
			}
		}
		

		public function InitError() {
			
			storage = Storage.getInstance();
			drawing = new Drawing();
			base = drawing.createHolder();
			this.addChild(base);
			
		}
		
		public function resetErrorText(str:String):void {
			sw=storage.getStageWidth()
			sh=storage.getStageHeight();
			var switching:Boolean = false; //Setting.getInstance().getIsSwitching();
			LogView.getInstance().InsetLogText("<b>Showing custom message  = </b>"+str);
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
				//StreamController.getInstance().onNetStreamError();
			}else{
				LogView.getInstance().InsetLogText("========By pass error message");
			}
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