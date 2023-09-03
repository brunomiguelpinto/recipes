# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :category, optional: true
  belongs_to :cuisine, optional: true
end