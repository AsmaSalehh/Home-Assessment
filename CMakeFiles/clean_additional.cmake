# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appAnalogClock_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appAnalogClock_autogen.dir\\ParseCache.txt"
  "appAnalogClock_autogen"
  )
endif()
