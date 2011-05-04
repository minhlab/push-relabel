package pushrelabel.environments {
	
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import pushrelabel.algorithm.Graph;
	import flash.events.Event;
	
	
	public class AbstractEnvironment extends MovieClip {
		
		protected var _graph:Graph = null;
		private static var _mouse:MovieClip = null;
		public function AbstractEnvironment() {
			Main.instance.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		public function onEnter(){
			_graph = Main.instance.graph;
		}
		public function onLeave(){
			Main.instance.graph = _graph;
		}
		
		public static function set mouse(mouse:MovieClip){
			if (_mouse != null){
				Main.instance.removeChild(_mouse);
			}
			_mouse = mouse;			
			if (mouse != null){
				Main.instance.addChild(_mouse);
				var scale:Number = 25/_mouse.height;
				_mouse.scaleX = _mouse.scaleY = scale;
			}			
		}
		
		public static function onEnterFrame(e:Event){
			if (_mouse!=null){
				_mouse.x = _mouse.stage.mouseX+10;
				_mouse.y = _mouse.stage.mouseY+10;
			}
		}
	}
	
}
