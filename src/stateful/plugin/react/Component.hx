package stateful.plugin.react;

import react.ReactMacro.*;
import react.ReactComponent;
import stateful.Manager;

using tink.CoreApi;

@:autoBuild(stateful.plugin.react.Macro.build())
class Component<ReactProps, PresentationProps, StatefulState, StatefulAction, StatefulManager:Manager<StatefulState, StatefulAction>> 
	extends ReactComponentOf<ReactProps, {state:StatefulState}, Dynamic, {manager:StatefulManager}> {
	
	var Presentation:Class<ReactComponentOfProps<PresentationProps>>;
	var presentation:ReactComponentOfProps<PresentationProps>;
	var dispatch:Dispatcher<StatefulAction>;
	var _handler:CallbackLink;
	
	function new(props, presentation) {
		super(props);
		Presentation = presentation; 
		state = {
			state: null,
		}
	}
	
	override function render() {
		if(Presentation == null)
			return jsx('<p>Error: Please specify a Presenation class or override the render method ({Type.getClassName(Type.getClass(this))})</p>');
		else if(state.state == null)
			return jsx('<p>Error: State not ready</p>');
		else
			return jsx('<Presentation {...mapStateToProps(state.state)} ref={function(r) presentation = r}/>');
	}
	
	override function componentWillMount() {
		dispatch = context.manager.dispatch;
	}
	
	override function componentDidMount() {
		handleState(context.manager.state);
		_handler = context.manager.changed.handle(handleState);
	}
	
	override function componentWillUnmount() {
		_handler.dissolve();
	}
	
	function mapStateToProps(state:StatefulState):PresentationProps {
		return null;
	}
	
	function handleState(state:StatefulState) {
		if(this.state.state == state) return;
		setState({state: state}); // TODO: optimize it
	}
	
}