package models.pay.interfaces 
{
	import models.components.core.IBaseModel;
	import models.utils.ResourceLib;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface IPayModel extends IBaseModel
	{
		function startup(assets:ResourceLib):void;
	}
	
}