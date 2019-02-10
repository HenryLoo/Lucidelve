//
//  Uniform.h
//  Lucidelve
//
//  Created by Choy on 2019-02-09.
//  Copyright © 2019 COMP 8051. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Uniform : NSObject {
    const NSString *_name;
    GLint _location;
}

- (const NSString *)getName;
- (GLint)getLocation;
- (void)setName:(NSString *)name;
- (void)setLocation:(GLint)location;

@end

NS_ASSUME_NONNULL_END
