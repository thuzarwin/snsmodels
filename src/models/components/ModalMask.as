package models.components
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author sars
	 */
	public class ModalMask extends Sprite
	{
		/**
		 * 实例化modalmask
		 * @param	width 宽
		 * @param	height 高
		 * @param	color 颜色
		 * @param	alpha 透明度
		 */
		public function ModalMask(width:Number,height:Number,color:Number=0,alpha:Number=.6) 
		{
			super();
			this.graphics.beginFill(color, alpha);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
		}
		
	}

}