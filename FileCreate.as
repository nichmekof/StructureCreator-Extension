﻿package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	/**
	 * ...
	 * @author Danny Murong
	 */
	public class FileCreate
	{
		private var _stage:MovieClip;
		private var _fileNameExtension:String;
		private var _folderURI:String;
		private var _urlLoader:URLLoader;
		
		public function FileCreate(stage:MovieClip, fileNameExtension:String, folderURI:String, fileURL:String)
		{
			_stage = stage;
			_fileNameExtension = fileNameExtension;
			_folderURI = folderURI;
			
			_urlLoader = new URLLoader(new URLRequest(fileURL));
			_urlLoader.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		private function completeHandler(evt:Event)
		{
			var stringData:String = _urlLoader.data;

			if (_fileNameExtension == "index.html")
			{
				stringData = stringData.replace("%SWFWIDTH%", _stage.widthInput_txt.text);
				stringData = stringData.replace("%SWFHEIGHT%", _stage.heightInput_txt.text);
			}
			
			if (_fileNameExtension == "style.css")
			{
				var w:int = int(_stage.widthInput_txt.text) * 0.5;
				var h:int = int(_stage.heightInput_txt.text) * 0.5;
				stringData = stringData.replace("%SWFHALFWIDTH%", w);
				stringData = stringData.replace("%SWFHALFHEIGHT%", h);
			}
			
			stringData = escape(stringData);
			_stage.info_txt.htmlText += _stage.executeJSFL('"createFile", "' + _folderURI + '", "' + _fileNameExtension + '", "' + stringData + '"') + "\n";
		}
	}
	
}