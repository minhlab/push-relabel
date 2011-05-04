package pushrelabel.environments {
	
	import flash.display.MovieClip;
	import pushrelabel.algorithm.Graph;
	import flash.events.MouseEvent;
	import pushrelabel.objects.Tank;
	import pushrelabel.objects.Pipe;
	import pushrelabel.algorithm.Tracer;
	import pushrelabel.algorithm.MatrixGraph;
	
	
	public class SimulateEnvironment extends AbstractEnvironment {

		private var _playing:Boolean = false;
		private var _tracer:Tracer;
		private var _simArea:SimulationArea;
		private var _stateIndex:int = 0;
		
		public function SimulateEnvironment() {			
			playBtn.addEventListener(MouseEvent.CLICK,playClick);
			pauseBtn.addEventListener(MouseEvent.CLICK,pauseClick);
			stopBtn.addEventListener(MouseEvent.CLICK,stopClick);
			nextBtn.addEventListener(MouseEvent.CLICK,nextClick);
			backBtn.addEventListener(MouseEvent.CLICK,backClick);
		}
		
		public function playClick(e:MouseEvent){
			this.playing = true;
		}
		public function pauseClick(e:MouseEvent){
			this.playing = false;
		}
		public function stopClick(e:MouseEvent){
			this.playing = false;
		}
		public function nextClick(e:MouseEvent){
			this.playing = false;
			if (_stateIndex < _tracer.getStateCount()-1) {
				_stateIndex++;
				trace(_tracer.getState(_stateIndex).network);
				_simArea.currentState = _tracer.getState(_stateIndex);
			}
		}
		public function backClick(e:MouseEvent){
			this.playing = false;
		}
		
		public function set playing(playing:Boolean){
			_playing = playing;
			playBtn.visible = !_playing;
		}
		
		override public function onEnter(){
			_graph = Main.instance.graph;
			_tracer = new Tracer(MatrixGraph(_graph));
			_simArea = new SimulationArea(this,_tracer.getState(0).network);
			var scale:Number = Math.min(_simArea.height/height,_simArea.width/width);
			_simArea.scaleX = _simArea.scaleY = scale;
			this.addChild(_simArea);
			
		}
	}
	
}
