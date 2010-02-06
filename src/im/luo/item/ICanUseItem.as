package im.luo.item
{
    import im.luo.role.IRole;

    public interface ICanUseItem extends IRole
    {
        function activate(item:IItem):void;
        function deactivate(item:IItem):void;
    }
}