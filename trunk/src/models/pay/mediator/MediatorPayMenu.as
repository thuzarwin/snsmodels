package models.pay.mediator 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import models.pay.events.PayEvent;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author sars
	 */
	public class MediatorPayMenu extends Mediator implements IMediator
	{
		public static const NAME:String = "MediatorPayMenu";
		protected var addCashBtn:MovieClip
		public function MediatorPayMenu(viewComponent:DisplayObject=null) 
		{
			super(NAME, viewComponent);
		}
		public function get view():MovieClip {
			return viewComponent as MovieClip;
		}
		override public function onRegister():void 
		{
			super.onRegister();
			addBtns();
		}
		override public function onRemove():void 
		{
			super.onRemove();
			removeBtns();
		}
		protected function addBtns():void
		{
			addCashBtn = viewComponent.addCashBtn;
			ButtonUtil.setButtonMode(addCashBtn);
			addCashBtn.addEventListener(MouseEvent.CLICK, onCash);
		}
		protected function removeBtns():void
		{
			
			addCashBtn.removeEventListener(MouseEvent.CLICK, onCash);
		}
		protected function onCash(event:MouseEvent):void
		{
			sendNotification(PayEvent.PAY_START);
		}
	}

}