package sarslib.common.net.loader.struct
{
	
	import flash.net.URLRequest;
	/**
	 * 加载队列中元素的
	 * @author sars
	 * @version 1.0
	 */
	public class LoadQueueElement
	{
		
		public var loader:Object;
		public var request:URLRequest;
		public var params:Object;
		
		public function LoadQueueElement(loader:Object, request:URLRequest,params:Object=null)
		{
			this.loader = loader;
			this.request = request;
			this.params = params;
		}
		
	}

}