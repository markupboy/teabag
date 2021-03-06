console.log("testing console output")

test "doesn't need a module", ->
  ok(passing == true, "Passing is true")

module "Teabag running QUnit"

test "is awesome", ->
  ok(passing == true, "Passing is true")


module "Running tests",

test "actually tests", 1, ->
  fixture("fixture.html")
  ok(document.getElementById("fixture_view").tagName == "DIV", "loads the fixture")

test "can handle more than one test", ->
  expect(1)
  stop()
  setTimeout ->
    ok(passing == true, "Passing is true")
    start()
  , 1000


module "Failing tests"

test "can fail", ->
  ok(failing == false, "Failing is false")
  ok(failing == false, "Failing is false")


fixture.preload("fixture.html", "fixture.json") # make the actual requests for the files
module "Using fixtures",
  setup: ->
    fixture.set("<h2>Another Title</h2>") # create some markup manually
    @fixtures = fixture.load("fixture.html", "fixture.json", true) # append these fixtures

test "loads fixtures", ->
  ok(document.getElementById("fixture_view").tagName == "DIV", "is in the dom")
  ok(@fixtures[0] == fixture.el, "has return values for the el") # the element is available as a return value and through fixture.el
  ok(@fixtures[1].title == fixture.json[0].title, "has return values for json") # the json for json fixtures is returned, and available in fixture.json
