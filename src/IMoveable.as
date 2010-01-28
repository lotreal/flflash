package
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
	* Sets / gets position of character as a Vector2D.
	*/
	function set position(value:Vector2D):void;
	function get position():Vector2D;
	
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