// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "FQDev/URPGoldBar"
{
  Properties
  {
    _BaseMap ("Albedo", 2D) = "white" {}
    _BaseColor ("Color", Color) = (1,1,1,1)
    _CoverColor ("Cover Color", Color) = (1,1,1,0)
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _BumpMap ("Normal Map", 2D) = "bump" {}
    [NoScaleOffset] _DetailMap ("Detail Map", 2D) = "white" {}
    _SmoothnessScale ("Smoothness", Range(0, 1)) = 0.5
    _MetallicScale ("Metallic", Range(0, 1)) = 0
    _EmissionScale ("Emission", Range(0, 4)) = 0
    _AmbientClamp ("Ambient Clamp", Range(0, 1)) = 0
    [NoScaleOffset] _MatcapTex ("Matcap Tex", 2D) = "gray" {}
    _MatcapColor ("Matcap Color", Color) = (1,1,1,0)
    [HideInInspector] _Surface ("__surface", float) = 0
    [HideInInspector] _Blend ("__blend", float) = 0
    [HideInInspector] _AlphaClip ("__clip", float) = 0
    [HideInInspector] _SrcBlend ("__src", float) = 1
    [HideInInspector] _DstBlend ("__dst", float) = 0
    [HideInInspector] _ZWrite ("__zw", float) = 1
    [HideInInspector] _Cull ("__cull", float) = 2
    [HideInInspector] _Simple ("__simple", float) = 0
    [HideInInspector] _Matcap ("__matcap", float) = 0
    [HideInInspector] _QueueOffset ("Queue offset", float) = 0
    _ReceiveShadows ("Receive Shadows", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Geometry+2"
      "RenderPipeline" = "UniversalPipeline"
      "RenderType" = "Opaque"
    }
    LOD 500
    Pass // ind: 1, name: ForwardLit
    {
      Name "ForwardLit"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "UniversalForward"
        "QUEUE" = "Geometry+2"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      LOD 500
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile _CoverColor _AmbientClamp
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainLightWorldToShadow[20];
      
      uniform float4 _CascadeShadowSplitSpheres0;
      
      uniform float4 _CascadeShadowSplitSpheres1;
      
      uniform float4 _CascadeShadowSplitSpheres2;
      
      uniform float4 _CascadeShadowSplitSpheres3;
      
      uniform float4 _CascadeShadowSplitSphereRadii;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _MainLightPosition;
      
      uniform float4 _MainLightColor;
      
      uniform float4 _MainLightShadowParams;
      
      uniform sampler2D _BaseMap;
      
      uniform sampler2D _BumpMap;
      
      uniform sampler2D _DetailMap;
      
      uniform sampler2D _MainLightShadowmapTexture;
      
      uniform sampler2D hlslcc_zcmp_MainLightShadowmapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float3 normal : NORMAL0;
          
          float4 tangent : TANGENT0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 vs_NORMAL0 : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float3 texcoord4 : TEXCOORD4;
          
          float3 texcoord5 : TEXCOORD5;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 vs_NORMAL0 : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float3 texcoord4 : TEXCOORD4;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 _CoverColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float Xhlslcc_UnusedX_SmoothnessScale;
          
          uniform float Xhlslcc_UnusedX_MetallicScale;
          
          uniform float Xhlslcc_UnusedX_EmissionScale;
          
          uniform float _AmbientClamp;
          
          uniform float4 Xhlslcc_UnusedX_MatcapColor;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 unity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 Xhlslcc_UnusedXunity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float3 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      bool4 u_xlatb1;
      
      float3 u_xlat2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_4;
      
      float u_xlat15;
      
      int u_xlati15;
      
      uint u_xlatu15;
      
      int u_xlatb15;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.normal.xyz * float3(0.00499999989, 0.00499999989, 0.00499999989) + in_v.vertex.xyz;
          
          u_xlat1.xyz = u_xlat0.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          out_v.texcoord.zw = u_xlat0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
          
          u_xlat0.xyz = u_xlat1.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat1 + unity_MatrixVP[3];
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat15 = max(u_xlat15, 1.17549435e-38);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat1.xyz = float3(u_xlat15) * u_xlat1.xyz;
          
          out_v.vs_NORMAL0.xyz = u_xlat1.xyz;
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          u_xlat2.xyz = in_v.tangent.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat2.xyz = unity_ObjectToWorld[0].xyz * in_v.tangent.xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_ObjectToWorld[2].xyz * in_v.tangent.zzz + u_xlat2.xyz;
          
          u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat15 = max(u_xlat15, 1.17549435e-38);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat2.xyz = float3(u_xlat15) * u_xlat2.xyz;
          
          out_v.texcoord1.xyz = u_xlat2.xyz;
          
          u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
          
          u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
          
          u_xlatb15 = unity_WorldTransformParams.w>=0.0;
          
          u_xlat15 = (u_xlatb15) ? 1.0 : -1.0;
          
          u_xlat16_4.x = u_xlat15 * in_v.tangent.w;
          
          u_xlat16_4.xyz = u_xlat1.xyz * u_xlat16_4.xxx;
          
          out_v.texcoord2.xyz = u_xlat16_4.xyz;
          
          u_xlat1.xyz = u_xlat0.xyz + (-_CascadeShadowSplitSpheres0.xyz);
          
          u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat2.xyz = u_xlat0.xyz + (-_CascadeShadowSplitSpheres1.xyz);
          
          u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat2.xyz = u_xlat0.xyz + (-_CascadeShadowSplitSpheres2.xyz);
          
          u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat2.xyz = u_xlat0.xyz + (-_CascadeShadowSplitSpheres3.xyz);
          
          u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlatb1 = lessThan(u_xlat1, _CascadeShadowSplitSphereRadii);
          
          u_xlat16_4.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
          
          u_xlat16_4.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
          
          u_xlat16_4.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
          
          u_xlat16_1.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
          
          u_xlat16_1.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
          
          u_xlat16_1.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
          
          u_xlat16_1.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_1.yzw;
          
          u_xlat16_1.yzw = max(u_xlat16_4.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_4.x = dot(u_xlat16_1, float4(4.0, 3.0, 2.0, 1.0));
          
          u_xlat16_4.x = (-u_xlat16_4.x) + 4.0;
          
          u_xlatu15 = uint(u_xlat16_4.x);
          
          u_xlati15 = int(int(u_xlatu15) << (2 & int(0x1F)));
          
          u_xlat2.xyz = u_xlat0.yyy * _MainLightWorldToShadow[(u_xlati15 + 1)].xyz;
          
          u_xlat2.xyz = _MainLightWorldToShadow[u_xlati15].xyz * u_xlat0.xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = _MainLightWorldToShadow[(u_xlati15 + 2)].xyz * u_xlat0.zzz + u_xlat2.xyz;
          
          out_v.texcoord3.xyz = u_xlat2.xyz + _MainLightWorldToShadow[(u_xlati15 + 3)].xyz;
          
          out_v.texcoord5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
          
          out_v.texcoord3.w = 0.0;
          
          u_xlat16_4.x = (-_AmbientClamp) + 1.0;
          
          u_xlat16_4.xyz = min(u_xlat16_4.xxx, float3(0.0, 0.0, 0.0));
          
          out_v.texcoord4.xyz = u_xlat16_4.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 _CoverColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float Xhlslcc_UnusedX_SmoothnessScale;
          
          uniform float Xhlslcc_UnusedX_MetallicScale;
          
          uniform float Xhlslcc_UnusedX_EmissionScale;
          
          uniform float _AmbientClamp;
          
          uniform float4 Xhlslcc_UnusedX_MatcapColor;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float3 u_xlat0_d;
      
      float u_xlat16_0;
      
      int u_xlatb0;
      
      float3 u_xlat16_1_d;
      
      float3 u_xlat2_d;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      int u_xlatb4;
      
      float u_xlat12;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          float3 txVec0 = float3(in_f.texcoord3.xy,in_f.texcoord3.z);
          
          u_xlat16_0 = textureLod(hlslcc_zcmp_MainLightShadowmapTexture, txVec0, 0.0);
          
          u_xlat16_1_d.x = (-_MainLightShadowParams.x) + 1.0;
          
          u_xlat16_1_d.x = u_xlat16_0 * _MainLightShadowParams.x + u_xlat16_1_d.x;
          
          u_xlatb0 = 0.0>=in_f.texcoord3.z;
          
          u_xlatb4 = in_f.texcoord3.z>=1.0;
          
          u_xlatb0 = u_xlatb4 || u_xlatb0;
          
          u_xlat16_1_d.x = (u_xlatb0) ? 1.0 : u_xlat16_1_d.x;
          
          u_xlat16_1_d.xyz = u_xlat16_1_d.xxx * _MainLightColor.xyz;
          
          u_xlat16_0 = texture(_DetailMap, in_f.texcoord.xy, _GlobalMipBias.x).w;
          
          u_xlat0_d.xyz = float3(u_xlat16_0) * u_xlat16_1_d.xyz;
          
          u_xlat16_2.xyz = texture(_BumpMap, in_f.texcoord.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1_d.xyz = u_xlat16_2.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat2_d.xyz = u_xlat16_1_d.yyy * in_f.texcoord2.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1_d.xxx * in_f.texcoord1.xyz + u_xlat2_d.xyz;
          
          u_xlat2_d.xyz = u_xlat16_1_d.zzz * in_f.vs_NORMAL0.xyz + u_xlat2_d.xyz;
          
          u_xlat12 = dot(u_xlat2_d.xyz, u_xlat2_d.xyz);
          
          u_xlat12 = inversesqrt(u_xlat12);
          
          u_xlat2_d.xyz = float3(u_xlat12) * u_xlat2_d.xyz;
          
          u_xlat12 = dot(u_xlat2_d.xyz, _MainLightPosition.xyz);
          
          u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * float3(u_xlat12) + in_f.texcoord4.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * _BaseColor.xyz;
          
          u_xlat16_1_d.xyz = min(u_xlat0_d.xyz, float3(65504.0, 65504.0, 65504.0));
          
          u_xlat16_3.xyz = (-u_xlat16_1_d.xyz) + _CoverColor.xyz;
          
          out_f.color.xyz = _CoverColor.www * u_xlat16_3.xyz + u_xlat16_1_d.xyz;
          
          u_xlat16_0 = texture(_BaseMap, in_f.texcoord.zw, _GlobalMipBias.x).w;
          
          out_f.color.w = u_xlat16_0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "SHADOWCASTER"
        "QUEUE" = "Geometry+2"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      LOD 500
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float3 _LightDirection;
      
      uniform float4 _ShadowBias;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 SV_TARGET0 : SV_TARGET0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 Xhlslcc_UnusedXunity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          u_xlat0.xyz = _LightDirection.xyz * _ShadowBias.xxx + u_xlat0.xyz;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat6 = max(u_xlat6, 1.17549435e-38);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat1.xyz = float3(u_xlat6) * u_xlat1.xyz;
          
          u_xlat6 = dot(_LightDirection.xyz, u_xlat1.xyz);
          
          u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
          
          u_xlat6 = (-u_xlat6) + 1.0;
          
          u_xlat6 = u_xlat6 * _ShadowBias.y;
          
          u_xlat0.xyz = u_xlat1.xyz * float3(u_xlat6) + u_xlat0.xyz;
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          u_xlat0 = u_xlat0 + unity_MatrixVP[3];
          
          out_v.vertex.z = max((-u_xlat0.w), u_xlat0.z);
          
          out_v.vertex.xyw = u_xlat0.xyw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.SV_TARGET0 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: DepthOnly
    {
      Name "DepthOnly"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "DepthOnly"
        "QUEUE" = "Geometry+2"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
      }
      LOD 500
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 SV_TARGET0 : SV_TARGET0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 Xhlslcc_UnusedXunity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 Xhlslcc_UnusedXunity_LightData;
          
          uniform float4 Xhlslcc_UnusedXunity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHAb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBr;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBg;
          
          uniform float4 Xhlslcc_UnusedXunity_SHBb;
          
          uniform float4 Xhlslcc_UnusedXunity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
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
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.SV_TARGET0 = float4(1.0, 1.0, 1.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
