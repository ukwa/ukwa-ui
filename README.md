# UKWA UI

User interface for the UK Web Archive

## How to Run the Code ##

* Install a git client of your choice.
* Clone this repository.

You can then run the code using the `run-against-docker.sh`. This helper script uses Docker Compose to start up two Solr services and then runs the UI using Maven.

There are scripts to populate the Solr services with example data, but the example data is not stored in this repository and is currently available on upon request.

### Running from IntelliJ

Alternatively, you can run code from IntelliJ, and configure it to use the same Solr services. Note that the username and password are not needed to run against local services.

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

## Supporting content translation ##

For the accessibility statements, most of the work was done by converting the original DOCX to HTML:

    pandoc -f docx -t html --ascii acc-cy.docx > acc-cy.html

The `ascii` flag ensures special characters are HTML/ampersand-escaped rather than relying on file character encoding.

Properties files need a bit more care, but can be mapped via spreadsheets if needed.


