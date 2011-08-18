package pushrelabel.algorithm
{
	public class State
	{

		public static const OP_INIT:int = 1;
		public static const OP_PUSH:int = 2;
		public static const OP_RELABEL:int = 3;
		public static const OP_FINISH:int = 4;

		private var _operation:int;
		private var _network:Network;
		private var _queue:Array;
		var _flowStart:int, _flowEnd:int;
		public var activeVertex:int;

		public function State(operation:int, _currentNetwork:Network, _queue:Array, activeVertex:int)
		{
			this._operation = operation;
			this._network = _currentNetwork.clone();
			this._queue = _queue.concat();
			this.activeVertex = activeVertex;
		}

		public function get flowStart():int {
			return _flowStart;
		}

		public function get flowEnd():int {
			return _flowEnd;
		}

		public function get queue():Array
		{
			return _queue;
		}

		public function get operation():int
		{
			return _operation;
		}

		public function get network():Network
		{
			return _network;
		}
	}
}