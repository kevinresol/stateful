package stateful;

class Store<S, A> {
	
	// TODO: find a way to avoid scoping issue when using with react-redux, to change dispatch back to an instance method
	public var dispatch(default, null):A->Void;
	
	var reducer:Reducer<S, A>;
	var state:S;
	var listeners:Array<Listener<S, A>>;
	
	public function new(reducer:Reducer<S, A>, ?initialState:S) {
		this.reducer = reducer;
		this.state = initialState;
		listeners = [];
		dispatch = function (action:A) {
			var oldState = this.state;
			state = reducer(state, action);
			for(listener in listeners.copy())
				listener(state, oldState, action);
		}
		dispatch(null);
	}
	
	@:keep
	public inline function getState() {
		return state;
	}
	
	@:keep
	public function subscribe(listener:Listener<S, A>) {
		if(listeners.indexOf(listener) == -1) listeners.push(listener);
		return function() listeners.remove(listener);
	}
}