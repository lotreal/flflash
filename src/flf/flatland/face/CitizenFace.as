package flf.flatland.face
{
    import flash.display.GraphicsPathCommand;
    import flash.display.MovieClip;
    
    import flf.flatland.role.Citizen;
    
    import im.luo.face.Face;
    import im.luo.logging.Logger;
    import im.luo.ui.UI;
    
    public class CitizenFace extends Face {
        public function CitizenFace(role:Citizen) {
            super(role);
        }
        
        override public function paint():void {
            var commands:Vector.<int> = new Vector.<int>();
            var data:Vector.<Number> = new Vector.<Number>();

            var radius:Number = role.radius;
            var edges:int = role.level;
            var innerangle:Number = (2 * Math.PI) / edges;
            var x:Number, y:Number;

            commands.push(GraphicsPathCommand.MOVE_TO);
            for (var i:int = 0; i < edges; i++) {
                x = Math.cos((innerangle * i)) * radius;
                y = Math.sin((innerangle * i)) * radius;
                data.push(x);
                data.push(y);
                commands.push(GraphicsPathCommand.LINE_TO);
            }

            commands.push(GraphicsPathCommand.LINE_TO);
            data.push(data[0]);
            data.push(data[1]);
            
            body.graphics.lineStyle(2, role.color, 1);
            body.graphics.beginFill(role.color);
            body.graphics.drawPath(commands, data);
            body.graphics.endFill();
        }

        override public function express(desc:String):void
        {
            if (desc == HURT) {
                var effect:MovieClip = new (context.getLoadedClass(HURT))();
                effect.x = effect.width / -2;
                ui.addChild(effect);
                
                var hpPct:Number = role.hp / role.init_hp;
                body.alpha = hpPct;
                _logger.debug('express hurt');
            }
        }
        
        public static var HURT:String = "Hurt"; 
        
        private var _logger:Logger = Logger.getLogger(this);
    }
}