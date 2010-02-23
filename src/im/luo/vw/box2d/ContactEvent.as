package im.luo.vw.box2d
{
    import Box2D.Collision.b2WorldManifold;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.Contacts.b2Contact;
    
    import flash.events.Event;
    
    import im.luo.geom.Vector2D;
    import im.luo.vw.IContactEvent;
    import im.luo.vw.Manifold;
    
    internal class ContactEvent extends Event implements IContactEvent
    {
        public function ContactEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }

        /**
         * 得到碰撞发生点的屏幕坐标 
         * @return Vector2D 碰撞点的屏幕坐标
         */        
        public function getContactPoint():Vector2D {
            var worldManifold:b2WorldManifold = new b2WorldManifold();
            contact.GetWorldManifold(worldManifold);
            var contactPoint:b2Vec2 = worldManifold.m_points[0];
            return new Vector2D(contactPoint.x * 30, contactPoint.y * 30);
        }

        public function get manifold():Manifold {
            return _manifold;
        }

        public function set manifold(value:Manifold):void {
            _manifold = value;
        }

        public var contact:b2Contact;

        private var _manifold:Manifold = null;
    }
}