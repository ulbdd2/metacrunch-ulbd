require "isbn"
require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../primo_to_elasticsearch"

class Metacrunch::UBPB::Transformations::PrimoToElasticsearch::AddIsbnSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "isbn_search", isbn_search) : isbn_search
  end

  private

  def isbn_search
    isbns.map do |_isbn|
      source_isbn_without_dashes =_isbn.gsub("-", "")

      isbn_10_without_dashes = ISBN.as_ten(source_isbn_without_dashes) rescue RuntimeError 
      isbn_13_without_dashes = ISBN.as_thirteen(source_isbn_without_dashes) rescue RuntimeError
      isbn_10_with_dashes = ISBN.with_dashes(isbn_10_without_dashes) rescue RuntimeError
      isbn_13_with_dashes = ISBN.with_dashes(isbn_13_without_dashes) rescue RuntimeError

      [
        source_isbn_without_dashes,
        isbn_10_without_dashes,
        isbn_13_without_dashes
      ]
    end
    .flatten
    .compact
    .uniq
    .presence
  end

  def isbns
    [source["isbn"]].flatten.compact
  end
end
