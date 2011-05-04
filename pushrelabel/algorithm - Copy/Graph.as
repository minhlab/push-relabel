package pushrelabel.algorithm{
	import flash.errors.IllegalOperationError;

	public class Graph{
		
		protected var _size;
		public function Graph(size:Number = 2){}
		
		public function addVertext(){}
		
		public function changeEdge(headVertex:Number,tailVertex:Number,value:Number):Boolean{
			throw new IllegalOperationError("This is an abstract method");
		}
		
		public function removeEdge(headVertex:Number,tailVertex:Number):Boolean{
			throw new IllegalOperationError("This is an abstract method");
		}
		
		public function getEdgeValue(headVertex:Number,tailVertex:Number):Number {
			throw new IllegalOperationError("This is an abstract method");
		}
	}
}