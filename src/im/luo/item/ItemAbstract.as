package im.luo.item
{
    import im.luo.util.TimerUtil;
    import im.luo.role.IRole;
    import im.luo.item.IItem;
    
    public class ItemAbstract implements IItem
    {
        public var cooldown:int = 200;
        public var protectedTime:int = cooldown;
        public var inCooldown:Boolean = false;
        public function ItemAbstract() {}

        public function apply(role:IRole):void {
            if (!inCooldown) {
                inCooldown = true;
                TimerUtil.delay(cooldown, function ahandler():void{ inCooldown = false; });
                this.activate(role);
                TimerUtil.delay(cooldown, function handler():void{deactivate(role); });
            }
        }

        public virtual function activate(role:IRole):void {}
        
        public virtual function deactivate(role:IRole):void {}
    }
}