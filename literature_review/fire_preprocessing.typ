#import "@preview/wordometer:0.1.1": word-count, total-words

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
#show: word-count

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

 Satellite-based fire detection can potentially offer significant advantages over traditional methods due to the vast areas they can monitor.
 The benefits and limitations of these systems largely depend on the satellite's orbit.
 Satellites in Sun-Synchronous Orbit (SSO) provide high spatial resolution but revisit the same location only after several days, resulting in low temporal resolution.
 This delay makes SSO satellites less effective for real-time wildfire detection @satellite.
 In contrast, Geostationary Earth Orbit (GEO) satellites remain fixed over the same region, as their orbital period matches Earth's rotation.
 Equipped with multispectral imaging sensors, GEO satellites provide continuous monitoring, making them ideal for detecting and tracking fires in real time.

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

 This paper contributes a benchmark of different pre-processing filters and algorithms to uncover insights on an ideal pipeline for wildfire detection, using metrics such as speed, power consumption and model accuracy. The benchmarks are carried out on a Raspberry Pi 4B, to similate low-powered edge computing hardware that is consistently used in terrestrial, UAV and satellite systems. Large deep-learning networks are unviable on these systems due to the high computational intensity, while models with reduced parameters are more efficient but suffer from less accurate inference. The preprocessing pipeline aims to improve the accuracy of lightweight models by highlighting important features in fire and smoke, while reducing unwanted noise in the image. For classification, 

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

== Corner Detection

Corner detection is a common technique used in computer vision to infer features from an image. The Harris corner detector uses the autocorrelation function of the image to determine intensity differences within patches of an image. Using a Taylor expansion, the autocorrelation function can be approximated as @prepfire @harriscorner:

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

== Contour Detection

== Dark Channel Prior

== Optical Flow

== Blurring

== Histogram Equalization




#bibliography("ref.bib", style: "apa")
