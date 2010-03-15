package flf.flatland.role
{
    import flf.flatland.fight.FightProfile;
    import flf.flatland.game.Groups;
    import flf.flatland.game.Roles;
    import flf.flatland.game.States;
    import flf.flatland.scene.PlayScene;
    import flf.flatland.ui.PlaySceneUI;
    
    import im.luo.action.IRoleAction;
    import im.luo.ui.UI;
    
    public class Player extends Citizen
    {
        public var fightProfile:FightProfile = new FightProfile();
        
        public function Player(name:String)
        {
            super(name, 3);
            this.groups.add(Roles.PLAYER);
            //if (Settings.debug) this.attack *= 100;
        }


        override public function hit(enemy:Citizen):void
        {
            super.hit(enemy);
            fightProfile.evalCombo();
            if (fightProfile.combo >= 2) this.scene.ui.setValue('combo', fightProfile.combo);
            if (enemy.state.has(States.DIED)) {
                fightProfile.kills++;
                fightProfile.exp = this.score;
                this.scene.ui.setValue('score', "Score : " + this.score);
            }
        }
        
        override public function getHurt(hurt:int):void 
        {
            super.getHurt(hurt);
            fightProfile.clearCombo();
        }
 
        override public function die():void
        {
            super.die();
            scene.showUI(PlayScene.GAMEOVER);
        }
       
        override public function pickGold(gold:int):void {
            super.pickGold(gold);
            this.fightProfile.golds += gold;
            this.scene.ui.setValue('gold', gold);
        }
        
        override public function set action(value:IRoleAction):void {
            super.action = value;
            //UI.instance.tips("当前操作方案: "+ value.toString() +" [切换操作方案: 空格键]");
        }
    }
}