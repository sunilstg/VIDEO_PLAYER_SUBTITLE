/*
					"EK TU HI NIRANKAR - ONE THE FORMLESS ALMIGHTY GOD" 
	 
	Project Name :	KH Video Player
	Developer 	 :  Sunil Kumar 
	Started on   :  June 20, 2011
	Completed by :  ---
	
	-------------------------------------
	Last modified by     : name of developer 
	Last modified logic  : details of logic 
	
*/

package com.knowledgehorizon.videoplayer.controller{
	
	import flash.display.MovieClip;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.introvideo.*;
	
	
	public class Controller {
		// Internal variables 
		private var _streamController:StreamController;
		// ======================  Create Singleton pattern ======================
		private static var instance:Controller = new Controller();
		public static function getInstance():Controller{
			return instance;
		}
		public function Controller() {
			if(instance){
				throw new Error("Access denied! Please use ChildControl.getInstance() to access this class.")
			}else{
				// constructor code
				InitController();
			}
		}
		
		private function InitController():void{
			ChildControl.getInstance().createChildren();
			StreamController.getInstance().InitVideoController();
		}
		
		
		
		
	}
}
