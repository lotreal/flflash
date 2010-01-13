package
{
    import im.luo.logging.Logger;
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import Box2D.Common.Math.b2Vec2;
    public class GladiatorRole extends Role {
        private var logger:Logger = Logger.getLogger(this);

        public var maxLevel:int = 9;

        private var _level:int = 4;
        public function get level():int {
            return _level;
        }
        public function set level(value:int):void {
            if (value > 8) value = 8;
            if (value < 3) value = 3;
            if (_level != value) {
                _level = value;
                actor.update();
                looks.repaint();
            }
        }

        public var color:uint = 0x990000;

        public var side:Number = 2;

        public function get radius():Number {
            var innerangle:Number = (2 * Math.PI) / level;
	    return (side / 2) / Math.sin(innerangle / 2);
        }

        public var forwardSpeed:Number = 24;
        public var backwardSpeed:Number = -9;

        public var strafeSpeed:Number = 12;

        public var dialogue:Vision = new Vision(camera);
        public var dialogueTextBox:TextField = new TextField();

        public function GladiatorRole(x:Number, y:Number) {
            super(x, y);
            this.actor = new GladiatorActor(this);
            this.looks = new GladiatorLooks(this);
        }

        public function strafeEast():void {
            var v:b2Vec2 = new b2Vec2(-strafeSpeed, 0);
            actor.linearVel = v;
        }

        public function strafeWest():void {
            var v:b2Vec2 = new b2Vec2(strafeSpeed, 0);
            actor.linearVel = v;
        }

        public function strafeNorth():void {
            var v:b2Vec2 = new b2Vec2(0, -strafeSpeed);
            actor.linearVel = v;
        }

        public function strafeSouth():void {
            var v:b2Vec2 = new b2Vec2(0, strafeSpeed);
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

        public function forward():void {
            //logger.debug ("forward");
            var v:b2Vec2 = new b2Vec2(
                forwardSpeed * Math.cos(actor.angle),
                forwardSpeed * Math.sin(actor.angle));
            actor.linearVel = v;
            actor.angularVel *= 0.8;
        }

        public function backward():void {
            //logger.debug ("backward");
            var v:b2Vec2 = new b2Vec2(
                backwardSpeed * Math.cos(actor.angle),
                backwardSpeed * Math.sin(actor.angle));
            actor.linearVel = v;
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