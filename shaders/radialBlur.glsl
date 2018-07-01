
vec4 effect(vec4 color, Image currentTexture, vec2 texCoords, vec2 screenCoords){
    
	float weight[10];
	float normalization;
	vec4 outputColor;

	vec2 direction;

	vec4 sum;

	// variables to control blur effect
	float sampleDistance = 1.0;
	float sampleStrength = 2.2;

	// Create the weights that each neighbor pixel will contribute to the blur.
	weight[0] = -0.08;
	weight[1] = -0.05;
	weight[2] = -0.03;
	weight[3] = -0.02;
	weight[4] = -0.01;
	weight[5] = weight[4] * -1;
	weight[6] = weight[3] * -1;
	weight[7] = weight[2] * -1;
	weight[8] = weight[1] * -1;
	weight[9] = weight[0] * -1;

	// 0.5, 0.5 is the center of the texture
	// so subtracting our texture coordinates away from this will get
	// a vector pointing towards the middle of the screen
	direction = vec2(0.5f - texCoords.x, 0.5f - texCoords.y);
	
	// calculate the distance from this pixel to the center of the screen
	float distance = sqrt(direction.x*direction.x + direction.y*direction.y);

	// normalize the direction
	direction = direction/distance;

	// Get the normal colour to blur
	outputColor = Texel(currentTexture, texCoords.xy);

    // remember the base color
	sum = outputColor;

	// Take 10 additional blur samples in the direction towards the center of the screen
	for (int i = 0; i < 10; i++)
	{
        sum += Texel(currentTexture, texCoords + direction * weight[i] * sampleDistance);
	}

	// we have taken eleven samples, so make sure we don't end up adding or taking away extra color
	sum *= 1.0/11.0;

	// weighten the blur effect with the distance to the center of the screen. Further out is blured more
	
	float scale = distance * sampleStrength;
	float sumScale = clamp(scale, 0.0, 1.0);

	// add red based on how far away from edge
	vec4 red = vec4(1.0, 0.1, 0.1, 1.0);
	
	// want half red by edges

	scale = distance * sampleStrength * 0.25;
	float redScale = clamp(scale, 0.0, 0.5);

	outputColor = mix(outputColor, sum, sumScale);
	outputColor = mix(outputColor, red, redScale);

	// Set the alpha channel to one.
	outputColor.a = 1.0f;

	return outputColor;
}