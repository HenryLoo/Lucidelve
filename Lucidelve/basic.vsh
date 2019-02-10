attribute vec4 position;
attribute vec4 colour;
varying vec4 v_colour;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    // Simple passthrough shader
    v_colour = colour;
    gl_Position = modelViewProjectionMatrix * position;
}
