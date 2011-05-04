package pushrelabel.objects {
	
	import flash.display.MovieClip;
	import pushrelabel.objects.PipeHorizontal;
	import pushrelabel.objects.PipeVertical;
	import pushrelabel.objects.PipeL;
	import pushrelabel.objects.PipeLInvert;
	import flash.geom.ColorTransform;
	import flash.display.DisplayObject;
	
	public class Pipe extends MovieClip {
		
		private var _distanceX:Number = 0;
		private var _distanceY:Number = 0;
		public static var blockSize:Number = 50;
		private var flowColor:ColorTransform = new ColorTransform(0,0,0,0,0x66,0xCC,0xFF,0xFF);
		private var color:ColorTransform = new ColorTransform(0,0,0,0,0x6F,0x7A,0x9B,0xFF);
		public function Pipe() {
			// constructor code
		}
		
		public function drawPipe(){
			while (this.numChildren>0){
				this.removeChildAt(0);
			}
			var i:int = 0;
			var lInvertPipe, lPipe;

			for (i = 0; i<_distanceY;i++){
				var hPipe:PipeVertical = new PipeVertical();
				hPipe.x = 0;
				hPipe.y = i*blockSize;
				this.addChild(hPipe);
			}
			
			if (_distanceX > 0) {
				
				lPipe = new PipeL();
				lPipe.x = 0;
				lPipe.y = i*blockSize;
				this.addChild(lPipe);
				
				for (i = 1; i<_distanceX-1;i++){
					var wPipe:PipeHorizontal = new PipeHorizontal();
					wPipe.x = i*blockSize;
					wPipe.y = lPipe.y+blockSize/2;
					this.addChild(wPipe);
				}
				
				lInvertPipe = new PipeLInvert();
				lInvertPipe.x = i*blockSize;
				lInvertPipe.y = lPipe.y;
				this.addChild(lInvertPipe);
				
			} else {
				
				lInvertPipe = new PipeLInvert();
				lInvertPipe.x = i*blockSize;
				lInvertPipe.y = i*blockSize;
				this.addChild(lInvertPipe);
				
				for (i = -1; i>_distanceX-1;i--){
					var wPipe:PipeHorizontal = new PipeHorizontal();
					wPipe.x = i*blockSize;
					wPipe.y = lInvertPipe.y+blockSize/2;
					this.addChild(wPipe);
				}
				
				lPipe = new PipeL();
				lPipe.x = 0;
				lPipe.y = lInvertPipe.y;
				this.addChild(lPipe);
				
			}
		}
		
		public function startFlow(){
			for (var i:Number = 0; i<this.numChildren;i++){
				var temp:DisplayObject = this.getChildAt(i);
				if(temp is PipeElement){
					PipeElement(temp).setFlowColor(flowColor);
				}
			}
		}
		
		public function left(){
			
		}
		
		public function right(){
			
		}
		
		public function stopFlow(){
			for (var i:Number = 0; i<this.numChildren;i++){
				var temp:DisplayObject = this.getChildAt(i);
				if(temp is PipeElement){
					PipeElement(temp).setFlowColor(color);
				}
			}
		}
		
		public function get distanceX():Number{
			return _distanceX;
		}
		
		public function get distanceY():Number{
			return _distanceY;
		}
		
		public function set distanceX(distanceX:Number){
			_distanceX = distanceX;
		}
		
		public function set distanceY(distanceY:Number){
			_distanceY = distanceY;
		}
	}
	
}
