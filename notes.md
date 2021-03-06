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
* Spent a lot of time dwelling on standard fuctional structure. Set up modules the same way,
with inputs as arguments and outputs as return values, using reactive expressions.
* E.g., return the input: `reactive({input$num})`, store in a variable, and use it elsewhere.
* Use case examples: loading a CSV and returning the result, giving an input to a module.
* [Documentation](http://shiny.rstudio.com/articles/modules.html).

Debugging (Jonathan McPherson)
==============================

* Breakpoints can inspect local stack, step through, non-intrusive, only works inside server. 
(Doesn't work with modules, apparently.)
* Conditional `browser()` valid everywhere, but intrusive.
* `runApp(..., display.model="showcase")`! Shows server execution. Doesn't scale well.
* `options(shiny.reactlog=TRUE)` + `showReactLog()` creates a static HTML version of the log.
* `printf` works after deployment; use `isolate()` to minimize new dependencies. (I 
recommend use of `futile.logger` package.)
* on shinyapps.io, do `rsconnect::showLogs(streaming=TRUE)`! 
* `options(shiny.trace=TRUE)` shows websocket data.
* New v0.13 feature shows filtered stack trace on `stop`. 
* `options(shiny.error=browser)`.
* JS Dev mode on OS X is Safari parameter. `defaults write org.rstudio.RStudio WebKitDeveloperExtras -bool true` then restart. Allows right-click and InspectElement, which
works without this on Linux and Windows.

Understanding UI (Garrett Grolemund)
====================================

* Three methods for building UI: 1) Standard UI.R
R functions, 2) HTML + Shiny components, 3) HTML + R for
Shiny components (htmlTemplates).
* Usual R functions, e.g. `fluidPage`, generate straight HTML body. 
* `includeCSS()`, `includeHTML()`, `includeMarkdown()` <- didn't know about this! Changing 
how this is embedded...
* `index.html` method involves putting in `www` directory and omitting `ui.R`, adding
ids and classes and including relevant Javascript libraries.
* New thing is `htmlTemplates`. Put R code in `{{ x }}` in the HTML, then call `htmlTemplate()`
to interpolate. Can use templates for components of bigger page too.
* See [Joe's demo](https://github.com/jcheng5/scorecard-app)

Dashboards (Nathan Stephens)
============================

* `reactiveFileReader()` to load CSV file of saved load, reloading frequently based on file
modified time.
* `reactiveFileReader` is based on `reactivePoll` which is based on `invalidateLater`.

Profiling (Winston Chang)
=========================

* Can use `Rprof` in Shiny apps. `profvis` package can be handy; wrap expression.
* Have to wrap the entire app. All code must be in the profvis block. Or, can use normal
`Rprof` to collect data, then `profvis` to visualize.
* May be more integrated in the future.

Data tables  (Yihui Xie)
========================

* `DT` uses `htmlwidgets` to interface between R and Javascript.
* Example of sending selection info from the JS front-end back to R, and using that to
change display of a linked graph: http://yihui.shinyapps.io/DT-click 
* Vice-versa: http://yihui.shinyapps.io/DT-proxy

shinyjs (Dean Attali)
=====================

* Slides linked here: https://github.com/daattali/shinyjs
* Todo: learn how to make [snippets](https://support.rstudio.com/hc/en-us/articles/204463668-Code-Snippets) for things, e.g., Shiny app templates.
* Sandbox: `shinyjs::runExample("sandbox")`
* Includes a delay function for things like hide/show to improve UI.
* Can wrap things in divs to act on groups.
* `toggleState` handy to enable/disable buttons based on checkbox value.
* `hidden(div(id="thanks", h3("Thanks!")))` + `show("thanks")` + `delay(2000, hide("thankyou"))`
* Works with interactive Rmarkdown too.
* `extendShinyjs()` lets you call JS functions from within `server.R`

Lightning Talks
===============

* `mytinyshinys.shinyapps.io/dashboard`. `timeline` and `explodingboxplotR` packages.
* Radiant package/app for business analytics. Saves state.
* App for exploring inequality in health by country. Avoiding repeated redrawing from linked
inputs -- best practice unclear?
* Wordbank (Lang & Cog @ Stanford) -- collection of MacArthur-Bates CDI data. Interactive
apps for overall and per-lexeme. 
* `shinypod` package with modules for CSV loading and time-series viz. "reactive ravioli" -- encapsulated.
* Board Pack app to interactively create commented versions of reports for execs. 

Grid style sheets (Yihui Xie)
=============================

* "advanced layout libraries from the future"
* http://gridstylesheets.com -- declarative constraints on tag properties
* Experimental R package that wraps it. Will be cool, I think.

Friss (Herman Sontrop)
======================

* Very complex dashboards with a mix of Shiny and Javascript
* Has red/yellow/green risk scores
* c3.js, intro.js used extensively
* Coming soon: https://github.com/FrissAnalytics/shinyJsTutorials 