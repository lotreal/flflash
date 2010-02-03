package flf.flatland.fx
{
    import im.luo.logging.Logger;
    import caurina.transitions.Tweener;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import im.luo.geom.Vector2D;
    import im.luo.camera.Camera;
    import flf.flatland.game.Context;
    
    public class Peng {
        private var _logger:Logger = Logger.getLogger(this);
        private var camera:Camera = Context.instance.camera;
        private var peng:Sprite = new Sprite();
        public function Peng(position:Vector2D) {
            camera.addChild(peng);
            //peng.graphics.beginFill(0xFFCC00);
            peng.graphics.lineStyle(1, 0xffffff);
            peng.graphics.drawCircle(0, 0, 32);
            peng.x = camera.rx(position.x);
            peng.y = camera.ry(position.y);

            Tweener.addTween(peng, 
                { scaleX: 0.01, scaleY: 0.01, alpha: 0.0, time: 1, onComplete: destroy });
        }

        public function destroy():void {
            camera.removeChild(peng);
        }
    }
}
