package com.knowledgehorizon.videoplayer.assets{
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.controller.*;
	import flash.events.MouseEvent;
	import flash.text.*;
	import fl.transitions.Tween;
	import flash.events.TimerEvent;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.utils.Timer;
	import flash.net.SharedObject;

	public class SubTittleButtons extends MovieClip {
		private var cbLang:MovieClip;
		private var lang:String;
		private var _storage:Storage;
		private var _library:Library;
		private var _logView:LogView;
		private var _drawing:Drawing;
		private var _buttonEvent:ButtonEvents;
		private var _subTitleLoaded:Array;
		private var _subTitle:Array;
		private var _sw:Number;
		private var _sh:Number;
		private var _mask:MovieClip;
		private var _buttonsThumb:MovieClip;
		private var _buttonsBg:MovieClip;
		private var _buttonsBgTop:MovieClip;
		private var _langThumb:MovieClip;
		private var _status:String;
		private var _ypos:Number;
		private var _buttonHolder:MovieClip;
		private var ItemHolder:MovieClip;
		private var testBtn:MovieClip;
		private var _counter:Number = 0;
		private var _mouseOver:Boolean = false;
		private var _updating:Boolean;
		private var _upState:Boolean = false;
		private var _tween:Tween;
		private var _speed:Number = 1;
		private var _mouseTimer:Timer;
		private var _offThumb:MovieClip;
		private var _offAndLang:MovieClip;
		private var _langOnOff:MovieClip;


		private var sharedObj:SharedObject;


		// ===== @ Sunil Kumar updated on 16th Oct. 2011
		private var subTitle:SubTittle;
		private static var instance:SubTittleButtons = new SubTittleButtons();
		public static function getInstance():SubTittleButtons {
			return instance;
		}
		public function SubTittleButtons() {
			if (instance) {
				throw new Error("Access is denied! Please uses SubTittleButtons.getInstance() to access this class");
			} else {
				// Construct code here 
				InitSubTitleButton();
			}
		}
		private function InitSubTitleButton():void {
			sharedObj = SharedObject.getLocal("KHSubtitle","/");
			_storage = Storage.getInstance();
			_library = Library.getInstance();
			_logView = LogView.getInstance();
			_drawing = new Drawing();
			this.addChild(createMainItem());
			//if (_storage.getSubTitleAvailabe()) {
			createItemHolder();
			//}
		}

		private function createMainItem():MovieClip {
			ItemHolder = _drawing.createHolder();
			return ItemHolder;
		}

		private function createItemHolder() {
			//ItemHolder = _drawing.createGraphics(0x000000, 200, 150);
			//ItemHolder = _drawing.createHolder();
			ItemHolder.addChild(createButtonsHolder());
			ItemHolder.addChild(createMask());
			_buttonHolder.mask = _mask;
			_buttonHolder.y = _mask.y + _mask.height;
			//ItemHolder.addChild(createTestBtn());
			resetChildren();

		}

		private function createButtonsHolder():MovieClip {
			_buttonHolder = _drawing.createHolder();
			_buttonHolder.addChild(createLanguageBg());
			_buttonHolder.addChild(createLanguageBgTop());
			//_buttonHolder.addChild(createOffAndLangBtn());
			_buttonHolder.addChild(createThumb(_storage.getSubTitleLoaded()));
			_buttonHolder.cacheAsBitmap = true;
			_mouseTimer = new Timer(500);
			_mouseTimer.addEventListener(TimerEvent.TIMER, updateMouseEvent, false, 0, true);
			childAlignment();
			return _buttonHolder;
		}

		private function updateMouseEvent(event:TimerEvent):void {
			if (! _mouseOver) {
				if (_counter < 5) {
					slideDown();
					_counter = 0;
				} else {
					_counter++;
				}
			}
		}

		private function startTimer():void {
			if (_mouseTimer != null && ! _mouseTimer.running) {
				_mouseTimer.start();
			}
		}

		private function stopTimer():void {
			if (_mouseTimer != null && _mouseTimer.running) {
				_mouseTimer.stop();
			}
		}

		public function isMouseOver():Boolean {
			return _mouseOver;
		}

		public function mouseOverEvent(event:MouseEvent):void {
			var target:Number = Number(event.currentTarget.name);
			if (target >= 0) {
				//_library.BtnOver(event);
			}
			if (! _mouseOver) {
				_mouseOver = true;
				slideUp();
				startTimer();
				//trace("VolumeMouseOver = "+event.target.name);
			} else {
				//trace("Already Over!!!!!!!!!!!");
			}
		}

		public function mouseOutEvent(event:MouseEvent):void {
			var target:Number = Number(event.currentTarget.name);
			if (target >= 0) {
				//_library.BtnOut(event);
			}
			_mouseOver = false;
		}

		private function slideDown():void {
			if (! _updating && _upState) {
				_tween = new Tween(_buttonHolder,"y",Strong.easeOut,0,_mask.height,_speed,true);
				_tween.addEventListener(TweenEvent.MOTION_FINISH, slipDownComplete, false, 0, true);
				_updating = true;
			}
		}

		private function slideUp():void {
			if (! _updating && ! _upState) {
				_tween = new Tween(_buttonHolder,"y",Strong.easeOut,_mask.height,0,_speed,true);
				_tween.addEventListener(TweenEvent.MOTION_FINISH, slipUpComplete, false, 0, true);
				_updating = true;
			}
		}

		private function slipDownComplete(event:TweenEvent):void {
			_updating = false;
			_upState = false;
			_tween.removeEventListener(TweenEvent.MOTION_FINISH, slipDownComplete);
			if (_mouseOver) {
				slideUp();
			}
			stopTimer();
		}
		private function slipUpComplete(event:TweenEvent):void {
			_updating = false;
			_upState = true;
			_tween.removeEventListener(TweenEvent.MOTION_FINISH, slipUpComplete);
		}
		private function createMask():MovieClip {
			_mask = _drawing.createGraphics(0xFF0000,10,20);
			_mask.width = _buttonHolder.width;
			_mask.height = _buttonsBg.height + 2;
			return _mask;
		}

		private function createLanguageBg():MovieClip {
			_buttonsBg = _library.createLanguageBg();
			_buttonsBg.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_buttonsBg.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _buttonsBg;
		}

		private function createLanguageBgTop():MovieClip {
			_buttonsBgTop = _library.createLangBgTop();
			_buttonsBgTop.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_buttonsBgTop.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			_buttonsBgTop.alpha = 0;
			return _buttonsBgTop;
		}
		private function createThumb(statusArr:Array):MovieClip {
			_buttonsThumb = _drawing.createHolder();
			_storage = Storage.getInstance();
			_subTitle = _storage.getSubTitles();
			_ypos = 0;
			// Default button 
			_langOnOff = _library.createLanguageThumb();
			_langOnOff.name = String(i);
			_langOnOff.txt.text = String(_subTitle[i][1]).toUpperCase();
			_langOnOff.txt.mouseEnabled = false;
			//_langThumb.txt.text = String(i);
			_langOnOff.y = _ypos;
			_ypos -=  Math.round(_langOnOff.height + 1);
			_langOnOff.buttonMode = true;
			_langOnOff.addEventListener(MouseEvent.CLICK, toggleSubTitle, false, 0, true);
			_langOnOff.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_langOnOff.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			_buttonsThumb.addChild(_langOnOff);
			if (_storage.getSubTitleAvailabe()) {
				for (var i:int=0; i<statusArr.length; i++) {
					_status = String(statusArr[i]);
					if (_status == "true") {//|| _status == "false"
						_langThumb = _library.createLanguageThumb();
						_langThumb.name = String(i);
						_langThumb.txt.text = String(_subTitle[i][1]).toUpperCase();
						_langThumb.txt.mouseEnabled = false;
						//_langThumb.txt.text = String(i);
						_langThumb.y = _ypos;
						_ypos -=  Math.round(_langThumb.height + 1);
						_langThumb.buttonMode = true;
						_langThumb.addEventListener(MouseEvent.CLICK, langBtnClick, false, 0, true);
						_langThumb.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
						_langThumb.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
						_buttonsThumb.addChild(_langThumb);
					}
				}
				_buttonsThumb.y -=  _langThumb.height;
			} else {
				trace("No Language found!");
			}
			return _buttonsThumb;
		}




		private function toggleSubTitle(event:MouseEvent):void {
			var base:MovieClip = MovieClip(event.currentTarget);
			var txt:String = String(base.txt.text);
			subTitle = SubTittle.getInstance();
			var temp:MovieClip = _storage.getRightButtons();
			cbLang = MovieClip(temp.getChildByName("ccButton"));
			if (txt == "ON") {
				base.txt.text = "OFF";
				lang = _storage.getSubTitles()[int(_storage.getCurrLanguage())][1];
				subTitle.subTitleOn();
				checkCBLang(String(sharedObj.data.langs));
			} else {
				base.txt.text = "ON";
				lang = _storage.getSubTitles()[int(_storage.getCurrLanguage())][1];
				sharedObj.data.langs = cbLang.txt.text;
				checkCBLang("OFF");
				subTitle.subTitleOff();
			}
			var target:Number = Number(event.currentTarget.name);
		}

		private function createOffAndLangBtn():MovieClip {
			_offAndLang = _drawing.createHolder();
			_offAndLang.addChild(createOffButton());
			_buttonsThumb.y = _offAndLang.y - _buttonsThumb.height;
			_offAndLang.addChild(createThumb(_storage.getSubTitleLoaded()));
			return _offAndLang;
		}

		private function createOffButton():MovieClip {
			_offThumb = _library.createLanguageThumb();
			_offThumb.txt.text = "OFF";
			return _offThumb;
		}
		private function checkCBLang(str:String):void {
			var temp:MovieClip = _storage.getRightButtons();
			cbLang = MovieClip(temp.getChildByName("ccButton"));
			cbLang.txt.text = str;
		}
		private function langBtnClick(event:MouseEvent):void {
			subTitle = SubTittle.getInstance();
			_langOnOff.txt.text = "OFF";
			subTitle.subTitleOn();
			_buttonEvent = ButtonEvents.getInstance();
			var target:MovieClip = MovieClip(event.currentTarget);
			_buttonEvent.CCBtnClick(Number(target.name));
			lang = _storage.getSubTitles()[int(target.name)][1];
			checkCBLang(lang.toUpperCase());
		}
		private function childAlignment():void {
			try {
				if (_storage.getSubTitleAvailabe()) {
					_buttonsThumb.x = _buttonsBg.x + 3;
					_buttonsBg.height = _buttonsThumb.height;
					_buttonsBg.y = (_buttonsBgTop.y+_buttonsBgTop.height);
					_buttonsThumb.y=_buttonsThumb.height-(_langThumb.height-3);
				}
			} catch (error:Error) {
				_logView.InsetLogText("<b>OOPS! Error found in childAlignment of SubtitleButtons.</b>");
			}
		}

		public function resetChildren():void {
			_sw = _storage.getStageWidth();
			_sh = _storage.getStageHeight();
			if (_storage.getSubTitleAvailabe()) {
				ItemHolder.x = (_sw-ItemHolder.width-28);
				ItemHolder.y = (_sh-_mask.height-_storage.getControlBarHeight()-2);
			}
		}

		// =====================   FUNCTION END HERE ==========================
	}
}