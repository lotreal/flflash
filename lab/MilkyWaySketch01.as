/*
* 七夕なので星空作ってみた
*
* レベル補正でこちらを参考にさせて頂きました
* http://wonderfl.net/code/37e0963030d17ebe8b321c254160c7f82a439b91
* 元ネタはPhotoShopのチュートリアル
* http://psd.tutsplus.com/text-effects-tutorials/a-slick-supernatural-text-effect/
*/
package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	[SWF(frameRate=30, backgroundColor="#000000")]
	public class MilkyWaySketch01 extends Sprite
	{
		private var _starBmpd:BitmapData;
		private var _backBmpd:BitmapData;
		public function MilkyWaySketch01()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			stage.align = "TL";
			stage.scaleMode = "noScale";
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// back
			_backBmpd = new BitmapData(500, 500, false, 0x000000);
			_backBmpd.perlinNoise(100, 80, 1,Math.random(), false, true, 7, true)
			_backBmpd.colorTransform(_backBmpd.rect, new ColorTransform(-1, 0.15, 0.20));
			addChild(new Bitmap(_backBmpd));
			
			// star
			_starBmpd = new BitmapData(500, 500, false, 0x000000);
			_starBmpd.lock();
			var b:Bitmap = addChild(new Bitmap(_starBmpd)) as Bitmap;
			b.blendMode = BlendMode.SCREEN;
			_starBmpd.noise(Math.random(),0,255,7,true);
			
			var rgb:RGB = new RGB();
			var max:int = 255;
			var min:int = 250; 
			
			for (var ix:int = 0; ix < _starBmpd.width; ix++)
			{
				for (var iy:int = 0; iy < _starBmpd.height; iy++)
				{
					rgb.setPixel(_starBmpd.getPixel(ix, iy));
					rgb.r = getColor(rgb.r, max, min);
					rgb.g = getColor(rgb.g, max, min);
					rgb.b = getColor(rgb.b, max, min);
					_starBmpd.setPixel(ix, iy, rgb.getPixel());
				}
			}
			
			_starBmpd.unlock(); 
			//Wonderfl.capture(stage);
			
		}
		
		private function getColor(color:int, max:int, min:int):int
		{
			if (color < min) color = min;
			if (color > max) color = max;
			return (color - min) * 255 / (max - min);
		}
		
	}
}


// http://wonderfl.net/code/37e0963030d17ebe8b321c254160c7f82a439b91
class RGB
{
	public var r:int = 0;
	public var g:int = 0;
	public var b:int = 0;
	
	public function setPixel(pixel:int):void
	{
		r = pixel >> 16 & 0xFF;
		g = pixel >> 8 & 0xFF;
		b = pixel & 0xFF;
	}
	
	public function getPixel():int
	{
		var pixel:int = 0;
		pixel += r << 16;
		pixel += g <<8;
		pixel += b;
		
		return pixel
	}
}
// ActionScript file