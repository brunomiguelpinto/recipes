# Recipe Search App

## Overview
The Recipe Search App is a Rails application designed to help users find recipes based on various criteria including authors, categories, cuisines, and ingredients. The application utilizes Postgres' full-text search capabilities to efficiently search through ingredients.

## Features
- **Search Recipes**: Find recipes based on specific criteria.
- **Full-Text Search**: Efficiently search within ingredients using Postgres' built-in full-text search.
- **Sort and Pagination**: Results can be sorted by ratings, prep time, and cook time. Pagination ensures results are easily navigable.
- **Associations**: Recipes can be associated with authors, categories, and cuisines.

## Design Decisions

### Ingredients as Text Instead of Separate Table
While a common approach would be to have a separate table for ingredients and join it with recipes, for this application, we decided to keep ingredients as a text column in the recipes table. This allows for more efficient full-text searches without the complexity of multi-table joins. The `to_tsvector` function in Postgres converts this column into a format suitable for text searches.

## Getting Started

### Prerequisites
- Ruby version: 3.2.1
- PostgreSQL

### Installation
1. Clone the repository:
   ```
   git clone [repository_url]
   ```

2. Change directory:
   ```
   cd recipe_search_app
   ```

3. Install dependencies:
   ```
   bundle install
   ```

4. Set up the database:
   ```
   rails db:create db:migrate
   ```

5. Start the server:
   ```
   rails s
   ```

6. Open a web browser and navigate to `http://localhost:3000`.

## Usage
Example of how to use the application or API endpoints (provide some examples).

## Running Tests
To ensure the functionality of the application, we've written specs for models and services. Run them using:
```
rspec
```
