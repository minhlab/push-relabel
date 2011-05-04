package pushrelabel.environments.initenvironmentoperations {
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.objects.Vertex;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.ui.EdgeHeadMouse;
	
	public class AddEdgeHeadOperation extends AbstractOperation{
		
		public function AddEdgeHeadOperation() {
			// constructor code
			AbstractEnvironment.mouse = new EdgeHeadMouse();
		}
		
		override public function doOps(environment:InitEnvironment){
			if (environment.selected is Vertex){
				if (Vertex(environment.selected).index != 0){
					environment.currentOperation = new AddEdgeTailOperation(Vertex(environment.selected));
				}
			} else {
				environment.currentOperation = null;
			}
		}

	}
	
}
