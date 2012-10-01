/*
 "EK TU HI NIRANKAR - ONE THE FORMLESS ALMIGHTY GOD" 
 
Project Name :KH Video Player
Developer  :  Sunil Kumar 
Started on   :  June 20, 2011
Completed by :  ---
-------------------------------------
Last modified by     : name of developer 
Last modified logic  : details of logic 
*/
package com.knowledgehorizon.videoplayer.streaming{
	import flash.net.NetConnection;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.AsyncErrorEvent;
	import com.knowledgehorizon.videoplayer.external.*;
	import com.knowledgehorizon.videoplayer.modal.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.utility.*;
	import com.knowledgehorizon.videoplayer.controller.*;


	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class NetConnect {
		// Internal varialbes 
		private var _netConn:NetConnection;
		private var _netStream:NetStreaming;
		private var _client:Client;
		private var _storage:Storage;
		private var _time:Number = 500;
		private var _initTimer:Timer;
		private var _bandWidth:Number;
		private var _qualityFileArr:Array;

		public function NetConnect(_conn:String) {
			_storage = Storage.getInstance();
			LogView.getInstance().InsetLogText(":: Createing NetConnection: <b>"+_conn+"</b>");
			//try {
				_client = new Client();
				_netConn = new NetConnection();
				_netConn.connect(_conn);
				_netConn.client = _client;
				_netConn.addEventListener(NetStatusEvent.NET_STATUS, NetStatusHandler, false, 0, true);
				_netConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler, false, 0, true);
				_netConn.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler, false, 0, true);
				_netConn.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler, false, 0, true);
				if (_netConn.connected) {
					InitNetStream();
				}
			/*} catch (error:Error) {
				trace("Error found netConn"+error);
				LogView.getInstance().InsetLogText("<b>OOPS! Error occured in NetConnect Constructor !</b>");
			}*/
		}

		public function NetStatusHandler(event:NetStatusEvent):void {
			trace("================== NetConnect ===============================");
			trace("NetConnect = "+event.info.code);
			LogView.getInstance().InsetLogText("NetConnect = "+event.info.code);
			trace("**************************************************************");
			switch (event.info.code) {
				case "NetConnection.Connect.Success" :
					//InitBWTest();
					InitNetStream();
					break;
				case "NetConnection.Connect.Closed" :
					NetConnError();
					break;
				case "NetConnection.Connect.Failed" :
					NetConnError();
					//StreamController.getInstance().onVideoError();
					break;
				case "NetConnection.Connect.AppShutdown" :
					NetConnError();
					break;
				case "NetConnection.Connect.Rejected" :
					NetConnError();
					break;
			}
		}
		private function NetConnError():void {
			var _showError:ShowError = ShowError.getInstance();
			var _logView:LogView = LogView.getInstance();
			var _errorMessage:ErrorMessage = ErrorMessage.getInstance();
			_logView.InsetLogText(":: <b>NetConnection Error : </b>"+_storage.getNetStreamURL());
			_showError.resetErrorText(_errorMessage.getUnableMsg(), ErrorMessage.NET_CONN_ERROR);
		}
		private function InitNetStream():void {
			LogView.getInstance().InsetLogText("::NetConnection Created : <b>"+_netConn+"; now createing netstream</b>");
			_storage.setNetConnect(_netConn);
			_netStream = new NetStreaming(_netConn);
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("Connect: securityErrorHandler: ");
			trace("connURI ");
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace("Connect: AsyncErrorEventHandler() "+event.text);
			trace("connURI ");
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Connect:ioErrorHandler: ");
			trace("connURI ");
		}

	}
}