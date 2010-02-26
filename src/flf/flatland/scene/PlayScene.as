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
    import im.luo.staff.Context;
    import im.luo.staff.Screen;
    import im.luo.util.TimerUtil;
    import im.luo.vw.IContactEvent;
    import im.luo.vw.IWorld;
    import im.luo.vw.RoleEvent;
    import im.luo.vw.World;
    
    // 战斗场景
    public class PlayScene extends Scene {
        public var player1:Player;
        //public var npcs:Vector.<Npc>;
        //public var npc_actors:Vector.<IActor> = new Vector.<IActor>();
        private var fight:Fight = new Fight();
        
        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            //npcs = new Vector.<Npc>();
        }
        
        override public function destroy():void
        {
            super.destroy();
            this.state.clear().add(GAMEOVER);
            var world:IWorld = World.instance;
            world.removeEventListener(World.BEGINCONTACT, beginContact);
            timerUtil.stop();
        }
        
        private function addNpc(layer:ISceneLayer):void
        {
            var x:int = Math.random() * rect.width;
            var y:int = Math.random() * rect.height;
            
            var npc:Npc = new Npc('npc'+x);
            npc.action = new SeekAction(this, npc);
            this.roles.layoutRole(this, layer, npc, new Vector2D(x, y));
            
            npc.addEventListener(World.REMOVEROLE, onNpcDied);
            //npcs.push(npc);
            //npc_actors.push(npc.actor);
        }
        
        override public function build():void {
            this.state.clear().add(BUILD);
            var world:IWorld = World.instance;
            world.addEventListener(World.BEGINCONTACT, beginContact);
            _ui = new PlaySceneUI();
            _ui.build();
            
            var bgLayer:ISceneLayer = new TileLayer();
            
            var bg:Bitmap = context.loader.getBitmap("bg");
            bgLayer.add(bg);
            
            mainLayer = new SpriteLayer();
            
            player1 = this.roles.registerPlayer();
            this.roles.layoutRole(this, mainLayer, player1, new Vector2D(rect.width / 2, rect.height / 2));
            
            //Roles.layoutNpc(this, mainLayer, generator(35, 20));
            
            var edge:Edge = new Edge('edge');
            this.roles.layoutRole(this, mainLayer, edge, new Vector2D(0, 0));
            
            var npc:Npc;
            var x:Number, y:Number;
            
            var npcCount:int = 10;
            var goldCount:int = 10;
            var heartCount:int = 10;
            
            for (var i:int = 0; i < npcCount; i++) {
                addNpc(mainLayer);
            }
            
            for (var j:int = 0; j < goldCount; j++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var gold:Gold = new Gold();
                this.roles.layoutRole(this, mainLayer, gold, new Vector2D(x, y));
            }
            
            for (var k:int = 0; k < heartCount; k++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var heart:Heart = new Heart('heart'+k);
                this.roles.layoutRole(this, mainLayer, heart, new Vector2D(x, y));
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
            
            timerUtil = new TimerUtil(120 * 1000, 1000, true);
            timerUtil.addEventListener(TimerEvent.TIMER, timerHandler);
            timerUtil.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            timerUtil.start();
            this.state.clear().add(PLAYING);
        }
        
        private function timerHandler(event:TimerEvent):void
        {
            ui.setValue('time', timerUtil.getTimeString());
        }
        
        private function completeHandler(event:TimerEvent):void {
            _logger.debug("game over");
            timerUtil.stop();
            showUI(GAMEOVER);
        }
        
        private function onNpcDied(event:RoleEvent):void
        {
            if (this.state.has(PLAYING))
            {
                _logger.debug("重新刷新一个死亡的NPC");
                this.addNpc(mainLayer);
            }
        }
        
        override public function play():void {
            roles.play(roles.all);
        }
        
        override public function showUI(id:String):void
        {
            if (id == GAMEOVER)
            {
                this.state.clear().add(GAMEOVER);
                var gameover_ui:GameOverUI = new GameOverUI();
                gameover_ui.fight_profile = player1.fightProfile.toString();
                gameover_ui.build();
                
                gameover_ui.addEventListener(REPLAY, restart);
            }
        }
        
        public function restart(event:Event):void
        {
            this.dispatchEvent(event);
            trace ("playScene发送replay");
            //destroy();
            //build();
        }
        
        public function beginContact(event:IContactEvent):void {
            //_logger.debug('begin contact', event.getContactPoint());
            var a:IRole = event.manifold.role1;
            var b:IRole = event.manifold.role2;

            if (a.groups.eq(b.groups)) return;
            if (a.groups.has(Roles.EDGE) || b.groups.has(Roles.EDGE)) return;

            var p:Vector2D = event.getContactPoint();
            if (a.groups.has(Roles.CITIZEN) && b.groups.has(Roles.CITIZEN)) {
                //collidByCreature(a as Citizen, b as Citizen, p);
                event.manifold.attackPoint = p;
                event.manifold.scene = this;
                fight.attackRolls(event.manifold);
            } else if (a.groups.has(Roles.CITIZEN) && b.groups.has(Roles.GOLD)) {
                collidByGold(a as Citizen, b as Gold, p);
            } else if (b.groups.has(Roles.CITIZEN) && a.groups.has(Roles.GOLD)) {
                collidByGold(b as Citizen, a as Gold, p);
            } else if (a.groups.has(Roles.CITIZEN) && b.groups.has(Roles.HEART)) {
                collidByHeart(a as Citizen, b as Heart, p);
            } else if (b.groups.has(Roles.CITIZEN) && a.groups.has(Roles.HEART)) {
                collidByHeart(b as Citizen, a as Heart, p);
            }

        }
        
        public function collidByGold(a:Citizen, b:Gold, position:Vector2D):void {
            a.pickGold(b.gold);
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }

        public function collidByHeart(a:Citizen, b:Heart, position:Vector2D):void {
            a.heal(1);
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }
        
        private var timerUtil:TimerUtil;
        private var _logger:Logger = Logger.getLogger(this);
        private var mainLayer:ISceneLayer;
        
        public static var BUILD:String = "build";
        public static var PLAYING:String = "playing";
        public static var GAMEOVER:String = "GameOver";
        public static var REPLAY:String = "replay";
    }
}
