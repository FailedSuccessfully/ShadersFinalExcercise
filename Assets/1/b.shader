Shader "Custom/b"
{
    Properties
    {
        _MainTex("First Texture", 2D) = "white" {}
        _Fade("Fade", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha

        #pragma target 3.0

        sampler2D _MainTex;
        half _Fade;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecTex;
        };
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c1 = tex2D (_MainTex, IN.uv_MainTex)  * _Fade;
            o.Albedo += c1.rgb;
            o.Alpha = _Fade;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
