/**
 * @author sars
 * 
 * 获取各种声音实例数据类，对应文档中的声音名称；
 */
package models.media.sound.instance
{
	public class SoundInstance
	{
		public function SoundInstance()
		{
		}
		////////////////////////////////////////////////////////////////////////////////////
		//                                      音乐素材部分 							  //
		////////////////////////////////////////////////////////////////////////////////////
		public static function get gameMusic():Object
		{
			return { name:"game_music", loop:1000000,type:"music"};
		}
		public static function get levelupMusic():Object
		{
			return { name:"levelup_music", loop:10,type:"music"};
		}
		public static function get avatarMusic():Object
		{
			return { name:"avatar_music", loop:1000000,type:"music"};
		}
		////////////////////////////////////////////////////////////////////////////////////
		//                                      音效素材部分 							  //
		////////////////////////////////////////////////////////////////////////////////////
		public static function get sellItemSfx():Object
		{
			return { name:"sellItem_sfx", loop:0,type:"sfx"};
		}
		public static function get buyItemSfx():Object
		{
			return { name:"buyItem_sfx", loop:0,type:"sfx"};
		}
		public static function get errorClickSfx():Object
		{
			return { name:"errorClick_sfx", loop:0,type:"sfx"};
		}
		public static function get trashPickupSfx():Object
		{
			return { name:"trashPickup_sfx", loop:0,type:"sfx"};
		}
		public static function get buttonClickSfx():Object
		{
			return { name:"buttonClick_sfx", loop:0,type:"sfx"};
		}
		public static function get tabClickSfx():Object
		{
			return { name:"tabClick_sfx", loop:0,type:"sfx"};
		}
		public static function get putItemSfx():Object
		{
			return { name:"putItem_sfx", loop:0,type:"sfx"};
		}
		public static function get takeItemSfx():Object
		{
			return { name:"takeItem_sfx", loop:0,type:"sfx"};
		}
		public static function get customerBuySfx():Object
		{
			return { name:"customerBuy_sfx", loop:0,type:"sfx"};
		}
		public static function get clickMoveSfx():Object
		{
			return { name:"clickMove_sfx", loop:0,type:"sfx"};
		}
		public static function get finishedCookingSfx():Object
		{
			return { name:"finishedCook_sfx", loop:0,type:"sfx"};
		}
		public static function get ovensSartSfx():Object
		{
			return { name:"ovensSart_sfx", loop:0,type:"sfx"};
		}
		public static function get fridgeStartSfx():Object
		{
			return { name:"fridgeStart_sfx", loop:0,type:"sfx"};
		}
		public static function get mixerStartSfx():Object
		{
			return { name:"mixerStart_sfx", loop:0,type:"sfx"};
		}
		public static function get storeItemClickSfx():Object
		{
			return { name:"storeItemClick_sfx", loop:0,type:"sfx"};
		}
		public static function get stealItemSfx():Object
		{
			return { name:"stealItem_sfx", loop:0,type:"sfx"};
		}
		public static function get customerUnhappySfx():Object
		{
			return { name:"customerUnhappy_sfx", loop:0,type:"sfx"};
		}
		public static function get dailyRewardSfx():Object
		{
			return { name:"dailyReward_sfx", loop:0,type:"sfx"};
		}
		public static function get dailyVisitRewardSfx():Object
		{
			return { name:"dailyVisitReward_sfx", loop:0,type:"sfx"};
		}
	}
}