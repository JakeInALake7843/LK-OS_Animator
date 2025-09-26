Shader "Unlit/SpriteRipple"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _HitTime ("Hit Time", Range(0, 1)) = 0
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            uniform float _HitTime;
            uniform float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float lineDist(float2 position) {
                float x = clamp(position.x, -0.5, 0.5);
                float2 nearest = float2(x, 0);
                return length(position - nearest);
            }

            float4 frag (v2f i) : SV_Target
            {
                float4 outputColor = _Color;
                float2 ScaledUV = i.uv.xy * float2(22, 1.6);
                float2 Position = ScaledUV - float2(11, 1.6);
                float dist = lineDist(Position);
                float Distance = step(dist, _HitTime * 10.62);
                outputColor.a = Distance;
                return outputColor;
            }
            ENDCG
        }
    }
}
