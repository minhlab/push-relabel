package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flashx.textLayout.formats.TextAlign;
	
	
	public class Vertex extends AbstractObject {

		private var _tField:TextField;
		private var _index:Number;
		var textFormat:TextFormat = new TextFormat("Tahoma",21,0x11111111,true,false,false,null,null,TextAlign.CENTER,null,null,null,null);
		public function Vertex(index:Number = -1, text:String = "17") {			
			_tField = new TextField();			
			_tField.mouseEnabled = false;
			_tField.selectable = false;
			_tField.x = -15;
			_tField.y = -15;
			_tField.width = 30;
			_tField.height = 30;
			this.addChild(_tField);
			
			this.text = text;
			_index = index;
		}
		
		public function set text(s:String){
			_tField.text = s;
			_tField.setTextFormat(textFormat);
		}
		
		public function get text():String {
			return _tField.text;
		}
		
		public function set index(index:Number){
			_index = index;			
		}
		
		public function get index():Number {
			return _index;
		}
		
		public function clone():Vertex{
			var cloner:Vertex = new Vertex(this.index,this.text);
			return cloner;
		}
	}
	
}
