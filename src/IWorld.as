package
{
    import flash.events.Event;

    public interface IWorld {
        function run(e:Event = null):void;
        function destroyBody(body:*):void;
        function createBody(body:*):*;
    }
}
