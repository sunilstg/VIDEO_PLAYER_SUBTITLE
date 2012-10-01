/*

Project Name :KH Video Player
Developer  :  Sunil Kumar 
Started on   :  June 20, 2011
Completed by :  ---
-------------------------------------
Last modified by     : Name of developer
Last modified logic  : Details of logic

*/

package com.knowledgehorizon.videoplayer.controller{

	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.utility.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import flash.net.NetStream;
	import flash.display.*;
	import com.knowledgehorizon.videoplayer.external.*;

	public class ButtonEvents {
		// Declare variables and class. 
		private var _storage:Storage;
		private var _library:Library;
		private var _modal:Modal;
		private var _volumeController:VolumeController;
		private var _leftButton:MovieClip;
		private var _rightButton:MovieClip;
		private var _baseLeft:MovieClip;
		private var _cplayBtn:MovieClip;
		private var _replayBtn:MovieClip;

		private var _playBtn:MovieClip;
		private var _pauseBtn:MovieClip;
		private var _volumeBtn:MovieClip;
		private var _muteBtn:MovieClip;
		private var _fullBtn:MovieClip;
		private var _settingBtn:MovieClip;
		private var _ccBtn:MovieClip;
		private var _normalBtn:MovieClip;
		private var _netStream:NetStream;
		private var _streamController:StreamController;
		private var _logView:LogView;
		private var _initSubTitle:InitSubTitle;
		private var _centerButton:CenterButton;
		private var _videoObj:VideoObject;
		private var _subTitleButtons:SubTittleButtons;
		private var _settingButtons:SettingButtons;
		private var _videoClick:MovieClip;

		private static var instance:ButtonEvents = new ButtonEvents();
		public static function getInstance():ButtonEvents {
			return instance;
		}

		public function ButtonEvents() {
			if (instance) {
				throw new Error("Access is deined! Please use ButtonEvents.getInstance() to access this class.");
			} else {

				_logView = LogView.getInstance();
				_modal = Modal.getInstance();
				_library = Library.getInstance();
				_streamController = StreamController.getInstance();
				_storage = Storage.getInstance();
				_initSubTitle = InitSubTitle.getInstance();
				_volumeController = VolumeController.getInstance();
				_leftButton = _storage.getLeftButtons();
				_rightButton = _storage.getRightButtons();
				_videoObj = VideoObject.getInstance();
				_subTitleButtons = SubTittleButtons.getInstance();
				_settingButtons = SettingButtons.getInstance();
				createVideoClick();

				_logView.InsetLogText("ButtonEvents.instance()");
			}
		}

		private function createVideoClick():void {
			try {
				_videoClick = _videoObj.getVideoHolder();
				_videoClick.name = "_videoClick";
				//_videoClick.buttonMode = true;
				_videoClick.addEventListener(MouseEvent.CLICK, videoClick, false, 0, true);
			} catch (error:Error) {
				_logView.InsetLogText("OOPS! Error found in ButtonEvents.createVideoClick()");
			}
		}

		private function videoClick(event:MouseEvent):void {
			try {
				if (_modal.getState() == "playState") {
					PauseBtnClick(event);
				} else {
					PlayBtnClick(event);
				}
			} catch (error:Error) {
				trace("Error occured at VideoClick");
				_logView.InsetLogText("OOPS! Error found in ButtonEvents.videoClick()");
			}
		}
		public function PlayBtnClick(event:MouseEvent):void {
			_logView.InsetLogText("Play Button clicked");
			playPauseBtn();
			playButtonReplace();
			_centerButton = CenterButton.getInstance();
			_centerButton.deleteChildren();
			
		}
		public function playButtonReplace():void {
			try {
				_leftButton = _storage.getLeftButtons();
				for (var i:int=0; i<_leftButton.numChildren; i++) {
					var baseTarget:MovieClip = MovieClip(_leftButton.getChildAt(i));
					if (baseTarget.name == "playBtn") {
						Utilities.ReplaceButton(_leftButton, baseTarget, createPauseBtn());
						break;
					}
				}
			} catch (error:Error) {
				trace("Error occured in PlayPauseButton replace");
			}
		}

		public function playPauseBtn():void {
			_logView.InsetLogText("playPauseBtn()")
			if (_modal.getState() == "stopState") {
				_logView.InsetLogText("playPauseBtn() ALERT 1");
				_streamController.StartVideo();
			} else {
				_streamController.ResumeVideo();
				_logView.InsetLogText("playPauseBtn() ALERT 2");
			}
		}

		public function createPlayBtn():MovieClip {
			_playBtn = _library.createPlayButton();
			_playBtn.addEventListener(MouseEvent.CLICK, PlayBtnClick, false, 0, true);
			return _playBtn;
		}

		public function createCPlayBtn():MovieClip {
			_cplayBtn = _library.createCPlayButton();
			_cplayBtn.addEventListener(MouseEvent.CLICK, PlayBtnClick, false, 0, true);
			return _cplayBtn;
		}

		public function createReplayBtn():MovieClip {
			_replayBtn = _library.createReplayButton();
			_replayBtn.addEventListener(MouseEvent.CLICK, PlayBtnClick, false, 0, true);
			return _replayBtn;
		}
		// Create pause button from library clss. 
		public function createPauseBtn():MovieClip {
			_pauseBtn = _library.createPauseButton();
			_pauseBtn.addEventListener(MouseEvent.CLICK, PauseBtnClick, false, 0, true);
			return _pauseBtn;
		}

		public function PauseBtnClick(event:MouseEvent):void {
			trace("Pause Button click")
			pauseButtonReplace();
			_centerButton = CenterButton.getInstance();
			_centerButton.createPlayButton();
			_streamController.PauseVideo();

		}

		public function pauseButtonReplace():void {
			try {
				_leftButton = _storage.getLeftButtons();
				for (var i:int=0; i<_leftButton.numChildren; i++) {
					var baseTarget:MovieClip = MovieClip(_leftButton.getChildAt(i));
					if (baseTarget.name == "pauseBtn") {
						Utilities.ReplaceButton(_leftButton, baseTarget, createPlayBtn());
						break;
					}
				}
			} catch (error:Error) {
				trace("PauseButtonReplace Error ");
			}
		}
		public function FullBtnClick(event:MouseEvent):void {
			ChildControl.getInstance().toggleFullScreen(event);
			fullBtnReplace();
		}
		public function normalScreen():void{
			ChildControl.getInstance().NormalScreen();
			NormalBtnReplace();
		}
		public function NormalBtnClick(event:MouseEvent):void {
			ChildControl.getInstance().toggleFullScreen(event);
			NormalBtnReplace();
		}
		public function fullBtnReplace():void {
			_rightButton = _storage.getRightButtons();
			for (var i:int=0; i<_rightButton.numChildren; i++) {
				var baseTarget:MovieClip = MovieClip(_rightButton.getChildAt(i));
				if (baseTarget.name == "fullBtn") {
					Utilities.ReplaceButton(_rightButton, baseTarget, createNormalBtn());
					break;
				}
			}
		}

		public function replaceBtnFromStage():void {
			_rightButton = _storage.getRightButtons();
			for (var i:int=0; i<_rightButton.numChildren; i++) {
				var baseTarget:MovieClip = MovieClip(_rightButton.getChildAt(i));
				if (baseTarget.name == "normalBtn") {
					Utilities.ReplaceButton(_rightButton, baseTarget, createFullBtn());
					break;
				}
			}
		}

		public function NormalBtnReplace():void {
			_rightButton = _storage.getRightButtons();
			for (var i:int=0; i<_rightButton.numChildren; i++) {
				var baseTarget:MovieClip = MovieClip(_rightButton.getChildAt(i));
				if (baseTarget.name == "normalBtn") {
					Utilities.ReplaceButton(_rightButton, baseTarget, createFullBtn());
					break;
				}
			}
		}



		// =======================  replace Volume and Mute button with event 
		public function VolumeBtnOver(event:MouseEvent):void {
			_volumeController.mouseOverEvent(event);
			_library.BtnOver(event);

		}
		public function VolumeBtnOut(event:MouseEvent):void {
			_volumeController.mouseOutEvent(event);
			_library.BtnOut(event);
		}

		public function VolumeBtnClick(event:MouseEvent):void {
			_volumeController.volumeBtnClicked();
			//volumeSave.data.tempXpos = volumeThumb.x;
			//volumeThumb.x = volXpos;
			//volumeSave.data.currentXpos = volumeThumb.x;
			//updateVolume();
			try {
				volumeBtnReplace();
			} catch (error:Error) {
				trace("Error found in VolumeBtnClick on ButtonEvent");
			}
		}

		public function MuteBtnOver(event:MouseEvent):void {
			_volumeController.mouseOverEvent(event);
			_library.BtnOver(event);
		}
		public function MuteBtnOut(event:MouseEvent):void {
			_volumeController.mouseOutEvent(event);
			_library.BtnOut(event);
		}


		public function MuteBtnClick(event:MouseEvent):void {
			_volumeController.muteBtnClicked();
			//var temp:Number = Number(volumeSave.data.tempXpos);
			//volumeThumb.x = (temp>volXpos)?temp: defaultXpos;
			//updateVolume();
			//volumeSave.data.currentXpos = volumeThumb.x;
			//volumeSave.data.tempXpos = volumeThumb.x;
			try {
				muteBtnReplace();
			} catch (error:Error) {
				trace("Error found in MuteBtnClick on ButtonEvent");
			}
		}

		public function volumeBtnReplace():void {
			_leftButton = _storage.getLeftButtons();
			for (var i:int=0; i<_leftButton.numChildren; i++) {
				var baseTarget:MovieClip = MovieClip(_leftButton.getChildAt(i));
				if (baseTarget.name == "volumeBtn") {
					Utilities.ReplaceButton(_leftButton, baseTarget, createMuteBtn());
					break;
				}
			}
		}

		public function muteBtnReplace():void {
			_leftButton = _storage.getLeftButtons();
			for (var i:int=0; i<_leftButton.numChildren; i++) {
				var baseTarget:MovieClip = MovieClip(_leftButton.getChildAt(i));
				if (baseTarget.name == "muteBtn") {
					Utilities.ReplaceButton(_leftButton, baseTarget, createVolumeBtn());
					break;
				}
			}
		}
		// Create volume button class. 
		public function createVolumeBtn():MovieClip {
			_volumeBtn = _library.createVolumeButton();
			_volumeBtn.addEventListener(MouseEvent.CLICK, VolumeBtnClick, false, 0, true);
			_volumeBtn.addEventListener(MouseEvent.ROLL_OVER, VolumeBtnOver, false, 0, true);
			_volumeBtn.addEventListener(MouseEvent.ROLL_OUT, VolumeBtnOut, false, 0, true);
			return _volumeBtn;
		}

		// Create Mute button from library 
		public function createMuteBtn():MovieClip {
			_muteBtn = _library.createMuteButton();
			_muteBtn.addEventListener(MouseEvent.CLICK, MuteBtnClick, false, 0, true);
			_muteBtn.addEventListener(MouseEvent.ROLL_OVER, MuteBtnOver, false, 0, true);
			_muteBtn.addEventListener(MouseEvent.ROLL_OUT, MuteBtnOut, false, 0, true);
			return _muteBtn;
		}



		// Create Full screen button from library class 
		public function createFullBtn():MovieClip {
			_fullBtn = _library.createFullButton();
			_fullBtn.addEventListener(MouseEvent.CLICK, FullBtnClick, false, 0, true);
			return _fullBtn;
		}
		// Create normal screen button from library class. 
		public function createNormalBtn():MovieClip {
			_normalBtn = _library.createNormalButton();
			_normalBtn.addEventListener(MouseEvent.CLICK, NormalBtnClick, false, 0, true);
			return _normalBtn;
		}
		public function createCCButton():MovieClip {
			_ccBtn = _library.createCCButton();
			
			_ccBtn.addEventListener(MouseEvent.ROLL_OVER, CCButtonOver, false, 0, true);
			_ccBtn.addEventListener(MouseEvent.ROLL_OUT, CCButtonOut, false, 0, true);
			return _ccBtn;
		}
		public function CCButtonOver(event:MouseEvent):void {
			_subTitleButtons.mouseOverEvent(event);
			_library.BtnOver(event);
		}
		public function CCButtonOut(event:MouseEvent):void {
			_subTitleButtons.mouseOutEvent(event);
			_library.BtnOut(event);
		}
		public function CCBtnClick(setId:Number):void {
			_initSubTitle.changeLang(setId);
		}

		public function createSettingButton():MovieClip {
			_settingBtn = _library.createSettingButton();
			_settingBtn.addEventListener(MouseEvent.ROLL_OVER, SettingButtonOver, false, 0, true);
			_settingBtn.addEventListener(MouseEvent.ROLL_OUT, SettingButtonOut, false, 0, true);
			return _settingBtn;
		}


		private function SettingButtonOver(event:MouseEvent):void {
			_settingButtons.mouseOverEvent(event);
			_library.BtnOver(event);
		}
		private function SettingButtonOut(event:MouseEvent):void {
			_settingButtons.mouseOutEvent(event);
			_library.BtnOut(event);
		}












	}

}