using System;

namespace Demo
{
    // error - classes must be sealed -- good example of future CodeFix 
    public class Coord
    {
        public long X;
        public long Y;

        public Coord()
        {
            X = 0L;
            Y = 0L;
        }

        public Coord(long x, long y)
        {
            X = x;
            Y = y;
        }

        // error - multiple constructors of arity 2
        public Coord(int x, int y)
        {
            X = x;
            Y = y;
        }

        // error - operator overloading not allowed in Windows Runtime
        public static Coord operator ++(Coord xypair)
        {
            ++xypair.X;
            ++xypair.Y;
            return xypair;
        }


        public double Distance(Coord target)
        {
            double deltaX = X - target.X;
            double deltaY = Y - target.Y;
            return Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
        }

        public override string ToString()
        {
            return "(" + X + "," + Y + ")";
        }
    }
}
