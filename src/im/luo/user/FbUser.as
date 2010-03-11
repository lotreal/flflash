package im.luo.user
{
    import com.facebook.data.users.GetInfoData;
    import com.facebook.utils.FacebookSessionUtil;
    import com.facebook.data.users.FacebookUser;
    import com.facebook.data.users.GetInfoFieldValues;
    import com.facebook.commands.users.GetInfo;
    import com.facebook.net.FacebookCall;
    import com.facebook.events.FacebookEvent;
    import com.facebook.Facebook;

    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    
    public class FbUser {
        private static var logger:Logger = Logger.getLogger(FbUser);
        public var context:Context = Context.instance;
        private var fbook:Facebook;
        private var session:FacebookSessionUtil;
        private var user:FacebookUser;

        private var API_KEY:String = "9c3b07f55e5e9ee759aa8dc87ac6c64d";
        private var SECRET_KEY:String = "7e5237b6d88b72363e546fdf37676e67";
        
        public function FbUser() {
            init();
        }
        
        private function init():void{
	    session=new FacebookSessionUtil(API_KEY, SECRET_KEY, context.root.loaderInfo);
	    session.addEventListener(FacebookEvent.CONNECT,onConnect);
	    session.addEventListener(FacebookEvent.ERROR,onError);
	    fbook=session.facebook;
            fbook.login(true);
	    session.login();
	    //session.validateLogin();
            logger.debug('init facebook', session);
        }

        private function onConfirmLogin():void {
	    //this.removeChild(loginbutton);
	    session.validateLogin();
        }

        private function onConnect(e:FacebookEvent):void {
            logger.debug('on connect facebook', fbook, fbook.uid);
	    var call:FacebookCall=fbook.post(new GetInfo([fbook.uid],[GetInfoFieldValues.ALL_VALUES]));
	    call.addEventListener(FacebookEvent.COMPLETE,onGetInfo);
        }

        private function onError(e:FacebookEvent):void {
            logger.debug('on error facebook');
        }

        private function onGetInfo(e:FacebookEvent):void {
            logger.debug('on getinfo facebook');
	    user=(e.data as GetInfoData).userCollection.getItemAt(0) as FacebookUser;
            //logger.debug("Hello "+user.first_name+" "+user.last_name);
            logger.debug(user);
        }
    }
}

//import com.facebook.Facebook;
//import com.facebook.events.FacebookEvent;
//import com.facebook.net.FacebookCall;
//import com.facebook.data.users.FacebookUser;
//import com.facebook.data.users.GetInfoData;
//import com.facebook.commands.users.GetInfo;
//import com.facebook.utils.FacebookSessionUtil;

//private var fbook:Facebook;
//private var session:FacebookSessionUtil;

//private var API_KEY:String = "9c3b07f55e5e9ee759aa8dc87ac6c64d";
//private var SECRET_KEY:String = "7e5237b6d88b72363e546fdf37676e67";

//session=new FacebookSessionUtil(
//    API_KEY,
//    SECRET_KEY,
//    context.root.loaderInfo);
//session.addEventListener(FacebookEvent.CONNECT, onConnect);
//fbook=session.facebook;
//private function onConnect(e:FacebookEvent):void {
//    _logger.debug("facebook api ready", e);
//    session.login();
//}

