	/*
	 
	Project Name :KH Video Player
	Developer  :  Sunil Kumar 
	Started on   :  June 20, 2011
	Completed by :  ---
	-------------------------------------
	Last modified by     : name of developer 
	Last modified logic  : details of logic 
	*/
	
	package com.knowledgehorizon.videoplayer.assets{
		import flash.display.MovieClip;
		import flash.events.MouseEvent;
		import com.knowledgehorizon.videoplayer.controller.*;
		
		public class Library{
			///private var buttonEvents:ButtonEvents;
			private var preloader:CirclePreloader;
			private var playBtn:PlayButton;
			private var cplayBtn:CPlayButton;
			private var replayBtn:ReplayButton;
			private var pauseBtn:PauseButton;
			private var volumeBgVertical:VolumeBGVertical;
			private var volumeSliderVertical:VolumeSliderVertical;
			private var volumeThumb:VolumeThumb;
			private var volumeBtn:VolumeButton;
			private var volumePassed:VolumePassed;
			private var muteBtn:MuteButton;
			private var fullBtn:FullButton;
			private var normalBtn:NormalButton;
			private var controlBg:ControlBg;
			private var divider:Divider;
			private var seekBg:SeekBg;
			private var languageThumb:LanguageThumb;
			private var languageBg:LanguageBg;
			private var languageBgTop:LanguageBgTop;
			
			// Setting button and window
			private var settingBtn:SettingButton;
			private var radioButton:RadioButton;
			
			
			//private var volumeThumb:VolumeThumb;
			private var seekSliderBg:SeekSliderBg;
			private var seekThumb:SeekThumb;
			private var dynamicBtn:DynamicButton;
			private var videoTime:VideoTime;
			private var ccButton:CCButton;
			private var subTitleText:SubTitleText;
			// Create constructor 
			private static var instance:Library = new Library();
			public static function getInstance():Library {
				return instance;
			}
	
			public function Library() {
				if (instance) {
					throw new Error("Access is denied! Please use Library.getInstance() to access this class. ");
				} else {
					// Init Constructor 
				}
			}
			// Create preloader 
			public function createPreloader():CirclePreloader {
				preloader = new CirclePreloader();
				preloader.name = "preloader";
				return preloader;
			}
			// Create Controlbar bg
			public function createControlBg():ControlBg {
				controlBg = new ControlBg();
				controlBg.cacheAsBitmap = true;
				return controlBg;
			}
			// Create divider of controlbar for button
			public function createDivider():Divider {
				divider = new Divider();
				divider.cacheAsBitmap = true;
				return divider;
			}
			// Create play button with all evetns 
			public function createPlayButton():PlayButton {
				playBtn = new PlayButton();
				playBtn.name = "playBtn";
				playBtn.buttonMode = true;
				playBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				playBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				//playBtn.addEventListener(MouseEvent.CLICK, PlayBtnClick, false, 0, true);
				playBtn.cacheAsBitmap = true;
				return playBtn;
			}
	
			// Create pause button with all events 
			public function createPauseButton():PauseButton {
				pauseBtn= new PauseButton();
				pauseBtn.name = "pauseBtn";
				pauseBtn.buttonMode = true;
				pauseBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				pauseBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				//pauseBtn.addEventListener(MouseEvent.CLICK, PauseBtnClick, false, 0, true);
				pauseBtn.cacheAsBitmap = true;
				return pauseBtn;
			}
			// Create Volume Button with all evetns 
			public function createVolumeButton():VolumeButton {
				volumeBtn = new VolumeButton();
				volumeBtn.name = "volumeBtn";
				volumeBtn.buttonMode = true;
				volumeBtn.cacheAsBitmap = true;
				return volumeBtn;
			}
	
			// Create Mute button with all evetns 
			public function createMuteButton():MuteButton {
				muteBtn = new MuteButton();
				muteBtn.name = "muteBtn";
				muteBtn.buttonMode = true;
				muteBtn.cacheAsBitmap = true;
				return muteBtn;
	
			}
			// Create full screen button with all evetns 
			public function createFullButton():FullButton {
				fullBtn = new FullButton();
				fullBtn.name = "fullBtn";
				fullBtn.buttonMode = true;
				fullBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				fullBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				//fullBtn.addEventListener(MouseEvent.CLICK, FullBtnClick, false, 0, true);
				fullBtn.cacheAsBitmap = true;
				return fullBtn;
	
			}
			// Create normal screen button
			public function createNormalButton():NormalButton {
				normalBtn = new NormalButton();
				normalBtn.name = "normalBtn";
				normalBtn.buttonMode = true;
				normalBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				normalBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				//normalBtn.addEventListener(MouseEvent.CLICK, NormalBtnClick, false, 0, true);
				normalBtn.cacheAsBitmap = true;
				return normalBtn;
			}
			
			// Create Seek slider  bg
			public function createSeekBg():SeekBg {
				seekBg = new SeekBg();
				seekBg.cacheAsBitmap = true;
				return seekBg;
			}
			
			public function createVolumBg():VolumeBGVertical{
				volumeBgVertical = new VolumeBGVertical();
				return volumeBgVertical;
			}
			public function createVolumeSlider():VolumeSliderVertical{
				volumeSliderVertical = new VolumeSliderVertical()
				return volumeSliderVertical;
			}
			
			public function createVolumeThumb():VolumeThumb{
				volumeThumb = new VolumeThumb();
				volumeThumb.name = "volumeThumb";
				volumeThumb.buttonMode = true;
				volumeThumb.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				volumeThumb.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				volumeThumb.cacheAsBitmap = true;
				return volumeThumb;
			}
			
			public function createVolumPassed():VolumePassed{
				volumePassed = new VolumePassed();
				return volumePassed;
			}
			// Create Seek bar slider 
			public function createSeekSlider():SeekSliderBg {
				seekSliderBg = new SeekSliderBg();
				seekSliderBg.cacheAsBitmap = true;
				return seekSliderBg;
			}
	
			public function createSeekThumb():SeekThumb {
				seekThumb = new SeekThumb();
				seekThumb.name = "seekThumb";
				seekThumb.buttonMode = true;
				seekThumb.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				seekThumb.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				seekThumb.cacheAsBitmap = true;
				return seekThumb;
			}
			
			public function createCCButton():CCButton{
				ccButton = new CCButton();
				ccButton.name = "ccButton";
				ccButton.buttonMode = true;
				//ccButton.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				//ccButton.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				ccButton.cacheAsBitmap = true;
				return ccButton;
			}
			
			// ================ Create setting button =====================
			public function createSettingButton():SettingButton{
				settingBtn =new SettingButton();
				settingBtn.name = "settingBtn";
				settingBtn.buttonMode = true;
				//settingBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				//settingBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				settingBtn.cacheAsBitmap = true;
				return settingBtn;
			}
			
			
			public function createRadioButton():RadioButton{
				radioButton = new RadioButton();
				radioButton.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				radioButton.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				return radioButton;
			}
			
			private var settingBg:SettingBg;
			private var settingBgTop:SettingBgTop;
			
			public function createSettingBg():SettingBg{
				settingBg = new SettingBg();
				return settingBg;
			}
			
			public function createSettingBtnTop():SettingBgTop{
				settingBgTop = new SettingBgTop();
				return settingBgTop;
			}
			
			
			
			public function createLanguageThumb():LanguageThumb{
				languageThumb = new LanguageThumb();
				languageThumb.buttonMode = true;
				return languageThumb;
			}
			
			public function createLanguageBg():LanguageBg{
				languageBg = new LanguageBg();
				return languageBg;
			}
			public function createLangBgTop():LanguageBgTop{
				languageBgTop = new LanguageBgTop();
				return languageBgTop;
			}
			public function createSubTitleText():SubTitleText{
				subTitleText = new SubTitleText();
				return subTitleText;
			}
	
			public function createDynamicButton():DynamicButton {
				dynamicBtn = new DynamicButton();
				return dynamicBtn;
			}
			public function createVideoTime():VideoTime {
				videoTime = new VideoTime();
				return videoTime;
			}
			// Create center play and replay button
			public function createCPlayButton():CPlayButton{
				cplayBtn =new CPlayButton();
				cplayBtn.name = "cplayBtn";
				cplayBtn.buttonMode = true;
				cplayBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				cplayBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				cplayBtn.cacheAsBitmap = true;
				return cplayBtn;
			}
			
			public function createReplayButton():ReplayButton{
				replayBtn = new ReplayButton();
				replayBtn.name = "replayBtn";
				replayBtn.buttonMode = true;
				replayBtn.addEventListener(MouseEvent.ROLL_OVER, BtnOver, false, 0, true);
				replayBtn.addEventListener(MouseEvent.ROLL_OUT, BtnOut, false, 0, true);
				replayBtn.cacheAsBitmap = true;
				return replayBtn;
			}
			
			public function BtnOver(event:MouseEvent):void {
				var mc:MovieClip = MovieClip(event.target);
				mc.over.gotoAndPlay("over");
			}
	
			public function BtnOut(event:MouseEvent):void {
				var mc:MovieClip = MovieClip(event.target);
				mc.over.gotoAndPlay("out");
			}
			
			
	
		}
	}