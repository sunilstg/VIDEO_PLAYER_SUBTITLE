package com.knowledgehorizon.videoplayer.external{

	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.*;
	import com.knowledgehorizon.videoplayer.assets.*;
	import com.knowledgehorizon.videoplayer.modal.*;
		
	public class PreviewImage extends MovieClip {
		// =========== Class variables ================
		private var drawing:Drawing
		//=========== Internal variables used ============
		private var imgLoader:Loader;
		private var urlRequest:URLRequest;
		private var imageVisible:Boolean = false;
		private var targetLoader:Loader;
		private var autostart:Boolean = false;
		// =========== Main MovieClip;
		private var ItemHolder:MovieClip;
		private var videoState:String;
		private var storage:Storage;
		private var modal:Modal;
		
		
		
		

		private static var instance:PreviewImage;
		public static function getInstance():PreviewImage {
			if (instance == null) {
				instance = new PreviewImage();
				instance.InitLoader();
			}
			return instance;
		}

		public function InitLoader() {
			modal = Modal.getInstance();
			drawing = new Drawing();
			storage = Storage.getInstance();
			this.addChild(createItemHolder());
		}
		public function showPreview():void {
			LoadImage(storage.getImage());
		}

		public function createItemHolder():MovieClip {
			ItemHolder = drawing.createHolder();
			return ItemHolder;
		}
		public function LoadImage(url:String) {
			autostart = storage.getAutoStart()
			if (url != "" && !autostart) {
				try {
					urlRequest = new URLRequest(url);
					imgLoader = new Loader();
					adListeners(imgLoader.contentLoaderInfo);
					imgLoader.load(urlRequest);
				} catch (error:Error) {
					LogView.getInstance().InsetLogText("Preview Image load Error ");
				}
			} else {
				LogView.getInstance().InsetLogText("Preview Image not applicable");
			}
		}

		public function removePreviewImage():void {
			//if (imageVisible) {
				while (ItemHolder.numChildren) {
					ItemHolder.removeChildAt(0);
				}
				imageVisible = false;
			//}
		}

		public function resetPreviewImage():void {
			if (imageVisible){
				storage = Storage.getInstance();
				targetLoader.width = storage.getStageWidth();
				targetLoader.height = (storage.getStageHeight());
			}
		}


		private function loadInit(event:Event):void {
			targetLoader = Loader(event.target.loader);
			targetLoader.width = storage.getStageWidth();
			targetLoader.height = (storage.getStageHeight());
		}
		
		
		

		private function callme(event:MouseEvent):void {
			trace("MouseEvent = "+event);
		}

		private function completeHandler(event:Event):void {
			removeListeners(imgLoader.contentLoaderInfo);
			videoState = modal.getState();
			if (videoState=="stopState") {
				imageVisible = true;
				ItemHolder.addChild(imgLoader);
			}else{
				while (ItemHolder.numChildren) {
					ItemHolder.removeChildAt(0);
				}
			}
		}
		private function openHandler(event:Event):void {
			trace("PreviewImage: openHandler: " + event);
		}
		private function progressHandler(event:ProgressEvent):void {
			//trace("PreviewImage: progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("PreviewImage: securityErrorHandler: " + event);
		}
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			if (event.status == 404) {
				trace("PreviewImage: httpStatusHandler: " + event);
			}
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("PreviewImage: ioErrorHandler: " + event);
		}
		//contentLoaderInfo
		private function adListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.INIT, loadInit);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		private function removeListeners(dispatcher:IEventDispatcher):void {
			dispatcher.removeEventListener(Event.INIT, loadInit);
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}






	}
}