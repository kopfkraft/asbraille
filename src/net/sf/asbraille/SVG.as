/**
 * Created by IntelliJ IDEA.
 * User: hannes
 * Date: 22.09.11
 * Time: 11:34
 * To change this template use File | Settings | File Templates.
 */
package net.sf.asbraille
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class SVG
    {
        public static function writeSVG(paragraph:Paragraph, file:File):void
        {
            var svg:XML = renderSVG(paragraph);
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.WRITE);
            stream.writeUTFBytes('<?xml version="1.0" encoding="utf-8"?>\n');
            stream.writeUTFBytes('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n');
            stream.writeUTFBytes(svg.toXMLString());

            stream.close();
        }


        public static function renderSVG(paragraph:Paragraph):XML
        {
            var svg:XML = <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
            x="0px" y="0px" width="0px" height="0px" />;

            var element:XML;
            var letter:Letter;
            var dotSize:Number = paragraph.dotSize;
            var padding:Number = paragraph.dotPadding;
            var cellSize:Number = dotSize + padding * 2;
            var radius:Number = dotSize / 2;
            var yFeed:Number = paragraph.lineGap + dotSize * 3 + padding * 6;
            var xFeed:Number = 2 * cellSize + paragraph.letterGap;
            var dcolor:String = toColorString(paragraph.dotColor);
            var x:Number = 0, maxX:Number = 0;
            var y:Number = 0;
            var item:int, l:int;

            paragraph.reset();

            while (paragraph.hasNext())
            {
                letter = paragraph.next();

                if (letter === Alphabet.NL)
                {
                    x = 0;
                    y += yFeed;
                    continue;
                }

                l = letter.length;

                while (l)
                {
                    item = letter.getItem(--l);
                    element = <circle fill="#000000" cx="0" cy="0" r="0"/>;
                    element.@fill = dcolor;
                    element.@cx = int(item % 2) * cellSize + radius + x + padding;
                    element.@cy = int(item / 2) * cellSize + radius + y + padding;
                    element.@r = radius;

                    svg.appendChild(element);
                }

                x += xFeed;
                maxX = x > maxX ? x : maxX;
            }

            svg.@width = (maxX - paragraph.letterGap) + "px";
            svg.@height = (y + yFeed - paragraph.lineGap) + "px";

            return svg;
        }

        public static function toColorString(value:uint, prefix:String = "#"):String
        {
            var hex:String = value.toString(16);
            var d:int = 6 - hex.length;
            while (d--)
                hex = "0" + hex;

            return prefix + hex;
        }
    }
}
