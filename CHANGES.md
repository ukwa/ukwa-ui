Change Log
----------

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