file(GLOB_RECURSE A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_SOURCES CONFIGURE_DEPENDS *.cpp *.cc *.c)
file(GLOB_RECURSE A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_HEADERS CONFIGURE_DEPENDS *.h *.hpp)

add_library(a-multi-reactor-threaded-coroutine-framework STATIC
    ${A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_SOURCES}
    ${A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_HEADERS})

target_include_directories(a-multi-reactor-threaded-coroutine-framework
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(a-multi-reactor-threaded-coroutine-framework PUBLIC a-multi-reactor-threaded-coroutine-framework_options) # 继承所有编译/链接选项

target_compile_options(a-multi-reactor-threaded-coroutine-framework PRIVATE
    # 主库可能需要更严格的警告
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
        -Werror             # 将警告视为错误（主库严格要求）
    >
)


install(TARGETS a-multi-reactor-threaded-coroutine-framework
    EXPORT a-multi-reactor-threaded-coroutine-frameworkTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES ${A_MULTI_REACTOR_THREADED_COROUTINE_FRAMEWORK_HEADERS}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/a-multi-reactor-threaded-coroutine-framework
)

