package pushrelabel.environments.initenvironmentoperations {
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.objects.Edge;
	import pushrelabel.ui.EditEdgeDlg;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.ui.EditMouse;
	
	public class EditEdgeOperation  extends AbstractOperation{

		public function EditEdgeOperation() {
			// constructor code
			AbstractEnvironment.mouse = new EditMouse();
		}
		
		override public function doOps(environment:InitEnvironment){
			if (environment.selected is Edge){				
				
				environment.frozen = true;
				var editEdgeDlg:EditEdgeDlg = new EditEdgeDlg();
				editEdgeDlg.show(function(dlg:EditEdgeDlg) {
								 			
				
					var editedEdge:Edge = environment.graphView.editEdge(Edge(environment.selected).head,Edge(environment.selected).tail,dlg.capacity);
					if (editedEdge==null){
						trace("false");
					}
					
					environment.frozen = false;
				}, function(dlb:EditEdgeDlg) {;
					environment.frozen = false;
				});
				
				environment.currentOperation = null;
			}
			
		}

	}
	
}
