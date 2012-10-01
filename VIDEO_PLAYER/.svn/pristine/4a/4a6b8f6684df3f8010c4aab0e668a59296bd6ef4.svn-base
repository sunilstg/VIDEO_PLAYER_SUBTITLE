package com.knowledgehorizon.videoplayer.external{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.system.System;
	import com.knowledgehorizon.videoplayer.modal.*;
	
	
	public class LogView extends MovieClip {
		private var baseMovie:MovieClip;
		private var baseBg:MovieClip;
		private var scrollBar:MovieClip;
		private var scrollBg:MovieClip;
		private var closeBtn:CloseInfoButton;
		private var topBtn:ButtonUp;
		private var bottomBtn:ButtonDown;
		private var dragBg:MovieClip;
		private var thumbDrag:Thumb;
		private var logText:TextField;
		private var headText:TextField;
		private var textFormate:TextFormat;
		private var headFormat:TextFormat;
		private var top:Number;
		private var bottom:Number;
		private var rectBound:Rectangle;

		private var logVisible:Boolean = false;
		private var sw:Number = Storage.getInstance().getStageWidth();
		private var sh:Number = Storage.getInstance().getStageHeight();
		//private var sw:Number = Storage.getInstance().getStageWidth();
		//private var sh:Number = Storage.getInstance().getStageHeight();


		private var w_width:Number;
		private var w_height:Number;
		private var xpos:Number;
		private var ypos:Number;
		private var scrolling:Boolean;
		private var draging:Boolean;
		private var scrollInterval:Number;
		private var maxScroll:Number;
		private var minScroll:Number;
		private var bufferState:MovieClip;
		private var copyBtn:CopyButton;



		private static var instance:LogView;
		public static function getInstance():LogView {
			if (instance == null) {
				instance = new LogView();
				instance.InitLogText();
			}
			return instance;
		}

		public function InitLogText() {
			baseMovie = new MovieClip();
			addChild(baseMovie);
			resetWindow(sw, sh);
			baseMovie.addChild(createBaseBg());
			baseMovie.addChild(createCloseButton());
			baseMovie.addChild(createHeadText());
			baseMovie.addChild(createCopyButton());
			baseMovie.addChild(createLogText());
			baseMovie.addChild(createScrollBar());
			baseMovie.addChild(createBufferState());
			scrollBar.addChild(createBgScrollBar());
			scrollBar.addChild(createTopButton());
			scrollBar.addChild(createBottomButton());
			scrollBar.addChild(createDgargBg());
			scrollBar.addChild(createThumb());
			resetLogWindow();
		}



		private function copyText(e:MouseEvent):void {
			logText.setSelection(0, logText.text.length);
			System.setClipboard(logText.text);
		}

		private function createBufferState():MovieClip {
			bufferState = new MovieClip();
			return bufferState;
		}

		private function createCopyButton():MovieClip {
			copyBtn = new CopyButton();
			copyBtn.buttonMode = true;
			copyBtn.addEventListener(MouseEvent.ROLL_OVER, RollOver);
			copyBtn.addEventListener(MouseEvent.ROLL_OUT, RollOut);
			copyBtn.addEventListener(MouseEvent.CLICK, copyClipBoard);
			return (copyBtn);
		}

		private function RollOver(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("over");
		}
		private function RollOut(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("out");
		}
		private function copyClipBoard(event:MouseEvent):void {
			copyText(event);
		}







		public function InsetLogText(str:String):void {
			logText.htmlText += String(str);
			//logText.defaultTextFormat=createTextFormat();
		}

		public function addLogView():MovieClip {
			return baseMovie;
		}

		public function resetLogWindow():void {
			sw=Storage.getInstance().getStageWidth();
			sh=Storage.getInstance().getStageHeight();
			if(sw<640){
				sw = 640;
			}
			if(sh<360){
				sh = 360;
			}
			resetWindow(sw, sh);
			//trace(sw,sh)
			baseBg.width=Math.round(w_width);
			baseBg.height=Math.round(w_height);
			headText.width=Math.round(baseBg.width-70);
			closeBtn.x=Math.round(baseBg.width-closeBtn.width-2);
			copyBtn.x=closeBtn.x-copyBtn.width-20;
			copyBtn.y=2;
			logText.width=Math.round(baseBg.width-20);
			logText.height=Math.round(baseBg.height-23);
			logText.y=20;
			logText.x=2;
			scrollBg.height=Math.round(logText.height);
			bottomBtn.y=Math.round(scrollBg.height-bottomBtn.height);
			scrollBar.x=Math.round(logText.width+logText.x+2);
			scrollBar.y=Math.round(logText.y);
			dragBg.height = Math.round(bottomBtn.y-(topBtn.height+topBtn.y));
			dragBg.y=Math.round(topBtn.height+topBtn.y);
			dragBg.x=1;
			ScrollPreSet();
			baseMovie.visible=false;
			//bufferState.x =baseBg.width-242
			//bufferState.y =15;
			resetXYPos(sw, sh);
		}

		public function resetWindow(sw:Number, sh:Number):void {
			if (sw>450) {
				w_width=sw-100;
			} else {
				w_width=sw-10;
			}
			if (sh>250) {
				w_height=sh-100;
			} else {
				w_height=sh-50;
			}
		}

		public function resetXYPos(sw:Number, sh:Number):void {
			if (sw>450) {
				xpos = (sw-baseMovie.width)/2;
			} else {
				xpos=5;
			}
			if (sh>250) {
				ypos = ((sh-baseMovie.height-60)/2);
			} else {
				ypos=5;
			}
			baseMovie.x=xpos;
			baseMovie.y=ypos;
		}

		public function FullScreen(sw:Number, sh:Number):void {
			if (sw>450) {
				xpos = (sw-baseMovie.width)/2;
			} else {
				xpos=5;
			}
			if (sh>250) {
				ypos = ((sh-baseMovie.height)/2);
			} else {
				ypos=5;
			}
			baseMovie.x=xpos;
			baseMovie.y=ypos;
		}


		private function ScrollPreSet():void {
			minScroll=thumbDrag.y;
			maxScroll = minScroll+(dragBg.height-thumbDrag.height)+8;
			scrollInterval=maxScroll-minScroll;
			draging=false;
			scrolling=false;
			logText.addEventListener(Event.SCROLL,updateScrollHandler);
		}

		private function checkingProgress(event:Event):void {
			var moveDrag:Number=thumbDrag.y-minScroll;
			var procentDrag=moveDrag/scrollInterval;
			if (draging) {
				logText.scrollV=procentDrag*logText.maxScrollV;
			}
		}

		private function updateScrollHandler(event:Event):void {
			scrolling=true;
			thumbDrag.y =minScroll +(logText.scrollV*scrollInterval/logText.maxScrollV);
			if (logText.scrollV==logText.maxScrollV) {
				thumbDrag.y=maxScroll;
			} else if (logText.scrollV == 1) {
				thumbDrag.y=minScroll;
			}
		}

		private function createThumb():MovieClip {
			thumbDrag = new Thumb();
			thumbDrag.buttonMode=true;
			thumbDrag.y=topBtn.y+topBtn.height-4;
			thumbDrag.x=1;
			thumbDrag.addEventListener(MouseEvent.ROLL_OVER, overBtn);
			thumbDrag.addEventListener(MouseEvent.ROLL_OUT, outBtn);
			thumbDrag.addEventListener(MouseEvent.MOUSE_DOWN, startDrager);
			thumbDrag.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			return (thumbDrag);
		}

		public function startDrager(event:MouseEvent):void {
			rectBound=new Rectangle(1,topBtn.y+topBtn.height-4,0,bottomBtn.y-thumbDrag.height-1);
			thumbDrag.startDrag(false, rectBound);
			draging=true;
			scrolling=false;
			thumbDrag.addEventListener(Event.ENTER_FRAME,checkingProgress);
			logText.removeEventListener(Event.SCROLL,updateScrollHandler);
		}

		private function endDrag(event:MouseEvent):void {
			stgEnd();
		}
		public function stgEnd():void {
			thumbDrag.stopDrag();
			draging=false;
			logText.addEventListener(Event.SCROLL,updateScrollHandler);
		}

		private function btnUpPress(event:MouseEvent):void {
			//thumbDrag.y =minScroll +(logText.scrollV*scrollInterval/logText.maxScrollV);
		}
		private function btnDownPress(event:MouseEvent):void {
			//thumbDrag.addEventListener(Event.ENTER_FRAME,checkingProgress);
			//thumbDrag.y++//minScroll +(logText.scrollV*scrollInterval/logText.maxScrollV);
		}

		private function createDgargBg():MovieClip {
			dragBg = new MovieClip();
			dragBg.graphics.beginFill(0x000000);
			dragBg.graphics.drawRect(0,0,12,100);
			dragBg.visible=false;
			return dragBg;
		}

		private function createBottomButton():MovieClip {
			bottomBtn = new ButtonDown();
			//bottomBtn.buttonMode=true;
			//bottomBtn.addEventListener(MouseEvent.ROLL_OVER, overBtn);
			//bottomBtn.addEventListener(MouseEvent.ROLL_OUT, outBtn);
			//bottomBtn.addEventListener(MouseEvent.MOUSE_DOWN, btnDownPress)
			bottomBtn.x=1;
			bottomBtn.y=scrollBg.height-bottomBtn.height;
			return (bottomBtn);
		}

		private function overBtn(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("over");
		}
		private function outBtn(event:MouseEvent):void {
			event.currentTarget.over.gotoAndPlay("out");
		}


		private function createTopButton():MovieClip {
			topBtn = new ButtonUp();
			topBtn.buttonMode=true;
			//topBtn.addEventListener(MouseEvent.ROLL_OVER, overBtn);
			//topBtn.addEventListener(MouseEvent.ROLL_OUT, outBtn);
			topBtn.x=1;
			return (topBtn);
		}

		private function createBgScrollBar():MovieClip {
			scrollBg = new MovieClip();
			scrollBg.graphics.beginFill(0x000000);
			scrollBg.graphics.drawRect(0,0,14, 100);
			return (scrollBg);
		}

		private function createScrollBar():MovieClip {
			scrollBar = new MovieClip();
			scrollBar.x=logText.width+logText.x+2;
			scrollBar.y=logText.y;
			return scrollBar;
		}

		private function createBaseBg():MovieClip {
			baseBg = new MovieClip();
			baseBg.graphics.beginFill(0x000000);
			baseBg.graphics.drawRect(0,0,400, 200);
			return (baseBg);
		}

		private function createLogText():TextField {
			logText = new TextField();
			logText.defaultTextFormat=createTextFormat();
			logText.selectable=true;
			logText.wordWrap=true;
			logText.multiline=true;
			logText.border=true;
			logText.background=true;
			logText.width=baseBg.width-20;
			logText.height=baseBg.height-18;
			logText.mouseWheelEnabled=true;
			logText.y=15;
			logText.x=2;
			logText.alwaysShowSelection=true;
			//logText.addEventListener(MouseEvent.CLICK, copyText);
			return logText;
		}

		private function createHeadText():TextField {
			headText = new TextField();
			headText.defaultTextFormat=createHeadFormat();
			//headText.autoSize =TextFieldAutoSize.LEFT;
			headText.multiline=false;
			headText.border=true;
			//headText.background = true;
			headText.width=baseBg.width-70;
			headText.height=17;
			headText.y=baseBg.y;
			headText.x=baseBg.x;
			headText.mouseEnabled=false;
			headText.htmlText="<b>\tKH Video Player ActionScript 3.0";
			return headText;
		}

		private function createTextFormat():TextFormat {
			textFormate = new TextFormat();
			textFormate.font="Arial";
			textFormate.color=0x000000;
			textFormate.size=11;
			return textFormate;
		}

		private function createHeadFormat():TextFormat {
			headFormat = new TextFormat();
			headFormat.font="Arial";
			headFormat.color=0xFFFFFF;
			headFormat.size=11;
			return headFormat;
		}

		private function createCloseButton():MovieClip {
			closeBtn = new CloseInfoButton();
			closeBtn.buttonMode=true;
			closeBtn.x=baseBg.width-closeBtn.width-2;
			closeBtn.addEventListener(MouseEvent.CLICK, closeLog);
			closeBtn.y=2;
			return closeBtn;
		}

		private var keyCount:Number=0;
		private var pressTime:Number=0;
		public function ToggleLogView(keyEvent:KeyboardEvent):void {
			var shift:Boolean=Boolean(keyEvent.shiftKey);
			var ctrl:Boolean=Boolean(keyEvent.ctrlKey);
			if (keyEvent.keyCode==32&&logVisible){
				toggleView();
			}
			if (shift&&ctrl) {
				if (keyEvent.keyLocation==0) {
					if (pressTime<4) {
						pressTime++;
						keyCount+=Number(keyEvent.keyCode);
						trace(keyEvent.keyCode)
						if (keyCount==207) {
							pressTime=0;
							keyCount=0;
							toggleView();
						} else {
							//trace(keyCount);
						}

					} else {
						pressTime=0;
						keyCount=0;
					}

				}
			}
		}
		
		private function closeLog(event:MouseEvent):void {
			toggleView();
		}
		private function toggleView():void {
			pressTime=0;
			keyCount=0;
			//logMovie.x = (Storage.getInstance().getStageWidth()-logMovie.width)/2
			//logMovie.y = ( Storage.getInstance().getStageHeight()-logMovie.height)/2
			if (logVisible) {
				logVisible=false;
				baseMovie.visible=false;
				//BufferStatus.getInstance().deletBufferStatus();
			} else {
				logVisible=true;
				baseMovie.visible=true;
				//BufferStatus.getInstance().createBufferStatus();
			}
		}




	}
}