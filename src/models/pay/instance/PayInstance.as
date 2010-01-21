package models.pay.instance
{
	import models.pay.proxy.struct.PayTypeStruct;
	/**
	 * ...
	 * @author sars
	 */
	public class PayInstance
	{
		
		public function PayInstance() 
		{
		}
		public static function get PayPal():PayTypeStruct
		{
			var data:PayTypeStruct = new PayTypeStruct();
			data.logoFrame = 1;
			data.selectPriceText = "";
			data.selectTypeText = "Pay using";
			data.type = "PayPal";
			return data;
		}
		public static function get Visa():PayTypeStruct
		{
			var data:PayTypeStruct = new PayTypeStruct();
			data.logoFrame = 6;
			data.selectPriceText = "";
			data.selectTypeText = "Pay by Credit Card";
			data.type = "Visa";
			return data;
		}
	}

}