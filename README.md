# maps_and_todo_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

This is an application which has a drawer and contains 2 main functions, one is to show a map second is to add a ToDo or a note. 

First of all to run the application, go to the lib folder in the terminal and run:

```
flutter run --no-sound-null-safety
```

This no sound null safety is because of the package I used (i.e. this [Flutter_maps](https://pub.dev/packages/flutter_google_maps) package) for showing google maps which till now doesn't support null safety (as of flutter 2.12).

![App Summary Video](https://user-images.githubusercontent.com/55953830/114333533-25518100-9b66-11eb-8287-3a2c2b4bb178.mp4)



Now, talking about the app: 

In the map screen, which is the first screen (I've chosen Delhi as a initial place to point to in map) that you will see as soon as you run the application:

You need to insert Your Google Maps API key for further features than just showing a map in following places : 









Specify your API key in the application manifest (in place of `YOUR KEY HERE` in following code snippet) `android/app/src/main/AndroidManifest.xml`:

```
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>

```

Or in your swift code, specify your API key in the application delegate `ios/Runner/AppDelegate.swift`:

```
import UIKit
import Flutter
import GoogleMaps
https://user-images.githubusercontent.com/55953830/114333580-43b77c80-9b66-11eb-9bc0-c724f2a4edec.mp4

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


```

Opt-in to the embedded views preview by adding a boolean property to the app's `Info.plist` file with the key `io.flutter.embedded_views_preview` and the value `YES`.

For, more info on how to use map features on different platforms visit: https://pub.dev/packages/flutter_google_maps


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
