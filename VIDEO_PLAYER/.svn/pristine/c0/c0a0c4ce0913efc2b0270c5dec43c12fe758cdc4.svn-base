/*

 
Project Name :KH Video Player
Developer  :  Sunil Kumar 
Started on   :  June 20, 2011
Completed by :  ---
-------------------------------------
Last modified by     : name of developer 
Last modified logic  : details of logic 
*/

package com.knowledgehorizon.videoplayer.document{

	import flash.display.*;
	import flash.display.LoaderInfo;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.FullScreenEvent;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.streaming.*;
	import com.knowledgehorizon.videoplayer.controller.*;
	//import com.knowledgehorizon.videoplayer.webservices.*;
	import com.knowledgehorizon.videoplayer.utility.*;
	import com.knowledgehorizon.videoplayer.flashvars.*;
	import com.knowledgehorizon.videoplayer.introvideo.*;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	
	public class InitVideoPlayer extends MovieClip {
		private var _playerVersion:String = "© KH Video Player Ver: 3.2.1.4";
		// Internal variables and class
		private var _drawing:Drawing;
		//private var _initWebService:InitWebService;
		private var _storage:Storage;
		private var _flashVars:Object;
		private var _menuItem:Array;
		private var _contextItem:ContextMenus;
		private var _introVideo:IntroVideo;
		private var _childControl:ChildControl;
		private var _preloader:Preloader;
		private var _showError:ShowError;
		private var _logView:LogView;
		private var _bufferStatus:BufferStatus;
		private var _seekController:SeekController;
		private var _volumeController:VolumeController;
		private var _mouseMove:MouseMove;
		private var _capability:String;
		private var _netStream:NetStream;
		private var ItemHolder:MovieClip;

		// Define constructor here
		public function InitVideoPlayer() {
			//Engine();
			// set object scale mode to no so that object should not scale when resize. 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			_storage = Storage.getInstance();
			_storage.setStageWidth(stage.stageWidth);
			_storage.setStageHeight(stage.stageHeight);
			// @ Sunil Kumar - 04th Sep.2011 ;
			_flashVars = new Object();
			// First set to stage width and height;
			_storage.updateRelease();
			_drawing = new Drawing();
			this.addChild(createItemHolder());
			flashPlayerCapabilites();
			_bufferStatus = BufferStatus.getInstance();
			_mouseMove = MouseMove.getInstance();
			rightClickMenu();
			stageListener();
			addListeners(this.root.loaderInfo);
		}

		// Create main Item Holder 
		private function createItemHolder():MovieClip {
			ItemHolder = _drawing.createHolder();
			ItemHolder.addChild(createIntroVideo());
			ItemHolder.addChild(createChildControl());
			ItemHolder.addChild(createPreloader());
			ItemHolder.addChild(createShowError());
			ItemHolder.addChild(createLogView());
			return ItemHolder;
		}
		private function createIntroVideo():IntroVideo {
			_introVideo = IntroVideo.getInstance();
			return _introVideo;
		}
		private function createChildControl():ChildControl {
			_childControl = ChildControl.getInstance();
			return _childControl;
		}
		private function createPreloader():Preloader {
			_preloader = Preloader.getInstance();
			return _preloader;
		}
		private function createShowError():ShowError {
			_showError = ShowError.getInstance();
			return _showError;
		}

		private function createLogView():LogView {
			_logView = LogView.getInstance();
			return _logView;
		}

		private function flashPlayerCapabilites():void {
			_capability = String(Capabilities.version);
			trace("_capability = "+_capability);
			_storage.setFLPVersion(_capability);
			//return Number( _capability.split(" ")[1].split(",", 1) );
			_logView.InsetLogText("Flash Player Version: "+_storage.getFLPVersion());
		}


		// ===============================  Statge main controller ==========================
		private function stageListener():void {
			stage.addEventListener(Event.RESIZE, stageResize, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMoveEvent, false, 0, true);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, toggleFullScreen, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardEvent, false, 0, true);
		}

		private function addListeners(dispatch:EventDispatcher):void {
			//when the data from the flashvars is now loaded call loadFlashVars method
			dispatch.addEventListener(Event.COMPLETE, loaderComplete, false, 0, true);
			//when there is no flashvars call loadFlashVars ** prevents the ugly runtime error box **
			dispatch.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			//when data is been loaded from an untrusted domain ** prevents the ugly runtime error box **
			dispatch.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
		}

		private function removeListeners(dispatch:EventDispatcher):void {
			// clean up after yourself you don’t need wasted memory
			// listening for some thing that already happend and will not happen again
			dispatch.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatch.removeEventListener(Event.COMPLETE, loaderComplete);
			dispatch.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function loaderComplete(event:Event):void {
			trace("FlashVars Load Completed Successfully");
			_flashVars = this.root.loaderInfo.parameters;
			FlashVars.getInstance(_flashVars);
			//useFlashVars(_flashVars);
			removeListeners(this.root.loaderInfo);
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler()");
			_logView.InsetLogText("<b>FlashVars I/O Error: </b>"+event);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler()");
			//_logView.InsetLogText("<b>FlashVars Security Error: </b>"+event);
		}
		public function stageResize(event:Event):void {
			_storage.setStageWidth(stage.stageWidth);
			_storage.setStageHeight(stage.stageHeight);
			_netStream = _storage.getNetStream();
			_preloader.resetPreloader();
			_logView.resetXYPos(_storage.getStageWidth(),_storage.getStageHeight());
			if (_netStream != null) {
				_childControl.resetChildren();
			}
		}
		private function toggleFullScreen(event:FullScreenEvent):void {
			_netStream = _storage.getNetStream();
			if (_netStream != null) {
				ButtonEvents.getInstance().replaceBtnFromStage();
				_childControl.resetChildren();
			}
		}
		private function stageMouseUp(event:MouseEvent):void {
			_netStream = _storage.getNetStream();

			_logView.stgEnd();
			if (_netStream != null) {
				_seekController = SeekController.getInstance();
				_volumeController = VolumeController.getInstance();
				_seekController.stopSeekThumb(event);
				_volumeController.stopVol(event);
			}
		}

		private function MouseMoveEvent(event:MouseEvent):void {
			if (_netStream != null) {
				_mouseMove.MouseMoveEvent(event);
			}
		}


		private function keyBoardEvent(event:KeyboardEvent):void {
			_logView.ToggleLogView(event);
			if (_netStream != null) {
				_bufferStatus.keyEvent(event);
			}
		}
		//BufferStatus.getInstance().keyEvent(event);

		private function rightClickMenu():void {
			_menuItem = new Array();
			_menuItem.push({caption:_playerVersion});
			_contextItem = new ContextMenus(_menuItem);
			_contextItem.init(this);
		}
		private function useFlashVars(initObj:Object):void {
			_logView.InsetLogText("======== FLASHVARS RECEIVED ======================");
			for (var ids:String in initObj) {
				var valueId:Object = initObj[ids];
				var tempVar:String = String(ids + " =\t " + valueId);
				_logView.InsetLogText(tempVar);
			}
			_logView.InsetLogText("======== FLASHVARS END HERE  ======================");
		}
		






	}
}