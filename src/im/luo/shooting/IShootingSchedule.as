package im.luo.shooting
{
    public interface IShootingSchedule
    {
        function init():void;
        function destroy():void
        function action():void;
        function cut():void
    }
}