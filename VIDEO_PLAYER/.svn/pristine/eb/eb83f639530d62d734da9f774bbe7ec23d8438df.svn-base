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

package com.knowledgehorizon.videoplayer.streaming{
	
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.AsyncErrorEvent;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.controller.*;

	public class NetStreaming {
		// Internal varialbes 
		private var _logView:LogView;
		private var _netStream:NetStream;
		
		private var _storage:Storage = Storage.getInstance();
		
		public function NetStreaming(_conn:NetConnection) {
			  _logView = LogView.getInstance();
			   _netStream = new NetStream(_conn);
			   _netStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler, false, 0, true);
			   _netStream.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler, false, 0, true);
			   _netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler, false, 0, true);
			   _storage.setNetStream(_netStream);
			   _logView.InsetLogText("NetStreaming........Createing controller ")
				Controller.getInstance();
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("NetStreaming: securityErrorHandler: "+event);
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace("Connect: AsyncErrorEventHandler() "+event.text);
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Connect:ioErrorHandler: "+event);
		}

	}
}