package models.utils 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import models.components.ModalMask;
	/**
	 * ...
	 * @author sars
	 */
	public class ClientControl
	{
		public static var client:Stage;
		public static var width:Number=-1;
		public static var height:Number=-1;
		private static var model:ModalMask;
		public function ClientControl() 
		{
			
		}
		public static function enabled():void
		{
			if (client == null) {
				return;
			}
			if(model){
				try { 
					client.removeChild(model);
				}catch (e:Error) {
					trace(e);
				}
			}
		}
		public static function disabled():void
		{
			if (client == null) {
				return;
			}
			if (model == null) {
				width = width == -1?client.stageWidth:width;
				height = height == -1?client.stageHeight:height;
				model = new ModalMask(width, height);
			}
			client.addChild(model);
		}
	}

}