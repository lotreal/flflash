package im.luo.user
{
    import flash.external.ExternalInterface;

    public class WebUser extends UserAbstract implements IUser
    {
        public function WebUser()
        {
            super();
        }
        
        override public function load():void
        {
            var params:Object = context.root.loaderInfo.parameters;
            this.id = params['fb_fig_user'];
        }
        
        public function save():void
        {
            var r:String = String(ExternalInterface.call('change_value', id, score, money ));
        }
    }
}