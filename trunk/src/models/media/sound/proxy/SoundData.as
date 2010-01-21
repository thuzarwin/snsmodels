
/**
 * @author sars
 * 
 * 声音数据类
 */
package models.media.sound.proxy
{
	import flash.utils.Dictionary;
	import models.media.sound.components.SoundPlayer;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class SoundData extends Proxy implements IProxy
	{
		public static const NAME:String = "SoundData";
		/**
		 * 音效实例集合
		 */
		public var sfxSounds:Dictionary;
		/**
		 * 音曰实例集合
		 */
		public var musicSounds:Dictionary;
		/**
		 * 音效音量
		 */
		private var _sfxVolume:Number;
		/**
		 * 音乐音量
		 */
		private var _musicVolume:Number;
		public function SoundData() 
		{
			super(NAME);
		}
		override public function onRegister():void 
		{
			super.onRegister();
			sfxSounds = new Dictionary();
			musicSounds = new Dictionary();
			_sfxVolume = 1;
			_musicVolume = 1;
		}
		/**
		 * 获取音乐音量
		 * @return Number
		 */
		public function get musicVolume():Number
		{
			return _musicVolume;
		}
		/**
		 * 获取音效音量
		 * @return Number
		 */
		public function get sfxVolume():Number
		{
			return _sfxVolume;
		}
		/**
		 * 设置音效音量
		 * @params num 音量大小 Number
		 */
		public function set sfxVolume(num:Number):void
		{
			var result:Number;
			if (num < 0) {
				result = 0;
			}else if (result > 1) {
				result = 1;
			}else {
				result = num;
			}
			if (_sfxVolume != result) {
				_sfxVolume = result;
				for each(var i:SoundPlayer in sfxSounds){
					i.volume = _sfxVolume;
				}
			}
		}
		/**
		 * 设置音乐音量
		 * @params num 音量大小 Number
		 */
		public function set musicVolume(num:Number):void
		{
			var result:Number;
			if (num < 0) {
				result = 0;
			}else if (result > 1) {
				result = 1;
			}else {
				result = num;
			}
			if (_musicVolume != result) {
				_musicVolume = result;
				for each(var i:SoundPlayer in musicSounds) {
					i.volume = _musicVolume; 
				}
			}
		}
	}
}