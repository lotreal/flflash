package im.luo.item
{
    import im.luo.util.TimeUtil;
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
                TimeUtil.delay(cooldown, function ahandler():void{ inCooldown = false; });
                this.activate(role);
                TimeUtil.delay(cooldown, function handler():void{deactivate(role); });
            }
        }

        public virtual function activate(role:IRole):void {}
        
        public virtual function deactivate(role:IRole):void {}
    }
}