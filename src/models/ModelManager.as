package models 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import models.components.PopupWindow;
	import models.external.ExternalPageModel;
	import models.external.interfaces.IExternalPage;
	import models.giftbox.GiftBoxModel;
	import models.giftbox.interfaces.IGiftBoxModel;
	import models.media.interfaces.ISound;
	import models.media.sound.SoundModel;
	import models.pay.interfaces.IPayModel;
	import models.pay.PayModel;
	import models.systemUI.interfaces.ISystemUIModel;
	import models.systemUI.SystemUIModel;
	import models.utils.ClientControl;
	/**
	 * ...
	 * @author sars
	 */
	public class ModelManager extends EventDispatcher implements IModelManager
	{
		protected static var _instance:ModelManager;
		protected var _stage:Stage;
		protected var _systemUIContainer:DisplayObjectContainer;
		public function ModelManager() 
		{
			
		}
		public static function getInstance():IModelManager {
			if (_instance == null) {
				_instance = new ModelManager();
			}
			return _instance;
		}
		public function get stage():Stage
		{
			return _stage;
		}
		/**
		 * 初始化
		 * TODO --------------可根据需要修改的方法
		 */
		public function initialize(stage:Stage,systemuiContainer:DisplayObjectContainer):void
		{
			//初始化必要数据
			_stage = stage
			_systemUIContainer = systemuiContainer;
			ClientControl.client = stage;
			PopupWindow.initialize(stage, stage.stageWidth, stage.stageHeight);
			//加载各个模块所需资源
		}
		public function acceptGift(gift:Object):void
		{
			///系统接收礼物的方法
		}
		public function get soundModel():ISound
		{
			return SoundModel.getInstance()
		}
		public function get externalPageModel():IExternalPage
		{
			return ExternalPageModel.getInstance();
		}
		public function get systemUIModel():ISystemUIModel
		{
			return SystemUIModel.getInstance();
		}
		public function get payModel():IPayModel
		{
			return PayModel.getInstance();
		}
		public function get giftBoxModel():IGiftBoxModel
		{
			return GiftBoxModel.getInstance();
		}
		
		
	}
}