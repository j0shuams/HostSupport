#include "pch.h"

using namespace winrt;
using namespace Windows::Foundation;
using namespace Coords;

int main()
{
    init_apartment();
    printf("Starting up!\n");
    Coord a = Coord();
    Coord b = Coord(39.0, 80.0);
    printf("We expect the distance between %ls and %ls to be 89.0\n", a.ToString().c_str(), b.ToString().c_str());
    printf("Calculated distance: %f", a.Distance(b));
}
