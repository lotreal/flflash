package flf.flatland.face
{
    import flash.display.DisplayObject;
    
    import flf.flatland.role.Gold;

    public class GoldFace extends PropFace
    {
        public function GoldFace(role:Gold)
        {
            super(role);
            var chatMain:DisplayObject = new (context.loader.getContent("res").loaderInfo.applicationDomain.getDefinition("Coin") as Class)();
            addChild(chatMain);
        }
    }
}