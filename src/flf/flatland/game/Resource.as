package flf.flatland.game
{
    import br.com.stimuli.loading.BulkLoader;
    
    import flash.display.MovieClip;
    
    import im.luo.logging.Logger;

    public class Resource
    {
        private static var logger:Logger = Logger.getLogger(Resource);
        private var define:XML;
        private var loader:BulkLoader = null;
        
        public function Resource(loader:BulkLoader)
        {
            this.loader = loader;
            //this.init();
            //this.create();
        }
        
        /**
         * 从资源文件中通过 id 读出指定的 Class 
         * @param id 资源 id
         * @param content 资源文件 id, 参见 BulkLoader，默认为 "res"
         * @return Class
         * 
         */        
        public function getLoadedClass(id:String, content:String = "res"):Class
        {
            return loader.getContent(content).loaderInfo.applicationDomain.getDefinition(id) as Class;
        }
        
        public function create():void
        {
            logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            logger.debug(define.children());
        }
        
        public function any(resname:String):MovieClip
        {
            return (new (getLoadedClass(resname))()) as MovieClip;
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