Shader "Hidden/Universal Render Pipeline/BokehDepthOfField"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
      "RenderPipeline" = "UniversalPipeline"
    }
    LOD 100
    Pass // ind: 1, name: Bokeh Depth Of Field CoC
    {
      Name "Bokeh Depth Of Field CoC"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _ZBufferParams;
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
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
          
          float color : SV_Target0;
      
      };
      
      
      float2 u_xlat0;
      
      uint3 u_xlatu0;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      uint4 u_xlatu0_d;
      
      float u_xlat16_1;
      
      float u_xlat16_3;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * _SourceSize.xy;
          
          u_xlatu0_d.xy = uint2(int2(u_xlat0_d.xy));
          
          u_xlatu0_d.z = uint(0u);
          
          u_xlatu0_d.w = uint(0u);
          
          u_xlat0_d.x = texelFetch(_CameraDepthTexture, int2(u_xlatu0_d.xy), int(u_xlatu0_d.w)).x;
          
          u_xlat0_d.x = _ZBufferParams.z * u_xlat0_d.x + _ZBufferParams.w;
          
          u_xlat0_d.x = float(1.0) / u_xlat0_d.x;
          
          u_xlat0_d.x = _CoCParams.x / u_xlat0_d.x;
          
          u_xlat0_d.x = (-u_xlat0_d.x) + 1.0;
          
          u_xlat0_d.x = u_xlat0_d.x * _CoCParams.y;
          
          u_xlat16_1 = max(u_xlat0_d.x, -1.0);
          
          u_xlat16_3 = u_xlat0_d.x;
          
          u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
          
          u_xlat16_1 = min(u_xlat16_1, 0.0);
          
          u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
          
          u_xlat16_1 = u_xlat16_1 + 1.0;
          
          out_f.color = u_xlat16_1 * 0.5;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: Bokeh Depth Of Field Prefilter
    {
      Name "Bokeh Depth Of Field Prefilter"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _FullCoCTexture;
      
      
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      int u_xlatb0;
      
      float3 u_xlat1;
      
      float4 u_xlat2;
      
      float4 u_xlat3;
      
      float3 u_xlat4;
      
      float3 u_xlat16_5;
      
      float u_xlat16_6;
      
      float u_xlat16_26;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = textureGather(_BlitTexture, in_f.texcoord.xy);
          
          u_xlat1.x = u_xlat0_d.x;
          
          u_xlat2 = textureGather(_BlitTexture, in_f.texcoord.xy, 1).xzyw;
          
          u_xlat1.y = u_xlat2.x;
          
          u_xlat3 = textureGather(_BlitTexture, in_f.texcoord.xy, 2).xywz;
          
          u_xlat1.z = u_xlat3.x;
          
          u_xlat4.x = u_xlat0_d.y;
          
          u_xlat4.y = u_xlat2.z;
          
          u_xlat4.z = u_xlat3.y;
          
          u_xlat16_5.xyz = u_xlat1.xyz + u_xlat4.xyz;
          
          u_xlat2.x = u_xlat0_d.z;
          
          u_xlat3.x = u_xlat0_d.w;
          
          u_xlat3.y = u_xlat2.w;
          
          u_xlat2.z = u_xlat3.w;
          
          u_xlat16_5.xyz = u_xlat2.xyz + u_xlat16_5.xyz;
          
          u_xlat16_5.xyz = u_xlat3.xyz + u_xlat16_5.xyz;
          
          u_xlat16_5.xyz = u_xlat16_5.xyz * float3(0.25, 0.25, 0.25);
          
          u_xlat0_d = textureGather(_FullCoCTexture, in_f.texcoord.xy);
          
          u_xlat0_d = u_xlat0_d * float4(2.0, 2.0, 2.0, 2.0) + float4(-1.0, -1.0, -1.0, -1.0);
          
          u_xlat16_26 = min(u_xlat0_d.z, u_xlat0_d.y);
          
          u_xlat16_26 = min(u_xlat0_d.w, u_xlat16_26);
          
          u_xlat16_26 = min(u_xlat0_d.x, u_xlat16_26);
          
          u_xlat16_6 = max(u_xlat0_d.z, u_xlat0_d.y);
          
          u_xlat16_6 = max(u_xlat0_d.w, u_xlat16_6);
          
          u_xlat16_6 = max(u_xlat0_d.x, u_xlat16_6);
          
          u_xlatb0 = u_xlat16_6<(-u_xlat16_26);
          
          u_xlat16_26 = (u_xlatb0) ? u_xlat16_26 : u_xlat16_6;
          
          u_xlat16_26 = u_xlat16_26 * _CoCParams.z;
          
          u_xlat16_6 = _SourceSize.w + _SourceSize.w;
          
          u_xlat16_6 = float(1.0) / u_xlat16_6;
          
          u_xlat16_6 = abs(u_xlat16_26) * u_xlat16_6;
          
          u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
          
          out_f.color.w = u_xlat16_26;
          
          u_xlat16_26 = u_xlat16_6 * -2.0 + 3.0;
          
          u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
          
          u_xlat16_26 = u_xlat16_26 * u_xlat16_6;
          
          out_f.color.xyz = float3(u_xlat16_26) * u_xlat16_5.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: Bokeh Depth Of Field Blur
    {
      Name "Bokeh Depth Of Field Blur"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _BokehKernel[42];
      
      uniform float4 _BokehConstants;
      
      uniform sampler2D _BlitTexture;
      
      
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      int u_xlati0;
      
      int u_xlatb0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      int u_xlatb2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float4 u_xlat16_5;
      
      float4 u_xlat16_6;
      
      float4 u_xlat16_7;
      
      float4 u_xlat16_8;
      
      float2 u_xlat9;
      
      int u_xlatb9;
      
      float u_xlat16_10;
      
      float u_xlat16_19;
      
      float u_xlat16_28;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_1.x = max(u_xlat16_0.w, 0.0);
          
          u_xlat16_1.x = u_xlat16_1.x + _BokehConstants.y;
          
          u_xlat16_1.y = (-u_xlat16_0.w) + _BokehConstants.y;
          
          u_xlat16_1.xy = u_xlat16_1.xy / _BokehConstants.yy;
          
          u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
          
          u_xlatb2 = (-u_xlat16_0.w)>=_BokehConstants.x;
          
          u_xlat16_19 = (u_xlatb2) ? 1.0 : 0.0;
          
          u_xlat16_10 = u_xlat16_19 * u_xlat16_1.y;
          
          u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
          
          u_xlat16_4.xyz = u_xlat16_0.xyz * float3(u_xlat16_10);
          
          u_xlat16_2.xyz = u_xlat16_3.xyz;
          
          u_xlat16_5.xyz = u_xlat16_4.xyz;
          
          u_xlat16_2.w = u_xlat16_1.x;
          
          u_xlat16_5.w = u_xlat16_10;
          
          for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<42 ; u_xlati_loop_1++)
      
          
              {
              
              u_xlat9.xy = in_f.texcoord.xy + _BokehKernel[u_xlati_loop_1].wy;
              
              u_xlat16_6 = texture(_BlitTexture, u_xlat9.xy, _GlobalMipBias.x);
              
              u_xlat16_19 = min(u_xlat16_0.w, u_xlat16_6.w);
              
              u_xlat16_19 = max(u_xlat16_19, 0.0);
              
              u_xlat16_19 = u_xlat16_19 + (-_BokehKernel[u_xlati_loop_1].z);
              
              u_xlat16_19 = u_xlat16_19 + _BokehConstants.y;
              
              u_xlat16_7.w = u_xlat16_19 / _BokehConstants.y;
              
              u_xlat16_7.w = clamp(u_xlat16_7.w, 0.0, 1.0);
              
              u_xlat16_19 = (-u_xlat16_6.w) + (-_BokehKernel[u_xlati_loop_1].z);
              
              u_xlat16_19 = u_xlat16_19 + _BokehConstants.y;
              
              u_xlat16_19 = u_xlat16_19 / _BokehConstants.y;
              
              u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
              
              u_xlatb9 = (-u_xlat16_6.w)>=_BokehConstants.x;
              
              u_xlat16_28 = (u_xlatb9) ? 1.0 : 0.0;
              
              u_xlat16_8.w = u_xlat16_28 * u_xlat16_19;
              
              u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_7.www;
              
              u_xlat16_2 = u_xlat16_7 + u_xlat16_2;
              
              u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.www;
              
              u_xlat16_5 = u_xlat16_8 + u_xlat16_5;
      
      }
          
          u_xlatb0 = u_xlat16_2.w==0.0;
          
          u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
          
          u_xlat16_1.x = u_xlat16_1.x + u_xlat16_2.w;
          
          u_xlat16_1.xyz = u_xlat16_2.xyz / u_xlat16_1.xxx;
          
          u_xlatb0 = u_xlat16_5.w==0.0;
          
          u_xlat16_28 = (u_xlatb0) ? 1.0 : 0.0;
          
          u_xlat16_28 = u_xlat16_28 + u_xlat16_5.w;
          
          u_xlat16_3.xyz = u_xlat16_5.xyz / float3(u_xlat16_28);
          
          u_xlat16_28 = u_xlat16_5.w * 0.0730602965;
          
          u_xlat16_28 = min(u_xlat16_28, 1.0);
          
          u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
          
          out_f.color.xyz = float3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_1.xyz;
          
          out_f.color.w = u_xlat16_28;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: Bokeh Depth Of Field Post Blur
    {
      Name "Bokeh Depth Of Field Post Blur"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _DownSampleScaleFactor;
      
      uniform sampler2D _BlitTexture;
      
      
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = _SourceSize.zwzw * _DownSampleScaleFactor.zwzw;
          
          u_xlat1 = (-u_xlat16_0.zwxw) * float4(0.5, 0.5, -0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat0_d = u_xlat16_0 * float4(-0.5, 0.5, 0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x);
          
          u_xlat16_1 = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat16_1 + u_xlat16_2;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x);
          
          u_xlat16_0 = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat1 + u_xlat16_2;
          
          u_xlat0_d = u_xlat16_0 + u_xlat1;
          
          out_f.color = u_xlat0_d * float4(0.25, 0.25, 0.25, 0.25);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: Bokeh Depth Of Field Composite
    {
      Name "Bokeh Depth Of Field Composite"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _DofTexture;
      
      uniform sampler2D _FullCoCTexture;
      
      
      
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
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlatu0.x = uint(int(bitfieldInsert(0, vertexID, 1 & int(0x1F), 1)));
          
          u_xlatu0.z = uint(vertexID) & 2u;
          
          u_xlat0.xy = float2(u_xlatu0.xz);
          
          out_v.vertex.xy = u_xlat0.xy * float2(2.0, 2.0) + float2(-1.0, -1.0);
          
          out_v.texcoord.xy = u_xlat0.xy * _BlitScaleBias.xy + _BlitScaleBias.zw;
          
          out_v.vertex.zw = float2(-1.0, 1.0);
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float u_xlat16_1;
      
      float u_xlat2;
      
      float4 u_xlat16_2;
      
      float u_xlat16_4;
      
      float u_xlat16_7;
      
      float u_xlat9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = texture(_FullCoCTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_1 = u_xlat16_0.x + -0.5;
          
          u_xlat16_1 = dot(float2(u_xlat16_1), _CoCParams.zz);
          
          u_xlat16_1 = (-_SourceSize.w) * 2.0 + u_xlat16_1;
          
          u_xlat16_4 = _SourceSize.w + _SourceSize.w;
          
          u_xlat16_4 = float(1.0) / u_xlat16_4;
          
          u_xlat16_1 = u_xlat16_4 * u_xlat16_1;
          
          u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
          
          u_xlat16_4 = u_xlat16_1 * -2.0 + 3.0;
          
          u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
          
          u_xlat16_7 = u_xlat16_1 * u_xlat16_4;
          
          u_xlat16_0 = texture(_DofTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat2 = u_xlat16_4 * u_xlat16_1 + u_xlat16_0.w;
          
          u_xlat9 = (-u_xlat16_7) * u_xlat16_0.w + u_xlat2;
          
          u_xlat16_1 = max(u_xlat16_0.y, u_xlat16_0.x);
          
          u_xlat16_1 = max(u_xlat16_0.z, u_xlat16_1);
          
          u_xlat16_2 = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat1.w = u_xlat16_1 + (-u_xlat16_2.w);
          
          u_xlat1.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
          
          u_xlat0_d = float4(u_xlat9) * u_xlat1 + u_xlat16_2;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderPipeline" = "UniversalPipeline"
    }
    LOD 100
    Pass // ind: 1, name: Bokeh Depth Of Field CoC
    {
      Name "Bokeh Depth Of Field CoC"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _ZBufferParams;
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
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
          
          float color : SV_Target0;
      
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
      
      
      
      float2 u_xlat0_d;
      
      uint4 u_xlatu0_d;
      
      float u_xlat16_1;
      
      float u_xlat16_3;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.xy = in_f.texcoord.xy * _SourceSize.xy;
          
          u_xlatu0_d.xy = uint2(int2(u_xlat0_d.xy));
          
          u_xlatu0_d.z = uint(uint(0u));
          
          u_xlatu0_d.w = uint(uint(0u));
          
          u_xlat0_d.x = texelFetch(_CameraDepthTexture, int2(u_xlatu0_d.xy), int(u_xlatu0_d.w)).x;
          
          u_xlat0_d.x = _ZBufferParams.z * u_xlat0_d.x + _ZBufferParams.w;
          
          u_xlat0_d.x = float(1.0) / u_xlat0_d.x;
          
          u_xlat0_d.x = _CoCParams.x / u_xlat0_d.x;
          
          u_xlat0_d.x = (-u_xlat0_d.x) + 1.0;
          
          u_xlat0_d.x = u_xlat0_d.x * _CoCParams.y;
          
          u_xlat16_1 = max(u_xlat0_d.x, -1.0);
          
          u_xlat16_3 = u_xlat0_d.x;
          
          u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
          
          u_xlat16_1 = min(u_xlat16_1, 0.0);
          
          u_xlat16_1 = u_xlat16_1 + u_xlat16_3;
          
          u_xlat16_1 = u_xlat16_1 + 1.0;
          
          out_f.color = u_xlat16_1 * 0.5;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: Bokeh Depth Of Field Prefilter
    {
      Name "Bokeh Depth Of Field Prefilter"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _FullCoCTexture;
      
      
      
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
      
      float3 u_xlat16_0;
      
      float u_xlat1;
      
      float3 u_xlat16_1;
      
      int u_xlatb1;
      
      float4 u_xlat2;
      
      float u_xlat16_3;
      
      float u_xlat5;
      
      float u_xlat16_5;
      
      float3 u_xlat16_7;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = (-_SourceSize.zwzw) * float4(0.5, 0.5, -0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat16_1.x = texture(_FullCoCTexture, u_xlat0_d.zw, _GlobalMipBias.x).x;
          
          u_xlat1 = u_xlat16_1.x * 2.0 + -1.0;
          
          u_xlat2 = _SourceSize.zwzw * float4(-0.5, 0.5, 0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat16_5 = texture(_FullCoCTexture, u_xlat2.xy, _GlobalMipBias.x).x;
          
          u_xlat5 = u_xlat16_5 * 2.0 + -1.0;
          
          u_xlat16_3 = min(u_xlat5, u_xlat1);
          
          u_xlat16_7.x = max(u_xlat5, u_xlat1);
          
          u_xlat16_1.x = texture(_FullCoCTexture, u_xlat2.zw, _GlobalMipBias.x).x;
          
          u_xlat1 = u_xlat16_1.x * 2.0 + -1.0;
          
          u_xlat16_3 = min(u_xlat1, u_xlat16_3);
          
          u_xlat16_7.x = max(u_xlat1, u_xlat16_7.x);
          
          u_xlat16_1.x = texture(_FullCoCTexture, u_xlat0_d.xy, _GlobalMipBias.x).x;
          
          u_xlat1 = u_xlat16_1.x * 2.0 + -1.0;
          
          u_xlat16_3 = min(u_xlat16_3, u_xlat1);
          
          u_xlat16_7.x = max(u_xlat16_7.x, u_xlat1);
          
          u_xlatb1 = u_xlat16_7.x<(-u_xlat16_3);
          
          u_xlat16_3 = (u_xlatb1) ? u_xlat16_3 : u_xlat16_7.x;
          
          u_xlat16_3 = u_xlat16_3 * _CoCParams.z;
          
          u_xlat16_7.x = _SourceSize.w + _SourceSize.w;
          
          u_xlat16_7.x = float(1.0) / u_xlat16_7.x;
          
          u_xlat16_7.x = u_xlat16_7.x * abs(u_xlat16_3);
          
          u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
          
          out_f.color.w = u_xlat16_3;
          
          u_xlat16_3 = u_xlat16_7.x * -2.0 + 3.0;
          
          u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
          
          u_xlat16_3 = u_xlat16_7.x * u_xlat16_3;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_7.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
          
          u_xlat16_0.xyz = texture(_BlitTexture, u_xlat2.xy, _GlobalMipBias.x).xyz;
          
          u_xlat16_1.xyz = texture(_BlitTexture, u_xlat2.zw, _GlobalMipBias.x).xyz;
          
          u_xlat16_7.xyz = u_xlat16_0.xyz + u_xlat16_7.xyz;
          
          u_xlat16_7.xyz = u_xlat16_1.xyz + u_xlat16_7.xyz;
          
          u_xlat16_7.xyz = u_xlat16_7.xyz * float3(0.25, 0.25, 0.25);
          
          out_f.color.xyz = float3(u_xlat16_3) * u_xlat16_7.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: Bokeh Depth Of Field Blur
    {
      Name "Bokeh Depth Of Field Blur"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _BokehKernel[42];
      
      uniform float4 _BokehConstants;
      
      uniform sampler2D _BlitTexture;
      
      
      
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
      
      
      
      float4 u_xlat16_0;
      
      int u_xlati0;
      
      int u_xlatb0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      int u_xlatb2;
      
      float3 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float4 u_xlat16_5;
      
      float4 u_xlat16_6;
      
      float4 u_xlat16_7;
      
      float4 u_xlat16_8;
      
      float2 u_xlat9;
      
      int u_xlatb9;
      
      float u_xlat16_10;
      
      float u_xlat16_19;
      
      float u_xlat16_28;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat16_1.x = max(u_xlat16_0.w, 0.0);
          
          u_xlat16_1.x = u_xlat16_1.x + _BokehConstants.y;
          
          u_xlat16_1.y = (-u_xlat16_0.w) + _BokehConstants.y;
          
          u_xlat16_1.xy = u_xlat16_1.xy / _BokehConstants.yy;
          
          u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
          
          u_xlatb2 = (-u_xlat16_0.w)>=_BokehConstants.x;
          
          u_xlat16_19 = (u_xlatb2) ? 1.0 : 0.0;
          
          u_xlat16_10 = u_xlat16_19 * u_xlat16_1.y;
          
          u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
          
          u_xlat16_4.xyz = u_xlat16_0.xyz * float3(u_xlat16_10);
          
          u_xlat16_2.xyz = u_xlat16_3.xyz;
          
          u_xlat16_5.xyz = u_xlat16_4.xyz;
          
          u_xlat16_2.w = u_xlat16_1.x;
          
          u_xlat16_5.w = u_xlat16_10;
          
          for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<42 ; u_xlati_loop_1++)
      
          
              {
              
              u_xlat9.xy = in_f.texcoord.xy + _BokehKernel[u_xlati_loop_1].wy;
              
              u_xlat16_6 = texture(_BlitTexture, u_xlat9.xy, _GlobalMipBias.x);
              
              u_xlat16_19 = min(u_xlat16_0.w, u_xlat16_6.w);
              
              u_xlat16_19 = max(u_xlat16_19, 0.0);
              
              u_xlat16_19 = u_xlat16_19 + (-_BokehKernel[u_xlati_loop_1].z);
              
              u_xlat16_19 = u_xlat16_19 + _BokehConstants.y;
              
              u_xlat16_7.w = u_xlat16_19 / _BokehConstants.y;
              
              u_xlat16_7.w = clamp(u_xlat16_7.w, 0.0, 1.0);
              
              u_xlat16_19 = (-u_xlat16_6.w) + (-_BokehKernel[u_xlati_loop_1].z);
              
              u_xlat16_19 = u_xlat16_19 + _BokehConstants.y;
              
              u_xlat16_19 = u_xlat16_19 / _BokehConstants.y;
              
              u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
              
              u_xlatb9 = (-u_xlat16_6.w)>=_BokehConstants.x;
              
              u_xlat16_28 = (u_xlatb9) ? 1.0 : 0.0;
              
              u_xlat16_8.w = u_xlat16_28 * u_xlat16_19;
              
              u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_7.www;
              
              u_xlat16_2 = u_xlat16_7 + u_xlat16_2;
              
              u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.www;
              
              u_xlat16_5 = u_xlat16_8 + u_xlat16_5;
      
      }
          
          u_xlatb0 = u_xlat16_2.w==0.0;
          
          u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
          
          u_xlat16_1.x = u_xlat16_1.x + u_xlat16_2.w;
          
          u_xlat16_1.xyz = u_xlat16_2.xyz / u_xlat16_1.xxx;
          
          u_xlatb0 = u_xlat16_5.w==0.0;
          
          u_xlat16_28 = (u_xlatb0) ? 1.0 : 0.0;
          
          u_xlat16_28 = u_xlat16_28 + u_xlat16_5.w;
          
          u_xlat16_3.xyz = u_xlat16_5.xyz / float3(u_xlat16_28);
          
          u_xlat16_28 = u_xlat16_5.w * 0.0730602965;
          
          u_xlat16_28 = min(u_xlat16_28, 1.0);
          
          u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
          
          out_f.color.xyz = float3(u_xlat16_28) * u_xlat16_3.xyz + u_xlat16_1.xyz;
          
          out_f.color.w = u_xlat16_28;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: Bokeh Depth Of Field Post Blur
    {
      Name "Bokeh Depth Of Field Post Blur"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _DownSampleScaleFactor;
      
      uniform sampler2D _BlitTexture;
      
      
      
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
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float4 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = _SourceSize.zwzw * _DownSampleScaleFactor.zwzw;
          
          u_xlat1 = (-u_xlat16_0.zwxw) * float4(0.5, 0.5, -0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat0_d = u_xlat16_0 * float4(-0.5, 0.5, 0.5, 0.5) + in_f.texcoord.xyxy;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat1.xy, _GlobalMipBias.x);
          
          u_xlat16_1 = texture(_BlitTexture, u_xlat1.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat16_1 + u_xlat16_2;
          
          u_xlat16_2 = texture(_BlitTexture, u_xlat0_d.xy, _GlobalMipBias.x);
          
          u_xlat16_0 = texture(_BlitTexture, u_xlat0_d.zw, _GlobalMipBias.x);
          
          u_xlat1 = u_xlat1 + u_xlat16_2;
          
          u_xlat0_d = u_xlat16_0 + u_xlat1;
          
          out_f.color = u_xlat0_d * float4(0.25, 0.25, 0.25, 0.25);
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: Bokeh Depth Of Field Composite
    {
      Name "Bokeh Depth Of Field Composite"
      Tags
      { 
        "RenderPipeline" = "UniversalPipeline"
      }
      LOD 100
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
      
      uniform float4 _SourceSize;
      
      uniform float4 _CoCParams;
      
      uniform sampler2D _BlitTexture;
      
      uniform sampler2D _DofTexture;
      
      uniform sampler2D _FullCoCTexture;
      
      
      
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
      
      float4 u_xlat16_0;
      
      float4 u_xlat1;
      
      float u_xlat16_1;
      
      float u_xlat2;
      
      float4 u_xlat16_2;
      
      float u_xlat16_4;
      
      float u_xlat16_7;
      
      float u_xlat9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = texture(_FullCoCTexture, in_f.texcoord.xy, _GlobalMipBias.x).x;
          
          u_xlat16_1 = u_xlat16_0.x + -0.5;
          
          u_xlat16_1 = dot(float2(u_xlat16_1), _CoCParams.zz);
          
          u_xlat16_1 = (-_SourceSize.w) * 2.0 + u_xlat16_1;
          
          u_xlat16_4 = _SourceSize.w + _SourceSize.w;
          
          u_xlat16_4 = float(1.0) / u_xlat16_4;
          
          u_xlat16_1 = u_xlat16_4 * u_xlat16_1;
          
          u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
          
          u_xlat16_4 = u_xlat16_1 * -2.0 + 3.0;
          
          u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
          
          u_xlat16_7 = u_xlat16_1 * u_xlat16_4;
          
          u_xlat16_0 = texture(_DofTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat2 = u_xlat16_4 * u_xlat16_1 + u_xlat16_0.w;
          
          u_xlat9 = (-u_xlat16_7) * u_xlat16_0.w + u_xlat2;
          
          u_xlat16_1 = max(u_xlat16_0.y, u_xlat16_0.x);
          
          u_xlat16_1 = max(u_xlat16_0.z, u_xlat16_1);
          
          u_xlat16_2 = texture(_BlitTexture, in_f.texcoord.xy, _GlobalMipBias.x);
          
          u_xlat1.w = u_xlat16_1 + (-u_xlat16_2.w);
          
          u_xlat1.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
          
          u_xlat0_d = float4(u_xlat9) * u_xlat1 + u_xlat16_2;
          
          out_f.color = u_xlat0_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
