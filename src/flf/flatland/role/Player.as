package flf.flatland.role
{
    import flf.flatland.game.Groups;
    
    import im.luo.action.IRoleAction;
    import im.luo.ui.UI;
    
    public class Player extends Citizen
    {
        public function Player(name:String, x:int, y:int, level:int)
        {
            super(name, x, y, level);
            type = Roles.CITIZEN;
            groupid = Groups.PLAYER;
        }

        override public function set action(value:IRoleAction):void {
            super.action = value;
            UI.instance.tips("当前操作方案: "+ value.toString() +" [切换操作方案: 空格键]");
        }
    }
}