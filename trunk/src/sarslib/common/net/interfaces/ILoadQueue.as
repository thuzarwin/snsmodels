package sarslib.common.net.interfaces
{
	import flash.net.URLRequest;
	import sarslib.common.net.loader.struct.LoadQueueProgress;
	
	/**
	 * ...
	 * @author sars
	 * @version 1.0
	 */
	public interface ILoadQueue 
	{
		/**
		 * 获取加载队列的任务数
		 */
		function get numItems():int
		/**
		 * 获取当前加载的索引
		 */
		function get currentItemIndex():int
		
		/**
		 * 获取当前正在加载的对象
		 */
		function get currentLoader():Object
		/**
		 * 获取当前正在加载对象的URLRequest
		 */
		function get currentURLRequest():URLRequest
		/**
		 * 获取当前正在加载对象的扩展参数
		 */
		function get currentParams():Object
		/**
		 * 获取当前正在加载对象的路径
		 */
		function get currentPath():String
		/**
		 * Returns the overall progress of the loader queue.
		 * Progress of 0 means that nothing has loaded. Progress of 1 means that all the items are fully loaded
		 */
		function get progress():LoadQueueProgress
		/**
		 * 添加加载对象
		 * @param	loader
		 * @param	request
		 * @param	descript
		 */
		function addItem(loader:Object, request:URLRequest,params:Object=null):void
		
		/**
		 * 开始加载
		 */
		function start():void
		
	}
	
}