package im.luo.scene
{
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.events.*;
    import flash.geom.Rectangle;
    import im.luo.camera.ICamera;
    import im.luo.role.IRole;
    import im.luo.staff.Context;

    public class Scene extends SceneAbstract implements IScene {
        public var context:Context = Context.instance;

        public function Scene(rect:Rectangle = null) {
            super(rect);
            _layers = new Vector.<ISceneLayer>();
            _roles = new Vector.<IRole>();
        }

        public function get roles():Vector.<IRole> {
            return _roles;
        }

        public function set roles(value:Vector.<IRole>):void {
            _roles = value;
        }

        public function get layers():Vector.<ISceneLayer> {
            return _layers;
        }

        public function set layers(value:Vector.<ISceneLayer>):void {
            _layers = value;
        }

        public function addLayer(layer:ISceneLayer):ISceneLayer {
            if (layer.rect.isEmpty()) layer.rect = this.rect;
            _layers.push(layer);
            return layer;
        }

        public function addCharacter(name:String, character:IRole, layer:ISceneLayer):* {
            character.face.paint();
            layer.add(character.face);
            _roles.push(character);
            return character;
        }

        public virtual function build():void {
        }

        public virtual function destroy():void {
        }

        public virtual function play():void {}

        public function preShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].preShoot(container, rect);
            }
        };
        public function shooting(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].shooting(container, rect);
            }
        };
        public function postShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].postShoot(container, rect);
            }
        };

        private var _logger:Logger = Logger.getLogger(this);
        private var _layers:Vector.<ISceneLayer> = null;
        private var _roles:Vector.<IRole> = null;
    }
}