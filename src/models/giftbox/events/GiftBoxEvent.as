package models.giftbox.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author sars
	 */
	public class GiftBoxEvent extends Event
	{
		public static const ADD_GIFT_TO_BOX:String = 'ADD_GIFT_TO_BOX';
		public static const SHOW_GIFT_BOX:String = 'SHOW_GIFT_BOX';
		public static const ACCEPT_GIFT:String = 'ACCEPT_GIFT';
		public var data:*;
		public function GiftBoxEvent(type:String) 
		{
			super(type);
		}
		
	}

}