# Duos App

duos-api -> nest.js\
duos-ui -> flutter

## flutter install
https://docs.flutter.dev/get-started/install

## flutter setup
We must setup our flutter sdk and project dependencies.
1. Make sure the flutter sdk is installed which comes with dart, then run flutter doctor to ensure all dependencies are met, android studio is required
2. ```cd duos_ui``` from the project root directory
3. ```flutter doctor```
4. ```flutter pub get``` After the flutter doctor resolves, we install our project dependencies
5. For setup on an emulator, either use VSCode or Android Studio, and create/select a virtual device.

    **Android:** Select a device from the list available through android studio, can use vscode flutter extension\
    **IOS:** Start an emulator from the command line as such ```open -a simulator```

6. With the emulator available through Android Studio or VSCode, we run our main.dart file in debug mode to start the build. (Run > Debugging) or F5 on VSCode

## backend install/config
You need to go into the duos-api and install the node dependencies.
1. Open a terminal in the root dir of this project.
2. ```cd duos-api```
3. ```npm ci``` 
4. Make sure that the firebase-service-account.json is present in /src/auth
5. ```npm start```
