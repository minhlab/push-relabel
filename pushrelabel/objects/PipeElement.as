package pushrelabel.objects {
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.geom.ColorTransform;
	
	public class PipeElement extends MovieClip{

		public function PipeElement() {
			// constructor code
		}
		
		public function get flow():MovieClip{
			throw new IllegalOperationError("abstract");
		}
		
		public function setFlowColor(color:ColorTransform){
			throw new IllegalOperationError("abstract");
		}

	}
	
}
