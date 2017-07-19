# i18 Guidelines

Currently three languages are suppored:

| Language        | File                   |
|-----------------|------------------------|
| English         | messages.properties    |
| Welsh           | messages_cy.properties |
| Scottish Gaelic | messages_gd.properties |

Each file is a standard Java .properties file with `key=value` pairs on each line.

We allow for HTML in properties, otherwise we would have to break formatting-rich text into pieces that are too small to be manageable:

    terms = <h2>1. GENERAL</h2> <p>1.1 If you use the Archive you agree to be bound...

HTML entities must be escaped, e.g. "Terms &amp; Conditions".

Generally, scripts, links and inline styles should be avoided in .properties files. As an exception, we kept the SurveyMonkey links in .properties in case we need to have different surveys in different languages.

