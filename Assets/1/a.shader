Shader "Custom/a"
{
    Properties
    {
        _MainTex("First Texture", 2D) = "white" {}
        _SecTex("Second Texture", 2D) = "white" {}
        _Blend("Blend", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _SecTex;
        half _Blend;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecTex;
        };
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c1 = tex2D (_MainTex, IN.uv_MainTex)  * _Blend;
            fixed4 c2 = tex2D (_SecTex, IN.uv_SecTex) * (1-_Blend);
            o.Albedo = c1.rgb + c2.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
