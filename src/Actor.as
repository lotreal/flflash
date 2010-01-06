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

        private var _world:b2World = context.world.getWorld();
        public function get world():b2World {
            return _world;
        }

        private var _bodyDef:b2BodyDef = null;
        public function get bodyDef():b2BodyDef {
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set(wx, wy);
	    _bodyDef.linearDamping = 1;
	    _bodyDef.angularDamping = 2;
            _bodyDef.angle = 0;
            return _bodyDef;
        }
        public function set bodyDef(t_bodyDef:b2BodyDef):void {
            _bodyDef = t_bodyDef;
        }

        private var _shapeDef:b2ShapeDef = null;

        public function get shapeDef():b2ShapeDef {
            var nAngle:Number = (2 * Math.PI) / level;
            sideLength = 3 / (1 + level/10);
	    var nRadius:Number = (sideLength / 2) / Math.sin(nAngle / 2);
	    var nPx:Number,nPy:Number;

            var def:b2PolygonDef = new b2PolygonDef();
            def.vertexCount = level
	    for (var i:Number = 0; i < level; i++)
	    {
		nPx = Math.cos((nAngle * i)) * nRadius;
		nPy = Math.sin((nAngle * i)) * nRadius;
                def.vertices[i].Set(nPx, nPy)
	    }

            def.density = 1.0;
            def.friction = 0.3;

            _shapeDef = def;
            return _shapeDef;
        }
        public function set shapeDef(t_shapeDef:b2ShapeDef):void {
            _shapeDef = t_shapeDef;
        }

        private var _shape:b2Shape = null;
        public function get shape():b2Shape {
            return _shape;
        }
        public function set shape(t_shape:b2Shape):void {
            _shape = t_shape;
        }

        public var level:uint = 3;

        public var wx:Number = 10.0;
        public var wy:Number = 6.0;


        private var _behaviour:IRoleBehaviour;

        private var sideLength:Number = 3.0;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 18;
        private var backwardSpeed:Number = 9;

        private var charVel:b2Vec2 = new b2Vec2();
        private var charVelAng:Number = 1;

        public function Actor(_b:IRoleBehaviour = null):void {
            init();
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

        public function init():void {
            body = world.CreateBody(bodyDef);
            body.m_userData = this;
            attachShape(shapeDef);
            makeup();
        }
        public function run(event:Event = null):void {
            if (behaviour != null) {
                behaviour.run();
            }
        }

        private function attachShape(def:b2ShapeDef):void {
            shape = body.CreateShape(def);
            body.SetMassFromShapes();
        }

        private function makeup():void {
            var hw:Number = sideLength;

            var bodyRotation:Number=body.GetAngle();
	    var bodyPosition:b2Vec2 = body.GetPosition();

            with (context.camera) {
                graphic = newSprite();
                beginFill(0x00FF00);
                //drawRect(0, 0, hw * 2, hw * 2);
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

        public function destroy():void {
            graphic.parent.removeChild(graphic);

            var world:b2World = context.world.getWorld();
            world.DestroyBody(body);
        }

        public function levelUp():void {
            level++;
            //destroy();
            //init();
            body.DestroyShape(shape);
            attachShape(shapeDef);
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
