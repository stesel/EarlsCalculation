package 
{
	import display.Graph;
	import display.Vertex;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Main extends Sprite 
	{
		private var graph:Graph;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var matrix:Vector.<Vector.<Number>> = Vector.<Vector.<Number>>([Vector.<Number>([3, 5, 4, 4, 7, 1, 7, 5, 5, 9]),
																			Vector.<Number>([2, 6, 7, 2, 5, 6, 4, 7, 2, 2]),
																			Vector.<Number>([2, 6, 7, 4, 7, 3, 2, 6, 7, 4]),
																			Vector.<Number>([2, 6, 1, 6, 7, 3, 1, 4, 7, 9]),
																			Vector.<Number>([2, 6, 2, 2, 7, 3, 3, 4, 5, 1]),
																			Vector.<Number>([2, 6, 7, 6, 7, 3, 2, 5, 5, 3]),
																			Vector.<Number>([2, 6, 7, 6, 9, 0, 6, 7, 4, 6]),
																			Vector.<Number>([2, 6, 7, 3, 1, 3, 2, 4, 0, 3]),
																			Vector.<Number>([2, 6, 7, 3, 1, 3, 2, 1, 4, 5]),
																			Vector.<Number>([1, 8, 9, 7, 9, 1, 4, 5, 2, 0])]);
			
			graph = new Graph(matrix);
			if (graph.built)
				onGraphBuilt();
			else
			graph.addEventListener(Graph.GRAPH_BUILT, onGraphBuilt);
			
		}
		
		private function onGraphBuilt(e:Event = null):void 
		{
			graph.removeEventListener(Graph.GRAPH_BUILT, onGraphBuilt);
			graph.x = (stage.stageWidth - graph.width) >> 1;
			graph.y = (stage.stageHeight - graph.height) >> 1;
			addChild(graph);
		}
		
	}
	
}