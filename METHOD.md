# Method

## Collection

1. Accept one absolute public `http` or `https` URL.
2. Fetch it server-side once, with redirects enabled.
3. Read the returned HTML without executing JavaScript.
4. Fetch same-origin stylesheet URLs declared in the HTML.
5. Apply deterministic checks to the response and those stylesheets.
6. Add separately labelled model signals where the method estimates a
   property rather than measuring it.
7. Return the source, rule and limit attached to every check.

No account is required, no page data is stored by the public API and no form is
submitted.

## Scoring

Checks are grouped as delivery, front-end, visual system, interaction,
backend, security and content. Each check has a state:

- `pass`: the delivered page meets the named rule;
- `warn`: the delivered page falls outside the preferred rule but does not
  establish a definite failure;
- `fail`: the delivered page contradicts the named rule;
- `not applicable`: the rule cannot be applied to this page;
- `blocked` or `unknown`: the evidence was unavailable.

The group score is a weighted roll-up of applicable checks. The overall score
combines the seven groups. A score is useful for finding the next inspection
target; it is not a certification.

## GEO review

The content/GEO group asks whether the delivered page gives an answer engine
stable material to extract:

- one descriptive title and description;
- a coherent heading hierarchy;
- one clear primary subject;
- question-shaped headings where a real question exists;
- definition-shaped statements that identify entities plainly;
- figures with units;
- structured data appropriate to the page type;
- machine-readable location, contact and service information where relevant;
- internal links to supporting material.

The method does not ask an AI model to invent a score. It does not query search
or answer engines, and it does not claim that a quotable page will be cited.

## Accessibility review

The HTML checks cover visible structural requirements such as:

- a declared viewport;
- one `h1` on the page;
- no skipped heading levels;
- a `main` landmark and a skip link;
- labelled inputs and real buttons;
- alt text that distinguishes content images from decorative ones;
- intrinsic image dimensions;
- iframe titles;
- focus-visible styling and reduced-motion handling observable in CSS.

These checks are not a WCAG conformance audit. They identify lines to inspect
with a browser and assistive technology.

## Security review

The security group reads response headers and delivered markup. It looks for
HTTPS, a content security policy, frame protection, MIME sniffing protection,
referrer policy, permissions policy and safe cross-origin loading. It does not
probe endpoints, run exploits or establish that a site is secure.

## Evidence

The JSON keeps the final URL, redirect count, response headers, byte counts,
script URLs, stylesheet URLs, structured-data types, every check and the
source attached to the check. A reader can therefore disagree with a rule
without having to trust the summary score.

When scores change between runs, compare:

1. final URL;
2. response status and redirects;
3. page revision or `Last-Modified`;
4. HTML and CSS byte counts;
5. individual check states.

Changing first-byte and transfer timing alone is not evidence that the page
changed.
