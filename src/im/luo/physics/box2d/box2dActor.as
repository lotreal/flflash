package im.luo.physics.box2d {
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
    import im.luo.geom.Vector2D;
    import im.luo.game.IActor;
    import flf.flatland.game.Context;
    import im.luo.sim.IWorld;
    import im.luo.game.RoleAbstract;

    public class box2dActor implements IActor {
        public var context:Context = Context.instance;
        //public var camera:Camera = context.camera;
        public var role:*;

        private var logger:Logger = Logger.getLogger(this);

        protected var _world:IWorld = box2dWorld.instance;
        protected var bodyDef:b2BodyDef = new b2BodyDef();
        protected var body:b2Body;
        protected var shape:b2Shape;
        protected var fixture:b2Fixture;
        protected var scale:int = 30;

        private var _maxSpeed:Number = 0;
        public function get maxSpeed():Number {
            return _maxSpeed;
        }
        public function set maxSpeed(value:Number):void {
            _maxSpeed = value;
        }


        public function get world():IWorld {
            return _world;
        }

        public function get angle():Number {
            return body.GetAngle();
        }
        public function set angle(value:Number):void {
        }

	public function set x(value:Number):void {};
	public function get x():Number {
            return 1;
        };

	public function set y(value:Number):void {};
	public function get y():Number {
            return 1;
        };

        public function get center():Vector2D {
            var p:b2Vec2 = body.GetWorldCenter();
            return new Vector2D(p.x * scale, p.y * scale);
        }

        public function get position():Vector2D {
            var p:b2Vec2 = body.GetPosition();
            return new Vector2D(p.x * scale, p.y * scale);
        }

        public function set position(value:Vector2D):void {
        }

        public function get linearVel():Vector2D {
            var vel:b2Vec2 = body.GetLinearVelocity();
            return new Vector2D(vel.x, vel.y);
        }
        public function set linearVel(value:Vector2D):void {
            body.SetLinearVelocity(new b2Vec2(value.x, value.y));
        }

        public function get angularVel():Number {
            return body.GetAngularVelocity();
        }
        public function set angularVel(value:Number):void {
            if (Math.abs(value) > 5) value = (value > 0 ? 5 : -5);
            body.SetAngularVelocity(value);
        }

        public function get mass():b2MassData {
            return new b2MassData(); //body.GetMass();
        }
        public function set mass(value:b2MassData):void {
        }

        public function get userdata():* {
            return body.GetUserData();
        }
        public function set userdata(value:*):void {
            body.SetUserData(value);
        }

	public function applyImpulse(impulse:b2Vec2, point:b2Vec2):void{
            body.ApplyImpulse(impulse, point);
        }

        public function update():void {
            body.DestroyFixture(fixture);
            createShape();
        }

        public function destroy():void {
            world.destroyBody(body);
        }

        public function box2dActor(role:RoleAbstract):void {
            this.role = role;
            this.creatBody();
        }

        protected function initBodyDef():void {
            bodyDef.position.Set(role.x, role.y);
	    bodyDef.linearDamping = 6;
	    bodyDef.angularDamping = 12;
            bodyDef.angle = 0;
            bodyDef.type = b2Body.b2_dynamicBody;
        }

        protected function createShape():void {}

        protected function creatBody():void {
            initBodyDef();
            body = world.createBody(bodyDef);
            body.SetUserData(this);
            body.SetSleepingAllowed(false);
            createShape();
        }

        public function play():void {
        }
    }
}
