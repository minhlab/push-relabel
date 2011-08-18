package pushrelabel.environments
{

	import flash.display.MovieClip;
	import pushrelabel.algorithm.Graph;
	import pushrelabel.algorithm.State;
	import pushrelabel.algorithm.MatrixGraph;
	import pushrelabel.algorithm.Network;
	import pushrelabel.objects.Tank;
	import pushrelabel.objects.Pipe;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;


	public class SimulationArea extends MovieClip
	{

		public static var blockSize:Number = 50;

		private var _currentState:State;
		private var _environment:SimulateEnvironment;
		private var _tanks:Array;
		private var _pipes:Array;
		private var _glow:GlowFilter = new GlowFilter(0x66CCFF,0.7,20,20,3,3,false,false);

		public function SimulationArea(environment:SimulateEnvironment,state:State)
		{
			_environment = environment;
			_currentState = state;
			drawLines();
			update();
		}
		
		private function drawLines() {
			var textFormat: TextFormat = new TextFormat("Tahoma", 24, 0, true);
			graphics.lineStyle(1, 0xC0C0C0, 0xC0);
			var n = _currentState.network.n;
			for (var i = 0; i < n*2-1; i++) {
				var y = (2*n-2-i+0.5)*blockSize*2;
				var txt:TextField= new TextField();
				txt.text = i;
				txt.x = n * blockSize * 3 + 10;
				txt.y = y-18;
				txt.setTextFormat(textFormat);
				addChild(txt);
				graphics.moveTo(-10, y);
				graphics.lineTo(n * blockSize * 3, y);
			}
		}

		private function removeAllChild(l:MovieClip)
		{
			while (l.numChildren > 0)
			{
				l.removeChildAt(0);
			}
		}

		private function clear()
		{
			removeAllChild(tankLayer);
			removeAllChild(pipeLayer);
		}

		public function update()
		{
			var i:int,j:int;
			var maxAmount = 0;
			for (i = 0; i < _currentState.network.n; i++)
			{
				maxAmount +=  currentState.network.capacity.getEdgeValue(_currentState.network.s,i);
			}

			clear();
			_tanks = new Array(net.n);

			var tTank:Tank = new Tank();
			tTank.x = getXofIndex(0);
			tTank.y = getYofHeight(0);
			tTank.waterLevel = net.e[0] / maxAmount;
			this.tankLayer.addChild(tTank);
			_tanks[0] = tTank;

			var sTank:Tank = new Tank();
			sTank.x = getXofIndex(1);
			sTank.y = getYofHeight(net.n - 1);
			sTank.waterLevel = net.e[1] / maxAmount;
			this.tankLayer.addChild(sTank);
			_tanks[1] = sTank;

			for (i=2; i<net.capacity.size; i++)
			{
				var tank:Tank = new Tank();
				tank.x = getXofIndex(i);
				tank.y = getYofHeight(net.d[i]);
				tank.waterLevel = net.e[i] / maxAmount;
				if (i == _currentState.activeVertex) {
					tank.filters = new Array(_glow);
				}
				this.tankLayer.addChild(tank);
				_tanks[i] = tank;
			}

			_pipes = new Array(net.n);
			for (i = 0; i < net.n; i++)
			{
				_pipes[i] = new Array(net.n);
				for (j = 0; j < net.n; j++)
				{
					if (net.capacity.getEdgeValue(i,j) > 0)
					{
						var pipe : Pipe = new Pipe();
						pipe.x = _tanks[i].x + _tanks[i].width / 2;
						pipe.y = _tanks[i].y + _tanks[i].height;
						pipe.distanceX = (_tanks[j].x - _tanks[i].x)/blockSize;
						pipe.distanceY = (_tanks[j].y - _tanks[i].y)/blockSize;
						pipe.text = net.flow.getEdgeValue(i,j) + "/" + net.capacity.getEdgeValue(i,j);
						pipe.drawPipe();
						pipeLayer.addChild(pipe);
						_pipes[i][j] = pipe;
					}
				}
			}
			
			if (_currentState.operation == State.OP_PUSH) {
				var pipe:Pipe = _pipes[_currentState.flowStart][_currentState.flowEnd];
				if (pipe == null) {
					pipe = _pipes[_currentState.flowEnd][_currentState.flowStart];
				}
				pipe.startFlow();
			}
		}

		private function get net():Network
		{
			return _currentState.network;
		}

		public function getYofHeight(h:Number):Number
		{
			return (net.n*2-2-h)*blockSize*2;
		}

		public function getXofIndex(index:Number):Number
		{
			if (index == 0)
			{
				return (net.capacity.size-1)*150;
			}
			else
			{
				return (index-1)*150;
			}
		}

		public function get currentState():State
		{
			return _currentState;

		}

		public function set currentState(currentState:State)
		{
			_currentState = currentState;
			update();
		}
	}

}