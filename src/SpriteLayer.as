package
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    
    public class SpriteLayer extends Sprite implements ISceneLayer {
        private var _logger:Logger = Logger.getLogger(this);
        public var list:Vector.<DisplayObject>;

        public function SpriteLayer() {
            list = new Vector.<DisplayObject>();
        }

        public function add(child:*):* {
            list.push(child);
            addChild(child);
            return child;
        }

        public function render(camera:ICamera):void {
            camera.add(this);
        }
    }
}
//public function render(camera:ICamera):void {
//    for (var i:int=0, l:list.length; i<l; i++) {
//        var visual:IVisual = list[i];
//        if (visual.inCamera(camera)) {
//            visual.render(camera);
//        }
//    }
//}