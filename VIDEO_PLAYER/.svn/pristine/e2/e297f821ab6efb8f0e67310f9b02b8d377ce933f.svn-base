package com.knowledgehorizon.videoplayer.assets{
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.external.*;
	
	import flash.text.*;
	import com.knowledgehorizon.videoplayer.utility.Utilities;
	public class SubTittle extends MovieClip {
		
		// Assets class and variable 
		private var _drawing:Drawing;
		private var _library:Library;
		private var _storage:Storage;
		private var _logView:LogView;
		private var _initSubTitle:InitSubTitle;
		private var _video:VideoObject;
		private var _subTitle:MovieClip;
		private var _textBg:MovieClip;
		private var _subTitleTxt:MovieClip;
		private var _fontSize:Number = 10;
		private var _arSize:Number = 10;
		private var _showText:String;
		private var ItemHolder:MovieClip;
		private var sw:Number;
		private var sh:Number;
		private var per:Number;
		private var perH:Number;
		
		private static var instance:SubTittle = new SubTittle();
		
		public static function getInstance():SubTittle {
			return instance;
		}

		public function SubTittle() {
			if (instance) {
				throw new Error("Access is denid! Please use SubTitle.getInstance() to access this class.");
			} else {
				_drawing = new Drawing();
				_library = Library.getInstance();
				_storage = Storage.getInstance();
				_logView = LogView.getInstance();
				_initSubTitle = InitSubTitle.getInstance();
				_video = VideoObject.getInstance();
				//_showText = "<b><font size='" + _fontSize + "'> Presented by Sunil Kumar<br> This is video subtitling";
				// constructor code
				this.addChild(createItemHolder());
			}
		}

		private function createItemHolder():MovieClip {
			ItemHolder = _drawing.createHolder();
			ItemHolder.addChild(createSubTitle());
			//ItemHolder.y = 200;
			resetSubTitle();
			return ItemHolder;
		}
		
		private function createSubTitle():MovieClip {
			_subTitle = _drawing.createHolder();
			//_subTitle.addChild(createTextBg());
			_subTitle.addChild(createSubTitleText());
			return _subTitle;
		}

		private function createTextBg():MovieClip {
			_textBg = _drawing.createGraphics(0x000000,100,50);
			_textBg.alpha = 0.5;
			return _textBg;
		}
		private function createSubTitleText():MovieClip {
			_subTitleTxt = _library.createSubTitleText();
			
			//_subTitleTxt.txt.defaultFormat = createTextFormat();
			return _subTitleTxt;
		}
		
		public function subTitleOn():void{
			ItemHolder.visible = true;
		}
		
		public function subTitleOff():void{
			ItemHolder.visible = false;
		}
		
		
		/*
		public function resetSubTitle(str:String=""):void {
			sw = _storage.getStageWidth();
			sh = _storage.getStageHeight();
			cbHeight = _storage.getControlBarHeight();
			updateFontSize();
			_showText = "<b><font size='" +_fontSize + "'>" + Utilities.trim(str)+"</b></font>" ;
			per = Math.round((sw*40)/100); // @ Sunil Kumar --- Dubai dated 05th Dec 2011 
			tlfText.htmlText = _showText;
			tlfText.x = 0;
			tlfText.width =sw-per;
			textBg.width = tlfText.textWidth+10;
			textBg.height = tlfText.height+5;
			textItem.x = Math.round((sw-tlfText.width)/2);
			textItem.y = Math.round((sh-tlfText.height-cbHeight-85));
			textBg.x = Math.round((tlfText.width-textBg.width)/2);
			if(str==""){
				textItem.visible = false;
			}else{
				textItem.visible = true;
			}
		}
*/

private var fmt:TextFormat;
		
		private function createTextFormat():TextFormat{
			fmt = new TextFormat();
			fmt.align = TextFormatAlign.CENTER;
			fmt.font = "Arial";
			fmt.bold = true;
			return fmt;
		}
		public function resetSubTitle(str:String=""):void {
			try {
				sw = _storage.getStageWidth();
				sh = _storage.getStageHeight();
				updateFontSize();
				_showText = "<b><font size='" + _fontSize + "'>" + str;
				//_subTitleTxt.txt.width = _subTitleTxt.txt.textWidth;
				// 3557355  - Indigo head office Dubai
				per = Math.round((sw*40)/100); // @ Sunil Kumar --- Dubai dated 05th Dec 2011 
				_subTitleTxt.txt.htmlText = Utilities.trim(_showText);
				_subTitleTxt.txt.height = _subTitleTxt.txt.textHeight + 10;
				_subTitleTxt.txt.width = sw-per;
				_subTitleTxt.bg.width = _subTitleTxt.txt.width;
				_subTitleTxt.bg.height = _subTitleTxt.txt.textHeight+10;
				_subTitleTxt.x = Math.round((sw-_subTitleTxt.width)/2);
				perH = Math.round((sh*15)/100); // @ Sunil Kumar --- Dubai dated 25th March 2012;
				_subTitleTxt.y = Math.round((sh-_subTitleTxt.height-perH)); //30+85 = 115 
				if(str==""){
				_subTitleTxt.visible = false;
				}else{
					_subTitleTxt.visible = true;
				}
				//textBg.x = Math.round((tlfText.width-textBg.width)/2);
				// ==== @ Sunil Kumar - updated 
				//ItemHolder.y = (_video.getVideoHeight()-_subTitleTxt.height-20);
				
			} catch (error:Error) {
				trace("Error found in Videosubtile reset");
			}
		}
		public function updateFontSize():void {
			var str:String = String(_storage.getCurrLanguage());
			if (str == "AR") {
				updateFontSizeAR();
			} else {
				updateFontSizeEN();
			}
		}


		private function updateFontSizeEN():void {
			if (sw < 300) {
				_fontSize = 10;
				//} //else if (sw>=300 && sw<350) {
				//_fontSize = 11;
			} else if (sw>=300 && sw<400) {
				_fontSize = 12;
			} else if (sw>=400 && sw<450) {
				_fontSize = 13;
			} else if (sw>=450 && sw<500) {
				_fontSize = 14;
			} else if (sw>=500 && sw<550) {
				_fontSize = 16;
			} else if (sw>=550 && sw<600) {
				_fontSize = 18;
			} else if (sw>=600 && sw<650) {
				_fontSize = 20;
			} else if (sw>=650 && sw<700) {
				_fontSize = 22;
			} else if (sw>=700) {
				_fontSize = 25;
			}
		}

		private function updateFontSizeAR():void {
			if (sw < 300) {
				_fontSize = 12;
			} else if (sw>=300 && sw<350) {
				_fontSize = 13;
			} else if (sw>=350 && sw<400) {
				_fontSize = 14;
			} else if (sw>=400 && sw<450) {
				_fontSize = 15;
			} else if (sw>=450 && sw<500) {
				_fontSize = 16;
			} else if (sw>=500 && sw<550) {
				_fontSize = 19;
			} else if (sw>=550 && sw<600) {
				_fontSize = 21;
			} else if (sw>=600 && sw<650) {
				_fontSize = 25;
			} else if (sw>=650 && sw<700) {
				_fontSize = 27;
			} else if (sw>=700) {
				_fontSize = 35;
			}
		}

		// =====================   FUNCTION END HERE ==========================
	}
}