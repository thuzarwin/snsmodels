package models.pay.proxy 
{
	import models.pay.proxy.struct.PayTypeStruct;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author sars
	 */
	public class PayData extends Proxy implements IProxy
	{
		public static const NAME:String = "PayData";
		//支付的价格
		public var price:Number;
		public var payType:PayTypeStruct
		public function PayData() 
		{
			super(NAME);
		}
		override public function onRegister():void 
		{
			super.onRegister();
			price = 0;
			payType = new PayTypeStruct();
		}
	}

}