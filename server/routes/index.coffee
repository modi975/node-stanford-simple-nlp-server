NLP = require 'stanford-simple-nlp'
nlp = new NLP.StanfordSimpleNLP()
nlp.loadPipelineSync()
console.log 'Stanford CoreNLP initialized.'

fs = require 'fs'
packageConfig = JSON.parse fs.readFileSync "#{__dirname}/../../package.json"


exports.index = index = (req, res) ->
  res.json
    welcome: packageConfig.name
    version: packageConfig.version


exports.parse = parse = (req, res) ->
  sourceText = req.body.sourceText

  return res.send 400, 'no sourceText'  if not sourceText?

  nlp.process sourceText,
    xml:
      explicitRoot: false
      explicitArray: false
      attrkey: '@'
  ,
    (err, result) ->
      return res.send 500, err.message  if err?

      result.sourceText = sourceText
      res.json result
