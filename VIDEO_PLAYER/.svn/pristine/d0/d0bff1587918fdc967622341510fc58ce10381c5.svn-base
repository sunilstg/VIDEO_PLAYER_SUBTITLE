package com.knowledgehorizon.videoplayer.assets{
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.controller.*;
	import com.knowledgehorizon.videoplayer.streaming.*;
	
	import flash.events.MouseEvent;
	import flash.text.*;
	import fl.transitions.Tween;
	import flash.events.TimerEvent;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.utils.Timer;

	public class SettingButtons extends MovieClip {
		private var _storage:Storage;
		private var _library:Library;
		private var _logView:LogView;
		private var _drawing:Drawing;
		private var _setting:Setting;
		private var _sw:Number;
		private var _sh:Number;
		private var _mask:MovieClip;
		private var _counter:Number = 0;
		private var _mouseOver:Boolean = false;
		private var _updating:Boolean;
		private var _upState:Boolean = false;
		private var _tweenSetting:Tween;
		private var _speed:Number = 1;
		private var _mouseTimer:Timer;
		private var _buttonHolder:MovieClip;
		private var _settingBg:MovieClip;
		private var _settingBgTop:MovieClip;
		private var _radio:MovieClip;
		private var _radioHolder:MovieClip;
		private var _radioHeight:Number;
		private var _ypos:Number = 0;
		private var _qualityFile:Array;
		private var _getQuality:Array;
		private var _numId:Number;
		private var ItemHolder:MovieClip;

		private static var instance:SettingButtons = new SettingButtons();
		public static function getInstance():SettingButtons {
			return instance;
		}
		public function SettingButtons() {
			if (instance) {
				throw new Error("Access is denied! Please uses SettingButtons.getInstance() to access this class");
			} else {
				// Construct code here 
				InitSubTitleButton();
			}
		}
		private function InitSubTitleButton():void {
			_storage = Storage.getInstance();
			_qualityFile = _storage.getQualityFile();
			if (_qualityFile.length > 1) {
				_library = Library.getInstance();
				_logView = LogView.getInstance();
				_drawing = new Drawing();
				this.addChild(createItemHolder());
				resetChildren();
			}
		}
		private function createItemHolder():MovieClip {
			ItemHolder = _drawing.createHolder();
			ItemHolder.addChild(createButtonsHolder());
			ItemHolder.addChild(createMask(_buttonHolder.width, _buttonHolder.height));
			_mouseTimer = new Timer(500);
			_mouseTimer.addEventListener(TimerEvent.TIMER, updateMouseEvent, false, 0, true);
			return ItemHolder;
		}
		
		private function createMask(Width:Number, Height:Number):MovieClip {
			_mask = _drawing.createGraphics(0xFF0000,Width,Height);
			_mask.x = _buttonHolder.x;
			_mask.y = _buttonHolder.y;
			_buttonHolder.mask = _mask;
			_buttonHolder.y = _mask.height;
			return _mask;
		}
		
		


		// ============================ Animation ==================================================
		private function updateMouseEvent(event:TimerEvent):void {
			//trace("***********************************************updateMouseEvent = "+_counter);
			if (! _mouseOver) {
				if (_counter < 5) {
					slideDown();
					//trace("Sliding down*************************")
					_counter = 0;
				} else {
					_counter++;
				}
			} else {
				//trace("OUT OF SINK Sliding down*************************")
			}
		}



		public function mouseOverEvent(event:MouseEvent):void {
			var target:Number = Number(event.currentTarget.name);
			if (target >= 0) {
				_library.BtnOver(event);
			}
			if (! _mouseOver) {
				_mouseOver = true;
				slideUp();
				startTimer();
			} else {
				//trace("Already Over!!!!!!!!!!!");
			}
		}

		public function mouseOutEvent(event:MouseEvent):void {
			var target:Number = Number(event.currentTarget.name);
			if (target >= 0) {
				_library.BtnOut(event);
			}
			_mouseOver = false;
			//trace("MouseOutEVetn target name = "+target, "_mouseOver = "+_mouseOver);
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

		private function slideDown():void {
			if (! _updating && _upState) {
				_tweenSetting = new Tween(_buttonHolder,"y",Strong.easeOut,0,_mask.height,_speed,true);
				_tweenSetting.addEventListener(TweenEvent.MOTION_FINISH, slipDownComplete, false, 0, true);
				_updating = true;
			}
		}

		private function slideUp():void {
			if (! _updating && ! _upState) {
				_tweenSetting = new Tween(_buttonHolder,"y",Strong.easeOut,_mask.height,0,_speed,true);
				_tweenSetting.addEventListener(TweenEvent.MOTION_FINISH, slipUpComplete, false, 0, true);
				_updating = true;
			}
		}

		private function slipDownComplete(event:TweenEvent):void {
			_updating = false;
			_upState = false;
			_tweenSetting.removeEventListener(TweenEvent.MOTION_FINISH, slipDownComplete);
			if (_mouseOver) {
				slideUp();
			}
			stopTimer();
		}
		private function slipUpComplete(event:TweenEvent):void {
			_updating = false;
			_upState = true;
			_tweenSetting.removeEventListener(TweenEvent.MOTION_FINISH, slipUpComplete);
		}
		// ============================ End HEre  ==================================================;

		private function createButtonsHolder():MovieClip {
			_buttonHolder = _drawing.createHolder();
			_buttonHolder.addChild(createSettingBgTop());
			_buttonHolder.addChild(createSettingBg());
			_buttonHolder.addChild(createRadioButton());
			childReset();

			return _buttonHolder;
		}
		
		
		private var _getDefault:Number;
		
		public function updateRadio():void{
			_getQuality = _storage.getQualityFile();
			for (var i:int=0; i<_getQuality.length; i++) {
				var _radio:MovieClip = MovieClip(_radioHolder.getChildAt(i));
				if(i==_numId){
					_radio.btn.bulb.visible = true;
				}else{
					_radio.btn.bulb.visible = false;
				}
			}
		}
		
		private function settingClick(event:MouseEvent):void{
			_setting = Setting.getInstance();
			_numId = Number(event.currentTarget.name);
			_setting.dynamicStream(_numId);
		}
		
		
		private function createRadioButton():MovieClip {
			_radioHolder = _drawing.createHolder();
			_getQuality = _storage.getQualityFile();
			_getDefault = _storage.getCurrentVideoId();
			_numId = _getDefault;
			for (var i:int=0; i<_getQuality.length; i++) {
				_radio = _library.createRadioButton();
				_radio.buttonMode = true;
				_radio.name = String(i);
				_radio.txt.text = String(formatText(String(_getQuality[i][0])));
				_radio.x = 1;
				_radio.y = _ypos;
				_ypos -=  _radio.height;
				_radio.addEventListener(MouseEvent.CLICK, settingClick, false, 0, true);
				_radio.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
				_radio.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
				_radioHolder.addChild(_radio);
			}
			updateRadio();
			_radioHeight = _radioHolder.height;
			return _radioHolder;
		}
		
		private function formatText(setId:String):String{
			var id:String = "";
			if(setId.length>3 && setId!="High"){
				id = setId.substr(0,3);
			}else{
				id = setId;
			}
			return id;
		}
		
		
		private function createSettingBg():MovieClip {
			_settingBg = _library.createSettingBg();
			_settingBg.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_settingBg.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _settingBg;
		}

		private function createSettingBgTop():MovieClip {
			_settingBgTop = _library.createSettingBtnTop();
			return _settingBgTop;
		}

		private function childReset():void {
			_sw = _storage.getStageWidth();
			_sh = _storage.getStageHeight();
			_settingBg.height = _radioHeight;
			_settingBg.y = _settingBgTop.y + _settingBgTop.height;
			_radioHolder.y = _settingBg.height - _radio.height;
		}

		public function resetChildren():void {
			_sw = _storage.getStageWidth();
			_sh = _storage.getStageHeight();
			_qualityFile = _storage.getQualityFile();
			if (_qualityFile.length > 1) {
				if (_storage.getSubTitleAvailabe()) {
					ItemHolder.x = (_sw-_mask.width-48);
				} else {
					ItemHolder.x = (_sw-_mask.width-19);
				}
				ItemHolder.y = (_sh-_mask.height-_storage.getControlBarHeight());

			}
		}
		// =====================   FUNCTION END HERE ==========================
	}
}