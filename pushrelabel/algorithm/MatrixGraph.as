﻿package pushrelabel.algorithm
{

	import pushrelabel.algorithm.MatrixGraph;

	public class MatrixGraph extends Graph
	{

		var _matrix:Array;

		public function MatrixGraph(size:Number = 2)
		{
			_matrix = new Array();
			_size = size;
			for (var i:Number = 0; i<_size; i++)
			{
				var temp:Array = new Array();
				for (var j:Number = 0; j<_size; j++)
				{
					temp.push(0);
				}
				_matrix.push(temp);
			}
		}

		override public function addVertext()
		{
			_size++;
			var temp:Array = new Array();
			for (var i:Number = 0; i<_size-1; i++)
			{
				_matrix[i].push(0);
				temp.push(0);
			}
			temp.push(0);
			_matrix.push(temp);
		}

		override public function changeEdge(headVertex:Number,tailVertex:Number,value:Number):Boolean
		{
			if ((headVertex < _size)&&(tailVertex < _size)&&(value>=0))
			{
				_matrix[headVertex][tailVertex] = value;
				return true;
			}
			else
			{
				return false;
			}
		}

		override public function removeEdge(headVertex:Number,tailVertex:Number):Boolean
		{
			return changeEdge(headVertex,tailVertex,0);
		}

		override public function getEdgeValue(headVertex:Number,tailVertex:Number):Number
		{
			if ((headVertex < _size)&&(tailVertex < _size))
			{
				return _matrix[headVertex][tailVertex];
			}
			else
			{
				return -1;
			}
		}

		public function toListGraph()
		{

		}

		public override function clone(): Graph
		{
			var g:MatrixGraph = new MatrixGraph();
			g._size = _size;
			g._matrix = _matrix.concat();
			for (var i = 0; i < _size; i++) {
				g._matrix[i] = g._matrix[i].concat();
			}
			return g;
		}
		
		public function get(row:int, col:int):int {
			return int(_matrix[row][col]);
		}
		
		public function toString():String {
			var s = "";
			for (var i = 0; i < _size; i++) {
				for (var j = 0; j < _size; j++) {
					s += _matrix[i][j] + " ";
				}
				s += "\n";
			}
			return s;
		}
		
		public function toSString():String {
			var s = "";
			for (var i = 0; i < _size; i++) {
				for (var j = 0; j < _size; j++) {
					s += _matrix[i][j] + " ";
				}
				s += "\r\n";
			}
			return s;
		}
	}

}