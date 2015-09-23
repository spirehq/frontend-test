class Recipes.ListenToYourHeart extends Recipes.Bitly
  generateSteps: ->
    position = 1

    @generateStep(
      key: "GoogleChooseAvatar"
    ,
      $setOnInsert:
        cls: "GoogleChooseAvatar"
        api: "Google"
        scopes: ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds"]
      $set:
        position: position++
    )
    @generateStep(
      key: "Echo"
    ,
      $setOnInsert:
        cls: "Echo"
      $set:
        position: position++
    )

  input: (step) ->
    switch step.key
      when "Echo"
        steps = @stepsByKey()
        input =
          Echo:
            avatarId: steps["GoogleChooseAvatar"].avatarId
            messages: []
      else
        throw new Meteor.Error "Recipe:unknown-step-cls", "Can't generate input for unknown step cls '#{step.cls}'",
          recipe: @
          step: step
    input

  progressBars: (step) ->
    switch step.key
      when "Echo"
        progressBars = @generateProgressBars [
          "Echo"
        ], [
          "Echo"
        ]
      else
        throw new Meteor.Error "Recipe:unknown-step-cls", "Can't generate progress bars for unknown step cls '#{step.cls}'",
          recipe: @
          step: step
    progressBars
