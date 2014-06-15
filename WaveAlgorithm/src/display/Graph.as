package display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import vo.MatrixMetrics;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Graph extends Sprite 
	{
		public static const EDGE_THICKNESS:int = 4;
		public static const EDGE_COLOR:uint = 0x57bf9f;
		static public const GRAPH_BUILT:String = "graphBuilt";
		
		private var vertexes:Vector.<Vertex> = new Vector.<Vertex>();
		
		public var matrix:Vector.<Vector.<Number>>;
		public var size:MatrixMetrics;
		public var built:Boolean = false;
		
		public function Graph(matrix:Vector.<Vector.<Number>>)
		{
			this.matrix = matrix;
			drawFromData();
		}
		
		private function drawFromData():void 
		{
			size = new MatrixMetrics();
			size.row = matrix.length;
			for (var i:int = 0; i < size.row; i++ )
			{
				var row:Vector.<Number> = matrix[i];
				size.column = row.length;
				
				for (var j:int = 0; j < size.column; j++)
				{
					var cell:Number = row[j];
					var vertex:Vertex = new Vertex();
					vertex.value = cell;
					vertex.position = new MatrixMetrics(i, j);
					vertex.x = Vertex.LINE_THICKNESS + Vertex.CIRCLE_RADIUS + (Vertex.CIRCLE_RADIUS * 3 * j);
					vertex.y = Vertex.LINE_THICKNESS + Vertex.CIRCLE_RADIUS + (Vertex.CIRCLE_RADIUS * 3 * i);
					addChild(vertex);
					vertexes.push(vertex);
				}
			}
			
			drawEdges();
		}
		
		private function drawEdges():void 
		{
			this.graphics.clear();
			this.graphics.lineStyle(EDGE_THICKNESS, EDGE_COLOR, 1, false, "normal", "none");
			
			for (var i:int = 0; i < vertexes.length; i++ )
			{
				var vertex:Vertex = vertexes[i];
				
				if (vertex.position.column < size.column - 1)
				{ 
					this.graphics.moveTo(vertex.x + Vertex.CIRCLE_RADIUS, vertex.y);
					this.graphics.lineTo(vertex.x + Vertex.CIRCLE_RADIUS * 2, vertex.y);
				}
				
				if (vertex.position.row < size.row - 1)
				{
					this.graphics.moveTo(vertex.x, vertex.y + Vertex.CIRCLE_RADIUS);
					this.graphics.lineTo(vertex.x, vertex.y + Vertex.CIRCLE_RADIUS * 2);
				}
				
			}
			
			this.graphics.endFill();
			built = true;
			dispatchEvent(new Event(Graph.GRAPH_BUILT));
		}
		
	}

}