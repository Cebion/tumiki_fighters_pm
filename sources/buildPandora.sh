#!/bin/sh

FLAGS="-frelease -fno-section-anchors -c -O2 -Wall -pipe -fversion=PANDORA -fversion=BindSDL_Static -fversion=SDL_201 -fversion=SDL_Mixer_202"

rm import/*.o*
rm import/sdl/*.o*
rm import/bindbc/sdl/*.o*
rm src/abagames/util/*.o*
rm src/abagames/util/bulletml/*.o*
rm src/abagames/util/sdl/*.o*
rm src/abagames/tf/*.o*

cd import
$PNDSDK/bin/pandora-gdc $FLAGS *.d
cd sdl
$PNDSDK/bin/pandora-gdc $FLAGS *.d
cd ../bindbc/sdl
$PNDSDK/bin/pandora-gdc $FLAGS *.d
cd ../../..

cd src/abagames/util
$PNDSDK/bin/pandora-gdc $FLAGS -I../../../import -I../.. *.d
cd ../../..

cd src/abagames/util/bulletml
$PNDSDK/bin/pandora-gdc $FLAGS -I../../../../import -I../../.. *.d
cd ../../../..

cd src/abagames/util/sdl
$PNDSDK/bin/pandora-gdc $FLAGS -I../../../../import -I../../.. *.d
cd ../../../..

cd src/abagames/tf
$PNDSDK/bin/pandora-gdc $FLAGS -I../../../import -I../.. *.d
cd ../../..

$PNDSDK/bin/pandora-gdc -o TUMIKI_Fighters -s -Wl,-rpath-link,$PNDSDK/usr/lib -L$PNDSDK/usr/lib -lGL -lSDL2_mixer -lSDL2 -lbulletml_d -L./lib/arm import/*.o* import/sdl/*.o* import/bindbc/sdl/*.o* src/abagames/util/*.o* src/abagames/util/bulletml/*.o* src/abagames/util/sdl/*.o* src/abagames/tf/*.o*
