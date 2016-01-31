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

Shiny Gadgets (Hadley)
======================

* For _programming_, used by _analysts_, _invoked_ instead of deployed.
* Three differences: _called_, _display_ in Rstudio, _returns_ a value.
* Example: get password without risking storing it in the history. 
* New UI widgets, `stopApp`, `runGadget`.
* Example, visually include/exclude points in a scattergraph, return vector to script.
* [RStudio Add-Ins](https://rstudio.github.io/rstudioaddins/): 
Create a package with some bindings lets you plug into RStudio!
Uses `rstudioapi` package.
* Other ideas: color picker, dynamic filtering, plot builders. Things that are hard to 
express in code but want to do reproducibly.

Hosting Apps (Jeff Allen)
=========================

* Seamless reconnecting is coming soon. Can be very long timeout in SSP.
* New product coming soon: RStudio Connect. Hub for sharing outputs of RStudio with easy
deploying and management.
* Seems useful for results of research workflows.
* Can re-generate Rmd reports on the server -- useful for reporting. Interactively or on
a schedule. Replaces reporting systems.
* Substantially improves value of logs.
* Parameterized reports. "Knit with Parameters" lets user set variables before running.
* Beta is available now.

Lightning Talks
===============

* My talk was fun. Hadley only glared a little.
* Really entertaining talk about a Shiny app that's the front end for a home bar optimization
tool.
* [hdnom.io](http://hdnom.io/) -- dashboard for survival modeling with high-dimensional inputs. 
Very cool work. New vocab: nomogram.
* [shinyURL](https://github.com/aoles/shinyURL) package for save/restore state to a URL. Could
be useful for certain smaller internal apps.
* Reproducibility in UIs is hard. Each widget stores a copy of the code used. 
[Example site](www.intro-stats.com). Generates code block that can be downloaded.
Uses `interpolate()` to fill in code templates. 

### Genentech (Brandon Arnieri)	

* Describes results from clinical trials. Internal decision-making. 
Shiny as presentation tool. Gives a voice to people good at R.

### AirBnB (Ricardo Bion)	

* "Decisions with data at scale". 70 people in all data roles -- 100k pageviews on Shiny.
* Created app for internal users to explore definitions for Superhost program. 
* Marketing ROI calculator, using `diagrammeR`. 
* Dashboard using pre-aggregation (map-reduce) of many data sets. 
* Dashboards for presentation.
* Kd-trees for clustering listings and putting on a map.
* Customizations: Javascript for RCharts, CSS and themes for branding. 
* Other tools: Batch jobs that generate static site. RMarkdown. Tableau. 
Custom tool called Panoramix. Moving past Shiny prototypes.
* Pick 3: Easy to code, inspectable, customizable, easy to deploy, free.
* Very nice talk.

Modules (Garrett G)
===================

* Modules are self-contained and composable. For reuse and isolation. Code pattern.
* Two functions: UI and Server. UI task returns Shiny UI & a namespace.
* Best practice for naming: `asdf()` and `asdfUI()`. 
* Use `tagList()` for the UI returns. Use `NS()` to create simple namespace convention.
* For server functions, have to use `session`, but don't use `NS`. Instead, use
`callModule(serverFn, id)` which rescopes `serverFn`. 