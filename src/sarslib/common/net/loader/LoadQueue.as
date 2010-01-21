package sarslib.common.net.loader 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import sarslib.common.core.utils.ObjectUtil;
	import sarslib.common.net.events.LoaderQueueEvent;
	import sarslib.common.net.interfaces.ILoadQueue;
	import sarslib.common.net.loader.struct.LoadQueueElement;
	import sarslib.common.net.loader.struct.LoadQueueProgress;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name = "securityError", type = "flash.events.SecurityErrorEvent")]
	[Event(name = "itemComplete", type = "sarslib.common.net.events.LoaderQueueEvent")]
	[Event(name = "queueComplete", type = "sarslib.common.net.events.LoaderQueueEvent")]
	/**
	 * 加载队列类。
	 * 改编于away3dlite.loaders.utils.TextureLoaderQueue
	 * @author sars
	 * @version 1.0
	 */
	public class LoadQueue extends EventDispatcher implements ILoadQueue
	{
		
		protected var _start:Boolean = false;
		protected var _queue:Array;
		protected var _currentItemIndex:int;
		public function LoadQueue() 
		{
			_queue = [];
		}
		protected function redispatchEvent(e:Event):void
		{
			dispatchEvent(e);
		}
		
		protected function onItemComplete(e:Event):void
		{
			dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.ITEM_COMPLETE,currentItem));
			var loader:EventDispatcher = getListenerObject(currentLoader) as EventDispatcher;
			loader.removeEventListener(Event.COMPLETE, onItemComplete);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, redispatchEvent);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, redispatchEvent);
			loader.removeEventListener(ProgressEvent.PROGRESS, redispatchEvent);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, redispatchEvent);
			_currentItemIndex++;
			loadNext();
		}
		/**
		 * 加载下一个对象
		 */
		protected function loadNext():void
		{
			if (_currentItemIndex >= numItems) {
				_start = false;
				dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.QUEUE_COMPLETE,currentItem));
			}else {
				var loader:EventDispatcher = getListenerObject(currentLoader)as EventDispatcher;
				if (loader == null) {
					loadNext();
					return;
				}
				if(loader["bytesLoaded"] > 0 &&loader["bytesLoaded"] == loader["bytesTotal"]){
					loader.dispatchEvent(new Event(Event.COMPLETE));
				}else {
					loader.addEventListener(Event.COMPLETE, onItemComplete, false, int.MIN_VALUE);
					loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, redispatchEvent);
					loader.addEventListener(IOErrorEvent.IO_ERROR, redispatchEvent);
					loader.addEventListener(ProgressEvent.PROGRESS, redispatchEvent);
					loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, redispatchEvent);
					currentLoader.load(currentURLRequest);
				}
			}
		}
		/**
		 * 获取当前加载的数据的进度
		 * @return
		 */
		protected function calcCurrentLoaderAmountLoaded():Number
		{
			var loader:Object = getListenerObject(currentLoader);
			if (loader) {
				if(loader.bytesLoaded > 0){
					return loader.bytesLoaded / loader.bytesTotal;
				}
				return 0;
			}
			return 0;
		}
		/**
		 * 
		 * @param	item
		 * @return
		 */
		protected function checkObject(item:Object):Boolean 
		{
			if (ObjectUtil.eitherType(item, [URLLoader, Loader])){
				return true
			}else {
				throw new Error("参数必须是Loader或者URLLoader类型");
				return false;
			}
			
		}
		protected function getListenerObject(obj:Object):Object {
			if (obj as URLLoader) {
				return obj;
			}else if (obj as Loader) {
				return ((obj as Loader).contentLoaderInfo);
			}
			return null;
		}
		/**
		 * 获取加载队列的任务数
		 */
		public function get numItems():int
		{
			return _queue.length;
		}
		/**
		 * 获取当前加载的索引
		 */
		public function get currentItemIndex():int
		{
			return _currentItemIndex;
		}
		
		public function get currentItem():LoadQueueElement
		{
			return _queue[_currentItemIndex];
		}
		/**
		 * 获取当前正在加载的对象
		 */
		public function get currentLoader():Object
		{
			return (_queue[currentItemIndex] as LoadQueueElement).loader;
		}
		
		/**
		 * 获取当前正在加载对象的URLRequest
		 */
		public function get currentURLRequest():URLRequest
		{
			return (_queue[currentItemIndex] as LoadQueueElement).request;
		}
		/**
		 * 获取当前正在加载对象的描述
		 */
		public function get currentParams():Object
		{
			return ((_queue[currentItemIndex] as LoadQueueElement).params);
		}
		/**
		 * 获取当前正在加载对象的路径
		 */
		public function get currentPath():String
		{
			return (_queue[currentItemIndex] as LoadQueueElement).request.url;
		}
		
		/**
		 * 返回进度对象
		 */
		public function get progress():LoadQueueProgress
		{
			var pro:LoadQueueProgress = new LoadQueueProgress();
			pro.byteProgress = int(calcCurrentLoaderAmountLoaded()*100);
			pro.itemProgress = currentItemIndex / numItems;
			return pro;
		}
		/**
		 * 添加加载对象到队列
		 * @param	loader URLLoader或者Loader对象
		 * @param	request
		 * @param	descript
		 */
		public function addItem(loader:Object, request:URLRequest, params:Object = null ):void
		{
			if(checkObject(loader)){
				for each (var _item:LoadQueueElement in _queue) {
					if (_item.request.url == request.url)
						return;
				}
				_queue.push(new LoadQueueElement(loader, request, params));
			}
		}
		
		/**
		 * Starts the load queue loading.
		 */
		public function start():void
		{
			trace("loadqueue start");
			if (_start) {
				return;
			}
			_start = true;
			_currentItemIndex = 0;
			loadNext();
		}
		
	}

}