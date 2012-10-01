package com.knowledgehorizon.videoplayer.assets{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	public class Drawing {
		
		private var arial:ArialEmbed = new ArialEmbed();
		
		public function Drawing() {
			// Define constructor 
			//trace("Drawing.Drawing()")
			//trace("---------------------------------------------")
		}

		public function createHolder():MovieClip {
			var target:MovieClip = new MovieClip();
			return target;
		}

		public function createGraphics(color:uint, Width:Number, Height:Number):MovieClip {
			var target:MovieClip = new MovieClip();
			target.graphics.beginFill(color);
			target.graphics.drawRect(0,0, Width, Height);
			return target;
		}
		
		public function createTxtField(color:uint, Width:Number, Height:Number):TextField {
			var txtField:TextField = new TextField();
			txtField.defaultTextFormat=createTextFormat(color);
			txtField.embedFonts=true;
			//txtField.autoSize=(position="right")? TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT
			txtField.mouseEnabled=false;
			txtField.autoSize = TextFieldAutoSize.LEFT;
			txtField.x=0;
			txtField.y=0;
			txtField.width=Width;
			txtField.height=Height;
			return txtField;
		}
		
		private function createTextFormat(color:uint):TextFormat {
			var textFormate:TextFormat = new TextFormat();
			textFormate.font=arial.fontName;
			//textFormate.font="Arial";
			textFormate.color=color;//0x00EAFF;
			textFormate.size=12;
			return textFormate;
		}
		
		


	}
}