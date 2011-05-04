package pushrelabel.algorithm
{
	public class Tracer
	{

		private var n:int;
		private var net:Network;
		private var _states:Array = new Array  ;
		private var _capacity:MatrixGraph;
		private var queue:Array = new Array  ;

		public function Tracer(capacity:MatrixGraph, source:int=1, sink:int=0)
		{
			n = capacity.size;
			net = new Network(capacity,new MatrixGraph(n),new Array(n),new Array(n),source,sink);
			solve();
		}

		private function saveState(op:int):State
		{
			var s:State = new State(op,net);
			_states.push(s);
			net = net.clone();
			//trace(s.network);
			return s;
		}

		private function solve()
		{
			init();
			while (queue.length > 0)
			{
				var u:int = queue.pop();
				var old:int = net._d[u];
				while (net._e[u] > 0 && net._d[u] == old)
				{
					pushRelabel(u);
				}
				if (net._d[u] > old)
				{
					queue.splice(0,0, u);
				}
			}
		}

		private function init()
		{
			var i:int,j:int,k:int;
			for (i = 0; i < n; i++)
			{
				net._e[i] = 0;
				net._d[i] = 0;
				for (j = 0; j < n; j++)
				{
					net._flow._matrix[i][j] = 0;
				}
			}
			net._d[net.s] = n;
			for (i = 0; i < n; i++)
			{
				var c = net._capacity._matrix[net.s][i];
				if (c > 0)
				{
					net._flow._matrix[net.s][i] = c;
					net._flow._matrix[i][net.s] =  -  c;
					net._e[net.s] -=  c;
					net._e[i] +=  c;
					queue.splice(0,0, i);
				}
			}
			saveState(State.OP_INIT);
		}

		private function pushRelabel(u:int)
		{
			var i:int,j:int,k:int;
			var m:int = 2 * n + 1;
			for (i = 0; i < n; i++)
			{
				if (net._capacity._matrix[u][i] > net._flow._matrix[u][i])
				{
					if (net._d[u] == net._d[i] + 1)
					{
						push(u, i);
						return;
					}
					m = Math.min(m,net._d[i]);
				}
			}
			relabel(u, m+1);
		}

		private function push(u:int, v:int)
		{
			var c:int = Math.min(net._e[u], net._capacity._matrix[u][v] - net._flow._matrix[u][v]);
			net._flow._matrix[u][v] +=  c;
			net._flow._matrix[v][u] -=  c;
			net._e[u] -=  c;
			net._e[v] +=  c;
			if (v != net.s && v != net.t) {
				queue.splice(0, 0, v);
			}
			saveState(State.OP_PUSH);
		}

		private function relabel(u:int, d:int)
		{
			net._d[u] = d;
			saveState(State.OP_RELABEL);
		}

		public function getStateCount()
		{
			return _states.length;
		}

		public function getState(i:int):State
		{
			return State(_states[i]);
		}

	}
}