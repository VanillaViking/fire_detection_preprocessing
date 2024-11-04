#align(center, text(20pt)[
  *Significance of Image Pre-processing in Computer Vision Based Fire Detection, A Review*
])

#align(center, text(17pt)[
  Task 2: Literature Review
])

#align(center, text(14pt)[
  Ashwin Rajesh - 14259321
])

#set heading(numbering: "1.a")
#show link: underline
#show link: set text(blue)
#show cite: set text(maroon)

#outline()
#pagebreak()

= Abstract

= Introduction

Wildfires pose a significant threat to humans, wildlife and the environment alike.
Left unchecked, A wildfire can spread rapidly causing large scale destruction to forests & infrastructure, as well as releasing large amounts of pollutants into the atmosphere.
Therefore, it has become increasingly crucial to detect them as early as possible.
This report aims to explore different methods employed in improving the performance and efficiency of wildfire detection systems, with a focus on computer vision based fire detection using Convolutional Neural Networks (CNNs).

= Literature Review

UAVs have seen extensive research for this application, as they provide valuable visual data which can be employed to carry out search and rescue operations, save forest resources, help firefighters navigate efficiently amoung numerous other enhancements.
Rather than sending ground crews to monitor hazardous environments, UAVs can drastically reduce the risk to firefighting crews by remotely scanning large amounts of dangerous forest area.
However UAVs tend to perform poorly in harsh weather conditions, have limited flight time and require a human operator to have a visual line of sight @uav.
These factors combined with expensive operation costs severly limit the effectiveness of UAVs in many circumstances. 

Edge computing sensor nodes can be placed at high risk locations that can monitor temperature, humidity and other characteristics of air in the surrounding area.
These systems generally use a microcontroller to operate sensors, relying on solar cells for long-term power.
By setting up multiple such nodes in different areas forming a Wireless Sensor Network (WSN), the collected sensor data may then be analyzed to determine the locations of fire events @MohapatraAnkita2022EWDT.
More advance methods of data classification with the use of artificial neural networks boast a high accuracy of >82% with multiple sensors @wsnfire.
The low cost of WSN systems has made it an increasingly popular choice for real-time monitoring of forest fires.
However, sensor nodes fail to be viable in some situations.
Establishing wireless communications for a WSN can prove challenging in rural or untamed areas such as forests @wsnyolo.
The sensor nodes may also be prone to damage from the wildfire, needing to be replaced in order to continue using the system. 

#figure(
  image("sensornode.png", width: 60%),
  caption: [Basic operation of WSNs. Images sourced from Creative Commons, following the
guidelines on Attribution 3.0 Unported, CC By 3.0],
) <sn>

 Satellite-based fire detection can potentially offer significant advantages over traditional methods due to the vast areas they can monitor.
 The benefits and limitations of these systems largely depend on the satellite's orbit.
 Satellites in Sun-Synchronous Orbit (SSO) provide high spatial resolution but revisit the same location only after several days, resulting in low temporal resolution.
 This delay makes SSO satellites less effective for real-time wildfire detection @satellite.
 In contrast, Geostationary Earth Orbit (GEO) satellites remain fixed over the same region, as their orbital period matches Earth's rotation.
 Equipped with multispectral imaging sensors, GEO satellites provide continuous monitoring, making them ideal for detecting and tracking fires in real time.

#figure(
  image("wildfire_satellite.png", width: 60%),
  caption: [Satellite Based Wildfire Detection],
) <sn>

Despite the various classifications of technologies within wildfire detection, advancements in computer vision object detection has spurred use in terrestrial, aerial as well as satellite systems. 
#cite(label("satellite"), form: "prose") explores the feasibility of space-borne fire detection using onboard computer vision to rapidly generate alerts.
The traditional method of downloading image data from satellites has too much latency for time-sensitive applications such as fire detection.
By examining performance of hardware accelerators for edge computing such as Nvidia Jetson and Movidius Myriad 2, the report found that AI inference on-board the satellite is possible in terms of performance as well as power consumption, allowing for low latency detection of wildfires.
#cite(label("uavai"), form: "prose") details methods to optimise Deep Learning to deal with UAV limitations such as image degredation, small fire size & background complexity.
By combining EfficientNet-B5, vision transformers and EfficientSeg convolutional model, an accuracy of 85.12% was obtained, outperforming many state-of-the-art models.
#cite(label("wsnyolo"), form: "prose") proposes a low cost WSN fire detection approach based on YOLO object detection models.
The system, named SDFS was trained on a dataset of 26,520 images and achieved a high precision rate of 97.1% for smoke and fire classification.

Due to the importance of computer vision based object detection in wildfire detection, it is imperative that they are as accurate as possible.
There are many different techniques to improve the performance of neural networks. 
Transfer learning is the process of using a model that has been pre-trained on a large dataset and further training and fine tuning it to a specific task. 
#cite(label("transferlearning"), form: "prose") studies the impact of transfer learning on classification by comparing six differnet pre-trained architectures.
The models were trained using an open access dataset of 3886 images and found that all six architectures were able to achieve a testing accuracy of above 90% despite a relatively small training dataset.
Augmenting data with synthetically generated samples investigated by #cite(label("augment"), form: "prose") found that inserting data-space transformations such as warped images provided improved performance and reduced overfitting.
#cite(label("prepfire"), form: "prose") proposed an image pre-processing pipeline using advanced techniques such as HSV filters and corner detection to assist models with classification by eliminating unwanted noise in images. This method has observed to improve fire detection accuracy by 5.5% and smoke detection by 6% in object detection models. 

 This paper contributes a benchmark of different pre-processing filters and algorithms to uncover insights on an ideal pipeline for wildfire detection, using metrics such as speed, power consumption and model accuracy. The benchmarks are carried out on a Raspberry Pi 4B, to similate low-powered edge computing hardware that is consistently used in terrestrial, UAV and satellite systems. Large deep-learning networks are unviable on these systems due to the high computational intensity, while models with reduced parameters are more efficient but suffer from less accurate inference. The preprocessing pipeline aims to improve the accuracy of lightweight models by highlighting important features in fire and smoke, while reducing unwanted noise in the image.

= Image Pre-Processing Algorithms

== HSV filter

Hue, Saturation, Value (HSV) is a cylindrical-coordinate representation of points in an RGB colour model.
It is an alternative representation of the RGB color model that intends to describe colors in a way that is more aligned with human perception.
Colour masks can be created by setting upper and lower bounds within the HSV channels.
This can then be applied to an image to filter specific tones of colour.
A study by #cite(label("skinhsv"), form: "prose") utilized HSV thresholding to detect human skin in an image. The process achieved an impressive 99.587% accuracy on natural images under varying light conditions.
#cite(label("prepfire"), form: "prose") used a HSV filter in addition to other preprocessing stages to isolate colours of fire in an image to assist object detection models with inference, which resulted in a 5.5% increase in fire detection accuracy. The following bounds were used to preprocess images in the paper:

$ "RoI"_"HSV(x,y)" := cases(
1 "if" 20 < H(x,y) < 40 "and" 50 < S(x,y) < 255 "and" 50 < V(x,y) < 255, 
0 "otherwise",
) $

#figure(
  image("hsv_filter.jpg", width: 60%),
  caption: [Resulting Image after HSV mask],
) <sn>


== Edge & Contour Detection

Edge detection involves identifying regions of an image where the contrast between pixels changes dramatically. Capturing edges can be used to reveal important properties in the image as these edges often correspond to changes in depth, illumination, orientation or material. Edge detection can be particularly useful in detecting fire, as it uncovers data about positions of contours and contrasts where fire and smoke could potentially exist. More specifically, method to use low edge responses in an image region may be useful in differentiating between smoke and sky. This method is explored further in this paper

Edge detection has seen use in many fields to extract valuable information from visual data. 
#cite(label("covidsobel"), form: "prose") aims to accurately detect COVID-19 patients by using edge detection to improve detection accuracy of a CNN on CT images of the lungs. The addition of sobel edge detection to a CNN proved to be an effective approach, achieving an accuracy of 99.02% on a custom dataset.
#cite(label("edgesat"), form: "prose") proposes an approach to detect roads in satellite images using edge detection and semantic-segmentation. The results showed accurate segmentation & edge detection even in complicated backgrounds. This shows the potential of edge detection in satellite and UAV based systems, where small details in an image are of significant importance.


#pagebreak()
=== Sobel Operator

A popular method of edge detection thanks to its computational simplicity is the Sobel operator. The sobel filter involves convolving the image with a specific kernel which calculates the gradient of the image in x and y directions @sobel. For a given image, let us consider a pixel region such as:

#table(
  columns: (1cm, 1cm, 1cm, 1cm),
  inset: 10pt,
  align: horizon,
  [50],
  [50],
  [100],
  [100],
  [50],
  [*50*],
  [100],
  [100],
  [50],
  [50],
  [100],
  [100],
  [50],
  [50],
  [100],
  [100],
)

Where the value in each cell is the brightness of the pixel in that position within the image. In the region shown above, we can see that the pixel brightness rapidly changes between the 2nd and 3rd columns, which would be perceived as an edge by humans.  We can then convolve the gradient filter shown below over each pixel of the image.

#table(
  columns: (1cm, 1cm, 1cm),
  inset: 10pt,
  align: horizon,
  [1],
  [0],
  [1],
  [-2],
  [0],
  [-2],
  [1],
  [0],
  [1],
)

Let us consider the pixel in the second column and second row as the pixel currently being processed. Each value in the gradient filter is multiplied with the corresponding pixel in the neighbouring 3x3 area around our center pixel, and summed. In our example, this would output a high value of 200, as our area of interest contains high intensity pixels on the right and lower intensity on the left. 

This process is repeated with every other pixel to produce the partial derivative of the image in the x direction. By obtaining the y partial derivative in a similar manner, we may combine the images to produce a resultant image containing high absolute values near edges and a value close to 0 everywhere else. The x and y gradients can be combined using the following method:

$ G = sqrt(G_x^2 + G_y^2) $

Where G is the positive magnitude of the intensity of an edge at that pixel. Pixels with small edge response will have a value closer to 0 (black) while pixels around an edge will have a high value and appear white. The effects of a sobel filter on an image can be seen in @sobelimg, where most of the scenery and smoke is covered in many white lines, while the small area of sky above is almost completely dark.


#figure(
  image("sobelsmoke.png", width: 90%),
  caption: [Image with smoke processed using a basic sobel filter],
) <sobelimg>

== Corner Detection

Corner detection is a common technique used in computer vision to infer features from an image. 
#cite(label("prepfire"), form: "prose") shows that a corner detection algorithm is a vital preprocessing stage, as it separates fire from other objects of similar color, which would fall within the thresholds of a HSV filter.
The popular Harris corner detector uses the autocorrelation function of the image to determine intensity differences within patches of an image. Using a Taylor expansion, the autocorrelation function can be approximated as @prepfire @harriscorner:

$ I(x_i,y_i) + [I_x(x_i,y_i) I_y(x_i,y_i)] vec(u,v, delim: "[") $

Where $I$ represents intensity and $u$ and $v$ represent the shift in the region from the reference pixel $(x_i,y_i)$. This shows that the change in intensity depends on the partial derivatives $I_x$ and $I_y$ of the image. When written in matrix form, the expression is as follows:

$ M = mat(sum(I_x(x_i,y_i)^2), sum(I_x(x_i,y_i)I_y(x_i,y_i)); sum(I_x(x_i,y_i)I_y(x_i,y_i)), sum(I_y(x_i,y_i))) $

The eigenvalues of the matrix can be found using the determinant and trace:

$ "det"(M) = A B - C^2 = lambda_1 lambda_2 $
$ "trace"(M) = A + B = lambda_1 + lambda_2 $

There are three possible situations based on their values:

- Both eigenvalues are small: this happens when the pixels are in a flat region
- One eigenvalue is bigger than the other eigenvalue: The region likely is an edge
- Both eigenvalues are large: the region is a corner

Therefore, corner regions within an image will output a high corner strength. These regions can be used as a candidate region that can be inferred through a CNN.

#figure(
  image("corner.png", width: 60%),
  caption: [Corner detection executed on HSV-filtered image of fire (corners marked green)],
) <firecorner>

== Dark Channel Prior

Dark Channel Prior has been commonly used to measure the degree of haziness as well as haze-removal in images. The technique is based on the observation that in most outdoor images, pixels tend to have low intensities in atleast one colour channel (dark channel). This property can be used to estimate the transmission map of an image, representing the amount of haze affecting the scene. Atmospheric haze can be modelled as follows @darkchannelprior:

$ I(x) = J(x)t(x) + A(1 - t(x))  $

$I(x)$ represents a pixel that reached the camera. $J(x)$ represents the undistorted pixel. $t(x)$ is the transmission map, representing how much scene radiance is retained, where a value of  1 means no haze and 0 means maximum haze. Due to the scattering of light from haze, low intensity channels in hazy patches of an image have an inherently higher value. As a result, DCP can be used to estimate $t(x)$ providing the areas of the image affected by haze. 
#cite(label("prepfire"), form: "prose") and #cite(label("dcpsmoke"), form: "prose") note that dark channel prior methods can apply to smoke due to the similar nature, having relatively higher values in their dark channels. This causes smoke to be picked up as an area of high haze in the transmission map. #cite(label("prepfire"), form: "prose") apply a threshold to the transmission map, extracting areas with high dark channel values and suppressing the rest. As a result, a 6% increase in detection accuracy was achieved compared to detection without extra preprocessing stages.


#figure(
  image("dcp.png", width: 90%),
  caption: [Image processed with Dark channel prior & thresholded to high intensity values],
) <dcp>

As shown in @dcp, DCP reveals areas with high intensity values in all three channels, causing haze, smoke, and sky regions to appear very bright compared to the rest in the second image. In the third image, regions below a certain intensity threshold are suppressed to zero. This gives us the regions where there is a high chance of smoke or fog.

Despite the notable improvements in smoke detection using dark channel prior, there are some drawbacks to be considered. Dark channel prior tends to be unreliable when the image consists of a large portion of sky, since the sky tends to have a high dark channel value, causing the algorithm to mistake it as hazy or smoky area. This is evident in @dcp, where the sky is included in the final thresholded output image.


== Histogram Equalization

Histogram Equalization increases the global contrast in images, which can enhance the visibility of finer details within an image. The algorithm spreads the intensity values out in an image so that it utilizes the full range of values more efficiently @he. As a result, HE is most effective on images with a narrow range of intensity values.

HE's effectiveness at enhancing image quality makes it a practical technique in many scenarios.
#cite(label("shipfirehe"), form: "prose") presents a system to detect early fires inside a ship using a YOLO computer vision model. Images were preprocessed with Histogram Equalization to reduce the impact of water vapour on the quality of the images, contributing to the remarkable 99% accuracy of the model.
#cite(label("xrayhe"), form: "prose") investigates using CLAHE, an advanced form of histogram equalization along with a YOLOv4 model to detect bone fracture features in xray images, obtaining a result of 81.91% when trained on a small dataset.

Let us consider $n_i$ as the number of occurences of the gray level $i$ in a greyscale image. The probability of a pixel with level $i$ is as follows:

$ p(i) = n_i/n, 0 <= i < L $
  
Where $L$ is the total number of gray levels in the image. The cumulative distribution function can then be defined:

$ "cdf"(i) = sum^L_(j=0) p(j)  $

In order to achieve a flat histogram of values, the CDF must be linearized. This can be carried out by the following equation:

$ h(v) = "round"(("cdf"(v) - "cdf"_"min")/(N - "cdf"_min)) $

Where $N$ is the number of pixels in the image.

By applying this function to each pixel of the original image, we obtain a resulting image with a flatter histogram of intensities, increasing contrast and visibility in the image.

#figure(
  image("firehe.png", width: 90%),
  caption: [Histogram equalization on image],
) <firehe>

= An Improved Smoke Detection System

Using Dark Channel Prior to preprocess images has proven to be worthwhile for improving detection accuracy @dcpsmoke @dcpsmoke2. By isolating smoke areas from other background noise in the image, DCP simplifies classification for a neural network, allowing for better results on smaller datasets and shallower, faster models. However, DCP fails to be effective in images that contain other artifacts of high light-intensity, such as the sky. This could cause inconsistent results particularly in terrestrially placed detection nodes, where the camera might have small parts of the sky in frame.

A method to address this shortcoming using edge detection is explored. Generally, we can assume that smoke in an image is more noisy and contains contours and textures that a plain sky would not have. This texture can be picked up by a Sobel operator in an edge response image. The response image may be used to identify areas with very little edge response which can safely be eliminated from consideration.

#figure(
  image("sobelsky.png", width: 60%),
  caption: [The sobel edge filter has close to zero response on sky regions],
) <sobelsky>

In order to eliminate certain areas of an image from being considered in the DCP algorithm, a binary threshold can be used on the image, which will either suppress pixels to zero or change them to max value depending on a thresholding condition. This can be useful for creating a map of unwanted sections in an image that can be suppressed at a later stage. We can provide the Sobel filtered image to a binary threshold to supress only parts of the image which have an edge response very close to 0. The resulting image mask would be black in sky areas, allowing us to effectively detect sky regions.

#figure(
  image("edgedcp.png", width: 60%),
  caption: [Edge Detection & DCP Filtering to detect smoke without conflating sky regions],
) <edgedcp>

In @edgedcp, A sobel filter as well as dark channel prior image is computed from the original image. The edge response image is generously dilated and blurred in order to mitigate small dark spots in the image as they are irrelevant. After applying a binary threshold, this image is used on the DCP output to suppress the pixel regions of sky.

= Experimental Results

The dark channel edge detection system was tested on various images as well as on a large smoke & fire dataset to benchmark speed & computational intensity, which are important in edge computing systems. The tested images show that the algorithm effectively separated smoke from sky and other unwanted noise, also being able to suppress the image completely in cases of no detected smoke or haze.

Notable weak points of the algorithm include differentiation between smoke and clouds. Smaller clouds with visible edges and contours can appear similar, which may reduce the algorithm's accuracy. Darker smoke such as those from burning fossil fuels are not easily detected by the edge + dcp algorithm. Since dark channel prior favours high light intensity values, dark gray or black smoke does not have any characteristics that DCP can detect.

#figure(
  image("results0.png", width: 60%),
) <r0>

#figure(
  image("results1.png", width: 60%),
) <r1>

#figure(
  image("results2.png", width: 60%),
) <r2>

#figure(
  image("results3.png", width: 60%),
) <r3>

#bibliography("ref.bib", style: "apa")
