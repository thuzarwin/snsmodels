package 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import models.IModelManager;
	import models.BakeryModelManager;
	import models.pay.proxy.PayData;
	import sarslib.common.net.events.LoaderQueueEvent;
	import sarslib.common.net.loader.LoadQueue;
	
	/**
	 * ...
	 * @author sars
	 */
	public class Main extends Sprite 
	{
		public var model:IModelManager;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			model = BakeryModelManager.getInstance();
			model.initialize(this.stage,this.stage);
			
		}
		
	}
	
}