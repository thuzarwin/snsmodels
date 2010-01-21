package models.media.sound.mediator 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import models.media.sound.events.SoundEvent;
	import models.media.sound.proxy.SoundData;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author sars
	 */
	public class SoundMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SoundMediator";
		public var sfxBtn:MovieClip;
		public var musicBtn:MovieClip;
		public function SoundMediator(viewComponent:DisplayObject=null) 
		{
			super(NAME,viewComponent);
		}
		public function get view():MovieClip
		{
			return getViewComponent() as MovieClip;
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
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch (notification.getName()) {
				case SoundEvent.UPDATE_MUSIC_STATE:
					switchMusic();
				break;
				case SoundEvent.UPDATE_SFX_STATE:
					switchSfx();
				break;
			}
		}
		override public function listNotificationInterests():Array 
		{
			return [SoundEvent.UPDATE_MUSIC_STATE, SoundEvent.UPDATE_SFX_STATE];
		}
		private function addBtns():void
		{
			sfxBtn = viewComponent.sfxBtn;
			musicBtn = viewComponent.musicBtn;
			sfxBtn.mc.stop();
			musicBtn.mc.stop();
			ButtonUtil.setButtonMode(sfxBtn);
			ButtonUtil.setButtonMode(musicBtn);
			sfxBtn.addEventListener(MouseEvent.CLICK, onSwitchSfx);
			musicBtn.addEventListener(MouseEvent.CLICK, onSwitchMusic);
		}
		private function removeBtns():void
		{
			sfxBtn.removeEventListener(MouseEvent.CLICK, onSwitchSfx);
			musicBtn.removeEventListener(MouseEvent.CLICK, onSwitchMusic);
		}
		private function switchMusic():void
		{
			
			var volume:Number = (facade.retrieveProxy(SoundData.NAME) as SoundData).musicVolume;
			if (volume == 0) {
				musicBtn.mc.gotoAndStop(2);
			}else {
				musicBtn.mc.gotoAndStop(1);
			}
		}
		private function switchSfx():void
		{
			var volume:Number = (facade.retrieveProxy(SoundData.NAME) as SoundData).sfxVolume;
			if (volume == 0) {
				sfxBtn.mc.gotoAndStop(2);
			}else {
				sfxBtn.mc.gotoAndStop(1);
			}
		}
		private function onSwitchMusic(event:MouseEvent):void
		{
			sendNotification(SoundEvent.SWITCH_MUSIC);
		}
		private function onSwitchSfx(event:MouseEvent):void
		{
			sendNotification(SoundEvent.SWITCH_SFX);
		}
	}

}