package models.giftbox.proxy.struct 
{
	/**
	 * ...
	 * @author sars
	 */
	public class GiftStruct
	{
		public var name:String;
		public var num:String;
		public var descript:String;
		public var type:int;
		public var gift:*;
		public function GiftStruct(obj:*) 
		{
			gift = obj;
			/*name = obj["name"];
			num = obj["num"];
			descript = obj["descript"];
			type = obj["type"];
			;*/
		}
		
	}

}