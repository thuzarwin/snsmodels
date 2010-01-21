package models.systemUI.interfaces
{
	import models.components.core.IBaseModel;
	import models.utils.ResourceLib;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface ISystemUIModel extends IBaseModel
	{
		function startup(assets:ResourceLib):void;
	}
	
}