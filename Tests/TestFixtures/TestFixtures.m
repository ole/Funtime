#import "TestFixtures.h"

@implementation BaseClass
@end

@implementation SubClass
@end

@implementation TwoProperties
@end

@implementation ThreeMoreProperties
@end

@implementation AssortedProperties

static double _classProperty = 0.0;

+ (double)classProperty {
    return _classProperty;
}

+ (void)setClassProperty:(double)newValue {
    _classProperty = newValue;
}

@end
