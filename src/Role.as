package
{
    import im.luo.logging.Logger;
    
    public class Role {
        public var x:int;
        public var y:int;

        public function Role(x:Number, y:Number) {
            this.x = x;
            this.y = y;
        }

        public function run():void {
            looks.paint();
            looks.addEventListener(Event.ENTER_FRAME, step);
        }

        public function step():void {
            if (action != null) action.step();
            looks.update();
        }

        private var _action:Action = null;
        public function get action():Action {
            return _action;
        }
        public function set action(value:Action):void {
            _action = value;
        }

        private var actor:Actor;
        private var type:String;
        private var looks:DisplayObjectContainer;

        private var _logger:Logger = Logger.getLogger(this);

        public function destroy():void {
            looks.destroy();
            //vision.parent.removeChild(vision);

            actor.destroy();
        }

    }
}
