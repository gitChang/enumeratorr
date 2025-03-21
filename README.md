# Enumeratorr

A Ruby on Rails application using Rails 7.1.5, Ruby 3.3.0, and PostgreSQL.

## Prerequisites

Ensure you have the following installed:

- **Mise** - A modern runtime version manager. Install it from [mise website](https://mise.jdx.dev/).

- **Ruby 3.3.0** - Check with:
  ```bash
  ruby -v
  ```
  Install using:
  ```bash
  mise use ruby@3.3.0
  ```

- **Rails 7.1.5** - Check with:
  ```bash
  rails -v
  ```
  Install using:
  ```bash
  gem install rails -v 7.1.5
  ```

- **PostgreSQL** - Check with:
  ```bash
  psql --version
  ```
  Install from the [PostgreSQL website](https://www.postgresql.org/download/).

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/gitChang/enumeratorr.git
   cd enumeratorr
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Configure the database:
   Edit `config/database.yml`:
   ```yaml
   default: &default
     adapter: postgresql
     encoding: unicode
     username: your_postgres_username
     password: your_postgres_password
     host: localhost

   development:
     <<: *default
     database: enumeratorr_development

   test:
     <<: *default
     database: enumeratorr_test
   ```

4. Create the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

## Running the Application

Start the Rails server:
```bash
rails server -p 3003
```
The app will be available at `http://localhost:3003`.

## Using Docker (Optional)

1. Build the Docker image:
   ```bash
   docker build -t enumeratorr .
   ```

2. Create a Docker volume:
   ```bash
   docker volume create enumeratorr-storage
   ```

3. Run the container:
   ```bash
   docker run --rm -it -v enumeratorr-storage:/rails/storage -p 3003:3003 --env RAILS_MASTER_KEY=<your-master-key> enumeratorr
   ```

Replace `<your-master-key>` with your Rails master key.

## Generating Secret Key Base

```bash
rails secret
```
Set this key in your environment variables or credentials file as needed.

---

For more information, refer to the [Rails Guides](https://guides.rubyonrails.org/), [Mise Documentation](https://mise.jdx.dev/), and [PostgreSQL Documentation](https://www.postgresql.org/docs/).

