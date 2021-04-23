shader_type canvas_item;

uniform float blur_amount = 1.5;

void fragment()
    {
    COLOR = textureLod(TEXTURE, UV, blur_amount);
    }