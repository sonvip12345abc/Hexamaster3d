// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "FQDev/CubeCrystal"
{
  Properties
  {
    _MainTex ("Albedo (RGB)", 2D) = "white" {}
    _AOTex ("AO Tex", 2D) = "black" {}
    _ReflectTex ("Reflect Tex", 2D) = "black" {}
    _Smoothness ("Smoothness", Range(0, 1)) = 0.3
    _SpecularClamp ("Specular Clamp", Range(0, 1)) = 0.6
  }
  SubShader
  {
    Tags
    { 
      "FORCENOSHADOWCASTING" = "true"
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "FORCENOSHADOWCASTING" = "true"
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
        "SHADOWSUPPORT" = "true"
      }
      LOD 200
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_SHAr;
      
      uniform float4 unity_SHAg;
      
      uniform float4 unity_SHAb;
      
      uniform float4 unity_SHBr;
      
      uniform float4 unity_SHBg;
      
      uniform float4 unity_SHBb;
      
      uniform float4 unity_SHC;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float _Smoothness;
      
      uniform float _SpecularClamp;
      
      uniform float4 _LightColor0;
      
      uniform float _LambertCut;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _AOTex;
      
      uniform sampler2D _ReflectTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float3 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float u_xlat12;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat12 = inversesqrt(u_xlat12);
          
          u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
          
          u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
          
          u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
          
          u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
          
          u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
          
          u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
          
          u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
          
          u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
          
          out_v.texcoord2.xyz = u_xlat0.xyz;
          
          u_xlat0.w = 1.0;
          
          u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
          
          u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
          
          u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
          
          u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
          
          out_v.texcoord1.xyz = max(u_xlat16_2.xyz, float3(0.0, 0.0, 0.0));
          
          out_v.texcoord1.w = 0.0;
          
          u_xlat0.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat0.xyz;
          
          out_v.texcoord3.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat16_0;
      
      float3 u_xlat1_d;
      
      float4 u_xlat16_1_d;
      
      float3 u_xlat2;
      
      float3 u_xlat16_2_d;
      
      float3 u_xlat16_3_d;
      
      float u_xlat4;
      
      float u_xlat10;
      
      float u_xlat16_10;
      
      float u_xlat11;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = dot((-_WorldSpaceLightPos0.xyz), (-_WorldSpaceLightPos0.xyz));
          
          u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
          
          u_xlat16_0.xyz = u_xlat16_0.xxx * (-_WorldSpaceLightPos0.xyz);
          
          u_xlat1_d.x = dot(u_xlat16_0.xyz, in_f.texcoord2.xyz);
          
          u_xlat1_d.x = u_xlat1_d.x + u_xlat1_d.x;
          
          u_xlat1_d.xyz = in_f.texcoord2.xyz * (-u_xlat1_d.xxx) + u_xlat16_0.xyz;
          
          u_xlat10 = dot(in_f.texcoord2.xyz, (-u_xlat16_0.xyz));
          
          u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
          
          u_xlat2.xyz = (-in_f.texcoord3.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat11 = inversesqrt(u_xlat11);
          
          u_xlat2.xyz = float3(u_xlat11) * u_xlat2.xyz;
          
          u_xlat1_d.x = dot(u_xlat2.xyz, u_xlat1_d.xyz);
          
          u_xlat4 = dot(in_f.texcoord2.xyz, u_xlat2.xyz);
          
          u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
          
          u_xlat4 = (-u_xlat4) + 1.0;
          
          u_xlat16_0.x = u_xlat4 * u_xlat4;
          
          u_xlat1_d.x = max(u_xlat1_d.x, 0.0);
          
          u_xlat16_0.y = log2(u_xlat1_d.x);
          
          u_xlat16_0.z = _Smoothness * 250.0 + 4.0;
          
          u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_0.xz;
          
          u_xlat16_3_d.x = exp2(u_xlat16_0.y);
          
          u_xlat16_0.x = u_xlat16_0.x * 0.699999988 + u_xlat16_3_d.x;
          
          u_xlat16_0.x = min(u_xlat16_0.x, _SpecularClamp);
          
          u_xlat16_3_d.x = (-_LambertCut) + 1.0;
          
          u_xlat16_3_d.x = u_xlat16_3_d.x * u_xlat10 + _LambertCut;
          
          u_xlat16_1_d = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat1_d.xyz = u_xlat16_1_d.xyz * _LightColor0.xyz;
          
          out_f.color.w = max(u_xlat16_0.x, u_xlat16_1_d.w);
          
          u_xlat1_d.xyz = u_xlat1_d.xyz * u_xlat16_3_d.xxx + in_f.texcoord1.xyz;
          
          u_xlat16_3_d.xy = in_f.texcoord2.xy + float2(1.0, 1.0);
          
          u_xlat16_3_d.xy = u_xlat16_3_d.xy * float2(0.5, 0.5);
          
          u_xlat16_2_d.xyz = texture(_ReflectTex, u_xlat16_3_d.xy).xyz;
          
          u_xlat16_10 = texture(_AOTex, in_f.texcoord.xy).x;
          
          u_xlat16_3_d.x = (-u_xlat16_10) + 1.0;
          
          u_xlat16_3_d.xyz = u_xlat16_2_d.xyz * u_xlat16_3_d.xxx + (-u_xlat1_d.xyz);
          
          out_f.color.xyz = u_xlat16_0.xxx * u_xlat16_3_d.xyz + u_xlat1_d.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
