varying vec4 vpos;
uniform float time;
 
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;

    return transform_projection * vec4(vertex_position.x, vertex_position.y * sin(time), vertex_position.z, vertex_position.w);
}
