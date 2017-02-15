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

static double _classDoubleProperty = 0.0;

+ (double)classDoubleProperty {
    return _classDoubleProperty;
}

+ (void)setClassDoubleProperty:(double)newValue {
    _classDoubleProperty = newValue;
}

@end
