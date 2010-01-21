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
	public class MediatorPayFirst extends Mediator implements IMediator
	{
		public static const NAME:String = "MediatorPayFirst";
		protected var payTypes:Array;
		protected var cancelBtn:MovieClip;
		public function MediatorPayFirst(viewComponent:Sprite) 
		{
			super(NAME, viewComponent);
		}
		public function get view():MovieClip {
			return viewComponent as MovieClip;
		}
		override public function onRegister():void 
		{
			super.onRegister();
			payTypes=[PayInstance.PayPal,PayInstance.Visa]
			view.gotoAndStop(1);
			view.mc_content.tf_title.text = "Add Cash";
			cancelBtn = view.mc_content.mc_cancel;
			cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClick);
			ButtonUtil.setButtonMode(cancelBtn);
			initPayBtns();
			view.addFrameScript(18, frame18);
			view.addFrameScript(25, frame25);
		}
		protected function initPayBtns():void {
			for (var i:Number = 0; i < payTypes.length; i++) {
				var mc:MovieClip = view.mc_content["mc_panel" + i] as MovieClip;
				var payType:PayTypeStruct=payTypes[i] as PayTypeStruct
				ButtonUtil.setButtonMode(mc, true);
				mc.mc_content.tf_text.text = payType.selectTypeText;
				mc.mc_content.mc_logo.gotoAndStop(payType.logoFrame)
				mc.payType = payType
				mc.addEventListener(MouseEvent.CLICK, onPayType);
			}
		}
		protected function clearPayBtns():void {
			for (var i:Number = 0; i < payTypes.length; i++) {
				var mc:MovieClip = view.mc_content["mc_panel" + i] as MovieClip;
				ButtonUtil.setButtonMode(mc);
				mc.removeEventListener(MouseEvent.CLICK, onCancelClick);
			}
		}
		protected function onPayType(event:MouseEvent):void 
		{
			facade.removeMediator(NAME);
			PayData(facade.retrieveProxy(PayData.NAME)).payType=event.currentTarget.payType as PayTypeStruct;
			sendNotification(PayEvent.SHOW_PAY_SECOND);
		}
		protected function onCancelClick(event:MouseEvent):void
		{
			view.play();
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
			cancelBtn.removeEventListener(MouseEvent.CLICK, onCancelClick);
			clearPayBtns();
			(view.parent as PopupWindow).remove();
		}
	}

}