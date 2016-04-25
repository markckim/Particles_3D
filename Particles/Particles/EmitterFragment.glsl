
uniform mediump sampler2D   u_Texture;
uniform lowp vec3           u_eColorStart;
uniform lowp vec3           u_eColorEnd;
uniform lowp float          u_eAlphaStart;
uniform lowp float          u_eAlphaCutoff;

varying mediump float       v_pRotation;
varying lowp float          v_pAlpha;
varying mediump vec3        v_pColorOffset;
varying mediump float       v_pStartTime;
varying mediump float       v_pPercent;
varying lowp float          v_pColorScale;

highp mat4 rotationMatrix(highp vec3 axis, highp float angle)
{
    axis = normalize(axis);
    highp float s = sin(angle);
    highp float c = cos(angle);
    highp float oc = 1.0 - c;
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y + axis.z * s,  oc * axis.z * axis.x - axis.y * s,  0.0,
                oc * axis.x * axis.y - axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z + axis.x * s,  0.0,
                oc * axis.z * axis.x + axis.y * s,  oc * axis.y * axis.z - axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

highp mat4 textureRotationMatrix(highp vec3 axis, highp float angle)
{
    highp mat4 m1 = mat4(1.0, 0.0, 0.0, 0.0,
                         0.0, 1.0, 0.0, 0.0,
                         0.0, 0.0, 1.0, 0.0,
                         -0.5, -0.5, 0.0, 1.0);
    highp mat4 m2 = rotationMatrix(vec3(0.0, 0.0, 1.0), angle);
    highp mat4 m3 = mat4(1.0, 0.0, 0.0, 0.0,
                         0.0, 1.0, 0.0, 0.0,
                         0.0, 0.0, 1.0, 0.0,
                         0.5, 0.5, 0.0, 1.0);
    return m3 * m2 * m1;
}

void main(void)
{
    lowp vec2 texCoord = (textureRotationMatrix(vec3(0.0, 0.0, 1.0), v_pRotation) * vec4(gl_PointCoord, 0, 1)).xy;
    mediump vec4 texture = vec4(texture2D(u_Texture, texCoord));
    if (texture.a < u_eAlphaCutoff) {
        discard;
    }
    lowp vec4 color = vec4(1.0, 1.0, 1.0, u_eAlphaStart < -0.5 ? texture.a : v_pAlpha);
    color.rgb = clamp(mix(u_eColorStart, u_eColorEnd, v_pPercent) + v_pColorOffset, vec3(0.0), vec3(1.0));
    
    // fragment shader outputs
    gl_FragColor = v_pColorScale * texture * color;
}
