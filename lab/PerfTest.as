// ~/share/flex4sdk/bin/mxmlc -debug=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -static-link-runtime-shared-libraries=true /home/lot/workspace/flflash/lab/PerfTest.as
package
{
    import flash.display.Sprite;
    import im.luo.logging.Logger;
    import com.gskinner.utils.PerformanceTest;
    
    public class PerfTest extends Sprite {
        private var logger:Logger = Logger.getLogger(this);

        public function PerfTest() {
            var perfTest:PerformanceTest = PerformanceTest.getInstance();
            perfTest.out = logger.debug;

            var c1:Context = Context.instance;
            var c2:Contex2 = Contex2.instance;
            var c3:Contex3 = Contex3.instance;

            perfTest.testFunction(run, 2000000, "run1", "dyn method get");
            perfTest.testFunction(run2, 2000000, "run2", "getInstance method");
            perfTest.testFunction(run3, 2000000, "run3", "single factory get");
        }

        private function run():void
        {
            var c1:Context = Context.instance;
        }

        private function run2():void
        {
            var c2:Contex2 = Contex2.instance;
        }

       private function run3():void
        {
            var c3:Contex3 = Contex3.instance;
        }

    }
}

import im.luo.util.core.Singleton;

class Context {
    public function Context() {}

    private static var _instance:Context = null;
    public static function get instance():Context {
	return Context.getInstance();
    }
    public static var getInstance:Function = function():Context {
        return _getInstance();
    }
    private static function _getInstance():Context {
	if (_instance == null) {
            _instance = new Context();
            Context.getInstance = function():Context{ return _instance; };
        }
        return _instance;
    }
}

class Contex2 {
    public function Contex2() {}
    private static var _instance:Contex2 = null;
    public static function get instance():Contex2 {
        return Contex2.getInstance();
    }
    public static function getInstance():Contex2 {
        if (_instance == null) _instance = new Contex2();
        return _instance;
    }
}

class Contex3 {
    public function Contex3() {}

    public static function get instance():Contex3
    {
        return Singleton.getInstanceOrCreate(Contex3) as Contex3;
    }
}

/**
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#run1 (2000000 iterations)                                               ; 
 [I] PerfTest#Player version: WIN 10,0,42,34 (debug); 
 [I] PerfTest#dyn method get                                                          ; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#method...................................................ttl ms...avg ms; 
 [I] PerfTest#run1                                                       2082     0.00; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#run2 (2000000 iterations)                                               ; 
 [I] PerfTest#Player version: WIN 10,0,42,34 (debug); 
 [I] PerfTest#getInstance method                                                      ; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#; 
 [I] PerfTest#method...................................................ttl ms...avg ms; 
 [I] PerfTest#run2                                                       1894     0.00; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#run3 (2000000 iterations)                                               ; 
 [I] PerfTest#Player version: WIN 10,0,42,34 (debug); 
 [I] PerfTest#single factory get                                                      ; 
 [I] PerfTest#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––; 
 [I] PerfTest#method...................................................ttl ms...avg ms; 
 [I] PerfTest#run3                                                       2316     0.00; 

*/