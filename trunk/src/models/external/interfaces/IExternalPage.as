package models.external.interfaces
{
	import models.utils.ResourceLib;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface IExternalPage
	{
		function startup():void
		function showInvitePage():void;
		function showPayPage():void;
	}
	
}