package models 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import models.media.sound.instance.SoundInstance;
	import models.media.sound.mediator.SoundMediator;
	import models.media.sound.SoundModel;
	import models.pay.mediator.MediatorPayMenu;
	import models.systemUI.instance.SystemUIAssetName;
	import models.systemUI.mediator.SystemUIMediator;
	import models.utils.AssetsSars;
	import models.utils.ResourceLib;
	import net.topzilla.tinytown.Assets;
	/**
	 * ...
	 * @author sars
	 */
	public class TinyTownModelManager extends ModelManager implements IModelManager
	{
		
		public function TinyTownModelManager() 
		{
			
		}
		public static function getInstance():IModelManager {
			if (_instance == null) {
				_instance = new TinyTownModelManager();
			}
			return _instance;
		}
		override public function initialize(stage:Stage,systemuiContainer:DisplayObjectContainer):void
		{
			super.initialize(stage, systemuiContainer);
			//加载各个模块所需资源
				initTinyTown();
		}
		private function initTinyTown():void
		{
			AssetsSars.soundAssets = new ResourceLib(Assets.soundAssets.loader);
			AssetsSars.systemAssets = new ResourceLib(Assets.systemAssets.loader);
			SoundModel.getInstance().ready = true;
			//ststem
			var systemView:MovieClip=AssetsSars.systemAssets.getMovieClip(SystemUIAssetName.VIEW)
			systemUIModel.startup(AssetsSars.systemAssets);
			systemUIModel.intializeViewToContainer(systemView, _systemUIContainer,SystemUIMediator);
			//sound
			soundModel.startup(AssetsSars.systemAssets, AssetsSars.soundAssets);
			soundModel.intializeView(systemView,SoundMediator);
			soundModel.play(SoundInstance.gameMusic);
			//pay
			payModel.startup(AssetsSars.systemAssets);
			payModel.intializeView(systemView,MediatorPayMenu);
			//externalPage
			externalPageModel.startup();
			//gift
			giftBoxModel.startup(AssetsSars.systemAssets);
			giftBoxModel.addGiftToBox(1, 23);
			giftBoxModel.show();
		}
	}

}