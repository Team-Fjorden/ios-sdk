# FjordenSDK

> ⚠️ We are still actively working on the SDK, so the documentation is subject to change. We hope we can keep it as close to this as possible when we launch.
>
> If you are interested in testing an early beta version, please let us know!

## Requirements & Installation

- iOS 14
- Xcode 13
- Swift Package Manager or manual integration

## Quick Start

The central class of everything you need is the `GripManager`. You can access it using `GripManager.default`. You have to call `configure()` before anything else can be accessed. 

The grip manager comes with different operations modes: The default one uses the system's bluetooth stack. Therefore it will only work on a physical device, Bluetooth on the iOS simulator is not supported. You can also run in `simulated` mode, to simulate any kind of situation to test your integration. Under the hood is completely mocks `CoreBluetooth` and doesn't touch the hardware at all. This is the default when running the SDK on the simulator.

To use the normal mode, simply call `configure()`, otherwise pass the desired operation mode `GripManager.default.configure(with: .simulated)`.

The Fjorden SDK is based around async/await, but offers fallback using closures. Xcode should be smart enough to pick the correct version of the API depending on the surrounding context.

### Connection Flow

> ‼️ Make sure to add a `NSBluetoothAlwaysUsageDescription` to your `Info.plist`, otherwise your app will crash the first time you are trying to connect to a new grip!

#### Setting up a new grip

To trigger the system alert to ask for Bluetooth permission, start the grip manager using `start(options: [.askForBluetoothPermission])`.

Once the user has given permission, you can start scanning for available Fjorden grips using `GripManager.default.startScanningForFjordenGrips()`.

We don't include any kind of UI in our SDK at this point, so it will be your job to present a list of found devices to the user.

When selecting a grip, call `GripManager.default.connect(toGrip: selectedGrip)` passing the grip the user selected. This will trigger a system alert from iOS, asking to confirm pairing to the device. Once pairing is confirmed, the grip manager will check the device's firmware version to ensure it matches the minimum required version. See firmware upgrades for further details.

#### Restore Connection on App Launch

Call `GripManager.default.start()` as soon as your app launches. By design, this method doesn't trigger anything that requires user input, so it is always safe to call. If you have paired a grip before, it will try to connect it. If it isn't available, it will time out after 5.0 seconds.

> You can change this timeout using a custom `GripManager.Configuration`, then pass it when setting up the grip manager `GripManager.default.configure(with: custom)`

If Bluetooth access isn't allowed, `unauthorized` will be returned.

#### Forget a configured grip

In order to fully forget a paired grip, you have to call `GripManager.default.disconnectAndForgotBondedGrip()`. Afterwards, you **have** to direct users to Settings.app -> Bluetooth -> Fjorden Grip, let them tap the blue `i` button, and select “Forget this device”. Sadly, there is no programmatic way to achieve this.

## State

The `GripManager` exposes a `state` property you can read at all times.

```swift
public enum State: Equatable {
   case uninitialized
   case ready
   case scanningForGrips
   case scanningForBondedGrip
   case connecting(ConnectableGrip)
   case connected(ConnectedGrip)
   case unauthorized
}
```

### React to changes

If you are interested being informed when the state changes, call `subscribeToStateChanges()`. See examples below.

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

## Handle Grip Events

```swift
guard case .connected(let grip) = GripManager.default.state else {
   assertionFailure("Not connected to any grip")
   return
}

for await event in grip.subscribeToEvents() {
   handleGripEvent(event)
}
```

or

```swift
// `.connectedGrip` is a convenience property since writing case .connected(let grip) = GripManager.default.state can be awkward. It returns the grip is `.state` is connected, otherwise it return `nil`.
guard let grip = GripManager.default.connectedGrip else {
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

We added a little app you can run on your Mac (or second iOS device) that will act as a simulator for the Fjorden hardware. It will show up as `Fjorden Grip Simulator` first, but then will use the name of your device for the bond—this is sadly a limitation we can't work around at this point. Due to more limitation in `CoreBluetooth`, the simulator can only simulate grip events, not scenarios where the firmware needs upgrading. We will update this section with the download link once available.
