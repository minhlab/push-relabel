package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import pushrelabel.ui.ArrowHead;
	import flashx.textLayout.formats.TextAlign;
	
	
	public class Edge extends AbstractObject {
		
		private var _head:Vertex;
		private var _tail:Vertex;
		private var _value:Number;
		private var _tField:TextField;
		private var arrowHead:ArrowHead;
		private var textFormat:TextFormat = new TextFormat("Tahoma",21,0x11111111,true,false,false,null,null,TextAlign.CENTER,null,null,null,null);
		
		public function Edge(head:Vertex,tail:Vertex,value:Number = 17) {
			// constructor code
			_head = head;
			_tail = tail;			
			
			
			_tField = new TextField();			
			_tField.mouseEnabled = false;
			_tField.selectable = false;
			_tField.border = true;
			_tField.width = 30;
			_tField.height = 30;
			
			
			this.value = value;
			arrowHead = new ArrowHead();
			drawEdge();
		}
		
		public function drawEdge(){
			if ((_head!=null)&&(_tail!=null)){
				graphics.clear();					
				
				var deltaX:Number = _tail.x-_head.x;
				var deltaY:Number = _tail.y-_head.y;
				var scale:Number = 25/Math.sqrt(deltaX*deltaX+deltaY*deltaY);
				var arrowX:Number = _tail.x-deltaX*scale;
				var arrowY:Number = _tail.y-deltaY*scale;
				
				this.addChild(arrowHead);
				arrowHead.x = arrowX;
				arrowHead.y = arrowY;
				var atan:Number;
				if (deltaY<0){
					atan = Math.atan(deltaX/-deltaY)*180/(Math.PI);
				}else{
					atan = Math.atan(deltaX/-deltaY)*180/(Math.PI)+180;
				}
				arrowHead.rotation = atan;				
				
				graphics.lineStyle(5,0x555555);
				graphics.moveTo(_head.x,_head.y);
				graphics.lineTo(arrowX,arrowY);
				
				var textX:Number = (_head.x+_tail.x)/2-15 + deltaX*scale*15/25;
				var textY:Number = (_head.y+_tail.y)/2-15 + deltaY*scale*15/25;
				graphics.beginFill(0xFFFFFF);
				graphics.drawRect(textX,textY,30,30);
				graphics.endFill();
				_tField.x = textX;
				_tField.y = textY;				
				this.addChild(_tField);
			}
		}
		
		public function set head(head:Vertex){
			_head = head;
		}
		public function set tail(tail:Vertex){
			_tail = tail;
		}
		public function set text(s:String){
			_tField.text = s;
			_tField.setTextFormat(textFormat);
		}
		public function set value(value:Number){
			if (isNaN(value)||(value == 0)){
				value = 1;
			}
			_value = value;
			this.text = _value.toString();
		}
		
		public function get text():String {
			return _tField.text;
		}
		public function get value():Number{
			return _value;			
		}
		public function get head():Vertex{
			return _head;
		}
		public function get tail():Vertex{
			return _tail;
		}
	}
	
}
