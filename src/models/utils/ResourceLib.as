package models.utils 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.media.Sound;
	/**
	 * ...
	 * @author sars
	 */
	public class ResourceLib
	{
		private var _loader:Loader
		public function ResourceLib(loader:Loader) 
		{
			_loader = loader;
		}
		public function getSound(name:String):Sound 
		{
			var objClass:Class = getClass(name);
			if (objClass) {
				return (new objClass()) as Sound;
			}
			return null;
		}
		public function getMovieClip(name:String):MovieClip 
		{
			var objClass:Class = getClass(name);
			if (objClass) {
				return (new objClass()) as MovieClip;
			}
			return null;
		}
		public function getClass(name:String):Class {
			try{
				var objClass:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			}catch( error:ReferenceError ){
				trace( "Asset '" + name + "' not found in '" + _loader.loaderInfo.url + "'" );
				return null;
			}
			return objClass;
		}
		
	}

}