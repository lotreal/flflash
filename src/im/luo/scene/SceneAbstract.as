package im.luo.scene
{
    import im.luo.logging.Logger;
    import flash.geom.Rectangle;

    public class SceneAbstract {
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
