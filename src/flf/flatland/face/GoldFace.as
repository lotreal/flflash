package flf.flatland.face
{
    import flf.flatland.role.Gold;
    import im.luo.staff.Context;
    import flash.display.DisplayObject;

    public class GoldFace extends PropFace
    {
        public function GoldFace(role:Gold)
        {
            super(role);
            var chatMain:DisplayObject = new (Context.instance.loader.getDefinitionOf("coin"))();
            render.addChild(chatMain);

        }
    }
}