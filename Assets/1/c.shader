Shader "Unlit/c"
{
    Properties
    {
        _Power("Power", Range(0,1)) = 1
        _Modulation("Modulation", Range(1,100)) = 1
        _Rate("Rate", Range(1,100)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5

            #include "UnityCG.cginc"

            half _Modulation, _Rate, _Power;

            struct v2f
            {
                fixed4 color : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (float4 vertex : POSITION, uint vid : SV_VertexID)
            {
                v2f o;
                float mod = _Time.x * _Modulation + _SinTime.y * _Rate;
                o.pos = UnityObjectToClipPos(vertex);
                float f = (float)vid / mod;
                o.color = half4(sin(f * cos(f)),cos(f * _Rate),sin(f * _Modulation),0) * 0.5 + 0.5;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color * _Power;
            }
            ENDCG
        }
    }
}
