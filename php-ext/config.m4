PHP_ARG_WITH(score,
    [Whether to enable the "score" extension],
    [ --enable-score      Enable "score" extension support])

if test "$PHP_SCORE" != "no"; then

    dnl Explicitly define the location of the library.
    dnl Production extensions should use the example from ext_skel on how to
    dnl properly check common library directories for the existence of your
    dnl libs.
    SCORE_LIB_DIR=/usr/local/lib

    dnl This is the proper way to check for the existance of a library. But...
    dnl this creates a simple program that expects a .h file that will define
    dnl our functions. Rust does not provide that, so it fails. There is
    dnl probably some autotools magic I can do to make this work, but alas.
    dnl PHP_CHECK_LIBRARY(score, score_ext,
    dnl [
    dnl     PHP_ADD_LIBRARY_WITH_PATH(score, $SCORE_LIB_DIR, SCORE_SHARED_LIBADD)
    dnl     AC_DEFINE(HAVE_SCORE, 1, [Whether you have score])
    dnl ],[
    dnl     AC_MSG_ERROR([ext_score function not found in libscore])
    dnl ],[
    dnl     -L$SCORE_LIB_DIR -R$SCORE_LIB_DIR
    dnl ])

    dnl Just blindly assume our libscore.so library exists
    PHP_ADD_LIBRARY_WITH_PATH(score, $SCORE_LIB_DIR, SCORE_SHARED_LIBADD)
    -L$SCORE_LIB_DIR -R$SCORE_LIB_DIR

    PHP_SUBST(SCORE_SHARED_LIBADD)
    PHP_NEW_EXTENSION(score, score.c, $ext_shared)
fi
