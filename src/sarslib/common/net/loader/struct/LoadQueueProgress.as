package sarslib.common.net.loader.struct
{
	/**
	 * ...
	 * @author sars
	 * @version 1.0
	 */
	public class LoadQueueProgress
	{
		public var byteProgress:Number;
		public var itemProgress:Number;
		public function LoadQueueProgress(byteProgerss:Number=0,itemProgress:Number=0) 
		{
			this.byteProgress = byteProgerss;
			this.itemProgress = itemProgress;
		}
		
	}

}