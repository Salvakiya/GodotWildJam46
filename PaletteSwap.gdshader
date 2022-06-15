shader_type canvas_item;

uniform sampler2D palette;
uniform int frame = -1;
uniform float fps = 0;
uniform bool skip_first_row = true;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	ivec4 colori = ivec4(round(original_color.rgba * 255.0));
	ivec2 color_count = textureSize(palette, 0);
	
	vec2 half_pixel = vec2(0.5/float(color_count.x),0.5/float(color_count.y));
	
	float idx = -1.0;
	for (int i = 0; i < color_count.x; i++) {
		vec4 color2 = texture(palette, vec2((float(i) / float(color_count.x - 1))+half_pixel.x, 0.0)).rgba;
		ivec4 colori2 = ivec4(round(color2 * 255.0));
		
		if (colori == colori2) {
			idx = float(i)+half_pixel.x;
			//break;
		}
	}
	
	vec2 uv;
	uv.x = idx / float(color_count.x - 1);
	
	float animated = ((mod((TIME * fps), max(float(color_count.y - 1 - int(skip_first_row)), 1.0)) + float(skip_first_row))  / float(color_count.y - 1));
	float no_animated = (float(frame)/float(color_count.y));
	
	uv.y = (fps==0.0)? no_animated : animated;
	uv.y = uv.y + half_pixel.y;
	vec4 palette_color = texture(palette, uv);
	
	COLOR = (idx>=0.0) ? palette_color : original_color;
}