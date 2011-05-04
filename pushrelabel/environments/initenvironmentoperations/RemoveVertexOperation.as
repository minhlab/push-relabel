package pushrelabel.environments.initenvironmentoperations {
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.ui.DeleteMouse;
	import pushrelabel.objects.Vertex;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.ui.ConfirmDlg;
	
	
	public class RemoveVertexOperation  extends AbstractOperation{

		public function RemoveVertexOperation() {
			// constructor code
			AbstractEnvironment.mouse = new DeleteMouse();
		}
		
		override public function doOps(environment:InitEnvironment){
			if (environment.selected is Vertex){
				environment.frozen = true;
				var confirmDlg:ConfirmDlg = new ConfirmDlg();
				confirmDlg.show(function(dlg:ConfirmDlg) {								 			
				
					var v:Vertex = environment.graphView.removeVertex(Vertex(environment.selected));
					trace(v);
					
					if (v!=null){
						trace(v);
					}
					environment.frozen = false;
				}, function(dlb:ConfirmDlg) {;
					environment.frozen = false;
				});
				environment.removeDrag();
				environment.currentOperation = null;
			}
			
		}

	}
	
}
