package flf.flatland.face
{
    import im.luo.logging.Logger;
    import flash.events.Event;
    import flash.geom.Matrix;
    import im.luo.geom.Vector2D;
    import flf.flatland.role.Creature;
    
    import flash.display.GraphicsPathCommand;
    import flash.display.Sprite;
    import im.luo.face.Face;
    
    public class CreatureFace extends Face {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function CreatureFace(role:Creature) {
            super(role);

            var commands:Vector.<int> = new Vector.<int>();
            commands.push(GraphicsPathCommand.MOVE_TO);
            
            var data:Vector.<Number> = new Vector.<Number>();
            
            var radius:Number = role.radius;
            var edges:int = role.level;
            var innerangle:Number = (2 * Math.PI) / edges;
            var x:Number, y:Number;
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
            commands.push(GraphicsPathCommand.LINE_TO);
            data.push(0);
            data.push(0);

            render.graphics.lineStyle(2, role.color, 1);
            _logger.debug(role.color, role.name);
            render.graphics.drawPath(commands, data);
            //_logger.debug("图形路径数据");
            //_logger.debug(commands);
            //_logger.debug(data);
        }
        
        override public function paint():void {
        }
        
        override public function repaint():void {
        }
    }
}