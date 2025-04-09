Shader "Custom/SunShader"
{
    Properties
    {
        _MainColor("Main Color", Color) = (1, 1, 0, 1) // Yellow Sun
        _GlowIntensity("Glow Intensity", Float) = 5.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _MainColor;
            float _GlowIntensity;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Create glow effect based on distance
                float glow = smoothstep(0.0, _GlowIntensity, distance(i.pos.xy, float2(0.5, 0.5)));
                return _MainColor * glow;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
