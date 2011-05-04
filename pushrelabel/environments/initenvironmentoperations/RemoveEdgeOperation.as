package pushrelabel.environments.initenvironmentoperations {
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.ui.DeleteMouse;
	import pushrelabel.objects.Edge;
	import pushrelabel.ui.ConfirmDlg;
	
	public class RemoveEdgeOperation  extends AbstractOperation{

		public function RemoveEdgeOperation() {
			// constructor code
			AbstractEnvironment.mouse = new DeleteMouse();
		}
		
		override public function doOps(environment:InitEnvironment){
			if (environment.selected is Edge){
				environment.frozen = true;
				var confirmDlg:ConfirmDlg = new ConfirmDlg();
				confirmDlg.show(function(dlg:ConfirmDlg) {								 			
				
					var e:Edge = environment.graphView.removeEdge(Edge(environment.selected).head,Edge(environment.selected).tail);
					trace(e);
					
					if (e!=null){
						trace(e);
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
