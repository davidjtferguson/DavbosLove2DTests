vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 texcolor = Texel(texture, texture_coords);
    return texcolor * vec4(0.4, 0.8, 0.5, 1.0);
}
