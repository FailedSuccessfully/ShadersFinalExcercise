Shader "Custom/texture tint"
{
    
    Properties{
        _Color("Tint", Color) = (1, 1, 1, 1)
        _MainTex("Texture", 2D) = "white" {}
    }
        SubShader{
            Tags{ "RenderType" = "Opaque" "Queue" = "Geometry"}

            CGPROGRAM

            #pragma surface surf Standard fullforwardshadows

            sampler2D _MainTex;
            fixed4 _Color;

            struct Input {
                float2 uv_MainTex;
            };

            void surf(Input i, inout SurfaceOutputStandard o) {
                fixed4 col = tex2D(_MainTex, i.uv_MainTex);
                col *= _Color;
                o.Albedo = col.rgb;
            }
            ENDCG
    }
}
