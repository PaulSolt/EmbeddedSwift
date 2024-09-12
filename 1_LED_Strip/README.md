# Embedded Swift LED Strip (LED Matrix)
2024-09-12 

I used the sample code from Apple to start this project and have modified it to include path specific details for Visual Studio code to build the project.

## TODO: You Must Configure the Files to Your Install

This project is a starting point and compliments my video and blog post on the setup process for Embedded Swift in Visual Studio Code.

You will need to find the paths for your install and update the files accordingly.



## Adding New Files to CMakeLists.txt

You need to configure CMake with new files. I believe this could be automated like I have configured the C code.

New Swift files will need to be exposed to the build system at the bottom of CMakeLists.txt in the `main` folder.

```
target_sources(${COMPONENT_LIB}
    PRIVATE
    Main.swift
    LedStrip.swift
    Format.swift # Add more files as needed below
)
```

## Configure VS Code

### .vscode/settings.json

Configure your micro controller settings so that you can build and flash from Visual Studio Code.

Your device settings, serial port, and paths will be different based on the toolchain (if Embedded Swift is still experimental)

```
{
    "idf.adapterTargetName": "esp32c6",
    "idf.port": "/dev/tty.usbmodem2101",
    "idf.openOcdConfigs": [
        "board/esp32c6-builtin.cfg"
    ],
    "idf.flashType": "UART",

    "swift.swiftEnvironmentVariables": {
        "DEVELOPER_DIR": "/Applications/Xcode.app"
    },
    "swift.path": "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2024-09-04-a.xctoolchain/usr/bin",
    "lldb.library": "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2024-09-04-a.xctoolchain/System/Library/PrivateFrameworks/LLDB.framework/Versions/A/LLDB",
    "lldb.launch.expressions": "native"
}
```

### .vscode/c_cpp_properties.json

If you're on macOS, you can probably use this C++ config file as is, so I'll include it.

```
{
    "configurations": [
        {
            "name": "ESP-IDF",
            "compilerPath": "/usr/bin/gcc",
            "compileCommands": "${workspaceFolder}/build/compile_commands.json",
            "includePath": [
                "${config:idf.espIdfPath}/components/**",
                "${workspaceFolder}/**"
            ],
            "browse": {
                "path": [
                    "${config:idf.espIdfPath}/components",
                    "${workspaceFolder}"
                ]
            }
        }
    ],
    "version": 4
}
```