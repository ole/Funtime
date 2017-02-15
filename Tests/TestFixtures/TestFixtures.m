#import "TestFixtures.h"

@implementation BaseClass
@end

@implementation SubClass
@end

@implementation TwoProperties
@end

@implementation ThreeMoreProperties
@end

@implementation AssortedProperties {
    int _dynamicProperty;
}

@dynamic dynamicProperty;
@synthesize customBackingIVarProperty = myCustomIVar;

static double _classProperty = 0.0;

+ (double)classProperty {
    return _classProperty;
}

+ (void)setClassProperty:(double)newValue {
    _classProperty = newValue;
}

- (int)dynamicProperty {
    return _dynamicProperty;
}

- (void)setDynamicProperty:(int)newValue {
    _dynamicProperty = newValue;
}

@end
