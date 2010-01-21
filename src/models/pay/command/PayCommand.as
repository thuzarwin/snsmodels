package models.pay.command 
{
	import flash.display.DisplayObject;
	import models.components.PopupWindow;
	import models.external.events.ExternalPageEvent;
	import models.pay.events.PayEvent;
	import models.pay.instance.PayViewAssetName;
	import models.pay.mediator.MediatorPayFirst;
	import models.pay.mediator.MediatorPaySecond;
	import models.pay.mediator.MediatorPayThird;
	import models.pay.PayModel;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author sars
	 */
	public class PayCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			switch(notification.getName()) {
				case PayEvent.PAY_START:
					showFirst();
				break;
				case PayEvent.SHOW_PAY_FIRST:
					showFirst();
				break;
				case PayEvent.SHOW_PAY_SECOND:
					showSecond()
				break;
				case PayEvent.SHOW_PAY_THIRD:
					showThird()
				break;
				case PayEvent.PAY_SUB:
					showPayPage(notification.getBody() as Number);
				break;
			}
		}
		private function showPayPage(money:Number):void
		{
			facade.sendNotification(ExternalPageEvent.ShowPayPage,money);
		}
		private function showFirst():void
		{
			var md:MediatorPayFirst = new MediatorPayFirst(PayModel.getInstance().assets.getMovieClip(PayViewAssetName.FIRST));
			facade.registerMediator(md);
			var pop:PopupWindow = new PopupWindow(md.getViewComponent() as DisplayObject);
			pop.show();
			md.getViewComponent().play();
		}
		private function showSecond():void
		{
			var md:MediatorPaySecond = new MediatorPaySecond(PayModel.getInstance().assets.getMovieClip(PayViewAssetName.SECOND));
			facade.registerMediator(md);
			var pop:PopupWindow = new PopupWindow(md.getViewComponent() as DisplayObject);
			pop.show();
			md.getViewComponent().play();
		}
		private function showThird():void
		{
			var md:MediatorPayThird = new MediatorPayThird(PayModel.getInstance().assets.getMovieClip(PayViewAssetName.THIRD));
			facade.registerMediator(md);
			var pop:PopupWindow = new PopupWindow(md.getViewComponent() as DisplayObject);
			pop.show();
			md.getViewComponent().play();
		}
	}

}