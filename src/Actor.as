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

        private var beh:IRoleBehaviour;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 10;
        private var backwardSpeed:Number = 3;

        // vector for linear velocity of character
        private var charVel:b2Vec2 = new b2Vec2();

        // angular velocity of character
        private var charVelAng:Number = 1;

        private var level:Number = 3;

        public function Actor():void {
            addEventListener(Event.ENTER_FRAME, run);
            addEventListener(Event.ENTER_FRAME, update);

            var world:b2World = context.world.getWorld();
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.position.Set(0.0, 4.0);
	    bodyDef.linearDamping = 1;
	    bodyDef.angularDamping = 2;


            body = world.CreateBody(bodyDef);

            var shapeDef:b2PolygonDef = new b2PolygonDef();
            shapeDef.SetAsBox(1.0, 1.0);
            shapeDef.density = 1.0;
            shapeDef.friction = 0.3;
            body.CreateShape(shapeDef);
            body.SetMassFromShapes();

            var triangleHeight:uint = 10;


            with (context.camera) {
                graphic = newSprite();
                beginFill(0xFF0000);
                moveTo(triangleHeight/2, 0);
                lineTo(triangleHeight, triangleHeight);
                lineTo(0, triangleHeight);
                lineTo(triangleHeight/2, 0);
            }

        }

        public function set behaviour(_beh:IRoleBehaviour):void {
            beh = _beh;
            beh.actor = this;
            run();
	    // if (stage) //active();
	    // else addEventListener(Event.ADDED_TO_STAGE, run);
        }

        public function run(event:Event = null):void {
            beh.run();
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
