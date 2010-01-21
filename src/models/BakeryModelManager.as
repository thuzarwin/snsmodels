package models 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.net.URLRequest;
	import models.media.sound.mediator.SoundMediator;
	import models.media.sound.SoundModel;
	import models.pay.mediator.MediatorPayMenu;
	import models.pay.PayModel;
	import models.systemUI.instance.SystemUIAssetName;
	import models.systemUI.mediator.SystemUIMediator;
	import models.systemUI.SystemUIModel;
	import models.utils.AssetsSars;
	import models.utils.ResourceLib;
	import sarslib.common.net.events.LoaderQueueEvent;
	import sarslib.common.net.loader.LoadQueue;
	import sarslib.common.net.loader.struct.LoadQueueElement;
	/**
	 * ...
	 * @author sars
	 */
	public class BakeryModelManager extends ModelManager implements IModelManager
	{
		
		public function BakeryModelManager() 
		{
			
		}
		public static function getInstance():IModelManager {
			if (_instance == null) {
				_instance = new BakeryModelManager();
			}
			return _instance;
		}
		override public function initialize(stage:Stage,systemuiContainer:DisplayObjectContainer):void
		{
			//初始化必要数据
			super.initialize(stage, systemuiContainer);
			//加载各个模块所需资源
			initBakery();
		}
		private function initBakery():void
		{
			var loadQueue:LoadQueue=new LoadQueue();
			loadQueue.addItem(new Loader(), new URLRequest(AssetsSars.soundAssetPath), { name:AssetsSars.soundAssetPath } );
			loadQueue.addItem(new Loader(), new URLRequest(AssetsSars.systemAssetPath), { name:AssetsSars.systemAssetPath } );
			loadQueue.addEventListener(LoaderQueueEvent.ITEM_COMPLETE,onItemComplete);
			loadQueue.addEventListener(LoaderQueueEvent.QUEUE_COMPLETE, onQueueComplete);
			loadQueue.start()
		}
		/*****************************************************************************/
		//							  监听										      /
		/*****************************************************************************/
		private function onItemComplete(event:LoaderQueueEvent):void
		{
			//各个模块资源加载完成后，初始化各个模块
			//TODO --------------可根据需要修改的方法
			var item:LoadQueueElement = event.currentItem as LoadQueueElement;
			if (item == null) {
				return;
			}
			switch(item.params.name) {
				case AssetsSars.soundAssetPath:
					AssetsSars.soundAssets = new ResourceLib(item.loader as Loader);
					SoundModel.getInstance().ready = true;
				break;
				case AssetsSars.systemAssetPath:
					AssetsSars.systemAssets = new ResourceLib(item.loader as Loader);
					//ststem
					var systemView:MovieClip=AssetsSars.systemAssets.getMovieClip(SystemUIAssetName.VIEW)
					systemUIModel.startup(AssetsSars.systemAssets);
					systemUIModel.intializeViewToContainer(systemView, _systemUIContainer,SystemUIMediator);
					//sound
					soundModel.startup(AssetsSars.systemAssets, AssetsSars.soundAssets);
					soundModel.intializeView(systemView,SoundMediator);
					//soundModel.play(SoundInstance.gameMusic);
					//pay
					payModel.startup(AssetsSars.systemAssets);
					payModel.intializeView(systemView,MediatorPayMenu);
					//externalPage
					externalPageModel.startup();
					//gift
					giftBoxModel.startup(AssetsSars.systemAssets);
					giftBoxModel.addGiftToBox(1, 23);
					giftBoxModel.show();
				break;
			}
		}
		private function onQueueComplete(event:LoaderQueueEvent):void
		{
			trace("sound complete");
			var target:LoadQueue = event.target as LoadQueue;
			target.addEventListener(LoaderQueueEvent.ITEM_COMPLETE,onItemComplete);
			target.addEventListener(LoaderQueueEvent.QUEUE_COMPLETE, onQueueComplete);
		}
	}

}