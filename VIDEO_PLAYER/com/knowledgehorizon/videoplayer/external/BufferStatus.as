package com.knowledgehorizon.videoplayer.external{

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import com.knowledgehorizon.videoplayer.modal.Storage;

	public class BufferStatus extends MovieClip {
		private var storage:Storage;
		private var mainItem:MovieClip;
		private var bufferBg:BufferTracer;
		private var closeBtn:CloseBtnRelated;
		private var bfTime:TextField;
		private var bfLength:TextField;
		private var states:TextField;
		private var currentBitrate:TextField;

		private var maxBytes:TextField;
		private var dropedFrames:TextField;

		private var Width:Number = 230;
		private var Hight:Number = 20;
		private var Yspace:Number = 0;
		private var xpos:Number = 5;
		private var ypos:Number = Yspace;
		private var isCreated:Boolean = false;
		private var netStream:NetStream;
		private var netConn:NetConnection;
		private var timer:Timer;
		private var keycountBF:Number = 0;
		private var BFPressed:Number = 0;
		private var currentBW:Number = 0;
		private var currVideo:Number = 0;
		private var netStateInfo:String="NetStream Info: Waiting for play start...";
		private var currentBitInfo:Number;

		private var statusMsg:String = "";

		private static var instance:BufferStatus;
		public static function getInstance():BufferStatus {
			if (instance == null) {
				instance = new BufferStatus();
				instance.initBufferStatus();
			}
			return instance;
		}

		public function initBufferStatus():void {
			storage = Storage.getInstance();
			this.addChild(createMainItem());
			netStream = storage.getNetStream();
		}

		public function setStatus(setId:String):void {
			statusMsg = setId;
		}

		public function setNetStateInfo(setId:String):void {
			netStateInfo = setId;
		}

		public function getNetStateInfo():String {
			return netStateInfo;
		}

		public function setCurrentBitrate(setId:Number):void {
			currentBitInfo = setId;
		}


		public function setSpeed(setId:Number):void {
			currentBW = setId;
		}
		public function setCurrentVideo(setId:Number):void {
			currVideo = setId;
		}
		public function setNetStream(setId:NetStream):void {// Look it into main VideoStream class 
			netStream = setId;
		}
		private function startTimer():void {
			if (netStream != null) {
				timer = new Timer(100);
				timer.addEventListener(TimerEvent.TIMER, netStreamBuffer, false, 0, true);
				timer.start();
			} else {
				trace("NetStream null found");
			}
		}
		
		private function netStreamBuffer(event:TimerEvent):void {
			if (netStream != null) {
				try {
					bfLength.text = "Buffer Length :  " + netStream.bufferLength;
					bfTime.text = "Buffer Time :   " + netStream.bufferTime;
					var main:String = storage.getFileUrl();
					var mainsubstr:String = main.substr(0, 10);
					var max:Number = Math.round((netStream.info.maxBytesPerSecond)*8/1024);
					var temp:String = "";
					if(mainsubstr.indexOf("rtmp")!=-1){
						if(netStream.time==0){
						temp = (max>0)? String(max+" kbps"): "Waiting for play start...";
						}else{
							temp = (max>0)? String(max+" kbps"): "Detecting please wait....";
						}
					}else{
						temp = "Http URL found!"
					}
					var dsAvail:Boolean = (storage.getQualityFile().length>1)? true:false;
					maxBytes.text = "Max Bandwidth : "+temp;
					var cb:String = "";
					if(dsAvail){
						cb = storage.getCurrentQuality();
					}else{
						cb = "Default Bitrate found"
					}
					dropedFrames.text = "Current Bitrate : "+ cb;
					currentBitrate.text =netStateInfo;
					states.text = "Installed FLP Version : "+storage.getFLPVersion();
					//trace("Maximum kbps = "+max)
					//maxBytes.text="Currently playing : "+selectedVideo(selectedUrl);
					/*if(currBandW>0){
					dropedFrames.text="Available Bandwidth :  "+currBandW+" kbps";
					}else{
					
					if(selectedUrl==1){
					dropedFrames.text="No need to check bandwidth";
					}else{
					dropedFrames.text="Requesting bandwidth please wait....";
					}
					}
					
					*/
				} catch (error:Error) {
					trace("Error found");
				}
			}
		}
		private function selectedVideo(setId:Number):String {
			var str:String;
			if (setId == 0) {
				str = "Medium Quality";
			} else {
				str = "High Quality";
			}
			return str;
		}


		public function keyEvent(keyEvent:KeyboardEvent):void {
			var shift:Boolean = Boolean(keyEvent.shiftKey);
			var ctrl:Boolean = Boolean(keyEvent.ctrlKey);
			if (isCreated && keyEvent.type == "keyDown") {
				deletBufferStatus();
			}
			if (ctrl) {
				BFPressed = 0;
				keycountBF = 0;
			}

			if (keyEvent.shiftKey == true && ctrl == false) {

				if (keyEvent.keyLocation == 0) {
					if (BFPressed < 4) {
						trace("Updating.....")
						BFPressed++;
						keycountBF += Number(keyEvent.keyCode);
						if (keycountBF==207) {
							trace("Key found ............");
							BFPressed=0;
							keycountBF=0;
							toggleViews();
						} else {
							trace("Key not found")
							trace(keycountBF);
						}
					} else {
						//trace("Update Finish")
						BFPressed=0;
						keycountBF=0;
					}
				}
			}
		}
		private function createCloseButton():MovieClip {
			closeBtn = new CloseBtnRelated();
			closeBtn.addEventListener(MouseEvent.ROLL_OVER, rollover, false, 0, true);
			closeBtn.addEventListener(MouseEvent.ROLL_OUT, rollout, false, 0, true);
			closeBtn.addEventListener(MouseEvent.CLICK, deleteBuffer, false, 0, true);
			closeBtn.over.gotoAndStop(1);
			closeBtn.buttonMode=true;
			return closeBtn;
		}

		private function createMainItem():MovieClip {
			mainItem = new MovieClip();
			return mainItem;
		}
		public function toggleViews():void {
			if (!isCreated) {
				createBufferStatus();
			} else {
				deletBufferStatus();
			}
		}

		public function getBFStatues():Boolean {
			return isCreated;
		}
		public function createBufferStatus():void {
			netStream = storage.getNetStream();
			if (! isCreated&&netStream!=null) {
				isCreated=true;
				mainItem.addChild(createBg());
				mainItem.addChild(createBfLength());
				mainItem.addChild(createBfTime());
				mainItem.addChild(createCloseButton());
				mainItem.addChild(createMaxBytes());
				mainItem.addChild(createDropedFrames());
				mainItem.addChild(createBitrate());
				mainItem.addChild(createStatus());
				resetPosition();
				startTimer();
			}else{
				trace("false..........")
			}
		}

		public function resetPosition():void {
			closeBtn.x=bufferBg.width-closeBtn.width;
			closeBtn.y=bufferBg.y-closeBtn.height;
			bfLength.x=xpos;
			bfLength.y=ypos;
			bfTime.x=xpos;
			bfTime.y=bfLength.y+bfLength.height+Yspace;
			maxBytes.y=bfTime.y+bfTime.height+Yspace;
			maxBytes.x=xpos;
			dropedFrames.y=maxBytes.y+maxBytes.height+Yspace;
			dropedFrames.x=xpos;
			
			currentBitrate.y=dropedFrames.y+currentBitrate.height+Yspace;
			currentBitrate.x=xpos;
			
			states.y = currentBitrate.y+states.height+Yspace;
			states.x = xpos;
			this.y=closeBtn.height+5;
			this.x=5;
		}

		public function deletBufferStatus():void {// Please look it in Log view 
			timer.removeEventListener(TimerEvent.TIMER, netStreamBuffer);
			if (isCreated) {
				while (mainItem.numChildren) {
					mainItem.removeChildAt(0);
				}
				isCreated=false;
			}
		}

		public function deleteBuffer(event:MouseEvent):void {
			deletBufferStatus();
		}

		public function createBg():MovieClip {
			bufferBg = new BufferTracer();
			return bufferBg;
		}

		public function createBfTime():TextField {
			bfTime=createTextFiled(Width,Hight);
			bfTime.text="";
			return bfTime;
		}

		public function createBfLength():TextField {
			bfLength=createTextFiled(Width,Hight);
			bfLength.text="";
			return (bfLength);
		}
		public function createBitrate():TextField {
			currentBitrate=createTextFiled(Width,Hight);
			currentBitrate.text="Current bit rate is ";
			return (currentBitrate);
		}





		public function createMaxBytes():TextField {
			maxBytes=createTextFiled(Width,Hight);
			maxBytes.text="";
			return (maxBytes);
		}

		public function createDropedFrames():TextField {
			dropedFrames=createTextFiled(Width,Hight);
			dropedFrames.text="";
			return (dropedFrames);
		}
		public function createStatus():TextField {
			states=createTextFiled(Width,Hight);
			states.text="Status.......";
			return (states);
		}

		private function createTextFiled(wdth:Number, hight:Number):TextField {
			var myText:TextField = new TextField();
			myText.width=wdth;
			myText.height=hight;
			myText.selectable=false;
			myText.defaultTextFormat=(createTextFormat());
			return myText;
		}

		private function createTextFormat():TextFormat {
			var myFormat:TextFormat = new TextFormat();
			myFormat.font="Arial";
			myFormat.size=11;
			//myFormat.color=0x005162;
			myFormat.color=0x00CBFF;
			return myFormat;
		}

		private function rollover(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("over");
		}
		private function rollout(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("out");
		}








	}

}