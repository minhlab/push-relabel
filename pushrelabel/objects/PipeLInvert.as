package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class PipeLInvert extends PipeElement {
		
		
		public function PipeLInvert() {
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
