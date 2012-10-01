package com.knowledgehorizon.videoplayer.utility{

	import flash.display.Sprite;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.events.ContextMenuEvent;
	import flash.display.InteractiveObject;

	public class ContextMenus{
		private var mynewmenu:Array=[];
		private var nccm:ContextMenu=new ContextMenu  ;
		public function ContextMenus(myNewMenu:Array) {
			mynewmenu=myNewMenu;
		}
		public function init(target:InteractiveObject):void {
			nccm.hideBuiltInItems();
			buildMenu();
			target.contextMenu=nccm;
		}
		private function buildMenu():void {
			var i:int=-1;
			var n:int=mynewmenu.length;
			//trace("mynewmenu.length = "+mynewmenu.length);
			while (++i<n) {
				var item:ContextMenuItem=new ContextMenuItem(mynewmenu[i].caption);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,onMenuItemSelect);
				nccm.customItems.push(item);
			}
		}
		
		private function onMenuItemSelect(event:ContextMenuEvent):void {
			var item:ContextMenuItem=ContextMenuItem(event.target);
			var url:String;
			var i:int=mynewmenu.length;
			while (i--) {
				if (mynewmenu[i].caption==item.caption){
					url=mynewmenu[i].url;
					break;
				}
			}
			trace(url);
		}

	}
}