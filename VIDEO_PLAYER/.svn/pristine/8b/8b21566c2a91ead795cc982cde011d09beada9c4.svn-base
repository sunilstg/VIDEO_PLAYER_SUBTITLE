package com.knowledgehorizon.videoplayer.golden{

	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.events.*;
	import flash.utils.Timer;
	import fl.transitions.TweenEvent;
	import flash.display.Loader;
	import flash.net.*;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.external.LogView;

	public class GoldenPoints extends MovieClip {
		private var _goldenXML:GoldenXML;
		private var _logView:LogView;
		private var _point:MovieClip;
		private var _next:MovieClip;
		private var _prev:MovieClip;
		private var _replay:MovieClip;
		private var _storage:Storage;

		private var _baseBg:MovieClip;
		private var _logo:Logo;
		private var _points:Array;
		private var _title:String;
		private var _image:String;
		private var _lang:String;
		private var _tilteTxt:MovieClip;

		private var BaseHolder:MovieClip;
		private var ButtonHolder:MovieClip;
		private var PointsHolder:MovieClip;
		private var ItemHolder:MovieClip;
		private var TitleHolder:MovieClip;
		private var ImageHolder:MovieClip;
		private var LogoHolder:MovieClip;


		private var row:Number = 0;
		private var ypos:Number = 0;
		private var tweenPoint:Tween;
		private var tweenTimer:Timer;
		private var count:Number = 0;
		private var imgLoader:Loader;
		private var targetLoader:Loader;


		// ========== Constructor with Singleton pattern ======================================
		private static var instance:GoldenPoints;
		public static function getIntance():GoldenPoints {
			if (instance == null) {
				instance = new GoldenPoints();
			}
			return instance;
		}

		public function GoldenPoints() {
			if (instance) {
				throw new Error("Access is denied! Please GoldenPoints.getInstance() to access this class. ");
			} else {
				//constructor code;
				this.addChild(createItemHolder());
			}
		}
		// ========== ****** Constructor with Singleton pattern ****** ======================================

		private function createItemHolder():MovieClip {
			ItemHolder = new MovieClip();
			ItemHolder.addChild(createBaseHolder());
			ItemHolder.addChild(createImageHolder());
			ItemHolder.addChild(createTitleHolder());
			ItemHolder.addChild(createPointsHolder());
			ItemHolder.addChild(createButtonHolder());
			ItemHolder.addChild(createLogoHolder());
			return ItemHolder;
		}

		private function createBaseBg():MovieClip {
			_baseBg = new MovieClip();
			_baseBg.graphics.beginFill(0x000000);
			_baseBg.graphics.drawRect(0,0, _storage.getStageWidth(), _storage.getStageHeight());
			return _baseBg;
		}


		public function createPoints():void {
			_storage = Storage.getInstance();
			_logView = LogView.getInstance();
			_goldenXML = GoldenXML.getInstance();
			_points = _goldenXML.getPoints();
			_lang = String(_goldenXML.getLang()).toUpperCase();
			_title = _goldenXML.getTitle();
			_image = _goldenXML.getImage();
			if (_points.length > 0) {
				BaseHolder.addChild(createBaseBg());
				loadImage(_image);
				LoadTitleTxt();
				createBulletText();
				createButtons();
				LogoHolder.addChild(createLogo());
				_next.visible = false;
				_prev.visible = false;
				_replay.visible = false;
			} else {
				_logView.InsetLogText("<b>:: OOPS! Golden XML not loaded successfylly </b>");
			}
		}
		private function createButtonHolder():MovieClip {
			ButtonHolder = new MovieClip();
			return ButtonHolder;
		}
		private function createLogoHolder():MovieClip {
			LogoHolder = new MovieClip();
			return LogoHolder;
		}

		/*if (_lang == "AR") {
		_logo.x = 640 - _logo.width - 25;
		_logo.y = 480 - _logo.height - 5;
		} else {
		_logo.y = 480 - _logo.height - 5;
		_logo.x = 25;
		}*/

		private function createLogo():MovieClip {
			_logo = new Logo();
			if (_lang == "AR") {
				_logo.x = 640 - _logo.width - 25;
				_logo.y = 480 - _logo.height - 5;
			} else {
				_logo.y = 480 - _logo.height - 5;
				_logo.x = 25;
			}
			return _logo;
		}

		private function createNextButton():MovieClip {
			if (_lang == "AR") {
				_next = new NextButtonAR();
			} else {
				_next = new NextButton();
			}

			_next.name = "_next";
			_next.buttonMode = true;
			_next.addEventListener(MouseEvent.CLICK, clickNext, false, 0, true);
			_next.addEventListener(MouseEvent.ROLL_OVER, btnOver, false, 0, true);
			_next.addEventListener(MouseEvent.ROLL_OUT, btnOut, false, 0, true);
			return _next;
		}

		private function createPrevButton():MovieClip {
			if (_lang == "AR") {
				_prev = new PrevButtonAR();
			} else {
				_prev = new PrevButton();
			}
			_prev.name = "_prev";
			_prev.buttonMode = true;
			_prev.addEventListener(MouseEvent.CLICK, clickPrev, false, 0, true);
			_prev.addEventListener(MouseEvent.ROLL_OVER, btnOver, false, 0, true);
			_prev.addEventListener(MouseEvent.ROLL_OUT, btnOut, false, 0, true);
			return _prev;
		}
		private function createReplayButton():MovieClip {
			if (_lang == "AR") {
				_replay = new ReplayButton2AR();
			}else{
				_replay = new ReplayButton2();
			}
			
			_replay.name = "_prev";
			_replay.buttonMode = true;
			_replay.addEventListener(MouseEvent.CLICK, clickReplay, false, 0, true);
			_replay.addEventListener(MouseEvent.ROLL_OVER, btnOver, false, 0, true);
			_replay.addEventListener(MouseEvent.ROLL_OUT, btnOut, false, 0, true);
			return _replay;
		}

		private function btnOver(event:MouseEvent):void {
			var target:MovieClip = MovieClip(event.currentTarget);
			target.over.gotoAndPlay("over");

		}
		private function btnOut(event:MouseEvent):void {
			var target:MovieClip = MovieClip(event.currentTarget);
			target.over.gotoAndPlay("out");
		}

		private function createButtons():void {
			ButtonHolder.addChild(createNextButton());
			ButtonHolder.addChild(createPrevButton());
			ButtonHolder.addChild(createReplayButton());
			resetButtons();
		}
		private function resetButtons():void {
			if (_lang == "AR") {
				_next.x = 25;
				_prev.x = _next.x + _prev.width + 10;
				_replay.x = _prev.x + _replay.width + 10;
			} else {
				_next.x = 640 - _next.width - 25;
				_prev.x = _next.x - _prev.width - 10;
				_replay.x = _prev.x - _replay.width - 8;
			}
			ButtonHolder.y = 480 - ButtonHolder.height - 5;
		}

		private function createTitleHolder():MovieClip {
			TitleHolder = new MovieClip();
			return TitleHolder;
		}

		private function createImageHolder():MovieClip {
			ImageHolder = new MovieClip();
			return ImageHolder;
		}
		private function createPointsHolder():MovieClip {
			PointsHolder = new MovieClip();
			PointsHolder.y = 210;
			PointsHolder.x = Math.round((640-590)/2);
			return PointsHolder;
		}

		private function createBaseHolder():MovieClip {
			BaseHolder = new MovieClip();
			return BaseHolder;
		}

		/*
		if(_lang=="EN" || _lang=="en"){
		_point = new BulletPointEN();
		//_point.myText.direction = "ltr";
		}else{
		_point = new BulletPoint();
		_point.myText.direction = "rtl";
		}
		
		GoldenTitlesEN*/



		private function LoadTitleTxt():void {
			if (_lang == "EN" || _lang == "en") {
				_tilteTxt = new TitlesEN();
				TitleHolder.x = 0;
			} else {
				_tilteTxt = new Titles();
				TitleHolder.x = 640 - _tilteTxt.width;
			}
			TitleHolder.addChild(_tilteTxt);
			TitleHolder.y = Math.round((192-TitleHolder.height)/2);
		}

		private function loadImage(setId:String):void {
			try {
				imgLoader = new Loader();
				adListeners(imgLoader.contentLoaderInfo);
				imgLoader.load(new URLRequest(setId));
			} catch (error:Error) {
				trace("Error Found in loading image");
			}
		}
		private function clickNext(event:MouseEvent):void {
			clearPoints();
			ypos = 0;
			row = 0;
			count++;
			/*trace("--------   ******** -------");
			trace(count, _points.length-1);
			trace("--------   ******** -------");
			*/
			if (count < _points.length) {
				createBulletText();
				_next.visible = false;
				_prev.visible = false;
				_replay.visible = false;
			} else {
				trace("...**********************  Completed......");
			}
		}
		private function clickPrev(event:MouseEvent):void {
			clearPoints();
			ypos = 0;
			trace("lastCount = "+count, row);
			trace(3+row);
			var temp:Number = (3+row>5)? 5 : Number(3+row);
			count -=  temp;
			row = 0;
			if (count >= 0) {
				createBulletText();
				_next.visible = false;
				_prev.visible = false;
				_replay.visible = false;
			} else {
				trace("...Completed......");
			}
		}

		private function clickReplay(event:MouseEvent):void {
			clearPoints();
			ypos = 0;
			//var temp:Number = (3+row>5)? 5 : Number(3+row);
			count = 0;
			row = 0;
			if (count < _points.length) {
				createBulletText();
				_next.visible = false;
				_prev.visible = false;
				_replay.visible = false;
			} else {
				trace("...Completed......");
			}

		}
		private function clearPoints():void {
			while (PointsHolder.numChildren) {
				PointsHolder.removeChildAt(0);
			}
		}



		private function createBulletText():void {
			if (_lang == "EN" || _lang == "en") {
				_point = new BulletPointEN();
				//_point.myText.direction = "ltr";
			} else {
				_point = new BulletPoint();
				_point.myText.direction = "rtl";
			}
			_point.bg.alpha = 0;
			_point.num.anim.txt.text = String(count + 1);
			_point.y = ypos;
			ypos +=  _point.height + 15;
			_point.myText.htmlText = String("<b>" + _points[count] + "</b>");
			_point.myText.height = _point.myText.textHeight + 10;
			_point.myText.y = (_point.bg.height-_point.myText.height)/2;
			PointsHolder.addChild(_point);
			tweenTimer = new Timer(600);
			tweenTimer.addEventListener(TimerEvent.TIMER, updateTimer, false, 0, true);
			tweenTimer.start();
		}

		private function updateTimer(event:TimerEvent):void {
			tweenTimer.stop();
			tweenTimer.removeEventListener(TimerEvent.TIMER, updateTimer, false);
			tweenPoint = new Tween(_point.myText,"alpha",Strong.easeOut,0,1,3,true);
			tweenPoint.addEventListener(TweenEvent.MOTION_FINISH, completed, false, 0, true);
		}
		private function completed(event:TweenEvent):void {
			row++;
			if (row < 3) {
				//trace(count, _points.length);
				trace("-----------------------------------");
				trace(count, _points.length);
				trace("-----------------------------------");
				count++;
				if (count < _points.length) {
					createBulletText();
				} else {
					_next.visible = false;
					if (count > 3) {
						_prev.visible = true;
					}
					_replay.visible = true;
					trace("Reached at End of Array.length");
				}

			} else {
				trace("Current STatus..........."+count, _points.length-1);
				if (count > 3) {
					_prev.visible = true;
					//_replay.visible = true;
				}
				if (count < _points.length - 1) {
					_next.visible = true;
				}
				if (count == _points.length - 1) {
					_replay.visible = true;
				}
			}
		}
		private function loadInit(event:Event):void {
			targetLoader = Loader(event.target.loader);
			targetLoader.width = 640;
			targetLoader.height = 192;
			if (_lang == "EN" || _lang == "en") {
				targetLoader.x = 640 - targetLoader.width;
			}
		}


		private function completeHandler(event:Event):void {
			removeListeners(imgLoader.contentLoaderInfo);
			ImageHolder.addChild(imgLoader);
		}
		private function openHandler(event:Event):void {
			trace("PreviewImage: openHandler: " + event);
		}
		private function progressHandler(event:ProgressEvent):void {
			//trace("PreviewImage: progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("PreviewImage: securityErrorHandler: " + event);
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void {
			if (event.status == 404) {
				trace("PreviewImage: httpStatusHandler: " + event);
				_logView.InsetLogText("Golden Image HTTP Error...."+event);
			}
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			_logView.InsetLogText("Golden Image IOError..."+event.target);
			trace("PreviewImage: ioErrorHandler: " + event);
		}

		//contentLoaderInfo
		private function adListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, loadInit);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		private function removeListeners(dispatcher:IEventDispatcher):void {
			dispatcher.removeEventListener(Event.INIT, loadInit);
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}






	}
}