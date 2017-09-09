/**
 * Created by IntelliJ IDEA.
 * User: hannes
 * Date: 23.09.11
 * Time: 17:16
 * To change this template use File | Settings | File Templates.
 */
package net.sf.asbraille
{
    public class Paragraph
    {
        public var dotColor:uint;
        public var dotAlpha:Number;
        public var dotSize:Number;
        public var dotPadding:Number;
        public var letterGap:Number;
        public var lineGap:Number;

        protected var _letters:Vector.<Letter>;
        protected var _cursor:int;

        public function Paragraph(dotSize:Number = 5, dotPadding:Number = 2, letterGap:Number = 5, lineGap:Number = 5, color:uint = 0x000000, alpha:Number = 1)
        {
            this.dotSize = dotSize;
            this.dotPadding = dotPadding;
            this.letterGap = letterGap;
            this.lineGap = lineGap;
            this.dotColor = color;
            this.dotAlpha = alpha;

            _letters = new Vector.<Letter>();
            _cursor = 0;
        }

        public function add(letter:Letter):void
        {
            _letters.push(letter);
        }

        public function addAll(... letters:Array):void
        {
            var letter:Letter;
            for each(letter in letters)
                add(letter);
        }

        public function hasNext():Boolean
        {
            return _cursor < _letters.length;
        }

        public function next():Letter
        {
            return _letters[_cursor++];
        }

        public function reset():void
        {
            _cursor = 0;
        }
    }
}
