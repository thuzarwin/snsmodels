package models.utils 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import models.media.sound.events.SoundEvent;
	import models.media.sound.instance.SoundInstance;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * ...
	 * @author sars
	 */
	public class ButtonUtil
	{
		public function ButtonUtil() 
		{
		}
		public static function setButtonMode(mc:MovieClip, mode:Boolean = true):void {
			if (mc) {
				mc.stop();
				mc.mouseChildren = false;
				if (mode) {
					mc.buttonMode = true; 
					mc.addEventListener(MouseEvent.MOUSE_UP, buttonUpListener);
                    mc.addEventListener(MouseEvent.MOUSE_DOWN, buttonDownListener);
                    mc.addEventListener(MouseEvent.ROLL_OVER, buttonOverListener);
                    mc.addEventListener(MouseEvent.ROLL_OUT, buttonOutListener);
				}else {
					mc.buttonMode = false;
					mc.removeEventListener(MouseEvent.MOUSE_UP, buttonUpListener);
                    mc.removeEventListener(MouseEvent.MOUSE_DOWN, buttonDownListener);
                    mc.removeEventListener(MouseEvent.ROLL_OVER, buttonOverListener);
                    mc.removeEventListener(MouseEvent.ROLL_OUT, buttonOutListener);
				}
			}
		}
		private static function buttonDownListener(event:MouseEvent) : void
        {
			(event.currentTarget as MovieClip).gotoAndStop("down");
        }

        private static function buttonUpListener(event:MouseEvent) : void
        {
           (event.currentTarget as MovieClip).gotoAndStop("up");
        }

        private static function buttonOutListener(event:MouseEvent) : void
        {
            (event.currentTarget as MovieClip).gotoAndStop("up");
        }

        private static function buttonOverListener(event:MouseEvent) : void
        {
			Facade.getInstance().sendNotification(SoundEvent.SOUND_PLAY, SoundInstance.buttonClickSfx);
           (event.currentTarget as MovieClip).gotoAndStop("over");
        }
	}

}