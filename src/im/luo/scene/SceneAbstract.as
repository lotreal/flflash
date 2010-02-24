package im.luo.scene
{
    import flash.events.EventDispatcher;
    import flash.geom.Rectangle;

    public class SceneAbstract extends EventDispatcher {
        protected var _rect:Rectangle = null;
        public function get rect():Rectangle {
            return _rect;
        }
        public function set rect(value:Rectangle):void {
            _rect = value;
        }
        
        public function SceneAbstract(rect:Rectangle = null) {
            this.rect = rect == null ? new Rectangle() : rect;            
        }
    }
}
