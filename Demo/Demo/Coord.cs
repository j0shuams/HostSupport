using System;

namespace Demo
{
    public sealed class Coord
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
