# Guessmoji

[Guessmoji](https://guessmoji.io) is a website where users can post emojis representing movies, and other users can guess which movie they represent. 

## Technologies used

[Guessmoji](https://guessmoji.io) was developed using the following technologies:

* [Elixir 1.6.6](http://elixir-lang.org/)
* [Phoenix 1.3.3](http://phoenixframework.org/)
* [PostgreSQL 10.3](https://www.postgresql.org/)

## How to run locally

1. Clone this repository:

   ~~~ sh
   git clone https://github.com/elomarns/guessmoji.git
   ~~~

2. Go to its directory:

   ~~~ sh
   cd guessmoji
   ~~~

3. Install the dependencies:

   ~~~ sh
   mix deps.get
   cd assets && npm install
   ~~~

4. Setup the database:

   ~~~ sh
   mix ecto.setup
   ~~~

5. Start the Phoenix server:

   ~~~ sh
   mix phx.server
   ~~~

The application will be started on your local computer on port 4000: [http://localhost:4000](http://localhost:4000).

## Deploy

You can use [Distillery](https://github.com/bitwalker/distillery) and [Edeliver](https://github.com/edeliver/edeliver) to deploy [Guessmoji](https://guessmoji.io) to your own server. Just make sure to edit the file ```.deliver/config``` with the data for your server. After that, run the following commands for your first deploy:

1. Build the release:

   ~~~ sh
   mix edeliver build release production --verbose
   ~~~

2. Deploy the release:

   ~~~ sh
   mix edeliver deploy release to production
   ~~~

3. Conect to your PostgreSQL production server:

   ~~~ sh
   psql -U YOUR_USER -h YOUR_HOST -d postgres
   ~~~

4. Creathe the production database:

   ~~~ sql
   create database guessmoji_prod;
   ~~~

5. Exit PostgresSQL client:

   ~~~ sh
   \q
   ~~~

6. Start the application:

   ~~~ sh
   mix edeliver start production
   ~~~

7. Run the migrations:

   ~~~ sh
   mix edeliver migrate production
   ~~~

Below you can find additional references to help you with this process:

* [Deploy Early and Often: Deploying Phoenix with Edeliver and Distillery (Part One)](https://medium.com/@zek/deploy-early-and-often-deploying-phoenix-with-edeliver-and-distillery-part-one-5e91cac8d4bd)
* [Deploy Early and Often: Deploying Phoenix with Edeliver and Distillery (Part Two)](https://medium.com/@zek/deploy-early-and-often-deploying-phoenix-with-edeliver-and-distillery-part-two-f361ef36aa10)
* [Secure Your Phoenix App With Free SSL
](https://medium.com/@zek/secure-your-phoenix-app-with-free-ssl-48ac749c17d7)

## License

[Guessmoji](https://guessmoji.io) is released under the [MIT License](https://opensource.org/licenses/MIT).
