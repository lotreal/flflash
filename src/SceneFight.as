package 
{
    import flash.display.*;
    import com.actionsnippet.qbox.*;
    import flf.*;
    import im.luo.log.Logger;

    public class SceneFight extends Sprite {
        private var logger:Logger = Logger.getLogger(this);

        private var qbWorld:QuickBox2D
        public function SceneFight():void {
            var mc:MovieClip = new MovieClip();
            var context:Context = Context.instance;
            context.sprite.addChild(mc);
            qbWorld = new QuickBox2D(mc, {gravityX:0, gravityY:0, debug:true, frim:true});
            qbWorld.setDefault({
                    lineColor:0x666666, 
                    lineThickness:3.0, 
                    fillColor:0x666666, 
                    fillAlpha:0.75,
                    //density:0,
                    radius:1.5,
                    fixedRotation:false,
                    linearDamping: 1.5,
                    angularDamping: 0.8,
                    friction: 1.0
                });
            qbWorld.createStageWalls();
            qbWorld.grid();
            qbWorld.start();
            qbWorld.mouseDrag();
            logger.debug('完成布景');
            createDoll();
            logger.debug('建立角色');
            //createDoll();
        }

        public function createDoll():void {
            var d:Doll = new Doll();
            d.controller = new DCKeyboardA(d);
            d.appendTo(qbWorld);
            d.action();
        }
    }
}
