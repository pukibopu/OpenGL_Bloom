#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec3 aTexCoords;

out VS_OUT{
    vec3 FragPos;
    vec3 Normal;
    vec3 TexCoords;
}vs_out;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main(){
    gl_Position = projection * view * model * vec4(aPos,1.0f);
    mat3 normalMatrix = transpose(inverse(mat3(model)));
    
    
    vs_out.FragPos = vec3 (model * vec4(aPos,1.0f));
    vs_out.Normal = normalize(normalMatrix * aNormal);
    vs_out.TexCoords = aTexCoords;
    
}
