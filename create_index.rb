require './es_client'

index_body = {
  "settings": {
    "analysis": {
      "analyzer": {
        "autocomplete_analyzer": {
          "type": "custom",
          "tokenizer": "autocomplete_tokenizer",
          "filter": ["lowercase"]
        }
      },
      "tokenizer": {
        "autocomplete_tokenizer": {
          "type": "edge_ngram",
          "min_gram": 1,
          "max_gram": 25,
          "token_chars": ["letter", "digit"]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "word": {
        "type": "text",
        "fields": {
          "autocomplete": {
            "type": "text",
            "analyzer": "autocomplete_analyzer"
          },
          "keyword": {
            "type": "keyword"
          }
        }
      }
    }
  }
}

ES.indices.create(index: "autocomplete_words", body: index_body)

File.readlines("./wordlist.txt", chomp: true).each do |word| 
  puts word;
  ES.index(index: "autocomplete_words", body: { word: word })
rescue
  retry
end