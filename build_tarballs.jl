# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "MuJoCo"
version = v"2.0.0"

# Collection of sources required to build MuJoCo
sources = [
    "https://www.roboti.us/download/mujoco200_linux.zip" =>
    "ba8560040f6ca47dbd89e4731bc9e06080a99eba4583cda95cdedca802389153",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cp mujoco200_linux/bin/*.so ${prefix}
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libmujoco200", :libmujoco),
    LibraryProduct(prefix, "libglewegl", :libglewegl),
    LibraryProduct(prefix, "libglewosmesa", :libglewosmesa),
    LibraryProduct(prefix, "libmujoco200nogl", :libmujoconogl),
    LibraryProduct(prefix, "libglew", :libglew)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

