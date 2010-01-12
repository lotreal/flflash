package {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flash.geom.*;
    import im.luo.logging.Logger;
    import caurina.transitions.Tweener;

    public class Actor implements IActor {
        public var context:Context = Context.instance;
        //public var camera:Camera = context.camera;
        public var role:Role;

        private var logger:Logger = Logger.getLogger(this);

        protected var _world:b2World = context.world.getWorld();
        protected var bodyDef:b2BodyDef = new b2BodyDef();
        protected var body:b2Body;
        protected var shapeDef:b2ShapeDef;
        protected var shape:b2Shape;


        public function get world():b2World {
            return _world;
        }

        public function get angle():Number {
            return body.GetAngle();
        }

        public function get position():b2Vec2 {
            return body.GetPosition();
        }

        public function get linearVel():b2Vec2 {
            return body.GetLinearVelocity();
        }
        public function set linearVel(value:b2Vec2):void {
            body.WakeUp();
            body.SetLinearVelocity(value);
        }

        public function get angularVel():Number {
            return body.GetAngularVelocity();
        }
        public function set angularVel(value:Number):void {
            body.WakeUp();
            body.SetAngularVelocity(value);
        }

        public function get data():* {
            return body.m_userData;
        }
        public function set data(value:*):void {
            body.m_userData = value;
        }

        public function update():void {
            body.DestroyShape(shape);
            createShape();
            //attachShape(shapeDef);
        }

        public function destroy():void {
            world.DestroyBody(body);
        }

        public function Actor(role:Role):void {
            this.role = role;
            this.creatBody();
        }

        protected function initBodyDef():void {
            bodyDef.position.Set(role.x, role.y);
	    bodyDef.linearDamping = 1;
	    bodyDef.angularDamping = 2;
            bodyDef.angle = 0;
        }

        protected function createShape():void {}

        protected function creatBody():void {
            initBodyDef();
            body = world.CreateBody(bodyDef);
            data(this);
            createShape();
        }
    }
}
