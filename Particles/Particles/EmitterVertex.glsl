
attribute highp float   a_pStartTime;
attribute highp float   a_pLifetimeOffset;
attribute highp float   a_pSpeedOffset;
attribute mediump float a_pAngleOffset;
attribute mediump float a_pPhiOffset;
attribute mediump float a_pAlphaStartOffset;
attribute mediump float a_pScaleStartOffset;
attribute mediump float a_pRotationStartOffset;
attribute highp vec3    a_pPositionOffset;
attribute highp vec3    a_pAccelerationOffset;
attribute lowp vec3     a_pColorOffset;

uniform highp mat4      u_ProjectionMatrix;
uniform highp mat4      u_ModelMatrix;
uniform highp float     u_eLifetime;
uniform highp float     u_eTime;
uniform highp float     u_eSize;
uniform highp float     u_eSpeed;
uniform mediump float   u_eAngle;
uniform mediump float   u_ePhi;
uniform lowp float      u_eAlphaStart;
uniform highp float     u_eAlphaSpeed;
uniform lowp float      u_eScaleStart;
uniform highp float     u_eScaleSpeed;
uniform highp float     u_ePerspectiveMaxDistance;
uniform mediump float   u_eRotationStart;
uniform highp float     u_eRotationSpeed;
uniform highp vec3      u_eAcceleration;

varying mediump float   v_pRotation;
varying lowp float      v_pAlpha;
varying mediump vec3    v_pColorOffset;
varying mediump float   v_pStartTime;
varying mediump float   v_pPercent;
varying lowp float      v_pColorScale;

void main(void)
{
    // initial values
    vec3 initialPosition = a_pPositionOffset;
    float angle = u_eAngle + a_pAngleOffset;
    float phi = u_ePhi + a_pPhiOffset;
    float speed = u_eSpeed + a_pSpeedOffset;
    vec3 acceleration = u_eAcceleration + a_pAccelerationOffset;
    float initialScale = u_eScaleStart + a_pScaleStartOffset;
    float initialRotation = u_eRotationStart + a_pRotationStartOffset;
    float initialAlpha = u_eAlphaStart + a_pAlphaStartOffset;
    float pTime = clamp(u_eTime - a_pStartTime, 0.0, u_eLifetime + a_pLifetimeOffset);
    
    // final values
    vec3 position = initialPosition + speed * vec3(sin(phi) * cos(angle), sin(phi) * sin(angle), cos(phi)) * pTime + 0.5 * acceleration * pow(abs(pTime), 2.0);
    float scale = initialScale + u_eScaleSpeed * pTime;
    float rotation = initialRotation + u_eRotationSpeed * pTime;
    float alpha = clamp(initialAlpha + u_eAlphaSpeed * pTime, 0.0, 1.0);
    float percent = clamp(pTime / (u_eLifetime + a_pLifetimeOffset), 0.0, 1.0);
    
    // vertex shader outputs
    vec4 finalPos = u_ProjectionMatrix * u_ModelMatrix * vec4(position, 1.0);
    
    // point size calculation
    // assuming cameraPos is vec3(0.0, 0.0, 0.0)
    float cameraDist = length(finalPos);
    float maxDistance = u_ePerspectiveMaxDistance > 0.0 ? u_ePerspectiveMaxDistance : 1.0;
    float distScale = max(0.0, 1.0 - (cameraDist / maxDistance));
    float size = scale * u_eSize * distScale;
    
    gl_Position = finalPos;
    gl_PointSize = max(0.0, size);
    
    // fragment shader inputs
    v_pRotation = rotation;
    v_pAlpha = alpha;
    v_pColorOffset = a_pColorOffset;
    v_pStartTime = a_pStartTime;
    v_pPercent = percent;
    v_pColorScale = ((u_eTime - v_pStartTime) <= u_eLifetime) ? 1.0 : 0.0;
}
