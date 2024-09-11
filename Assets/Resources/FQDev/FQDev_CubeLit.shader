// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "FQDev/CubeLit"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo (RGB)", 2D) = "white" {}
    _Smoothness ("Smoothness", Range(0, 1)) = 0.3
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 200
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_SHAr;
      
      uniform float4 unity_SHAg;
      
      uniform float4 unity_SHAb;
      
      uniform float4 unity_SHBr;
      
      uniform float4 unity_SHBg;
      
      uniform float4 unity_SHBb;
      
      uniform float4 unity_SHC;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_WorldTransformParams;
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightColor0;
      
      uniform float _Smoothness;
      
      uniform float4 _Color;
      
      uniform float _LambertCut;
      
      uniform float _SpecularClamp;
      
      uniform float _GIReduce;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 tangent : TANGENT0;
          
          float3 normal : NORMAL0;
          
          float4 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float3 texcoord4 : TEXCOORD4;
          
          float3 texcoord5 : TEXCOORD5;
          
          float4 texcoord7 : TEXCOORD7;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord3 : TEXCOORD3;
          
          float3 texcoord4 : TEXCOORD4;
          
          float3 texcoord5 : TEXCOORD5;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float4 u_xlat2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float u_xlat18;
      
      float u_xlat19;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
          
          u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.texcoord1.w = u_xlat0.x;
          
          u_xlat18 = in_v.tangent.w * unity_WorldTransformParams.w;
          
          u_xlat1.xyz = in_v.tangent.yyy * unity_ObjectToWorld[1].yzx;
          
          u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_v.tangent.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_v.tangent.zzz + u_xlat1.xyz;
          
          u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat19 = inversesqrt(u_xlat19);
          
          u_xlat1.xyz = float3(u_xlat19) * u_xlat1.xyz;
          
          u_xlat2.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat2.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat2.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
          
          u_xlat19 = inversesqrt(u_xlat19);
          
          u_xlat2 = float4(u_xlat19) * u_xlat2.xyzz;
          
          u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
          
          u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
          
          u_xlat3.xyz = float3(u_xlat18) * u_xlat3.xyz;
          
          out_v.texcoord1.y = u_xlat3.x;
          
          out_v.texcoord1.x = u_xlat1.z;
          
          out_v.texcoord1.z = u_xlat2.x;
          
          out_v.texcoord2.x = u_xlat1.x;
          
          out_v.texcoord3.x = u_xlat1.y;
          
          out_v.texcoord2.y = u_xlat3.y;
          
          out_v.texcoord3.y = u_xlat3.z;
          
          out_v.texcoord2.w = u_xlat0.y;
          
          out_v.texcoord2.z = u_xlat2.y;
          
          out_v.texcoord3.w = u_xlat0.z;
          
          out_v.texcoord4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
          
          out_v.texcoord3.z = u_xlat2.z;
          
          u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
          
          u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
          
          u_xlat16_0 = u_xlat2.yzwx * u_xlat2.xywz;
          
          u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
          
          u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
          
          u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
          
          u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
          
          u_xlat2.w = 1.0;
          
          u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
          
          u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
          
          u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
          
          out_v.texcoord5.xyz = max(u_xlat16_4.xyz, float3(0.0, 0.0, 0.0));
          
          out_v.texcoord7 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat16_1;
      
      float3 u_xlat2_d;
      
      float4 u_xlat16_2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4_d;
      
      float2 u_xlat16_5_d;
      
      float u_xlat6;
      
      float2 u_xlat16_7;
      
      float u_xlat12;
      
      float u_xlat16_13;
      
      float u_xlat18_d;
      
      float u_xlat16_19;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = in_f.texcoord1.z;
          
          u_xlat0_d.y = in_f.texcoord2.z;
          
          u_xlat0_d.z = in_f.texcoord3.z;
          
          u_xlat18_d = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat18_d = inversesqrt(u_xlat18_d);
          
          u_xlat0_d.xyz = float3(u_xlat18_d) * u_xlat0_d.xyz;
          
          u_xlat18_d = dot(in_f.texcoord4.xyz, in_f.texcoord4.xyz);
          
          u_xlat18_d = inversesqrt(u_xlat18_d);
          
          u_xlat16_1.xyz = in_f.texcoord4.xyz * float3(u_xlat18_d) + _WorldSpaceLightPos0.xyz;
          
          u_xlat2_d.xyz = float3(u_xlat18_d) * in_f.texcoord4.xyz;
          
          u_xlat18_d = dot(u_xlat0_d.xyz, u_xlat2_d.xyz);
          
          u_xlat16_19 = (-u_xlat18_d) + 1.0;
          
          u_xlat16_19 = (-u_xlat16_19) * u_xlat16_19 + 1.0;
          
          u_xlat16_19 = u_xlat16_19 * 1.70000005;
          
          u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
          
          u_xlat16_3.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
          
          u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
          
          u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xxx;
          
          u_xlat18_d = dot(u_xlat0_d.xyz, u_xlat16_1.xyz);
          
          u_xlat18_d = clamp(u_xlat18_d, 0.0, 1.0);
          
          u_xlat0_d.x = dot(u_xlat0_d.xyz, _WorldSpaceLightPos0.xyz);
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat16_1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
          
          u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
          
          u_xlat6 = u_xlat18_d * u_xlat18_d;
          
          u_xlat16_1.y = (-_Smoothness) + 1.0;
          
          u_xlat12 = u_xlat16_1.y * u_xlat16_1.y + -1.0;
          
          u_xlat6 = u_xlat6 * u_xlat12 + 1.00001001;
          
          u_xlat16_13 = u_xlat6 * u_xlat6;
          
          u_xlat6 = u_xlat16_1.x * u_xlat16_1.x;
          
          u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
          
          u_xlat6 = max(u_xlat6, 0.100000001);
          
          u_xlat6 = u_xlat6 * u_xlat16_13;
          
          u_xlat12 = u_xlat16_1.y * 4.0 + 2.0;
          
          u_xlat16_7.xy = u_xlat16_1.yx * u_xlat16_1.yx;
          
          u_xlat6 = u_xlat12 * u_xlat6;
          
          u_xlat6 = u_xlat16_7.x / u_xlat6;
          
          u_xlat16_7.x = u_xlat0_d.x * u_xlat6;
          
          u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
          
          u_xlat16_7.x = min(u_xlat16_7.x, _SpecularClamp);
          
          u_xlat16_13 = u_xlat16_7.y * u_xlat16_7.y;
          
          u_xlat16_1.x = u_xlat16_1.x * u_xlat16_13;
          
          u_xlat16_3.xyz = (-in_f.texcoord5.xyz) + float3(1.0, 1.0, 1.0);
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xxx + in_f.texcoord5.xyz;
          
          u_xlat16_1.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz;
          
          u_xlat16_2 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_19 = u_xlat16_19 * u_xlat16_2.w;
          
          u_xlat16_3.xyz = u_xlat16_2.xyz + (-_Color.xyz);
          
          u_xlat16_3.xyz = float3(u_xlat16_19) * u_xlat16_3.xyz + _Color.xyz;
          
          u_xlat16_4_d.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
          
          u_xlat16_3.xyz = u_xlat16_3.xyz * in_f.texcoord5.xyz;
          
          u_xlat16_5_d.xy = (-float2(_LambertCut, _GIReduce)) + float2(1.0, 1.0);
          
          u_xlat16_19 = u_xlat16_5_d.x * u_xlat0_d.x + _LambertCut;
          
          u_xlat16_1.xyz = u_xlat16_4_d.xyz * float3(u_xlat16_19) + u_xlat16_1.xyz;
          
          out_f.color.xyz = u_xlat16_3.xyz * u_xlat16_5_d.yyy + u_xlat16_1.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
