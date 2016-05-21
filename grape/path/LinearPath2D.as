﻿/*
Copyright (c) 2009 Drew Cummins

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

package grape.path
{
	import flash.geom.Point;

	/**
	 * Linear
	 * 
	 * Line Segment = L = AB
	 * Vector v = B - A
	 * Point on segment at t [0,1] = L(t) = A + v * t
	 * */
	public class LinearPath2D extends Path2D
	{
		
		protected var A:Point;
		protected var v:Point;
		
		public function LinearPath2D( A:Point, B:Point )
		{
			
			super();
			
			this.A = A;
			v = B.subtract( A );
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			$solution[ 0 ] = A.x + v.x * t;
			$solution[ 1 ] = A.y + v.y * t;
		}
		
	}
}