require './es_client.rb'

query = ARGV[0]
min_should_match = query.length > 7 ? "#{(((query.length - 3.0)/query.length) * 100).ceil}%" : "100%"

body = {
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "word.autocomplete": {
              "query": query,
              "minimum_should_match": min_should_match
            }
          }
        }
      ],
      "filter": [
        {
          "script": {
            "script": {
              "source": "doc['word.keyword'].value.length() >= #{query.length}"
            }
          }
        }
      ]
    }
  }
}

puts ES.search(index: "autocomplete_words", body: body).dig("hits", "hits").to_a.map { |hit| hit.dig("_source", "word")}