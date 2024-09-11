Shader "Custom/Outline Mask"
{
  Properties
  {
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent+100"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: Mask
    {
      Name "Mask"
      Tags
      { 
        "QUEUE" = "Transparent+100"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 1
        ReadMask 255
        WriteMask 255
        Pass Replace
        Fail Keep
        ZFail Keep
        PassFront Replace
        FailFront Keep
        ZFailFront Keep
        PassBack Replace
        FailBack Keep
        ZFailBack Keep
      } 
      Fog
      { 
        Mode  Off
      } 
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
      
      
      
      struct appdata_t
      {
          
          float3 vertex : POSITION0;
          
          float4 color : COLOR0;
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          out_v.color = in_v.color;
          
          out_v.color = clamp(out_v.color, 0.0, 1.0);
          
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
          
          out_f.color = in_f.color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
