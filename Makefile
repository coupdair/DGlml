#
#  File        : Makefile
#                ( Makefile for GNU 'make' utility )
#
#  Description : Makefile for compiling CImg-based code on Unix.
#                This file is a part of the CImg Library project.
#                ( http://cimg.sourceforge.net )
#
#  Copyright   : David Tschumperle
#                ( http://www.greyc.ensicaen.fr/~dtschump/ )
#
#  License     : CeCILL v2.0
#                ( http://www.cecill.info/licences/Licence_CeCILL_V2-en.html )
#
#  This software is governed by the CeCILL  license under French law and
#  abiding by the rules of distribution of free software.  You can  use,
#  modify and/ or redistribute the software under the terms of the CeCILL
#  license as circulated by CEA, CNRS and INRIA at the following URL
#  "http://www.cecill.info".
#
#  As a counterpart to the access to the source code and  rights to copy,
#  modify and redistribute granted by the license, users are provided only
#  with a limited warranty  and the software's author,  the holder of the
#  economic rights,  and the successive licensors  have only  limited
#  liability.
#
#  In this respect, the user's attention is drawn to the risks associated
#  with loading,  using,  modifying and/or developing or reproducing the
#  software by the user in light of its specific status of free software,
#  that may mean  that it is complicated to manipulate,  and  that  also
#  therefore means  that it is reserved for developers  and  experienced
#  professionals having in-depth computer knowledge. Users are therefore
#  encouraged to load and test the software's suitability as regards their
#  requirements in conditions enabling the security of their systems and/or
#  data to be ensured and,  more generally, to use and operate it in the
#  same conditions as regards security.
#
#  The fact that you are presently reading this means that you have had
#  knowledge of the CeCILL license and that you accept its terms.
#

#-------------------------------------------------------
# Define the list of files to be compiled
# (name of the source files without the .cpp extension)
#-------------------------------------------------------
CIMG_FILES = DGlml
version = v0.0.1
PG_format_version = `cat ../PGlml/PG_FORMAT_VERSION`

#---------------------------------
# Set correct variables and paths
#---------------------------------
CIMG_VERSION = 1.30
X11PATH      = /usr/X11R6
CC           = g++
CCVER        = `$(CC) -v 2>&1 | tail -n 1`
EXEPFX       =

ifeq ($(CC),icc)
CFLAGS       = -I.. -ansi -DVERSION=\"$(version)\" -DPG_FORMAT_VERSION=\"$(PG_format_version)\"
LDFLAGS      =
else
CFLAGS       = -I.. -Wall -W -ansi -pedantic -DVERSION=\"$(version)\" -DPG_FORMAT_VERSION=\"$(PG_format_version)\"
LDFLAGS      = -lm
endif

#--------------------------------------------------
# Set compilation flags allowing to customize CImg
#--------------------------------------------------

# Flags to enable code debugging.
CIMG_DEBUG_CFLAGS = -Dcimg_debug=3 -g

# Flags to enable color output messages.
# (requires a VT100 compatible terminal)
CIMG_VT100_CFLAGS = -Dcimg_use_vt100

# Flags to enable code optimization by the compiler.
ifeq ($(CC),icc)
CIMG_OPT_CFLAGS = -O3 -ipo -no-prec-div
else
CIMG_OPT_CFLAGS = -O3 -ffast-math -fno-tree-pre
endif

# Flags to enable OpenMP support.
ifeq ($(CC),icc)
CIMG_OPENMP_CFLAGS = -Dcimg_use_openmp -openmp -i-static
else
CIMG_OPENMP_CFLAGS = -Dcimg_use_openmp -fopenmp
endif

# Flags used to disable display capablities of CImg
CIMG_NODISPLAY_CFLAGS = -Dcimg_display=0

# Flags to enable the use of the X11 library.
# (X11 is used by CImg to handle display windows)
# !!! For 64bits systems : replace -L$(X11PATH)/lib by -L$(X11PATH)/lib64 !!!
CIMG_X11_CFLAGS = -I$(X11PATH)/include
CIMG_X11_LDFLAGS = -L$(X11PATH)/lib -lpthread -lX11

# Flags to enable GDI32 display (Windows native).
CIMG_GDI32_CFLAGS = -mwindows
CIMG_GDI32_LDFLAGS = -lgdi32

# Flags to enable Carbon-based display (MacOSX native).
CIMG_CARBON_CFLAGS = -Dcimg_display=3 -framework Carbon

# Flags to enable fast image display, using the XSHM library (when using X11).
CIMG_XSHM_CFLAGS = -Dcimg_use_xshm
CIMG_XSHM_LDFLAGS = -lXext

# Flags to enable screen mode switching, using the XRandr library (when using X11).
# ( http://www.x.org/wiki/Projects/XRandR )
CIMG_XRANDR_CFLAGS = -Dcimg_use_xrandr
CIMG_XRANDR_LDFLAGS = -lXrandr

# Flags to enable native support for PNG image files, using the PNG library.
# ( http://www.libpng.org/ )
CIMG_PNG_CFLAGS = -Dcimg_use_png
CIMG_PNG_LDFLAGS = -lpng -lz

# Flags to enable native support for JPEG image files, using the JPEG library.
# ( http://www.ijg.org/ )
CIMG_JPEG_CFLAGS = -Dcimg_use_jpeg
CIMG_JPEG_LDFLAGS = -ljpeg

# Flags to enable native support for TIFF image files, using the TIFF library.
# ( http://www.libtiff.org/ )
CIMG_TIFF_CFLAGS = -Dcimg_use_tiff
CIMG_TIFF_LDFLAGS = -ltiff

# Flags to enable native support for various video files, using the FFMPEG library.
# ( http://www.ffmpeg.org/ )
CIMG_FFMPEG_CFLAGS = -Dcimg_use_ffmpeg -I/usr/include/ffmpeg
CIMG_FFMPEG_LDFLAGS = -lavcodec -lavformat

# Flags to enable native support for compressed .cimgz files, using the Zlib library.
# ( http://www.zlib.net/ )
CIMG_ZLIB_CFLAGS = -Dcimg_use_zlib
CIMG_ZLIB_LDFLAGS = -lz

# Flags to enable native support of most classical image file formats, using the Magick++ library.
# ( http://www.imagemagick.org/Magick++/ )
CIMG_MAGICK_CFLAGS = -Dcimg_use_magick `Magick++-config --cppflags` `Magick++-config --cxxflags`
CIMG_MAGICK_LDFLAGS = `Magick++-config --ldflags` `Magick++-config --libs`

# Flags to enable faster Discrete Fourier Transform computation, using the FFTW3 library
# ( http://www.fftw.org/ )
CIMG_FFTW3_CFLAGS = -Dcimg_use_fftw3
ifeq ($(MSYSTEM),MINGW32)
CIMG_FFTW3_LDFLAGS = -lfftw3-3
else
CIMG_FFTW3_LDFLAGS = -lfftw3
endif

# Flags to enable the use of LAPACK routines for matrix computation
# ( http://www.netlib.org/lapack/ )
CIMG_LAPACK_CFLAGS = -Dcimg_use_lapack
CIMG_LAPACK_LDFLAGS = -lblas -lg2c -llapack

# Flags to enable the use of the Board library
# ( http://libboard.sourceforge.net/ )
CIMG_BOARD_CFLAGS = -Dcimg_use_board -I/usr/include/board
CIMG_BOARD_LDFLAGS = -lboard

# Flags to compile on Sun Solaris
CIMG_SOLARIS_LDFLAGS = -R$(X11PATH)/lib -lrt -lnsl -lsocket

# Flags to compile GIMP plug-ins.
ifeq ($(MSYSTEM),MINGW32)
CIMG_GIMP_CFLAGS = -mwindows
endif

#-------------------------
# Define Makefile entries
#-------------------------
version: Makefile
	echo ${version} > VERSION

.cpp:
	@echo
	@echo "** Compiling '$* ($(CIMG_VERSION))' with '`$(CC) -v 2>&1 | tail -n 1`'"
	@echo
	$(CC) -o $(EXEPFX)$* $< $(CFLAGS) $(LDFLAGS) $(CONF_CFLAGS) $(CONF_LDFLAGS)
ifeq ($(MACOSX_APP),true)
	mkdir -p $(EXEPFX)${*}.app/Contents/MacOS
	mv $(EXEPFX)${*} $(EXEPFX)${*}.app/Contents/MacOS
endif
ifeq ($(STRIP_EXE),true)
ifeq ($(MSYSTEM),MINGW32)
	strip $(EXEPFX)$*.exe
else
	strip $(EXEPFX)$*
endif
endif
menu:
	@echo
	@echo "CImg Library $(CIMG_VERSION) : Examples"
	@echo "-----------------------------"
	@echo "  > linux    : Linux/BSD/MacOSX target, X11 display, optimizations disabled."
	@echo "  > dlinux   : Linux/BSD/MacOSX target, X11 display, debug mode."
	@echo "  > olinux   : Linux/BSD/MacOSX target, X11 display, optimizations enabled."
	@echo "  > mlinux   : Linus/BSD/MacOSX target, no display, minimal features, optimizations enabled."
	@echo "  > Mlinux   : Linux/BSD/MacOSX target, X11 display, maximal features, optimizations enabled."
	@echo
	@echo "  > solaris  : Sun Solaris target, X11 display, optimizations disabled."
	@echo "  > dsolaris : Sun Solaris target, X11 display, debug mode."
	@echo "  > osolaris : Sun Solaris target, X11 display, optimizations enabled."
	@echo "  > msolaris : Sun Solaris target, no display, minimal features, optimizations enabled."
	@echo "  > Msolaris : Sun Solaris target, X11 display, maximal features, optimizations enabled."
	@echo
	@echo "  > macosx   : MacOSX target, Carbon display, optimizations disabled."
	@echo "  > dmacosx  : MacOSX target, Carbon display, debug mode."
	@echo "  > omacosx  : MacOSX target, Carbon display, optimizations enabled."
	@echo "  > mmacosx  : MacOSX target, no display, minimal features, optimizations enabled."
	@echo "  > Mmacosx  : MacOSX target, Carbon display, maximal features, optimizations enabled."
	@echo
	@echo "  > windows  : Windows target, GDI32 display, optimizations disabled."
	@echo "  > dwindows : Windows target, GDI32 display, debug mode."
	@echo "  > owindows : Windows target, GDI32 display, optimizations enabled."
	@echo "  > mwindows : Windows target, no display, minimal features, optimizations enabled."
	@echo "  > Mwindows : Windows target, GDI32 display, maximal features, optimizations enabled."
	@echo
	@echo "  > clean    : Clean generated files."
	@echo
	@echo "Choose your option :"
	@read CHOICE; echo; make $$CHOICE; echo; echo "> Next time, you can bypass the menu by typing directly 'make $$CHOICE'"; echo;

all: version $(CIMG_FILES)

clean:
	rm -rf *.app *.exe *.o *~ \#* CMakeFiles cmake_install.cmake CMakeCache.txt use_jpeg_buffer greycstoration4gimp gmic4gimp $(CIMG_FILES)
ifneq ($(EXEPFX),)
	rm -f $(EXEPFX)*
endif

# Specific target for 'check_all_functions'.
check: check_all_functions.cpp
	@echo
	@echo "** Compiling 'check_all_functions ($(CIMG_VERSION)) ' with '$(CCVER)'"
	@echo
	$(CC) -c check_all_functions.cpp $(CFLAGS)

# Specific target for the 'greycstoration4gimp' plug-in for GIMP.
greycstoration4gimp: greycstoration4gimp.cpp
	@echo
	@echo "** Compiling 'greycstoration4gimp ($(CIMG_VERSION))' with '$(CCVER)'"
	@echo
	$(CC) -I.. -I./plugins -o $(EXEPFX)greycstoration4gimp greycstoration4gimp.cpp `gimptool-2.0 --cflags` `gimptool-2.0 --libs` -lpthread $(CIMG_OPT_CFLAGS) $(CIMG_GIMP_CFLAGS)

# Specific targets for the 'gmic4gimp' plug-in for GIMP.
gmic4gimp_def: gmic4gimp_def.raw
	\gmic -v- -t char gmic4gimp_def.raw,`du -Db gmic4gimp_def.raw | awk '{print $$1}'` -o -.h | sed 's/unnamed/gmic4gimp_def/' | sed 's/char/const char/' > gmic4gimp_def.h
	\gmic -v- -t uchar ../html/img/logoGMIC.ppm -permute vxyz -o -.h | sed 's/unnamed/logo/' | sed 's/char/const char/' >> gmic4gimp_def.h

gmic4gimp.o: gmic.cpp
	$(CC) -I.. -o gmic4gimp.o -c gmic.cpp -Dgmic_minimal $(CIMG_OPT_CFLAGS) $(CIMG_FFTW3_CFLAGS)

gmic4gimp: gmic4gimp.o gmic4gimp.cpp
	$(CC) -I.. -I./plugins -o $(EXEPFX)gmic4gimp gmic4gimp.cpp gmic4gimp.o `gimptool-2.0 --cflags` `gimptool-2.0 --libs` -lpthread $(CIMG_OPT_FLAGS) $(CIMG_FFTW3_LDFLAGS) $(CIMG_GIMP_CFLAGS)

# Specific targets for 'gmic'.
gmic_def: gmic_def.raw
	\gmic -v- -t char gmic_def.raw,`du -Db gmic_def.raw | awk '{print $$1}'` -o -.h | sed 's/ \};/, 0 \};/g' | sed 's/unnamed/def/' > gmic_def.h

gmic_bool.o: gmic.cpp
	@echo
	@echo "** Compiling 'gmic ($(CIMG_VERSION))' with '$(CCVER)'"
	@echo
	$(CC) -o gmic_bool.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_bool $(CFLAGS) $(CONF_CFLAGS)
gmic_uchar.o: gmic.cpp
	$(CC) -o gmic_uchar.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_uchar $(CFLAGS) $(CONF_CFLAGS)
gmic_char.o: gmic.cpp
	$(CC) -o gmic_char.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_char $(CFLAGS) $(CONF_CFLAGS)
gmic_ushort.o: gmic.cpp
	$(CC) -o gmic_ushort.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_ushort $(CFLAGS) $(CONF_CFLAGS)
gmic_short.o: gmic.cpp
	$(CC) -o gmic_short.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_short $(CFLAGS) $(CONF_CFLAGS)
gmic_uint.o: gmic.cpp
	$(CC) -o gmic_uint.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_uint $(CFLAGS) $(CONF_CFLAGS)
gmic_int.o: gmic.cpp
	$(CC) -o gmic_int.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_int $(CFLAGS) $(CONF_CFLAGS)
gmic_float.o: gmic.cpp
	$(CC) -o gmic_float.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_float $(CFLAGS) $(CONF_CFLAGS)
gmic_double.o: gmic.cpp
	$(CC) -o gmic_double.o -c gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_double $(CFLAGS) $(CONF_CFLAGS)
gmic: gmic_bool.o gmic_uchar.o gmic_char.o gmic_ushort.o gmic_short.o gmic_uint.o gmic_int.o gmic_float.o gmic_double.o gmic.cpp
	$(CC) -o $(EXEPFX)gmic gmic.cpp -I. -Dgmic_separate_compilation -Dgmic_main \
		 gmic_bool.o gmic_uchar.o gmic_char.o gmic_ushort.o gmic_short.o \
		 gmic_uint.o gmic_int.o gmic_float.o gmic_double.o $(CFLAGS) $(LDFLAGS) $(CONF_CFLAGS) $(CONF_LDFLAGS)

ifeq ($(MACOSX_APP),true)
	mkdir -p $(EXEPFX)gmic.app/Contents/MacOS
	mv ${*} $(EXEPFX)gmic.app/Contents/MacOS
endif
ifeq ($(STRIP_EXE),true)
	strip $(EXEPFX)gmic
endif

# Linux/BSD/Mac OSX targets, with X11 display.
linux:
	@make \
"CONF_CFLAGS = \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
all

dlinux:
	@make \
"CONF_CFLAGS = \
$(CIMG_DEBUG_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
all

olinux:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
"STRIP_EXE=true" \
all

mlinux:
	@make \
"CONF_CFLAGS = \
$(CIMG_NODISPLAY_CFLAGS) \
$(CIMG_OPT_CFLAGS)" \
"STRIP_EXE=true" \
all

Mlinux:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS) \
$(CIMG_TIFF_CFLAGS) \
$(CIMG_PNG_CFLAGS) \
$(CIMG_JPEG_CFLAGS) \
$(CIMG_ZLIB_CFLAGS) \
$(CIMG_MAGICK_CFLAGS) \
$(CIMG_FFTW3_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS) \
$(CIMG_TIFF_LDFLAGS) \
$(CIMG_PNG_LDFLAGS) \
$(CIMG_JPEG_LDFLAGS) \
$(CIMG_ZLIB_LDFLAGS) \
$(CIMG_MAGICK_LDFLAGS) \
$(CIMG_FFTW3_LDFLAGS)" \
"STRIP_EXE=true" \
all use_jpeg_buffer greycstoration4gimp gmic4gimp

# Sun Solaris targets, with X11 display.
solaris:
	@make \
"CONF_CFLAGS = \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_SOLARIS_LDFLAGS) \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
all

dsolaris:
	@make \
"CONF_CFLAGS = \
$(CIMG_DEBUG_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_SOLARIS_LDFLAGS) \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
all

osolaris:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_SOLARIS_LDFLAGS) \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS)" \
"STRIP_EXE=true" \
all

msolaris:
	@make \
"CONF_CFLAGS = \
$(CIMG_NODISPLAY_CFLAGS) \
$(CIMG_OPT_CFLAGS)" \
"STRIP_EXE=true" \
all

Msolaris:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_X11_CFLAGS) \
$(CIMG_XSHM_CFLAGS) \
$(CIMG_XRANDR_CFLAGS) \
$(CIMG_TIFF_CFLAGS) \
$(CIMG_PNG_CFLAGS) \
$(CIMG_JPEG_CFLAGS) \
$(CIMG_ZLIB_CFLAGS) \
$(CIMG_MAGICK_CFLAGS) \
$(CIMG_FFTW3_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_SOLARIS_LDFLAGS) \
$(CIMG_X11_LDFLAGS) \
$(CIMG_XSHM_LDFLAGS) \
$(CIMG_XRANDR_LDFLAGS) \
$(CIMG_TIFF_LDFLAGS) \
$(CIMG_PNG_LDFLAGS) \
$(CIMG_JPEG_LDFLAGS) \
$(CIMG_ZLIB_LDFLAGS) \
$(CIMG_MAGICK_LDFLAGS) \
$(CIMG_FFTW3_LDFLAGS)" \
"STRIP_EXE=true" \
all use_jpeg_buffer greycstoration4gimp gmic4gimp

# MacOsX targets, with Carbon display.
macosx:
	@make \
"CONF_CFLAGS = \
$(CIMG_CARBON_CFLAGS) \
$(CIMG_VT100_CFLAGS)" \
"MACOSX_APP=true" \
all

dmacosx:
	@make \
"CONF_CFLAGS = \
$(CIMG_DEBUG_CFLAGS) \
$(CIMG_CARBON_CFLAGS) \
$(CIMG_VT100_CFLAGS)" \
"MACOSX_APP=true" \
all

omacosx:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_CARBON_CFLAGS) \
$(CIMG_VT100_CFLAGS)" \
"MACOSX_APP=true" \
all

mmacosx:
	@make \
"CONF_CFLAGS = \
$(CIMG_NODISPLAY_CFLAGS) \
$(CIMG_OPT_CFLAGS)" \
"MACOSX_APP=true" \
all

Mmacosx:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_VT100_CFLAGS) \
$(CIMG_CARBON_CFLAGS) \
$(CIMG_TIFF_CFLAGS) \
$(CIMG_PNG_CFLAGS) \
$(CIMG_JPEG_CFLAGS) \
$(CIMG_ZLIB_CFLAGS) \
$(CIMG_MAGICK_CFLAGS) \
$(CIMG_FFTW3_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_TIFF_LDFLAGS) \
$(CIMG_PNG_LDFLAGS) \
$(CIMG_JPEG_LDFLAGS) \
$(CIMG_ZLIB_LDFLAGS) \
$(CIMG_MAGICK_LDFLAGS) \
$(CIMG_FFTW3_LDFLAGS)" \
"MACOSX_APP=true" \
all use_jpeg_buffer greycstoration4gimp gmic4gimp

# Windows targets, with GDI32 display.
windows:
	@make \
"CONF_LDFLAGS = \
$(CIMG_GDI32_LDFLAGS)" \
all

dwindows:
	@make \
"CONF_CFLAGS = \
$(CIMG_DEBUG_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_GDI32_LDFLAGS)" \
all

owindows:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_GDI32_LDFLAGS)" \
"STRIP_EXE=true" \
all

mwindows:
	@make \
"CONF_CFLAGS = \
$(CIMG_NODISPLAY_CFLAGS) \
$(CIMG_OPT_CFLAGS)" \
"STRIP_EXE=true" \
all

Mwindows:
	@make \
"CONF_CFLAGS = \
$(CIMG_OPT_CFLAGS) \
$(CIMG_TIFF_CFLAGS) \
$(CIMG_PNG_CFLAGS) \
$(CIMG_JPEG_CFLAGS) \
$(CIMG_ZLIB_CFLAGS) \
$(CIMG_FFTW3_CFLAGS)" \
"CONF_LDFLAGS = \
$(CIMG_GDI32_LDFLAGS) \
$(CIMG_TIFF_LDFLAGS) \
$(CIMG_PNG_LDFLAGS) \
$(CIMG_JPEG_LDFLAGS) \
$(CIMG_ZLIB_LDFLAGS) \
$(CIMG_FFTW3_LDFLAGS)" \
"STRIP_EXE=true" \
all use_jpeg_buffer greycstoration4gimp gmic4gimp

#-----------------
# End of makefile
#-----------------
