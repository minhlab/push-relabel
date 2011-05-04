package pushrelabel.algorithm {
	
	public class Node {

		private var _next:Node;
		private var _prev:Node;
		private var _data:*;
		
		public function Node(next:Node = null, prev:Node = null, data:* = null) {
			// constructor code
			_prev = prev;
			_next = next;
			_data = data;
		}
		
		public function get next():Node{
			return _next;
		}
		public function get prev():Node{
			return _prev;
		}
		public function get data():*{
			return _data;
		}
		public function set next(next:Node){
			_next = next;
		}
		public function set prev(prev:Node){
			_prev = prev;
		}
		public function set data(datat:Node){
			_data = data;
		}

	}
	
}
