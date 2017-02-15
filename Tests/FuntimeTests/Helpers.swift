import Foundation

/**
 Returns `true` if the current deployment target is at least the specified version that corresponds to the current platform.

 The arguments must be passed in the form of the `__MAC_XX_X`, `__IPHONE_XX_X`, etc. constants defined in Availability.h. For example, to test if the current deployment target is at least macOS 10.12, iOS 10.0, tvOS 10.0, or watchOS 3.0:

 guard isDeploymentTargetAtLeast(macOS: __MAC_10_12, iOS: __IPHONE_10_0, tvOS: __TVOS_10_0, watchOS: __WATCHOS_3_0) else {
 // Deployment target is lower
 ...
 }

 - Note: This is a runtime, not a compile-time, test.
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
