package im.luo.motion
{
    import im.luo.geom.Vector2D;

    // 基本运动类，为 IBasicMotion 接口下的类提供上下左右等简单运动。
    public class BasicMotion
    {
        public static function up(role:IBasicMotion):void {
            role.velocity = role.velocity.add(new Vector2D(0, role.speed * -1)).truncate(role.speed);
        }
        
        public static function down(role:IBasicMotion):void {
            role.velocity = role.velocity.add(new Vector2D(0, role.speed)).truncate(role.speed);
        }

        public static function left(role:IBasicMotion):void {
            role.velocity = role.velocity.add(new Vector2D(role.speed * -1, 0)).truncate(role.speed);
        }
        
        public static function right(role:IBasicMotion):void {
            role.velocity = role.velocity.add(new Vector2D(role.speed, 0)).truncate(role.speed);
        }

        //public function turnLeft():void {
        //    actor.angularVel -= 1;
        //}
        
        //public function turnRight():void {
        //    actor.angularVel += 1;
        //}
    }
}