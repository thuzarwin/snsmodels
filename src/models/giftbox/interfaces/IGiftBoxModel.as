package models.giftbox.interfaces 
{
	import models.components.core.IBaseModel;
	import models.utils.ResourceLib;
	/**
	 * ...
	 * @author sars
	 */
	public interface IGiftBoxModel extends IBaseModel
	{
		
		function startup(assets:ResourceLib):void;
		function addGiftToBox(...arguments):void;
		function show():void;
		function acceptGift(gift:Object):void;
		
	}

}