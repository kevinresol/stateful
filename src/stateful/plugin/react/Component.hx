package stateful.plugin.react;

import react.ReactMacro.*;
import react.ReactComponent;
import stateful.Manager;

using tink.CoreApi;

@:autoBuild(stateful.plugin.react.Macro.build())
class Component<ReactProps, PresentationProps, StatefulState, StatefulAction, StatefulManager:Manager<StatefulState, StatefulAction>> 
	extends ReactComponentOf<ReactProps, Dynamic, Dynamic, {manager:StatefulManager}> {
	
	var Presentation:Class<ReactComponentOfProps<PresentationProps>>;
	var dispatch:Dispatcher<StatefulAction>;
	var _handler:CallbackLink;
	
	function new(props, presentation) {
		super(props);
		Presentation = presentation; 
	}
	
	override function render() {
		return jsx('<Presentation {...mapStateToProps(context.manager.state)}/>');
	}
	
	override function componentWillMount() {
		dispatch = context.manager.dispatch;
	}
	
	override function componentDidMount() {
		_handler = context.manager.changed.handle(handleState);
	}
	
	override function componentWillUnmount() {
		_handler.dissolve();
	}
	
	function mapStateToProps(state:StatefulState):PresentationProps {
		return null;
	}
	
	function handleState(state:StatefulState) {
		forceUpdate();
	}
	
}