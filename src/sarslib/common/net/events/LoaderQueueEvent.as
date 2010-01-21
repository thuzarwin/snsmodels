package sarslib.common.net.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author sars
	 * @version 1.0
	 */
	public class LoaderQueueEvent extends Event 
	{
		public static const ITEM_COMPLETE:String = "itemComplete";
		public static const QUEUE_COMPLETE:String = "queueComplete";
		public var currentItem:Object
		public function LoaderQueueEvent(type:String,currentItem:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.currentItem=currentItem
			
		} 
		
		public override function clone():Event 
		{ 
			return new LoaderQueueEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LoaderQueueEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}