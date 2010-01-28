package
{
    import flash.events.Event;
    public interface IRoleBehaviour {
        function set role(value:Character):void;
        function run():void;
        function update(e:Event):void;
        function destroy():void;
        function toString():String;
    }
}