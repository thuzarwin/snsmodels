package models.systemUI.mediator 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import models.external.events.ExternalPageEvent;
	import models.media.sound.events.SoundEvent;
	import models.media.sound.proxy.SoundData;
	import models.pay.events.PayEvent;
	import models.utils.ButtonUtil;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author sars
	 */
	public class SystemUIMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SystemUIMediator";
		public function SystemUIMediator(viewCommponent:DisplayObject) 
		{
			super(NAME, viewCommponent);
		}
		public function get view():MovieClip
		{
			return getViewComponent() as MovieClip;
		}
		
	}

}