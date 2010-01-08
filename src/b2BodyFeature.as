package 
{
    import flash.events.*;
    import im.luo.logging.Logger;

import Box2D.Dynamics.*;
import Box2D.Dynamics.Joints.*;
import Box2D.Dynamics.Contacts.*;
import Box2D.Collision.Shapes.*;
import Box2D.Common.Math.*;
import Box2D.Common.*;
    
    public class b2BodyFeature extends EventDispatcher {
        private var logger:Logger = Logger.getLogger(this);
        public function b2BodyFeature():void {
            
        }

        private var b2xform:b2XForm;

        public function getFrom():void {
            
        }
        public function apply():void {
            body.SetXForm(b2xform.position, b2xform.R);
        }
        //private function createFrom(b2parent:b2Body):void {
        //    var b2new:b2Body = new b2Body();
	//    b2new.SetXForm(b2parent.GetPosition, b2parent.GetAngle());
        //    b2new.SetLinearVelocity(b2parent.GetLinearVelocity());
        //    b2new.SetAngularVelocity(b2parent.GetAngularVelocity());
        //    b2new.SetBullet(b2parent.IsBullet());
        //}
    }
}
