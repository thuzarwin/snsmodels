﻿package models.external.command 
{
	import flash.external.ExternalInterface;
	import models.external.events.ExternalPageEvent;
	import models.utils.ClientControl;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author sars
	 */
	public class ExternalPageCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			switch(notification.getName()) {
				case ExternalPageEvent.ShowInvitePage:
					showInvitePage();
				break;
				case ExternalPageEvent.ShowPayPage:
					showPayPage();
				break;
				case ExternalPageEvent.STARTUP:
					startup();
				break;
			}
		}
		private function startup():void
		{
			facade.registerCommand(ExternalPageEvent.ShowInvitePage,ExternalPageCommand);
			facade.registerCommand(ExternalPageEvent.ShowPayPage,ExternalPageCommand);
			try{
				ExternalInterface.addCallback("sendToActionScript", sendToActionScript);
			}catch (e:Error) {
				
			}
		}
		private function showInvitePage():void
		{
			ClientControl.disabled();
			try{
				ExternalInterface.call("addInviteFriendsIFrame", true);
			}catch (e:Error) {
				trace(e);
			}
		}
		private function showPayPage():void
		{
			ClientControl.disabled();
			try{
				ExternalInterface.call("addInviteFriendsIFrame", true);
			}catch (e:Error) {
				trace(e);
			}
		}
		private function sendToActionScript(array:Array):void
		{
			switch(array[0]) {
				case "InviteDone":
					ClientControl.enabled();
				break;
				case "InviteStart":
					ClientControl.disabled();
				break;
			}
		}
	}

}