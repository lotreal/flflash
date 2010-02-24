package im.luo.staff
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.display.Stage;
    
    import im.luo.logging.Logger;
    
    public class Screen {
        public function Screen() {}

        /**
         * 如果指定名字的屏幕图层不存在,则创建并添加到当前屏幕 
         * @param name 屏幕图层的名字
         * @param top 置顶标记
         * @return 
         * 
         */        
        public function addScreenByName(name:String, top:Boolean = false):DisplayObjectContainer {
            if (!layers.hasOwnProperty(name))
            {
                layers[name] = new Sprite();
                addScreen(layers[name], top);
            }
            return layers[name];
        }

        public function addScreen(s:DisplayObjectContainer, top:Boolean = false):DisplayObjectContainer {
            sumLayers++;
            if (top) {
                numTopLayers++;
                canvas.addChild(s);
            } else {
                canvas.addChildAt(s, sumLayers - numTopLayers - 1);
            }
            return s;
        }
        
        public function setLayer(name:String, layer:DisplayObjectContainer):void
        {
            layers[name] = layer;
        }
        
        public function getLayer(name:String):DisplayObjectContainer
        {
            if (!layers.hasOwnProperty(name)) layers[name] = new Sprite();
            return layers[name] as DisplayObjectContainer;
        }
 
        public function clear():void {
            _root.removeChild(canvas);
            canvas = null;
            layers = new Object();
            canvas = new Sprite();
            _root.addChild(canvas);
            numTopLayers = 0;
            sumLayers = 0;
        }

        public function set root(value:DisplayObjectContainer):void
        {
            _root = value;
            canvas = new Sprite();
            _root.addChild(canvas);
        }

        public static var SCENE_UI:String = "scene_ui";
        public static var SCREEN_UI:String = "screen_ui";

        public var stage:Stage;
        public var _root:DisplayObjectContainer;
        public var canvas:Sprite;
        
        private var logger:Logger = Logger.getLogger(this);
        private var numTopLayers:int = 0;
        private var sumLayers:int = 0;
        
        private var layers:Object = new Object();
    }
}