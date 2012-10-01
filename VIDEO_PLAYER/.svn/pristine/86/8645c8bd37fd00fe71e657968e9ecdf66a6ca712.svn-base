package com.knowledgehorizon.videoplayer.external{
	
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	
	public class Preloader extends MovieClip{
		// Internal variables 
		private var drawing:Drawing;
		private var library:Library;
		
		private var ItemHolder:MovieClip;
		private var preloader:MovieClip;
		private var storage:Storage = Storage.getInstance();

		private static var instance:Preloader = new Preloader();
		public static function getInstance():Preloader{
			return instance;
		}
	
		public function Preloader() {
			if(instance){
				throw new Error("Access denied! Please use Preloader.getInstance() to access this class.")
			}else{
				drawing = new Drawing();
				library = Library.getInstance();
				addChild(createItemHolder());
				// constructor code
			}
		}
		
		public function createItemHolder():MovieClip{
			ItemHolder = drawing.createHolder();
			ItemHolder.addChild(createPreloader());
			return ItemHolder;
		}
		
		public function getPreloader():MovieClip{
			return preloader;
		}
		
		private function createPreloader():MovieClip{
			preloader = library.createPreloader();
			preloader.x = Math.round((storage.getStageWidth()-preloader.width)/2)
			preloader.y = Math.round((storage.getStageHeight()-preloader.height)/2)-20;
			return preloader;
		}
		
		public function resetPreloader():void{
			preloader.x = Math.round((storage.getStageWidth()-preloader.width)/2)
			preloader.y = Math.round((storage.getStageHeight()-preloader.height)/2)-20;
		}
		
		public function deleteChildren():void{
			while(ItemHolder.numChildren){
				ItemHolder.removeChildAt(0);
			}
		}
		
		
	}
}
