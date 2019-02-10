#version 300 es

layout(location = 0) in vec4 position;
layout(location = 1) in vec4 colour;

out vec4 v_colour;

uniform mat4 modelViewProjectionMatrix;

void main() {
	// Simple passthrough shader
	v_colour = colour;
	gl_Position = modelViewProjectionMatrix * position;
}
