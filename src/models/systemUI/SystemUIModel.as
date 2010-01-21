package models.systemUI 
{
	import models.components.core.BaseModel;
	import models.systemUI.instance.SystemUIAssetName;
	import models.systemUI.interfaces.ISystemUIModel;
	import models.systemUI.mediator.SystemUIMediator;
	import models.utils.ResourceLib;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * ...
	 * @author sars
	 */
	public class SystemUIModel extends BaseModel implements ISystemUIModel
	{
		protected static var instance:ISystemUIModel;
		public function SystemUIModel() 
		{
			
		}
		public static function getInstance():ISystemUIModel
		{
			if (instance == null) {
				instance = new SystemUIModel();
			}
			return instance as SystemUIModel;
		}
		public function startup(assets:ResourceLib):void
		{
			trace("startup systemUI");
			_assets = assets;
		}
	}

}