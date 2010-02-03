package im.luo.role
{
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import im.luo.util.UI;
    import flf.flatland.game.Context;
    import im.luo.geom.Vector2D;
    import im.luo.actor.IActor;
    import im.luo.face.Face;
    import im.luo.action.IRoleBehaviour;

    public class RoleAbstract implements IRole {
        public var x:int;
        public var y:int;
        public var type:String = "";

        public var actor:IActor;

        private var _controller:IRoleBehaviour = null;
        public function set behaviour(value:IRoleBehaviour):void {
            //if (_controller != null) _controller.destroy();

            UI.instance.tips("当前操作方案: "+ value.toString() +" [切换操作方案: 空格键]");
            _controller = value;
            //_controller.role = this;
            //_controller.run();
        }

        public function get position():Vector2D {
            return actor.position;
        }
        public function set position(value:Vector2D):void {
            actor.position = value;
        }


        public var appearance:Face;

        public var context:Context = Context.instance;

        private var _logger:Logger = Logger.getLogger(this);

        public function RoleAbstract(x:int, y:int) {
            this.x = x;
            this.y = y;
        }

        public function run():void {
            appearance.paint();
        }

        public function play():void {
            //if (action != null) action.step();
            _controller.play();
            actor.play();
            appearance.update();
        }

        public function destroy():void {
            appearance.destroy();
            //vision.parent.removeChild(vision);
            actor.destroy();
        }
    }
}
