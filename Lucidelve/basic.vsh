attribute vec4 position;
attribute vec4 colour;
attribute vec2 texCoordIn;

varying vec4 v_colour;
varying vec2 v_texcoord;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    // Simple passthrough shader
    v_colour = colour;
    v_texcoord = texCoordIn;
    gl_Position = modelViewProjectionMatrix * position;
}
