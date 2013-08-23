Shader "Custom/Test"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
	}

	SubShader
	{
		LOD 200

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"LightMode" = "ForwardBase"
		}
		
		Pass
		{
			Lighting On
			Fog { Mode Off }
			ColorMask RGB
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			sampler2D _MainTex;
			half4 _MainTex_ST;

			struct appdata_t
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				half4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float4 normal : TEXCOORD1;
				float depth : TEXCOORD2;
			};

			struct fragOutput
			{
				float4 Col0 : COLOR0;
				float4 Col1 : COLOR1;
				float4 Col2 : COLOR2;
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = v.normal;
				o.normal.w = 1;
				o.texcoord = v.texcoord;
				return o;
			}

			fragOutput frag (v2f IN)
			{
				fragOutput o;
				o.Col0 = tex2D( _MainTex, IN.texcoord );

				o.Col1 = IN.normal;
				o.Col1.a = 1;

				o.Col2 = float4( 1.0, 1.0 , 1.0, 1.0 );
				o.Col2.r = IN.depth;


				return o;
			}
			ENDCG
		}
	}
	Fallback Off
}