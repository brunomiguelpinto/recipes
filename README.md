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

## Getting Started

### Prerequisites

- Ruby version: `3.2.1`
- Rails version: `7.0.7.2`
- PostgreSQL: `14.9`

### Setup

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
   rails s
   ```

6. Access the application by navigating to `http://localhost:3000/recipes/search` or the online 
version in your browser.
