// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "Universal Render Pipeline/Simple Lit"
{
  Properties
  {
    _BaseMap ("Base Map (RGB) Smoothness / Alpha (A)", 2D) = "white" {}
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _Cutoff ("Alpha Clipping", Range(0, 1)) = 0.5
    _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,0.5)
    _SpecGlossMap ("Specular Map", 2D) = "white" {}
    _SmoothnessSource ("Smoothness Source", float) = 0
    _SpecularHighlights ("Specular Highlights", float) = 1
    [HideInInspector] _BumpScale ("Scale", float) = 1
    [NoScaleOffset] _BumpMap ("Normal Map", 2D) = "bump" {}
    [HDR] _EmissionColor ("Emission Color", Color) = (0,0,0,1)
    [NoScaleOffset] _EmissionMap ("Emission Map", 2D) = "white" {}
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
    [HideInInspector] _Shininess ("Smoothness", float) = 0
    [HideInInspector] _GlossinessSource ("GlossinessSource", float) = 0
    [HideInInspector] _SpecSource ("SpecularHighlights", float) = 0
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
      "UniversalMaterialType" = "SimpleLit"
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
        "UniversalMaterialType" = "SimpleLit"
      }
      LOD 300
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile _Surface unity_SHAg
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
      
      uniform float4 _MainLightShadowParams;
      
      uniform float4 _AdditionalShadowFadeParams;
      
      uniform float4 _AdditionalShadowParams[16];
      
      uniform float4 _AdditionalLightsWorldToShadow[64];
      
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
          
          float3 texcoord7 : TEXCOORD7;
          
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
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 Xhlslcc_UnusedX_EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
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
          
          u_xlat1.xyz = float3(u_xlat6) * u_xlat1.xyz;
          
          u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat1.xyz = float3(u_xlat6) * u_xlat1.xyz;
          
          out_v.texcoord2.xyz = u_xlat1.xyz;
          
          out_v.texcoord5 = 0.0;
          
          u_xlat1.xyz = u_xlat0.yyy * _MainLightWorldToShadow[1].xyz;
          
          u_xlat1.xyz = _MainLightWorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = _MainLightWorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
          
          out_v.texcoord6.xyz = u_xlat1.xyz + _MainLightWorldToShadow[3].xyz;
          
          out_v.texcoord6.w = 0.0;
          
          out_v.texcoord7.xyz = float3(0.0, 0.0, 0.0);
          
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
          
          uniform float4 _BaseColor;
          
          uniform float4 Xhlslcc_UnusedX_SpecColor;
          
          uniform float4 Xhlslcc_UnusedX_EmissionColor;
          
          uniform float Xhlslcc_UnusedX_Cutoff;
          
          uniform float _Surface;
          
          #if HLSLCC_ENABLE_UNIFORM_BUFFERS
      };
      
      float4 u_xlat16_0;
      
      float4 u_xlat1_d;
      
      int u_xlatb1;
      
      float3 u_xlat16_2;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat5;
      
      uint u_xlatu5;
      
      int u_xlatb5;
      
      float3 u_xlat6_d;
      
      float4 u_xlat7;
      
      bool3 u_xlatb7;
      
      float u_xlat8;
      
      bool3 u_xlatb8;
      
      float3 u_xlat16_9;
      
      uint u_xlatu15;
      
      float3 u_xlat17;
      
      float u_xlat25;
      
      int u_xlati25;
      
      uint u_xlatu25;
      
      int u_xlatb25;
      
      float u_xlat27;
      
      float u_xlat31;
      
      float u_xlat16_31;
      
      int u_xlatb31;
      
      float u_xlat16_32;
      
      float u_xlat16_33;
      
      float u_xlat35;
      
      int u_xlati35;
      
      float u_xlat36;
      
      float u_xlat16_36;
      
      int u_xlati36;
      
      int u_xlatb36;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          ImmCB_0[0] = float4(1.0,0.0,0.0,0.0);
          
          ImmCB_0[1] = float4(0.0,1.0,0.0,0.0);
          
          ImmCB_0[2] = float4(0.0,0.0,1.0,0.0);
          
          ImmCB_0[3] = float4(0.0,0.0,0.0,1.0);
          
          u_xlat16_0 = texture(_BaseMap, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_0 = u_xlat16_0.wxyz * _BaseColor.wxyz;
          
          u_xlat1_d.x = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat1_d.x = inversesqrt(u_xlat1_d.x);
          
          u_xlat1_d.xyz = u_xlat1_d.xxx * in_f.texcoord2.xyz;
          
          u_xlat1_d.w = 1.0;
          
          u_xlat16_2.x = dot(unity_SHAr, u_xlat1_d);
          
          u_xlat16_2.y = dot(unity_SHAg, u_xlat1_d);
          
          u_xlat16_2.z = dot(unity_SHAb, u_xlat1_d);
          
          u_xlat16_3 = u_xlat1_d.yzzx * u_xlat1_d.xyzz;
          
          u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
          
          u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
          
          u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
          
          u_xlat16_32 = u_xlat1_d.y * u_xlat1_d.y;
          
          u_xlat16_32 = u_xlat1_d.x * u_xlat1_d.x + (-u_xlat16_32);
          
          u_xlat16_3.xyz = unity_SHC.xyz * float3(u_xlat16_32) + u_xlat16_4.xyz;
          
          u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
          
          u_xlat16_2.xyz = max(u_xlat16_2.xyz, float3(0.0, 0.0, 0.0));
          
          float3 txVec0 = float3(in_f.texcoord6.xy,in_f.texcoord6.z);
          
          u_xlat16_31 = textureLod(hlslcc_zcmp_MainLightShadowmapTexture, txVec0, 0.0);
          
          u_xlat16_32 = (-_MainLightShadowParams.x) + 1.0;
          
          u_xlat16_32 = u_xlat16_31 * _MainLightShadowParams.x + u_xlat16_32;
          
          u_xlatb31 = 0.0>=in_f.texcoord6.z;
          
          u_xlatb5 = in_f.texcoord6.z>=1.0;
          
          u_xlatb31 = u_xlatb31 || u_xlatb5;
          
          u_xlat16_32 = (u_xlatb31) ? 1.0 : u_xlat16_32;
          
          u_xlat5.xyz = in_f.texcoord1.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
          
          u_xlat5.x = u_xlat31 * _MainLightShadowParams.z + _MainLightShadowParams.w;
          
          u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
          
          u_xlat16_3.x = (-u_xlat16_32) + 1.0;
          
          u_xlat16_32 = u_xlat5.x * u_xlat16_3.x + u_xlat16_32;
          
          u_xlat5.x = u_xlat16_32 * unity_LightData.z;
          
          u_xlat5.xyz = u_xlat5.xxx * _MainLightColor.xyz;
          
          u_xlat16_32 = dot(u_xlat1_d.xyz, _MainLightPosition.xyz);
          
          u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
          
          u_xlat16_3.xyz = float3(u_xlat16_32) * u_xlat5.xyz;
          
          u_xlat16_3.xyz = u_xlat16_0.yzw * u_xlat16_3.xyz;
          
          u_xlat16_32 = min(_AdditionalLightsCount.x, unity_LightData.y);
          
          u_xlatu5 = uint(int(u_xlat16_32));
          
          u_xlat31 = u_xlat31 * _AdditionalShadowFadeParams.x + _AdditionalShadowFadeParams.y;
          
          u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
          
          u_xlat16_4.x = float(0.0);
          
          u_xlat16_4.y = float(0.0);
          
          u_xlat16_4.z = float(0.0);
          
          for(uint u_xlatu_loop_1 = uint(0u) ; u_xlatu_loop_1<u_xlatu5 ; u_xlatu_loop_1++)
      
          
              {
              
              u_xlatu25 = uint(u_xlatu_loop_1 >> (2u & uint(0x1F)));
              
              u_xlati35 = int(uint(u_xlatu_loop_1 & 3u));
              
              u_xlat25 = dot(unity_LightIndices[int(u_xlatu25)], ImmCB_0[u_xlati35]);
              
              u_xlati25 = int(u_xlat25);
              
              u_xlat6_d.xyz = (-in_f.texcoord1.xyz) * _AdditionalLightsPosition[u_xlati25].www + _AdditionalLightsPosition[u_xlati25].xyz;
              
              u_xlat35 = dot(u_xlat6_d.xyz, u_xlat6_d.xyz);
              
              u_xlat35 = max(u_xlat35, 6.10351562e-05);
              
              u_xlat36 = inversesqrt(u_xlat35);
              
              u_xlat6_d.xyz = float3(u_xlat36) * u_xlat6_d.xyz;
              
              u_xlat36 = float(1.0) / float(u_xlat35);
              
              u_xlat35 = u_xlat35 * _AdditionalLightsAttenuation[u_xlati25].x;
              
              u_xlat16_32 = (-u_xlat35) * u_xlat35 + 1.0;
              
              u_xlat16_32 = max(u_xlat16_32, 0.0);
              
              u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
              
              u_xlat35 = u_xlat16_32 * u_xlat36;
              
              u_xlat16_32 = dot(_AdditionalLightsSpotDir[u_xlati25].xyz, u_xlat6_d.xyz);
              
              u_xlat16_32 = u_xlat16_32 * _AdditionalLightsAttenuation[u_xlati25].z + _AdditionalLightsAttenuation[u_xlati25].w;
              
              u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
              
              u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
              
              u_xlat35 = u_xlat16_32 * u_xlat35;
              
              u_xlati36 = int(_AdditionalShadowParams[u_xlati25].w);
              
              u_xlatb7.x = u_xlati36>=0;
              
              if(u_xlatb7.x)
      {
                  
                  u_xlatb7.x = float4(0.0, 0.0, 0.0, 0.0)!=float4(_AdditionalShadowParams[u_xlati25].z);
                  
                  if(u_xlatb7.x)
      {
                      
                      u_xlatb7.xyz = greaterThanEqual(abs(u_xlat6_d.zzyz), abs(u_xlat6_d.xyxx)).xyz;
                      
                      u_xlatb7.x = u_xlatb7.y && u_xlatb7.x;
                      
                      u_xlatb8.xyz = lessThan((-u_xlat6_d.zyxz), float4(0.0, 0.0, 0.0, 0.0)).xyz;
                      
                      u_xlat17.x = (u_xlatb8.x) ? float(5.0) : float(4.0);
                      
                      u_xlat17.z = (u_xlatb8.y) ? float(3.0) : float(2.0);
                      
                      u_xlat8 = u_xlatb8.z ? 1.0 : float(0.0);
                      
                      u_xlat27 = (u_xlatb7.z) ? u_xlat17.z : u_xlat8;
                      
                      u_xlat7.x = (u_xlatb7.x) ? u_xlat17.x : u_xlat27;
                      
                      u_xlat17.x = trunc(_AdditionalShadowParams[u_xlati25].w);
                      
                      u_xlat7.x = u_xlat7.x + u_xlat17.x;
                      
                      u_xlati36 = int(u_xlat7.x);
      
      }
                  
                  u_xlati36 = int(u_xlati36 << (2 & int(0x1F)));
                  
                  u_xlat7 = in_f.texcoord1.yyyy * _AdditionalLightsWorldToShadow[(u_xlati36 + 1)];
                  
                  u_xlat7 = _AdditionalLightsWorldToShadow[u_xlati36] * in_f.texcoord1.xxxx + u_xlat7;
                  
                  u_xlat7 = _AdditionalLightsWorldToShadow[(u_xlati36 + 2)] * in_f.texcoord1.zzzz + u_xlat7;
                  
                  u_xlat7 = u_xlat7 + _AdditionalLightsWorldToShadow[(u_xlati36 + 3)];
                  
                  u_xlat7.xyz = u_xlat7.xyz / u_xlat7.www;
                  
                  float3 txVec1 = float3(u_xlat7.xy,u_xlat7.z);
                  
                  u_xlat16_36 = textureLod(hlslcc_zcmp_AdditionalLightsShadowmapTexture, txVec1, 0.0);
                  
                  u_xlat16_32 = 1.0 + (-_AdditionalShadowParams[u_xlati25].x);
                  
                  u_xlat16_32 = u_xlat16_36 * _AdditionalShadowParams[u_xlati25].x + u_xlat16_32;
                  
                  u_xlatb36 = 0.0>=u_xlat7.z;
                  
                  u_xlatb7.x = u_xlat7.z>=1.0;
                  
                  u_xlatb36 = u_xlatb36 || u_xlatb7.x;
                  
                  u_xlat16_32 = (u_xlatb36) ? 1.0 : u_xlat16_32;
      
      }
              else
              
                  {
                  
                  u_xlat16_32 = 1.0;
      
      }
              
              u_xlat16_33 = (-u_xlat16_32) + 1.0;
              
              u_xlat16_32 = u_xlat31 * u_xlat16_33 + u_xlat16_32;
              
              u_xlat35 = u_xlat16_32 * u_xlat35;
              
              u_xlat7.xyz = float3(u_xlat35) * _AdditionalLightsColor[u_xlati25].xyz;
              
              u_xlat16_32 = dot(u_xlat1_d.xyz, u_xlat6_d.xyz);
              
              u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
              
              u_xlat16_9.xyz = float3(u_xlat16_32) * u_xlat7.xyz;
              
              u_xlat16_4.xyz = u_xlat16_9.xyz * u_xlat16_0.yzw + u_xlat16_4.xyz;
      
      }
          
          u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.yzw + u_xlat16_3.xyz;
          
          out_f.color.xyz = u_xlat16_4.xyz + u_xlat16_2.xyz;
          
          u_xlatb1 = _Surface==1.0;
          
          out_f.color.w = (u_xlatb1) ? u_xlat16_0.x : 1.0;
          
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
        "UniversalMaterialType" = "SimpleLit"
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
        "UniversalMaterialType" = "SimpleLit"
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
        "UniversalMaterialType" = "SimpleLit"
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
          
          float3 texcoord3 : TEXCOORD3;
          
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
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.texcoord2.xyz = u_xlat0.xyz;
          
          out_v.texcoord3.xyz = float3(0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat16_0;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = dot(in_f.texcoord2.xyz, in_f.texcoord2.xyz);
          
          u_xlat16_0 = inversesqrt(u_xlat16_0);
          
          out_f.color.xyz = float3(u_xlat16_0) * in_f.texcoord2.xyz;
          
          out_f.color.w = 0.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
