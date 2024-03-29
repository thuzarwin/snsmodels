﻿package models.media.sound
{
	import models.components.core.BaseModel;
	import models.media.interfaces.ISound;
	import models.media.sound.command.SoundCommand;
	import models.media.sound.instance.SoundSwitch;
	import models.media.sound.mediator.SoundMediator;
	import models.media.sound.proxy.SoundData;
	import models.utils.ResourceLib;

	import models.media.sound.events.SoundEvent;
	import org.puremvc.as3.patterns.facade.Facade;
	
	
	public class SoundModel extends BaseModel implements ISound
	{
		protected static var instance:SoundModel;
		protected var _ready:Boolean = false;
		protected var _wavAssets:ResourceLib;
		protected var _musicSwitch:SoundSwitch = SoundSwitch.SwitchON;
		protected var _sfxSwitch:SoundSwitch=SoundSwitch.SwitchON;
		public function SoundModel()
		{
			
			super();
			//startup()
		}
		public static function getInstance():ISound {
			if (instance == null) {
				instance = new SoundModel();
			}
			return instance as SoundModel;
		}
		public function startup(uiassets:ResourceLib=null,wavassets:ResourceLib=null):void
		{
			//注册声音事件的响应函数
			trace("starup sound");
			assets = uiassets;
			_wavAssets = wavassets;
			Facade.getInstance().registerCommand(SoundEvent.STARTUP,SoundCommand);
			Facade.getInstance().sendNotification(SoundEvent.STARTUP);
		}
		public function play(obj:Object):void
		{
			Facade.getInstance().sendNotification(SoundEvent.SOUND_PLAY, obj);
		}
		public function stop(obj:Object):void
		{
			Facade.getInstance().sendNotification(SoundEvent.SOUND_STOP, obj);
		}
		public function switchMusic():void
		{
			var sw:SoundSwitch = getMusicSwitch();
			if (sw == SoundSwitch.SwitchON) {
				sw = SoundSwitch.SwitchOFF;
			}else {
				sw = SoundSwitch.SwitchON;
			}
			setMusicSwitch(sw);
		}
		public function switchSfx():void 
		{
			var sw:SoundSwitch = getSfxSwitch();
			if (sw == SoundSwitch.SwitchON) {
				sw = SoundSwitch.SwitchOFF;
			}else {
				sw = SoundSwitch.SwitchON;
			}
			setSfxSwitch(sw);
		}
		public function getMusicSwitch():SoundSwitch 
		{
			var obj:SoundSwitch = (Facade.getInstance().retrieveProxy(SoundData.NAME) as SoundData).musicSwitch;
			return (obj == null?_musicSwitch:obj);
		}
		public function getSfxSwitch():SoundSwitch 
		{
			var obj:SoundSwitch = (Facade.getInstance().retrieveProxy(SoundData.NAME) as SoundData).sfxSwitch;
			return (obj == null?_sfxSwitch:obj);
		}
		public function setMusicSwitch(obj:SoundSwitch):void 
		{
			_musicSwitch = obj;
			Facade.getInstance().sendNotification(SoundEvent.SWITCH_MUSIC,_musicSwitch);
		}
		public function setSfxSwitch(obj:SoundSwitch):void 
		{
			_sfxSwitch = obj;
			Facade.getInstance().sendNotification(SoundEvent.SWITCH_SFX,_sfxSwitch);
		}
		public function get ready():Boolean
		{
			return _ready;
		}
		public function set ready(b:Boolean):void 
		{
			_ready = b;
		}
		public function get wavAssets():ResourceLib
		{
			return _wavAssets;
		}
		public function set wavAssets(assets:ResourceLib):void
		{
			_wavAssets = assets;
		}
	}
}