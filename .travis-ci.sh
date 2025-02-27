#!/bin/bash

# This script is triggered from the script section of .travis.yml
# It runs the appropriate commands depending on the task requested.

export QMAKE=/opt/qt514/bin/qmake

if [ "$TASK" = "coverage" ]; then
  gem install coveralls-lcov
fi

# Report the compiler version
$CXX --version

# Report the qmake version
$QMAKE -v

# Otherwise compile and check as normal
if [ "$TASK" = "compile" ]; then
  if [ "$QT" = "qt5" ]; then
    $QMAKE QMAKE_CXX=$CXX QMAKE_CC=$CC QMAKE_LINK=$CXX QMAKE_LINK_SHLIB=$CXX && make && make check
    exit $?
  fi
  if [ "$QT" = "qt5qml" ]; then
    $QMAKE QMAKE_CXX=$CXX QMAKE_CC=$CC QMAKE_LINK=$CXX QMAKE_LINK_SHLIB=$CXX CONFIG+=qmlui && make && make check
    exit $?
  fi
fi
if [ "$TASK" = "coverage" ]; then
  $QMAKE CONFIG+=coverage QMAKE_CXX=$CXX QMAKE_CC=$CC QMAKE_LINK=$CXX QMAKE_LINK_SHLIB=$CXX && make && make lcov
  exit $?
fi
