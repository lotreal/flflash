package im.luo.motion
{
    import flash.utils.Dictionary;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    
    public class Wander
    {
        private static var logger:Logger = Logger.getLogger(Wander);
        private static var obj:Dictionary = new Dictionary();
        private var body:IAdvancedMotion;
        
        public static function getInstance(body:IAdvancedMotion):Wander
        {
            if (!obj[body])
            {
                obj[body] = new Wander(body);
            }
            return obj[body];
        }
        
        public function Wander(body:IAdvancedMotion)
        {
            this.body = body;
        }
        
        private var _wanderAngle:Number = 0;
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

        // 漫游行为
        public function start():void
        {
            var center:Vector2D = body.velocity.clone().normalize().multiply(wanderDistance);
            var offset:Vector2D = new Vector2D(0);
            offset.length = wanderRadius;
            offset.angle = _wanderAngle;
            _wanderAngle += Math.random() * wanderRange - wanderRange * .5;
            var force:Vector2D = center.add(offset);
            body.steeringForce = body.steeringForce.add(force);
        }
    }
}