package com.knowledgehorizon.videoplayer.introvideo{
	// Import classes for use of their propertier and methods

	import flash.display.MovieClip;
	import flash.events.NetStatusEvent;
	import flash.net.*;
	import flash.media.Video;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.AsyncErrorEvent;

	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.streaming.*;

	public class IntroVideo extends MovieClip {
		// Internal classess 
		private var _drawing:Drawing;
		private var _storage:Storage;
		private var _logView:LogView;
		private var _bg:MovieClip;
		private var _videoHolder:MovieClip;
		private var _video:Video;

		private var _netStream:NetStream;
		private var _netConnect:NetConnection;
		private var _client:Client;
		private var _clientObj:Object;
		private var _duration:Number;
		private var _netConn:NetConnect;
		//-------- Main Item Holder ------------;
		private var ItemHolder:MovieClip;

		private static var instance:IntroVideo = new IntroVideo();
		public static function getInstance():IntroVideo {
			return instance;
		}

		public function IntroVideo() {
			if (instance) {
				throw new Error("Access is denied! Please use IntroVideo.getInstance() to access this class.");
			} else {
				InitIntroVideo();
			}
		}

		private function InitIntroVideo():void {
			_drawing = new Drawing();
			_storage = Storage.getInstance();
			_logView = LogView.getInstance();
			this.addChild(createItemHolder());
		}
		
		private function createItemHolder():MovieClip {
			ItemHolder = _drawing.createHolder();
			return ItemHolder;
		}


		public function createIntroVideo():void {
			ItemHolder.addChild(createVideoHolder());
			_client = new Client();
			_netConnect = new NetConnection();
			_netConnect.connect(_storage.getIntroNetConnUrl());
			_netConnect.client = _client;
			_netConnect.addEventListener(NetStatusEvent.NET_STATUS, NetStatusHandler, false, 0, true);
			_netConnect.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler, false, 0, true);
			_netConnect.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler, false, 0, true);
			_netConnect.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler, false, 0, true);
			if (_netConnect.connected) {
				trace("NetConnection IntroVideos HTTP found! ");
				InitNetStream();
			}else{
				trace("NetConnection IntroVideos RTMP found! ");
			}
		}
		
		private function InitNetStream():void {
			_netStream = new NetStream(_netConnect);
			_clientObj = new Object();
			_clientObj.onPlayStatus = getPlayStatus;
			_clientObj.onMetaData = getMetaData;
			_clientObj.onCuePoint = getCuePoint;
			_video.attachNetStream(_netStream);
			_video.smoothing = true;
			_netStream.client = _clientObj;
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, streamStatus, false, 0, true);
			_netStream.play(_storage.getIntroNetStreamUrl(), 0, -1, true);
			Preloader.getInstance().getPreloader().visible = false;
			
			
		}

		private function getMetaData(information:Object):void {
			_duration = Number(information.duration);
			_logView.InsetLogText("Video MetaData Duration = "+_duration);
			_storage.setVideoDuration(_duration);
		}

		private function getCuePoint(infoObect:Object):void {
			trace("CuePointSet");
		}
		
		private function VideoCompleted():void{
			deleteChildren();
			Preloader.getInstance().getPreloader().visible = true;
			_netConn = new NetConnect(_storage.getNetConnectURL());
		}
		
		public function deleteChildren():void{
			while(ItemHolder.numChildren){
				ItemHolder.removeChildAt(0);
			}
		}

		public function streamStatus(event:NetStatusEvent):void {
			trace("================== VideoStreaming ===============================");
			trace("IntroVideo.StreamStatus = "+event.info.code);
			trace("=================================================================");
			switch (event.info.code) {
				case "NetStream.Buffer.Empty" :
					_netStream.bufferTime = 3;
					break;
				case "NetStream.Buffer.Full" :
					_netStream.bufferTime = 10;
					break;
				case "NetStream.Play.Transition" :
					//_logView.InsetLogText("::<b> NetStream: </b>"+event.info.code);
					break;
				case "NetStream.Play.Start" :
					//_logView.InsetLogText(":: <b>NetStream: </b>"+event.info.code);
					break;
				case "NetStream.Play.StreamNotFound" :
					VideoCompleted()	
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
			trace("==============================================");
			switch (information.code) {
				case "NetStream.Play.Complete" :
					VideoCompleted();
					break;
				case "NetStream.Play.TransitionComplete" :
					//Storage.getInstance().setStreamSwitch(false);
					break;
			}
		}

		// =======================================================================================
		public function NetStatusHandler(event:NetStatusEvent):void {
			trace("================== NetConnect ===============================");
			trace("IntroVideo.NetConnect = "+event.info.code);
			//LogView.getInstance().InsetLogText("NetConnect = "+event.info.code);
			trace("**************************************************************");
			switch (event.info.code) {
				case "NetConnection.Connect.Success" :
					//InitBWTest();
					//InitNetStream();
					break;
				case "NetConnection.Connect.Closed" :
					//NetConnError();
					break;
				case "NetConnection.Connect.Failed" :
					//NetConnError();
					//StreamController.getInstance().onVideoError();
					break;
				case "NetConnection.Connect.AppShutdown" :
					//NetConnError();
					break;
				case "NetConnection.Connect.Rejected" :
					//NetConnError();
					break;
			}
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("Connect: securityErrorHandler: ");
			trace("connURI ");
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace("Connect: AsyncErrorEventHandler() "+event.text);
			trace("connURI ");
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Connect:ioErrorHandler: ");
			trace("connURI ");
		}


		//=======================================================
		private function createVideoHolder():MovieClip {
			_videoHolder = _drawing.createHolder();
			_videoHolder.addChild(createBg());
			_videoHolder.addChild(createVideo());
			return _videoHolder;
		}

		private function createVideo():Video {
			_video = new Video();
			_video.width = _storage.getStageWidth();
			_video.height = _storage.getStageHeight();
			return _video;
		}


		private function createBg():MovieClip {
			_bg = _drawing.createGraphics(0x000000,_storage.getStageWidth(),_storage.getStageHeight());
			return _bg;
		}


	}
}