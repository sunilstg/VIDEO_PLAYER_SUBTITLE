package com.knowledgehorizon.videoplayer.streaming{
	import flash.net.NetStream;
	import flash.net.NetStreamPlayOptions;
	import flash.net.NetStreamPlayTransitions;
	import com.knowledgehorizon.videoplayer.modal.Storage;
	import com.knowledgehorizon.videoplayer.external.LogView;
	import com.knowledgehorizon.videoplayer.assets.Drawing;
	import com.knowledgehorizon.videoplayer.assets.Library;
	import com.knowledgehorizon.videoplayer.modal.Modal;

	public class Setting {
		private var _netStream:NetStream;
		private var _storage:Storage;
		private var _logView:LogView;
		private var _drawing:Drawing;
		private var _library:Library;
		private var _paramOption:NetStreamPlayOptions;

		private var _qualityFiles:Array;
		private var _currentVideoId:Number;
		private var _oldStream:String;
		private var _newStream:String;
		private var _modal:Modal;


		private static var instance:Setting = new Setting();
		public static function getInstance():Setting {
			return instance;
		}

		public function Setting() {
			if (instance) {
				throw new Error("Access is denied! Please use Setting.getInstance() to access this class.");
			} else {
				InitSetting();
			}
		}

		private function InitSetting():void {
			_storage = Storage.getInstance();
			_netStream = _storage.getNetStream();
		}

		public function dynamicStream(setId:Number):void {
			nsPlayOption(setId);
		}


		private var _newVideoId:Number;

		private function nsPlayOption(newVideoId:Number):void {
			try {
				_currentVideoId = _storage.getCurrentVideoId();
				_newVideoId = newVideoId;
				_modal = Modal.getInstance();
				trace("case = "+_currentVideoId,newVideoId);
				if (_currentVideoId != newVideoId && _modal.getState() != "stopState") {
					_qualityFiles = _storage.getQualityFile();
					_oldStream = _storage.getNetStreamURL();
					_newStream = String(_qualityFiles[newVideoId][1]);
					_storage.setConnAndFile(_newStream);
					//===========  Change Request ========================;
					_paramOption= new NetStreamPlayOptions();
					_paramOption.oldStreamName = _oldStream;
					_paramOption.streamName = _storage.getNetStreamURL();
					_paramOption.transition = NetStreamPlayTransitions.SWITCH;
					_netStream.play2(_paramOption);
					trace("Updating please wait......",_oldStream,  _storage.getNetStreamURL());
					//========== Change Request completed ================
				} else {
					trace("Switch not required...........");
				}
			} catch (error:Error) {
				trace("Error occured at Setting.nsPlayOptions()");
			}
		}

		public function updateComplete():void {
			_storage.setCurrentVideoId(_newVideoId);
		}
		public function updateFailed():void {
			_qualityFiles = _storage.getQualityFile();
			if (_netStream != null && _qualityFiles.length>0) {
				trace("update failed "+_netStream)
				_newStream = String(_qualityFiles[_currentVideoId][1]);
				_storage.setConnAndFile(_newStream);
			}else{
				trace("----NA----")
			}

		}

	}

}