using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Two : MonoBehaviour
{
    public ComputeShader cShader;
    public Color tint;
    WebCamTexture feed;
    int kernelIndex;
    RenderTexture tinted;
    // Start is called before the first frame update
    void Start()
    {
        feed = new WebCamTexture();
        tinted = new RenderTexture(feed.width * 32, feed.height * 32, 24);
        tinted.enableRandomWrite = true;
        tinted.Create();
        kernelIndex = cShader.FindKernel("CSMain");
        cShader.SetTexture(kernelIndex, Shader.PropertyToID("Feed"), (Texture)feed);
        cShader.SetTexture(kernelIndex, Shader.PropertyToID("Result"), tinted);
        feed.Play();
    }

    // Update is called once per frame
    void Update()
    {
        cShader.SetVector(Shader.PropertyToID("Tint"), tint);
        cShader.Dispatch(kernelIndex, feed.width / 32, feed.height / 32, 1);
        GetComponent<Renderer>().material.SetTexture("_MainTex", tinted);
    }
}
