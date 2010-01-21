package sarslib.common.core.utils 
{
	/**
	 * ...
	 * @author sars
	 * @version 1.0
	 */
	public class ObjectUtil
	{
		
		public function ObjectUtil() 
		{
			
		}
		public static function eitherType(obj:Object, types:Array = null):Boolean
		{
			if (types.length == 0 || types==null) {
				return true;
			}
			for (var i:int = 0; i < types.length; i++) {
				if (obj as types[i]) {
					return true;
				}
			}
			return false;
		}
	}

}