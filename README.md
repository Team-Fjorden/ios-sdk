# FjordenSDK

## Documentation

[Full documentation ↗](https://sdk.fjorden.co/)

## Requirements

- iOS 14
- Xcode 13
- Swift Package Manager or manual integration

## Quick start

⚠️ There are a couple of bugs in SPM and/or Xcode that might break Xcode Cloud and/or SwiftUI preview. Packages that define a dynamic framework seem to break Xcode Cloud, e.g. https://github.com/DataDog/dd-sdk-ios/issues/624#issuecomment-965240757, https://developer.apple.com/forums/thread/689907, https://github.com/simibac/ConfettiSwiftUI/issues/8. We can't change our SDK to be a static library, because we rely on other frameworks as well. Static libraries via SPM also seem to break SwiftUI previews (https://github.com/DataDog/dd-sdk-ios/pull/949, https://developer.apple.com/forums/thread/707569). The most reliable way to integrate the FjordenSDK at the moment is to manually add the latest `.xcframework` file to your workspace & include it in your repository.

### SPM

Add `https://github.com/Team-Fjorden/ios-sdk` to your `Package.swift` file or via Xcode → Add Packages… & paste the URL into the search field.

### Manual

Download the [latest release](https://sdk.fjorden.co/releases/1.1.3/FjordenSDK.xcframework.zip) from the Release tab. Unzip, and drag the `xcframework` files into the `Frameworks, Libraries, and Embedded Content` section of your target.

## Quick Start

The central class of everything you need is the `GripManager`. You can access it using `GripManager.default`. You have to call `configure()` before anything else can be accessed.

The grip manager comes with different operations modes: The default one uses the system's bluetooth stack. Therefore it will only work on a physical device, Bluetooth on the iOS simulator is not supported. You can also run in `simulated` mode, to simulate any kind of situation to test your integration. Under the hood it completely mocks `CoreBluetooth` and doesn't touch the hardware at all. This is the default when running the SDK on the simulator.

To use the normal mode, simply call `configure()`, otherwise pass the desired operation mode `GripManager.default.configure(with: .simulated)`.

The Fjorden SDK is based around async/await, but offers fallback using closures. Xcode should be smart enough to pick the correct version of the API depending on the surrounding context.

### Connection Flow

> ‼️ Make sure to add a `NSBluetoothAlwaysUsageDescription` to your `Info.plist`, otherwise your app will crash the first time you are trying to connect to a new grip!

#### Setting up a new grip

To trigger the system alert to ask for Bluetooth permission, start the grip manager using `start(options: [.askForBluetoothPermission])`.

Once the user has given permission, you can start scanning for available Fjorden grips using `GripManager.default.startScanningForFjordenGrips()`. If there is a grip (or multiple grips) around, the method will be called every time the signal strength of a discovered grip updates. The SDK handles deduplication, so you can always simply take the reported grip(s), no need to filter them yourself.

**We don't include any kind of UI in our SDK**, so it will be your job to present a list of found devices to the user. When selecting a grip, call `GripManager.default.connect(toGrip: selectedGrip)` passing the grip the user selected. This will trigger a system alert from iOS, asking to confirm bonding to the device. Once pairing is confirmed, the grip is considered connected, and the `GripManager` transitions into the `.connected(ConnectedGrip)` state.

#### Restore Connection on App Launch

Call `GripManager.default.start()` as soon as your app launches. By design, this method doesn't trigger anything that requires user input, so it is always safe to call. If you have paired a grip before, it will try to connect it. If it isn't available, it will time out after 5.0 seconds. Usually the system re-connects to a grip as soon as you turn it on, even if your app with the Fjorden SDK is not running.

> You can change this timeout using a custom `GripManager.Configuration`, then pass it when setting up the grip manager `GripManager.default.configure(with: custom)`

If Bluetooth access isn't allowed, `unauthorized` will be returned.

#### Forget a configured grip

In order to fully forget a paired grip, you have to call `GripManager.default.disconnectAndForgotBondedGrip()`. Afterwards, you **have** to direct users to Settings.app -> Bluetooth -> Fjorden Grip, let them tap the blue `i` button, and select “Forget this device”. Sadly, there is no programmatic way to achieve this.

## State

The [`GripManager`](https://sdk.fjorden.co/documentation/fjordensdk/gripmanager) exposes a [`state`](https://sdk.fjorden.co/documentation/fjordensdk/gripmanager/state-swift.property) property you can read at all times.

### React to changes

If you are interested being informed when the state changes, call [`subscribeToStateChanges()`](https://sdk.fjorden.co/documentation/fjordensdk/gripmanager/subscribetostatechanges()). See examples below.

```swift
for await state in GripManager.default.subscribeToStateChanges() {
    handleGripManagerStateChange(state)
}
```

or

```swift
GripManager.default.subscribeToStateChanges { [weak self] state in
    self?.handleGripManagerStateChange(state)
}
```

## Grip Events

[List of available events ↗](https://sdk.fjorden.co/documentation/fjordensdk/gripevent)

### React to Events

#### Async/Await

```swift
guard case .connected(let grip) = GripManager.default.state else {
   assertionFailure("Not connected to any grip")
   return
}

for await event in grip.subscribeToEvents() {
   handleGripEvent(event)
}
```

#### Callback Closure

```swift
guard case .connected(let grip) = GripManager.default.state else {
   assertionFailure("Not connected to any grip")
   return
}

grip.subscribeToEvents { [weak self] event in
   self?.handleGripEvent(event)
}
```

### Firmware Upgrades

When first connecting to a grip, the SDK makes sure the grip has the min. required firmware. We don’t expect the communication interface between the SDK & the grip will change once we start shipping, but how knows :) In case the firmware is too old, the SDK will throw an error. If that happens, you should direct users to the Fjorden app to update the grip.

## macOS Simulator

We will add a little app you can run on your Mac (or second iOS device) that will act as a simulator for the Fjorden hardware. It will show up as `Fjorden Grip Simulator` first, but then will use the name of your device for the bond—this is sadly a limitation we can't work around at this point. Due to more limitation in `CoreBluetooth`, the simulator can only simulate grip events, not scenarios where the firmware needs upgrading. We will update this section with the download link once available.
