precision mediump float;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

varying vec3 FragPos;
varying vec2 TexCoords;

uniform Material material;
uniform bool isFogDisabled;
uniform vec4 fogColour;
uniform vec4 textureColour;
uniform float textureColourAmount;

void main() {
    gl_FragColor = texture2D(material.diffuse, TexCoords);
    
    if (!isFogDisabled)
    {
        // Save the alpha value
        float alpha = gl_FragColor.a;
        
        float fogDistance = gl_FragCoord.z / gl_FragCoord.w;
        float fogAmount = 1.0 - clamp(exp(-0.12 * fogDistance), 0.0, 1.0);
        gl_FragColor = mix(gl_FragColor, fogColour, fogAmount);
        
        // Restore the alpha value
        gl_FragColor.a = alpha;
    }
    
    // Mix texture colour
    float alpha = gl_FragColor.a;
    gl_FragColor = mix(gl_FragColor, textureColour, textureColourAmount);
    gl_FragColor.a = alpha;
}

