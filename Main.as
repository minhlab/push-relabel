package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import pushrelabel.environments.AbstractEnvironment;
	import pushrelabel.environments.InitEnvironment;
	import pushrelabel.environments.SimulateEnvironment;
	import flash.events.MouseEvent;
	import pushrelabel.algorithm.Graph;
	import pushrelabel.algorithm.ListGraph;
	import pushrelabel.algorithm.MatrixGraph;
	
	
	public class Main extends MovieClip {
		
		private var _activeEnvironment:AbstractEnvironment = null;
		private var _environments:Array;
		
		private var _nameBtn:Array = new Array("Bắt đầu","Làm lại");
		
		private var _graph:Graph;
		
		
		
		public function Main() {
			_instance = this;
			initGraph();
			initEnvironments();
			
			changeBtn.addEventListener(MouseEvent.CLICK,onChangeBtnClick);
		}
		
		public function initGraph(){
			_graph = new ListGraph();
		}
		
		public function initEnvironments(){			
			var initation:InitEnvironment = new InitEnvironment();
			var simulation:SimulateEnvironment = new SimulateEnvironment();
			
			_environments = new Array(initation,simulation);
			_activeEnvironment = _environments[0];
			
			this.addChildAt(_activeEnvironment,1);					
			_activeEnvironment.onEnter();
		}

		public function onChangeBtnClick(e:MouseEvent){
			this.removeChild(_activeEnvironment);
			_activeEnvironment.onLeave();
			
			var index:Number = ((_environments.indexOf(_activeEnvironment)+1)%2);
			_activeEnvironment = _environments[index];
			changeBtn.setText(_nameBtn[index]);
			
			this.addChildAt(_activeEnvironment,1);		
			_activeEnvironment.onEnter();
			
		}
		
		private static var _instance:Main;

		public static function get instance():Main
		{
			return _instance;
		}
		
		public function get graph():Graph{
			return _graph;
		}
		public function set graph(g:Graph){
			_graph = g;
		}
		
	}
	
}
