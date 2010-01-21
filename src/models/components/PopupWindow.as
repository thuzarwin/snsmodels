package models.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author sars
	 */
	public class PopupWindow extends Sprite
	{
		public static var popups:Array;
		public static var activePopups:Array;
		public static var popupContainer:DisplayObjectContainer
		public static var modWidth:Number;
		public static var modHeight:Number;
		public var modLayer:ModalMask;
		public function PopupWindow(content:DisplayObject,mod:Boolean=true) 
		{
			super();
			addChild(content);
			if (mod) {
				modLayer = new ModalMask(modWidth, modHeight);
			}
			this.x = modWidth / 2;
			this.y = modHeight / 2;
		}
		public static function initialize(container:DisplayObjectContainer, w:Number, h:Number):void
		{
			trace(container, w, h);
			popupContainer = container;
			modWidth = w;
			modHeight = h;
			activePopups = [];
			popups = [];
		}
		public function show():void
		{
			if (activePopups.indexOf(this) == -1) {
				if (modLayer) {
					popupContainer.addChild(modLayer);
				}
				popupContainer.addChild(this);
				activePopups.push(this);
			}
		}
		public function remove():void
		{
			if (modLayer) {
				popupContainer.removeChild(modLayer);
			}
			popupContainer.removeChild(this);
			activePopups.splice(activePopups.indexOf(this), 1);
		}
		public function isShown():Boolean
		{
			return activePopups.indexOf(this) != -1;
		}
		public function queueToShow():void
		{
			if (activePopups.length > 0) {
				popups.push(this);
			}else {
				show();
			}
		}
		public function getTopActivePopUp():PopupWindow
		{
			if (activePopups.length == 0)
            {
                return null;
            }
            return activePopups[(activePopups.length - 1)];
		}
	}

}