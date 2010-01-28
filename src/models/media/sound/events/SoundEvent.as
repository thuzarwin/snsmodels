package models.media.sound.events
{
	public class SoundEvent
	{
		/**
		 * 播放
		 */
		public static const SOUND_PLAY:String="SOUND_PLAY";
		/**
		 * 停止
		 */
		public static const SOUND_STOP:String="SOUND_STOP";
		//public static const SOUND_PAUSE:String="SOUND_PAUSE";
		//public static const SOUND_CONTINUE:String="SOUND_CONTINUE";
		/**
		 * 关闭音乐
		 */
		public static const SWITCH_MUSIC:String = "SWITCH_MUSIC";
		public static const SWITCH_MUSIC_OFF:String = "SWITCH_MUSIC_OFF";
		public static const SWITCH_MUSIC_ON:String="SWITCH_MUSIC_ON";
		/**
		 * 关闭音效
		 */
		public static const SWITCH_SFX:String = "SWITCH_SFX";
		public static const SWITCH_SFX_OFF:String = "SWITCH_SFX_OFF";
		public static const SWITCH_SFX_ON:String = "SWITCH_SFX_ON";
		/**
		 * 更新音乐状态
		 */
		public static const UPDATE_MUSIC_STATE:String="UPDATE_MUSIC_STATE";
		/**
		 * 更新音效状态
		 */
		public static const UPDATE_SFX_STATE:String = "UPDATE_SFX_STATE";
		/**
		 * 设置音量
		 */
		//public static const SET_VOLUME:String="SET_VOLUME";
		public static const STARTUP:String = "Sound_STARTUP";
	}
}