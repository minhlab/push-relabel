package pushrelabel.algorithm {
	
	public class LinkedList {

		private var _head:Node;
		private var _count;
		
		public function LinkedList() {
			_head = new Node();
			_head.next = _head;
			_head.prev = _head;
			_count = 0;
		}
		
		public function add(data:*,index:Number){			
			if (index < _count){
				if (index<=0){
					addFirst(data);
				}else{
					var cur:Node = findAt(index).prev;
					if (cur != null){						
						var newNode:Node = new Node(cur.next,cur,data);
						cur.next.prev = newNode;
						cur.next = newNode;
						_count++;
					}
				}
			}else{
				addLast(data);
			}			
		}	
		
		public function removeAt(index:Number):Node{
			if ((index < _count) && (index >= 0)){
				if (index == 0){
					return removeFirst();
				} else if (index == _count-1){
					return removeLast();
				} else {
					var cur:Node = findAt(index);
					cur.prev.next = cur.next;
					cur.next.prev = cur.prev;
					return cur;
				}
			}else return null;
		}
		
		public function remove(data:*):Node{
			var cur:Node = findFirst(data);
			if (cur!=null){
				cur.prev.next = cur.next;
				cur.next.prev = cur.prev;
				return cur;
			} else {
				return null;
			}
		}
		
		public function removeLast():Node{
			if (_count>0){
				var temp:Node = _head.prev;
				_head.prev.prev.next = _head;
				_head.prev = _head.prev.prev;
				return temp;
			} else return null;
		}
		
		public function removeFirst():Node{
			if (_count>0){
				var temp:Node = _head.next;
				_head.next.next.prev = _head;
				_head.next = _head.next.next;
				return temp;
			} else return null;
		}
		
		public function addLast(data:*){
			var newNode:Node = new Node(_head,_head.prev,data);
			_head.prev.next = newNode;
			_head.prev = newNode;
			_count++;
		}
		
		public function addFirst(data:*){
			var newNode:Node = new Node(_head.next,_head,data);
			_head.next.prev = newNode;
			_head.next = newNode;
			_count++;
		}
		
		public function findAt(index:Number):Node{
			if ((index>=0)&&(index<_count)){
				var found:Node = _head.next;
				for (var i:Number=0;i<index;i++){
					found = found.next;
				}
				return found;
			}else return null;
		}

		public function findFirst(data:*):Node{
			var found:Node = _head.next;
			while (found!=head){
				if (found.data == data){
					return found;
				}
				found = found.next;
			}
			return null;
		}
		
		public function findLast(data:*):Node{
			var found:Node = _head.prev;
			while (found!=head){
				if (found.data == data){
					return found;
				}
				found = found.prev;
			}
			return null;
		}
		
		public function get head():Node{
			return _head;
		}
		public function get rear():Node{
			return _head.prev;
		}

	}
	
}
