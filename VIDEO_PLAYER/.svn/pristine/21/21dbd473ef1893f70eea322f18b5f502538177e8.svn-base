package com.knowledgehorizon.videoplayer.utility{

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Utilities {


		public static function connFormat(setId:String):String {
			var url:String = trim(setId);
			var array:Array = url.split("?");
			var newUrl:String = String(array[0]);
			var conn2:String = newUrl.substr(0,newUrl.lastIndexOf("/"));
			var conn:String = conn2.substr(0,conn2.lastIndexOf("/"));
			var outfile:String;
			var rtmpCheck:String = newUrl.substr(0,12);
			var RTMP:Number = rtmpCheck.indexOf("rtmp");
			if (RTMP != -1) {
				outfile = conn + "/";
			} else {
				outfile = null;
			}
			return outfile;
		}


		public static function fileFormat(setId:String):String {
			var url:String = trim(setId);
			var array:Array = url.split("?");
			var mw:String = (array[1]!=undefined && String(array[1]).length>0)? String("?"+array[1]): "";
			var newUrl:String = String(array[0]);
			var ext:String = newUrl.substr(-4);
			var conn:String = newUrl.substr(0,newUrl.lastIndexOf("/"));

			var f1:String = newUrl.substr(newUrl.lastIndexOf("/"));
			var t1:String = newUrl.substr(0,newUrl.lastIndexOf("/"));
			var t2:String = t1.substr(0,t1.lastIndexOf("/"));

			var f2:String = t1.substr(t1.lastIndexOf("/"));
			var newUrlUpdated:String = String(f2 + f1);
			trace("t1 = "+t1);
			trace("t2 = "+t2);
			trace("f1 = "+f2+f1);
			//var fileExt:String = newUrlUpdated.substr(newUrlUpdated.lastIndexOf("/"),newUrlUpdated.length);
			//trace("fileExt = "+fileExt);
			var file:String = newUrlUpdated.substr(1,-5);// Get only file name without extention
			var rtmpCheck:String = newUrl.substr(0,12);
			var RTMP:Number = rtmpCheck.indexOf("rtmp");
			var outfile:String;
			if (RTMP != -1) {
				if (ext == '.mp3') {
					outfile = 'mp3:' + file + mw;
				} else if (ext == '.mp4' || ext == '.mov' || ext == '.m4v' || ext == '.m4a' || ext == '.aac' || ext == '.m4a' || ext == '.f4v' || ext == '.3gp' || ext == '.3g2') {
					outfile = 'mp4:' + file + ext + mw;
				} else if (ext == '.flv') {
					outfile = file + mw;
				}
			} else {
				outfile = url;
			}
			return outfile;
		}






		/*
		public static function fileFormat(setId:String):String {
		var url:String = trim(setId)
		var array:Array = url.split("?");
		var mw:String = (array[1]!=undefined && String(array[1]).length>0)? String("?"+array[1]): "";
		var newUrl:String = String(array[0]);
		var ext:String = newUrl.substr(-4);
		var conn:String = newUrl.substr(0,newUrl.lastIndexOf("/"));
		var fileExt:String = newUrl.substr(newUrl.lastIndexOf("/"),newUrl.length);
		var file:String = fileExt.substr(1,-5);// Get only file name without extention
		var rtmpCheck:String = newUrl.substr(0,12);
		var RTMP:Number = rtmpCheck.indexOf("rtmp");
		var outfile:String;
		if (RTMP != -1) {
		if (ext == '.mp3') {
		outfile = 'mp3:' + file + mw;
		} else if (ext == '.mp4' || ext == '.mov' || ext == '.m4v' || ext == '.m4a' || ext == '.aac' || ext == '.m4a' || ext == '.f4v' || ext == '.3gp' || ext == '.3g2') {
		outfile = 'mp4:' + file + ext + mw;
		} else if (ext == '.flv') {
		outfile = file + mw;
		}
		} else {
		outfile = url;
		}
		return outfile;
		}
		
		public static function connFormat(setId:String):String {
		var url:String = trim(setId)
		var array:Array = url.split("?");
		var newUrl:String = String(array[0]);
		var conn:String = newUrl.substr(0,newUrl.lastIndexOf("/"));
		var outfile:String;
		var rtmpCheck:String = newUrl.substr(0,12);
		var RTMP:Number = rtmpCheck.indexOf("rtmp");
		if (RTMP != -1) {
		outfile = conn + "/";
		} else {
		outfile = null;
		}
		return outfile;
		} */
		public static function formatTime(t:int):String {
			var s:int = Math.round(t);
			var m:int = 0;
			var h:int = 0;
			if (s > 0) {
				while (s > 59) {
					m++;
					s -=  60;
				}
				while (m > 59) {
					h++;
					m -=  60;
				}
				if (h >= 1) {
					return String(h +":"+(m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
				} else {
					return String((m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
				}

			} else {
				return "00:00";
			}
		}

		public static function ReplaceButton(base:MovieClip, oldBtn:MovieClip, newBtn:MovieClip):void {
			try {
				trace("ReplaceButton = "+base.name,oldBtn.name, newBtn.name );
				var xpos:Number = oldBtn.x;
				var ypos:Number = oldBtn.y;
				base.removeChild(oldBtn);
				base.addChild(newBtn);
				newBtn.x = xpos;
				newBtn.y = ypos;
			} catch (error:Error) {
				trace("ReplaceButton Error = "+error);
			}
		}
		
		public static function trim(str:String):String {
			var stripCharCodes = {
			code_9  : true, // tab
			code_10 : true, // linefeed
			code_13 : true, // return
			code_32 : true// space
		}
		while (stripCharCodes["code_" + str.charCodeAt(0)] == true) {
			str=str.substring(1,str.length);
		}
		while (stripCharCodes["code_" + str.charCodeAt(str.length - 1)] == true) {
			str=str.substring(0,str.length-1);
		}
		return str;
	}


		/*
		private function useFlashVars(initObj:Object):void {
		LogView.getInstance().InsetLogText("======== LL String ======================");
		for (var ids:String in initObj) {
		var valueId:Object=initObj[ids];
		var tempVar:String=String(ids+" = "+valueId);
		// LogView.getInstance().InsetLogText(tempVar);
		}
		}
		*/

	}
}