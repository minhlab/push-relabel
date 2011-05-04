package pushrelabel.objects {
	import pushrelabel.algorithm.LinkedList;
	import pushrelabel.algorithm.Node;
	import pushrelabel.algorithm.ListGraph;
	import pushrelabel.algorithm.MatrixGraph;
	
	public class GraphView  extends AbstractObject{

		private var _vertexs:LinkedList;
		private var _size:Number;
		public function GraphView(){
			// constructor code
			_size = 0;
			_vertexs = new LinkedList();			
		}
		
		public function addVertex(v:Vertex){
			_vertexs.addLast(new Array(v,new LinkedList()));			
			_size++;
		}
		
		public function editEdge(head:Vertex,tail:Vertex,value:Number):Edge{
			var cur:Node = findEdge(head,tail);
			if (cur!=null){
				cur.data.value = value;
				return Edge(cur.data);
			} else {
				return null;
			}
		}
		
		public function addEdge(head:Vertex,tail:Vertex,value:Number):Edge{
			var cur:Node = findVertex(head);
			if ((findVertex(tail)!=null) && (cur!=null)){
				var found:Node = cur.data[1].head.next;
				while (found != cur.data[1].head){
					if (found.data.tail == tail){
						return null;
					}
					found = found.next;
				}
				var newEdge:Edge = new Edge(head,tail,value);
				cur.data[1].addLast(newEdge);
				return newEdge;
			} else {
				return null;
			}
		}
		
		public function removeEdge(head:Vertex,tail:Vertex):Edge{
			var cur:Node = findEdge(head,tail);
			if (cur!=null){
				var temp:Edge = cur.data;
				cur.prev.next = cur.next;
				cur.next.prev = cur.prev;
				temp.parent.removeChild(temp);
				return temp;
			} else {
				return null;
			}
		}
		
		public function removeVertex(v:Vertex):Vertex{
			var cur:Node = findVertex(v);
			if (cur != null){
				var iterator:Node = _vertexs.head.next;
				while (iterator != _vertexs.head){
					removeEdge(iterator.data[0],v);
					iterator = iterator.next;
				}
				var temp:Vertex = cur.data[0];
				var iterator2:Node = cur.data[1].head.next;
				while (iterator2 != cur.data[1].head){
					iterator2.data.parent.removeChild(iterator2.data);
					iterator2 = iterator2.next;
				}
				cur.prev.next = cur.next;
				cur.next.prev = cur.prev;
				temp.parent.removeChild(temp);
				return temp;
				_size--;
			} else return null;
		}
		
		public function updateEdge(movedV:Vertex){
			var cur:Node = findVertex(movedV);
			if (cur != null){
				var iterator:Node = _vertexs.head.next;
				while (iterator != _vertexs.head){
					var temp:Node = findEdge(iterator.data[0],movedV);
					if (temp!=null){
						temp.data.drawEdge();
					}
					iterator = iterator.next;
				}
				
				var iterator2:Node = cur.data[1].head.next;
				while (iterator2 != cur.data[1].head){
					iterator2.data.drawEdge();
					iterator2 = iterator2.next;
				}
				
			}
		}
		
		public function findEdge(head:Vertex,tail:Vertex):Node{
			var cur:Node = findVertex(head);
			if ((findVertex(tail)!=null) && (cur!=null)){
				var found:Node = cur.data[1].head.next;
				while (found != cur.data[1].head){
					if (found.data.tail == tail){
						return found;
					}
					found = found.next;
				}
				return null;
			} else {
				return null;
			}
		}
		
		public function findVertex(v:Vertex):Node{
			var found:Node = _vertexs.head.next;
			while (found!=_vertexs.head){
				if (found.data[0] == v){
					return found;
				}
				found = found.next;
			}
			return null;
		}
		
		public function findVertexAt(index:Number):Vertex{
			var temp:Node = _vertexs.findAt(index);
			if (temp!=null){
				return temp.data[0];
			} else return null;
		}
		
		public function get size(){
			return _size;
		}
		
		public function resetVertexIndex(){
			var cur:Node = _vertexs.head.next;
			var index:Number = 0;
			while (cur!=_vertexs.head){
				cur.data[0].index = index;
				if (index>1){
					cur.data[0].text = index.toString();
				}
				cur = cur.next;
				index++;
			}
		}
		
		public function toListGraph():ListGraph{
			var listGraph:ListGraph = new ListGraph(_size);
			return listGraph;
		}
		
		public function toMatrixGraph():MatrixGraph{
			var matrixGraph:MatrixGraph = new MatrixGraph(_size);
			resetVertexIndex();
			
			var iterator1:Node = _vertexs.head.next;
			while (iterator1 != _vertexs.head){
				var iterator2:Node = iterator1.data[1].head.next;
				while (iterator2 != iterator1.data[1].head){
					matrixGraph.changeEdge(Edge(iterator2.data).head.index,Edge(iterator2.data).tail.index,Edge(iterator2.data).value);	
					trace(Edge(iterator2.data).head.index,Edge(iterator2.data).tail.index,Edge(iterator2.data).value);
					iterator2 = iterator2.next;
				}
				iterator1 = iterator1.next;
			}
			return matrixGraph;
		}

	}
	
}
