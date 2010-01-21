package models.giftbox.command 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import models.components.PopupWindow;
	import models.giftbox.events.GiftBoxEvent;
	import models.giftbox.GiftBoxModel;
	import models.giftbox.instance.GiftBoxAssetName;
	import models.giftbox.mediator.GiftBoxMediator;
	import models.giftbox.proxy.GiftBoxData;
	import models.giftbox.proxy.struct.GiftStruct;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...礼物事件处理方法
	 * @author sars
	 */
	public class GiftBoxCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void 
		{
			switch(notification.getName()) {
				case GiftBoxEvent.ADD_GIFT_TO_BOX:
					addGiftToBox(notification.getBody() as GiftStruct);
				break;
				case GiftBoxEvent.SHOW_GIFT_BOX:
					showGiftBox();
				break;
				case GiftBoxEvent.ACCEPT_GIFT:
					acceptGift(notification.getBody());
				break;
			}
		}
		/**
		 * 添加礼物数据
		 * @param	gift
		 */
		private function addGiftToBox(gift:GiftStruct):void
		{
			var gifts:Array = (facade.retrieveProxy(GiftBoxData.NAME) as GiftBoxData).gifts;
			gifts.push(gift);
		}
		/**
		 * 显示礼物
		 * 
		 * 
		 */
		//@return 如果礼物列表为空返回false否则返回true
		private function showGiftBox():void
		{
			var gifts:Array = (facade.retrieveProxy(GiftBoxData.NAME) as GiftBoxData).gifts;
			trace(gifts.length);
			if (gifts.length > 0) {
				var gift:GiftStruct = new GiftStruct(gifts[0]);
				var mc:MovieClip = GiftBoxModel.getInstance().assets.getMovieClip(GiftBoxAssetName.VIEW);
				var popup:PopupWindow= new PopupWindow(mc);
				facade.registerMediator(new GiftBoxMediator(mc,gift));
				popup.show();
				gifts.splice(0, 1);
			}
		}
		/**
		 * 接受礼物
		 * @param	gift
		 */
		private function acceptGift(gift:*):void
		{
			trace("accept", gift);
			var event:GiftBoxEvent = new GiftBoxEvent(GiftBoxEvent.ACCEPT_GIFT);
			event.data = gift;
			(GiftBoxModel.getInstance() as EventDispatcher).dispatchEvent(event);
		}
	}

}