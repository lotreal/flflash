package im.luo.actor
{
	import im.luo.geom.Vector2D;
	import im.luo.motion.IAdvancedMotion;

    public interface IActor extends IAdvancedMotion {
        function play():void;
        function update():void;
        function destroy():void;
        

        // 设置坐标引起跳出边界问题的暂时解决方案
        function initPosition(value:Vector2D):void;
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