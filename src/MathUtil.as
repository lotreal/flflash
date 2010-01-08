package
{
    import Box2D.Common.Math.b2Vec2;

    public final class MathUtil
    {
        public static function degreesToRadians(degrees:Number):Number
        {
            return (degrees * Math.PI / 180);
        }
        
        public static function radiansToDegrees(radians:Number):Number
        {
            return radians * 180 / Math.PI;
        }
        
        //returns angle in radians
        public static function getAngleBetweenPoints(p1:b2Vec2, p2:b2Vec2):Number
        {
            var dx:Number = p1.x - p2.x;
            var dy:Number = p1.y - p2.y;
            var radians:Number = Math.atan2(dy, dx);
            return radians;
        }
        
        public static function distanceBetweenPoints(p1:b2Vec2, p2:b2Vec2):Number
        {
            var dx:Number = p1.x - p2.x;
            var dy:Number = p1.y - p2.y;
            var dist:Number = Math.sqrt(dx * dx + dy * dy);
            
            return dist;
        }
        
        public static function abs(value:Number):Number
        {
            //http://lab.polygonal.de/2007/05/10/bitwise-gems-fast-integer-math/
            return (value ^ (value >> 31)) - (value >> 31);
        }
    }
}
