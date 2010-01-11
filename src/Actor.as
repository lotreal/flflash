package {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.text.TextField;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flash.geom.*;
    import im.luo.logging.Logger;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import caurina.transitions.Tweener;
    public class Actor {
        private var logger:Logger = Logger.getLogger(this);

        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

        public var body:b2Body;

        private var _world:b2World = context.world.getWorld();
        public function get world():b2World {
            return _world;
        }

        protected var _bodyDef:b2BodyDef = new b2BodyDef();
        public function get bodyDef():b2BodyDef {
            return _bodyDef;
        }
        public function set bodyDef(value:b2BodyDef):void {
            _bodyDef = value;
        }

        public function initBodyDef():void {
            _bodyDef.position.Set(role.x, role.y);
	    _bodyDef.linearDamping = 1;
	    _bodyDef.angularDamping = 2;
            _bodyDef.angle = 0;
        }

        protected var _shapeDef:b2ShapeDef = null;
        public function get shapeDef():b2ShapeDef {
            return _shapeDef;
        }
        public function set shapeDef(value:b2ShapeDef):void {
            _shapeDef = value;
        }

        protected var _shape:b2Shape = null;
        public function get shape():b2Shape {
            return _shape;
        }
        public function set shape(t_shape:b2Shape):void {
            _shape = t_shape;
        }

        public var level:uint = 4;

        public var ix:Number = 10;
        public var iy:Number = 6;


        private var _behaviour:IRoleBehaviour;

        private var side:Number = 3;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 18;
        private var backwardSpeed:Number = -9;



        public function get data():* {
            return body.m_userData;
        }
        public function set data(value:*):void {
            body.m_userData = value;
        }

        public function Actor(role:Role):void {
            this.role = role;

            this.initBodyDef();
            this.body = world.CreateBody(this.bodyDef);
            this.data(this);
            this.attachShape(this.shapeDef);
        }

        private function attachShape(def:b2ShapeDef):void {
            shape = body.CreateShape(def);
            body.SetMassFromShapes();
        }

        private var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>(10);
        private function evalVertices():void {
            var nAngle:Number = (2 * Math.PI) / level;
            side = 3 / (1 + level/10);
	    var nRadius:Number = (side / 2) / Math.sin(nAngle / 2);
	    var nPx:Number,nPy:Number;

	    for (var i:Number = 0; i < level; i++)
	    {
		nPx = Math.cos((nAngle * i)) * nRadius;
		nPy = Math.sin((nAngle * i)) * nRadius;
                var vv:b2Vec2 = new b2Vec2(nPx, nPy);
                vertices[i] = vv;
	    }
        }

        public function refresh():void {
            body.DestroyShape(shape);
            attachShape(shapeDef);
        }

        public function destroy():void {
            world.DestroyBody(body);
        }

        private var charVel:b2Vec2 = new b2Vec2();
        private var charVelAng:Number = 1;

        public function get linearVel():b2Vec2 {
            return body.GetLinearVelocity();
        }
        public function set linearVel(p_linearVel:b2Vec2):void {
            body.WakeUp();
            body.SetLinearVelocity(p_linearVel);
        }

        public function get angularVel():Number {
            return body.GetAngularVelocity();
        }
        public function set angularVel(p_angularVel:Number):void {
            body.WakeUp();
            body.SetAngularVelocity(p_angularVel);
        }

        private var _angle:b2Vec2 = null;
        public function get angle():b2Vec2 {
            return body.GetAngle;
        }
        public function set angle(value:b2Vec2):void {
            //_angle = value;
        }


    }
}
