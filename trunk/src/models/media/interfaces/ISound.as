package models.media.interfaces 
{
	import models.components.core.IBaseModel;
	import models.media.sound.instance.SoundSwitch;
	import models.utils.ResourceLib;
	
	/**
	 * ...
	 * @author sars
	 */
	public interface ISound extends IBaseModel
	{
		function startup(uiassets:ResourceLib=null,wavassets:ResourceLib=null):void;
		function play(obj:Object):void;
		function stop(obj:Object):void;
		function switchMusic():void;
		function switchSfx():void;
		function getMusicSwitch():SoundSwitch;
		function getSfxSwitch():SoundSwitch;
		function setMusicSwitch(obj:SoundSwitch):void;
		function setSfxSwitch(obj:SoundSwitch):void;
		function get ready():Boolean;
		function set ready(b:Boolean):void;
		function get wavAssets():ResourceLib;
		function set wavAssets(assets:ResourceLib):void;
	}
	
}