
package com.knowledgehorizon.videoplayer.controller{
	import flash.display.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	import flash.text.TextField;
	import flash.events.MouseEvent;

	public class ControlBar extends MovieClip {
		// Internal varialbes of button
		private var library:Library;
		private var buttonEvents:ButtonEvents;

		private var drawing:Drawing;
		private var storage:Storage;
		private var volumeController:MovieClip;
		private var seekController:MovieClip;
		
		//private var 
		// Internal buttons 
		private var playBtn:MovieClip;
		private var pauseBtn:MovieClip;
		private var fullBtn:MovieClip;
		private var normalBtn:MovieClip;
		private var settingBtn:MovieClip;
		private var ccBtn:MovieClip;
		private var controlBg:MovieClip;
		private var divider:MovieClip;
		
		// Main Itemholder 
		private var ItemHolder:MovieClip;
		private var controlBar:MovieClip;
		private var LeftButtons:MovieClip;
		private var RightButtons:MovieClip;
		private var SeekBar:MovieClip;
		private var elapsedTime:MovieClip;
		private var totalTimes:MovieClip;
		private var dynamicButton:MovieClip;
		private var muteBtn:MovieClip;
		private var volumeBtn:MovieClip;
		private var _mouseMove:MouseMove;
		
		// Constructor 
		public function ControlBar() {
			buttonEvents = ButtonEvents.getInstance();
			//trace("buttonEvents..................................................")
			_mouseMove = MouseMove.getInstance(); 
			library = Library.getInstance();
			drawing = new Drawing();
			storage = Storage.getInstance();
			// constructor code
			this.addChild(createItemHolder());
		}
		// Create main Item holder in which add all other items
		private function createItemHolder():MovieClip {
			ItemHolder = drawing.createHolder();
			ItemHolder.addChild(createControlBar());
			storage = Storage.getInstance();
			storage.setLeftButtons(LeftButtons);
			storage.setRightButtons(RightButtons);
			resetControlBar();
			return ItemHolder;
		}
		// Create main controlber which we can add to main controlbar
		private function createControlBar():MovieClip {
			controlBar = drawing.createHolder();
			controlBar.addChild(createControlBG());
			controlBar.addChild(createLeftButtons());
			controlBar.addChild(createRightButtons());
			controlBar.addChild(createSeekController());
			_mouseMove.setControlBar(controlBar);
			return controlBar;
		}

		private function createSeekController():MovieClip {
			seekController = SeekController.getInstance();
			seekController.x = (LeftButtons.x+LeftButtons.width);
			return seekController;
		}
		private function setSeekWidth():void {
			var totalSpace:Number = (RightButtons.x-(LeftButtons.x+LeftButtons.width));
			storage.setSeekWidth(totalSpace);
		}
		//Create main controlbar bg
		private function createControlBG():MovieClip {
			controlBg = library.createControlBg();
			return controlBg;
		}
		// Create Left button holder 
		private function createLeftButtons():MovieClip {
			LeftButtons = drawing.createHolder();
			createPlayPauseBtn();
			LeftButtons.addChild(createDivider());
			createVolumeMuteBtn();
			LeftButtons.addChild(createDivider());
			LeftButtons.addChild(createElapsedText());
			LeftButtons.addChild(createDivider())
			leftButtonXpos();
			return LeftButtons;
		}
		// CReate play button instance from library and reset the xpos of all buttons 
		private function createPlayBtn():MovieClip {
			playBtn = library.createPlayButton();
			playBtn.addEventListener(MouseEvent.CLICK, buttonEvents.PlayBtnClick, false, 0, true);
			return playBtn;
		}
		// Create pause button from library clss. 
		private function createPauseBtn():MovieClip {
			pauseBtn = library.createPauseButton();
			pauseBtn.addEventListener(MouseEvent.CLICK, buttonEvents.PauseBtnClick, false, 0, true);
			return pauseBtn;
		}
		// Create LeftButtonXpos 
		private function leftButtonXpos():void {
			var xpos:Number = 0;
			for (var i:int = 0; i < LeftButtons.numChildren; i++) {
				var target:MovieClip = MovieClip(LeftButtons.getChildAt(i));
				target.x = Math.round(xpos);
				//trace(target)
				xpos +=  target.width;
			}
			resetLeftButtons();
		}
		private function resetLeftButtons():void {
			LeftButtons.x = 1;
			LeftButtons.y = 1;
		}
		// Check if autostart is tru or not and add buttons accordingly
		private function createPlayPauseBtn():void {
			var auto:Boolean = storage.getAutoStart();
			if (! auto) {
				LeftButtons.addChild(buttonEvents.createPlayBtn());
			} else {
				LeftButtons.addChild(buttonEvents.createPauseBtn());
			}
		}

		// Create RightButtons 
		private function createRightButtons():MovieClip {
			RightButtons = drawing.createHolder();
			RightButtons.addChild(createDivider());
			
			createCCButton();
			RightButtons.addChild(buttonEvents.createFullBtn());
			rightButtonXpos();
			return RightButtons;
		}
		
		
		private function createSettingButton():void{
			var _qualityFile:Array = storage.getQualityFile();
			if (_qualityFile.length > 1) {
				settingBtn = buttonEvents.createSettingButton();
				RightButtons.addChild(settingBtn);
				RightButtons.addChild(createDivider());
			}
		}
		
		// Create subtitle button
		private function createCCButton():void {
			if (storage.getSubTitleAvailabe()){
				RightButtons.addChild( createSubTitleHead());
				ccBtn = buttonEvents.createCCButton();
				ccBtn.y=2
				ccBtn.txt.text = String(storage.getSubTitles()[1][1]).toUpperCase();
				ccBtn.bg.alpha = 0.3
				//RightButtons.addChild(createDivider());
				RightButtons.addChild(ccBtn);
			}else{
				trace(".....**************************")
				trace("SubTitle not abvailable ")
				trace(".....**************************")
			}
		}

		private function createDynamicButton():MovieClip {
			dynamicButton = library.createDynamicButton();
			return dynamicButton;
		}

		// Create RightButtonXpos 
		private function rightButtonXpos():void {
			var xpos:Number = 0;
			for (var i:int = 0; i < RightButtons.numChildren; i++) {
				var target:MovieClip = MovieClip(RightButtons.getChildAt(i));
				target.x = Math.round(xpos);
				xpos +=  target.width;
			}
			resetRigthButton();
		}

		public function resetRigthButton():void {
			RightButtons.x = controlBg.width - RightButtons.width - 1;
			RightButtons.y = 1;
		}
		// Seekbar bar hoder for loading all assets 
		private function createSeekBar():MovieClip {
			SeekBar = drawing.createHolder();
			return SeekBar;
		}
		// CReate controlbar bg main
		private function createControlBg():MovieClip {
			controlBg = library.createControlBg();
			return controlBg;
		}
		//  Create left button divider for left buttons
		private function createDivider():MovieClip {
			divider = library.createDivider();
			return divider;
		}

		// Create elapsed text field using drawing class 
		private function createElapsedText():MovieClip {
			elapsedTime = library.createVideoTime();
			elapsedTime.txt.text = "[ 00:00 / 00:00 ]";
			//elapsedTime.border = true;
			elapsedTime.y = 4;
			storage.setElapsedText(elapsedTime.txt);
			return elapsedTime;
		}
		private function createSubTitleHead():MovieClip {
			totalTimes = library.createVideoTime();
			totalTimes.txt.text = "Subtitles:";
			totalTimes.y = 4;
			totalTimes.txt.width = totalTimes.txt.textWidth+10;
			///storage.setTotalText(totalTimes.txt);
			return totalTimes;
		}

		// Check user interaction on volume button and add buttons accordingly;
		private function createVolumeMuteBtn():void {
			//LeftButtons.addChild(createVolumeBtn());
			var lastY:Number = Number(VolumeController.getInstance().getThumbYpos());
			if (lastY == 51) {
				LeftButtons.addChild(createMuteBtn());
			} else {
				LeftButtons.addChild(createVolumeBtn());
			}
		}
		// Create volume button class. 
		private function createVolumeBtn():MovieClip {
			volumeBtn = buttonEvents.createVolumeBtn();
			return volumeBtn;
		}

		// Create Mute button from library 
		private function createMuteBtn():MovieClip {
			muteBtn = buttonEvents.createMuteBtn();
			return muteBtn;
		}

		public function resetControlBar():void {
			var stageWidth:Number = storage.getStageWidth();
			var stageHeight:Number = storage.getStageHeight();
			controlBg.width = stageWidth;
			resetLeftButtons();
			resetRigthButton();
			setSeekWidth();
			seekController.resetSeekControl();
			ItemHolder.y = Math.round((stageHeight-ItemHolder.height));
		}


	}
}