package models.external 
{
	import models.external.command.ExternalPageCommand;
	import models.external.events.ExternalPageEvent;
	import models.external.interfaces.IExternalPage;
	import models.utils.ResourceLib;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author sars
	 */
	public class ExternalPageModel implements IExternalPage
	{
		protected static var instance:ExternalPageModel
		public function ExternalPageModel() 
		{
			super();
		}
		public static function getInstance():IExternalPage {
			if (instance == null) {
				instance = new ExternalPageModel();
			}
			return instance as ExternalPageModel;
			
		}
		public function startup():void
		{
			trace("startup externalpage");
			Facade.getInstance().registerCommand(ExternalPageEvent.STARTUP,ExternalPageCommand);
			Facade.getInstance().sendNotification(ExternalPageEvent.STARTUP);
		}
		public function showInvitePage():void
		{
			Facade.getInstance().sendNotification(ExternalPageEvent.ShowInvitePage);
		}
		public function showPayPage():void
		{
			Facade.getInstance().sendNotification(ExternalPageEvent.ShowPayPage);
		}
		public function publishFeedLevelUp(userName:String,level:String):void
		{
			Facade.getInstance().sendNotification(ExternalPageEvent.PublishFeedLevelUp,[userName,level]);
		}
		public function publishFeedDailyReward(userName:String):void
		{
			Facade.getInstance().sendNotification(ExternalPageEvent.PublishFeedLevelUp,[userName]);
		}
	}

}