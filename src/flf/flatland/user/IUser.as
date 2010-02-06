package flf.flatland.user
{
    public interface IUser
    {
        function get name():String;
        function set name(value:String):void;
        
        function get money():int;
        function set money(value:int):void;

        function get score():int;
        function set score(value:int):void;
    }
}