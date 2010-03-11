package im.luo.user
{
    public interface IUser
    {
        function get id():String;
        function set id(value:String):void;
        
        function get score():int;
        function set score(value:int):void;

        function get money():int;
        function set money(value:int):void;

        function load():void;
        function save():void;
    }
}