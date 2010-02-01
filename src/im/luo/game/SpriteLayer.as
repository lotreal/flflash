package im.luo.game
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    
    public class SpriteLayer extends Sprite implements ISceneLayer {
        private var _logger:Logger = Logger.getLogger(this);
        public var list:Vector.<DisplayObject>;

        public function SpriteLayer() {
            alpha = 0.5;
            list = new Vector.<DisplayObject>();
        }

        public function add(child:*):* {
            list.push(child);
            addChild(child);
            return child;
        }

        public function addCharacter(character:Role):* {
            add(character.appearance);
            return character;
        }
        
        public function render(camera:ICamera):void {
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