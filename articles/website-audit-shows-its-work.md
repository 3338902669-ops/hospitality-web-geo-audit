# A Website Audit Is More Useful When It Shows Its Work

Most website-check tools begin with a number. The number is easy to share, but
it rarely tells you what to examine next. If the score falls, which rule
failed? If it rises, did the page change or did the connection get faster?
Without the underlying response and rule, the score turns into a verdict that
outlives the evidence.

We published a small version of that evidence set for hospitality websites.
The repository contains four unmodified JSON responses from Morphos Page
Check, collected on 9 November 2026, plus the method and a script for repeating
the request.

The samples are public pages:

| Page | Report | Overall |
| --- | --- | ---: |
| Morphos Studio | `17AEDE84` | 89 |
| Morphos Page Check | `97383857` | 87 |
| Ballyfin Demesne | `EFCAD33E` | 76 |
| Ashford Castle | `A9732A23` | 67 |

The two hotel sites are test inputs. Their presence does not rank them, review
them or imply a relationship with Morphos Studio.

## What one request can inspect

Page Check fetches one public URL, follows redirects, reads the delivered HTML
and fetches same-origin CSS. It groups the checks into delivery, front-end
build, visual system, interaction and accessibility, backend posture, security
exposure and content/GEO.

That is enough to catch things such as a missing description, an ambiguous
heading order, controls without labels, images without dimensions, absent
structured data or a response header that was never configured. It is also
enough to make timing, byte counts and individual check states reproducible.

It is not enough to make some claims that people often attach to an audit.

## What a check cannot see

One HTTP request does not run JavaScript. It does not open a browser, measure
Core Web Vitals, test a booking flow, submit an enquiry form, inspect an
authenticated area or compare conversion rates. Headers can show an exposure
surface; they cannot prove that a site is secure. A high content/GEO score does
not prove that a search engine will rank the page or that an AI assistant will
cite it.

These limits belong beside the score. Leaving them out makes a narrow
inspection sound like a complete audit.

## Why the raw response matters

The JSON preserves the requested URL, the final URL, redirects, response
status, timing, HTML and CSS facts, every deterministic check and any modelled
signal. Someone who disagrees with a rule can inspect the rule. Someone
comparing two runs can see whether the page changed or only the network did.

The report is still a snapshot. It records what the server returned at one
moment. It does not prove that every visitor received the same response.

For a hotel, venue or restaurant team, that distinction is practical. A failed
delivery check belongs with the hosting team. A missing label or heading
problem belongs with the site owner and front-end developer. A content/GEO
finding may need editorial work. The evidence helps assign the next action.

## Inspect the method

The method, JSON reports, PowerShell helper and limitations are public here:

https://github.com/3338902669-ops/hospitality-web-geo-audit

The free implementation is here:

https://check.morphostech.com/check

Run it on one page you already know well. Read the individual checks before
looking at the score. The most useful result is usually a specific question
that can now be tested, not a number that ends the conversation.
