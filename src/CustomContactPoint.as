package 
{
    import flash.events.*;
    import im.luo.log.Logger;

    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.Math.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;

    public class CustomContactPoint {
        private var logger:Logger = Logger.getLogger(this);

        public var shape1:b2Shape;
        public var shape2:b2Shape;
        public var separation:Number;
        public var position:b2Vec2;
        
        public function CustomContactPoint (s1:b2Shape,s2:b2Shape, f:Number, p:b2Vec2){
            shape1 = s1;
            shape2 = s2;
            separation = f;
            position = p;
        }
    }
}
