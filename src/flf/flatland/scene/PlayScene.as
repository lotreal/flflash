package flf.flatland.scene
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.events.*;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyA;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    
    import im.luo.logging.Logger;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;

    public class PlayScene extends Scene {
        public var player:Player;
        public var npcs:Vector.<Npc>;

        [Embed(source="../../../../resource/04.png")]
        public var bgImage:Class;

        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }

        override public function build():void {
            var bgLayer:ISceneLayer = new TileLayer();

            //var map1:DisplayObject = new (context.loader.getDefinitionOf("Map1"))();
            //var map2:DisplayObject = new (context.loader.getDefinitionOf("Map2"))();
            //var map3:DisplayObject = new (context.loader.getDefinitionOf("Map3"))();
            //var map4:DisplayObject = new (context.loader.getDefinitionOf("Map4"))();
            //map2.x = 997;
            //map3.y = 600;
            //map4.x = 997;
            //map4.y = 600;
            //bgLayer.add(map1);
            //bgLayer.add(map2);
            //bgLayer.add(map3);
            //bgLayer.add(map4);

            var chatMain:DisplayObject = new (context.loader.getDefinitionOf("hp"))();
            chatMain.x = 100;
            chatMain.y = 100;
            var bg:Bitmap = new bgImage();
            bgLayer.add(bg);
            //bgLayer.add(chatMain);

            var mainLayer:ISceneLayer = new SpriteLayer();

            player = new Player('user', 375, 275);
            player.action = new PlayerHotkeyA(this, player);
            addCharacter('player', player, mainLayer);

            var edge:Edge = new Edge('edge', 0, 0);
            addCharacter('edge', edge, mainLayer);

            var npc:Npc;
            var x:Number, y:Number;
            for (var i:int = 0; i < 10; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;

                npc = new Npc('npc'+i, x, y);
                addCharacter('npc'+i, npc, mainLayer);
                npcs.push(npc);
            }

            for (var j:int = 0; j < 10; j++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var gold:Gold = new Gold('gold'+j, x, y);
                addCharacter('gold'+j, gold, mainLayer);
            }
            
            for (var k:int = 0; k < 10; k++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var heart:Heart = new Heart('heart'+k, x, y);
                addCharacter('heart'+k, heart, mainLayer);
            }

            var debugLayer:ISceneLayer = new SpriteLayer();
            //debugLayer.add(context.cache['world_debug_draw']);

            var uiLayer:ISceneLayer = new SpriteLayer();
            uiLayer.add(context.cache['ui']);

            addLayer(bgLayer);
            addLayer(mainLayer);
            addLayer(debugLayer);
            addLayer(uiLayer);

            _logger.debug("完成游戏场景搭建");
        }

        override public function play():void {
            for (var i:int = 0, l:int = roles.length; i < l; i++) {
                roles[i].play();
            }
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}