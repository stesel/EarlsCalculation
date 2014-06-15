package display 
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import vo.MatrixMetrics;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Vertex extends Sprite 
	{
		public static const CIRCLE_RADIUS:int = 20;
		public static const LINE_THICKNESS:int = 2;
		public static const LINE_COLOR:uint = 0x57bf9f;
		
		public var position:MatrixMetrics;
		
		private var _value:Number = 0;
		private var text:TextField;
		private var textFormat:TextFormat;
		
		
		public function Vertex() 
		{
			textFormat = new TextFormat("Arial", 20, 0xffff00, true);
			text = new TextField();
			text.autoSize = TextFieldAutoSize.LEFT;
			text.defaultTextFormat = textFormat;
			text.wordWrap = false;
			text.multiline = false;
			text.selectable = false;
			addChild(text);
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(v:Number):void
		{
			if (value != 0 && v == _value)
				return
			
			_value = v;
			
			drawCircle();
			setText();
		}
		
		protected function setText():void 
		{
			text.text = String(_value);
			text.x = - (text.width >> 1);
			text.y = - (text.height >> 1);
		}
		
		protected function drawCircle():void 
		{
			this.graphics.clear();
			this.graphics.lineStyle(LINE_THICKNESS, LINE_COLOR, 1); 
			this.graphics.beginFill(getColorByValue, 0.6);
			this.graphics.drawCircle(0, 0, CIRCLE_RADIUS);
			this.graphics.endFill();
		}
		
		protected function get getColorByValue():uint 
		{
			var colorTranform:ColorTransform = new ColorTransform(1,1,1, 40, 40, 40);
			colorTranform.blueOffset = _value / 20 * 255;
			colorTranform.redOffset = _value / 10 * 255;
			//colorTranform.greenOffset = _value / 20 * 255;
			return colorTranform.color;
		}
		
	}

}