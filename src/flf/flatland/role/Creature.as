package flf.flatland.role
{
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    
    import flf.flatland.actor.CreatureActor;
    import flf.flatland.face.CreatureFace;
    
    import im.luo.role.RoleAbstract;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;


    public class Creature extends RoleAbstract {
        private var logger:Logger = Logger.getLogger(this);

        public var maxLevel:int = 9;

        private var initLv:int = 3;
        private var _level:int = initLv;
        public function get level():int {
            return _level;
        }
        public function set level(value:int):void {
            //if (lock) return void;
            if (value > 8) value = 8;
            if (value < 2) value = 2;
            if (_level != value) {
                //lock = true;
		//var gameTimer:Timer = new Timer(1000, 1); //changed in part 3 from 50
		//gameTimer.addEventListener(TimerEvent.TIMER, buff);

                _level = value;
                actor.update();
                appearance.repaint();
            }
        }
        
        private var lock:Boolean = false;
        public function buff():void {
            lock = false;
        }

        public var color:uint = 0x990000;

        public var side:Number = 2;

        public function get radius():Number {
            var innerangle:Number = (2 * Math.PI) / level;
	    return (side / 2) / Math.sin(innerangle / 2);
        }

        public var forwardSpeed:Number = 24;
        public var backwardSpeed:Number = -9;

        public var strafeSpeed:Number = 20;

        public var dialogueTextBox:TextField = new TextField();

        public function Creature(x:int, y:int) {
            super(x, y);
            type = "gladiator";
            this.actor = new CreatureActor(this);
            this.appearance = new CreatureFace(this);
        }

        public function strafeEast(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(-strafeSpeed, 0);
            actor.linearVel = v;
        }

        public function strafeWest(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(strafeSpeed, 0);
            actor.linearVel = v;
        }

        public function strafeNorth(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(0, -strafeSpeed);
            actor.linearVel = v;
        }

        public function strafeSouth(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(0, strafeSpeed);
            actor.linearVel = v;
        }


        public function turnLeft():void {
            //logger.debug ("left");
            //actor.linearVel.x -= 1;
            actor.angularVel -= 1;
        }

        public function turnRight():void {
            //logger.debug ("right");
            //actor.linearVel.x += 1;
            actor.angularVel += 1;
        }

        private function evalLinearVel(a:Number, t:int, maxVel:Number):Number {
            var v:Number = v0 + a * t / 1000;
            if (a > 0) {
                v = v > maxVel ? maxVel : v;
            } else {
                v = v < maxVel ? maxVel : v;
                v = v > v0 ? v0 : v;
            }
            //logger.debug(v0, a, t, maxVel, v);
            return v;
        }

        public static const FORWARD:int = 1;
        public static const BACKWARD:int = 2;

        private var lastMove:int = 0;
        private var v0:Number = 0;

        public function move(type:int):void {
            if (type != lastMove) {
                lastMove = type;
                v0 = actor.linearVel.length;
            }
        }


        public function forward(t:int = -1):void {
            move(FORWARD);
            var v:Number = evalLinearVel(24, t, 40);

            actor.linearVel = new Vector2D(
                v * Math.cos(actor.angle),
                v * Math.sin(actor.angle));
            actor.angularVel *= 0.8;
        }

        public function backward(t:int = -1):void {
            move(BACKWARD);
            var v:Number = evalLinearVel(-32, t, -20);

            actor.linearVel = new Vector2D(
                v * Math.cos(actor.angle),
                v * Math.sin(actor.angle));
            actor.angularVel *= 0.8;
        }

        public function win():void {
            say("win");
        }

        public function lose():void {
            say("lose");
            destroy();
        }

        public function draw():void {
            say("draw");
        }

        public function levelUp():void {
            level++;
        }

        public function levelDown():void {
            level--;
        }

        public var dialogueTimer:Timer;
        public function say(s:String):void
        {
            //dialogueTextBox.text = s;
            //dialogueTimer = new Timer(1000, 1);
            //dialogueTimer.addEventListener("timer", timerHandler);
            //dialogueTimer.start();
        }

        public function timerHandler(event:TimerEvent):void {
            dialogueTimer = null;
            dialogueTextBox.text = ".";
        }

    }
}