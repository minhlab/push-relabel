package pushrelabel.environments
{

	import flash.display.MovieClip;
	import pushrelabel.algorithm.Graph;
	import flash.events.MouseEvent;
	import pushrelabel.objects.Tank;
	import pushrelabel.objects.Pipe;
	import pushrelabel.algorithm.Tracer;
	import pushrelabel.algorithm.MatrixGraph;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;


	public class SimulateEnvironment extends AbstractEnvironment
	{

		private var _playing:Boolean = false;
		private var _tracer:Tracer;
		private var _simArea:SimulationArea;
		private var _stateIndex:int = 0;
		private var playId:uint;

		public function SimulateEnvironment()
		{
			playBtn.addEventListener(MouseEvent.CLICK,playClick);
			pauseBtn.addEventListener(MouseEvent.CLICK,pauseClick);
			stopBtn.addEventListener(MouseEvent.CLICK,stopClick);
			nextBtn.addEventListener(MouseEvent.CLICK,nextClick);
			backBtn.addEventListener(MouseEvent.CLICK,backClick);
		}

		private function playSimulation()
		{
			if (sindex >= _tracer.getStateCount())
			{
				playing = false;
			}
			if (sindex < _tracer.getStateCount() - 1)
			{
				sindex++;
			}
		}

		public function playClick(e:MouseEvent)
		{
			if (playing)
			{
				return;
			}
			this.playing = true;
			playId = setInterval(playSimulation,500);
		}

		public function pauseClick(e:MouseEvent)
		{
			if (! playing)
			{
				return;
			}
			this.playing = false;
		}

		public function stopClick(e:MouseEvent)
		{
			if (! playing)
			{
				return;
			}
			this.playing = false;
			sindex = 0;
		}

		public function nextClick(e:MouseEvent)
		{
			this.playing = false;
			if (sindex < _tracer.getStateCount() - 1)
			{
				sindex++;
			}
		}
		public function backClick(e:MouseEvent)
		{
			this.playing = false;
			if (sindex > 0)
			{
				sindex--;
			}
		}

		public function get playing():Boolean
		{
			return _playing;
		}

		public function set playing(playing:Boolean)
		{
			if (_playing)
			{
				clearInterval(playId);
			}
			_playing = playing;
			playBtn.visible = ! _playing;
		}

		private function get sindex():int
		{
			return _stateIndex;
		}
		private function set sindex(i:int)
		{
			_stateIndex = i;
			_simArea.currentState = _tracer.getState(_stateIndex);
			_queue.queue = _simArea.currentState.queue;
		}

		override public function onEnter()
		{
			playing = false;
			if (_simArea != null)
			{
				removeChild(_simArea);
			}
			_graph = Main.instance.graph;
			_tracer = new Tracer(MatrixGraph(_graph));
			_simArea = new SimulationArea(this,_tracer.getState(sindex));
			sindex = 0;
			var scale:Number = Math.min(500 / _simArea.height,600 / _simArea.width);
			_simArea.scaleX = _simArea.scaleY = scale;
			_simArea.x = (600 - _simArea.width)/2
			_simArea.y = 20;
			this.addChild(_simArea);

		}
	}

}