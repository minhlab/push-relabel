package pushrelabel.algorithm {
	
	import pushrelabel.algorithm.Node;
	import pushrelabel.algorithm.LinkedList;
	
	public class ListGraph extends Graph{

		private var _list:Array;
		private var _index:Number = 0;
		public function ListGraph(size:Number = 2){
			_list = new Array();
			_size = size; 
			for (var i:Number = 0;i<_size;i++){
				_list.push(new LinkedList());
				_index++;
			}
		}
		
		public function findEdge(headVertex:Number,tailVertex:Number):Node{
			if (_list[headVertex] == null){
				return null;
			}else{
				var cur:Node = _list[headVertex].head.next;
				while (cur!=_list[headVertex].head){
					if (cur.data[0] == tailVertex){
						return cur;
					}
					cur = cur.next;
				}
				return null;				
			}			
		}
		
		override public function addVertext(){
			_list.push(new LinkedList());
			_index++;
			_size++;
		}
		
		public function removeVertex(headVertex:Number):Boolean{
			if ((headVertex < _index)&&(_list[headVertex] != null)){
				_list[headVertex] = null;
				for (var i:Number = 0;i<_index;i++){
					removeEdge(i,headVertex);
				}
				return true;
			} else {
				return false;
			}
		}
				
		override public function changeEdge(headVertex:Number,tailVertex:Number,value:Number):Boolean{
			if ((headVertex < _index)&&(tailVertex < _index)&&(value>=0)&&(_list[headVertex] != null)){
				if (value == 0){
					removeEdge(headVertex,tailVertex);
				//} else if (_list[headVertex] == null) { return false;
				} else {
					var cur:Node = findEdge(headVertex,tailVertex);
					if (cur == null){
						_list[headVertex].addLast(new Array(tailVertex,value));
					}else{
						cur.data[1] = value;
					}
				}
				return true;
			} else {
				return false;
			}
		}
		
		override public function removeEdge(headVertex:Number,tailVertex:Number):Boolean{
			if ((headVertex < _index)&&(tailVertex < _index)&&(_list[headVertex] != null)){
				var cur:Node = findEdge(headVertex,tailVertex);
				if (cur == null){
					return false;
				}else{
					_list[headVertex].remove(cur.data);
				}
				return true;
			} else {
				return false;
			}
		}
		
		override public function getEdgeValue(headVertex:Number,tailVertex:Number):Number {
			if ((headVertex < _index)&&(tailVertex < _index)&&(_list[headVertex] != null)){
				var cur:Node = findEdge(headVertex,tailVertex);
				if (cur == null){
					return -1;
				}else{
					return cur.data[1];
				}
			} else {
				return -1;
			}
		}
		
		public function toMatrixGraph(){
			
		}

	}
	
}
