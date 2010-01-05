package
{
    import flash.events.Event;
    public interface IRoleBehaviour {
        function set actor(a:Actor):void;
        function run():void;
        function update(e:Event):void;
    }
}