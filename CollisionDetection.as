/**
* GTween by Grant Skinner. Aug 1, 2005
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
*
* Copyright (c) 2005 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*
*
* This code was modificated by BlackCat team. ^__^
**/

package 
{
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	class CollisionDetection {
		
		static public function checkForCollision(p_clip1:MovieClip,p_clip2:MovieClip,
												 p_alphaTolerance:Number=255):Object {

			// get bounds:
			var bounds1:Object = p_clip1.getBounds(p_clip1.parent);
			var bounds2:Object = p_clip2.getBounds(p_clip2.parent);

			// rule out anything that we know can't collide:
			if (((bounds1.x+bounds1.width < bounds2.x) || (bounds2.x+bounds2.width < bounds1.x)) || 
				((bounds1.y+bounds1.height < bounds2.y) || (bounds2.y+bounds2.height < bounds1.y)) )
			{
				return null;
			}

			// determine test area boundaries:
			var bounds:Object = {};
			bounds.xMin = Math.max(bounds1.x,bounds2.x);
			bounds.xMax = Math.min(bounds1.x+bounds1.width,bounds2.x+bounds2.width);
			bounds.yMin = Math.max(bounds1.y,bounds2.y);
			bounds.yMax = Math.min(bounds1.y+bounds1.height,bounds2.y+bounds2.height);
			
			var imgW:int = bounds.xMax-bounds.xMin;
			var imgH:int = bounds.yMax-bounds.yMin;
			
			if (imgW < 1) {imgW = 1};
			if (imgH < 1) {imgH = 1};
			
			// set up the image to use:
			try {
				var img:BitmapData = new BitmapData(imgW,imgH,false);			
			}
			catch (error:ArgumentError) {
				trace(error);
				trace(img, imgW, imgH);
			}
			
			// draw in the first image:
			var mat:Matrix = p_clip1.transform.concatenatedMatrix;
			mat.tx -= bounds.xMin;
			mat.ty -= bounds.yMin;
			var ct:ColorTransform = new ColorTransform(1,1,1,1,255,-255,-255,p_alphaTolerance);
			img.draw(p_clip1,mat,ct);
			
			// overlay the second image:
			mat = p_clip2.transform.concatenatedMatrix;
			mat.tx -= bounds.xMin;
			mat.ty -= bounds.yMin;
			ct = new ColorTransform(1,1,1,1,255,255,255,p_alphaTolerance);
			img.draw(p_clip2,mat,ct,"difference");

			// find the intersection:
			var intersection:Rectangle = img.getColorBoundsRect(0xFFFFFFFF,0xFF00FFFF);
			
			// if there is no intersection, return null:
			if (intersection.width == 0)
			{
				return null;
			}

			// adjust the intersection to account for the bounds:
			intersection.x +=  bounds.xMin;
			intersection.y +=  bounds.yMin;

			return intersection;
		}
		
	}

}