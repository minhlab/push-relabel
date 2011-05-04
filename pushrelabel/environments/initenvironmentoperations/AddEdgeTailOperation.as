package pushrelabel.environments.initenvironmentoperations {
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.objects.Vertex;
	import pushrelabel.objects.Edge;
	import flash.events.MouseEvent;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.ui.EdgeTailMouse;
	import pushrelabel.ui.EditEdgeDlg;
	
	public class AddEdgeTailOperation  extends AbstractOperation{

		private var _headVertex:Vertex;
		public function AddEdgeTailOperation(headVertex:Vertex) {
			AbstractEnvironment.mouse = new EdgeTailMouse();
			_headVertex = headVertex;
		}
		
		override public function doOps(environment:InitEnvironment){
			if (environment.selected is Vertex){				
				if (Vertex(environment.selected).index != 1){
					environment.frozen = true;
					var editEdgeDlg:EditEdgeDlg = new EditEdgeDlg();
					editEdgeDlg.show(function(dlg:EditEdgeDlg) {
									 
						var newEdge:Edge = environment.graphView.addEdge(_headVertex,Vertex(environment.selected),dlg.capacity);
						if (newEdge!=null){
							environment.edgeLayer.addChild(newEdge);
							newEdge.addEventListener(MouseEvent.MOUSE_DOWN,environment.onMouseDown);
						}
						
						environment.frozen = false;
					}, function(dlb:EditEdgeDlg) {;
						environment.frozen = false;
					});
					environment.removeDrag();
					
					environment.currentOperation = null;
				}
				
			}
		}

	}
	
}
