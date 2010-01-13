package
{
    import flash.events.Event;
    public interface IRoleBehaviour {
        function set role(value:Role):void;
        function run():void;
        function update(e:Event):void;
        function destroy():void;
    }
}