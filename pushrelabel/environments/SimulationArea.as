package pushrelabel.environments {
	
	import flash.display.MovieClip;
	import pushrelabel.algorithm.Graph;
	import pushrelabel.algorithm.State;
	import pushrelabel.algorithm.MatrixGraph;
	import pushrelabel.algorithm.Network;
	import pushrelabel.objects.Tank;
	import pushrelabel.objects.Pipe;
	
	
	public class SimulationArea extends MovieClip {
		
		public static var blockSize:Number = 50;
		
		private var _currentState:State;		
		private var _environment:SimulateEnvironment;
		private var _network:Network;
		private var _tanks:Array;
		private var _pipes:Array;
		
		public function SimulationArea(environment:SimulateEnvironment,network:Network) {
			_environment = environment;
			_network = network;
			// constructor code
			init();
		}
		
		public function init(){
			var i:int, j:int;

			_tanks= new Array(_network.n);

			var tTank:Tank = new Tank();
			tTank.x = getXofIndex(0);
			tTank.y = getYofHeight(0);
			this.tankLayer.addChild(tTank);
			_tanks[0] = tTank;
			
			var sTank:Tank = new Tank();
			sTank.x = getXofIndex(1);
			sTank.y = getYofHeight(_network.capacity.size-1);
			this.tankLayer.addChild(sTank);
			_tanks[1] = sTank;
			
			for (i=2;i<_network.capacity.size;i++){
				var tank:Tank = new Tank();
				tank.x = getXofIndex(i);
				tank.y = getYofHeight(0);
				this.tankLayer.addChild(tank);
				_tanks[i] = tank;
			}
			
			_pipes = new Array(_network.n);
			for (i = 0; i < _network.n; i++) {
				_pipes[i] = new Array(_network.n);
				for (j = 0; j < _network.n; j++) {
					if (_network.capacity.getEdgeValue(i, j) > 0) {
						var pipe : Pipe = new Pipe();
						pipe.x = _tanks[i].x + _tanks[i].width / 2;
						pipe.y = _tanks[i].y + _tanks[i].height;
						pipe.distanceX = _tanks[j].x - _tanks[i].x;
						pipe.distanceY = _tanks[j].y - _tanks[i].y;
						pipe.drawPipe();
						pipeLayer.addChild(pipe);
						_pipes[i][j] = pipe;
					}
				}
			}
		}
		
		public function getYofHeight(h:Number):Number{
			return (_network.n*2-2-h)*blockSize*2;
		}
		
		public function getXofIndex(index:Number):Number{
			if(index == 0){
				return (_network.capacity.size-1)*150;
			}else{
				return (index-1)*150;
			}
		}
		
		public function set currentState(currentState:State){
			_currentState = currentState;
			
		}
	}
	
}
