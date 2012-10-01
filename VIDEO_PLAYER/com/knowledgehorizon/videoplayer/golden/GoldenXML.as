package com.knowledgehorizon.videoplayer.golden{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.display.Loader;
	import com.knowledgehorizon.videoplayer.modal.Storage;

	public class GoldenXML {
		private var _storage:Storage;
		private var _targetList:XMLList;
		private var _urlLoader:URLLoader;
		private var _golden:XML;
		private var _title:String;
		private var _lang:String;
		private var _imageUrl:String;
		private var _points:Array;
		private static var instance:GoldenXML;
		public static function getInstance():GoldenXML {
			if (instance == null) {
				instance = new GoldenXML();
			}
			return instance;
		}

		public function GoldenXML() {
			if (instance) {
				throw new Error("Access is denied! Please GoldenXML.getInstance() to access this class");
			} else {
				try {
					_storage = Storage.getInstance();
					_points = new Array();
					_urlLoader = new URLLoader();
					_urlLoader.load(new URLRequest(_storage.getGoldenXML()));
					adListeners(_urlLoader);
				} catch (error:Error) {
					trace("******************  Error Found in loading xml of Golden................");
				}
			}
		}
		
		// ============== Retrieve all text ========================
		public function getPoints():Array {
			if (_points == null) {
				_points = new Array();
			}
			return _points;
		}
		public function getTitle():String {
			return _title;
		}
		public function getImage():String {
			return _imageUrl;
		}
		public function getLang():String{
			return _lang;
		}
		// ============== Retrieve all text ========================
		private function parseXML(xml:XML):void {

			_imageUrl = xml.points. @ title;
			_targetList = xml.points;
			for each (var points:XML in _targetList) {
				_imageUrl = String(points. @ image);
				_title = String(points. @ title);
				_lang = String(points. @ lang).toUpperCase();
				for(var i:int= 0; i<points.point.length(); i++){;
				_points.push(points.point[i]);
			}
		}
		trace("=============  Golden points Successfully loaded =================");
	}

	private function completeHandler(event:Event):void {
		removeListeners(_urlLoader);
		_golden = new XML(event.target.data);
		parseXML(_golden);
	}

	private function httpStatusHandler(event:HTTPStatusEvent):void {
		if (event.status == 404) {
			trace("URL Not found: httpStatusHandler: " + event);
		}
	}
	private function securityErrorHandler(event:SecurityErrorEvent):void {
		trace("SecurityErrorHandler: " + event);
	}
	private function ioErrorHandler(event:IOErrorEvent):void {
		trace(" IoErrorHandler: " + event);
	}
	private function adListeners(dispatcher:IEventDispatcher):void {
		dispatcher.addEventListener(Event.COMPLETE, completeHandler);
		dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	}
	private function removeListeners(dispatcher:IEventDispatcher):void {
		dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
		dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	}
}
}