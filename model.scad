$fn = 200;

FI = (sqrt(5) + 1) / 2;

dCandle = 50;
tWall = 2;

dCandleExt = dCandle + 2 * tWall;
echo("dCandleExt", dCandleExt);
dVaseHole = dCandleExt * FI;
echo("dVaseHole", dVaseHole);
dSphereExt = dVaseHole * FI / (2 * sqrt(FI - 1));
echo("dSphereExt", dSphereExt);
hVase = dSphereExt / FI;
echo("hVase", hVase);
hStandInt = 1;
hStandExt = tWall + hStandInt;
echo("hStandExt", hStandExt);
hLeg = hVase * FI - hStandExt;
dLegNarrow = tWall * FI * FI;
echo("dLegNarrow", dLegNarrow);

translate([0, 0, hLeg])
stand();
leg(hLeg, dLegNarrow / 2, dCandleExt / 2);
vase();

module stand()
{
	difference()
	{
		cylinder(d = dCandleExt, h = hStandExt);
		translate([0, 0, tWall])
		cylinder(d = dCandleExt - 2 * tWall, h = hStandExt);
	}
}

module leg(h, rNarrow, rWide)
{
	a = h * rNarrow * rWide / (rWide - rNarrow);
	step = (rWide - rNarrow) / $fn;
	translate([0, 0, h])
	mirror([0, 0, 1])
	rotate_extrude()
	translate([0, -a / rWide])
	polygon([[0, a / rWide], [0, a / rNarrow], for (x = [rNarrow : step : rWide])[x, a / x]]);
}

module vase()
{
	difference()
	{
		difference()
		{
			translate([0, 0, dSphereExt / 2])
			sphere(d = dSphereExt);
			//cylinder(d = dSphereExt, h = hVase);
			translate([0, 0, dSphereExt / 2])
			sphere(d = dSphereExt - 2 * tWall);
		}
		translate([-dSphereExt / 2, -dSphereExt / 2, hVase])
		cube([dSphereExt, dSphereExt, dSphereExt]);
	}
}