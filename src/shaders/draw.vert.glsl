precision mediump float;

attribute float a_index;

uniform sampler2D u_particles;
uniform float u_particles_res;

varying vec2 v_particle_pos;

void main() {
    vec4 color = texture2D(u_particles, vec2(
        fract(a_index / u_particles_res),
        floor(a_index / u_particles_res) / u_particles_res));

    // decode current particle position from the pixel's RGBA value
    v_particle_pos = vec2(
        color.r / 255.0 + color.b,
        color.g / 255.0 + color.a);

    // project the position with mercator projection
    float s = sin(radians(90.0 - v_particle_pos.y * 180.0));
    float y = degrees(log((1.0 + s) / (1.0 - s))) / 360.0;
    float x = 2.0 * v_particle_pos.x - 1.0;

    gl_PointSize = 1.0;
    gl_Position = vec4(x, y, 0, 1);
}
