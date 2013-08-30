NLP = require 'stanford-simple-nlp'

nlp = new NLP.StanfordSimpleNLP (err) ->
  return console.log err  if err?
  console.log 'Stanford CoreNLP initialized.'



exports.index = index = (req, res) ->
  res.json
    welcome: 'stanford-simple-nlp-server'
    version: '0.0.1'


exports.parse = parse = (req, res) ->
  sourceText = req.body.sourceText

  return res.send 400, 'no sourceText'  if not sourceText?

  nlp.process sourceText, (err, result) ->
    return res.send 500, err.message  if err?

    result.sourceText = sourceText
    res.json result
