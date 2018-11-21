varying vec4 vpos;
uniform float time;
uniform vec2 squareCentre;
 
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;

    vec2 outwardsVec = vec2(vpos.x - squareCentre.x, vpos.y - squareCentre.y);

    return transform_projection * vec4(vertex_position.x + (outwardsVec.x * sin(time)), vertex_position.y + (outwardsVec.y * sin(time)), vertex_position.z, vertex_position.w);
}
