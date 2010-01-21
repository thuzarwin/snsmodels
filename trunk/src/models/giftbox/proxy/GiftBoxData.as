package models.giftbox.proxy 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author sars
	 */
	public class GiftBoxData extends Proxy implements IProxy
	{
		public static const NAME:String = "GiftBoxData";
		public var gifts:Array;
		public function GiftBoxData() 
		{
			super(NAME);
		}
		override public function onRegister():void 
		{
			super.onRegister();
			gifts = [];
		}
	}

}