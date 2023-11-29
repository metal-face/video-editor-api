#[macro_use] extern crate rocket;

mod controllers;
use crate::controllers::authentication::world;

#[rocket::main]
async fn main() -> Result<(), rocket::Error> {
    let _rocket = rocket::build()
        .mount("/hello", routes![world])
        .launch()
        .await?;
    Ok(())
}
