package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;
    
    public class ContactPoint {
        private var _logger:Logger = Logger.getLogger(this);

        public var actor1:Actor;
        public var actor2:Actor;
        public var separation:Number;
        public var position:b2Vec2;

        public function ContactPoint(actor1:Actor, actor2:Actor, separation:Number, position:b2Vec2) {
            this.actor1 = actor1;
            this.actor2 = actor2;
            this.separation = separation;
            this.position = position;
        }
    }
}
