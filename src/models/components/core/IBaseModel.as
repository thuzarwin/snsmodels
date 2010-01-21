package models.components.core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import models.utils.ResourceLib;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface IBaseModel
	{
		function intializeView(view:DisplayObject, mediatorClass:Class):void ;
		
		function intializeAssetsView(assetsName:String, mediatorClass:Class):void ;
		
		function intializeViewToContainer(view:DisplayObject, container:DisplayObjectContainer, mediatorClass:Class):void;
		
		function intializeAssetsViewToContainer(assetsName:String, container:DisplayObjectContainer, mediatorClass:Class):void;
		
		function get assets():ResourceLib;
		
		function set assets(assets:ResourceLib):void;
		
	}
	
}