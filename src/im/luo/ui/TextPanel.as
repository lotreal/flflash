package im.luo.ui
{
    import im.luo.geom.Vector2D;
    import flash.text.TextField;
    import flash.display.DisplayObjectContainer;

    public class TextPanel implements ITextPanel
    {
        protected var txt:TextField;

        public function TextPanel(position:Vector2D, width:int, height:int, size:int, color:uint) {
            txt = UI.createTextField(position.x, position.y, width, height, size, color);
            this.position = position;
        }

        public function get content():String {
            return txt.text;
        }

        public function set content(value:String):void {
            if (txt.text != value) txt.text = value;
        }

        public function get position():Vector2D {
            return _position;
        }

        public function set position(value:Vector2D):void {
            _position = value;
            txt.x = value.x;
            txt.y = value.y;
        }

        public function render(c:DisplayObjectContainer):void {
            c.addChild(txt);
        }

        public function destroy():void {
            if (txt.parent != null) txt.parent.removeChild(txt);
        }

        private var _position:Vector2D = null;
    }
}