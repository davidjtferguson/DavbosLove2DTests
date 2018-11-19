varying vec4 vpos;
 
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;

    return transform_projection * vertex_position * vec4(0.5, 1.0, 1.0, 1.0);
}