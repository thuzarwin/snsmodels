package models.pay 
{
	import models.pay.command.PayCommand;
	import models.pay.events.PayEvent;
	import models.pay.interfaces.IPayModel;
	import models.pay.mediator.MediatorPayMenu;
	import models.pay.proxy.PayData;
	import models.components.core.BaseModel;
	import models.utils.ResourceLib;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author sars
	 */
	public class PayModel extends BaseModel implements IPayModel
	{
		private static var instance:PayModel
		public function PayModel() 
		{
			
		}
		public static function getInstance():IPayModel {
			if (instance == null) {
				instance = new PayModel();
			}
			return instance as PayModel;
			
		}
		public function startup(assets:ResourceLib):void
		{
			trace("startup pay");
			_assets = assets;
			Facade.getInstance().registerProxy(new PayData());
			Facade.getInstance().registerCommand(PayEvent.PAY_START, PayCommand);
			Facade.getInstance().registerCommand(PayEvent.PAY_SUB, PayCommand);
			Facade.getInstance().registerCommand(PayEvent.SHOW_PAY_FIRST, PayCommand);
			Facade.getInstance().registerCommand(PayEvent.SHOW_PAY_SECOND, PayCommand);
			Facade.getInstance().registerCommand(PayEvent.SHOW_PAY_THIRD, PayCommand);
		}
	}

}