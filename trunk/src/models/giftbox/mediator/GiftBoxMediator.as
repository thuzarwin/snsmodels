package models.giftbox.mediator 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import models.components.PopupWindow;
	import models.giftbox.events.GiftBoxEvent;
	import models.giftbox.proxy.struct.GiftStruct;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author sars
	 */
	public class GiftBoxMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'GiftMediator';
		public var gift:GiftStruct
		protected var _okBtn:MovieClip;
		public function GiftBoxMediator(viewComponent:DisplayObject,gift:GiftStruct) 
		{
			super(NAME, viewComponent)
			this.gift = gift;
		}
		public function get view():MovieClip 
		{
			return viewComponent as MovieClip;
		}
		override public function onRegister():void 
		{
			super.onRegister();
			_okBtn = view.mc_content.mc_tick;
			_okBtn.stop();
			addBtns();
			ButtonUtil.setButtonMode(_okBtn);
			view.addFrameScript(15, frame15);
			view.addFrameScript(23, frame23);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			(view.parent as PopupWindow).remove();
			_okBtn.addEventListener(MouseEvent.CLICK, onOk);
			sendNotification(GiftBoxEvent.SHOW_GIFT_BOX);
		}
		private function frame15():void
		{
			view.stop();
		}
		private function frame23():void
		{
			facade.removeMediator(NAME);
		}
		protected function addBtns():void
		{
			_okBtn.addEventListener(MouseEvent.CLICK, onOk);
		}
		protected function clearBtns():void
		{
			_okBtn.removeEventListener(MouseEvent.CLICK, onOk);
		}
		protected function onOk(event:MouseEvent):void
		{
			sendNotification(GiftBoxEvent.ACCEPT_GIFT, gift.gift);
			clearBtns();
			view.gotoAndPlay(16);
		}
		
	}

}