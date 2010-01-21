/**
 * @author sars
 * 
 * 播放器组件
 */
package models.media.sound.components
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author sars
	 */
	public class SoundPlayer extends EventDispatcher
	{
		private var _sound:Sound
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform
		private var _loops:int;
		private var _pause:Boolean;
		private var _playPos: Number;
		private var _id:String;
		private static var _idCount:int=0;
		public function SoundPlayer(sound:Sound,id:String=null) 
		{
			if (id == null) {
				_id = "SoundPlayerInstance_" + _idCount++;
			}else {
				_id = id;
			}
			_sound = sound;
			_soundTransform = new SoundTransform();
		}
		public function set volume(num:Number):void
		{
			_soundTransform.volume = num;
			_soundChannel.soundTransform = _soundTransform;
		}
		public function play(startTime:Number = 0, loops:int = 0, volume: Number = 0, pan:int = 0):SoundChannel
		{
			_loops = loops;
			_soundTransform.volume = volume;
			_soundTransform.pan = pan;
			_soundChannel = _sound.play(startTime, _loops, _soundTransform);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			return _soundChannel;
		}
		public function stop():void
		{
			if (_soundChannel)
			{
				_soundChannel.stop();
			}
		}
		public function pause():void
		{
			if (_pause || !_soundChannel) {
				return;
			}
			_pause = true;
			_playPos = _soundChannel.position;
		}
		public function goon():void {
			if (_pause) {
				_pause = false;
				_soundChannel = _sound.play(_playPos, _loops, _soundTransform);
			}
		}
		public function get id():String
		{
			return _id;
		}
		public function get sound():Sound
		{
			return _sound;
		}
		public function get soundChannnel():SoundChannel
		{
			return _soundChannel;
		}
		public function get soundTransform():SoundTransform
		{
			return _soundTransform
		}
		private function onSoundComplete(event:Event):void
		{
			dispatchEvent(new Event(Event.SOUND_COMPLETE));
		}
	}
}