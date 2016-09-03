package stateful.plugin.react;

import react.ReactComponent;
import stateful.Manager;

using tink.CoreApi;

@:autoBuild(stateful.plugin.react.Macro.build())
class Component<ReactProps, ReactState, StatefulState, StatefulAction, StatefulManager:Manager<StatefulState, StatefulAction>> 
	extends ReactComponentOf<ReactProps, ReactState, Dynamic, {manager:StatefulManager}> {
	
	var dispatch:Dispatcher<StatefulAction>;
	var _handler:CallbackLink;
	
	override function componentWillMount() {
		dispatch = context.manager.dispatch;
		handleState(context.manager.state);
	}
	
	override function componentDidMount() {
		_handler = context.manager.changed.handle(handleState);
	}
	
	override function componentWillUnmount() {
		_handler.dissolve();
	}
	
	function mapState(state:StatefulState):ReactState {
		return null;
	}
	
	function handleState(state:StatefulState) {
		switch mapState(state) {
			case null:
			case v: setState(v);
		}
	}
}