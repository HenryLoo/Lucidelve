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
@interface Camera : NSObject {
    // The position
    GLKVector3 _position;
    // The direction it is facing
    GLKVector3 _front;
    // The up direction
    GLKVector3 _up;
    // The right direction
    GLKVector3 _right;
    // The world's up direction
    GLKVector3 _worldUp;
    /* Euler angles */
    GLfloat _yaw;
    GLfloat _pitch;
    /* Camera options */
    GLfloat _zoom;
}

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

/*!
 * Returns the position of the Camera.
 * @author Jason Chung
 *
 * @return The position of the Camera.
 */
- (GLKVector3)position;
/*!
 * Returns the front vector of the Camera.
 * @author Jason Chung
 *
 * @return The front vector of the Camera.
 */
- (GLKVector3)front;
/*!
 * Returns the up vector of the Camera.
 * @author Jason Chung
 *
 * @return The up vector of the Camera.
 */
- (GLKVector3)up;
/*!
 * Returns the right vector of the Camera.
 * @author Jason Chung
 *
 * @return The right vector of the Camera.
 */
- (GLKVector3)right;
/*!
 * Returns the world up of the Camera.
 * @author Jason Chung
 *
 * @return The world up of the Camera.
 */
- (GLKVector3)worldUp;
/*!
 * Returns the yaw of the Camera.
 * @author Jason Chung
 *
 * @return The yaw of the Camera.
 */
- (GLfloat)yaw;
/*!
 * Returns the pitch of the Camera.
 * @author Jason Chung
 *
 * @return The pitch of the Camera.
 */
- (GLfloat)pitch;
/*!
 * Returns the zoom of the Camera.
 * @author Jason Chung
 *
 * @return The zoom of the Camera.
 */
- (GLfloat)zoom;

/*!
 * Sets the position of the Camera.
 * @author Jason Chung
 *
 * @param position The new position of the Camera.
 */
- (void)setPosition:(GLKVector3)position;
/*!
 * Sets the up of the Camera.
 * @author Jason Chung
 *
 * @param up The new up of the Camera.
 */
- (void)setUp:(GLKVector3)up;
/*!
 * Sets the yaw of the Camera.
 * @author Jason Chung
 *
 * @param yaw The new yaw of the Camera.
 */
- (void)setYaw:(GLfloat)yaw;
/*!
 * Sets the pitch of the Camera.
 * @author Jason Chung
 *
 * @param pitch The new pitch of the Camera.
 */
- (void)setPitch:(GLfloat)pitch;
/*!
 * Sets the zoom of the Camera.
 * @author Jason Chung
 *
 * @param zoom The new zoom of the Camera.
 */
- (void)setZoom:(GLfloat)zoom;

@end

NS_ASSUME_NONNULL_END
