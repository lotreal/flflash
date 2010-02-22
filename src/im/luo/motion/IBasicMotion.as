package im.luo.motion
{
    import im.luo.geom.Vector2D;

    public interface IBasicMotion
    {
        // 读写线性速度
        function get velocity():Vector2D;
        function set velocity(value:Vector2D):void;
        
        // 得到最大速度数值
        function get speed():Number;
    }
}