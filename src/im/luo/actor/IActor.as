package im.luo.actor
{
	import im.luo.geom.Vector2D;
	import im.luo.vw.IMoveable;

    public interface IActor extends IMoveable {
        function play():void;
        function update():void;
        function destroy():void;
        
        /**
         * Sets / gets position of character as a Vector2D.
         */
        function set position(value:Vector2D):void;
        function get position():Vector2D;
        /**
         * Sets / gets x position of character.
         */
        function set x(value:Number):void;
        function get x():Number;
        
        /**
         * Sets / gets y position of character.
         */
        function set y(value:Number):void;
        function get y():Number;
        
        /**
         * Sets / gets angle of character by radian.
         */
        function set angle(value:Number):void;
        function get angle():Number;
    }
}