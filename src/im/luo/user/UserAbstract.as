package im.luo.user
{
    import im.luo.staff.Context;

    public class UserAbstract
    {
        private var _id:String = '';
        private var _score:int = 0;
        private var _money:int = 0;
        
        public var context:Context = Context.instance;

        public function UserAbstract()
        {
            this.load();
        }

        public function get id():String {
            return _id;
        }

        public function set id(value:String):void {
            _id = value;
        }

        public function get score():int {
            return _score;
        }

        public function set score(value:int):void {
            _score = value;
        }
        
        public function get money():int {
            return _money;
        }
        
        public function set money(value:int):void {
            _money = value;
        }
        
        public function load():void {}
    }
}