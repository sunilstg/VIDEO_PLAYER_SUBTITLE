package com.knowledgehorizon.videoplayer.assets{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.media.Video;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.streaming.*;
	import com.knowledgehorizon.videoplayer.introvideo.*;
	
	//import com.knowledgehorizon.videoplayer.webservices.InitErrorWebService;

	public class InitSubTitle {
		private var storage:Storage;
		private var logView:LogView;
		
		private var voScript:Array;
		private var voScriptEN:Array;
		private var voScriptAR:Array;
		private var voScriptFormat:TextFormat;
		private var voScriptParams:Object;
		private var loader:URLLoader;
		private var loaderAR:URLLoader;
		private var request:URLRequest;
		private var vdoReadyToRun:Boolean;
		private var loadDefaultLanguage:Boolean;
		private var subTitlesENComplete:Boolean;
		private var subTitlesARComplete:Boolean;
		private var subTitlesENLoaded:int;
		private var subTitlesARLoaded:int;
		private var language:String;
		private var script:String = "";
		private var currLang:String;
		private var scriptIndex:Number;
		private var toolRref;
		// ===========================
		//private var subTitle:SubTitle;
		private var ItemHolder:MovieClip;
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		private var xml:XML;
		private var txtArray:Array;
		private var timer:Timer;
		private var _netConn:NetConnect;
		private var voScriptArray:Array;
		private var count:Number = 0;
		private var statusArray:Array;
		private var len:Number;
		private var _language:Number = 0;
		private var _arabText:Number;
		
		

		private static var instance:InitSubTitle = new InitSubTitle();
		public static function getInstance():InitSubTitle{
			return instance;
		}
		
		public function InitSubTitle() {
			if(instance){
				throw new Error("Access is denied! Please use InitSubTitle.getInstance() to access this class");
			}else{
				trace("_initSubTitle Initialised");
				updateSubTitltes();
				
			}
		}
		
		private function updateSubTitltes():void {
			logView = LogView.getInstance();
			storage = Storage.getInstance();
			logView.InsetLogText("<b> Starting ....updateSubTitltes() please wait....................... </b>")
			len = storage.getSubTitles().length;
			
			voScriptArray = new Array();
			statusArray = new Array();
			voScriptParams=new Object();
			voScriptFormat=new TextFormat();
			_language = 0;
			count = 0;
			loadSubtitles(count);
			logView.InsetLogText("<b>END  updateSubTitltes() please wait....................... </b>")
		}
		
		private function loadNext():void{
			if(count<len-1){
				count++;
				loadSubtitles(count);
			}else{
				storage.setSubTitleLoaded(statusArray);
				trace("storage.setSubTitleLoaded = "+storage.getSubTitleLoaded());
				changeLang(1);
				customCheck();
				trace("Status Array ............................"+statusArray);
				InitVideoPlayer();
			}
		}
		
		private function InitVideoPlayer():void{
			
			if(storage.getIntroVideoAvailable()){
				IntroVideo.getInstance().createIntroVideo();
			}else{
				trace("Intro Video available......"+storage.getIntroVideoAvailable())
				logView.InsetLogText("Introvideo Available "+storage.getIntroVideoAvailable());
				logView.InsetLogText("Introvideo Available "+storage.getNetConnectURL())
				_netConn = new NetConnect(storage.getNetConnectURL());
			}
			
		}
		
		
		
		private function customCheck():void{
			var newUrl:String = String(storage.getSubTitles()[count]);
			var newArr:Array = storage.getSubTitles();
			for(var i:int=0; i<newArr.length; i++){
				var str:String = String(newArr[i][1]);
				if(str=="ar"){
					_arabText = Number(newArr[i][0]);
					trace(str, _arabText);
				}
			}
		}
		
		private function loadSubtitles(count:Number):void{
			var newUrl:String = String(storage.getSubTitles()[count][2]);
			request = new URLRequest(newUrl);
			loader = new URLLoader();
			loader.load(request);
			addListeners(loader);
		}
		private function getIOError(event:IOErrorEvent):void{
			statusArray.push("false");
			removeListeners(loader);
			loadNext();
		}
		
		private function completeHandler(event:Event):void{
			statusArray.push("true");
			parseArray(event.target.data);
			removeListeners(loader);
			loadNext();
		}
		
		private function parseArray(_data:*= null):void{
			voScriptArray[count] = new Array();
			var temp:*;
			voScript = voScriptArray[count];
			temp = _data.split('[')
			temp.filter(getVOScriptData);
			temp[0].split('{').filter(getVOScriptParams);
			
		}
		
		public function changeLang(setId:Number):void{
			loadDefaultLanguage = false;
			_language = setId;
			storage.setCurrLanguage(_language);
		}
		
		private function addListeners(dispatcher:EventDispatcher):void{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, getIOError, false, 0, true);
		}
		
		private function removeListeners(dispatcher:EventDispatcher):void{
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, getIOError);
		}

		public function getTranscript(_time:*):String {
			if (! loadDefaultLanguage) {
				loadDefaultLanguage = true;
				voScript = voScriptArray[_language];
			}
			for (var a in voScript) {
				if (_time > voScript[a].startTime && _time < voScript[a].endTime) {
					scriptIndex = a;
					script = voScript[scriptIndex].text;
					break;
				} else {
					script = "";
				}
			}
			return script;
		}
			

		private function getVOScriptData(element:*, index:int, arr:Array) {
			var obj:Object=new Object();
			var a;
			var b;
			var c;
			var d;
			if (element.length == 16) {
				var tmp1 = arr[index - 1] + arr[index];
				var tmp2 = tmp1.substring(0,tmp1.indexOf("]"));
				a = tmp2;
				b = a.split(":");
				c=(Number(b[0])*60)+Number(b[1]);
				d=(Number(c)*60)+Number(b[2]);
				obj.startTime = Number(d);
				tmp2 = tmp1.substring(tmp1.indexOf("]") + 1,tmp1.lastIndexOf("]") - 11);
				var t1 = tmp2.indexOf(" ") - 2;
				tmp2 = tmp2.substring(tmp2.indexOf(" ") - t1,tmp2.length - 2);
				obj.text = tmp2;
				tmp2 = tmp1.substring(tmp1.lastIndexOf("]") - 11,tmp1.lastIndexOf("]"));
				a = tmp2;
				b = a.split(":");
				c=(Number(b[0])*60)+Number(b[1]);
				d=(Number(c)*60)+Number(b[2]);
				obj.endTime = Number(d);
				voScript.push(obj);
			}
		}

		private function getVOScriptParams(element:*, index:int, arr:Array) {
			if (element.indexOf("}") != -1) {
				var tmp1 = element;
				var tmp2 = tmp1.substring(0,tmp1.indexOf("}"));
				if (tmp2.indexOf(":") != -1) {
					var temp3 = tmp2.split(":");
					voScriptParams[temp3[0]] = temp3[1];
					if (temp3[0] == "font") {
						voScriptFormat.font = temp3[1];
					} else if (temp3[0]=="size") {
						voScriptFormat.size = temp3[1];
					}
				} else {
					voScriptParams[tmp2] = tmp2;
				}
			}
		}

	}
}