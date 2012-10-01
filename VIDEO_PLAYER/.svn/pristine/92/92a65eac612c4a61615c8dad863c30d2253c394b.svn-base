package com.knowledgehorizon.videoplayer.assets{
	import flash.display.MovieClip;
	import flash.media.Video;
	import com.knowledgehorizon.videoplayer.modal.*;
		
	public class VideoObject extends MovieClip {
		// Internal variables 
		private var drawing:Drawing;
		private var ItemHolder:MovieClip;
		private var videoObj:Video;
		private var videoScreen:MovieClip;
		private var videoHolder:MovieClip;
		private var storage:Storage = Storage.getInstance();
		
		// ======================  Create Singleton pattern ======================
		private static var instance:VideoObject = new VideoObject();
		public static function getInstance():VideoObject{
			return instance;
		}
		public function VideoObject() {
			if(instance){
				throw new Error("Access denied! Please use VideoObject.getInstance() to access this class.")
			}else{
				// constructor code
				InitVideoObj();
			}
		}
		
		// ======================  Init constructor  =============================
		private function InitVideoObj():void{
			drawing =new Drawing();
			this.addChild(createItemHolder());
		}
		
		private function createItemHolder():MovieClip{
			ItemHolder = drawing.createHolder();
			ItemHolder.addChild(createVideoHolder());
			resetChildren();
			return ItemHolder;
		}
		
		private function createVideoObj():Video{
			videoObj = new Video();
			videoObj.width  = 320;
			videoObj.height = 240;
			return videoObj;
		}
		private function createVideoHolder():MovieClip{
		    videoHolder = drawing.createHolder();
			videoHolder.addChild(createVideoScreen());
			videoHolder.addChild(createVideoObj());
			return videoHolder;
		}
		
		public function getVideoHolder():MovieClip{
			return videoHolder;

		}
		
		private function createVideoScreen():MovieClip{
			videoScreen =  drawing.createGraphics(0x000000,320, 240); // Set any default value and reset when player render 
			return videoScreen;
		}
		public function getVideoObj():Video{
			return videoObj;
		}
		public function resetChildren():void{
			videoScreen.width = Math.round(storage.getStageWidth());
			videoScreen.height = Math.round(storage.getStageHeight());
			videoObj.width = Math.round(storage.getStageWidth());
			videoObj.height = Math.round(storage.getStageHeight());
		}
		public function getVideoHeight():Number{
			return videoObj.height;
		}
		
		public function getVideoWidth():Number{
			return videoObj.width;
		}
		
		
		
				
			
	}
}
