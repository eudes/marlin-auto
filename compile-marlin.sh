#!/bin/bash
set -e

export PATH=$PATH:/home/eudes/.platformio/penv/bin

PROJECT_ROOT="/home/eudes/personal/3dprinting/marlin"
CONFIG_DIR="$PROJECT_ROOT/marlin-configurations/config/custom/EudesEnderV2"
MARLIN_ROOT="$PROJECT_ROOT/marlin"

pushd "$MARLIN_ROOT"

cp "$CONFIG_DIR"/_Bootscreen.h ./Marlin/
cp "$CONFIG_DIR"/_Statusscreen.h ./Marlin/
cp "$CONFIG_DIR"/Configuration.h ./Marlin/
cp "$CONFIG_DIR"/Configuration_adv.h ./Marlin/
cp "$CONFIG_DIR"/platformio.ini ./
rm .pio/build/STM32F103RET6_creality/firmware-*.bin || echo 'nothing to delete'

platformio run

rm Marlin/_Bootscreen.h
rm Marlin/_Statusscreen.h
git checkout -- Marlin/Configuration.h
git checkout -- Marlin/Configuration_adv.h
git checkout -- platformio.ini

popd

set +e
mkdir oldfirm 2> /dev/null
mv ./firmware-*.bin oldfirm/

set -e

cp "$MARLIN_ROOT"/.pio/build/STM32F103RE_creality/firmware-*.bin ./
