$ ->
  $('#submit-form').on 'click', (e) ->
    e.preventDefault
    tables  = {}
    columns = {}

    toHash = (hash, array, type) ->
      array.each ->
        hash[(($(@).data(type)))] = "#{($(@).val())}"

    compactHash = (hash) ->
      $.each hash, (key, value) ->
        if value == '' then delete hash[key]

    console.log values
    sendRequest = (hash, type) ->
      if hash
        $.each hash, (key, value) ->
          $.ajax
            type: "POST",
            url: "/ryakuzu/update_hash",
            data: { "#{type}": { "#{key}": value } },
          location.reload()


    toHash(tables, $('.tables'), 'table')
    toHash(columns, $('.columns'), 'column')

    compactHash(tables)
    compactHash(columns)

    sendRequest(tables, 'table')
