# Recipe Finder 🍲

## Overview

Recipe Finder is an advanced recipe search application that allows users to discover new recipes based on various criteria. Whether you're hunting for a dish by a specific author, looking for meals within a category, or just trying to find what you can make with chocolate, Recipe Finder has got you covered!

## Features

1. **Advanced Search**: Filter recipes by:
   - **Author**: Discover dishes from your favorite chefs.
   - **Category**: In the mood for a dessert or a main course? We got you!
   - **Cuisine**: Travel the world with your taste buds. From Italian to Japanese cuisine, we have it all.
   - **Ingredients**: Enter what you have, and we'll tell you what you can make!

2. **Sorting & Pagination**: With a vast database, Recipe Finder offers:
   - **Sorting**: Rank recipes by ratings, preparation time, cooking time, and more.
   - **Pagination**: Efficiently browse through results, 10 recipes at a time.

3. **Responsive UI**: Designed to be user-friendly and accessible across devices.

## 🚀 Getting Started

### Prerequisites

- Ruby version: `3.2.1`
- Rails version: `7.0.7.2`
- PostgreSQL: `14.9`

### 🌌 Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:brunomiguelpinto/recipes.git
   ```

2. Navigate to the project directory:
   ```bash
   cd pennylane_recipes
   ```

3. Install the required gems:
   ```bash
   bundle install
   ```

4. Set up the database:
   ```bash
   rails db:create db:migrate
   rake recipes:import
   ```

5. Start the Rails server:
   ```bash
   # Light the stove! 🔥
   rails s
   ```

6. Access the application by navigating to `http://localhost:3000/recipes/search` 
in your browser.

## 👩‍🍳 Potential Improvements

## Importing Recipes from a JSON File

### Overview
The `recipes:import` rake task facilitates the importing of recipes from a JSON file into the database. It reads the specified JSON file and iterates over each recipe to create an entry in the database.

### Usage
To execute the rake task:
```
rake recipes:import[file_path]
```
Where `file_path` is the path to your JSON file. If not provided, it defaults to `lib/recipes-en.json`.

### Efficiency Considerations

The current implementation of the rake task has some areas of inefficiency:

1. **Memory Usage**: The entire JSON file is read into memory, which can be problematic for very large files, leading to potential memory issues.

2. **Database Operations**: For each recipe, the task checks for the existence of its associated `Author`, `Category`, and `Cuisine` individually and then creates them if they don't exist. This results in a lot of individual database reads and writes which can slow down the process. Ideally, these operations should be batched to minimize the number of database interactions.

3. **Bulk Inserts**: Instead of saving each recipe individually, using a method to bulk insert the recipes would improve the performance. Rails provides methods like `insert_all` which can be utilized for such cases.

It's recommended to enhance this task by implementing a streaming mechanism for reading large JSON files and batching the database operations where possible.


## RecipeSearchService Overview

### Introduction
The `RecipeSearchService` is an integral component of the recipe application, ensuring that users can search for recipes based on various criteria such as author, category, cuisine, and ingredients. Moreover, it provides the capability to sort and paginate the results to ensure a seamless user experience.

### Features

1. **Robust Filtering**:
   - The service efficiently filters recipes based on:
      - **Author**: Using the `author_id`.
      - **Category**: Using the `category_id`.
      - **Cuisine**: Using the `cuisine_id`.
      - **Ingredients**: Leverages PostgreSQL's full-text search for ingredient filtering.

2. **Sorting**:
   - Users can sort the results based on valid fields, currently including `ratings`, `prep_time`, and `cook_time`.
   - Sorting can be ascending or descending.

3. **Pagination**:
   - To ensure optimal performance and user experience, the service paginates the results.
   - By default, it returns 10 recipes per page, but this can be adjusted.

4. **Flexible Integration**:
   - Designed as a service object, it can be easily integrated into controllers or other services within the application.

### Usage

To initiate a search, simply call the service like so:

```ruby
recipes = RecipeSearchService.call(params)
```

Where `params` is a hash containing the search and pagination parameters.


---

## Recipe Search View Overview

### Introduction

This view provides the functionality to search for recipes based on different criteria such as category, author, cuisine, and ingredients. Once a search is performed, the results are listed below the search form.

### Design & Implementation

#### Search Form

The search form uses Rails' form helpers to create various dropdowns and text fields for users to specify their search criteria:

- **Category**: A dropdown to filter by recipe categories.
- **Author**: A dropdown to filter by the author of the recipes.
- **Cuisine**: A dropdown to filter by cuisines.
- **Ingredients**: A text field where users can input specific ingredients they're looking for in a recipe.

#### Displaying Results

After a search is executed, the results are displayed in a list format. Each recipe item displays:

- The title of the recipe.
- Author, Category, and Cuisine associated with the recipe.
- Cook time and prep time.
- A list of ingredients.
- An image of the recipe (if available).

### Considerations & Improvements

1. **API Integration**:
   - While the current implementation relies on server-side rendering, this could be enhanced by making calls to an API and rendering the data on the client side. A frontend framework like React would be apt for such an implementation, allowing for more dynamic interactions and improved performance.

2. **Data Loading**:
   - Currently, all categories, authors, and cuisines are preloaded in the dropdowns. This approach is not scalable and can result in performance issues as the data grows. Instead, consider using a select box with search and suggestions (e.g., using libraries like Select2 or react-select). This minimizes the amount of data transferred between layers and offers a more user-friendly search experience.
