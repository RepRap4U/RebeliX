RebeliX
=======
RebeliX – a 3D printer inspired by constructions of Rebel II a Prusa i3. Licensed as GPLv3. Howto and list of materials is available on www.RebeliX.cz (currently only in Czech, we are working on it, help is appreciated).

![RebeliX](Rebelix_render.png "Preview of assembled printer" )

Build
=====

To continue OpenSCAD has to be installed and available as `openscad` command.

1. Make necessary changes to configuration.scad according to printer that prints the parts and available hardware. 
* Generate a calibration object by `make calibration`.
* Print generated calibration.stl and repeat the steps if unhappy.

When satisfied, run `make clean && make all`. That produces STLs with your tweeks.

Note about the language
=======================

Originally, almost everything in this repository was in Czech, in order to spread awareness of RebeliX abroad, we've translated stuff to English. However, part of git history is in Czech, as we don't want to rebase the whole repository. Sorry for that.
