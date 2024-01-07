Simple words autocomplete functionality via ElasticSearch.

Run `docker-compose up` to prepare ElasticSearch instance.

Install deps with `bundle install`

To create index and add words run:

```
ruby create_index.rb
```

To check autocomplete run

```
ruby search.rb query
```

Examples:

```
> ruby search.rb metal 
metal
metals
metallic
metallike
metalloid
metalwork
metalepsis
metallurgy
metalanguage
metallurgist
```

```
> ruby search.rb metallerh
metallike
metalloid
metallurgy
metallurgist
metallography
metallurgical
```