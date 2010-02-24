package flf.flatland.scene
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyB;
    import flf.flatland.fight.Fight;
    import flf.flatland.game.Roles;
    import flf.flatland.item.InjuryProtect;
    import flf.flatland.role.Citizen;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    import flf.flatland.ui.GameOverUI;
    import flf.flatland.ui.PlaySceneUI;
    
    import im.luo.action.SeekAction;
    import im.luo.actor.IActor;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;
    import im.luo.util.TimerUtil;
    import im.luo.vw.IContactEvent;
    import im.luo.vw.IWorld;
    import im.luo.vw.World;
    import im.luo.staff.Context;
    import im.luo.staff.Screen;
    
    // 战斗场景
    public class PlayScene extends Scene {
        public var player1:Player;
        public var npcs:Vector.<Npc>;
        public var npc_actors:Vector.<IActor> = new Vector.<IActor>();
        private var fight:Fight = new Fight();
        
        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }
        
        override public function destroy():void
        {
            super.destroy();
            var world:IWorld = World.instance;
            world.removeEventListener(World.BEGINCONTACT, beginContact);
        }
        
        override public function build():void {
            var world:IWorld = World.instance;
            world.addEventListener(World.BEGINCONTACT, beginContact);
            PlaySceneUI.instance.build();
            
            var bgLayer:ISceneLayer = new TileLayer();
            
            var bg:Bitmap = context.loader.getBitmap("bg");
            bgLayer.add(bg);
            
            var mainLayer:ISceneLayer = new SpriteLayer();
            
            player1 = Roles.registerPlayer();
            Roles.layoutRole(this, mainLayer, player1, new Vector2D(rect.width / 2, rect.height / 2));
/*            new Player('user', rect.width / 2, rect.height / 2, 3);
            player1.action = new PlayerHotkeyB(this, player1);
*/          //addCharacter('player', player1, mainLayer);
            
            //player1 = Roles.getPlayer();
            //Roles.layoutRole(this, mainLayer, player1, x, y);
            
            //Roles.layoutNpc(this, mainLayer, generator(35, 20));
            
            var edge:Edge = new Edge('edge');
            Roles.layoutRole(this, mainLayer, edge, new Vector2D(0, 0));
            
            var npc:Npc;
            var x:Number, y:Number;
            
            var npcCount:int = 9;
            var goldCount:int = 9;
            var heartCount:int = 9;
            
            for (var i:int = 0; i < npcCount; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                npc = new Npc('npc'+i);
                npc.action = new SeekAction(this, npc);
                Roles.layoutRole(this, mainLayer, npc, new Vector2D(x, y));
                npcs.push(npc);
                npc_actors.push(npc.actor);
            }
            
            for (var j:int = 0; j < goldCount; j++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var gold:Gold = new Gold('gold'+j);
                Roles.layoutRole(this, mainLayer, gold, new Vector2D(x, y));
            }
            
            for (var k:int = 0; k < heartCount; k++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var heart:Heart = new Heart('heart'+k);
                Roles.layoutRole(this, mainLayer, heart, new Vector2D(x, y));
            }
            
           
            var uiLayer:ISceneLayer = new SpriteLayer();
            //context.screen.setLayer(Screen.SCENE_UI, new Sprite());
            uiLayer.add(context.screen.getLayer(Screen.SCENE_UI));
            
            addLayer(bgLayer);
            addLayer(mainLayer);
            
            if (Settings.debug)
            {
                var debugLayer:ISceneLayer = new SpriteLayer();
                debugLayer.add(context.screen.getLayer('world_debug_draw'));
                addLayer(debugLayer);                
            }
            
            addLayer(uiLayer);
            
            _logger.debug("完成游戏场景搭建");
            
            timerUtil = new TimerUtil(2 * 1000, 1000, true);
            timerUtil.addEventListener(TimerEvent.TIMER, timerHandler);
            timerUtil.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            timerUtil.start();
        }
        
        private function timerHandler(event:TimerEvent):void
        {
            ui.time.content = timerUtil.getTimeString();
        }
        
        private function completeHandler(event:TimerEvent):void {
            _logger.debug("game over");
            timerUtil.stop();
            showUI(GAMEOVER);
        }
        
        override public function play():void {
            for (var i:int = 0, l:int = roles.length; i < l; i++) {
                roles[i].play();
            }
        }
        
        override public function showUI(id:String):void
        {
            if (id == GAMEOVER)
            {
                var gameover_ui:GameOverUI = new GameOverUI();
                gameover_ui.fight_profile = player1.fightProfile.toString();
                gameover_ui.build();
                
                gameover_ui.addEventListener(REPLAY, restart);
            }
        }
        
        public function restart(event:Event):void
        {
            this.dispatchEvent(event);
            //destroy();
            //build();
        }
        
        public function beginContact(event:IContactEvent):void {
            _logger.debug('begin contact', event.getContactPoint());
            var a:IRole = event.manifold.role1;
            var b:IRole = event.manifold.role2;

            if (a.groupid == b.groupid) return;
            if (a.type == Roles.EDGE || b.type == Roles.EDGE) return;

            var p:Vector2D = event.getContactPoint();
            if (a.type == Roles.CITIZEN && b.type == Roles.CITIZEN) {
                //collidByCreature(a as Citizen, b as Citizen, p);
                event.manifold.attackPoint = p;
                event.manifold.scene = this;
                fight.attackRolls(event.manifold);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.GOLD) {
                collidByGold(a as Citizen, b as Gold, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.GOLD) {
                collidByGold(b as Citizen, a as Gold, p);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.HEART) {
                collidByHeart(a as Citizen, b as Heart, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.HEART) {
                collidByHeart(b as Citizen, a as Heart, p);
            }

        }
        
        public function collidByGold(a:Citizen, b:Gold, position:Vector2D):void {
            a.pickGold(100);
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }

        public function collidByHeart(a:Citizen, b:Heart, position:Vector2D):void {
            a.hp += 1;
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }
        
        public var ui:PlaySceneUI = PlaySceneUI.instance;
        private var timerUtil:TimerUtil;
        private var _logger:Logger = Logger.getLogger(this);
        
        public static var GAMEOVER:String = "GameOver";
        public static var REPLAY:String = "replay";
    }
}
