project(fw_currency)
cmake_minimum_required(VERSION 2.8)

find_package(Qt4 COMPONENTS QtCore QtXml REQUIRED)
include (${QT_USE_FILE})


#aux_source_directory(. SRC_LIST)
include_directories(  
 .
)

set (HEADERS
)
set (SOURCES
  src/main.cpp
  src/loader.cpp
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fvisibility=hidden")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -fvisibility=hidden")
SET(CMAKE_CXX_FLAGS "-std=c++11")

set (EXT_LIBS
    curl
    tidy
)


add_executable(${PROJECT_NAME} ${SOURCES} ${SRC_LIST} ${HEADERS})
#add_library(${PROJECT_NAME} SHARED ${SOURCES} ${SRC_LIST} ${HEADERS})
target_link_libraries(${PROJECT_NAME} ${QT_LIBRARIES} ${EXT_LIBS})
