package 
{
    import flash.display.*;
    import flash.geom.*;
    import im.luo.log.Logger;

    public class Vision extends Sprite {
        private var camera:Camera;
        
        public function Vision(p_camera:Camera) {
            camera = p_camera;
        }

        public function lineStyle(thickness:Number, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void {
            graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
        }

        public function beginFill(color:uint, alpha:Number = 1.0):void  {
            graphics.beginFill(color, alpha);
        }

        public function moveTo(x:Number, y:Number):void {
            x = camera.rx(x); y = camera.ry(y); graphics.moveTo(x, y);
        }

        public function lineTo(x:Number, y:Number):void {
            x = camera.rx(x); y = camera.ry(y); graphics.lineTo(x, y);
        }

        public function drawRect(x:Number, y:Number, width:Number, height:Number):void {
            x = camera.rx(x); y = camera.ry(y);
            graphics.drawRect(x, y, width * camera.scale, height * camera.scale);
        }

        public function drawCircle(x:Number, y:Number, radius:Number):void {
            x = camera.rx(x); y = camera.ry(y); 
            graphics.drawCircle(x, y, radius * camera.scale);
        }
    }
}