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
        public var level:int = 4;

        public var side:Number = 3;
        public var forwardSpeed:Number = 18;
        public var backwardSpeed:Number = -9;

        public var dialogue:Vision = new Vision(camera);
        public var dialogueTextBox:TextField = new TextField();

        public function GladiatorRole(x:Number, y:Number) {
            super(x, y);
            this.actor = new GladiatorActor();
            this.looks = new GladiatorLooks(this);
        }




        public function turnLeft():void {
            logger.debug ("left");
            actor.linearVel.x -= 1;
            actor.angularVel -= 1;
        }

        public function turnRight():void {
            logger.debug ("right");
            actor.linearVel.x += 1;
            actor.angularVel += 1;
        }

        public function forward():void {
            logger.debug ("forward");
            var v:b2Vec2 = new b2Vec2(
                forwardSpeed * Math.cos(actor.angle),
                forwardSpeed * Math.sin(actor.angle));
            actor.linearVel = v;
            actor.angularVel *= 0.8;
        }

        public function backward():void {
            logger.debug ("backward");
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
            actor.update();
            looks.repaint();
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