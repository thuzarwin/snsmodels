package models.components.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import models.utils.ResourceLib;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * ...
	 * @author sars
	 */
	public class BaseModel extends EventDispatcher implements IBaseModel
	{
		protected var _assets:ResourceLib
		public function BaseModel() 
		{
			
		}
		public function intializeView(view:DisplayObject,mediatorClass:Class):void 
		{
			Facade.getInstance().registerMediator(new mediatorClass(view));
		}
		public function intializeAssetsView(assetsName:String,mediatorClass:Class):void 
		{
			var view:DisplayObject = assets.getMovieClip(assetsName);
			Facade.getInstance().registerMediator(new mediatorClass(view));
		}
		public function intializeViewToContainer(view:DisplayObject, container:DisplayObjectContainer,mediatorClass:Class):void
		{
			container.addChild(view);
			Facade.getInstance().registerMediator(new mediatorClass(view));
		}
		public function intializeAssetsViewToContainer(assetsName:String, container:DisplayObjectContainer,mediatorClass:Class):void
		{
			var view:DisplayObject = assets.getMovieClip(assetsName);
			container.addChild(view);
			Facade.getInstance().registerMediator(new mediatorClass(view));
		}
		public function get assets():ResourceLib
		{
			return _assets
		}
		public function set assets(assets:ResourceLib):void
		{
			_assets=assets
		}
	}

}