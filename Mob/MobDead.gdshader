// code from https://godotshaders.com/shader/parametric-linear-rgb-dimmer/

shader_type canvas_item;

uniform bool alive = true;

// Parameters to control the damping factors for red, green, and blue channels
uniform float red_factor : hint_range(0.0, 1.0) = 1.0;
uniform float green_factor : hint_range(0.0, 1.0) = 1.0;
uniform float blue_factor : hint_range(0.0, 1.0) = 1.0;

// Parameter to control the alpha factor
uniform float alpha_factor : hint_range(0.0, 1.0) = 1.0;


void fragment() { 
	if (!alive) {
		// Reduce the red, green, and blue channels by their respective factors
		COLOR.rgb = vec3(COLOR.r * red_factor, COLOR.g * green_factor, COLOR.b * blue_factor);
		// Adjust the alpha channel
		COLOR.a *= alpha_factor;
	}
}
