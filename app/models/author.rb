# frozen_string_literal: true

class Author < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :recipes, dependent: :nullify
end
