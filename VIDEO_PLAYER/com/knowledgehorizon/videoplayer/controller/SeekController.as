package com.knowledgehorizon.videoplayer.controller{
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.NetStream;

	public class SeekController extends MovieClip {
		// variable and class 
		private var drawing:Drawing;
		private var library:Library;
		// Main variable holders 
		private var ItemHolder:MovieClip;
		private var storage:Storage;
		private var seekBg:MovieClip;
		private var seekThumb:MovieClip;
		private var rect:Rectangle;
		private var seekPassed:MovieClip;
		private var seekButton:MovieClip;
		private var httpProgress:MovieClip;
		private var duration:Number;
		private var seekBarDragging:Boolean = false;
		private var time:Number;
		private var seekVideo:Number = 0;
		private var netStream:NetStream;



		private static var instance:SeekController = new SeekController();
		public static function getInstance():SeekController {
			return instance;
		}

		public function SeekController() {
			if (instance) {
				throw new Error("Access denied! Please use SeekController.getInstance() to access this class.");
			} else {
				// constructor code
				drawing = new Drawing();
				library = Library.getInstance();
				storage = Storage.getInstance();
				this.addChild(createItemHolder());
				this.addChild(createHttpProgress());
				this.addChild(createSeekPassed());
				this.addChild(createSeekButton());
				this.addChild(createSeekThumb());
				VideoCompleted();
				resetSeekControl();
			}
		}

		public function updateSeekController(_netStream:NetStream):void {
			seekBarProgress(_netStream);
		}




		private function seekBarProgress(_netStream:NetStream) {
			duration = storage.getVideoDuration();
			netStream = _netStream;
			time = netStream.time;
			HttpBuffering(netStream);
			if (seekBarDragging) {
				seekVideo  = (((seekThumb.x)*duration)/(seekBg.width-seekThumb.width));
				netStream.seek((seekVideo));
			} else {
				if (Math.round(time) > Math.round(seekVideo)) {
					seekThumb.x =Math.round((time*(seekBg.width-seekThumb.width)*100/100)/duration);
					seekPassed.width = seekThumb.x + 4;
					seekThumb.visible = true;
					seekPassed.visible = true;
					seekButton.mouseEnabled = true;
				}
			}
		}

		private function seekButtonClick(event:MouseEvent):void {
			try {
				var min:Number = seekThumb.width;
				if (ItemHolder.mouseX > min) {
					seekThumb.x = (ItemHolder.mouseX-seekThumb.width);
				} else {
					if (ItemHolder.mouseX < min) {
						seekThumb.x = (ItemHolder.mouseX);
					}
				}
				
				seekVideo = (((seekThumb.x)*duration)/(seekBg.width-seekThumb.width));
				netStream.seek((seekVideo));
				seekPassed.width = seekThumb.x + 4;
			} catch (error:Error) {
				trace("SeekButtonPRessed Error ");
			}
			
		}

		private function createItemHolder():MovieClip {
			ItemHolder = drawing.createHolder();
			ItemHolder.addChild(createSeekBg());
			return ItemHolder;
		}
		private function createSeekPassed():MovieClip {
			seekPassed = drawing.createGraphics(0x515151,5,5);
			return seekPassed;
		}
		private function createHttpProgress():MovieClip {
			httpProgress = drawing.createGraphics(0x3C3C3C,1,5);
			return httpProgress;
		}
		private function createSeekButton():MovieClip {
			seekButton = drawing.createGraphics(0xFF0000,5,5);
			seekButton.buttonMode = true;
			seekButton.addEventListener(MouseEvent.CLICK, seekButtonClick,false, 0, true);
			seekButton.alpha = 0;
			return seekButton;
		}

		private function createSeekBg():MovieClip {
			seekBg = library.createSeekBg();//library.createSeekSlider();
			return seekBg;
		}
		private function createSeekThumb():MovieClip {
			//seekThumb = library.createSeekThumb();
			seekThumb = library.createSeekThumb();
			seekThumb.y = Math.round((28-seekThumb.height)/2);
			seekThumb.addEventListener(MouseEvent.MOUSE_DOWN, startSeek, false, 0, true);
			seekThumb.addEventListener(MouseEvent.MOUSE_UP, stopSeekThumb, false, 0, true);
			//seekThumb.cacheAsBitmap = true;
			return seekThumb;
		}
		public function resetSeekControl():void {
			seekBg.width = storage.getSeekWidth();
			ItemHolder.y = Math.round((28-seekBg.height)/2);// 40 Mannual value has been set because of controlbar height we have that is fix;
			seekPassed.y = Math.round(ItemHolder.y + 1);
			seekButton.x = Math.round(seekBg.x);
			seekButton.y = Math.round(ItemHolder.y + 1);
			httpProgress.x = Math.round(seekBg.x);
			httpProgress.y = Math.round(ItemHolder.y + 1);
			seekButton.width = Math.round(ItemHolder.width);
		}

		private function startSeek(event:MouseEvent):void {
			seekBarDragging = true;
			rect = new Rectangle(seekBg.x,seekThumb.y,seekBg.width - seekThumb.width,0);
			seekThumb.startDrag(false, rect);
			seekPassed.addEventListener(Event.ENTER_FRAME, updateHead, false, 0, true);
		}
		private function updateHead(event:Event):void {
			seekPassed.width = seekThumb.x;
		}
		public function stopSeekThumb(event:MouseEvent):void {
			try{
			seekBarDragging = false;
			seekThumb.stopDrag();
			seekPassed.removeEventListener(Event.ENTER_FRAME, updateHead);
			}catch(error:Error){
				trace("Error occured in SeekController.stopSeekThumb()")
			}
		}


		public function VideoCompleted():void {
			seekThumb.x = 0;
			seekThumb.cacheAsBitmap = true;
			seekThumb.visible = false;
			seekPassed.width = 1;
			seekPassed.visible = false;
			seekVideo = 0;
			seekButton.mouseEnabled = false;
			httpProgress.width = 1;
			

		}
		
		private function HttpBuffering(netStream:NetStream) {
			if(storage.getNetConnectURL()==null) {
				httpProgress.width = (netStream.bytesLoaded/netStream.bytesTotal)*(seekBg.width);
			}
		}




	}
}