add_library(a-multi-reactor-threaded-coroutine-framework_options INTERFACE)

target_compile_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
# GCC/Clang 通用选项
$<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
-Wall
-Wextra
-fno-strict-aliasing
)

target_compile_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
        -fPIC
    >
)

target_link_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
        -rdynamic           # 栈回溯需要
    >
)

target_compile_definitions(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
    $<$<CONFIG:Debug>:A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_DEBUG>
)

target_compile_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
    $<$<CONFIG:Debug>:-O0>
    $<$<CONFIG:Debug>:-g3>
    $<$<CONFIG:Debug>:-ggdb>
)

# ===== Release/RelWithDebInfo 共用选项 =====
target_compile_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
    $<$<CONFIG:Release>:-DNDEBUG>
    $<$<CONFIG:Release>:-O2>
    $<$<CONFIG:Release>:-fno-omit-frame-pointer>

    $<$<CONFIG:RelWithDebInfo>:-DNDEBUG>
    $<$<CONFIG:RelWithDebInfo>:-O2>
    $<$<CONFIG:RelWithDebInfo>:-g>
    $<$<CONFIG:RelWithDebInfo>:-fno-omit-frame-pointer>
)

option(A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_BUILD_TESTS "Build tests" OFF)
option(A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_BUILD_TOOLS "Build tools" OFF)
option(A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_ENABLE_COVERAGE "Enable code coverage instrumentation" OFF)
if(A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_ENABLE_COVERAGE)
    target_compile_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
        $<$<CONFIG:Debug>:--coverage>
    )
    target_link_options(a-multi-reactor-threaded-coroutine-framework_options INTERFACE
        $<$<CONFIG:Debug>:--coverage>
    )
endif()
