# UKWA UI

A new user interface for the UK Web Archive

### How to Run the Code ###

* Install a git client of your choice.
* Clone this repository.
* Install [IntelliJ IDEA](https://www.jetbrains.com/idea/).
* Open the code in IntelliJ IDEA.
* Go to Run -> Edit Configurations.
* Click + in the upper-left corner of the dialog and add a Maven configuration.
* On the "Parameters" tab, enter "spring-boot:run" in the "Command Line" field.
* Specify Solr credentials:
    * On the "Runner" tab, click on three dots next to "Environment variables".
    * Сlick the "plus" button to add two new variables: SOLR\_USERNAME and SOLR\_PASSWORD.
    * Click OK to close the dialog.
* Click OK to close the dialog.
* Go to Run -> Run (Shift-F10). Wait for the build to finish.
* Navigate to http://localhost:8080 in your browser.