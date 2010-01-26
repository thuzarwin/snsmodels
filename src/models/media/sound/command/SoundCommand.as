﻿package models.media.sound.command 
{
	import flash.events.Event;
	import flash.media.Sound;
	import models.media.sound.components.SoundPlayer;
	import models.media.sound.proxy.SoundData;
	import models.media.sound.proxy.struct.SoundType;
	import models.media.sound.events.SoundEvent;
	import models.media.sound.SoundModel;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author sars
	 */
	public class SoundCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			switch(notification.getName()) {
				case SoundEvent.SOUND_PLAY:
					play(notification.getBody());
				break;
				case SoundEvent.SOUND_STOP:
					stop(notification.getBody());
				break;
				case SoundEvent.SWITCH_MUSIC:
					switchMusic();
				break;
				case SoundEvent.SWITCH_SFX:
					switchSfx();
				break;
				case SoundEvent.STARTUP:
					startup();
				break;
			}
		}
		private function get soundData():SoundData
		{
			return facade.retrieveProxy(SoundData.NAME) as SoundData;
		}
		private function startup():void
		{
			//trace("startup")
			facade.registerCommand(SoundEvent.SWITCH_MUSIC, SoundCommand);
			facade.registerCommand(SoundEvent.SWITCH_SFX, SoundCommand);
			facade.registerCommand(SoundEvent.SOUND_PLAY, SoundCommand);
			facade.registerCommand(SoundEvent.SOUND_STOP, SoundCommand);
			facade.registerCommand(SoundEvent.UPDATE_MUSIC_STATE, SoundCommand);
			facade.registerCommand(SoundEvent.UPDATE_SFX_STATE, SoundCommand);
			//注册数据
			facade.registerProxy(new SoundData());
		}
		/**
		 * 开/关闭音乐
		 * @param	d
		 */
		private function switchMusic():void
		{
			if (soundData.musicVolume == 0) {
				soundData.musicVolume = 1
			}else {
				soundData.musicVolume = 0;
			}
			sendNotification(SoundEvent.UPDATE_MUSIC_STATE);
		}
		/**
		 * 开/关闭音效
		 * @param	d
		 */
		private function switchSfx(d:*=null):void
		{
			if (soundData.sfxVolume == 0) {
				soundData.sfxVolume = 1
			}else {
				soundData.sfxVolume = 0;
			}
			sendNotification(SoundEvent.UPDATE_SFX_STATE);
		}
		/**
		 * 播放声音
		 * @param	d
		 */
		private function play(d:Object=null):void
		{
			if (d) {
				var sound:Sound
				var player:SoundPlayer
				if ((player=getSoundByNameFromLocal(d.name,d.type))) {
					if (d.type == SoundType.MUSIC) {
						return
					}
				}
				sound = getSoundByNameFromAssets(d.name) 
				if (sound == null) {
					return;
				}
				player = new SoundPlayer(sound,d.name);
				//try 是当玩家没有扬声器设备时sound.play()会返回null的错误
				try{
					if (d.type == SoundType.MUSIC) {
						player.play(0, d.loop,soundData.musicVolume);
						soundData.musicSounds[d.name] = player;
						player.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
					}else if (d.type == SoundType.SFX) {
						player.play(0, d.loop,soundData.sfxVolume);
						soundData.sfxSounds[player] = player;
						player.addEventListener(Event.SOUND_COMPLETE, onSfxComplete);
					}
				}catch(e:Error){
					trace(e);
				}
			}
		}
		/**
		 * 关闭声音
		 * @param	d
		 */
		private function stop(d:Object=null):void
		{
			if (d) {
				var player:SoundPlayer;
				if ((player = getSoundByNameFromLocal(d.name,d.type))) {
					player.stop();
					if (d.type == SoundType.MUSIC) {
						delete soundData.musicSounds[d.name];
					}else {
						delete soundData.sfxSounds[player];
					}
				}
			}
		}
		/**
		 * 
		 * @param	name 声音名称
		 * @return  声音类实例
		 */
		public function getSoundByNameFromAssets(name:String):Sound
		{
			var sound:Sound;
			try {
				sound=SoundModel.getInstance().wavAssets.getSound(name);
			}catch (e:Error) {
				trace(e)
				return null;
			}
			return sound;
		}
		/**
		 * 
		 * @param	name 声音名称
		 * @param	type SoundType.MUSIC or SoundType.SFX
		 * @return  声音类实例
		 */
		public function getSoundByNameFromLocal(name:String,type:String="music"):SoundPlayer
		{
			if (type == SoundType.MUSIC) {
				return (soundData.musicSounds[name])
			}
			if (type == SoundType.SFX) {
				return (soundData.sfxSounds[name]);
			}
			return null;
		}
		/*****************************************************************************/
		//							  监听										      /
		/*****************************************************************************/
		private function onMusicComplete(event:Event):void
		{
			delete soundData.musicSounds[(event.target as SoundPlayer).id]
		}
		private function onSfxComplete(event:Event):void 
		{
			delete soundData.sfxSounds[event.target]
		}
		
	}

}