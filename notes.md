This is my notes from people's talks. Other tabs will include examples of things I learned.
This tab will include things that were new to me, or particularly worth sharing.

Reactivity
==========

Quiz:

1. No
2. Yes
3. Yes
4. (distracted)
5. No
6. No (*wrong*)
7. No

* `output$plot1 <- renderPlot(...)` means _this is how_, not _do this now_.
* It's important to have plenty of coffee, if you're running a conference.
* Outputs that aren't visible cause reactive expressions that feed them not to run (
unless some other output depends on them).
* "options(shiny.reactlog=TRUE) is the kind of magic you come to #shinydevcon for :)" -- https://twitter.com/earino/status/693507747241816064
* "the dark side of Observers" -- perform actions in response to changing reactive values. 
Execute once, plus when inputs change. _Implicit_ use `observe({})`; _Explicit_ use
`observeEvent(eventExpr, {...})` where only inputs in first expression are dependencies.
* Joe Cheng is funny.
* `reactive()` are _lazy_, _cached_, and _reactive_. Order of execution is hard to reason
about. `observe()` are _eager_, (caching is N/A), and _reactive_. 
* `reactive()` is for calculating values, without side effects; `observer()` is for
performing actions, with side effects. <- *punchline*
* check out [shinySignals](https://github.com/hadley/shinySignals) 
package that, among other things, let you throttle reactivity from things that change quickly.
* _do the remaining exercises!_

Lunch
=====

* SF can be cold in January

Interactive Graphics (Winston Chang)
====================================

* [slides](bit.ly/23Av4Y3)
* Easy thing: return X/Y coords to the server. In `plotOutput`, add `click="plot_click"`.
In a reactive, `input$plot_click$x` now works. Returns in data coordinates, not pixels.
* `nearPoints()` takes data, `input$plot_click$`, and details; returns subset of data.
* `reactiveValues` generates something very much like the `input` object, which can be used in
similar ways. Handy for what Winston calls "state accumulation".
* `stopApp` is in new widgets functionality; returns a value from the app to calling code.
* `click`, `dblclick`, and `hover` options in `plotOutput` let you attach actions to graph
interactions. E.g., can display info about a point when hovering over it.
