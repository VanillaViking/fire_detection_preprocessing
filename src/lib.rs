use std::{collections::HashMap, error::Error};
use image::{ImageReader, Rgb};
use rand::Rng;
use rand::seq::SliceRandom;

#[derive(Debug)]
pub struct Config {
    pub image_path: String, 
}

impl Config {
    pub fn build(mut args: impl Iterator<Item = String>) -> Result<Config, &'static str> {
        args.next(); 

        let image_path = match args.next() {
            Some(value) => value,
            None => return Err("no input file path provided"),
        };

        Ok(Config {
            image_path
        })
    }
}
