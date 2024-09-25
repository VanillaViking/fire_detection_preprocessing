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
This report aims to explore different methods employed in improving the performance and efficiency of video-based remote fire detection systems devices to achieve best possible results.

// add more shi
UAVs have seen extensive research for this application, as they provide valuable visual data which can be employed to carry out search and rescue operations, save forest resources, help firefighters navigate efficiently amoung numerous other enhancements. Rather than sending ground crews to monitor hazardous environments, UAVs can drastically reduce the risk to firefighting crews by remotely scanning large amounts of dangerous forest area. However UAVs tend to perform poorly in harsh weather conditions, have limited flight time and require a human operator to have a visual line of sight @uav. These factors combined with expensive operation costs severly limit the effectiveness of UAVs in many circumstances. 

Edge computing sensor nodes can be placed at high risk locations that can monitor temperature, humidity and other characteristics of air in the surrounding area. These systems generally use a microcontroller to operate sensors, relying on solar cells for long-term power. By setting up multiple such nodes in different areas forming a Wireless Sensor Network (WSN), the collected sensor data may then be analyzed to determine the locations of fire events @MohapatraAnkita2022EWDT. More advance methods of data classification with the use of artificial neural networks boast a high accuracy of >82% with multiple sensors @wsnfire. The low cost of WSN systems has made it an increasingly popular choice for real-time monitoring of forest fires. However, sensor nodes fail to be viable in some situations. Establishing wireless communications for a WSN can prove challenging in rural or untamed areas such as forests @Talaat2023. The sensor nodes may also be prone to damage from the wildfire, needing to be replaced in order to continue using the system. 

 Satellite-based fire detection can potentially offer significant advantages over traditional methods due to the vast areas they can monitor. The benefits and limitations of these systems largely depend on the satellite's orbit. Satellites in Sun-Synchronous Orbit (SSO) provide high spatial resolution but revisit the same location only after several days, resulting in low temporal resolution. This delay makes SSO satellites less effective for real-time wildfire detection @satellite. In contrast, Geostationary Earth Orbit (GEO) satellites remain fixed over the same region, as their orbital period matches Earth's rotation. Equipped with multispectral imaging sensors, GEO satellites provide continuous monitoring, making them ideal for detecting and tracking fires in real time.

Despite the various classifications of technologies within wildfire detection, advancements in computer vision object detection has spurred use in terrestrial, aerial as well as satellite systems. 
#cite(label("satellite"), form: "prose") explores the feasibility of space-borne fire detection using onboard computer vision to rapidly generate alerts. The traditional method of downloading image data from satellites has too much latency for time-sensitive applications such as fire detection. By examining performance of hardware accelerators for edge computing such as Nvidia Jetson and Movidius Myriad 2, the report found that AI inference on-board the satellite is possible in terms of performance as well as power consumption, allowing for low latency detection of wildfires.
#cite(label("uavai"), form: "prose") details methods to optimise Deep Learning to deal with UAV limitations such as image degredation, small fire size & background complexity. By combining EfficientNet-B5, vision transformers and EfficientSeg convolutional model, an accuracy of 85.12% was obtained, outperforming many state-of-the-art models.
#cite(label("wsnyolo"), form: "prose") proposes a low cost WSN fire detection approach based on YOLO object detection models. The system, named SDFS was trained on a dataset of 26,520 images and achieved a high precision rate of 97.1% for smoke and fire classification.

Image pre-processing using techniques such as HSV filters and corner detection has observed to improve accuracy by 5.5% in object detection models @prepfire.

#bibliography("ref.bib", style: "apa")
