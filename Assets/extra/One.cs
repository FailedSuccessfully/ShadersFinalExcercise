using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class One : MonoBehaviour
{
    public ComputeShader computeShader;
    public Texture textureIn;
    RenderTexture textureOut;

    void Start()
    {
        textureOut = new RenderTexture(textureIn.width, textureIn.height, 24);
        textureOut.enableRandomWrite = true;
        textureOut.Create();

        Renderer rend = GetComponent<Renderer>();
        int kernelIndex = computeShader.FindKernel("CSMain");

        computeShader.SetTexture(kernelIndex, Shader.PropertyToID("Original"), textureIn);
        computeShader.SetTexture(kernelIndex, Shader.PropertyToID("Result"), textureOut);
        computeShader.Dispatch(kernelIndex, textureIn.width / 8, textureIn.height / 8, 1);

        rend.material.SetTexture("_MainTex", textureOut);
    }
}
