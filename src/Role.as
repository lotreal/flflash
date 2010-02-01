package
{
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import im.luo.game.IRole;
    import im.luo.game.IRoleBehaviour;
    import im.luo.game.IActor;
    import im.luo.game.Camera;

    public class Role implements IRole {
        public var x:Number;
        public var y:Number;
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

        public var appearance:Appearance;

        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

        private var _logger:Logger = Logger.getLogger(this);

        public function Role(x:Number, y:Number) {
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
