package im.luo.scene
{
    import flash.display.DisplayObjectContainer;
    import flash.events.*;
    import flash.geom.Rectangle;
    
    import im.luo.camera.ICamera;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.staff.Context;
    import im.luo.ui.UI;

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
        
        public function get ui():UI
        {
            return _ui;
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

        public virtual function build():void {}

        public virtual function destroy():void 
        {
            _logger.debug('摧毁场景，回收资源');
            for (var j:int = 0, k:int = roles.length; j < k; j++) {
                roles[j].destroy();
            }
import im.luo.ui.UI;
            
            for (var i:int = 0, n:int = this.layers.length; i < n; i++) {
                this.layers[i].destroy();
            }
        }
        
        public virtual function showUI(id:String):void {}
            
        public virtual function play():void {}

        public function preShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = layers.length; i < n; i++) {
                layers[i].preShoot(container, rect);
            }
        };
        public function shooting(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = layers.length; i < n; i++) {
                layers[i].shooting(container, rect);
            }
        };
        public function postShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            for (var i:int = 0, n:int = layers.length; i < n; i++) {
                layers[i].postShoot(container, rect);
            }
        };

        protected var _ui:UI;
        private var _logger:Logger = Logger.getLogger(this);
        private var _layers:Vector.<ISceneLayer> = null;
        private var _roles:Vector.<IRole> = null;
    }
}