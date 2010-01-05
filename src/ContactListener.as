package 
{
    import flash.events.*;
    import im.luo.log.Logger;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.Math.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    
    public class ContactListener extends b2ContactListener {
        private var logger:Logger = Logger.getLogger(this);

        public var contactStack:Array = new Array();
        
        override public function Add(point:b2ContactPoint):void{
            var shape1:b2Shape = point.shape1;
            var shape2:b2Shape = point.shape2;
            var separation:Number = point.separation;
            var position:b2Vec2 = point.position.Copy();
            
            contactStack.push(new CustomContactPoint(shape1,shape2,separation,position));
        }
    }
}