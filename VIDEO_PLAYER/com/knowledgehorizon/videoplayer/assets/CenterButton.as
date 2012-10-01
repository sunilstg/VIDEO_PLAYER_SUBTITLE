package com.knowledgehorizon.videoplayer.assets{
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.assets.*
	import com.knowledgehorizon.videoplayer.controller.*
	
	
	public class CenterButton extends MovieClip {
		
		private var _storage:Storage;
		private var _video:VideoObject;
		private var _library:Library;
		private var _logView:LogView;
		private var _drawing:Drawing;
		private var _buttonEvent:ButtonEvents;
		private var _playBtn:MovieClip;
		private var _replayBtn:MovieClip;
		private var _sw:Number;
		private var _sh:Number;
		
		private var ItemHolder:MovieClip;
		
		
		private static var instance:CenterButton = new CenterButton();
		
		public static function getInstance():CenterButton{
			return instance;
		}
		
		public function CenterButton(){
			if(instance){
				throw new Error("Access id denied! Please use CenterButton.getInstance() to access this class.");
			}else{
				// constructor code
				InitCenterButton();
			}
		}
		public function createItemHolder():MovieClip{
			ItemHolder = _drawing.createHolder();
			//ItemHolder = _drawing.createGraphics(0xFF0000, 200, 150);
			return ItemHolder;
		}
		
		public function resetChildren():void{
			_sw = _video.getVideoWidth();
			_sh = _video.getVideoHeight();
			if(_playBtn!=null){
				_playBtn.x = Math.round((_sw-_playBtn.width)/2);
				_playBtn.y = Math.round((_sh-_playBtn.height)/2)-20;
			}
			if(_replayBtn!=null){
				_replayBtn.x = Math.round((_sw-_replayBtn.width)/2);
				_replayBtn.y = Math.round((_sh-_replayBtn.height)/2)-20;
			}
		}
		
		
		
		private function InitCenterButton():void {
			_storage = Storage.getInstance();
			_library = Library.getInstance();
			_logView = LogView.getInstance();
			_drawing = new Drawing();
			_buttonEvent = ButtonEvents.getInstance();
			_video = VideoObject.getInstance();
			this.addChild(createItemHolder());
			
		}
		
		public function createPlayButton():void{
			ItemHolder.addChild(playBtn());
		}
		
		public function createReplayButton():void{
			ItemHolder.addChild(replayBtn());
		}
		
		private function playBtn():MovieClip{
			_playBtn = _buttonEvent.createCPlayBtn();
			resetChildren();
			return _playBtn;
		}
		
		private function replayBtn():MovieClip{
			_replayBtn = _buttonEvent.createReplayBtn();
			resetChildren();
			return _replayBtn;
		}
		public function deleteChildren():void{
			while(ItemHolder.numChildren){
				ItemHolder.removeChildAt(0);
			}
			_replayBtn = null;
			_playBtn = null;
		}
		
		
	}
}
