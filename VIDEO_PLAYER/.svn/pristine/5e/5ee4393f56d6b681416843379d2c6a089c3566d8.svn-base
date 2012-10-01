package com.knowledgehorizon.videoplayer.controller{
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.external.ExternalInterface;

	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.utility.*;

	import flash.net.NetConnection;
	import flash.media.Video;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.streaming.Setting;
	import com.knowledgehorizon.videoplayer.golden.GoldenPoints;

	

	public class StreamController {
		// Internal variables 
		private var _storage:Storage;
		private var _seekController:SeekController;
		private var _initSubTitle:InitSubTitle;
		private var _subTitle:SubTittle;
		private var _previewImage:PreviewImage;
		private var _preloader:Preloader;
		private var _buttonEvents:ButtonEvents;
		private var _ceterButton:CenterButton;
		private var _showError:ShowError;
		private var _errorMessage:ErrorMessage;
		private var _bufferStatus:BufferStatus;
		private var _mouseMove:MouseMove;
		private var _logView:LogView;
		private var _setting:Setting;
		private var _settingButtons:SettingButtons;
		private var _netStream:NetStream;
		private var _netConnect:NetConnection;
		private var _video:Video;
		private var _clientObj:Object;
		private var _duration:Number;
		private var _viewThrougTimer:Timer;
		private var _timer:Timer;
		private var _time:Number = 100;
		private var _totalTime:TextField;
		private var _elapsedTime:TextField;
		private var _modal:Modal;
		private var _autoStart:Boolean;
		private var sendTime:Number = 0;
		private var goldenPoints:GoldenPoints;
		private var _buttonEvent:ButtonEvents;


		private static var instance:StreamController = new StreamController();
		public static function getInstance():StreamController {
			return instance;
		}

		public function StreamController() {
			if (instance) {
				throw new Error("Access is denied! Please StreamController.getInstance() to access this class.");
			} else {
				
			}
		}
		public function InitVideoController():void {
			try {
				videoAutoStarts();
			} catch (error:Error) {
				_logView.InsetLogText("<b>OOPS! Error occured in StreamController Constructor !</b>");
			}
		}

		private function videoAutoStarts():void {
			_buttonEvent = ButtonEvents.getInstance();
			goldenPoints = GoldenPoints.getIntance();
			_mouseMove = MouseMove.getInstance();
			_storage = Storage.getInstance();
			_logView = LogView.getInstance();
			_showError = ShowError.getInstance();
			_errorMessage = ErrorMessage.getInstance();
			_autoStart = _storage.getAutoStart();
			_initSubTitle = InitSubTitle.getInstance();
			_subTitle = SubTittle.getInstance();
			_previewImage = PreviewImage.getInstance();
			_preloader = Preloader.getInstance();
			_buttonEvents = ButtonEvents.getInstance();
			_ceterButton = CenterButton.getInstance();
			_preloader.deleteChildren();
			_logView.InsetLogText("Starting video plaease wait......")
			if (_autoStart) {
				StartVideo();
				_logView.InsetLogText("Starting video ")
			} else {
				loadInterface();
				_logView.InsetLogText("Video autostart is false ")
			}
			//_buttonEvents.startFullScreen();
			//goldenPoints.createPoints(); // Testing purpose only
		}
		private function loadInterface():void {
			_previewImage.showPreview();
			_ceterButton.createPlayButton();
		}
		
		private function VideoCompleted():void{
			_buttonEvent.normalScreen();
			goldenPoints.createPoints();
			_video.visible = false;
			_modal.setState(Modal.STOP_STATE);
			_buttonEvents.pauseButtonReplace();
			//_timer.removeEventListener(TimerEvent.TIMER, UpdateStream);
			_elapsedTime.text = "00:00";
			_ceterButton.createReplayButton();
			_netStream.close();
			_mouseMove.stopTimer();
			_seekController.VideoCompleted();
		}


		



		public function streamStatus(event:NetStatusEvent):void {
			trace("================== VideoStreaming ===============================");
			trace("StreamController = "+event.info.code);
			_bufferStatus.setNetStateInfo(event.info.code);
			trace("=================================================================");
			switch (event.info.code) {
				case "NetStream.Buffer.Empty" :
					_netStream.bufferTime = 3;
					trace("_netStream.bufferTime = "+_netStream.bufferTime);
					Buffering.getInstance().showBuffering(_netStream);
					break;
				case "NetStream.Buffer.Full" :
					_netStream.bufferTime = 10;
					Buffering.getInstance().hideBuffering();
					break;
				case "NetStream.Play.Transition" :
					_logView.InsetLogText("::<b> NetStream: </b>"+event.info.code);
					break;
				case "NetStream.Play.Start" :
					_logView.InsetLogText(":: Now playing : <b>"+_storage.getNetStreamURL()+"</b>");
					break;
				case "NetStream.Play.StreamNotFound" :
					streamNotFound();
					break;
				case "NetStream.Play.Stop" :
					if (_netConnect.uri == "null") {
						VideoCompleted();
						trace("HTTP video completed succssfully!");
					}
					break;
			}
		}

		public function getPlayStatus(information:Object):void {
			trace("==============================================");
			trace("onPlayStatus  = "+information.code);
			_bufferStatus.setNetStateInfo(information.code);
			_logView.InsetLogText("NetStreamin PlayStatus: "+information.code);
			trace("==============================================");
			switch (information.code) {
				case "NetStream.Play.Complete" :
					VideoCompleted();
					break;
				case "NetStream.Play.TransitionComplete" :
					updateSetting();
					//Storage.getInstance().setStreamSwitch(false);
					break;
			}
		}

		private function updateSetting():void {
			_setting = Setting.getInstance();
			_setting.updateComplete();
			_settingButtons = SettingButtons.getInstance();
			_settingButtons.updateRadio();
		}
		//updateRadio(_numId);


		private function failedSetting():void {
			_setting = Setting.getInstance();
			_setting.updateFailed();
		}

		private function getMetaData(information:Object):void {
			_duration = Number(information.duration);
			_logView.InsetLogText("Video MetaData Duration = "+_duration);
			_storage.setVideoDuration(_duration);
		}

		private function getCuePoint(infoObect:Object):void {
			trace("CuePointSet");
		}

		public function onNetStreamError():void {
			try {
				var video:MovieClip = VideoObject.getInstance().getVideoHolder();
				video.visible = false;
				var controlLeft:MovieClip = _storage.getLeftButtons();
				var controlRight:MovieClip = _storage.getRightButtons();
				controlLeft.mouseChildren = false;
				controlRight.mouseChildren = false;
				_ceterButton.deleteChildren();
				_mouseMove.stopTimer();
			} catch (error:Error) {
				trace("Error Found on NetConnectionSTreamERROR");
			}
		}

		// ===================  SET VIDEO STATE ========================;
		public function StartVideo():void {
			_logView.InsetLogText("StreamController.StartVideo()");
			_bufferStatus = BufferStatus.getInstance();
			_modal = Modal.getInstance();
			_duration = -1;
			_seekController = SeekController.getInstance();
			_video = VideoObject.getInstance().getVideoObj();
			_clientObj = new Object();
			_clientObj.onPlayStatus = getPlayStatus;
			_clientObj.onMetaData = getMetaData;
			_clientObj.onCuePoint = getCuePoint;
			_netConnect = _storage.getNetConnect();
			_netStream = _storage.getNetStream();
			_video.attachNetStream(_netStream);
			_video.smoothing = true;
			_netStream.client = _clientObj;
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, streamStatus, false, 0, true);
			_elapsedTime = _storage.getElapsedText();
			_totalTime = _storage.getTotalText();
			_netStream.play(_storage.getNetStreamURL(), 0, -1, true);
			_timer = new Timer(_time);
			_timer.addEventListener(TimerEvent.TIMER, UpdateStream, false, 0, true);
			_timer.start();
			_modal.setState(Modal.PLAY_STATE);
			_video.visible = true;
			_previewImage.removePreviewImage();
			_ceterButton.deleteChildren();
			_mouseMove.startTimer();
			_logView.InsetLogText("StreamController.StartVideo()_END");

		}
		
		private function UpdateStream(event:TimerEvent):void {
			_elapsedTime.text = "[ "+Utilities.formatTime(_netStream.time) +" / "+Utilities.formatTime(_duration)+" ]";
			//_totalTime.text = Utilities.formatTime(_duration);
			_seekController.updateSeekController(_netStream);
			_subTitle.resetSubTitle(_initSubTitle.getTranscript(_netStream.time));
			
		}
		
		
		public function PauseVideo():void {
			if (_modal.getState() == "playState") {
				_netStream.pause();
				_modal.setState(Modal.PAUSE_STATE);
				//_timer.stop()
			} else {
				trace("**********************  You are already in PauseVideo = "+_modal.getState());
			}
		}
		
		public function ResumeVideo():void {
			if (_modal.getState() != "stopState") {
				_netStream.resume();
				_modal.setState(Modal.PLAY_STATE);
			} else {
				trace("**********************  You are already in StopVideo = "+_modal.getState());
			}
		}
		private function streamNotFound():void {
			if (_duration < 1) {
				_mouseMove.stopTimer();
				_logView.InsetLogText(":: <b>NetStream Error File not Found : </b>"+_storage.getNetStreamURL());
				_showError.resetErrorText(_errorMessage.getWeAreMsg(), ErrorMessage.FILE_NOT_FOUND);
				onNetStreamError();
			} else {
				trace("stream not found ");
				failedSetting();
			}
		}
	}
}