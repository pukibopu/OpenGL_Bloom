#version 330 core
layout(location = 0) out vec4 FragColor;
layout(location = 1) out vec4 BrightColor;

in VS_OUT{`
    vec3 FragPos;
    vec3 Normal;
    vec3 TexCoords;
}fs_in;
struct Light {
    vec3 Position;
    vec3 Color;
};
uniform sampler2D diffuseTexture;
uniform Light lights[4];
uniform vec3 viewPos;

void main()
{
    vec3 color = texture(diffuseTexture,fs_in.TexCoords).rgb;
    vec3 normal = fs_in.Normal;
    vec3 ambient = 0.0 * color;
    
    vec3 lighting = vec3(0.0);
    vec3 viewDir = normalize(viewPos - fs_in.FragPos);
    
    for(int i=0;i<4;i++){
        vec3 lightDir = normalize(lights[i].Position - fs_in.FragPos);
        float diff = max(dot(lightDir,normal),0.0);
        vec3 res = lights[i].Color * diff * color;
        
        float distance = length(fs_in.FragPos - lights[i].Position);
        res *= 1.0/ distance * distance;
        lighting += res;
    }
    
    vec3 res = lighting + ambient;
    float brightness = dot(res, vec3(0.2126, 0.7152, 0.0722));
    if (brightness > 1.0) {
        BrightColor = vec4 (res,1.0f);
    }else
        BrightColor = vec4(0.0, 0.0, 0.0, 1.0);
    FragColor = vec4(res, 1.0);
}

