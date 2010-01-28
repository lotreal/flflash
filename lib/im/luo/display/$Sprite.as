package im.luo.display
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Graphics;
    import im.luo.logging.Logger;

    /**
    var sprite:$prite = new $prite();
    sprite.graphics.beginFill(bgColor);
    sprite.graphics.lineStyle(borderSize, borderColor);
    sprite.graphics.drawRect(0, 0, size, size);
    sprite.graphics.endFill();

    In order to make use of this library you'll need to instantiate a QuickBox2D instance.
    
    What does the QuickBox2D class do?
    It instantiates the main classes that Box2D needs to run (b2World and b2AABB).
    It manages the Box2D simulation via <code>start()</code> and <code>stop()</code> methods.
    It contains methods for creating rigid bodies and joints - such as addCircle(), addBox() and addPoly()
    It contains a few additional methods for debugging and mouse interaction.
    
    @author Zevan Rosser
    @version 1.0
    */
    
    public class $Sprite extends $DisplayObject {
        private var logger:Logger = Logger.getLogger(this);
        private var content:Bitmap = new Bitmap();

        private var _shape:Shape = null;
        private var _graphics:Graphics = null;
        public function get graphics():Graphics {
	    if (_graphics == null) {
                _shape = new Shape();
                _graphics = _shape.graphics;
            }
            return _graphics;
        }

        public function draw():void {}
        
        public function $Sprite() {
            logger.debug("$sprite");
        }

	protected function drawBitmapData(src:BitmapData):void
	{
	    content.bitmapData = src;
	}

    }
}