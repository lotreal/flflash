package im.luo.game
{
    import im.luo.logging.Logger;
    import flash.events.*;
    
    public class Scene extends EventDispatcher implements IScene {
        public var _layers:Vector.<ISceneLayer>;
        public var _roles:Vector.<RoleAbstract>;
        public function get layers():Vector.<ISceneLayer> { return _layers; }

        public function Scene() {
            _layers = new Vector.<ISceneLayer>();
            _roles = new Vector.<RoleAbstract>();
        }

        public function addLayer(layer:ISceneLayer):ISceneLayer {
            _layers.push(layer);
            return layer;
        }

        public function addCharacter(name:String, character:RoleAbstract, layer:ISceneLayer):* {
            layer.add(character.appearance);
            _roles.push(character);
            return character;
        }

        public function build():void {
        }

        public function destroy():void {
        }

        public function render(camera:ICamera):void {
        }

        public function action(camera:ICamera):void {
            preShoot(camera);
        }

        public function play():void {
        }

        public function pause(camera:ICamera):void {
        }

        public function resume(camera:ICamera):void {
        }

        public function stop(camera:ICamera):void {
            postShoot(camera);
        }

        public function preShoot(camera:ICamera):void {
            render(camera);
        }

        public function postShoot(camera:ICamera):void {
            render(camera);
        }

        public function play2(event:Event):void {
            for (var i:int = 0, n:int = _roles.length; i < n; i++) {
                //logger.debug(_roles[i].act());
            }
        }

        private var logger:Logger = Logger.getLogger(this);
    }
}