shader_type canvas_item;

uniform vec3 color = vec3(0.0);
uniform int OCTAVES = 5;
uniform float scaleParam = 0.9;

float rand(vec2 coord){
	return fract(sin(dot(coord,vec2(12.9898,78.233))* 1000.0) * 43758.5453123);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1.0,0.0));
	float c = rand(i + vec2(0.0,1.0));
	float d = rand(i + vec2(1.0,1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f );
	return mix(a,b,cubic.x) + (c-a) * cubic.y * (1.0 -cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fractal_brownien_motion(vec2 coord){
	float value = 0.0;
	// Opacity (basically?)
	//float scale = 0.5;
	float scale = scaleParam;
	
	vec2 shift = vec2(100.0);
	mat2 rot = mat2(vec2(cos(0.5), sin(0.5)), vec2(-sin(0.5), cos(0.50)));
	
	for(int i=0 ; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord = rot * coord * 2.0 + shift;
		scale *= 0.5; 
	}
	return value;
}

void fragment(){
	vec2 coord = UV * 10.0;

	vec2 motion = vec2(fractal_brownien_motion(coord + vec2(TIME * -0.5, TIME * 0.5)));

	float final = fractal_brownien_motion(coord + motion);

	COLOR = vec4(color,final * 1.0);
	
}
