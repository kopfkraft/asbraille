package net.sf.asbraille
{


    /*
     Braille setup of a display dot matrix like

     | 0 | 1 |
     | 2 | 3 |
     | 4 | 5 |

     only active dots are handled by the marks Vector
     */
    public class Letter
    {
        protected var marks:Vector.<int>;

        /*
         active braille "marks" as vector ... like 0,3,4,5 for z
         */
        public function Letter(marks:Vector.<int>)
        {
            this.marks = marks;
        }

        public function get length():int
        {
            return marks.length;
        }

        public function getItem(index:int):int
        {
            return marks[index];
        }
    }
}