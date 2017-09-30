Change Log
----------
* 2017-09-30
    * Inserted translations

* 2017-09-29
	* Changes to FAQ page

* 2017-09-26
    * Filters not reset after search term change
	* Added selected filters under the main search field 
	* Added reset filters button
	* Updated dependencies

* 2017-09-16
    * Removed archived date for collection sites where Solr does not return it
	* Removed number of sites if no sites in collection
	* Remved the word "total" from number of sites and added singular/prular destinction

* 2017-09-14
    * Help tips triggering when using keyboard issue fix
    * Fixed main search input field Android issue

* 2017-09-13
    * Fixed search results numbers don't tally issues
	* Fixed layout alignment issues

* 2017-09-11
    * Fixed inconsistent search results

* 2017-09-08
    * Fixed contact and nominate form language issues

* 2017-09-03
    * Added capcha to nominate and contact forms
	* Removed back buttons if pages opened in new window
	* Additional WCAG2 fixes
	* Links in search tips are now functional

* 2017-08-29
    * Issue #5 Reimplemented search using SolrJ to work for all search types 
    * Adapted keyword highlighting to work with the new search implementation

* 2017-08-18
    * Deep paging notice visual fixes
	* Added translation placeholders

* 2017-08-17
    * Fixed search with logical operators
	* Removed deep paging

* 2017-08-16
    * Removed possibility of deep paging issues when using URL
	* Added custom error pages separate for types of errors.

* 2017-08-15
    * Added reading room only notification to SC with IP sniffing

* 2017-08-14
    * Added custom error page

* 2017-08-11
    * Form sending fixes
	* Footer link fixes
	* Custom error page added

* 2017-08-09
	* Changed warning text from red to black for reading room sites when user is on premises
	* Commented application.properties file

* 2017-08-04
    * Added mapping for different URL prefixes in different reading room locations

* 2017-08-03
    * Added IE9 support

* 2017-08-01
    * Added ALT text to special collections images
    * Added mail send support to Contact and Save a UK site forms
    * Removed not needed dependencies
    * Added correct survey URL
	* Fixed pagination in SC

* 2017-07-31
    * Fixed text mistakes
    * Added aria-* attributes to accordion elements
    * Added reading room IP ranges

* 2017-07-28
    * Added IP sniffing for Access facet
    * Resized logos for better quality

* 2017-07-26
    * Added missing help texts

* 2017-07-26
    * Inserted texts from BL
    * Fixed breadcrumbs for subcollections on SC page
    * Added nesting of subcollections to SC list (only in list view)
    * Added total number of sites in collection to SC page
    * Added "no results" notice to main search filters
    * Added "no results" notice to main search


* 2017-07-24
    * Added supplied SC images
    * Added "No resuts" notification if no sites in collection
    * Added "no description" text if no SC description
    * Footer separated to 3 columns
    * Added white border to cookie message
    * Alignment fixes
    * Changed colors in main logo
    * Moved "Viw all Special Collections" button
    * Changed SC titles
    * Added cookie policy page

* 2017-07-19
    * Search term highlighting
    * Cookies acknowledgement added.
    * Survey pop-up added.
    * Various layout and accessibility improvements, desktop and mobile.
    * "Viewable only on Library Premises" now includes open access material.
    * Use "type" facet instead of "content_type_norm" for Document Type.
    * Special Collections are now ordered alphabetically.
    * Add an X button to reset dates.
    * Display number of results in brackets for the Access facet.
    * Format numbers in search results to 1,000,000.
    * Detect URLs and output them as the top search result.
    * Fix the CI build by removing the test.
    * Check that the From date is before the To date.
    * Google Analytics code added.

* 2017-07-11
    * Changed font embeddability to "Installable" for IE browser
    * Mobile browser fixes

* 2017-07-10
    * Language links separate from main navigation
    * Changed Special collections heading
    * Welcome text in 2 paragraphs, added "About us" link
    * Changed "Nominate a site" to "Save a UK website"
    * Added underline to footer links
    * Added cookies notice
    * Removed "Back to the list" from SC page
    * Added top pagination to collections
    * Removed list of all SCs from sidebar
    * Added list and thumbnail view to collections
    * Removed images for subcollections
    * Added "X" button to date selection in search
    * Added search tips text
    * WCAG2 fixes: WCAG-001, WCAG-006, WCAG-002, WCAG-003, WCAG-011, WCAG-013, WCAG-014, WCAG-016, WCAG-007, WCAG-008, WCAG-015, WCAG-012

* 2017-07-03
    * WCAG2 fully fixed
    * Removed mappings for pages which will be done in phase 2
    * Added mappings for Terms and conditions, Privacy and Technical information pages
    * Finished FAQ and Technical information pages
    * Changed OpenSans Regular font to OpenSans Semibold
    * Larger footer icons and added links to footer icons
    * Removed "More information..." heading in the footer
    * Removed live URL from collections
    * Added blog URL to footer menu
    * Added favicon
    * Shortened long URLs in collections

* 2017-06-29
    * Added full descriptions to collections
    * HTML search filter selected by default
    * WCAG2 changes to pages (where applicable)

* 2017-06-29
    * Remove copyrighted icons

* 2017-06-11
    * Remove copyrighted images.
    * Use OpenSans fonts throughout the website.
    * Use a default image for collections that haven't been assigned an image.
    * Fix radio buttons that did not render correctly under "Are you the copyright holder or owner of the website?" on ukwa/info/nominate.
    
* Open Access / Library only (2017-05-18)
    * Faceting by access_terms added.
    * Search results are now sorted by date archived (Newest to Oldest / Oldest to Newest).
    * Number of search results per page can now be chosen by users.
    * Various layout improvements.
    * The middle column of the search results grid was removed as per the new UI mockups.
      The column used to contain "Date Archived" and the domain.
      "Date Archived" has been moved next to the target title.#
    * Switched from beta to dev Solr instance. Don't forget to update Solr credentials during deployment.
    * The website will now display an error page if Solr credentials are incorrect. 
      Previously it showed "0 results found".

* The New UI (2017-05-17)
    * UI styled as per approved mockups (menu on top).
    * Title / Full Text toggle removed. Currently defaults to Full Text.
    * New collection images added.
    * Logging to a file (file name set in application.properties).

* Search Improvements (2017-05-15)
    * Facets "Restrict by Archiving Organisation" and "Restrict to a subject" removed.
    * Domain and Public Suffix facets added.
    * The Collection facet is functional now.
    * Facet values and counts are now taken from Solr.
    * 'From' and 'To' are now dates, not just years.
    * Various layout improvements (still the 'old' UI, new UI coming in the next drop).
    * More UI elements localized.
    * FIXED: Home link not preserving language selection.
    * FIXED: Exception when Solr returns duplicate hosts.
    * FIXED: Domain links in search results.
    * Improved performance when navigating to the last page of the search results.
    * Logging added (logs to stdout currently, file logging to be added later).

* Post-Drop 1 (2017-03-09)
    * Added search filters: doc type, public suffix and date.
    * Added search results pagination.
    * Better collection images, collection names are now clickable.
    * Other minor fixes.
