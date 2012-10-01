package com.knowledgehorizon.videoplayer.controller{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;



	public class MouseMove {
		private var volumeController:VolumeController;
		private var delay:Number = 20;
		private var updateDelay:Number = 0;
		private var controlBar:MovieClip;
		private var modal:Modal;
		private var myTimer:Timer;
		private var isMouseOver:Boolean;
		private var subTitles:SubTittleButtons;
		private var isMouseOverSub:Boolean;
		private var videoHolder:MovieClip;
		private var videoObj:VideoObject;




		private static var instance:MouseMove = new MouseMove();
		public static function getInstance():MouseMove {
			return instance;
		}
		// Main constructor
		public function MouseMove() {
			if (instance) {
				throw new Error("Access id denied! Please MouseMove.getInstance() to access this class.");
			} else {
				init();
				// Construct your code here......
			}
		}
		
		private function createVideoHolder():void{
			videoObj = VideoObject.getInstance();
			videoHolder = videoObj.getVideoHolder();
			videoHolder.addEventListener(MouseEvent.MOUSE_MOVE, MouseMoveEvent, false, 0, true)
		}


		public function startTimer():void {
			myTimer = new Timer(100);
			myTimer.addEventListener(TimerEvent.TIMER, updateShowHide, false, 0, true);
			myTimer.start();
			createVideoHolder()
		}

		public function updateShowHide(event:TimerEvent):void {
			showHideControlbar();
			if (modal.getState() == "pauseState") {
				resetControlBar();
			}
		}
		public function stopTimer():void {
			if (myTimer.hasEventListener(TimerEvent.TIMER)) {
				myTimer.removeEventListener(TimerEvent.TIMER, updateShowHide);
				videoHolder.removeEventListener(MouseEvent.MOUSE_MOVE, MouseMoveEvent)
			}
			resetControlBar();
		}





		private function init():void {
			modal = Modal.getInstance();
			updateDelay = delay;
		}
		public function setControlBar(setId:MovieClip):void {
			controlBar = setId;
		}
		public function getControlBar():MovieClip {
			return controlBar;
		}
		public function showHideControlbar():void {
			if (modal.getState() == "playState") {
				if (updateDelay > 0) {
					updateDelay--;
				}
				HideControl();
			}
		}
		public function resetControlBar():void {
			updateDelay = delay;
			controlBar.alpha = 1;
		}
		public function MouseMoveEvent(event:MouseEvent):void {
			updateDelay = delay;
			ShowControl();
		}
		private function ShowControl():void {
			if (updateDelay > 0 && controlBar.alpha != 1) {
				controlBar.alpha +=  .5;
			}
		}

		private function HideControl():void {
			//trace("updateDelay = "+updateDelay);
			if (updateDelay < 10) {
				volumeController = VolumeController.getInstance();
				subTitles = SubTittleButtons.getInstance();
				//volumeController.forseSlideDown();
				isMouseOver = volumeController.isMouseOver();
				isMouseOverSub = subTitles.isMouseOver();
			}
			//trace(isMouseOver, "isMouseOverSub = "+isMouseOverSub);
			if (! isMouseOver && ! isMouseOverSub) {
				if (updateDelay < 5 && controlBar.alpha != 0) {
					controlBar.alpha -=  .5;
				}
			}
		}

	}
}