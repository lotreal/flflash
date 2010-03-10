package im.luo.motion
{
    import im.luo.geom.Vector2D;

    public interface IBasicMotion
    {
        /**
         * Sets / gets position of character as a Vector2D.
         */
        function set position(value:Vector2D):void;
        function get position():Vector2D;
        
        // 读写线性速度
        function get velocity():Vector2D;
        function set velocity(value:Vector2D):void;
        
        // 得到最大速度数值
        function get speed():Number;
    }
}