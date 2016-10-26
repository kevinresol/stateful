package stateful;

class Store<S, A> {
	
	var reducer:Reducer<S, A>;
	var state:S;
	var listeners:Array<Listener<S, A>>;
	
	public function new(reducer:Reducer<S, A>, ?initialState:S) {
		this.reducer = reducer;
		this.state = initialState;
		listeners = [];
		dispatch(null);
	}
	
	public inline function getState() {
		return state;
	}
	
	public function dispatch(action:A) {
		var oldState = state;
		state = reducer(state, action);
		for(listener in listeners.copy())
			listener(state, oldState, action);
	}
	
	public function subscribe(listener:Listener<S, A>) {
		if(listeners.indexOf(listener) == -1) listeners.push(listener);
		return function() listeners.remove(listener);
	}
}