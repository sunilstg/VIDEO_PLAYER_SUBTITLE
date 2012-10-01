package com.knowledgehorizon.videoplayer.controller{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.assets.Library;
	import com.knowledgehorizon.videoplayer.external.LogView;
	import com.knowledgehorizon.videoplayer.assets.Drawing;
	import flash.geom.Rectangle;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.media.SoundTransform;
	import flash.net.NetStream;

	public class VolumeController extends MovieClip {
		private var _storage:Storage;
		private var _library:Library;
		private var _logView:LogView;
		private var _drawing:Drawing;
		private var _buttonEvent:ButtonEvents;
		private var _volume:MovieClip;
		private var _volumeBg:MovieClip;
		private var _volumeSlider:MovieClip;
		private var _volumeThumb:MovieClip;
		private var _rect:Rectangle;
		private var _mask:MovieClip;
		private var _sw:Number;
		private var _sh:Number;
		private var _mouseTimer:Timer;
		private var _counter:Number = 0;
		private var _tween:Tween;
		private var _speed:Number = 1;
		private var _upState:Boolean = false;
		private var _updating:Boolean = false;
		private var _mouseOver:Boolean = false;
		private var _volumeSave:SharedObject;
		private var _volumeBtnVisible:Boolean = true;
		private var _lastYpos:Number = 0;
		private var _volYpos:Number = 51;
		private var _videoSound:SoundTransform;
		private var _netStream:NetStream;
		private var _volumPassed:MovieClip;
		private var _mouseMove:MouseMove;
		private var defaultYpos:Number = 30;
		private var ItemHolder:MovieClip;





		// =================== Methods and function ===================
		private static var instance:VolumeController = new VolumeController();
		public static function getInstance():VolumeController {
			return instance;
		}

		public function VolumeController() {
			if (instance) {
				throw new Error("Access is denied! Please use VolumeController.getInstance() to access this class");
			} else {
				// constructor code
				_volumeSave = SharedObject.getLocal("KHVideoVolume");
				InitVolumeController();
				this.addChild(createItemHolder());
				//_buttonEvent = ButtonEvents.getInstance();
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
		
		public function isMouseOver():Boolean{
			return _mouseOver;
		}
		

		public function mouseOverEvent(event:MouseEvent):void {
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
			if (_mouseOver) {
				_mouseOver = false;
			} else {
				//trace("Already down@@@@@@@@@@@@@@@@@");
			}
		}


		private function createItemHolder():MovieClip {
			ItemHolder = _drawing.createHolder();
			ItemHolder.addChild(createVolume());
			ItemHolder.addChild(createMask());
			_volume.mask = _mask;
			_volume.y = Math.round(_mask.y + _mask.height);
			_mouseTimer = new Timer(500);
			_mouseTimer.addEventListener(TimerEvent.TIMER, updateMouseEvent, false, 0, true);
			resetVolumeController();
			volumeUpdate();
			return ItemHolder;
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
		private function createMask():MovieClip {
			_mask = _drawing.createGraphics(0xFF9900,30,65);
			return _mask;
		}
		private function createVolumePassed():MovieClip {
			_volumPassed = _library.createVolumPassed();
			_volumPassed.y =(_volumeSlider.y+_volumeSlider.height);
			_volumPassed.x = _volumeSlider.x+(_volumPassed.width/2)+1;
			return _volumPassed;
		}

		public function resetVolumeController():void {
			_sw = _storage.getStageWidth();
			_sh = _storage.getStageHeight();
			ItemHolder.y = Math.round((_sh-_mask.height-_storage.getControlBarHeight()));
			ItemHolder.x = Math.round(28);
		}

		private function slideDown():void {
			if (! _updating && _upState) {
				_tween = new Tween(_volume,"y",Strong.easeOut,0,_volume.height,_speed,true);
				_tween.addEventListener(TweenEvent.MOTION_FINISH, slipDownComplete, false, 0, true);
				_updating = true;
			}
		}
		private var temp:Boolean = false;


		public function forseSlideDown():void {
			
				slideDown();
		}
		
		

		private function slideUp():void {
			_mouseMove = MouseMove.getInstance();
			if (! _updating && ! _upState && _mouseMove.getControlBar().alpha==1) {
				_tween = new Tween(_volume,"y",Strong.easeOut,_volume.height,0,_speed,true);
				_tween.addEventListener(TweenEvent.MOTION_FINISH, slipUpComplete, false, 0, true);
				_updating = true;
				 temp = true;
			}
		}

		private function slipDownComplete(event:TweenEvent):void {
			_updating = false;
			_upState = false;
			stopTimer();
			_tween.removeEventListener(TweenEvent.MOTION_FINISH, slipDownComplete);
			if (_mouseOver) {
				slideUp();
			}
		}
		private function slipUpComplete(event:TweenEvent):void {
			_updating = false;
			_upState = true;
			_tween.removeEventListener(TweenEvent.MOTION_FINISH, slipUpComplete);
		}

		private function createVolume():MovieClip {
			_volume = _drawing.createHolder();
			_volume.name = "_volume";
			_volume.addChild(createVolumBg());
			_volume.addChild(createSlider());
			_volume.addChild(createVolumePassed());
			_volume.addChild(createVolumeThumb());
			_volume.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_volume.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _volume;
		}

		private function InitVolumeController():void {
			_storage = Storage.getInstance();
			_library = Library.getInstance();
			_logView = LogView.getInstance();
			_drawing = new Drawing();
		}

		private function createVolumBg():MovieClip {
			_volumeBg = _library.createVolumBg();
			_volumeBg.name = "_volumeBg";
			_volumeBg.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_volumeBg.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _volumeBg;
		}
		private function createSlider():MovieClip {
			_volumeSlider = _library.createVolumeSlider();
			_volumeSlider.name = "_volumeSlider";
			_volumeSlider.x =Math.round((_volumeBg.width - _volumeSlider.width)/2);
			_volumeSlider.y = Math.round(_volumeBg.y + 3);
			_volumeSlider.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_volumeSlider.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _volumeSlider;
		}
		private function createVolumeThumb():MovieClip {
			_volumeThumb = _library.createVolumeThumb();
			_volumeThumb.cacheAsBitmap = true;
			_volumeThumb.x = Math.round((_volumeBg.width - _volumeThumb.width)/2);
			_lastYpos = Number(_volumeSave.data.currentXpos);
			_volumeThumb.y = Math.round((_lastYpos>0)? _lastYpos : defaultYpos);
			_volumeThumb.addEventListener(MouseEvent.MOUSE_DOWN, startVol, false, 0, true);
			_volumeThumb.addEventListener(MouseEvent.MOUSE_UP, stopVol, false, 0, true);
			_volumeThumb.addEventListener(MouseEvent.ROLL_OVER, mouseOverEvent, false, 0, true);
			_volumeThumb.addEventListener(MouseEvent.ROLL_OUT, mouseOutEvent, false, 0, true);
			return _volumeThumb;
		}

		private function startVol(event:MouseEvent):void {
			_rect = new Rectangle(Math.round(_volumeThumb.x),Math.round(_volumeSlider.y),0,_volumeSlider.height - _volumeThumb.height);
			_volumeThumb.startDrag(false, _rect);
			_volumeThumb.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		public function stopVol(event:MouseEvent):void {
			_volumeSave.data.currentXpos = Math.round(_volumeThumb.y);
			_volumeThumb.stopDrag();
			_volumeThumb.removeEventListener(Event.ENTER_FRAME, update, false);
		}

		private function update(event:Event):void {
			volumeUpdate();
			try {
				createVolumeBtn(_volumeThumb.y);
				createMuteBtn(_volumeThumb.y);
			} catch (error:Error) {
				trace("Error found in tracking");
			}
		}

		private function volumeUpdate():void {
			var netY:Number = Math.round((_volumeThumb.y - _volumeSlider.y));
			var newVol:Number = 48 - netY;
			_volumPassed.height = newVol;
			var divide:Number = newVol * 1.0 / 48;
			trace("Volume = "+divide, newVol);

			streamVolumeUpdate(divide);

		}

		public function streamVolumeUpdate(intVolume:Number=1):void {
			_netStream = _storage.getNetStream();
			if (_netStream != null) {
				_videoSound = new SoundTransform(intVolume);
				_netStream.soundTransform = _videoSound;
			} else {
				trace("NetStream found null");
			}
		}


		public function volumeBtnClicked():void {
			_volumeSave.data.tempXpos = Math.round(_volumeThumb.y);
			_volumeThumb.y = Math.round(_volYpos);
			_volumeSave.data.currentXpos = Math.round(_volumeThumb.y);
			volumeUpdate();
		}

		public function muteBtnClicked():void {
			var temp:Number = Number(_volumeSave.data.tempXpos);
			_volumeThumb.y = Math.round((temp<=_volYpos)? Math.round(temp): defaultYpos);
			_volumeSave.data.currentXpos = Math.round(_volumeThumb.y);
			_volumeSave.data.tempXpos = Math.round(_volumeThumb.y);
			volumeUpdate();
		}

		public function getThumbYpos():Number {
			var ypos:Number = (_volumeThumb.y>0)? _volumeThumb.y : defaultYpos;
			return ypos;
		}

		private function createVolumeBtn(setId:Number):void {
			if (setId == _volYpos && _volumeBtnVisible) {
				_volumeBtnVisible = false;
				_buttonEvent = ButtonEvents.getInstance();
				_buttonEvent.volumeBtnReplace();
				trace("Creating Mute button button please wait....");
			} else {
				//trace("Mute Button alreadycreated@@@@@@@@@@@@@@@@@");
			}
		}

		private function createMuteBtn(setId:Number):void {
			if (setId < _volYpos && ! _volumeBtnVisible) {
				_volumeBtnVisible = true;
				_buttonEvent = ButtonEvents.getInstance();
				_buttonEvent.muteBtnReplace();
				trace("Creating volume button please wait....");
			} else {
				//trace("Volume Button alreadycreated!!!!!!!!!!!!!!!!!!!!!");
			}
		}




	}
}