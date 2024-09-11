Shader "FQDev/VertexColor"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 150
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 150
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 _LightColor0;
      
      uniform float4 _Color;
      
      
      
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
          
          float4 color : COLOR0;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          out_v.texcoord1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.color = in_v.color;
          
          out_v.texcoord4 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat16_0;
      
      float3 u_xlat16_1;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = dot(in_f.texcoord.xyz, _WorldSpaceLightPos0.xyz);
          
          u_xlat16_0 = max(u_xlat16_0, 0.0);
          
          u_xlat16_1.xyz = in_f.color.xyz * _Color.xyz;
          
          u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
          
          out_f.color.xyz = float3(u_xlat16_0) * u_xlat16_1.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: DEFERRED
    {
      Name "DEFERRED"
      Tags
      { 
        "LIGHTMODE" = "DEFERRED"
        "RenderType" = "Opaque"
      }
      LOD 150
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      
      
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
          
          float4 color : COLOR0;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
          
          float4 color1 : SV_Target1;
          
          float4 color2 : SV_Target2;
          
          float4 color3 : SV_Target3;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float u_xlat6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
          
          out_v.texcoord1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
          
          u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
          
          u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
          
          u_xlat0.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat0.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat0.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat6 = inversesqrt(u_xlat6);
          
          out_v.texcoord.xyz = float3(u_xlat6) * u_xlat0.xyz;
          
          out_v.color = in_v.color;
          
          out_v.texcoord2 = float4(0.0, 0.0, 0.0, 0.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color.xyz = in_f.color.xyz * _Color.xyz;
          
          out_f.color.w = 1.0;
          
          out_f.color1 = float4(0.0, 0.0, 0.0, 0.0);
          
          u_xlat0_d.xyz = in_f.texcoord.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
          
          u_xlat0_d.w = 1.0;
          
          out_f.color2 = u_xlat0_d;
          
          out_f.color3 = float4(1.0, 1.0, 1.0, 1.0);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
