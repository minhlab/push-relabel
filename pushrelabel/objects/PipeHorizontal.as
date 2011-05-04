package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class PipeHorizontal extends PipeElement {
		
		
		public function PipeHorizontal() {
			// constructor code
		}
		
		override public function get flow():MovieClip{
			return _flow;
		}
		
		override public function setFlowColor(color:ColorTransform){
			_flow.colorTransform = color;
		}
	}
	
}
