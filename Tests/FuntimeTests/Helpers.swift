import Foundation

/**
 Returns `true` if the current deployment target is at least the specified version that corresponds to the current platform.

 The arguments must be passed in the form of the `__MAC_XX_X`, `__IPHONE_XX_X`, etc. constants defined in Availability.h. For example, to test if the current deployment target is at least macOS 10.12, iOS 10.0, tvOS 10.0, or watchOS 3.0:

 guard isDeploymentTargetAtLeast(macOS: __MAC_10_12, iOS: __IPHONE_10_0, tvOS: __TVOS_10_0, watchOS: __WATCHOS_3_0) else {
 // Deployment target is lower
 ...
 }

 - Note: Although this is a runtime test, it uses the `__MAC_OS_X_VERSION_MIN_REQUIRED` etc. compile-time macros to determine the deployment target. So this function checks the deployment target it itself has been compiled with, not the deployment target of the calling code. If the calling code is in another module, it's possible that it has been compiled with a different deployment target.
 */
public func isDeploymentTargetAtLeast(macOS macOSVersion: Int32, iOS iOSVersion: Int32, tvOS tvOSVersion: Int32, watchOS watchOSVersion: Int32) -> Bool {
    #if os(macOS)
        return __MAC_OS_X_VERSION_MIN_REQUIRED >= macOSVersion
    #elseif os(iOS)
        return __IPHONE_OS_VERSION_MIN_REQUIRED >= iOSVersion
    #elseif os(tvOS)
        return __TV_OS_VERSION_MIN_REQUIRED >= tvOSVersion
    #elseif os(watchOS)
        return __WATCH_OS_VERSION_MIN_REQUIRED >= watchOSVersion
    #else
        return false
    #endif
}
