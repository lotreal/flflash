package im.luo.actor {
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    
    import flash.geom.*;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.physics.box2d.box2dWorld;
    import im.luo.role.RoleAbstract;
    import im.luo.sim.IWorld;
    import im.luo.staff.Context;
    
    public class box2dStaticActor implements IActor {
        public var context:Context = Context.instance;
        //public var camera:Camera = context.camera;
        public var role:*;
        
        private var _logger:Logger = Logger.getLogger(this);
        
        protected var _world:IWorld = box2dWorld.instance;
        protected var bodyDef:b2BodyDef = new b2BodyDef();
        protected var body:b2Body;
        protected var shape:b2Shape;
        protected var fixture:b2Fixture;
        protected var fixtureDef:b2FixtureDef;
        protected var scale:int = 30;
        
        protected var _mass:Number = 1.0;
        protected var _position:Vector2D;
        protected var _velocity:Vector2D;
        protected var _maxSpeed:Number = 10;
        
        public function box2dStaticActor(role:RoleAbstract):void {
            this.role = role;
            this.fixtureDef = new b2FixtureDef();
            this.creatBody();
        }
        
        public function get world():IWorld {
            return _world;
        }
        
        public function get angle():Number {
            return body.GetAngle();
        }
        
        public function set angle(value:Number):void {
            body.SetAngle(value);
        }
        
        public function get x():Number {
            return position.x;
        }
        
        public function set x(value:Number):void {
            position.x = value;
        }

        public function get y():Number {
            return position.y;
        }

        public function set y(value:Number):void {
            position.y = value;
        }
        
        public function get position():Vector2D {
            var p:b2Vec2 = body.GetPosition();
            return new Vector2D(p.x * scale, p.y * scale);
        }
        
        public function set position(value:Vector2D):void {
            bodyDef.position.Set(value.x / scale, value.y/ scale);
        }
        
        public function get maxSpeed():Number {
            return _maxSpeed;
        }
        public function set maxSpeed(value:Number):void {
            _maxSpeed = value;
        }
        public function set velocity(value:Vector2D):void
        {
            linearVel = value;
        }
        public function get velocity():Vector2D
        {
            return linearVel;
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
        
        public function get mass():Number {
            return body.GetMass();
        }
        
        public function set mass(value:Number):void {
            var md:b2MassData = new b2MassData();
            body.GetMassData(md);
            md.mass = value;
            body.SetMassData(md);
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
            body.DestroyFixture(body.GetFixtureList());
            _logger.debug('update');
            createShape();
        }
        
        public function destroy():void {
            _logger.debug('destory', role.name);
            world.destroyBody(body);
        }
        
        protected function initBodyDef():void {
            position = new Vector2D(role.x, role.y);
            
            bodyDef.linearDamping = 6;
            bodyDef.angularDamping = 12;
            bodyDef.angle = 0;
        }
        
        protected function createShape():void {}
        
        protected function creatBody():void {
            initBodyDef();
            body = world.createBody(bodyDef);
            body.SetUserData(this);
            createShape();
        }
        
        public function play():void {
            //role.position = this.position;
            // make sure velocity stays within max speed.
            velocity.truncate(maxSpeed);
            
            // add velocity to position
            position = position.add(velocity);
            
            // update position of sprite
            x = position.x;
            y = position.y;
            
            // rotate heading to match velocity
            angle = velocity.angle * 180 / Math.PI;
        }

        protected function addFixture(shape:b2Shape, data:* = null):void {
            fixtureDef.shape = shape;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            fixtureDef.restitution = 2;
            fixtureDef.userData = role;
            body.CreateFixture(fixtureDef);
        }
    }
}
