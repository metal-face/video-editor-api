#[macro_use] extern crate rocket;

#[get("/world")]
fn world() -> &'static str {
    "Hello, world!"
}

#[rocket::main]
async fn main() -> Result<(), rocket::Error> {
    let _rocket = rocket::build()
        .mount("/hello", routes![world])
        .launch()
        .await?;

    Ok(())
}
