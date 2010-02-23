package im.luo.vw
{
    import flash.geom.Point;
    import im.luo.geom.Vector2D;
    
    public interface IMoveable {
        /**
         * Sets / gets maximum speed of character.
         */
        function set maxSpeed(value:Number):void;
        
        function get maxSpeed():Number;
        
        /**
         * Sets / gets velocity of character as a Vector2D.
         */
        function set linearVel(value:Vector2D):void;
        function get linearVel():Vector2D;
        
        /**
         * Sets / gets rotational speed of character as radian / s.
         */
        function set angularVel(value:Number):void;
        function get angularVel():Number;
    }
}