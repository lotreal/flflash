package flf {
    import flash.display.Sprite;
    import flash.events.*;
    import Box2D.Dynamics.*;
    import Box2D.Common.Math.*;
    import com.actionsnippet.qbox.*;
    import flash.ui.Keyboard;
    import im.luo.log.Logger;

    public class Doll extends Sprite {
        private var _cu:IDollController;

        private var logger:Logger = Logger.getLogger(this);

        private var qbWorld:QuickBox2D;
        private var char:QuickObject;
        private var b2body:b2Body;

        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 10;
        private var backwardSpeed:Number = 3;

        // vector for linear velocity of character
        private var charVel:b2Vec2 = new b2Vec2();

        // angular velocity of character
        private var charVelAng:Number = 1;

        private var level:Number = 3;


        public function Doll():void {
        }

        public function set controller(cu:IDollController):void {
            _cu = cu;

	    // if (stage) //active();
	    // else addEventListener(Event.ADDED_TO_STAGE, active);
        }

        public function action(event:MouseEvent = null):void {
            _cu.action();
        }

        public function appendTo(world:QuickBox2D):void {
            qbWorld = world;
            char = qbWorld.addBox({x:12, y:12, width:2, height:2, isBullet:true});
            //b2body = char.getBody();
            b2body = char.body;
        }

        public function show(ox:Number, oy:Number):void {
            var va:Array = new Array();
	    var nRadius:Number = 1;
            var t:Number = 1000;
	    var nPx:Number,nPy:Number;
            var nAngle:Number = (2 * Math.PI) / level;
	    for (var i:Number = 0; i < level; i++)
	    {
		nPx = Math.cos((nAngle * i)) * nRadius;
		nPy = Math.sin((nAngle * i)) * nRadius;

                nPx = Math.round(nPx * t) / t;
                nPy = Math.round(nPy * t) / t;
                va.push(nPx);
                va.push(nPy);
	    }
            logger.debug(va);

            char = qbWorld.addPoly({x:ox, y:oy, verts:[va]});
            b2body = char.body;
        }

        public function levelUp():void {
            level++;
            logger.debug(level);

            var ox:Number, oy:Number;
            ox = char.x;
            oy = char.y;
            char.fullDestroy();
            show(ox,oy);
        }
        public function levelDown():void {
            level--;
            logger.debug(level);
        }

        public function turnLeft():void {
            logger.debug ("left");
            charVel = char.body.GetLinearVelocity();
            charVelAng =  char.body.GetAngularVelocity();
            charVel.x -= 1
            char.body.SetLinearVelocity(charVel);
            charVelAng -= 1;
            char.body.SetAngularVelocity(charVelAng);
        }

        public function turnRight():void {
            logger.debug ("right");
            charVel = char.body.GetLinearVelocity();
            charVelAng =  char.body.GetAngularVelocity();
            charVel.x += 1
            char.body.SetLinearVelocity(charVel);
            charVelAng += 1;
            char.body.SetAngularVelocity(charVelAng);
        }

        public function forward():void {
            logger.debug ("forward");
            char.body.WakeUp();
            charVel = char.body.GetLinearVelocity();
            charVelAng =  char.body.GetAngularVelocity();

            charVel.x = forwardSpeed * Math.cos(char.angle);
            charVel.y = forwardSpeed * Math.sin(char.angle);
            char.body.SetLinearVelocity(charVel);
            charVelAng *= 0.8;
            char.body.SetAngularVelocity(charVelAng);
        }

        public function backward():void {
            logger.debug ("backward");
            charVel = char.body.GetLinearVelocity();
            charVelAng =  char.body.GetAngularVelocity();

            charVel.x = backwardSpeed * Math.cos(char.angle) * -1;
            charVel.y = backwardSpeed * Math.sin(char.angle) * -1;
            char.body.SetLinearVelocity(charVel);
            charVelAng *= 0.8;
            char.body.SetAngularVelocity(charVelAng);
        }

    }
}
