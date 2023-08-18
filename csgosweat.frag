precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    
    // Boost vibrance
    float average = (pixColor.r + pixColor.g + pixColor.b) / 3.0;
    float mx = max(pixColor.r, max(pixColor.g, pixColor.b));
    vec3 color = mix(vec3(mx), pixColor.rgb, 1.5) - vec3(average) * 0.5;
    pixColor.rgb = mix(pixColor.rgb, color, 0.9);

    // Boost gamma
    pixColor.rgb = pow(pixColor.rgb, vec3(0.87));

    // Increase brightness
    float brightness = 1.8; // Adjust this value to control brightness
    pixColor.rgb *= brightness;

    gl_FragColor = pixColor;
} 
