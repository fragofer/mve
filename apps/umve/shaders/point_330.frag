#version 330

in vec3 gnormal;
in vec3 gcolor;
smooth in vec2 gtex;

uniform int lighting = 0;
uniform int pass = 0;
uniform vec4 ccolor;
uniform vec3 light1 = vec3(0.0, 0.0, 5.0);

uniform mat4 viewmat;
layout(location=0) out vec4 fcolor;

void main()
{
    if (!gl_FrontFacing)
        discard;

    float dist = distance(gtex, vec2(0.5, 0.5)) * 2.0;
    if (dist > 1.0)
        discard;

    if (pass == 1)
    {
        float alpha = exp(-(dist * dist));
        vec4 color = vec4(ccolor.rgb * alpha, alpha);
        if (ccolor.a == 0.0)
            color = vec4(gcolor * alpha, alpha);

        if (lighting == 1)
        {
            vec4 normal = viewmat * vec4(gnormal, 0.0);
            float f = dot(normal, vec4(normalize(light1), 0.0));
            color = vec4(color.rgb * f * 0.2 + color.rgb * 0.8, alpha);
            //color = color * f;
        }

        fcolor = color;
    }
    else
        fcolor = vec4(0.0, 0.0, 0.0, 1.0);
}
