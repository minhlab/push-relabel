﻿package pushrelabel.io
{

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import pushrelabel.algorithm.MatrixGraph;
	import flash.events.IOErrorEvent;

	public class FileIO
	{

		public static function loadMatrixGraph(fname:String,errorHandler,completeHandler)
		{
			var request:URLRequest = new URLRequest(fname);
			var loader:URLLoader = new URLLoader();
			try
			{
				loader.load(request);
			}
			catch (error:SecurityError)
			{
				trace("A SecurityError has occurred.");
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, function(event:Event) {
				var content:String=loader.data;
				//trace(loader.data);
				var rows:Array = content.split("\n");
				var n :int = parseInt(rows[0]);
				var g : MatrixGraph = new MatrixGraph(n);
				for (var i:int = 1; i <= n ; i++) {
					var cells:Array = String(rows[i]).split(" ");
					for (var j:int = 0; j < n; j++) {
						g.changeEdge(i-1, j, cells[j]);
					}
				}
				completeHandler(g);
			});
		}
	}
}