package pushrelabel.environments {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import pushrelabel.objects.Vertex;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import pushrelabel.ui.DeleteMouse;	
	import pushrelabel.ui.EditMouse;	
	import pushrelabel.ui.EdgeHeadMouse;	
	import pushrelabel.ui.EdgeTailMouse;	
	import flash.display.DisplayObjectContainer;
	import pushrelabel.objects.Edge;
	import pushrelabel.environments.initenvironmentoperations.AbstractOperation;
	import pushrelabel.environments.initenvironmentoperations.AddEdgeHeadOperation;
	import pushrelabel.environments.initenvironmentoperations.EditEdgeOperation;
	import pushrelabel.environments.initenvironmentoperations.RemoveVertexOperation;
	import pushrelabel.environments.initenvironmentoperations.RemoveEdgeOperation;
	import pushrelabel.objects.AbstractObject;
	import pushrelabel.objects.GraphView;
	import flash.ui.Keyboard;
	import pushrelabel.algorithm.MatrixGraph;
	import pushrelabel.io.FileIO;
	
	public class InitEnvironment extends AbstractEnvironment {
		
		private var _graphView:GraphView;
		
		private var _dragged:Vertex = null;
		private var _selected:AbstractObject = null;
		private var _clone:Vertex = null;
		private var glow:GlowFilter = new GlowFilter(0x0000FF,0.5,20,20,2,3,false,false);
		
		private var _startX:Number;
		private var _startY:Number;
		
		private var _currentOperation:AbstractOperation = null;		
		
		private var _frozen:Boolean = false;
		public function InitEnvironment() {
			initGraphView();
			
			
			addVertexBtn.addEventListener(MouseEvent.CLICK,addVertexClick);
			addEdgeBtn.addEventListener(MouseEvent.CLICK,addEdgeClick);
			editEdgeBtn.addEventListener(MouseEvent.CLICK,editEdgeClick);
			removeVertexBtn.addEventListener(MouseEvent.CLICK,removeVertexClick);
			removeEdgeBtn.addEventListener(MouseEvent.CLICK,removeEdgeClick);
			clearBtn.addEventListener(MouseEvent.CLICK,clearClick);
			loadBtn.addEventListener(MouseEvent.CLICK,loadClick);
			saveBtn.addEventListener(MouseEvent.CLICK,saveClick);
			
			//this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			Main.instance.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			this.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		public function initGraphView(){
			_graphView = new GraphView();
			var vertexT:Vertex = new Vertex(_graphView.size,"T");
			_graphView.addVertex(vertexT);
			this.vertexLayer.addChild(vertexT);
			vertexT.x = 550;
			vertexT.y = 300;
			vertexT.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			var vertexS:Vertex = new Vertex(_graphView.size,"S");
			_graphView.addVertex(vertexS);
			this.vertexLayer.addChild(vertexS);
			vertexS.x = 50;
			vertexS.y = 300;
			vertexS.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		public function addVertexClick(e:MouseEvent){
			if (!_frozen){
				addNewVertex();
			}
						
		}
		
		public function addNewVertex(){
			var newVertex:Vertex = new Vertex(_graphView.size,(_graphView.size).toString());
			_graphView.addVertex(newVertex);
			this.vertexLayer.addChild(newVertex);
			newVertex.x = Math.random()*300+150;
			newVertex.y = Math.random()*500+50;
			newVertex.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		public function addEdgeClick(e:MouseEvent){
			if (!_frozen){
				_currentOperation = new AddEdgeHeadOperation();
			}
			
		}
		
		public function editEdgeClick(e:MouseEvent){
			if (!_frozen){
				_currentOperation = new EditEdgeOperation();
			}
			
		}
		
		public function removeVertexClick(e:MouseEvent){
			if (!_frozen){
				_currentOperation = new RemoveVertexOperation();
				
			}
		}
		public function removeEdgeClick(e:MouseEvent){
			if (!_frozen){
				_currentOperation = new RemoveEdgeOperation;				
			}
		}
		public function clearClick(e:MouseEvent){
			if (!_frozen){
				resetGraphView();
			}
		}
		
		public function resetGraphView(){
			while (this.vertexLayer.numChildren>0){
				this.vertexLayer.removeChildAt(0);
			}
			while (this.edgeLayer.numChildren>0){
				this.edgeLayer.removeChildAt(0);
			}
			initGraphView();
		}
		
		public function loadClick(e:MouseEvent){
			if (!_frozen){
				resetGraphView();
				FileIO.openMatrixGraph(function(evt:Event) {
									trace(evt);
									}, function (g:MatrixGraph) {
										var i:Number;
										for (i = 0; i<g.size-2; i++){
											addNewVertex();
										}
										
										for (i = 0; i<g.size; i++){
											for (var j:Number = 0; j<g.size; j++){
												if (g.getEdgeValue(i,j)>0){
													var newEdge:Edge = _graphView.addEdge(_graphView.findVertexAt(i),_graphView.findVertexAt(j),g.getEdgeValue(i,j));
													if (newEdge!=null){
														edgeLayer.addChild(newEdge);
														newEdge.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
													}
												}
											}
									   }
								   });
			}
		}
		public function saveClick(e:MouseEvent){
			if (!_frozen){
				FileIO.saveMatrixGraph("data.txt",_graphView.toMatrixGraph(), function(evt:Event) {
										trace(evt);
									}, function () {
										trace("ok");
									});				
			}
		}
		
		public function onMouseDown(e:MouseEvent){
			if (!_frozen){
				if (_clone != null){
					this.vertexLayer.removeChild(_clone);
				}
				if (e.target is Vertex){				
					_dragged = Vertex(e.target);
					_startX = _dragged.stage.mouseX - _dragged.x;
					_startY = _dragged.stage.mouseY - _dragged.y;
					_clone = _dragged.clone();
					_clone.x = _dragged.x;
					_clone.y = _dragged.y;
					_clone.alpha = 0.8;
					this.vertexLayer.addChildAt(_clone,this.vertexLayer.getChildIndex(_dragged));
					_dragged.alpha = 0.5;				
				}			
				if (e.target is AbstractObject){
					activeSelection(AbstractObject(e.target));
				}
			}
		}
		
		
		
		public function onMouseUp(e:MouseEvent){
			if (!_frozen){
				
					removeDrag();
					
								
			}
		}
		
		public function removeDrag(){
			if (_dragged != null){
				_dragged.alpha = 1;
				_graphView.updateEdge(_dragged);
				_dragged = null;
				this.vertexLayer.removeChild(_clone);
				_clone = null;
			}
		}
		
		public function onEnterFrame(e:Event){
			if (!_frozen){
				if (_dragged != null){
					_dragged.x = Math.min(Math.max(_dragged.stage.mouseX - _startX,25),575);
					_dragged.y = Math.min(Math.max(_dragged.stage.mouseY - _startY,25),575);
				}
			}
		}
		
		public function activeSelection(selected:AbstractObject){
			if (_selected != null){
				_selected.filters = new Array();
			}
			_selected = selected;
			_selected.filters = new Array(glow);
			var temp:DisplayObjectContainer = _selected.parent;
			temp.removeChild(_selected);
			temp.addChild(_selected);
			if (_currentOperation!=null){
				_currentOperation.doOps(this);
			}
		}
		
		public function onKeyDown(evt : KeyboardEvent) {
			if (evt.charCode == Keyboard.ESCAPE) {
				_currentOperation = null;
				AbstractEnvironment.mouse = null;
			}
		}
		
		public function get graphView():GraphView{
			return _graphView;
		}
		public function set graphView(graphView:GraphView){
			_graphView = graphView;
		}
		public function set frozen(frozen:Boolean){
			_frozen = frozen;
		}		
		public function get frozen():Boolean{
			return _frozen;
		}
		public function get selected():AbstractObject{
			return _selected;
		}
		public function set selected(selected:AbstractObject){
			_selected = selected;
		}
		
		public function get currentOperation():AbstractOperation{
			return _currentOperation;
		}
		public function set currentOperation(currentOperation:AbstractOperation){
			_currentOperation = currentOperation;
			if (currentOperation == null){
				AbstractEnvironment.mouse = null;
			}
		}
		
		
		override public function onLeave(){
			
			_graph = _graphView.toMatrixGraph();
			Main.instance.graph = _graph;
		}

	}
	
}
