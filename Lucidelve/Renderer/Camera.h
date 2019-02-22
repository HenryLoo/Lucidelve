//
//  Camera.h
//  Adapted from Joey DeVries LearnOpenGL tutorials found at
//  https://learnopengl.com/
//  ass_2
//
//  Created by Choy on 2019-02-17.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief A Camera object used for the view matrix.
 */
@interface Camera : NSObject

// The position
@property (nonatomic) GLKVector3 _position;
// The direction it is facing
@property (nonatomic) GLKVector3 _front;
// The up direction
@property (nonatomic) GLKVector3 _up;
// The right direction
@property (nonatomic) GLKVector3 _right;
// The world's up direction
@property (nonatomic) GLKVector3 _worldUp;
/* Euler angles */
@property (nonatomic) GLfloat _yaw;
@property (nonatomic) GLfloat _pitch;
/* Camera options */
@property (nonatomic) GLfloat _zoom;

/*!
 * @brief Default constructor
 * @author Jason Chung
 *
 * @return An id to the created instance
 */
- (id)init;
/*!
 * @brief Constructor with vectors
 * @author Jason Chung
 *
 * @param position The position of the camera
 *
 * @return An id to the created instance
 */
- (id)initWithPosition:(GLKVector3)position;
/*!
 * @brief Constructor with vectors
 * @author Jason Chung
 *
 * @param position The position of the camera
 * @param up The up position of the camera
 *
 * @return An id to the created instance
 */
- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up;
/*!
 * @brief Constructor with vectors
 * @author Jason Chung
 *
 * @param position The position of the camera
 * @param up The up position of the camera
 * @param yaw The rotation around the vertical axis
 *
 * @return An id to the created instance
 */
- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up yaw:(GLfloat)yaw;
/*!
 * @brief Constructor with vectors
 * @author Jason Chung
 *
 * @param position The position of the camera
 * @param up The up position of the camera
 * @param yaw The rotation around the vertical axis
 * @param pitch The rotation around side-to-side axis
 *
 * @return An id to the created instance
 */
- (id)initWithPosition:(GLKVector3)position up:(GLKVector3)up yaw:(GLfloat)yaw pitch:(GLfloat)pitch;
/*!
 * @brief Constructor with vectors
 * @author Jason Chung
 *
 * @param posX The X position
 * @param posY The Y position
 * @param posZ The Z position
 * @param upX The X up direction
 * @param upY The Y up direction
 * @param upZ The Z up direction
 * @param yaw The rotation around the vertical axis
 * @param pitch The rotation around side-to-side axis
 *
 * @return An id to the created instance
 */
- (id)initWithPosition:(GLfloat)posX posY:(GLfloat)posY posZ:(GLfloat)posZ upX:(GLfloat)upX upY:(GLfloat)upY upZ:(GLfloat)upZ yaw:(GLfloat)yaw pitch:(GLfloat)pitch;
/*!
 * @brief Updates the values of the camera
 * @author Jason Chung
 */
- (void)update;
/*!
 * @brief Returns the view matrix based on current values.
 * @author Jason Chung
 *
 * @return Returns the view matrix
 */
- (GLKMatrix4)getViewMatrix;

@end

NS_ASSUME_NONNULL_END
