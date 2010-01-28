package models.media.sound.mediator 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import models.media.sound.events.SoundEvent;
	import models.media.sound.instance.SoundSwitch;
	import models.media.sound.SoundModel;
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
		public static const INIT_COMPLETE:String = "SoundMediator_INIT_COMPLETE";
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
			sendNotification(SoundMediator.INIT_COMPLETE);
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
					updateMusic(notification.getBody() as Array);
				break;
				case SoundEvent.UPDATE_SFX_STATE:
					updateSfx(notification.getBody() as Array);
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
		private function updateMusic(states:Array):void
		{
			if(states[0]!==null){
				var switchm:SoundSwitch = states[0];
				if (switchm==SoundSwitch.SwitchON) {
					musicBtn.mc.gotoAndStop(1);
				}else if(switchm==SoundSwitch.SwitchOFF){
					musicBtn.mc.gotoAndStop(2);
				}
			}
		}
		private function updateSfx(states:Array):void
		{
			if(states[0]!==null){
				var switchs:SoundSwitch = states[0];
				if (switchs == SoundSwitch.SwitchON) {
					sfxBtn.mc.gotoAndStop(1);
				}else if(switchs==SoundSwitch.SwitchOFF) {
					sfxBtn.mc.gotoAndStop(2);
				}
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