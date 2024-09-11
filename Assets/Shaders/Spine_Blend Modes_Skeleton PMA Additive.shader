Shader "Spine/Blend Modes/Skeleton PMA Additive"
{
  Properties
  {
    _Color ("Tint Color", Color) = (1,1,1,1)
    [NoScaleOffset] _MainTex ("MainTex", 2D) = "black" {}
    [Toggle(_STRAIGHT_ALPHA_INPUT)] _StraightAlphaInput ("Straight Alpha Texture", float) = 0
    _Cutoff ("Shadow alpha cutoff", Range(0, 1)) = 0.1
    [HideInInspector] _StencilRef ("Stencil Reference", float) = 1
    [Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _StencilComp ("Stencil Comparison", float) = 8
    [HideInInspector] _OutlineWidth ("Outline Width", Range(0, 8)) = 3
    [HideInInspector] _OutlineColor ("Outline Color", Color) = (1,1,0,1)
    [HideInInspector] _OutlineReferenceTexWidth ("Reference Texture Width", float) = 1024
    [HideInInspector] _ThresholdEnd ("Outline Threshold", Range(0, 1)) = 0.25
    [HideInInspector] _OutlineSmoothness ("Outline Smoothness", Range(0, 1)) = 1
    [MaterialToggle(_USE8NEIGHBOURHOOD_ON)] [HideInInspector] _Use8Neighbourhood ("Sample 8 Neighbours", float) = 1
    [HideInInspector] _OutlineOpaqueAlpha ("Opaque Alpha", Range(0, 1)) = 1
    [HideInInspector] _OutlineMipLevel ("Outline Mip Level", Range(0, 3)) = 0
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: Normal
    {
      Name "Normal"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Fog
      { 
        Mode  Off
      } 
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      int u_xlatb9;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat16_2.xyz = in_v.color.xyz / in_v.color.www;
          
          u_xlat0.xyz = u_xlat16_2.xyz * float3(0.305306017, 0.305306017, 0.305306017) + float3(0.682171106, 0.682171106, 0.682171106);
          
          u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xyz + float3(0.0125228781, 0.0125228781, 0.0125228781);
          
          u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
          
          u_xlat16_2.xyz = u_xlat0.xyz * in_v.color.www;
          
          u_xlat0.xyz = in_v.color.xyz * float3(0.305306017, 0.305306017, 0.305306017) + float3(0.682171106, 0.682171106, 0.682171106);
          
          u_xlat0.xyz = in_v.color.xyz * u_xlat0.xyz + float3(0.0125228781, 0.0125228781, 0.0125228781);
          
          u_xlat0.xyz = u_xlat0.xyz * in_v.color.xyz;
          
          u_xlatb9 = in_v.color.w==0.0;
          
          u_xlat16_1.xyz = (int(u_xlatb9)) ? u_xlat0.xyz : u_xlat16_2.xyz;
          
          u_xlat0.x = 0.0;
          
          u_xlat16_1.w = (u_xlatb9) ? u_xlat0.x : in_v.color.w;
          
          u_xlat0.xyz = _Color.www * _Color.xyz;
          
          u_xlat0.w = _Color.w;
          
          out_v.color = u_xlat0 * u_xlat16_1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          out_f.color = u_xlat16_0 * in_f.color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: Caster
    {
      Name "Caster"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "SHADOWCASTER"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
        "SHADOWSUPPORT" = "true"
      }
      LOD 100
      Cull Off
      Offset 1, 1
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Fog
      { 
        Mode  Off
      } 
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_LightShadowBias;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat4;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
          
          u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          
          u_xlat4 = u_xlat0.z + u_xlat1.x;
          
          u_xlat1.x = max((-u_xlat0.w), u_xlat4);
          
          out_v.vertex.xyw = u_xlat0.xyw;
          
          u_xlat0.x = (-u_xlat4) + u_xlat1.x;
          
          out_v.vertex.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
          
          out_v.texcoord1.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.texcoord1.z = 0.0;
          
          out_v.texcoord1.w = in_v.color.w;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord1.xy).w;
          
          u_xlat0_d = u_xlat16_0 * in_f.texcoord1.w + (-_Cutoff);
          
          u_xlatb0 = u_xlat0_d<0.0;
          
          if(u_xlatb0)
      {
              discard;
      }
          
          out_f.color = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
