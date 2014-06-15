package vo 
{
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class MatrixMetrics
	{
		public var row:Number;
		public var column:Number;
		
		public function MatrixMetrics(row:Number = 0, column:Number = 0) 
		{
			this.row = row;
			this.column = column;
		}
		
		public function toString():String 
		{
			return "row = " + row + ", column = " + column;
		}
		
	}

}