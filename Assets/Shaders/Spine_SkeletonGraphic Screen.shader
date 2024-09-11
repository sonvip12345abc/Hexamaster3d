Shader "Spine/SkeletonGraphic Screen"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    [Toggle(_STRAIGHT_ALPHA_INPUT)] _StraightAlphaInput ("Straight Alpha Texture", float) = 0
    [Toggle(_CANVAS_GROUP_COMPATIBLE)] _CanvasGroupCompatible ("CanvasGroup Compatible", float) = 1
    _Color ("Tint", Color) = (1,1,1,1)
    [Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _StencilComp ("Stencil Comparison", float) = 8
    [HideInInspector] _Stencil ("Stencil ID", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] [HideInInspector] _StencilOp ("Stencil Operation", float) = 0
    [HideInInspector] _StencilWriteMask ("Stencil Write Mask", float) = 255
    [HideInInspector] _StencilReadMask ("Stencil Read Mask", float) = 255
    [HideInInspector] _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
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
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: Normal
    {
      Name "Normal"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
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
      Blend One OneMinusSrcColor
      ColorMask 0
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
      
      uniform float4 _TextureSampleAdd;
      
      uniform float4 _ClipRect;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat16_0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float u_xlat3;
      
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
          
          u_xlat16_2.xyz = max(in_v.color.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat0.xyz = log2(u_xlat16_2.xyz);
          
          u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat0.xyz = exp2(u_xlat0.xyz);
          
          u_xlat0.xyz = u_xlat0.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat1.xyz = u_xlat0.xyz * float3(0.305306017, 0.305306017, 0.305306017) + float3(0.682171106, 0.682171106, 0.682171106);
          
          u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + float3(0.0125228781, 0.0125228781, 0.0125228781);
          
          u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
          
          u_xlat16_2.xyz = u_xlat0.xyz / in_v.color.www;
          
          u_xlat0.xyz = u_xlat16_2.xyz * float3(0.305306017, 0.305306017, 0.305306017) + float3(0.682171106, 0.682171106, 0.682171106);
          
          u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xyz + float3(0.0125228781, 0.0125228781, 0.0125228781);
          
          u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
          
          u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
          
          u_xlat16_2.xyz = u_xlat16_2.xyz * in_v.color.www;
          
          u_xlatb0 = in_v.color.w==0.0;
          
          u_xlat16_1.xyz = (int(u_xlatb0)) ? u_xlat1.xyz : u_xlat16_2.xyz;
          
          u_xlat3 = 0.0;
          
          u_xlat16_1.w = (u_xlatb0) ? u_xlat3 : in_v.color.w;
          
          u_xlat16_0.xyz = _Color.www * _Color.xyz;
          
          u_xlat16_0.w = _Color.w;
          
          u_xlat0 = u_xlat16_0 * u_xlat16_1;
          
          out_v.color = u_xlat0;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.texcoord1 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      bool4 u_xlatb0_d;
      
      float4 u_xlat16_1_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0_d.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlatb0_d.zw = greaterThanEqual(_ClipRect.zzzw, in_f.texcoord1.xxxy).zw;
          
          u_xlat0_d.x = u_xlatb0_d.x ? float(1.0) : 0.0;
          
          u_xlat0_d.y = u_xlatb0_d.y ? float(1.0) : 0.0;
          
          u_xlat0_d.z = u_xlatb0_d.z ? float(1.0) : 0.0;
          
          u_xlat0_d.w = u_xlatb0_d.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat0_d.xy = u_xlat0_d.zw * u_xlat0_d.xy;
          
          u_xlat0_d.x = u_xlat0_d.y * u_xlat0_d.x;
          
          u_xlat16_1_d = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_1_d = u_xlat16_1_d + _TextureSampleAdd;
          
          u_xlat16_1_d = u_xlat16_1_d * in_f.color;
          
          u_xlat0_d = u_xlat0_d.xxxx * u_xlat16_1_d;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
