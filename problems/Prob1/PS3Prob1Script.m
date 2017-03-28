(* ::Package:: *)

BeginPackage["PS3Prob1Script`"]

CurrentDir = DirectoryName[FileNameJoin[{Directory[], $ScriptCommandLine[[1]]}]]
ImageDir = FileNameJoin[{CurrentDir, "images"}]
outFile = OpenWrite[FileNameJoin[{CurrentDir, "prob1ScriptOutput.txt"}]]

Print["All the stuff for problem 1"]

(* Part b *)
sols = NSolve[ x == 5(1 - E^(-x)), x]

Print[StringTemplate["Got solutions: `1`"][x /. sols]]
WriteString[outFile, StringTemplate["Got solutions for part b: `1`\n"][x /. sols]]

(* Part c *)
T[\[Lambda]_] := UnitSimplify[(2 * Pi * Quantity[1, "ReducedPlanckConstant"] * Quantity[1, "SpeedOfLight"]) / (4.966 * Quantity[1, "BoltzmannConstant"] * \[Lambda])]
Print[StringTemplate["Temperature: `1`"][T[ Quantity[480, "Nanometers"]]]]
WriteString[outFile, StringTemplate["Solar temperature for 480 nm: `1`\n"][T[ Quantity[480, "Nanometers"]]]]

(* Part d *)

rho[\[Lambda]_, T_] := (16 * Pi^2 * Quantity[1, "ReducedPlanckConstant"] * Quantity[1, "SpeedOfLight"]) / (\[Lambda]^5 (E^((2 * Pi * Quantity[1, "ReducedPlanckConstant"] * Quantity[1, "SpeedOfLight"])/( Quantity[1, "BoltzmannConstant"] * T * \[Lambda])) - 1))

Print["Plotting spectra..."]
Export[FileNameJoin[{ImageDir, "4000And6000Spectrum.jpg"}], 
	Show[
		Plot[rho[Quantity[l, "Nanometers"], Quantity[4000, "Kelvins"]], {l, 1, 1000},  AxesLabel->{\[Lambda], \[Rho]}, PlotLabels->"4000 K"],
		Plot[rho[Quantity[l, "Nanometers"], Quantity[5000, "Kelvins"]], {l, 1, 1000},  AxesLabel->{\[Lambda], \[Rho]}, PlotLabels->"5000 K"],
		Plot[rho[Quantity[l, "Nanometers"], Quantity[6000, "Kelvins"]], {l, 1, 1000},  AxesLabel->{\[Lambda], \[Rho]}, PlotLabels->"6000 K"],
		PlotRange->All, PlotLabels->Automatic
	],
	 ImageResolution -> 1000
]


EndPackage[]
