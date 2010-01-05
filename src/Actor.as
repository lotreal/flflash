package {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;

    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flash.geom.*;
    import im.luo.log.Logger;

    public class Actor extends Sprite {
        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;

        //private var role:IRole;
        public var body:b2Body;
        private var graphic:DisplayObject;

        private var _behaviour:IRoleBehaviour;

        private var sideLength:Number = 1.0;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 18;
        private var backwardSpeed:Number = 9;

        // vector for linear velocity of character
        private var charVel:b2Vec2 = new b2Vec2();

        // angular velocity of character
        private var charVelAng:Number = 1;

        private var level:Number = 3;

        public function Actor(_b:IRoleBehaviour = null):void {
            initBody();
            initGraphic();

            addEventListener(Event.ENTER_FRAME, run);
            addEventListener(Event.ENTER_FRAME, update);

            if (_b != null) {
                behaviour = _b;
            }
        }

        public function get behaviour():IRoleBehaviour {
            return _behaviour;
        }
        public function set behaviour(_b:IRoleBehaviour):void {
            _behaviour = _b;
            _behaviour.actor = this;
            run();
        }

        public function run(event:Event = null):void {
            if (behaviour != null) {
                behaviour.run();
            }
        }

        public function initBody():void {
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.position.Set(10.0, 6.0);
	    bodyDef.linearDamping = 1;
	    bodyDef.angularDamping = 2;

            var world:b2World = context.world.getWorld();
            body = world.CreateBody(bodyDef);
            body.m_userData = this;

            var shapeDef:b2PolygonDef = new b2PolygonDef();
            shapeDef.SetAsBox(sideLength, sideLength);
            shapeDef.density = 1.0;
            shapeDef.friction = 0.3;
            body.CreateShape(shapeDef);
            body.SetMassFromShapes();
        }

        public function initGraphic():void {
            var hw:Number = sideLength;

            var bodyRotation:Number=body.GetAngle();
	    var bodyPosition:b2Vec2 = body.GetPosition();

            with (context.camera) {
                graphic = newSprite();
                beginFill(0x00FF00);
                drawRect(0, 0, hw * 2, hw * 2);
                drawCircle(1.81, 1, 0.15)
            }
        }

        public function update(e:Event):void {
            var a:Actor = this;

            // World state position
            var bodyPosition:b2Vec2=a.body.GetPosition();
            var bodyRotation:Number=a.body.GetAngle();
            
            // Sprite rotation based (0,0) correct for size by moving sprite before rotation.
            // ie. rotation about the center of the sprite.
            a.graphic.rotation=0;// If not, matrix starts wrong.
            var m:Matrix=a.graphic.transform.matrix;
            
            m.tx=- a.graphic.width/2;
            m.ty=- a.graphic.height/2;
            m.rotate(bodyRotation);// Already in radians
            
            // Now set the position to the world position
            m.tx+=bodyPosition.x*physScale;
            m.ty+=bodyPosition.y*physScale;
            
            // ...and set the whole thing at once via the matrix.
            // ie. Update the sprite.
            a.graphic.transform.matrix=m;

        }

        public function turnLeft():void {
            logger.debug ("left");
            body.WakeUp();
            charVel = body.GetLinearVelocity();
            charVelAng =  body.GetAngularVelocity();
            charVel.x -= 1
            body.SetLinearVelocity(charVel);
            charVelAng -= 1;
            body.SetAngularVelocity(charVelAng);
        }

        public function turnRight():void {
            logger.debug ("right");
            body.WakeUp();
            charVel = body.GetLinearVelocity();
            charVelAng =  body.GetAngularVelocity();
            charVel.x += 1
            body.SetLinearVelocity(charVel);
            charVelAng += 1;
            body.SetAngularVelocity(charVelAng);
        }

        public function forward():void {
            logger.debug ("forward");
            body.WakeUp();
            charVel = body.GetLinearVelocity();
            charVelAng =  body.GetAngularVelocity();

            charVel.x = forwardSpeed * Math.cos(body.GetAngle());
            charVel.y = forwardSpeed * Math.sin(body.GetAngle());
            body.SetLinearVelocity(charVel);
            charVelAng *= 0.8;
            body.SetAngularVelocity(charVelAng);
        }

        public function backward():void {
            logger.debug ("backward");
            body.WakeUp();
            charVel = body.GetLinearVelocity();
            charVelAng =  body.GetAngularVelocity();

            charVel.x = backwardSpeed * Math.cos(body.GetAngle()) * -1;
            charVel.y = backwardSpeed * Math.sin(body.GetAngle()) * -1;
            body.SetLinearVelocity(charVel);
            charVelAng *= 0.8;
            body.SetAngularVelocity(charVelAng);
        }
    }
}
