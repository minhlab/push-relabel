package pushrelabel.algorithm
{
	public class State
	{

		public static const OP_INIT:int = 1;
		public static const OP_PUSH:int = 1;
		public static const OP_RELABEL:int = 2;

		private var _operation:int;
		private var _network:Network;

		public function State(operation:int, _currentNetwork:Network)
		{
			this._operation = operation;
			this._network = _currentNetwork;
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