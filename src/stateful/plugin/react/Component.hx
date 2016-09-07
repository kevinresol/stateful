package stateful.plugin.react;

import react.ReactMacro.*;
import react.ReactComponent;
import stateful.Manager;

using tink.CoreApi;

@:autoBuild(stateful.plugin.react.Macro.build())
class Component<ReactProps, PresentationProps, StatefulState, StatefulAction, StatefulManager:Manager<StatefulState, StatefulAction>> 
	extends ReactComponentOf<ReactProps, Dynamic, Dynamic, {manager:StatefulManager}> {
	
	var Presentation:Class<ReactComponentOfProps<PresentationProps>>;
	var presentation:ReactComponentOfProps<PresentationProps>;
	var dispatch:Dispatcher<StatefulAction>;
	var _handler:CallbackLink;
	
	function new(props, presentation) {
		super(props);
		Presentation = presentation; 
	}
	
	override function render() {
		if(Presentation != null)
			return jsx('<Presentation {...mapStateToProps(context.manager.state)} ref={function(r) presentation = r}/>');
		else
			return jsx('<p>Error: Please specify a Presenation class or override the render method ({Type.getClassName(Type.getClass(this))})</p>');
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