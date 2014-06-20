package load 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Leonid Trofymchuk
	 */
	public class DataProvider extends EventDispatcher
	{
		static public const PARSE_COMPLETE:String = "parseComplete";
		
		private const LINE_FEED:String = String.fromCharCode(10);
		private const LINE_NEW:String = "\r";
		private const SPACE:String = String.fromCharCode(32);
		private const COMMA:String = String.fromCharCode(44);
		
		private var loader:DataLoader;
		
		public var matrix:Vector.<Vector.<Number>>;
		
		public function DataProvider() 
		{
			loader = new DataLoader("graph.txt", { name:"graph", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
		}
		
		public function start():void
		{
			loader.load(true);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			if (CONFIG::debug)
				trace.apply(this, ["progress: ", loader.progress]);
		}
		
		private function errorHandler(e:LoaderEvent):void 
		{
			if (CONFIG::debug)
				trace.apply(this, [e.text]);
		}
		
		private function completeHandler(e:LoaderEvent):void 
		{
			if (CONFIG::debug)
				trace.apply(this, ["complete:", "\r", loader.content]);
			parseData(loader.content);
		}
		
		private function parseData(content:String):void 
		{
			var defenition:String = readContent(content);
			if (CONFIG::debug)
				trace.apply(this, ["defenition: ", defenition]);
			parseInVector(defenition);
		}
		
		/**
		 * You can reinterpret your ByteArray as containing only shorts.
		 * This lets you read two bytes at a time and get a single number value representing them both.
		 * Next, you can take these numbers and reinterpret them as being character codes.
		 * Finally, create a String from these character codes and you're done.
		 * @param	content
		 * @return
		 */
		private function readContent(content:String):String 
		{
		   /**
			*Now, as for decoding this String...
			*Get the character code of each character, and place them into a new ByteArray as shorts.
			*It will be identical to the original, except if the original had an odd number of bytes, in which case the decoded ByteArray will have an extra 0 byte at the end.
			*/
		   
			var bytes:ByteArray = new ByteArray();
			for (var i:int = 0; i < content.length; ++i)
			{
				bytes.writeShort(content.charCodeAt(i));
			}
			bytes.position = 0;
			
			/**
			 * There is one special circumstance to pay attention to.
			 * If you try reading a short from a ByteArray when there is only one byte remaining in it, an exception will be thrown.
			 * In this case, you should call readByte with the value shifted 8 bits instead.
			 * This is the same as if the original ByteArray had an extra 0 byte at the end. (making it even in length)
			 */
			
			var origPos:uint = bytes.position;
			var result:Array = new Array();

			for (bytes.position = 0; bytes.position < bytes.length - 1; )
				result.push(bytes.readShort());

			if (bytes.position != bytes.length)
				result.push(bytes.readByte() << 8);

			bytes.position = origPos;
			return String.fromCharCode.apply(null, result);
		}
		
		
		private function parseInVector(defenition:String):void 
		{
			while(defenition.indexOf(SPACE) > -1)
				defenition = defenition.replace(SPACE, "");
			var rows:Array = defenition.split(LINE_FEED);
			
			matrix = new Vector.<Vector.<Number>>();
			
			for (var i:int = 0; i < rows.length; i++)
			{
				var row:Vector.<Number> = new Vector.<Number>();
				var rawString:String = rows[i];
				if (!rawString.length || rawString == LINE_NEW)
					continue;
				var rawRow:Array = rawString.split(COMMA);
				
				for (var j:int = 0; j < rawRow.length; j++)
					row.push(Number(rawRow[j]));
					
				matrix.push(row);
			}
			if (CONFIG::debug)
				trace.apply(this, [matrix.join(",")]);
				
			this.dispatchEvent(new Event(PARSE_COMPLETE));
		}
		
	}

}