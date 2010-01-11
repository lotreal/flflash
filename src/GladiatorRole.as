package
{
    import im.luo.logging.Logger;
    
    public class GladiatorRole extends Role {
        private var _logger:Logger = Logger.getLogger(this);

        private var maxLevel:int = 9;

        public function GladiatorRole() {
            this.actor = actor;
            this.looks = looks;
        }

        private function changeLevel(lv:uint):void {
            if (level != lv) {
                //modelling();
            }
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
            actor.refresh();
            looks.repaint();
        }

        private var dialogueTimer:Timer;
        public function say(s:String):void
        {
            dialogueTextBox.text = s;
            dialogueTimer = new Timer(1000, 1);
            dialogueTimer.addEventListener("timer", timerHandler);
            dialogueTimer.start();
        }

        public function timerHandler(event:TimerEvent):void {
            dialogueTimer = null;
            dialogueTextBox.text = ".";
        }

    }
}