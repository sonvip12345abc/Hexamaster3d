Shader "Custom/Outline Fill"
{
  Properties
  {
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 0
    _OutlineColor ("Outline Color", Color) = (1,1,1,1)
    _OutlineWidth ("Outline Width", Range(0, 10)) = 2
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "QUEUE" = "Transparent+110"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: Fill
    {
      Name "Fill"
      Tags
      { 
        "DisableBatching" = "true"
        "QUEUE" = "Transparent+110"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 1
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
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask RGB
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 UNITY_MATRIX_P[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixInvV[4];
      
      uniform float4 _OutlineColor;
      
      uniform float _OutlineWidth;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float3 texcoord3 : TEXCOORD3;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat2;
      
      float u_xlat9;
      
      int u_xlatb9;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[0].yyy;
          
          u_xlat0.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[0].xxx + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[0].zzz + u_xlat0.xyz;
          
          u_xlat0.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[0].www + u_xlat0.xyz;
          
          u_xlat9 = dot(in_v.texcoord3.xyz, in_v.texcoord3.xyz);
          
          u_xlatb9 = u_xlat9!=0.0;
          
          u_xlat1.xyz = (int(u_xlatb9)) ? in_v.texcoord3.xyz : in_v.normal.xyz;
          
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
          
          u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[1].yyy;
          
          u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[1].xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[1].zzz + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[1].www + u_xlat2.xyz;
          
          u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
          
          u_xlat2.xyz = unity_WorldToObject[1].xyz * unity_MatrixInvV[2].yyy;
          
          u_xlat2.xyz = unity_WorldToObject[0].xyz * unity_MatrixInvV[2].xxx + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[2].xyz * unity_MatrixInvV[2].zzz + u_xlat2.xyz;
          
          u_xlat2.xyz = unity_WorldToObject[3].xyz * unity_MatrixInvV[2].www + u_xlat2.xyz;
          
          u_xlat0.z = dot(u_xlat2.xyz, u_xlat1.xyz);
          
          u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
          
          u_xlat9 = inversesqrt(u_xlat9);
          
          u_xlat0.xyz = float3(u_xlat9) * u_xlat0.xyz;
          
          u_xlat1 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat1 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat1;
          
          u_xlat1 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat1;
          
          u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
          
          u_xlat2.xyz = u_xlat1.yyy * unity_MatrixV[1].xyz;
          
          u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
          
          u_xlat1.xyz = unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
          
          u_xlat1.xyz = unity_MatrixV[3].xyz * u_xlat1.www + u_xlat1.xyz;
          
          u_xlat0.xyz = u_xlat0.xyz * (-u_xlat1.zzz);
          
          u_xlat0.xyz = u_xlat0.xyz * float3(_OutlineWidth);
          
          u_xlat0.xyz = u_xlat0.xyz * float3(0.00100000005, 0.00100000005, 0.00100000005) + u_xlat1.xyz;
          
          u_xlat1 = u_xlat0.yyyy * UNITY_MATRIX_P[1];
          
          u_xlat1 = UNITY_MATRIX_P[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat0 = UNITY_MATRIX_P[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = u_xlat0 + UNITY_MATRIX_P[3];
          
          out_v.color = _OutlineColor;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          out_f.color = in_f.color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
