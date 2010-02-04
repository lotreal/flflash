package im.luo.util{
    import flash.display.*;
    import flash.events.*;
    import im.luo.staff.Context;

    public class KeyMapper extends Sprite{
        public  var keys:uint = 0;
        private var _map:Vector.<int> = new Vector.<int>(256, true);
        
        function KeyMapper(context:Context): void { 
            for (var i:int=0; i<256; i++) _map[i]=31;
            context.stage.addEventListener("keyDown", 
                function(e:KeyboardEvent) : void {
                    keys |= 1<<_map[e.keyCode];
                });
            context.stage.addEventListener("keyUp",
                function(e:KeyboardEvent) : void {
                    keys &= ~(1<<_map[e.keyCode]);
                });
        }
        
        public function map(bit:int, ...args) : KeyMapper {
            for (var i:int=0; i<args.length; i++) _map[args[i]] = bit;
            return this;
        }

        public function pressed(bit:int):Boolean {
            return Boolean((keys >> bit ) & 1);
        }
    }
}
