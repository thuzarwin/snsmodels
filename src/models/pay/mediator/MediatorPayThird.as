package models.pay.mediator 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import models.components.PopupWindow;
	import models.external.events.ExternalPageEvent;
	import models.pay.events.PayEvent;
	import models.pay.proxy.PayData;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author sars
	 */
	public class MediatorPayThird extends Mediator implements IMediator
	{
		public static const NAME:String = "MediatorPayThird";
		
		protected var _isTick:Boolean;
		protected var _cancelBtn:MovieClip;
		protected var _payBtn:MovieClip;
		protected var _tickBtn:MovieClip;
		public function MediatorPayThird(viewComponent:Sprite) 
		{
			super(NAME, viewComponent);
		}
		public function get view():MovieClip {
			return viewComponent as MovieClip;
		}
		override public function onRegister():void 
		{
			super.onRegister();
			view.addFrameScript(18, frame18);
			initButtons();
		}
		protected function initButtons():void {
			_cancelBtn = view.mc_content.mc_cancel;
			_payBtn = view.mc_content.mc_pay;
			_tickBtn = view.mc_content.mc_tick;
			_payBtn.mc_content.mc_logo.gotoAndStop((facade.retrieveProxy(PayData.NAME) as PayData).payType.logoFrame);
			ButtonUtil.setButtonMode(_cancelBtn);
			ButtonUtil.setButtonMode(_payBtn);
			_tickBtn.buttonMode = true;
			_tickBtn.stop();
			_tickBtn.addEventListener(MouseEvent.CLICK, onTick);
			_cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClick);
			_payBtn.addEventListener(MouseEvent.CLICK, onPay);
		}
		private function frame18():void 
		{
			view.stop();
		}
		protected function onTick(event:MouseEvent):void
		{
			if (_isTick) {
				_isTick = false;
				_tickBtn.gotoAndStop("unTick");
			}else {
				_isTick = true;
				_tickBtn.gotoAndStop("tick");
			}
		}
		protected function onCancelClick(event:MouseEvent):void
		{
			facade.removeMediator(NAME);
			sendNotification(PayEvent.SHOW_PAY_SECOND);
		}
		protected function onPay(event:MouseEvent):void
		{
			if (_isTick) {
				facade.removeMediator(NAME);
				sendNotification(ExternalPageEvent.ShowPayPage);
			}
		}
		override public function onRemove():void 
		{
			super.onRemove();
			_cancelBtn.removeEventListener(MouseEvent.CLICK, onCancelClick);
			(view.parent as PopupWindow).remove();
		}
	}

}