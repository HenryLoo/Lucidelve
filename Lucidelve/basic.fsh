precision highp float;
varying vec4 v_colour;
varying vec2 v_texcoord;

uniform sampler2D texSampler;

void main() {
    gl_FragColor = v_colour * texture2D(texSampler, v_texcoord);
}

