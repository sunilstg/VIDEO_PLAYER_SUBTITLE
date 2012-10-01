package com.knowledgehorizon.videoplayer.flashvars{
	import flash.external.ExternalInterface;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.external.LogView;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.streaming.*;
	//import com.knowledgehorizon.videoplayer.webservices.*;
	import com.knowledgehorizon.videoplayer.utility.*;
	import com.knowledgehorizon.videoplayer.external.ShowError;
	import com.knowledgehorizon.videoplayer.external.ErrorMessage;
	import com.knowledgehorizon.videoplayer.introvideo.*;
	import com.knowledgehorizon.videoplayer.golden.GoldenXML;
	

	public class FlashVars {
		private var _introVideoAvailable:Boolean = false;
		private var _introVideoUrl:String = "Video launcher.flv";
		private var _file:String ="";//"Complaint_high.flv";
		private var _image:String ="";// "images/previewVideo.jpg";// previewVideo.jpg
		private var _defaultVideo:Number = 0;
		private var _title:String = "";
		private var _autostart:Boolean = false;
		private var _subTitles:String = "0, off,images/off.txt | 1, ar,images/1_AR.txt |2, en, images/1_EN.txt";
		private var _storage:Storage;
		private var _logView:LogView;
		private var _netConn:NetConnect;
		private var _initSubTitle:InitSubTitle;
		private var _showError:ShowError;
		private var _errorMessage:ErrorMessage;
		private var statusArr:Array;
		private var _goldenXML:String ="";//"7star.xml";
		private var _golden:GoldenXML;
		
		
		
		private static var instance:FlashVars;
		public static function getInstance(flashVars:Object):FlashVars {
			if (instance == null) {
				instance = new FlashVars();
				instance.InitVariables(flashVars);
			}
			return instance;
		}

		public function FlashVars() {
			if (instance) {
				throw new Error("Access is denied! Please use FlashVars.getInstance() to access this class!");
			} else {
				// Construct your code here.
			}
		}
		
		
		public function InitVariables(flashVars:Object):void {
			_logView = LogView.getInstance();
			_showError = ShowError.getInstance();
			_errorMessage = ErrorMessage.getInstance();
			_storage = Storage.getInstance();
			_storage.setFileUrl(initFile(flashVars.file));
			_storage.setCurrentVideoId(initCurrentVideo(flashVars.defaultVideo));
			_storage.setTitle(initTitle(flashVars.title));
			_storage.setAutoStart(initAuto(flashVars.autostart));
			_storage.setImage(initImage(flashVars.image));
			_storage.setGoldenXML(initGoldenXML(flashVars.goldenxml));
			
			_storage.setIntroVideoAvailable(initIntroVideoAvailabe(flashVars.introVideoAvailable));
			_storage.setIntroVideoUrl(initIntroVideoUrl(flashVars.introVideoUrl));
			
			// ======= @ Sunil Kumar - Jordan 
			
			_storage.setSubTitles(formatSubtitles(initSubTitles(flashVars.subtitles)));
			_logView.InsetLogText("<b>:: file = </b>"+_storage.getFileUrl());
			_logView.InsetLogText("<b>:: title = </b>"+_storage.getTitle());
			_logView.InsetLogText("<b>:: currentVideoId = </b>"+_storage.getCurrentVideoId());
			_logView.InsetLogText("<b>:: autostart =</b> "+_storage.getAutoStart());
			_logView.InsetLogText("<b>:: image = </b>"+_storage.getImage());
			
			_logView.InsetLogText("<b>:: IntroVideoAvailable = </b>"+_storage.getIntroVideoAvailable());
			_logView.InsetLogText("<b>:: IntroVideoUrl = </b>"+_storage.getIntroVideoUrl());
			_logView.InsetLogText("<b>:: subtitles = </b>"+_storage.getSubTitles());
			_logView.InsetLogText("<b>:: Golden Points = </b>"+_storage.getGoldenXML())
			InitVideo();
		}
		// @ Sunil Kumar - Jordan, August 28, 2011
		public function InitVideo():void{
			_logView.InsetLogText("<b>: InitVideo()</b>");
			_initSubTitle = InitSubTitle.getInstance(); // For testing....
			_golden = GoldenXML.getInstance();
			_logView.InsetLogText("<b>: InitVideo() ...........END HERE </b>");
			// ===== END ====== @ Sunil Kumar - Jordan, August 24, 2011
		}
		
		// Default values for Intro videos ========================================
		private function initIntroVideoAvailabe(setId:String):Boolean{
			var setVars:Boolean = (setId!=null && setId=="true")? true: _introVideoAvailable;
			return setVars;
		}
		private function initIntroVideoUrl(setId:String):String{
			var setVars:String = (setId!=null)? setId: _introVideoUrl;
			return setVars;
		}

		// Default variables 
		private function initFile(setId:String):String {
			var setVars:String = (setId!=null)? setId: _file;
			return setVars;
		}
		
		private function initGoldenXML(setId:String):String {
			var setVars:String = (setId!=null)? setId: _goldenXML;
			return setVars;
		}
		private function initTitle(setId:String):String {
			var setVars:String = (setId!=null)? setId: _title;
			return setVars;
		}
		private function initCurrentVideo(setId:String):Number {
			var setVars:Number = (setId!=null)? Number(setId): _defaultVideo;
			return setVars;
		}
		private function initAuto(setId:String):Boolean {
			var setVars:Boolean = (setId!=null && setId=="true")? true: _autostart;
			return setVars;
		}
		private function initImage(setId:String):String {
			var setVars:String = (setId!=null)? setId: _image;
			return setVars;
		}
		private function initSubTitles(setId:String):String {
			var setVars:String = (setId!=null)? "0, off,images/off.txt | "+setId: _subTitles;
			return setVars;
		}
		private function formatSubtitles(str:String):Array {
			var multiArr:Array = new Array();
			var tempArr:Array = str.split("|");
			for (var i:int=0; i<tempArr.length; i++) {
				var subArr:Array = (String(tempArr[i]).split(","));
				multiArr[i] = new Array();
				for (var j:int=0; j<subArr.length; j++) {
					multiArr[i].push(Utilities.trim(String(subArr[j])));
				}
			}
			return multiArr;
		}


	}
}