package im.luo.item
{
    import im.luo.role.IRole;
    public interface IItem
    {
        function apply(role:IRole):void;
        function activate(role:IRole):void;
        function deactivate(role:IRole):void;
    }
}