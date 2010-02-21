package
{
    import im.luo.logging.Logger;
    
    public class Screen {
        private var logger:Logger = Logger.getLogger(this);

        private var top:int = 0;
        private var total:int = 0;
        public var stage;
        public var render;
        public function Screen() {
            
        }

        public function addChild(s:DisplayObject):void {
            if (top) {            
                render.addChild(s);
                top++;
            } else {
                render.addChildAt(s, total - top);
            }
            total++;
        }
    }
}
