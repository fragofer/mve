#version 330 core

in vec3 onormal;
smooth in vec2 otexuv;

uniform vec3 light1 = vec3(0.0, 0.0, 5.0);
uniform sampler2D texunit;
uniform vec4 ccolor = vec4(0.7, 0.7, 0.7, 1.0);

layout(location=0) out vec4 frag_color;

void main(void)
{
    vec4 color = texture(texunit, vec2(otexuv.x, 1.0 - otexuv.y));

    if (color.a == 0)
       discard;

    if (color.a > 1.0)
        frag_color = vec4(color.rgb / (color.a - 1.0), 1.0);
    else
        frag_color = color;
}
