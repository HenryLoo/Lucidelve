//
//  Primitives.h
//  Adapted from the code given by Borna Noureddin from BCIT
//  ass_2
//
//  Created by Choy on 2019-02-17.
//  Copyright © 2019 Choy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mesh.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A singleton class which can return primitive shapes
 */
@interface Primitives : NSObject

/*!
 * @brief Returns a triangle
 * @author Jason Chung
 *
 * @return A triangle mesh
 */
+ (Mesh *)triangle;
/*!
 * @brief Returns a square
 * @author Jason Chung
 *
 * @return A square mesh
 */
+ (Mesh *)square;
/*!
 * @brief Returns a cube
 * @author Jason Chung
 *
 * @return A cube mesh
 */
// + (Mesh *)cube;
/*!
 * @brief Returns a sphere
 * @author Jason Chung
 *
 * @param numSlices The number of slices in the sphere
 * @param radius The radius of the sphere
 *
 * @return A sphere mesh
 */
// + (Mesh *)sphere:(GLint)numSlices radius:(GLfloat)radius;

@end

NS_ASSUME_NONNULL_END
