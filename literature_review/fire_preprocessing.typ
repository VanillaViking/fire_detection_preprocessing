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

Satellite-based fire detection could prove to have huge advantages over alternative methods due to the vastly larger area they can cover. The advantages and challenges to consider with satellites depends on their orbit around the Earth. Satellites in Sun Synchronous Orbit (SSO) provide high spatial resolution, however they can take multiple days to see the same area again, resulting in a low temporal resolution, making SSO satellites ineffective at detecting wildfires in real time @satellite. Geostationary Earth Orbit (GEO) satellites have an orbital period that is equal to Earth's rotational period, which means that the satellite has a constant view of the same area of land. Satellites in GEO satellites are usually equipped with multispectral imaging sensors to take pictures of the Earth. 






Image pre-processing using techniques such as HSV filters and corner detection has observed to improve accuracy by 5.5% in object detection models @prepfire.

#bibliography("ref.bib", style: "apa")
