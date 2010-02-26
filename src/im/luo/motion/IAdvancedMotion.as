package im.luo.motion
{
    import im.luo.geom.Vector2D;

    public interface IAdvancedMotion extends IBasicMotion
    {
        function get steeringForce():Vector2D;
        function set steeringForce(value:Vector2D):void;
    }
}