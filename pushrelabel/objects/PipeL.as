package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class PipeL extends PipeElement {
		
		
		public function PipeL() {
			// constructor code
		}
		override public function get flow():MovieClip{
			return _flow;
		}
		
		override public function setFlowColor(color:ColorTransform){
			_flow.transform.colorTransform = color;
		}
	}
	
}
