$fn = 50;

FI = (sqrt(5) + 1) / 2;

dCandle = 50;
tWall = 2;
dScrew = 6;
hScrew = 5;

dCandleExt = dCandle + 2 * tWall;
echo("dCandleExt", dCandleExt);
dVaseHole = dCandleExt * FI;
echo("dVaseHole", dVaseHole);
dSphereExt = dVaseHole * FI / (2 * sqrt(FI - 1));
echo("dSphereExt", dSphereExt);
hVase = dSphereExt / FI;
echo("hVase", hVase);
hCandleStandInt = 1;
hCandleStandExt = tWall + hCandleStandInt;
echo("hCandleStandExt", hCandleStandExt);
hLeg = hVase * FI - hCandleStandExt;
dLegNarrow = tWall * FI * FI;
echo("dLegNarrow", dLegNarrow);

//hyperboloid();

difference()
{
	union()
	{
		translate([0, 0, hLeg])
		candleStand();
		leg();
		vase();
	}
	//Выемка под саморез
	translate([0, 0, hLeg + hCandleStandExt - hCandleStandInt - hScrew])
	cylinder(d = dScrew, h = hScrew + 1);
}


module candleStand()
{
	difference()
	{
		cylinder(d = dCandleExt, h = hCandleStandExt);
		translate([0, 0, tWall])
		cylinder(d = dCandleExt - 2 * tWall, h = hCandleStandExt);
	}
}

module leg()
{
	translate([0, 0, hLeg])
	mirror([0, 0, 1])
	hyperboloid(hLeg, dLegNarrow / 2, dCandleExt / 2);
}

module hyperboloid(h, rNarrow, rWide)
{
	a = h * rNarrow * rWide / (rWide - rNarrow);
	step = (rWide - rNarrow) / $fn;
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