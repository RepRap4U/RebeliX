RebeliX
=======
RebeliX – 3D tiskárna inspirovaná konstrukcemi Rebel II a Průša i3. Tiskárna je šířena pod licencí GPLv3. Návod a seznam materiálu na stavbu naleznete na stránkách www.RepRap4U.cz v sekci návody.

![Model render](Rebelix_render.png "Preview of assembled printer" )

Kompilace
======

Důležitým předpokladem je možnost spustit program openscad z příkazové řádky příkazem <code>openscad</code>.

1. Upravte si soubor calibration dle parametrů své tiskárny a nakoupených dílů. 
* Vygenerujte kalibrační objekt pomocí příkazu <code>make calibration</code>.
* Změňte parametry podle vytištěného souboru calibration.stl.

Následně stačí v hlavní složce přeložit nové součástky pomocí <code>make clean && make all</code>.
