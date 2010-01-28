package
{
    import im.luo.logging.Logger;
    
    public class Scene implements IScene {
        public var _layers:Vector.<ISceneLayer>;
        public function get layers():Vector.<ISceneLayer> { return _layers; }

        public function Scene() {
            _layers = new Vector.<ISceneLayer>();
        }

        public function addLayer(layer:ISceneLayer):ISceneLayer {
            _layers.push(layer);
            return layer;
        }

        public function build():void {
        }

        public function destroy():void {
        }

        private var logger:Logger = Logger.getLogger(this);
    }
}