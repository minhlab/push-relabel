package pushrelabel.algorithm
{
	import pushrelabel.algorithm.Graph;
	public class Network
	{

		private var _source:int;
		private var _sink:int;
		var _capacity:MatrixGraph;// maximum capacity map
		var _flow:MatrixGraph;//flow map
		var _d:Array;// height map
		var _e:Array;// water amount in a point map

		public function Network(capacity:MatrixGraph = null,flow:MatrixGraph = null,d:Array = null,e:Array = null,source:int=1,sink:int=0)
		{
			_capacity = capacity;
			_flow = flow;
			_d = d;
			_e = e;
			_source = source;
			_sink = sink;
		}

		public function clone():Network
		{
			var net:Network = new Network  ;
			net._capacity = _capacity;
			net._flow = MatrixGraph(_flow.clone());
			net._d = _d.concat();
			net._e = _e.concat();
			return net;
		}

		public function get capacity():MatrixGraph
		{
			return _capacity;
		}

		public function get flow():MatrixGraph
		{
			return _flow;
		}

		public function get d():Array
		{
			return _d;
		}

		public function get e():Array
		{
			return _e;
		}

		public function get s():int
		{
			return _source;
		}

		public function get t():int
		{
			return _sink;
		}

		public function get source():int
		{
			return _source;
		}

		public function get sink():int
		{
			return _sink;
		}

		public function toString():String
		{
			var s:String = "";
			var i;
			s +=  "Flow:\n" + _flow;
			s += "d[i] = ";
			for (i = 0; i < _d.length; i++)
			{
				s +=  _d[i] + " ";
			}
			s +=  "\n";
			s += "e[i] = ";
			for (i = 0; i < _e.length; i++)
			{
				s +=  _e[i] + " ";
			}
			s +=  "\n";
			return s;
		}

		public function get n():int {
			return _capacity.size;
		}
	
	}
}