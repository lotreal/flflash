package im.luo.game
{
    import im.luo.logging.Logger;
    
    public class SceneLayer implements ISceneLayer {
        private var logger:Logger = Logger.getLogger(this);
        
        public function SceneLayer() {
            
        }

        public function render(camera:ICamera):void {
            for (var i:int=0, l:list.length; i<l; i++) {
                var visual:IVisual = list[i];
                if (visual.inCamera(camera)) {
                    visual.render(camera);
                }
            }
        }
    }
}
