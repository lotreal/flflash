package im.luo.display
{
    import flash.display.Shape;
    import flash.display.DisplayObject;
    import flash.events.Event;

    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;

    public class $Screen extends Shape {
        private var logger:Logger = Logger.getLogger(this);
        private var content:$DisplayObject;
        private var children:Vector.<$Sprite> = new Vector.<$Sprite>;

        public function $Screen() {
            super();
            content = new $Sprite();
            Tick.instance.addEventListener(TickEvent.TICK, tickHandler);
        }

	private final function tickHandler(event:Event):void {
            updateDisplayList();
	}

        public function addChild(child:$DisplayObject):$DisplayObject {
            return content.addChild(child);
        }

        public function addChildAt(child:$DisplayObject, index:int):$DisplayObject {
            return content.addChildAt(child, index);
        }

        protected function updateDisplayList():void {
        }
    }
}

var size:uint         = 80;
var bgColor:uint      = 0xFFCC00;
var borderColor:uint  = 0x666666;
var borderSize:uint   = 0;
var cornerRadius:uint = 9;
var gutter:uint       = 5;
var sprite:$Sprite = new $Sprite();
sprite.graphics.beginFill(bgColor);
sprite.graphics.lineStyle(borderSize, borderColor);
sprite.graphics.drawRect(0, 0, size, size);
sprite.graphics.endFill();
//addChild(sprite);

var screen:$Screen = new $Screen();
screen.addChild(sprite);

