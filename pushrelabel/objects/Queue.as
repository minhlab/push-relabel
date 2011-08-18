package pushrelabel.objects
{

	import flash.display.MovieClip;


	public class Queue extends MovieClip
	{

		private var q:Array;

		public function Queue()
		{

		}

		public function set queue(q:Array)
		{
			while (numChildren > 1) {
				removeChildAt(1);
			}
			this.q = q;
			//trace(q.length);
			for (var i = 0; i < q.length; i++)
			{
				var v = new Vertex(q[i],q[i].toString());
				v.x = 20;
				v.y = (v.height + 10) * i + 10;
				addChild(v);
			}
		}
	}

}