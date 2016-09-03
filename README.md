# stateful

Mimic Redux, in a Haxey manner.

To be continued...

## Use with React

```haxe
// Entry point
static function main() {
	var manager = new Manager({counter: 1});
	ReactDOM.render(jsx('<App manager={manager}/>'), js.Browser.document.getElementById('app'));
}

// App Manager, contains the state and action handler
typedef State = {counter:Int};
typedef Action = String;

class Manager extends stateful.Manager<State, Action> {
	override function handle(state:State, action:Action):State {
		switch action {
			case 'add': state.counter += 1;
			default:
		}
		return state;
	}
}

// Main React App
typedef Provider = stateful.plugin.react.Provider<Manager>;

class App extends ReactComponentOfProps<{manager:Manager}> {
	override function render() {
		return jsx('
			<Provider manager={props.manager}>
				<TestComponent/>
			</Provider>
		');
	}
}

// An React Component
typedef Component<P, S> = stateful.plugin.react.Component<P, S, State, Action, Manager>;

class TestComponent extends Component<Dynamic, {counter:Int}> {
	override function render() {
		return jsx('
			<h1>Counter: {state.counter}</h1>
		');
	}
	
	override function mapState(state:State) {
		return {
			counter: state.counter,
		}
	}
	
	var timer:haxe.Timer;
	override function componentDidMount() {
		super.componentDidMount(); // Note: don't omit this
		
		// Let's try to dispatch some actions at an interval
		timer = new haxe.Timer(500);
		timer.run = function() dispatch(Add);
	}
	
	override function componentWillUnmount() {
		super.componentWillUnmount(); // Note: don't omit this
		
		// Stop the timer
		timer.stop();
	}	
}
```

## Plugin the transform library

https://github.com/kevinresol/transform

To be documented...