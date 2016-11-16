package stateful;

typedef L<S, A> = S->S->A->Void;

@:callable
abstract Listener<S, A>(L<S, A>) from L<S, A> to L<S, A> {
	@:from
	public static inline function ofVoid<S, A>(f:Void->Void):Listener<S, A>
		return function(_, _, _) return f();
	@:from
	public static inline function ofState<S, A>(f:S->Void):Listener<S, A>
		return function(s, _, _) return f(s);
	@:from
	public static inline function ofAction<S, A>(f:A->Void):Listener<S, A>
		return function(_, _, a) return f(a);
}