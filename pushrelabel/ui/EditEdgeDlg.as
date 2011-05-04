package pushrelabel.ui {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	
	public class EditEdgeDlg extends MovieClip {
		
		
		private var okCallback;
		private var cancelCallback;
		public function EditEdgeDlg() {
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			okBtn.addEventListener(MouseEvent.CLICK, onOkClicked);
			cancelBtn.addEventListener(MouseEvent.CLICK, onCancelClicked);
		}
		
		public function onKeyDown(evt : KeyboardEvent) {
			if (evt.charCode == Keyboard.ENTER) {
				onOkClicked(null);
			}
		}

		public function onOkClicked(evt: MouseEvent)
		{
			if (parseInt(this.input.text) is Number){
				close();
				okCallback(this);
			}
		}

		public function onCancelClicked(evt: MouseEvent)
		{
			close();
			cancelCallback(this);
		}

		public function close() {
			parent.removeChild(this);
		}
	
		public function show(okCallback, cancelCallback)
		{
			this.okCallback = okCallback;
			this.cancelCallback = cancelCallback;
			x = 100;
			y = 50;
			Main.instance.addChild(this);
			stage.focus = input;
			input.text = "";
			input.restrict="0-9";
		}
		
		public function get capacity():Number{
			
			return parseInt(this.input.text);
		}
	}
	
}
