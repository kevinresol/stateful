package stateful;

import haxe.macro.Expr;
import haxe.macro.Context;

typedef R<S, A> = S->A->S; 

@:callable
abstract Reducer<S, A>(R<S, A>) from R<S, A> to R<S, A> {
	public static macro function combine(e:Expr) {
		switch e.expr {
			case EObjectDecl(fields):
				var rets = [];
				for(field in fields) {
					var name = field.field;
					var expr = field.expr;
					rets.push({field: name, expr: macro $expr(state == null ? null : state.$name, action)});
				}
				var ret = {expr: EObjectDecl(rets), pos: e.pos};
				return macro function(state, action) return $ret;
				
			default:
				Context.error('Expected object declaration', e.pos);
				return macro null;
		}
	}
}