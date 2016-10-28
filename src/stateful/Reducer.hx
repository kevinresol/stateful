package stateful;

import haxe.macro.Expr;
import haxe.macro.Context;

using Lambda;

typedef R<S, A> = S->A->S; 

@:callable
abstract Reducer<S, A>(R<S, A>) from R<S, A> to R<S, A> {
	public static macro function combine(e:Expr) {
		switch e.expr {
			case EObjectDecl(fields):
				var rets = [];
				var conds = [];
				for(field in fields) {
					var name = field.field;
					var expr = field.expr;
					rets.push({field: name, expr: macro $expr(state == null ? null : state.$name, action)});
					conds.push(macro state.$name != newState.$name);
				}
				var ret = {expr: EObjectDecl(rets), pos: e.pos};
				return macro function(state, action) {
					var newState = $ret;
					
					// return newState if original state is null or any of the sub-state changed
					if(${conds.fold(function(i, last) return macro $last || $i, macro state == null)})
						return newState;
					
					// otherwise return the original state
					return state;
				}
				
			default:
				Context.error('Expected object declaration', e.pos);
				return macro null;
		}
	}
}