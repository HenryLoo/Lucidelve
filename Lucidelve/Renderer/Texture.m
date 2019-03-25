//
//  Texture.m
//  ass_2
//
//  Created by Choy on 2019-02-18.
//  Copyright © 2019 Choy. All rights reserved.
//

#import "Texture.h"
#import "../Utility.h"

@implementation Texture

- (id)initWithFilename:(const char *)filename {
    return [self initWithFilename:filename type:"texture_diffuse"];
}

- (id)initWithFilename:(const char *)filename type:(const char *)type {
    if (self == [super init]) {
        NSString *filePath = [[Utility getInstance] getFilepath:filename fileType:"textures"];
        CGImageRef imageRef = [UIImage imageNamed:filePath].CGImage;
        if (!imageRef) {
            [[Utility getInstance] log:"Failed to load the image."];
            self = nil;
            return self;
        }
        
        _width = CGImageGetWidth(imageRef);
        _height = CGImageGetHeight(imageRef);
        
        GLubyte *spriteData = (GLubyte *)calloc(_width * _height * 4, sizeof(GLubyte));
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * _width;
        NSUInteger bitsPerComponent = 8;
        
        CGContextRef spriteContext = CGBitmapContextCreate(spriteData, _width, _height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGContextDrawImage(spriteContext, CGRectMake(0, 0, _width, _height), imageRef);
        CGContextRelease(spriteContext);
        
        GLuint texture;
        glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
        glGenTextures(1, &texture);
        glBindTexture(GL_TEXTURE_2D, texture);
        
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)_width, (GLsizei)_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
        
        free(spriteData);
        self._id = texture;
        self._type = type;
    }
    return self;
}

- (void)cleanUp {
    if (self._id) {
        glDeleteTextures(1, &__id);
        self._id = 0;
    }
}

- (void)dealloc {
    [self cleanUp];
}

@end
