// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "FQDev/VertexColorSihouette"
{
  Properties
  {
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _RimColor ("Rim Color", Color) = (0,0,0,0)
    _RimPower ("Rim Power", Range(0.1, 8)) = 4
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
      }
      LOD 100
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
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _BaseColor;
      
      uniform float4 _RimColor;
      
      uniform float _RimPower;
      
      uniform float4 _LightColor0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float3 texcoord3 : TEXCOORD3;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float3 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
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
      
      float u_xlat13;
      
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
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat13 = inversesqrt(u_xlat13);
          
          out_v.texcoord.xyz = float3(u_xlat13) * u_xlat1.xyz;
          
          out_v.texcoord1.xyz = u_xlat0.xyz;
          
          out_v.texcoord2 = in_v.color;
          
          u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
          
          u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
          
          u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
          
          u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
          
          u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
          
          u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
          
          u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
          
          u_xlat0.w = 1.0;
          
          u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
          
          u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
          
          u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
          
          u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
          
          out_v.texcoord3.xyz = u_xlat16_2.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float3 u_xlat1_d;
      
      float4 u_xlat2;
      
      float u_xlat9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xyz = (-in_f.texcoord1.xyz) + _WorldSpaceCameraPos.xyz;
          
          u_xlat9 = dot(u_xlat0_d.xyz, u_xlat0_d.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat0_d.xyz = float3(u_xlat9) * u_xlat0_d.xyz;
          
          u_xlat0_d.x = dot(in_f.texcoord.xyz, u_xlat0_d.xyz);
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlat0_d.x = (-u_xlat0_d.x) + 1.0;
          
          u_xlat0_d.x = log2(u_xlat0_d.x);
          
          u_xlat0_d.x = u_xlat0_d.x * _RimPower;
          
          u_xlat0_d.x = exp2(u_xlat0_d.x);
          
          u_xlat0_d.xyz = u_xlat0_d.xxx * _RimColor.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz * _RimColor.www;
          
          u_xlat1_d.xyz = (-in_f.texcoord1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
          
          u_xlat9 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat1_d.xyz = float3(u_xlat9) * u_xlat1_d.xyz;
          
          u_xlat9 = dot(in_f.texcoord.xyz, u_xlat1_d.xyz);
          
          u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
          
          u_xlat1_d.xyz = _LightColor0.xyz * float3(u_xlat9) + in_f.texcoord3.xyz;
          
          u_xlat2 = in_f.texcoord2 * _BaseColor;
          
          u_xlat2.xyz = u_xlat2.xyz * u_xlat1_d.xyz + u_xlat0_d.xyz;
          
          out_f.color = u_xlat2;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
