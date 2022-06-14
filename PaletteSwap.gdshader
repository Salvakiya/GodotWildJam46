shader_type canvas_item;

uniform sampler2D palette;
uniform bool skip_first_row = true;
//uniform bool use_palette_alpha = false;
uniform int frame = -1;
uniform float fps = 6;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	ivec4 colori = ivec4(round(original_color.rgba * 255.0));
	
	ivec2 color_count = textureSize(palette, 0);
	
	float idx = -1.0;
	for (int i = 0; i < color_count.x; i++) {
		vec4 color2 = texture(palette, vec2(float(i) / float(color_count.x -1), 0)).rgba;
		ivec4 colori2 = ivec4(round(color2 * 255.0));
		
		if (colori == colori2) {
			idx = float(i);
			break;
		}
	}
	
	if (idx >= 0.0) {
		vec2 uv;
		uv.x = idx / float(color_count.x - 1);
		if (frame == -1){
			uv.y = (mod((TIME * fps), max(float(color_count.y - 1 - int(skip_first_row)), 1.0)) + float(skip_first_row))  / float(color_count.y - 1);
		} else {
			uv.y = float(frame)/float(color_count.y);
			//(mod(frame, max(float(color_count.y - 1 - int(skip_first_row)), 1.0)) + float(skip_first_row))  / float(color_count.y - 1);
		}
		vec4 palette_color = texture(palette, uv);
		COLOR = palette_color;//vec4(palette_color.rgba);//, mix(original_color.a, palette_color.a, float(use_palette_alpha)));
	} else {
		COLOR = original_color;
	}
}