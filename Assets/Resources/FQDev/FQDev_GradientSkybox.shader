Shader "FQDev/GradientSkybox"
{
  Properties
  {
    _SkyColor ("Sky Color", Color) = (0.5,0.5,0.5,1)
    _EquatorColor ("Equator Color", Color) = (0.4,0.4,0.4,1)
    _GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
    _EquatorLine ("Equator Line", Range(0.001, 0.999)) = 0.5
    _EquatorWidth ("Equator Width", Range(0.01, 2)) = 1
    _Exposure ("Exposure", Range(0, 8)) = 1.3
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
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _SkyColor;
      
      uniform float4 _EquatorColor;
      
      uniform float4 _GroundColor;
      
      uniform float _EquatorLine;
      
      uniform float _Exposure;
      
      uniform float _EquatorWidth;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float3 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float3 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          out_v.texcoord.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat0.xyz;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float u_xlat0_d;
      
      float4 u_xlat16_1;
      
      float3 u_xlat16_2;
      
      float u_xlat16_4;
      
      float u_xlat16_7;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = dot(in_f.texcoord.xyz, in_f.texcoord.xyz);
          
          u_xlat0_d = inversesqrt(u_xlat0_d);
          
          u_xlat16_1.x = in_f.texcoord.y * u_xlat0_d + 1.0;
          
          u_xlat16_4 = u_xlat16_1.x * 0.5 + (-_EquatorLine);
          
          u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + _EquatorLine;
          
          u_xlat16_7 = (-_EquatorLine) + 1.0;
          
          u_xlat16_4 = u_xlat16_4 / u_xlat16_7;
          
          u_xlat16_4 = u_xlat16_4 / _EquatorWidth;
          
          u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
          
          u_xlat16_7 = _EquatorWidth * _EquatorLine;
          
          u_xlat16_1.x = u_xlat16_1.x / u_xlat16_7;
          
          u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
          
          u_xlat16_7 = (-u_xlat16_1.x) + 1.0;
          
          u_xlat16_2.xyz = u_xlat16_1.xxx * _GroundColor.xyz;
          
          u_xlat16_1.x = (-u_xlat16_4) + u_xlat16_7;
          
          u_xlat16_1.xzw = _EquatorColor.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
          
          u_xlat16_1.xyz = _SkyColor.xyz * float3(u_xlat16_4) + u_xlat16_1.xzw;
          
          out_f.color.xyz = u_xlat16_1.xyz * float3(float3(_Exposure, _Exposure, _Exposure));
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
