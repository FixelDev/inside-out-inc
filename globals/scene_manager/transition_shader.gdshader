shader_type canvas_item;


uniform float speed;
uniform vec4 color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment () {
	COLOR = texture(TEXTURE, vec2(UV.x + TIME * speed, UV.y));
	COLOR *= color;
}