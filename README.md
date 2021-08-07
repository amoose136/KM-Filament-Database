# KnoxMakers Filament Database
This is the website source for the the Knoxmakers Filament Database. The website is constructed with a MariaDB backend managed by Prisma ORM. The frontend is built using Nuxt.js which is in turn built on Vue.js. An advantage of this is that javascript runs on both the front and backend so code is completely portable. 
## Installation and Setup

```bash
$ git clone https://github.com/amoose136/KM-Filament-Database
```
Then you will need to add an `.env` file with the login info to your own local `filament` database. The url format used by Prisma is described [here.](https://www.prisma.io/docs/reference/database-reference/connection-urls) One way you might do this is with the below command (replacing the `username` and `password` with your own):
```bash
$ echo 'KM_DATABASE_URL = "mysql://username:password@localhost:3306/filament"' > .env
```
Then it's a normal install from there:
```bash
# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm run start

# generate static project
$ npm run generate
```