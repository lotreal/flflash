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
        public static function wander(role:IAdvancedMotion, wanderDistance:Number = 30, wanderRadius:Number = 5, wanderRange:Number = 1, wanderAngle:Number = 0):void
        {
            var center:Vector2D = role.velocity.clone().normalize().multiply(wanderDistance);
            var offset:Vector2D = new Vector2D(0);
            offset.length = wanderRadius;
            offset.angle = wanderAngle;
            wanderAngle += Math.random() * wanderRange - wanderRange * .5;
            var force:Vector2D = center.add(offset);
            role.steeringForce = role.steeringForce.add(force);
        }
    }
}