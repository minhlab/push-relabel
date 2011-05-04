package pushrelabel.ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class ConfirmDlg extends MovieClip {
		
		private var okCallback;
		private var cancelCallback;
		public function ConfirmDlg() {
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
			close();
			okCallback(this);			
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
		}
	}	
}
