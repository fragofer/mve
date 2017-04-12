#version 330

in vec4 pos;
in vec4 color;
in vec3 normal;

out vec3 vpos;
out vec3 vnormal;
out vec3 vcolor;

void main()
{
    vpos = pos.xyz / pos.w;
    vnormal = normal;
    vcolor = color.xyz;
}
