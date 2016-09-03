package stateful.plugin.react;

import react.ReactComponent;
import react.ReactMacro.*;
import react.ReactPropTypes;
import stateful.Manager;


class Provider<M/*:Manager<S, A>*/> extends ReactComponentOfProps<{manager:M}> {
	
	static var childContextTypes = {
		manager: ReactPropTypes.object,
	}
	
	public function new(props) {
		super(props);
	}
	
	override function render() {
		return jsx('
			<div>{props.children}</div>
		');
	}
	
	function getChildContext() {
		return {
			manager: props.manager,
		}
	}
}