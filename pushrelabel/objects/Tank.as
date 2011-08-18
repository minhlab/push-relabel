package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import pushrelabel.objects.Water;
	import flash.events.Event;
	
	public class Tank extends MovieClip {
		
		private var _waterLevel:Number = 0;		
		private var _waterMC:Water;
		public function Tank() {
			_waterMC = new Water();
			_waterMC.width = this.width-6;
			_waterMC.x = 3;
			_waterMC.height = 1;//_waterLevel*this.height;
			this.addChildAt(_waterMC,0);	
			//this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		public function onEnterFrame(e:Event){
			if (_waterMC.height != _waterLevel*this.height){
				_waterMC.height -= 10*(_waterMC.height-_waterLevel*this.height)/Math.abs(_waterMC.height-_waterLevel*this.height);
				_waterMC.y = this.height - _waterMC.height-3;
			}
		}
		
		public function drawWater(){
			_waterMC.height = _waterLevel*this.height;
			_waterMC.y = this.height - _waterMC.height-3;
		}
		
		public function get waterLevel():Number{
			return _waterLevel;
		}
		
		public function set waterLevel(waterLevel:Number){
			_waterLevel = waterLevel;
			drawWater();
		}
		
		public function set text(text:String){
			waterAmount.text = text;
		}
		public function get text():String{
			return waterAmount.text;
		}
	}
	
}
