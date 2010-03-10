package im.luo.motion
{
    import im.luo.geom.Vector2D;

    /**
     * 高级行为类，提供追捕，群落，躲避，漫游等行为 
     * @author Lot
     * 
     */    
    public class AdvancedMotion
    {
        public function AdvancedMotion()
        {
        }
        
        // 漫游行为
        public static function wander(body:IAdvancedMotion, wanderDistance:Number = 30, wanderRadius:Number = 5, wanderRange:Number = 1, wanderAngle:Number = 0):void
        {
            Wander.getInstance(body).start();
        }
        
        public static function seek(body:IAdvancedMotion, target:Vector2D):void
        {
            var desiredVelocity:Vector2D = target.subtract(body.position);
            desiredVelocity.normalize();
            desiredVelocity = desiredVelocity.multiply(20); //maxSpeed
            var force:Vector2D = desiredVelocity.subtract(body.velocity);
            body.steeringForce = body.steeringForce.add(force);
        }
    }
}