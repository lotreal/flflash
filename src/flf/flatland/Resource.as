package flf.flatland
{
    import im.luo.logging.Logger;

    public class Resource
    {
        private static var logger:Logger = Logger.getLogger(Resource);
        private var define:XML;
        
        public function Resource()
        {
            this.init();
            this.create();
        }
        
        public function create():void
        {
            logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            logger.debug(define.children());
        }
        
        public function init():void
        {
            this.define =
                <resource>
                  <movieclip name="Heart" desc="血瓶" />
                  <movieclip name="Coin" desc="硬币" />
                
                  <movieclip name="Hit" desc="撞击_造成伤害" />
                  <movieclip name="Pass" desc="撞击_未造成伤害" />
                  <movieclip name="Guard" desc="保护罩" />
                  <movieclip name="Heal" desc="回血" />
                
                
                  <movieclip name="HPbar" desc="血条和边框">
                    <movieclip name="bar" desc="血条" />
                  </movieclip>
                
                  <movieclip name="LoadMC" desc="加载动画">
                    <movieclip name="bar" desc="进度条" />
                  </movieclip>
                
                
                  <movieclip name="GetCoin" desc="获得金钱">
                    <text name="num" />
                  </movieclip>
                
                  <movieclip name="Combo" desc="连击">
                    <text name="num" />
                  </movieclip>
                
                  <movieclip name="KillEnemy" desc="消灭敌人">
                    <text name="num" />
                  </movieclip>
                
                
                  <movieclip name="GameOver_Window" desc="游戏结束窗口">
                    <button name="BtnRestart" />
                    <button name="BtnShart" />
                    <text name="fs_kills" />
                    <text name="fs_exp" />
                    <text name="fs_golds" />
                    <text name="fs_maxcombo" />
                  </movieclip>
                </resource>
            
        }
    }
}