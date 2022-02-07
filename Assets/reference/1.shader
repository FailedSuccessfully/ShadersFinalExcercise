Shader "Custom/1"
{
    Properties { // display in inspector
        _MyColor("pick color", Color) = (1,1,1,1)
        [HDR]_MyEmission("pick emission color", Color) = (0,0,0,0)
        _Specular("Specular", Color) = (0,0,0)
        _Gloss("Gloss", Range(0,1)) = 0
        //_Normal("Normal", Vector) = (1,1,1)
        [Normal]  _BumpMap ("Normal Map", 2D) = "bump" { }
    }
    SubShader {
        Tags { "RenderType" = "Transparent" "Queue"="Transparent"}
        
        CGPROGRAM
        #pragma surface surf StandardSpecular fullforwardshadows alpha
        #pragma target 3.0
        fixed4 _MyColor;
        fixed3 _Specular;
        fixed3 _MyEmission;
        half _Gloss;
        //fixed3 _Normal;
        sampler2D _BumpMap;
        
        
        struct Input {
                fixed4 color : COLOR;
                float2 uv_BumpMap;
        };
        void surf (Input IN, inout SurfaceOutputStandardSpecular  o) {
                o.Albedo = _MyColor.rgb; // 1 = (1,1,1,1) = white
                o.Alpha = _MyColor.a;
                o.Emission = _MyEmission;
                o.Specular = _Specular;
                o.Smoothness = _Gloss;
                o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
        }
        ENDCG
    }
Fallback "StandardSpecular"
}
