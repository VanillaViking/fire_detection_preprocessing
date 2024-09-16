use std::{collections::HashMap, error::Error};
use image::{ImageReader, Rgb};
use rand::Rng;

pub struct Pixel {
    values: Rgb<u8>,
    centroid: Option<PixelCentroid>,
}
impl Pixel {
    pub fn new(value: Rgb<u8>) -> Self {
        Self { values: value, centroid: None }
    }

    pub fn adjust_centroid_dists(&mut self, centroid: &Rgb<u8>, centroid_idx: usize) {
        let current_dist = get_euclid_distance(centroid, &self.values);

        if let Some(pc) = self.centroid.clone() {
            if pc.distance > current_dist {
                self.centroid = Some(PixelCentroid {
                    index: centroid_idx,
                    distance: current_dist
                })
            }
        } else {
            self.centroid = Some(PixelCentroid {
                index: centroid_idx,
                distance: current_dist
            })
        }
    }
}

pub fn get_euclid_distance(a: &Rgb<u8>, b: &Rgb<u8>) -> f32 {
    (i64::pow(a[0] as i64 - b[0] as i64, 2) as f32 + i64::pow(a[1] as i64 - b[1] as i64, 2) as f32 + i64::pow(a[2] as i64 - b[2] as i64, 2) as f32).sqrt()
}

#[derive(Clone)]
struct PixelCentroid {
    index: usize,
    distance: f32
}


pub fn kmeans_run(k: u32, pixel_list: &mut Vec<Pixel>, iterations: u32) -> Vec<Rgb<u8>> {
    let mut centroid_list: Vec<Rgb<u8>> = Vec::with_capacity(k as usize);

    let mut rng = rand::thread_rng();
    for _ in 0..k  {
        centroid_list.push(Rgb([rng.gen::<u8>(), rng.gen::<u8>(), rng.gen::<u8>()]));
    }

    for _ in 0..iterations {
        for (idx, centroid) in centroid_list.iter().enumerate() {
            for pixel in pixel_list.iter_mut() {
                pixel.adjust_centroid_dists(&centroid, idx)
            }
        }

        let mut sums: Vec<Rgb<u32>> = Vec::with_capacity(k as usize);
        for _ in 0..k {
            sums.push(Rgb([0,0,0]));
        }
        let mut totals: Vec<u32> = Vec::with_capacity(k as usize);
        for _ in 0..k {
            totals.push(0);
        }
        for pixel in pixel_list.iter() {
            if let Some(cen) = &pixel.centroid {
                sums[cen.index][0] += pixel.values[0] as u32;
                sums[cen.index][1] += pixel.values[1] as u32;
                sums[cen.index][2] += pixel.values[2] as u32;
                totals[cen.index] += 1;
            }
        }

        for (idx, _c) in sums.iter().enumerate() {
            centroid_list[idx] = Rgb([(sums[idx][0].checked_div(totals[idx]).unwrap_or(0)) as u8, (sums[idx][1].checked_div(totals[idx]).unwrap_or(0)) as u8, (sums[idx][2].checked_div(totals[idx]).unwrap_or(0)) as u8])
        }

    }

    let mut results_list: Vec<Rgb<u8>> = Vec::with_capacity(k as usize);
    let mut mean_dists: Vec<f32> = Vec::with_capacity(k as usize);
    let mut counts: Vec<usize> = Vec::with_capacity(k as usize);

    for (idx, _c) in centroid_list.iter().enumerate() {
        let p = get_mode(&pixel_list, idx);
        dbg!(&p);
        // let p = pixel_list.iter()
        //     .filter(|pixel| pixel.centroid.to_owned().unwrap().index == idx)
        //     .min_by(|a, b| a.centroid.to_owned().unwrap().distance.partial_cmp(&b.centroid.to_owned().unwrap().distance).unwrap());

        let count = pixel_list.iter()
            .filter(|pixel| pixel.centroid.to_owned().unwrap().index == idx)
            .count();

        let sum = pixel_list.iter()
            .filter(|pixel| pixel.centroid.to_owned().unwrap().index == idx)
            .fold(0f32, |acc, e| acc + e.centroid.to_owned().unwrap().distance);

        mean_dists.push(count as f32 / sum);
        counts.push(count);

        if let Some(pix) = p {
            results_list.push(pix);
        }

    }

    dbg!(mean_dists);
    dbg!(counts);

    results_list
}

fn get_mode(pixel_list: &Vec<Pixel>, centroid_idx: usize) -> Option<Rgb<u8>> {
    let mut pixmap: HashMap<Rgb<u8>, u32> = HashMap::new();

    pixel_list.iter()
        .filter(|pixel| pixel.centroid.clone().unwrap().index == centroid_idx)
        .for_each(|pixel| *pixmap.entry(pixel.values).or_insert(0) += 1);

   pixmap.into_iter()
        .max_by_key(|&(_, count)| count)
        .map(|(val, _)| val)
}
