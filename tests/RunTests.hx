package ;

class RunTests {

  static function main() {
    
    var store = {
      app: new AppManager()
    }
    
    travix.Logger.println('it works');
    travix.Logger.exit(0); // make sure we exit properly, which is necessary on some targets, e.g. flash & (phantom)js
  }
}

typedef AppState = {count:Int}
typedef AppManager = stateful.Manager<AppState, String>; 