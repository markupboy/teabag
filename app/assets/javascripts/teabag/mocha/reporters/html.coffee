class Teabag.Reporters.HTML extends Teabag.Reporters.HTML

  constructor: (runner) ->
    super
    @setFilter(Teabag.Reporters.HTML.filter)
    @reportRunnerStarting(runner)
    runner.on("fail", @reportSpecResults)
    runner.on("test end", @reportSpecResults)
    runner.on("end", @reportRunnerResults)


  reportSpecResults: (spec, err) =>
    if err
      spec.err = err
      return
    @reportSpecStarting(spec)
    super


  envInfo: ->
    "mocha 1.7.4"


class Teabag.Reporters.HTML.SpecView extends Teabag.Reporters.HTML.SpecView

  updateState: (state) ->
    super(state, @spec.spec.duration)
