package pushrelabel.algorithm{
	import pushrelabel.algorithm.Graph;
	public class Network{
		
		private var _capacity:Graph; // maximum capacity map
		private var _flow:Graph; //flow map
		private var _d:Array; // height map
		private var _e:Array; // water amount in a point map
		
		public static const S:Number = 1;
		public static const T:Number;
		
		public function Network(capacity:Graph = null,flow:Graph = null,d:Array = null,e:Array = null){
			_capacity = capacity;
			_flow = flow;
			_d = d;
			_e = e;
		}
	}
}