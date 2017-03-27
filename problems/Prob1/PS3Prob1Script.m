(* ::Package:: *)

BeginPackage["PS3Prob1Script`"]

CurrentDir = DirectoryName[FileNameJoin[{Directory[], $ScriptCommandLine[[1]]}]]
outFile = OpenWrite[FileNameJoin[{CurrentDir, "prob1ScriptOutput.txt"}]]


Print["Solving equation for Problem 1"]

sols = NSolve[ x == 5(1 - E^(-x)), x]

Print[StringTemplate["Found solutions: `1`"][x /. sols]]
Write[outFile, StringTemplate["Solutions: `1`"][x /. sols]]

EndPackage[]
