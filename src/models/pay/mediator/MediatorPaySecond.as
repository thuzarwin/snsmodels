package models.pay.mediator 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import models.components.PopupWindow;
	import models.pay.events.PayEvent;
	import models.pay.instance.PayInstance;
	import models.pay.proxy.PayData;
	import models.pay.proxy.struct.PayTypeStruct;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	/**
	 * ...
	 * @author sars
	 */
	public class MediatorPaySecond extends Mediator implements IMediator
	{
		public static const NAME:String = "MediatorPaySecond";
		protected var _payTypes:Array;
		protected var _cancelBtn:MovieClip;
		protected var _payType:PayTypeStruct;
		protected var _prices:Array;
		public function MediatorPaySecond(viewComponent:Sprite) 
		{
			super(NAME, viewComponent);
		}
		public function get view():MovieClip {
			return viewComponent as MovieClip;
		}
		override public function onRegister():void 
		{
			super.onRegister();
			_payTypes=[PayInstance.PayPal,PayInstance.Visa]
			_prices = [ { price:100, str:"100 for 10 USD" }, { price:200, str:"100 for 20 USD" } ];
			_payType = (facade.retrieveProxy(PayData.NAME) as PayData).payType;
			view.gotoAndStop(1);
			view.mc_content.tf_title.text = "Add Cash With "+_payType.type;
			_cancelBtn = view.mc_content.mc_cancel;
			_cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClick);
			ButtonUtil.setButtonMode(_cancelBtn);
			initPayBtns();
			view.addFrameScript(18, frame18);
			view.addFrameScript(25, frame25);
		}
		protected function initPayBtns():void {
			for (var i:Number = 0; i < _prices.length; i++) {
				var mc:MovieClip = view.mc_content["mc_panel" + i] as MovieClip;
				ButtonUtil.setButtonMode(mc);
				mc.addEventListener(MouseEvent.CLICK, onPayType);
				mc.mc_content.tf_text.text = _prices[i].str;
				mc.mc_content.mc_logo.visible = false;
				mc.price = _prices[i].price;
			}
		}
		protected function clearPayBtns():void {
			for (var i:Number = 0; i < _payTypes.length; i++) {
				var mc:MovieClip = view.mc_content["mc_panel" + i] as MovieClip;
				ButtonUtil.setButtonMode(mc);
				mc.removeEventListener(MouseEvent.CLICK, onCancelClick);
			}
		}
		protected function onPayType(event:MouseEvent):void 
		{
			facade.removeMediator(NAME);
			PayData(facade.retrieveProxy(PayData.NAME)).price = event.currentTarget.price;
			sendNotification(PayEvent.SHOW_PAY_THIRD);
		}
		protected function onCancelClick(event:MouseEvent):void
		{
			facade.removeMediator(NAME);
			sendNotification(PayEvent.SHOW_PAY_FIRST);
		}
		private function frame18():void
		{
			view.stop();
		}
		private function frame25():void
		{
			facade.removeMediator(NAME);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			_cancelBtn.removeEventListener(MouseEvent.CLICK, onCancelClick);
			clearPayBtns();
			(view.parent as PopupWindow).remove();
		}
	}

}