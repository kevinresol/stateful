package ;

import stateful.*;

class RunTests {

  static function main() {
    
    // var store = {
    //   app: new AppManager()
    // }
    
    
    var f1 = function(s:Int, a:String) return s; 
    var f2 = function(s:Bool, a:String) return s; 
    
    var f = Reducer.combine({
      f1: f1, f2: f2
    });
    
    var r = f({f1:1, f2: true}, '');
    trace(r);
    var store = new Store(f, {f1: 1, f2: false});
    trace(store.getState());
    
    travix.Logger.println('it works');
    travix.Logger.exit(0); // make sure we exit properly, which is necessary on some targets, e.g. flash & (phantom)js
  }
}

// typedef AppState = {count:Int}
// typedef AppManager = stateful.Manager<AppState, String>; 