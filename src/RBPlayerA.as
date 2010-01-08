package
{
    import flash.display.*;
    import im.luo.logging.Logger;
    import flash.events.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;

    public class RBPlayerA extends EventDispatcher implements IRoleBehaviour {
        private var logger:Logger = Logger.getLogger(this);

        public var _actor:Actor;
        public function set actor(a:Actor):void {_actor = a};

        public var kb:Keyboard;

        public function RBPlayerA():void {
            kb = Keyboard.instance;
        }

        public function run():void {
            _actor.addEventListener(Event.ENTER_FRAME, update);
            var stage:Stage = Context.instance.stage;
            stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
        }

        public function update(e:Event):void {
            if (kb.justPressed("LEFT")) {
                _actor.turnLeft();
            }
            if (kb.justPressed("UP")) {
                _actor.forward();
            }
            if (kb.pressed("RIGHT")) {
                _actor.turnRight();
            }
            if (kb.pressed("DOWN")) {
                _actor.backward();
            }
            //if (kb.justPressed[78]) { // N
            //    levelUp();
            //}
            //if (kb.justPressed[77]) { // M
            //    levelDown();
            //}
        }

	public function handleKeyUp(event:KeyboardEvent):void
	{
            var c:uint  = event.keyCode;
	    if(c == KeyCode.N) {
                logger.debug('N');
                _actor.levelUp();
            }

	    if(c == KeyCode.D) {
                var body:b2Body = _actor.body;
                var wc:b2Vec2 = body.GetWorldCenter();
                logger.debug(wc.x, wc.y);
                wc = body.GetLocalCenter();
                logger.debug(wc.x, wc.y);
            }

        }
    }
}
