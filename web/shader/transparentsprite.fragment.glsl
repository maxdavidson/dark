precision mediump float;

varying vec2 v_uv;
varying vec3 v_pos;
varying vec2 v_screenPos;
varying float v_brightness;
varying vec2 v_real_screenPos;

uniform sampler2D u_tex;
uniform sampler2D u_frame;
uniform float u_time;
uniform vec2 u_viewportSize;
uniform vec2 u_bufferSize;

void main() {
    vec4 col = texture2D(u_tex, v_uv);
    if (col.a<0.9) discard;
/*    float ib = 1.0-v_brightness;
    ib = ib*ib*ib;
    ib = ib*ib;
    float brightness = ((v_brightness+1.0)/(length(v_pos.z)*ib+v_brightness+1.0));*/

    float x = floor(v_screenPos.x);
    float y = floor(v_screenPos.y);
    x = -x*1197.0+(x/64.0)*(x/64.0)*8617.0;
    x+=u_time*63.231312;
    y+=u_time*14.34234;
    float step = fract((x+y)/8.0);
    float transparentBrightness = 0.9-fract(step)/2.0;
    vec4 lastCol = texture2D(u_frame, v_real_screenPos+vec2(0.0, (step-0.5)*4.0/u_bufferSize.y)); 
//    gl_FragColor = vec4(col.rg, transparentBrightness, 1.0);
    lastCol.b*=transparentBrightness;
    gl_FragColor = lastCol;
}
