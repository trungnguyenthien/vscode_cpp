# Đặt phiên bản CMake tối thiểu cần thiết.
# Điều này hữu ích để đảm bảo tính năng bạn sử dụng được hỗ trợ.
cmake_minimum_required(VERSION 3.10)

# Đặt tên dự án và ngôn ngữ sử dụng.
project(MyProject VERSION 1.0.0 LANGUAGES CXX)
add_link_options(-static -static-libgcc -static-libstdc++)
file(GLOB_RECURSE SOURCES "src/*.cpp" CONFIGURE_DEPEND)
file(GLOB_RECURSE HEADERS "src/*.h" CONFIGURE_DEPEND)

# Đặt chuẩn C++ được sử dụng.
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(executable_sources
    src/main.cpp
)
# Link to cli11
add_subdirectory(modules/cli11)
foreach(source ${executable_sources})
    # Lấy tên của file mã nguồn mà không có phần mở rộng (.cpp)
    get_filename_component(exec_name ${source} NAME_WE)
    project(${exec_name})
    # Tạo target cho mỗi file mã nguồn
    add_executable(${exec_name} ${source} ${SOURCES} ${HEADERS})
    target_include_directories(${exec_name} PRIVATE modules/cli11/include)
endforeach()
# target_include_directories(${APP_NAME} PRIVATE modules/cli11/include)

install(FILES ${HEADERS} DESTINATION include)