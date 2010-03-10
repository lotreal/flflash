package im.luo.actor {
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    
    import flash.geom.*;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.motion.IAdvancedMotion;
    import im.luo.role.IRole;
    import im.luo.role.Role;
    import im.luo.staff.Context;
    import im.luo.vw.IWorld;
    import im.luo.vw.box2d.Box2DWorld;

    
    public class Box2DActor implements IActor, IAdvancedMotion {
        public function Box2DActor(role:Role):void {
            this.role = role;
            this.fixtureDef = new b2FixtureDef();
            this.createBody();
        }
        public function get speed():Number { return 24; }
        public function set speed(value:Number):void{}
        private var _maxForce:Number = 1;
        private var _steeringForce:Vector2D = new Vector2D();
        public function get steeringForce():Vector2D
        {
            return _steeringForce;
        }
        public function set steeringForce(value:Vector2D):void
        {
            _steeringForce = value;
        }
        
        public var context:Context = Context.instance;
        
        /**
         * 此演员当前扮演的角色
         */
        public var role:*;
        
        private var _logger:Logger = Logger.getLogger(this);
        
        protected var _world:IWorld = Box2DWorld.instance;
        protected var bodyDef:b2BodyDef = new b2BodyDef();
        protected var body:b2Body;
        protected var shape:b2Shape;
        protected var fixture:b2Fixture;
        protected var fixtureDef:b2FixtureDef;
        protected var scale:int = 30;
        
        protected var lockPosition:Boolean = false;
        
        protected var _mass:Number = 1.0;
        protected var _position:Vector2D = new Vector2D();
        protected var _velocity:Vector2D = new Vector2D();
        protected var _maxSpeed:Number = 30;
        
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
            //body.SetPosition(new b2Vec2(value.x / scale, value.y/ scale));
            //bodyDef.position.Set();
        }

        public function initPosition(value:Vector2D):void {
            body.SetPosition(new b2Vec2(value.x / scale, value.y/ scale));
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
            _logger.debug('destory actor', role.name);
            world.destroyBody(body);
        }
        
        protected function initBodyDef():void {
            //position = new Vector2D(role.x, role.y);
            
            bodyDef.linearDamping = 6;
            bodyDef.angularDamping = 12;
            bodyDef.angle = 0;
            if (!lockPosition) bodyDef.type = b2Body.b2_dynamicBody;
        }
        
        protected function createShape():void {}
        
        protected function createBody():void {
            initBodyDef();
            body = world.createBody(bodyDef);
            body.SetUserData(this);
            body.SetBullet(true);
            if (!lockPosition) body.SetSleepingAllowed(false);

            createShape();
        }
        
        public function play():void {
            //role.position = this.position;
            // make sure velocity stays within max speed.
            velocity.truncate(maxSpeed);
            
            // add velocity to position
            position = position.add(velocity);
            
            // update position of sprite
            //x = position.x;
            //y = position.y;
            
            // rotate heading to match velocity
            angle = velocity.angle; // * 180 / Math.PI;
            _steeringForce.truncate(_maxForce);
            _steeringForce = _steeringForce.divide(mass);
            velocity = velocity.add(_steeringForce);
            _steeringForce = new Vector2D();

        }

        protected function addFixture(shape:b2Shape, data:* = null):void {
            fixtureDef.shape = shape;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            fixtureDef.restitution = 2;
            fixtureDef.userData = role;
            body.CreateFixture(fixtureDef);
        }

        // 躲避行为
/*        public function flee(target:Vector2D):void
        {
            var desiredVelocity:Vector2D = target.subtract(_position);
            desiredVelocity.normalize();
            desiredVelocity = desiredVelocity.multiply(_maxSpeed);
            var force:Vector2D = desiredVelocity.subtract(_velocity);
            _steeringForce = _steeringForce.subtract(force);
        }*/
        
        // 回避行为
/*        private var _avoidDistance:Number = 300;
        private var _avoidBuffer:Number = 20;
        public function set avoidDistance(value:Number):void
        {
            _avoidDistance = value;
        }
        public function get avoidDistance():Number
        {
            return _avoidDistance;
        }
        
        public function set avoidBuffer(value:Number):void
        {
            _avoidBuffer = value;
        }
        public function get avoidBuffer():Number
        {
            return _avoidBuffer;
        }
        public function avoid(circles:Vector.<IRole>):void
        {
            for(var i:int = 0; i < circles.length; i++)
            {
                var circle:IRole = circles[i];
                var heading:Vector2D = _velocity.clone().normalize();
                
                // vector between circle and vehicle:
                var difference:Vector2D = circle.position.subtract(_position);
                var dotProd:Number = difference.dotProd(heading);
                
                // if circle is in front of vehicle...
                if(dotProd > 0)
                {
                    // vector to represent "feeler" arm
                    var feeler:Vector2D = heading.multiply(_avoidDistance);
                    // project difference vector onto feeler
                    var projection:Vector2D = heading.multiply(dotProd);
                    // distance from circle to feeler
                    var dist:Number = projection.subtract(difference).length;
                    
                    // if feeler intersects circle (plus buffer),
                    //and projection is less than feeler length,
                    // we will collide, so need to steer
                    if(dist < circle.radius + _avoidBuffer &&
                        projection.length < feeler.length)
                    {
                        // calculate a force +/- 90 degrees from vector to circle
                        var force:Vector2D = heading.multiply(_maxSpeed);
                        force.angle += difference.sign(_velocity) * Math.PI / 2;
                        
                        // scale this force by distance to circle.
                        // the further away, the smaller the force
                        force = force.multiply(1.0 - projection.length /
                            feeler.length);
                        
                        // add to steering force
                        _steeringForce = _steeringForce.add(force);
                        
                        // braking force
                        _velocity = _velocity.multiply(projection.length / feeler.length);
                    }
                }
            }
        }*/
        // 漫游行为
/*        private var _wanderAngle:Number = 0;
        private var _wanderDistance:Number = 30;
        private var _wanderRadius:Number = 5;
        private var _wanderRange:Number = 1;
        
        public function set wanderDistance(value:Number):void
        {
            _wanderDistance = value;
        }
        public function get wanderDistance():Number
        {
            return _wanderDistance;
        }
        
        public function set wanderRadius(value:Number):void
        {
            _wanderRadius = value;
        }
        public function get wanderRadius():Number
        {
            return _wanderRadius;
        }
        
        public function set wanderRange(value:Number):void
        {
            _wanderRange = value;
        }
        public function get wanderRange():Number
        {
            return _wanderRange;
        }
        public function wander():void
        {
            var center:Vector2D = velocity.clone().normalize().multiply(_wanderDistance);
            var offset:Vector2D = new Vector2D(0);
            offset.length = _wanderRadius;
            offset.angle = _wanderAngle;
            _wanderAngle += Math.random() * _wanderRange - _wanderRange * .5;
            var force:Vector2D = center.add(offset);
            _steeringForce = _steeringForce.add(force);
        }*/
        // 群落行为
/*        private var _inSightDist:Number = 200;
        private var _tooCloseDist:Number = 60;
        
        public function set inSightDist(value:Number):void
        {
            _inSightDist = value;
        }
        public function get inSightDist():Number
        {
            return _inSightDist;
        }
        
        public function set tooCloseDist(value:Number):void
        {
            _tooCloseDist = value;
        }
        public function get tooCloseDist():Number
        {
            return _tooCloseDist;
        }
        
        public function flock(actors:Vector.<IActor>):void
        {
            var averageVelocity:Vector2D = _velocity.clone();
            var averagePosition:Vector2D = new Vector2D();
            var inSightCount:int = 0;
            for(var i:int = 0; i < actors.length; i++)
            {
                var vehicle:IActor = actors[i];
                if(vehicle != this && inSight(vehicle))
                {
                    averageVelocity = averageVelocity.add(vehicle.velocity);
                    averagePosition = averagePosition.add(vehicle.position);
                    if(tooClose(vehicle)) flee(vehicle.position);
                    inSightCount++;
                }
            }
            if(inSightCount > 0)
            {
                averageVelocity = averageVelocity.divide(inSightCount);
                averagePosition = averagePosition.divide(inSightCount);
                seek(averagePosition);
                _steeringForce.add(averageVelocity.subtract(_velocity));
            }
        }
        
        public function inSight(vehicle:IActor):Boolean		
        {
            if(_position.dist(vehicle.position) > _inSightDist) return false;
            var heading:Vector2D = _velocity.clone().normalize();
            var difference:Vector2D = vehicle.position.subtract(_position);
            var dotProd:Number = difference.dotProd(heading);
            
            if(dotProd < 0) return false;
            return true;
        }
        
        public function tooClose(vehicle:IActor):Boolean
        {
            return _position.dist(vehicle.position) < _tooCloseDist;
        }
*/
/*        public function seek(target:Vector2D):void
        {
            var desiredVelocity:Vector2D = target.subtract(position);
            desiredVelocity.normalize();
            desiredVelocity = desiredVelocity.multiply(maxSpeed);
            var force:Vector2D = desiredVelocity.subtract(velocity);
            _steeringForce = _steeringForce.add(force);
        }*/
    }
}
