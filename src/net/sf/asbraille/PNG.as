/**
 * Created by IntelliJ IDEA.
 * User: hannes
 * Date: 22.09.11
 * Time: 11:35
 * To change this template use File | Settings | File Templates.
 */
package net.sf.asbraille
{
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    import mx.graphics.codec.PNGEncoder;

    public class PNG
    {
        public static function writePNG(paragraph:Paragraph, file:File):void
        {
            var sprite:Sprite = renderSprite(paragraph);
            var bmp:BitmapData = new BitmapData(sprite.width + paragraph.dotPadding * 2, sprite.height + paragraph.dotPadding * 2);
            bmp.draw(sprite);

            var encoder:PNGEncoder = new PNGEncoder();
            var byteArray:ByteArray = encoder.encode(bmp);

            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.WRITE);
            stream.writeBytes(byteArray);

            stream.close();
        }

        public static function renderSprite(paragraph:Paragraph):Sprite
        {
            var sprite:Sprite = new Sprite();
            var gfx:Graphics = sprite.graphics;
            var letter:Letter;
            var dotSize:Number = paragraph.dotSize;
            var padding:Number = paragraph.dotPadding;
            var cellSize:Number = dotSize + padding * 2;
            var radius:Number = dotSize / 2;
            var yFeed:Number = paragraph.lineGap + dotSize * 3 + padding * 6;
            var xFeed:Number = 2 * cellSize + paragraph.letterGap;
            var x:Number = 0;
            var y:Number = 0;
            var item:int, l:int;

            paragraph.reset();
            gfx.beginFill(paragraph.dotColor, paragraph.dotAlpha);

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
                    gfx.drawCircle(
                            int(item % 2) * cellSize + radius + x + padding,
                            int(item / 2) * cellSize + radius + y + padding,
                            radius
                    );
                }

                x += xFeed;
            }

            gfx.endFill();

            return sprite;
        }
    }
}
