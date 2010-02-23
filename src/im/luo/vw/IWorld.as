package im.luo.vw
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    public interface IWorld extends IEventDispatcher 
    {
        function run(e:Event = null):void;
        function destroyBody(body:*):void;
        function createBody(body:*):*;
    }
}
