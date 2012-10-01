package com.knowledgehorizon.videoplayer.assets{

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Buffering extends MovieClip {
		private var drawing:Drawing;
		private var BufferBg:MovieClip;
		private var bufferText:TextField;
		private var textFormate:TextFormat;
		private var percent:Number;
		private var timer:Timer;
		private var netStream:NetStream;
		private var bufferHide:Boolean = false;

		// ==============  Create main item holder =========
		private var ItemHolder:MovieClip;

		//Buffering.getInstance()
		private static var instance:Buffering;
		public static function getInstance():Buffering {
			if (instance == null) {
				instance = new Buffering();
				instance.InitBuffering();
			}
			return instance;
		}

		public function InitBuffering() {
			drawing = new Drawing();
			this.addChild(createItemHolder());
		}

		public function showBuffering(ns:NetStream):void {
			createBuffer();
			bufferHide = true;
			netStream = ns;
			BufferBg.visible = true;
			timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
		}

		public function hideBuffering():void {
			if (bufferHide) {
				bufferHide = false;
				try {
					percent = 0;
					timer.removeEventListener(TimerEvent.TIMER, update);
					BufferBg.visible = false;
					bufferText.text = "";
				} catch (error:Error) {
					trace("Hide buffering = "+error);
				}
			}
		}


		private function createItemHolder():MovieClip {
			ItemHolder = drawing.createHolder();
			return (ItemHolder);
		}

		private function createBuffer():void {
			ItemHolder.addChild(createBufferBg());
			BufferBg.addChild(createBufferText());
		}

		private function createBufferBg():MovieClip {
			BufferBg = new MovieClip();
			BufferBg.graphics.beginFill(0x333333);
			BufferBg.graphics.drawRect(0,0,97, 18);
			BufferBg.alpha = 0.8;
			BufferBg.visible = false;
			return BufferBg;
		}
		private function createBufferText():TextField {
			bufferText = new TextField();
			bufferText.selectable = false;
			bufferText.autoSize = TextFieldAutoSize.LEFT;
			bufferText.defaultTextFormat = createTextFormate();
			return (bufferText);
		}

		private function createTextFormate():TextFormat {
			textFormate = new TextFormat();
			textFormate.font = "Arial";
			textFormate.color = 0xFFFFFF;
			textFormate.size = 11;
			return (textFormate);
		}



		private function update(event:TimerEvent):void {
			try {
				percent = Math.min(Math.round(netStream.bufferLength / netStream.bufferTime * 100),100);
				if (percent > 0 && percent < 100) {
					bufferText.text = "Buffering... " + getPercent(percent) + " %";
				} else {
					hideBuffering();
				}
			} catch (error:Error) {
				trace("Buffering...");
			}
		}

		private function getPercent(per:Number):String {
			var setPer:String = "00";
			if (per > 0) {
				if (per < 10) {
					setPer = "0" + String(per);
				} else {
					setPer = String(per);
				}
			}
			return setPer;
		}




	}
}