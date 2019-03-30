precision mediump float;

attribute vec3 aPos;
attribute vec2 aTexCoords;

varying vec3 FragPos;
varying vec2 TexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform vec2 texSize;
uniform vec2 clipSize;
uniform int spriteIndex;

void main() {
    FragPos = vec3(model * vec4(aPos, 1.0));
    
    float index = float(spriteIndex);
    float spritesPerRow = texSize.x / clipSize.x;
    float offsetX = mod(index, spritesPerRow);
    float offsetY = floor(index / spritesPerRow);
    vec2 clipCoords = vec2((aTexCoords.x + offsetX) * clipSize.x / texSize.x, (aTexCoords.y + offsetY) * clipSize.y / texSize.y);
    TexCoords = clipCoords;
    
    gl_Position = projection * view * vec4(FragPos, 1.0);
}
