package im.luo.actor {
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
    import im.luo.staff.Context;
    import im.luo.sim.IWorld;
    import im.luo.sim.IMoveable;
    import im.luo.role.RoleAbstract;
    import im.luo.physics.box2d.box2dWorld;
    
    public class box2dActor extends box2dStaticActor implements IMoveable {
        public function box2dActor(role:RoleAbstract):void {
            super(role);
        }
        
        override protected function initBodyDef():void {
            super.initBodyDef();
            bodyDef.type = b2Body.b2_dynamicBody;
        }

        override protected function creatBody():void {
            super.creatBody();
            body.SetSleepingAllowed(false);
        }
        
        override public function play():void
        {
            //_steeringForce.truncate(_maxForce);
            //_steeringForce = _steeringForce.divide(mass);
            //velocity = velocity.add(_steeringForce);
            //_steeringForce = new Vector2D();
            //super.play();
        }
        
        public function seek(target:Vector2D):void
        {
            var desiredVelocity:Vector2D = target.subtract(position);
            desiredVelocity.normalize();
            desiredVelocity = desiredVelocity.multiply(maxSpeed);
            var force:Vector2D = desiredVelocity.subtract(velocity);
            _steeringForce = _steeringForce.add(force);
        }
        
        private var _maxForce:Number = 1;
        private var _steeringForce:Vector2D = new Vector2D();
        private var _logger:Logger = Logger.getLogger(this);
    }
}
