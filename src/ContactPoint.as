package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;
    import im.luo.physics.box2d.box2dActor;
    
    public class ContactPoint {
        private var _logger:Logger = Logger.getLogger(this);

        public var actor1:box2dActor;
        public var actor2:box2dActor;
        public var separation:Number;
        public var position:b2Vec2;

        public function ContactPoint(actor1:box2dActor, actor2:box2dActor, separation:Number, position:b2Vec2) {
            this.actor1 = actor1;
            this.actor2 = actor2;
            this.separation = separation;
            this.position = position;
        }
    }
}
