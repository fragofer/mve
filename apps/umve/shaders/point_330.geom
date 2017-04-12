#version 330

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

in vec3 vpos[];
in vec3 vnormal[];
in vec3 vcolor[];

uniform mat4 viewmat;
uniform mat4 projmat;
uniform float size = 0.0015;
uniform int pass;

out vec3 gnormal;
out vec3 gcolor;
smooth out vec2 gtex;

vec3 orthogonal(vec3 vec)
{
    vec3 n0 = vec3(1.0, 0.0, 0.0);
    vec3 n1 = vec3(0.0, 1.0, 0.0);
    if (abs(dot(n0, vec)) < abs(dot(n1, vec)))
        return cross(n0, vec);
    else
        return cross(n1, vec);
}

void main(void)
{
    vec3 pos = vpos[0];
    float r = length(vnormal[0]);
    vec3 normal = vnormal[0] / r;
    vec3 color = vcolor[0];

    r = 3.0 * size;

    vec3 sy = normalize(orthogonal(-normal));
    vec3 sx = normalize(cross(sy, -normal));

    vec3 vs[4];
    vec2 uvs[4];
    vs[0] = pos - r * sx - r * sy;
    vs[1] = pos - r * sx + r * sy;
    vs[2] = pos + r * sx - r * sy;
    vs[3] = pos + r * sx + r * sy;
    uvs[0] = vec2(0, 0);
    uvs[1] = vec2(0, 1);
    uvs[2] = vec2(1, 0);
    uvs[3] = vec2(1, 1);

    for (int i = 0; i < 4; ++i)
    {
        gnormal = normal;
        gcolor = color;
        vec4 pos = viewmat * vec4(vs[i], 1.0);
        if (pass == 0)
        {
            //Correct perspective if possible
            if (pos.z < -0.001)
            {
                pos.x += (pos.x * -r) / pos.z;
                pos.y += (pos.y * -r) / pos.z;
            }
            pos.z += -r;
        }
        gl_Position = projmat * pos;
        gtex = uvs[i];
        EmitVertex();
    }
    EndPrimitive();
}

