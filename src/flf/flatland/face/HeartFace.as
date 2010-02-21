package flf.flatland.face
{
    import flf.flatland.role.Heart;
    import flash.display.DisplayObject;
    import im.luo.role.IRole;

    public class HeartFace extends PropFace
    {
        public function HeartFace(role:Heart)
        {
            super(role);
            var chatMain:DisplayObject = new (context.loader.getContent("res").loaderInfo.applicationDomain.getDefinition("HP") as Class)();
            addChild(chatMain);
            //#CD1821
        }
    }
}