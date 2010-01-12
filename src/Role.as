package
{
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    public class Role {
        public var x:Number;
        public var y:Number;
        public var type:String = "";

        public var actor:Actor;
        //public var action:Action = null;
        public var looks:Looks;

        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

        private var _logger:Logger = Logger.getLogger(this);

        public function Role(x:Number, y:Number) {
            this.x = x;
            this.y = y;
        }

        public function run():void {
            looks.paint();
        }

        public function step():void {
            //if (action != null) action.step();
            looks.update();
        }

        public function destroy():void {
            looks.destroy();
            //vision.parent.removeChild(vision);
            actor.destroy();
        }
    }
}
