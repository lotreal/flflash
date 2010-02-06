package flf.flatland.face
{
    import flf.flatland.role.Heart;
    import im.luo.staff.Context;
    import flash.display.DisplayObject;
    import im.luo.role.IRole;
    
    public class HeartFace extends PropFace
    {
        public function HeartFace(role:Heart)
        {
            super(role);
            var chatMain:DisplayObject = new (Context.instance.loader.getDefinitionOf("hp"))();
            render.addChild(chatMain);
            //#CD1821
        }
    }
}