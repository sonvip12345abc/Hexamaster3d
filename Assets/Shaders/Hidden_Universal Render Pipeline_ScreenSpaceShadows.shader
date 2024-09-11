Shader "Hidden/Universal Render Pipeline/ScreenSpaceShadows"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "RenderPipeline" = "UniversalPipeline"
    }
    Pass // ind: 1, name: ScreenSpaceShadows
    {
      Name "ScreenSpaceShadows"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "RenderPipeline" = "UniversalPipeline"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 _BlitScaleBias;
      
      uniform float2 _GlobalMipBias;
      
      uniform float4 unity_MatrixInvVP[4];
      
      uniform float4 _MainLightWorldToShadow[20];
      
      uniform float4 _MainLightShadowParams;
      
      uniform sampler2D _MainLightShadowmapTexture;
      
      uniform sampler2D hlslcc_zcmp_MainLightShadowmapTexture;
      
      uniform sampler2D _CameraDepthTexture;
      
      
      
      struct appdata_t
      {
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float2 u_xlat0;
      
      uint3 u_xlatu0;
      
      int int_bitfieldInsert(int base, int insert, int offset, int bits) 
          {
          
          uint mask = uint(~(int(~0) << uint(bits)) << uint(offset));
          
          return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
      
      }
      
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(int_bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(uint(vertexID) & 2u);
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat16_0;
      
      float4 u_xlat1;
      
      int u_xlatb1;
      
      float u_xlat16_2;
      
      int u_xlatb3;
      
      int u_xlatb9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          u_xlat1 = u_xlat0_d.yyyy * unity_MatrixInvVP[1];
          
          u_xlat0_d = unity_MatrixInvVP[0] * u_xlat0_d.xxxx + u_xlat1;
          
          u_xlat1.x = texture(_CameraDepthTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat1.x = u_xlat1.x * 2.0 + -1.0;
          
          u_xlat0_d = unity_MatrixInvVP[2] * u_xlat1.xxxx + u_xlat0_d;
          
          u_xlat0_d = u_xlat0_d + unity_MatrixInvVP[3];
          
          u_xlat0_d.xyz = u_xlat0_d.xyz / u_xlat0_d.www;
          
          u_xlat1.xyz = u_xlat0_d.yyy * _MainLightWorldToShadow[1].xyz;
          
          u_xlat0_d.xyw = _MainLightWorldToShadow[0].xyz * u_xlat0_d.xxx + u_xlat1.xyz;
          
          u_xlat0_d.xyz = _MainLightWorldToShadow[2].xyz * u_xlat0_d.zzz + u_xlat0_d.xyw;
          
          u_xlat0_d.xyz = u_xlat0_d.xyz + _MainLightWorldToShadow[3].xyz;
          
          u_xlatb9 = 0.0>=u_xlat0_d.z;
          
          u_xlatb1 = u_xlat0_d.z>=1.0;
          
          float3 txVec0 = float3(u_xlat0_d.xy,u_xlat0_d.z);
          
          u_xlat16_0 = textureLod(hlslcc_zcmp_MainLightShadowmapTexture, txVec0, 0.0);
          
          u_xlatb3 = u_xlatb9 || u_xlatb1;
          
          u_xlat16_2 = (-_MainLightShadowParams.x) + 1.0;
          
          u_xlat16_2 = u_xlat16_0 * _MainLightShadowParams.x + u_xlat16_2;
          
          out_f.color = (int(u_xlatb3)) ? float4(1.0, 1.0, 1.0, 1.0) : float4(u_xlat16_2);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
