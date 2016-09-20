package stateful;

using tink.CoreApi;

typedef Dispatcher<Action> = AnyTime<Action>->Void;

class Manager<State, Action> {
	
	public var state(default, null):State;
	public var changed:Signal<State>;
	var changedTrigger:SignalTrigger<State>;
	
	public function new(?initialState:State) {
		state = initialState;
		changed = changedTrigger = Signal.trigger();
	}
	
	public function dispatch(action:AnyTime<Action>) {
		action.handle(function(action) {
			var oldState = state;
			state = handle(state, action);
			if(oldState != state) changedTrigger.trigger(state);
		});
	}
	
	function handle(state:State, action:Action):State {
		return state;
	}
}

@:forward
private abstract AnyTime<Action>(Future<Action>) from Future<Action> to Future<Action> {
	@:from
	public static inline function ofSync<A>(action:A):AnyTime<A>
		return Future.sync(action);
}