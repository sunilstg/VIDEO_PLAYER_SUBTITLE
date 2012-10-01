/*
Project Name :KH Video Player
Developer  :  Sunil Kumar 
Started on   :  June 20, 2011
Completed by :  ---
-------------------------------------
Last modified by     : name of developer 
Last modified logic  : details of logic 
*/

package com.knowledgehorizon.videoplayer.controller{

	import flash.display.*;
	import flash.external.ExternalInterface;
	import flash.events.MouseEvent;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.controller.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.golden.GoldenPoints;

	public class ChildControl extends MovieClip {
		// Internal variables 
		private var logView:LogView;
		private var drawing:Drawing;
		private var storage:Storage;
		private var ItemHolder:MovieClip;
		private var videoObj:VideoObject;
		private var previewImage:PreviewImage;
		private var controlBar:ControlBar;
		private var volumeController:VolumeController;
		private var subTittle:SubTittle;
		private var subTitleButtons:SubTittleButtons;
		private var settingButtons:SettingButtons;
		private var centerBtn:CenterButton;
		private var buffer:Buffering;
		private var bufferStatus:BufferStatus;
		// Testing svn

		// ======================  Create Singleton pattern ======================
		private static var instance:ChildControl = new ChildControl();
		public static function getInstance():ChildControl {
			return instance;
		}

		public function ChildControl() {
			if (instance) {
				throw new Error("Access denied! Please use ChildControl.getInstance() to access this class.");
			} else {
				// constructor code
				InitChildControl();
			}
		}
		// ======================  Init constructor  =============================

		private function InitChildControl():void {
			logView = LogView.getInstance();
			storage = Storage.getInstance();
			drawing =new Drawing();
			this.addChild(createItemHolder());
		}
		private function createItemHolder():MovieClip {
			ItemHolder = drawing.createHolder();
			return ItemHolder;
		}
		public function createChildren():void {
			setControlbarHeight();
			ItemHolder.addChild(createVideoObject());
			ItemHolder.addChild(createPreviewImage());
			ItemHolder.addChild(createSubTitle());
			ItemHolder.addChild(createVolumeController());
			ItemHolder.addChild(createSubTitleButtons());
			ItemHolder.addChild(createSettingButtons());
			ItemHolder.addChild(createControlBar());
			ItemHolder.addChild(createCButton());
			ItemHolder.addChild(createBufferLog());
			ItemHolder.addChild(createBuffering());
			ItemHolder.addChild(createGolden());
			logView.InsetLogText("ChildControl.createChildren() Successfully");
		}
		private var goldenPoints:GoldenPoints;

		private function createGolden():GoldenPoints {
			goldenPoints = GoldenPoints.getIntance();
			return goldenPoints;
		}

		public function clearChildren():void {
			while (ItemHolder.numChildren) {
				ItemHolder.removeChildAt(0);
			}
		}



		private function createBufferLog():BufferStatus {
			bufferStatus = BufferStatus.getInstance();
			return bufferStatus;
		}

		private function setControlbarHeight():void {
			var cb:ControlBg = new ControlBg();
			storage.setControlBarHeight(cb.height);
			trace("Controlbar height = "+storage.getControlBarHeight());
		}

		private function createBuffering():Buffering {
			buffer = Buffering.getInstance();
			return buffer;
		}

		private function createCButton():MovieClip {
			centerBtn = CenterButton.getInstance();
			return centerBtn;
		}

		private function createVolumeController():VolumeController {
			volumeController = VolumeController.getInstance();
			return volumeController;
		}

		private function createSubTitleButtons():SubTittleButtons {
			subTitleButtons = SubTittleButtons.getInstance();
			return subTitleButtons;
		}

		private function createSettingButtons():SettingButtons {
			settingButtons = SettingButtons.getInstance();
			return settingButtons;
		}

		private function createControlBar():ControlBar {
			controlBar = new ControlBar();
			return controlBar;
		}
		public function resetChildren():void {
			controlBar.resetControlBar();
			volumeController.resetVolumeController();
			previewImage.resetPreviewImage();
			videoObj.resetChildren();
			subTittle.resetSubTitle();
			subTitleButtons.resetChildren();
			centerBtn.resetChildren();
			settingButtons.resetChildren();
		}



		private function createVideoObject():VideoObject {
			videoObj = VideoObject.getInstance();
			return videoObj;
		}

		private function createPreviewImage():PreviewImage {
			previewImage = PreviewImage.getInstance();
			return previewImage;
		}



		private function createSubTitle():SubTittle {
			subTittle = SubTittle.getInstance();
			return subTittle;
		}

		public function toggleFullScreen(event:MouseEvent):void {
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
			resetChildren();
		}
		public function NormalScreen():void {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.displayState = StageDisplayState.NORMAL;
			}
			resetChildren();
		}


	}
}