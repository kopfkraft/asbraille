package net.sf.asbraille
{
    public class Alphabet
    {
        /*
         Braille setup of a display dot matrix like

         | 0 | 1 |
         | 2 | 3 |
         | 4 | 5 |

         only active dots are handled by the marks Vector
         */
        public static const A:Letter = new Letter(new <int>[0]);
        public static const B:Letter = new Letter(new <int>[0, 2]);
        public static const C:Letter = new Letter(new <int>[0, 1]);
        public static const D:Letter = new Letter(new <int>[0, 1, 3]);
        public static const E:Letter = new Letter(new <int>[0, 3]);
        public static const F:Letter = new Letter(new <int>[0, 1, 2]);
        public static const G:Letter = new Letter(new <int>[0, 1, 2, 3]);
        public static const H:Letter = new Letter(new <int>[0, 2, 3]);
        public static const I:Letter = new Letter(new <int>[1, 2]);
        public static const J:Letter = new Letter(new <int>[1, 2, 3]);
        public static const K:Letter = new Letter(new <int>[0, 4]);
        public static const L:Letter = new Letter(new <int>[0, 2, 4]);
        public static const M:Letter = new Letter(new <int>[0, 1, 4]);
        public static const N:Letter = new Letter(new <int>[0, 1, 3, 4]);
        public static const O:Letter = new Letter(new <int>[0, 3, 4]);
        public static const P:Letter = new Letter(new <int>[0, 1, 2, 4]);
        public static const Q:Letter = new Letter(new <int>[0, 1, 2, 3, 4]);
        public static const R:Letter = new Letter(new <int>[0, 2, 3, 4]);
        public static const S:Letter = new Letter(new <int>[1, 2, 4]);
        public static const T:Letter = new Letter(new <int>[1, 2, 3, 4]);
        public static const U:Letter = new Letter(new <int>[0, 4, 5]);
        public static const V:Letter = new Letter(new <int>[0, 2, 4, 5]);
        public static const W:Letter = new Letter(new <int>[1, 2, 3, 5]);
        public static const X:Letter = new Letter(new <int>[0, 1, 4, 5]);
        public static const Y:Letter = new Letter(new <int>[0, 1, 3, 4, 5]);
        public static const Z:Letter = new Letter(new <int>[0, 3, 4, 5]);

        // Further characters
        //TODO implement special characters
        public static const CL:Letter = new Letter(new <int>[5]);
        public static const NB:Letter = new Letter(new <int>[1, 3, 4, 5]);
        public static const AP:Letter = new Letter(new <int>[4]);

        public static const FS:Letter = new Letter(new <int>[2, 3, 5]);
        public static const CO:Letter = new Letter(new <int>[2]);
        public static const SC:Letter = new Letter(new <int>[2, 4]);
        public static const EP:Letter = new Letter(new <int>[2, 3, 4]);
        public static const QM:Letter = new Letter(new <int>[2, 4, 5]);
        public static const BT:Letter = new Letter(new <int>[2, 3, 4, 5]);
        public static const HP:Letter = new Letter(new <int>[4, 5]);
        public static const SP:Letter = new Letter(new <int>[]);

        // newline
        public static const NL:Letter = new Letter(null);


        // possibility to implement own char and letter maps ... maybe not necessary
        protected static var letterMap:Object =
        {
            "a": A, "b": B, "c": C, "d": D, "e": E, "f": F, "g": G, "h": H, "i": I,
            "j": J, "k": K, "l": L, "m": M, "n": N, "o": O, "p": P, "q": Q, "r": R,
            "s": S, "t": T, "u": U, "v": V, "w": W, "x": X, "y": Y, "z": Z,
            "1": A, "2": B, "3": C, "4": D, "5": E, "6": F, "7": G, "8": H, "9": I, "0": J,
            ".": FS, ",": CO, ";": SC, "!": EP, "?": QM, "(": BT, ")": BT, "-": HP, "'": AP,
            " ": SP, "\n": NL
        };

        public static function encode(text:String):Paragraph
        {
            return encodeGradeOne(text);
        }

        public static function encodeGradeOne(text:String):Paragraph
        {
            var paragraph:Paragraph = new Paragraph();
            var i:int, c:String, l:int = text.length;

            for (i = 0; i < l; i++)
            {
                c = text.charAt(i).toLowerCase();

                if (c in letterMap)
                {
                    //TODO implement handling of special chars and rules
                    paragraph.add(letterMap[c]);
                }
            }

            return paragraph;
        }
    }
}