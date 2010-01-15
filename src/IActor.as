package
{
    import Box2D.Dynamics.b2World;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Collision.Shapes.b2MassData;
    public interface IActor {
        function get world():b2World;

        function get angle():Number;
        function get position():b2Vec2;

        function get linearVel():b2Vec2;
        function set linearVel(value:b2Vec2):void;

        function get angularVel():Number;
        function set angularVel(value:Number):void;

        function get mass():b2MassData;
        function set mass(value:b2MassData):void;

        function get userdata():*;
        function set userdata(value:*):void;

        function update():void;
        function destroy():void;
    }
}