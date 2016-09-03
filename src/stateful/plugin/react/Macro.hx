package stateful.plugin.react;

import haxe.macro.Context;

class Macro {
	public static function build() {
		var fields = Context.getBuildFields();
		// add a static variable `contextTypes`, which is required by reactjs for `context` to work
		fields.push({
			name: 'contextTypes',
			kind: FVar(null, macro {manager: react.ReactPropTypes.object}),
			access: [AStatic],
			pos: Context.currentPos(),
		});
		return fields;
	}
}