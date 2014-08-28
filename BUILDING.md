# Building Servo

Normal build is done with:

```
./mach build
./mach run src/test/html/about-mozilla.html
./mach test
```

Run `./mach --help` to see all available commands.

Android build is done with:

```
ANDROID_TOOLCHAIN=/path/to/toolchain ANDROID_NDK=/path/to/ndk PATH=$PATH:/path/to/toolchain/bin ./mach build --target arm-linux-androideabi`
cd ports/android
ANDROID_NDK=/path/to/ndk ANDROID_SDK=/path/to/sdk make
ANDROID_SDK=/path/to/sdk make install
```

