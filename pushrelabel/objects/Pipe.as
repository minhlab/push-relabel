package pushrelabel.objects
{

	import flash.display.MovieClip;
	import pushrelabel.objects.PipeHorizontal;
	import pushrelabel.objects.PipeVertical;
	import pushrelabel.objects.PipeL;
	import pushrelabel.objects.PipeLInvert;
	import flash.geom.ColorTransform;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flashx.textLayout.formats.TextAlign;
	import flash.events.MouseEvent;

	public class Pipe extends MovieClip
	{

		private var _distanceX:Number = 0;
		private var _distanceY:Number = 0;

		private var _textField:TextField;
		var textFormat:TextFormat = new TextFormat("Tahoma",21,0x11111111,true,false,false,null,null,TextAlign.CENTER,null,null,null,null);

		public static var blockSize:Number = 50;
		private var flowColor:ColorTransform = new ColorTransform(0,0,0,0,0x66,0xCC,0xFF,0xFF);
		private var color:ColorTransform = new ColorTransform(0,0,0,0,0x6F,0x7A,0x9B,0xFF);
		public function Pipe()
		{
			// constructor code
			_textField = new TextField();
			_textField = new TextField();
			_textField.mouseEnabled = false;
			_textField.selectable = false;
			_textField.x = 0;
			_textField.y = 0;
			_textField.width = 70;
			_textField.height = 30;
			_textField.border = true;
			addEventListener(MouseEvent.MOUSE_DOWN, pipeOnMouseDown);
		}

		public function pipeOnMouseDown(evt:MouseEvent)
		{
			var parent = this.parent;
			parent.removeChild(this);
			parent.addChild(this);
		}

		public function drawPipe()
		{
			while (this.numChildren>0)
			{
				this.removeChildAt(0);
			}
			var i:int = 0;
			var lInvertPipe,lPipe;
			var hPipe:PipeHorizontal;
			var vPipe:PipeVertical;


			for (i = 0; i<_distanceY; i++)
			{
				vPipe = new PipeVertical();
				vPipe.x = 0;
				if (_distanceX < 0)
				{
					vPipe.x +=  blockSize / 2;
				}
				vPipe.y = i * blockSize;
				this.addChild(vPipe);
			}

			for (i = -1; i>=_distanceY; i--)
			{
				vPipe = new PipeVertical();
				vPipe.x = (_distanceX-1)*blockSize;
				if (_distanceX > 0)
				{
					vPipe.x +=  blockSize / 2;
				}
				vPipe.y = i * blockSize;
				this.addChild(vPipe);
			}


			if (_distanceX > 0)
			{
				lPipe = new PipeL();
				lPipe.x = 0;
				lPipe.y = Math.max(0,_distanceY * blockSize);
				this.addChild(lPipe);

				for (i = 1; i<_distanceX-1; i++)
				{
					hPipe = new PipeHorizontal();
					hPipe.x = i * blockSize;
					hPipe.y = lPipe.y + blockSize / 2;
					this.addChild(hPipe);
				}

				lInvertPipe = new PipeLInvert();
				lInvertPipe.x = i * blockSize;
				lInvertPipe.y = lPipe.y;
				this.addChild(lInvertPipe);
			}
			else
			{
				lInvertPipe = new PipeLInvert();
				lInvertPipe.x = 0;
				lInvertPipe.y = Math.max(0,_distanceY * blockSize);
				this.addChild(lInvertPipe);

				for (i = -1; i>_distanceX-1; i--)
				{
					hPipe = new PipeHorizontal();
					hPipe.x = i * blockSize;
					hPipe.y = lInvertPipe.y + blockSize / 2;
					this.addChild(hPipe);
				}

				lPipe = new PipeL();
				lPipe.x = i * blockSize;
				lPipe.y = lInvertPipe.y;
				this.addChild(lPipe);
			}

			_textField.x = _distanceX * blockSize / 2 - _textField.width / 2;
			_textField.y = Math.max(0,_distanceY * blockSize) + 22;

			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(3,0x000000);
			mc.graphics.beginFill(0xffffff);
			mc.graphics.drawRect(0,0,_textField.width,_textField.height);
			mc.graphics.endFill();
			mc.x = _textField.x;
			mc.y = _textField.y;
			this.addChild(mc);

			this.addChild(_textField);
		}

		public function startFlow()
		{
			for (var i:Number = 0; i<this.numChildren; i++)
			{
				var temp:DisplayObject = this.getChildAt(i);
				if (temp is PipeElement)
				{
					PipeElement(temp).setFlowColor(flowColor);
				}
			}
		}

		public function left()
		{

		}

		public function right()
		{

		}

		public function stopFlow()
		{
			for (var i:Number = 0; i<this.numChildren; i++)
			{
				var temp:DisplayObject = this.getChildAt(i);
				if (temp is PipeElement)
				{
					PipeElement(temp).setFlowColor(color);
				}
			}
		}

		public function get distanceX():Number
		{
			return _distanceX;
		}

		public function get distanceY():Number
		{
			return _distanceY;
		}

		public function set distanceX(distanceX:Number)
		{
			_distanceX = distanceX;
		}

		public function set distanceY(distanceY:Number)
		{
			_distanceY = distanceY;
		}

		public function set text(text:String)
		{
			_textField.text = text;
			_textField.setTextFormat(textFormat);
		}
		public function get text():String
		{
			return _textField.text;
		}
	}

}