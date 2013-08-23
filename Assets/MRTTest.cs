using UnityEngine;
using System.Collections;

public class MRTTest : MonoBehaviour {

	public RenderTexture[] renderTexture = new RenderTexture[3];
	public RenderBuffer[] renderBuffer = new RenderBuffer[3];

	// Use this for initialization
	void Start () {
		renderBuffer[0] = renderTexture[0].colorBuffer;
		renderBuffer[1] = renderTexture[1].colorBuffer;
		renderBuffer[2] = renderTexture[2].colorBuffer;
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnPreRender(){
		Graphics.SetRenderTarget( renderBuffer, renderTexture[0].depthBuffer );
	}

	void OnPostRender(){
		Graphics.SetRenderTarget( null );
	}
}
