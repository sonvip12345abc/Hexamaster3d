// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "Universal Render Pipeline/Lit"
{
  Properties
  {
    _WorkflowMode ("WorkflowMode", float) = 1
    _BaseMap ("Albedo", 2D) = "white" {}
    _BaseColor ("Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    _SmoothnessTextureChannel ("Smoothness texture channel", float) = 0
    _Metallic ("Metallic", Range(0, 1)) = 0
    _MetallicGlossMap ("Metallic", 2D) = "white" {}
    _SpecColor ("Specular", Color) = (0.2,0.2,0.2,1)
    _SpecGlossMap ("Specular", 2D) = "white" {}
    [ToggleOff] _SpecularHighlights ("Specular Highlights", float) = 1
    [ToggleOff] _EnvironmentReflections ("Environment Reflections", float) = 1
    _BumpScale ("Scale", float) = 1
    _BumpMap ("Normal Map", 2D) = "bump" {}
    _Parallax ("Scale", Range(0.005, 0.08)) = 0.005
    _ParallaxMap ("Height Map", 2D) = "black" {}
    _OcclusionStrength ("Strength", Range(0, 1)) = 1
    _OcclusionMap ("Occlusion", 2D) = "white" {}
    [HDR] _EmissionColor ("Color", Color) = (0,0,0,1)
    _EmissionMap ("Emission", 2D) = "white" {}
    _DetailMask ("Detail Mask", 2D) = "white" {}
    _DetailAlbedoMapScale ("Scale", Range(0, 2)) = 1
    _DetailAlbedoMap ("Detail Albedo x2", 2D) = "linearGrey" {}
    _DetailNormalMapScale ("Scale", Range(0, 2)) = 1
    [Normal] _DetailNormalMap ("Normal Map", 2D) = "bump" {}
    [HideInInspector] _ClearCoatMask ("_ClearCoatMask", float) = 0
    [HideInInspector] _ClearCoatSmoothness ("_ClearCoatSmoothness", float) = 0
    _Surface ("__surface", float) = 0
    _Blend ("__blend", float) = 0
    _Cull ("__cull", float) = 2
    [ToggleUI] _AlphaClip ("__clip", float) = 0
    [HideInInspector] _SrcBlend ("__src", float) = 1
    [HideInInspector] _DstBlend ("__dst", float) = 0
    [HideInInspector] _SrcBlendAlpha ("__srcA", float) = 1
    [HideInInspector] _DstBlendAlpha ("__dstA", float) = 0
    [HideInInspector] _ZWrite ("__zw", float) = 1
    [HideInInspector] _BlendModePreserveSpecular ("_BlendModePreserveSpecular", float) = 1
    [HideInInspector] _AlphaToMask ("__alphaToMask", float) = 0
    [ToggleUI] _ReceiveShadows ("Receive Shadows", float) = 1
    _QueueOffset ("Queue offset", float) = 0
    [HideInInspector] _MainTex ("BaseMap", 2D) = "white" {}
    [HideInInspector] _Color ("Base Color", Color) = (1,1,1,1)
    [HideInInspector] _GlossMapScale ("Smoothness", float) = 0
    [HideInInspector] _Glossiness ("Smoothness", float) = 0
    [HideInInspector] _GlossyReflections ("EnvironmentReflections", float) = 0
    unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
    unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
    unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "RenderPipeline" = "UniversalPipeline"
      "RenderType" = "Opaque"
      "UniversalMaterialType" = "Lit"
    }
    LOD 300
    Pass // ind: 1, name: ForwardLit
    {
      Name "ForwardLit"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "UniversalForward"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "Lit"
      }
      LOD 300
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile _Smoothness unity_LightIndices
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainLightWorldToShadow[20];
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 _MainLightPosition;
      
      uniform float4 _MainLightColor;
      
      uniform float4 _AdditionalLightsCount;
      
      uniform float4 _AdditionalLightsPosition[16];
      
      uniform float4 _AdditionalLightsColor[16];
      
      uniform float4 _AdditionalLightsAttenuation[16];
      
      uniform float4 _AdditionalLightsSpotDir[16];
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_OrthoParams;
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 _MainLightShadowParams;
      
      uniform float4 _AdditionalShadowFadeParams;
      
      uniform float4 _AdditionalShadowParams[16];
      
      uniform float4 _AdditionalLightsWorldToShadow[64];
      
      uniform samplerCUBE unity_SpecCube0;
      
      uniform sampler2D _BaseMap;
      
      uniform sampler2D _MainLightShadowmapTexture;
      
      uniform sampler2D hlslcc_zcmp_MainLightShadowmapTexture;
      
      uniform sampler2D _AdditionalLightsShadowmapTexture;
      
      uniform sampler2D hlslcc_zcmp_AdditionalLightsShadowmapTexture;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord5 : TEXCOORD5;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord6 : TEXCOORD6;
          
          float3 texcoord8 : TEXCOORD8;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 texcoord6 : TEXCOORD6;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 unity_LightData;
          
          uniform float4 unity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 unity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 unity_SHAr;
          
          uniform float4 unity_SHAg;
          
          uniform float4 unity_SHAb;
          
          uniform float4 unity_SHBr;
          
          uniform float4 unity_SHBg;
          
          uniform float4 unity_SHBb;
          
          uniform float4 unity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 Xhlslcc_UnusedX_DetailAlbedoMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 Xhlslcc_UnusedX_EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float _Smoothness;
          
          uniform float _Metallic;
          
          uniform float Xhlslcc_UnusedX_BumpScale;
          
          uniform float Xhlslcc_UnusedX_Parallax;
          
          uniform float Xhlslcc_UnusedX_OcclusionStrength;
          
          uniform float Xhlslcc_UnusedX_ClearCoatMask;
          
          uniform float Xhlslcc_UnusedX_ClearCoatSmoothness;
          
          uniform float Xhlslcc_UnusedX_DetailAlbedoMapScale;
          
          uniform float Xhlslcc_UnusedX_DetailNormalMapScale;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.texcoord.xy = in_v.texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz + unity_ObjectToWorld[3].xyz;
          
          out_v.texcoord1.xyz = u_xlat0.xyz;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat6 = max(u_xlat6, 1.17549435e-38);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord2.xyz = float3(u_xlat6) * u_xlat1.xyz;
          
          out_v.texcoord5 = 0.0;
          
          u_xlat1.xyz = u_xlat0.yyy * _MainLightWorldToShadow[1].xyz;
          
          u_xlat1.xyz = _MainLightWorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = _MainLightWorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          out_v.texcoord6.xyz = u_xlat1.xyz + _MainLightWorldToShadow[3].xyz;
          
          out_v.texcoord6.w = 0.0;
          
          out_v.texcoord8.xyz = float3(0.0, 0.0, 0.0);
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat0 + unity_MatrixVP[3];
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 ImmCB_0[4];
      
      uniform UnityPerDraw 
          {
          
          #endif
          uniform float4 unity_ObjectToWorld[4];
          
          uniform float4 unity_WorldToObject[4];
          
          uniform float4 Xhlslcc_UnusedXunity_LODFade;
          
          uniform float4 Xhlslcc_UnusedXunity_WorldTransformParams;
          
          uniform float4 Xhlslcc_UnusedXunity_RenderingLayer;
          
          uniform float4 unity_LightData;
          
          uniform float4 unity_LightIndices[2];
          
          uniform float4 Xhlslcc_UnusedXunity_ProbesOcclusion;
          
          uniform float4 unity_SpecCube0_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_HDR;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube0_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMax;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_BoxMin;
          
          uniform float4 Xhlslcc_UnusedXunity_SpecCube1_ProbePosition;
          
          uniform float4 Xhlslcc_UnusedXunity_LightmapST;
          
          uniform float4 Xhlslcc_UnusedXunity_DynamicLightmapST;
          
          uniform float4 unity_SHAr;
          
          uniform float4 unity_SHAg;
          
          uniform float4 unity_SHAb;
          
          uniform float4 unity_SHBr;
          
          uniform float4 unity_SHBg;
          
          uniform float4 unity_SHBb;
          
          uniform float4 unity_SHC;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Min;
          
          uniform float4 Xhlslcc_UnusedXunity_RendererBounds_Max;
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousM[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MatrixPreviousMI[4];
          
          uniform float4 Xhlslcc_UnusedXunity_MotionVectorsParams;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      uniform UnityPerMaterial 
          {
          
          #endif
          uniform float4 _BaseMap_ST;
          
          uniform float4 Xhlslcc_UnusedX_DetailAlbedoMap_ST;
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 Xhlslcc_UnusedX_EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float _Smoothness;
          
          uniform float _Metallic;
          
          uniform float Xhlslcc_UnusedX_BumpScale;
          
          uniform float Xhlslcc_UnusedX_Parallax;
          
          uniform float Xhlslcc_UnusedX_OcclusionStrength;
          
          uniform float Xhlslcc_UnusedX_ClearCoatMask;
          
          uniform float Xhlslcc_UnusedX_ClearCoatSmoothness;
          
          uniform float Xhlslcc_UnusedX_DetailAlbedoMapScale;
          
          uniform float Xhlslcc_UnusedX_DetailNormalMapScale;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      int u_xlatb0;
      
      float4 u_xlat16_1;
      
      float4 u_xlat2;
      
      int u_xlatb2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float4 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float u_xlat16_7;
      
      float4 u_xlat8;
      
      float4 u_xlat16_8;
      
      float3 u_xlat16_9;
      
      float2 u_xlat16_10;
      
      float3 u_xlat11;
      
      float3 u_xlat12;
      
      float3 u_xlat13;
      
      bool3 u_xlatb13;
      
      float u_xlat14;
      
      bool3 u_xlatb14;
      
      float3 u_xlat16_15;
      
      float3 u_xlat16_16;
      
      float3 u_xlat17;
      
      uint u_xlatu17;
      
      int u_xlatb17;
      
      float3 u_xlat16_24;
      
      float3 u_xlat16_27;
      
      float3 u_xlat30;
      
      float u_xlat34;
      
      uint u_xlatu34;
      
      float u_xlat16_41;
      
      float u_xlat47;
      
      float u_xlat51;
      
      int u_xlati51;
      
      uint u_xlatu51;
      
      int u_xlatb51;
      
      float u_xlat53;
      
      int u_xlati53;
      
      float u_xlat16_54;
      
      float u_xlat16_55;
      
      float u_xlat16_56;
      
      float u_xlat16_57;
      
      float u_xlat16_58;
      
      float u_xlat62;
      
      float u_xlat63;
      
      float u_xlat16_63;
      
      int u_xlati63;
      
      int u_xlatb63;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          ImmCB_0[0] = float4(1.0,0.0,0.0,0.0);
          
          ImmCB_0[1] = float4(0.0,1.0,0.0,0.0);
          
          ImmCB_0[2] = float4(0.0,0.0,1.0,0.0);
          
          ImmCB_0[3] = float4(0.0,0.0,0.0,1.0);
          
          u_xlat16_0 = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_1 = u_xlat16_0 * _BaseColor;
          
          u_xlatb51 = unity_OrthoParams.w==0.0;
          
          u_xlat2.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat53 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat53 = inversesqrt(u_xlat53);
          
          u_xlat2.xyz = float3(u_xlat53) * u_xlat2.xyz;
          
          u_xlat16_3.x = (u_xlatb51) ? u_xlat2.x : unity_MatrixV[0].z;
          
          u_xlat16_3.y = (u_xlatb51) ? u_xlat2.y : unity_MatrixV[1].z;
          
          u_xlat16_3.z = (u_xlatb51) ? u_xlat2.z : unity_MatrixV[2].z;
          
          u_xlat51 = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat51 = inversesqrt(u_xlat51);
          
          u_xlat2.xyz = float3(u_xlat51) * in_f.texcoord2.xyz;
          
          u_xlat2.w = 1.0;
          
          u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
          
          u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
          
          u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
          
          u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
          
          u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
          
          u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
          
          u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
          
          u_xlat16_54 = u_xlat2.y * u_xlat2.y;
          
          u_xlat16_54 = u_xlat2.x * u_xlat2.x + (-u_xlat16_54);
          
          u_xlat16_5.xyz = unity_SHC.xyz * float3(u_xlat16_54) + u_xlat16_6.xyz;
          
          u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
          
          u_xlat16_4.xyz = max(u_xlat16_4.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_54 = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat16_55 = (-u_xlat16_54) + _Smoothness;
          
          u_xlat16_5.xyz = u_xlat16_1.xyz * float3(u_xlat16_54);
          
          u_xlat16_6.xyz = u_xlat16_0.xyz * _BaseColor.xyz + float3(-0.0399999991, -0.0399999991, -0.0399999991);
          
          u_xlat16_6.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
          
          u_xlat16_54 = (-_Smoothness) + 1.0;
          
          u_xlat16_56 = u_xlat16_54 * u_xlat16_54;
          
          u_xlat16_56 = max(u_xlat16_56, 0.0078125);
          
          u_xlat16_57 = u_xlat16_56 * u_xlat16_56;
          
          u_xlat16_55 = u_xlat16_55 + 1.0;
          
          u_xlat16_55 = clamp(u_xlat16_55, 0.0, 1.0);
          
          u_xlat16_7 = u_xlat16_56 * 4.0 + 2.0;
          
          float3 txVec0 = float3(in_f.texcoord6.xy,in_f.texcoord6.z);
          
          u_xlat16_0.x = textureLod(hlslcc_zcmp_MainLightShadowmapTexture, txVec0, 0.0);
          
          u_xlat16_24.x = (-_MainLightShadowParams.x) + 1.0;
          
          u_xlat16_24.x = u_xlat16_0.x * _MainLightShadowParams.x + u_xlat16_24.x;
          
          u_xlatb0 = 0.0>=in_f.texcoord6.z;
          
          u_xlatb17 = in_f.texcoord6.z>=1.0;
          
          u_xlatb0 = u_xlatb17 || u_xlatb0;
          
          u_xlat16_24.x = (u_xlatb0) ? 1.0 : u_xlat16_24.x;
          
          u_xlat0_d.xyz = in_f.texcoord1.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat0_d.x = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat17.x = u_xlat0_d.x * _MainLightShadowParams.z + _MainLightShadowParams.w;
          
          u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
          
          u_xlat16_41 = (-u_xlat16_24.x) + 1.0;
          
          u_xlat16_24.x = u_xlat17.x * u_xlat16_41 + u_xlat16_24.x;
          
          u_xlat16_41 = dot((-u_xlat16_3.xyz), u_xlat2.xyz);
          
          u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
          
          u_xlat16_8.xyz = u_xlat2.xyz * (-float3(u_xlat16_41)) + (-u_xlat16_3.xyz);
          
          u_xlat16_41 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
          
          u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
          
          u_xlat16_41 = (-u_xlat16_41) + 1.0;
          
          u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
          
          u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
          
          u_xlat16_58 = (-u_xlat16_54) * 0.699999988 + 1.70000005;
          
          u_xlat16_54 = u_xlat16_54 * u_xlat16_58;
          
          u_xlat16_54 = u_xlat16_54 * 6.0;
          
          u_xlat16_8 = textureLod(unity_SpecCube0, u_xlat16_8.xyz, u_xlat16_54);
          
          u_xlat16_54 = u_xlat16_8.w + -1.0;
          
          u_xlat16_54 = unity_SpecCube0_HDR.w * u_xlat16_54 + 1.0;
          
          u_xlat16_54 = max(u_xlat16_54, 0.0);
          
          u_xlat16_54 = log2(u_xlat16_54);
          
          u_xlat16_54 = u_xlat16_54 * unity_SpecCube0_HDR.y;
          
          u_xlat16_54 = exp2(u_xlat16_54);
          
          u_xlat16_54 = u_xlat16_54 * unity_SpecCube0_HDR.x;
          
          u_xlat16_9.xyz = u_xlat16_8.xyz * float3(u_xlat16_54);
          
          u_xlat16_10.xy = float2(u_xlat16_56) * float2(u_xlat16_56) + float2(-1.0, 1.0);
          
          u_xlat16_54 = float(1.0) / u_xlat16_10.y;
          
          u_xlat16_27.xyz = (-u_xlat16_6.xyz) + float3(u_xlat16_55);
          
          u_xlat16_27.xyz = float3(u_xlat16_41) * u_xlat16_27.xyz + u_xlat16_6.xyz;
          
          u_xlat17.xyz = float3(u_xlat16_54) * u_xlat16_27.xyz;
          
          u_xlat16_9.xyz = u_xlat17.xyz * u_xlat16_9.xyz;
          
          u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + u_xlat16_9.xyz;
          
          u_xlat17.x = u_xlat16_24.x * unity_LightData.z;
          
          u_xlat16_54 = dot(u_xlat2.xyz, _MainLightPosition.xyz);
          
          u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
          
          u_xlat16_54 = u_xlat17.x * u_xlat16_54;
          
          u_xlat16_24.xyz = float3(u_xlat16_54) * _MainLightColor.xyz;
          
          u_xlat17.xyz = u_xlat16_3.xyz + _MainLightPosition.xyz;
          
          u_xlat53 = dot(u_xlat17.xyz, u_xlat17.xyz);
          
          u_xlat53 = max(u_xlat53, 1.17549435e-38);
          
          u_xlat53 = inversesqrt(u_xlat53);
          
          u_xlat17.xyz = u_xlat17.xyz * float3(u_xlat53);
          
          u_xlat53 = dot(u_xlat2.xyz, u_xlat17.xyz);
          
          u_xlat53 = clamp(u_xlat53, 0.0, 1.0);
          
          u_xlat17.x = dot(_MainLightPosition.xyz, u_xlat17.xyz);
          
          u_xlat17.x = clamp(u_xlat17.x, 0.0, 1.0);
          
          u_xlat34 = u_xlat53 * u_xlat53;
          
          u_xlat34 = u_xlat34 * u_xlat16_10.x + 1.00001001;
          
          u_xlat16_54 = u_xlat17.x * u_xlat17.x;
          
          u_xlat17.x = u_xlat34 * u_xlat34;
          
          u_xlat34 = max(u_xlat16_54, 0.100000001);
          
          u_xlat17.x = u_xlat34 * u_xlat17.x;
          
          u_xlat17.x = u_xlat16_7 * u_xlat17.x;
          
          u_xlat17.x = u_xlat16_57 / u_xlat17.x;
          
          u_xlat16_54 = u_xlat17.x + -6.10351562e-05;
          
          u_xlat16_54 = max(u_xlat16_54, 0.0);
          
          u_xlat16_54 = min(u_xlat16_54, 1000.0);
          
          u_xlat16_9.xyz = u_xlat16_6.xyz * float3(u_xlat16_54) + u_xlat16_5.xyz;
          
          u_xlat16_54 = min(_AdditionalLightsCount.x, unity_LightData.y);
          
          u_xlatu17 = uint(int(u_xlat16_54));
          
          u_xlat0_d.x = u_xlat0_d.x * _AdditionalShadowFadeParams.x + _AdditionalShadowFadeParams.y;
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat16_27.x = float(0.0);
          
          u_xlat16_27.y = float(0.0);
          
          u_xlat16_27.z = float(0.0);
          
          for(uint u_xlatu_loop_1 = uint(0u) ; u_xlatu_loop_1<u_xlatu17 ; u_xlatu_loop_1++)
      
          
              {
              
              u_xlatu51 = uint(u_xlatu_loop_1 >> (2u & uint(0x1F)));
              
              u_xlati53 = int(uint(u_xlatu_loop_1 & 3u));
              
              u_xlat51 = dot(unity_LightIndices[int(u_xlatu51)], ImmCB_0[u_xlati53]);
              
              u_xlati51 = int(u_xlat51);
              
              u_xlat11.xyz = (-in_f.texcoord1.xyz) * _AdditionalLightsPosition[u_xlati51].www + _AdditionalLightsPosition[u_xlati51].xyz;
              
              u_xlat53 = dot(u_xlat11.xyz, u_xlat11.xyz);
              
              u_xlat53 = max(u_xlat53, 6.10351562e-05);
              
              u_xlat62 = inversesqrt(u_xlat53);
              
              u_xlat12.xyz = float3(u_xlat62) * u_xlat11.xyz;
              
              u_xlat63 = float(1.0) / float(u_xlat53);
              
              u_xlat53 = u_xlat53 * _AdditionalLightsAttenuation[u_xlati51].x;
              
              u_xlat16_54 = (-u_xlat53) * u_xlat53 + 1.0;
              
              u_xlat16_54 = max(u_xlat16_54, 0.0);
              
              u_xlat16_54 = u_xlat16_54 * u_xlat16_54;
              
              u_xlat53 = u_xlat16_54 * u_xlat63;
              
              u_xlat16_54 = dot(_AdditionalLightsSpotDir[u_xlati51].xyz, u_xlat12.xyz);
              
              u_xlat16_54 = u_xlat16_54 * _AdditionalLightsAttenuation[u_xlati51].z + _AdditionalLightsAttenuation[u_xlati51].w;
              
              u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
              
              u_xlat16_54 = u_xlat16_54 * u_xlat16_54;
              
              u_xlat53 = u_xlat53 * u_xlat16_54;
              
              u_xlati63 = int(_AdditionalShadowParams[u_xlati51].w);
              
              u_xlatb13.x = u_xlati63>=0;
              
              if(u_xlatb13.x)
      {
                  
                  u_xlatb13.x = float4(0.0, 0.0, 0.0, 0.0)!=float4(_AdditionalShadowParams[u_xlati51].z);
                  
                  if(u_xlatb13.x)
      {
                      
                      u_xlatb13.xyz = greaterThanEqual(abs(u_xlat12.zzyz), abs(u_xlat12.xyxx)).xyz;
                      
                      u_xlatb13.x = u_xlatb13.y && u_xlatb13.x;
                      
                      u_xlatb14.xyz = lessThan((-u_xlat12.zyxz), float4(0.0, 0.0, 0.0, 0.0)).xyz;
                      
                      u_xlat30.x = (u_xlatb14.x) ? float(5.0) : float(4.0);
                      
                      u_xlat30.z = (u_xlatb14.y) ? float(3.0) : float(2.0);
                      
                      u_xlat14 = u_xlatb14.z ? 1.0 : float(0.0);
                      
                      u_xlat47 = (u_xlatb13.z) ? u_xlat30.z : u_xlat14;
                      
                      u_xlat13.x = (u_xlatb13.x) ? u_xlat30.x : u_xlat47;
                      
                      u_xlat30.x = trunc(_AdditionalShadowParams[u_xlati51].w);
                      
                      u_xlat13.x = u_xlat13.x + u_xlat30.x;
                      
                      u_xlati63 = int(u_xlat13.x);
      
      }
                  
                  u_xlati63 = int(u_xlati63 << (2 & int(0x1F)));
                  
                  u_xlat8 = in_f.texcoord1.yyyy * _AdditionalLightsWorldToShadow[(u_xlati63 + 1)];
                  
                  u_xlat8 = _AdditionalLightsWorldToShadow[u_xlati63] * in_f.texcoord1.xxxx + u_xlat8;
                  
                  u_xlat8 = _AdditionalLightsWorldToShadow[(u_xlati63 + 2)] * in_f.texcoord1.zzzz + u_xlat8;
                  
                  u_xlat8 = u_xlat8 + _AdditionalLightsWorldToShadow[(u_xlati63 + 3)];
                  
                  u_xlat13.xyz = u_xlat8.xyz / u_xlat8.www;
                  
                  float3 txVec1 = float3(u_xlat13.xy,u_xlat13.z);
                  
                  u_xlat16_63 = textureLod(hlslcc_zcmp_AdditionalLightsShadowmapTexture, txVec1, 0.0);
                  
                  u_xlat16_54 = 1.0 + (-_AdditionalShadowParams[u_xlati51].x);
                  
                  u_xlat16_54 = u_xlat16_63 * _AdditionalShadowParams[u_xlati51].x + u_xlat16_54;
                  
                  u_xlatb63 = 0.0>=u_xlat13.z;
                  
                  u_xlatb13.x = u_xlat13.z>=1.0;
                  
                  u_xlatb63 = u_xlatb63 || u_xlatb13.x;
                  
                  u_xlat16_54 = (u_xlatb63) ? 1.0 : u_xlat16_54;
      
      }
              else
              
                  {
                  
                  u_xlat16_54 = 1.0;
      
      }
              
              u_xlat16_55 = (-u_xlat16_54) + 1.0;
              
              u_xlat16_54 = u_xlat0_d.x * u_xlat16_55 + u_xlat16_54;
              
              u_xlat53 = u_xlat53 * u_xlat16_54;
              
              u_xlat16_54 = dot(u_xlat2.xyz, u_xlat12.xyz);
              
              u_xlat16_54 = clamp(u_xlat16_54, 0.0, 1.0);
              
              u_xlat16_54 = u_xlat53 * u_xlat16_54;
              
              u_xlat16_15.xyz = float3(u_xlat16_54) * _AdditionalLightsColor[u_xlati51].xyz;
              
              u_xlat11.xyz = u_xlat11.xyz * float3(u_xlat62) + u_xlat16_3.xyz;
              
              u_xlat51 = dot(u_xlat11.xyz, u_xlat11.xyz);
              
              u_xlat51 = max(u_xlat51, 1.17549435e-38);
              
              u_xlat51 = inversesqrt(u_xlat51);
              
              u_xlat11.xyz = float3(u_xlat51) * u_xlat11.xyz;
              
              u_xlat51 = dot(u_xlat2.xyz, u_xlat11.xyz);
              
              u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
              
              u_xlat53 = dot(u_xlat12.xyz, u_xlat11.xyz);
              
              u_xlat53 = clamp(u_xlat53, 0.0, 1.0);
              
              u_xlat51 = u_xlat51 * u_xlat51;
              
              u_xlat51 = u_xlat51 * u_xlat16_10.x + 1.00001001;
              
              u_xlat16_54 = u_xlat53 * u_xlat53;
              
              u_xlat51 = u_xlat51 * u_xlat51;
              
              u_xlat53 = max(u_xlat16_54, 0.100000001);
              
              u_xlat51 = u_xlat51 * u_xlat53;
              
              u_xlat51 = u_xlat16_7 * u_xlat51;
              
              u_xlat51 = u_xlat16_57 / u_xlat51;
              
              u_xlat16_54 = u_xlat51 + -6.10351562e-05;
              
              u_xlat16_54 = max(u_xlat16_54, 0.0);
              
              u_xlat16_54 = min(u_xlat16_54, 1000.0);
              
              u_xlat16_16.xyz = u_xlat16_6.xyz * float3(u_xlat16_54) + u_xlat16_5.xyz;
              
              u_xlat16_27.xyz = u_xlat16_16.xyz * u_xlat16_15.xyz + u_xlat16_27.xyz;
      
      }
          
          u_xlat16_3.xyz = u_xlat16_9.xyz * u_xlat16_24.xyz + u_xlat16_4.xyz;
          
          u_xlat16_1.xyz = u_xlat16_27.xyz + u_xlat16_3.xyz;
          
          u_xlat16_0 = min(u_xlat16_1, float4(65504.0, 65504.0, 65504.0, 65504.0));
          
          u_xlatb2 = _Surface==1.0;
          
          out_f.color.w = (u_xlatb2) ? u_xlat16_0.w : 1.0;
          
          out_f.color.xyz = u_xlat16_0.xyz;
          
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
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "Lit"
      }
      LOD 300
      Cull Off
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _ShadowBias;
      
      uniform float3 _LightDirection;
      
      
      
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
          
          out_v.vertex.z = max(u_xlat0.z, -1.0);
          
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
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "Lit"
      }
      LOD 300
      Cull Off
      ColorMask B
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
          
          float SV_TARGET0 : SV_TARGET0;
      
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
          
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
          
          out_f.SV_TARGET0 = hlslcc_FragCoord.z;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: DepthNormals
    {
      Name "DepthNormals"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "DepthNormals"
        "RenderPipeline" = "UniversalPipeline"
        "RenderType" = "Opaque"
        "UniversalMaterialType" = "Lit"
      }
      LOD 300
      Cull Off
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
          
          float3 normal : NORMAL0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord5 : TEXCOORD5;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord2 : TEXCOORD2;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
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
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = max(u_xlat6, 1.17549435e-38);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord2.xyz = u_xlat0.xyz;
          
          out_v.texcoord5.xyz = float3(0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat0_d.x = inversesqrt(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * in_f.texcoord2.xyz;
          
          out_f.color.xyz = u_xlat0_d.xyz;
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
