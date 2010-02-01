package models.giftbox
{
	import models.components.core.BaseModel;
	import models.giftbox.command.GiftBoxCommand;
	import models.giftbox.events.GiftBoxEvent;
	import models.giftbox.interfaces.IGiftBoxModel;
	import models.giftbox.proxy.GiftBoxData;
	import models.giftbox.proxy.struct.GiftStruct;
	import models.media.interfaces.ISound;
	import models.utils.ResourceLib;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * ...
	 * @author sars
	 */
	public class GiftBoxModel extends BaseModel implements IGiftBoxModel
	{
		private static var instance:GiftBoxModel
		public function GiftBoxModel() 
		{
			
		}
		public static function getInstance():IGiftBoxModel
		{
			if (instance == null) {
				instance = new GiftBoxModel();
			}
			return instance;
		}
		public function startup(assets:ResourceLib):void
		{
			trace("startup giftbox");
			_assets = assets;
			Facade.getInstance().registerProxy(new GiftBoxData());
			Facade.getInstance().registerCommand(GiftBoxEvent.ADD_GIFT_TO_BOX, GiftBoxCommand);
			Facade.getInstance().registerCommand(GiftBoxEvent.SHOW_GIFT_BOX, GiftBoxCommand);
			Facade.getInstance().registerCommand(GiftBoxEvent.ACCEPT_GIFT, GiftBoxCommand);
		}
		public function addGiftToBox(...arguments):void
		{
			for each(var i:* in arguments) {
				Facade.getInstance().sendNotification(GiftBoxEvent.ADD_GIFT_TO_BOX, i);
			}
			
		}
		public function show():void
		{
			Facade.getInstance().sendNotification(GiftBoxEvent.SHOW_GIFT_BOX);
		}
		public function acceptGift(gift:Object):void
		{
			Facade.getInstance().sendNotification(GiftBoxEvent.ACCEPT_GIFT, gift);
		}
	}

}