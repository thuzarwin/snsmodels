package models 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import models.external.interfaces.IExternalPage;
	import models.giftbox.interfaces.IGiftBoxModel;
	import models.media.interfaces.ISound;
	import models.pay.interfaces.IPayModel;
	import models.systemUI.interfaces.ISystemUIModel;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface IModelManager 
	{
		function initialize(stage:Stage,systemuiContainer:DisplayObjectContainer):void;
		function get stage():Stage;
		function get soundModel():ISound;
		function get externalPageModel():IExternalPage;
		function get systemUIModel():ISystemUIModel;
		function get payModel():IPayModel
		function get giftBoxModel():IGiftBoxModel;
		
	}
	
}