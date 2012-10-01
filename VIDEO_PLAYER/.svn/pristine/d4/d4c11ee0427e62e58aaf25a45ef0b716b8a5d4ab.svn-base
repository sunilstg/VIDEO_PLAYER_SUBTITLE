/*
 "EK TU HI NIRANKAR - ONE THE FORMLESS ALMIGHTY GOD" 
 
Project Name :KH Video Player
Developer  :  Sunil Kumar 
Started on   :  June 20, 2011
Completed by :  ---
-------------------------------------
Last modified by     : name of developer 
Last modified logic  : details of logic 
*/
package com.knowledgehorizon.videoplayer.modal{
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.utility.*;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Storage {
		// Centeral warehouse and data services (Internal variables)
		//private var _fileArr:Array;
		private var _isIntroAvailable:Boolean;
		private var _introVideoUrl:String;
		private var _introNetConnUrl:String;
		private var _introNetStreamUrl:String;
		
		
		
		private var _qualityFile:Array;
		private var _currentVideoId:Number;
		private var _previousVideoId:Number;
		private var _bandWidth:Number;
		private var _file:String;
		private var _title:String;
		private var _autostart:Boolean;
		private var _image:String;
		private var _pid:String;
		private var _sid:String;
		private var _uid:String;
		private var _domain:String;
		private var _subTittles:Array;
		private var _subTitleLoaded:Array;
		private var _currLangId:Number;
		private var _webServiceUrl:String;
		private var _controlBarHeight:Number;
		private var _subTitleAvailable:Boolean;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _netConnect:NetConnection;
		private var _netStream:NetStream;
		private var _netConnectURL:String;
		private var _netStreamURL:String;
		private var _videoInfo:Object;
		private var _flashVars:Object;
		private var _mute:Boolean = false;
		private var _seekWidth:Number;
		private var _leftButtons:MovieClip;
		private var _rightButtons:MovieClip;
		private var _volumeBtnHolder:MovieClip;
		private var _elapsedText:TextField;
		private var _totalText:TextField;
		private var _duration:Number;
		private var _installedFLPVersion:String;
		private var _goldenXML:String;

		private var _playerVersion:String = "© KH Video Player TTIME Version: 3.0.0.0";
		//================= Define singleton pattern and constructor ========
		private static var instance:Storage = new Storage();
		public static function getInstance():Storage {
			return instance;
		}

		public function Storage() {
			if (instance) {
				throw new Error("Access is denied! Please use Storage.getInstance() to access this class.");
			} else {
				// Constructor
			}
		}
		// ==== @ Sunil Kumar - Jordan, August 28, 2011
		// =================== Intro Video gettet and setter with all details for TTIME ==============
		
		public function getGoldenXML():String{
			return _goldenXML;
		}
		public function setGoldenXML(setId:String):void{
			_goldenXML = setId;
		}
		public function setIntroVideoAvailable(setId:Boolean):void{
			_isIntroAvailable = setId;
		}
		public function getIntroVideoAvailable():Boolean{
			return _isIntroAvailable;
		}
		
		public function setIntroVideoUrl(setId:String):void{
			_introVideoUrl = setId;
			setIntroVideoConnAndFile(_introVideoUrl);
		}
		public function getIntroVideoUrl():String{
			return _introVideoUrl;
		}
		
		//private var _introNetConnUrl:String;
		//private var _introNetStreamUrl:String;
		
		public function setIntroNetConnUrl(setId:String):void{
			_introNetConnUrl = setId;
		}
		
		public function getIntroNetConnUrl():String{
			return _introNetConnUrl;
		}
		
		public function setIntroNetStreamUrl(setId:String):void{
			_introNetStreamUrl = setId;
		}
		
		public function getIntroNetStreamUrl():String{
			return _introNetStreamUrl;
		}
		
		
		private function setIntroVideoConnAndFile(setId:String):void{
			_introNetConnUrl = Utilities.connFormat(setId);
			_introNetStreamUrl = Utilities.fileFormat(setId);
		}

		
		
		
		// =================== Bandwidth getter and setter ==============================
		
		public function setBandWidth(setId:Number):void{
			_bandWidth = setId;
		}
		public function getBandWidth():Number{
			return _bandWidth;
		}
		// ==================== Player internal information =============================
		public function getPlayerVersion():String {
			return _playerVersion;
		}
		public function setFLPVersion(setId:String):void {
			_installedFLPVersion = setId;
		}
		public function getFLPVersion():String {
			return _installedFLPVersion;
		}

		// Web service request URL Getter and seetter 
		public function setWebServiceUrl(setId:String):void {
			_webServiceUrl = setId;
		}

		public function getWebServiceUrl():String {
			return _webServiceUrl;
		}

		// ==================== Player information and release notes ====================
		public function updateRelease():void {
			LogView.getInstance().InsetLogText("-------------------------------------------------------------");
			LogView.getInstance().InsetLogText("<b>:: "+_playerVersion+"</b>");
			LogView.getInstance().InsetLogText("<b>:: Project Name: </b>\t Knowledge Horizon Video Player ");
			LogView.getInstance().InsetLogText("<b>:: Developed by : </b>\t Sunil Kumar");
			LogView.getInstance().InsetLogText("<b>:: Designed by : </b>\t Sunil Kumar");
			LogView.getInstance().InsetLogText("-------------------------------------------------------------");
			LogView.getInstance().InsetLogText("");
		}

		// ==================== Video information getter/setter i.e. file, title, etc ====================;
		public function getMuteButton():Boolean {
			return _mute;
		}
		public function setMuteButton(setId:Boolean):void {
			_mute = setId;
		}
		public function setConnAndFile(setId:String):void {
			_file = setId;
			_netConnectURL = Utilities.connFormat(setId);
			_netStreamURL = Utilities.fileFormat(setId);
			/*trace(" =====================  New Url has set for video play ============");
			trace("NetConnection : "+_netConnectURL);
			trace("NetStream : "+_netStreamURL);
			trace(" =====================************************* ============");*/
		}
		// ==================== Seek bar width getter and setter     ====================
		public function setSeekWidth(setId:Number):void {
			_seekWidth = setId;
		}
		public function getSeekWidth():Number {
			return _seekWidth;
		}


		// ==================== Stage width and height getter/setter ====================


		public function setStageWidth(setId:Number):void {
			_stageWidth = setId;
		}

		public function setStageHeight(setId:Number):void {
			_stageHeight = setId;
		}

		public function getStageWidth():Number {
			return _stageWidth;
		}
		public function getStageHeight():Number {
			return _stageHeight;
		}

		// ====================  NetConnection getter/setter ==========================
		public function setNetConnect(setId:NetConnection):void {
			_netConnect = setId;
		}

		public function getNetConnect():NetConnection {
			return _netConnect;
		}

		public function setNetConnectURL(setId:String):void {
			_netConnectURL = setId;
		}

		public function getNetConnectURL():String {
			return _netConnectURL;
		}

		// ==================== NetStream getter and setter   ====================

		public function setCurrentVideoId(setId:Number):void {
			_currentVideoId = setId;
		}

		public function getCurrentVideoId():Number {
			return _currentVideoId;
		}

		public function setPreviousVideoId(setId:Number):void {
			_previousVideoId = setId;
		}
		public function getPreviousVideoId():Number {
			return _previousVideoId;
		}

		public function setNetStream(setId:NetStream):void {
			_netStream = setId;
		}
		public function getNetStream():NetStream {
			return _netStream;
		}
		public function setNetStreamURL(setId:String):void {
			_netStreamURL;
		}
		public function getNetStreamURL():String {
			return _netStreamURL;
		}
		// Controlbar left and right buttons holder gettet and setter 
		public function setLeftButtons(setId:MovieClip):void {
			_leftButtons = setId;
		}
		public function setRightButtons(setId:MovieClip):void {
			_rightButtons = setId;
		}

		public function getLeftButtons():MovieClip {
			return _leftButtons;
		}

		public function getRightButtons():MovieClip {
			return _rightButtons;
		}
		// Create volume button holder getter and setter 
		public function setVolumeBtnHolder(setId:MovieClip):void {
			_volumeBtnHolder = setId;
		}
		public function getVolumeBtnHolder():MovieClip {
			return _volumeBtnHolder;
		}

		// Create video duration getter and setter 
		public function setVideoDuration(setId:Number):void {
			_duration = setId;
		}
		public function getVideoDuration():Number {
			return _duration;
		}
		public function setElapsedText(setId:TextField):void {
			_elapsedText = setId;
		}
		public function getElapsedText():TextField {
			return _elapsedText;
		}

		public function setSubTitles(setId:Array):void {
			_subTittles = setId;
		}
		public function setSubTitleLoaded(setId:Array):void {
			_subTitleLoaded = setId;
			subTitleAvailable(_subTitleLoaded);
		}

		private function subTitleAvailable(statusArray:Array):void {
			var count:Number = 0;
			for (var i:int=0; i<statusArray.length; i++) {
				var str:String = String(statusArray[i]);
				if (str == "true") {
					count++;
				}
			}
			if (count > 0) {
				_subTitleAvailable = true;
			} else {
				_subTitleAvailable = false;
			}
		}

		public function setTotalText(setId:TextField):void {
			_totalText = setId;
		}
		public function getTotalText():TextField {
			return _totalText;
		}
		// ========================  Set video files and setups video information 
		public function setQualtiyFile(setId:Array):void {
			_qualityFile = setId;
			trace("*************************************_qualityFile = "+_qualityFile, _qualityFile.length, "current video id"+_currentVideoId)
			setConnAndFile(String(_qualityFile[0][1]));
			//updateNewVideoUrl(_qualityFile);
		}
		
		public function getCurrentQuality():String{
			var quality:String = String(_qualityFile[_currentVideoId][0]);
			return quality;
		}
		
		private function updateNewVideoUrl(setId:Array):void{
			var _len:Number = setId.length;
			if (setId.length > 0) {
				if (_currentVideoId > _len) {
					_currentVideoId = 0;
				} else {
					//setConnAndFile(String(setId[_currentVideoId][1]));
				}
			}
			trace("_currentVideoId = "+_currentVideoId, "_qualityFile = "+setId.length);
		}
		
		public function bandWidthBaseFileSwitch(setId:Number):void{
			if(_qualityFile.length>0 && _qualityFile!=null){
			  setConnAndFile(String(_qualityFile[setId][1]));
			  
			}
		}
		
		public function getQualityFile():Array {
			if (_qualityFile == null) {
				_qualityFile = new Array();
			}
			return _qualityFile;
		}

		public function setFileUrl(setId:String):void {
			_file = setId;
			setConnAndFile(_file);
		}
		public function setTitle(setId:String):void {
			_title = setId;
		}
		public function setAutoStart(setId:Boolean):void {
			_autostart = setId;
		}
		public function setImage(setId:String):void {
			_image = setId;
		}
		public function setPid(setId:String):void {
			_pid = setId;
		}

		public function setSid(setId:String):void {
			_sid = setId;
		}

		public function setUid(setId:String):void {
			_uid = setId;
		}

		public function setDomain(setId:String):void {
			_domain = setId;
		}





		// =========================  GETTER OF Flashvars ==========================

		public function getFileUrl():String {
			return _file;
		}

		public function getTitle():String {
			return _title;
		}

		public function getAutoStart():Boolean {
			return _autostart;
		}

		public function getImage():String {
			return _image;
		}

		public function getPid():String {
			return _pid;
		}

		public function getSid():String {
			return _sid;
		}

		public function getUid():String {
			return _uid;
		}

		public function getDomain():String {
			return _domain;
		}
		public function getSubTitles():Array {
			return _subTittles;
		}
		public function getSubTitleLoaded():Array {
			return _subTitleLoaded;
		}




		// =================  Controlbar height getter and setter 
		public function setControlBarHeight(setId:Number):void {
			_controlBarHeight = setId;
		}
		public function getControlBarHeight():Number {
			return _controlBarHeight;
		}
		public function setSubTitleAvailabe(setId:Boolean):void {
			_subTitleAvailable = setId;
		}
		public function getSubTitleAvailabe():Boolean {
			return _subTitleAvailable;
		}

		public function setCurrLanguage(setId:Number):void {
			_currLangId = setId;
		}
		public function getCurrLanguage():String {
			var str:String = String(getSubTitles()[_currLangId][1]).toUpperCase();
			return str;
		}






	}
}