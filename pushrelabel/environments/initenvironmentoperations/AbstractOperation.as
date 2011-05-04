package pushrelabel.environments.initenvironmentoperations {
	import flash.errors.IllegalOperationError;
	import pushrelabel.environments.InitEnvironment;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import pushrelabel.environments.AbstractEnvironment;
	
	public class AbstractOperation extends MovieClip{

		public function AbstractOperation() {
			// constructor code
			
		}

		public function doOps(environment:InitEnvironment){
			throw new IllegalOperationError("This is an abstract method");
		}
		
		
	}
	
}
