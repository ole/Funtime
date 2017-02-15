#import <Foundation/Foundation.h>

/// A direct subclass of NSObject
@interface BaseClass : NSObject
@end

/// A subclass of a subclass of NSObject
@interface SubClass : BaseClass
@end

@interface TwoProperties : NSObject

@property (assign) int one;
@property (assign) int two;

@end

@interface ThreeMoreProperties : NSObject

@property (assign) int three;
@property (assign) int four;
@property (assign) int five;

@end

@interface AssortedProperties : NSObject

@property (nonatomic, assign) int nonAtomicProperty;
@property (atomic, assign) int atomicProperty;
@property (assign) int intProperty;
@property (copy) NSString *nsStringProperty;
@property (retain) id idProperty;
@property (nonatomic, copy, readonly) NSArray *nonAtomicCopyReadonlyArrayProperty;
@property (class, assign) double classProperty;
@property (copy, readonly) NSString *readOnlyProperty;
@property (assign) char assignProperty;
@property (retain) NSDate *retainProperty;
@property (copy) NSArray *someCopyProperty;
@property (weak) id weakProperty;

@end
