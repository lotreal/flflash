package im.luo.scene
{
    import im.luo.logging.Logger;
    import flash.events.*;
    import flash.geom.Rectangle;
    import im.luo.camera.ICamera;
    import im.luo.role.RoleAbstract;

    public class Scene extends SceneAbstract implements IScene {
        public var _layers:Vector.<ISceneLayer>;
        public var _roles:Vector.<RoleAbstract>;
        public function get layers():Vector.<ISceneLayer> { return _layers; }

        public function Scene(rect:Rectangle = null) {
            super(rect);
            _layers = new Vector.<ISceneLayer>();
            _roles = new Vector.<RoleAbstract>();
        }

        public function addLayer(layer:ISceneLayer):ISceneLayer {
            if (layer.rect.isEmpty()) layer.rect = this.rect;
            _layers.push(layer);
            return layer;
        }

        public function addCharacter(name:String, character:RoleAbstract, layer:ISceneLayer):* {
            layer.add(character.appearance.render);
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