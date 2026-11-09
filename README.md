# Hospitality Web GEO Audit

A reproducible, openly documented method for inspecting the public HTML and
same-origin CSS of hospitality websites. The method combines delivery,
front-end, visual-system, accessibility, backend-posture, security-exposure
and content/GEO checks, then keeps the raw evidence beside the summary.

Maintained by [Yifan Zheng](https://github.com/3338902669-ops) at
[Morphos Studio](https://morphostech.com/). The free implementation is at
[check.morphostech.com/check](https://check.morphostech.com/check).

Long-form note:
[A Website Audit Is More Useful When It Shows Its Work](articles/website-audit-shows-its-work.md).

## Why this repository exists

Most website-audit pages return a number and keep the reasoning out of view.
That makes the result hard to check and easy to over-read. This repository
publishes:

- the scope of each check;
- the standard or research behind it where the check names one;
- the complete JSON response for the sample pages;
- the date of collection and the exact URL inspected;
- the cases the method cannot see.

The repository is a method and evidence set. It is not a ranking of hotels,
restaurants or design studios, and a high or low score is not an endorsement.

## What one request can inspect

The free tool fetches one public URL, follows redirects, reads the delivered
HTML and fetches same-origin stylesheets. It reports seven scored groups:

1. **Delivery** — status, redirects, first byte, document weight, compression,
   cache policy and transport basics.
2. **Front-end build** — viewport, script loading, control semantics, labels,
   image dimensions and modern layout use.
3. **Visual system** — declared type sizes, colour literals, font families,
   spacing variables, layout mechanisms and motion preferences.
4. **Interaction and accessibility** — document landmarks, alt text, focus
   styling, skip links, heading structure, iframe titles and touch-risk
   indicators that can be inferred from markup.
5. **Backend posture** — headers and server-visible configuration that affect
   caching, transport and browser handling.
6. **Security exposure surface** — HTTPS, content security policy, frame
   protection, MIME protection and related response headers. This is an
   external configuration read, not a penetration test.
7. **Content and GEO** — title and description, heading order, questions,
   definition-shaped statements, figures with units, structured data and
   machine-readable contact details.

The output also includes modelled signals such as copy shape, an early-hold
estimate, answer quotability, action friction, page currency and
scannability. Those values are labelled as models in the JSON. They are not
analytics data and do not predict enquiries or revenue.

## Public samples

Captured on 9 November 2026 through
`https://check.morphostech.com/api/check`. Full responses are in
[`examples/`](examples/).

| Page | Requested URL | Overall score | Content/GEO score | Raw report |
| --- | --- | ---: | ---: | --- |
| Morphos Studio | `https://morphostech.com/` | 89 | 100 | [`examples/morphos-main.json`](examples/morphos-main.json) |
| Morphos Page Check | `https://check.morphostech.com/check` | 87 | 100 | [`examples/morphos-page-check.json`](examples/morphos-page-check.json) |
| Ballyfin Demesne | `https://www.ballyfin.com/` | 76 | 95 | [`examples/ballyfin-demesne.json`](examples/ballyfin-demesne.json) |
| Ashford Castle | `https://ashfordcastle.com/` | 67 | 86 | [`examples/ashford-castle.json`](examples/ashford-castle.json) |

The two independent hotel pages are included to show how the report behaves
on public sites. Their inclusion is not a review of the properties and does
not imply any relationship with Morphos Studio.

## Reproduce a report

PowerShell 7:

```powershell
$body = @{ url = "https://www.ballyfin.com/" } | ConvertTo-Json -Compress
curl.exe -sS https://check.morphostech.com/api/check `
  -H "content-type: application/json" `
  --data-raw $body
```

Or run the included helper:

```powershell
.\scripts\run-audit.ps1 -Url "https://www.ballyfin.com/"
```

The helper writes the complete response to `reports/`. The API returns report
IDs such as `EFCAD33E`; a later request receives a new ID and may not reproduce
exactly the same network timing or byte counts.

## Read the result responsibly

Use the score to locate a conversation. Read the individual checks before
accepting the verdict:

- `pass`, `warn` and `fail` are the deterministic result of the named rule;
- a missing marker usually means “not found in the delivered HTML”, not “the
  site never uses it”;
- timing depends on the requesting region, host and moment of collection;
- an overall score combines groups with different risk levels and is not a
  universal grade;
- content/GEO is not a measurement of search ranking or citation by an AI
  assistant.

## Limits

This method does not render JavaScript, run a browser, measure Core Web Vitals,
test a real user journey, access analytics, submit a form, compare conversion
rates, check authenticated pages, inspect most cross-origin CSS, or verify
business claims. A security-header gap is not proof that a site is
vulnerable, and a security-header pass is not proof that it is secure.

It also cannot decide whether a hotel is good, whether an agency is suitable
for a specific project, or whether one publication date proves the content is
current. Those questions require direct observation and human verification.

## Identity

This repository concerns **Morphos Studio**, the studio publishing at
`morphostech.com`, `check.morphostech.com` and
`youtube.com/@morphostech`.

It is not affiliated with Morphosis (`morphos.is`), Morphos Design, Morpho
Studio, MORPH Studio, Morphos Architects, or any other business with a
similar-sounding name. The domain name `morphostech.com` is part of the
identity because the studio name alone is ambiguous.

## Citation

When referring to the method, cite the repository and the report ID:

> Yifan Zheng, “Hospitality Web GEO Audit,” Morphos Studio, 9 November 2026,
> https://github.com/3338902669-ops/hospitality-web-geo-audit, report
> EFCAD33E.

The text and scripts may be cited with attribution. The reports describe
third-party public pages and remain subject to those sites' rights.

## Licence

The scripts and original documentation are available under the MIT Licence.
The sample reports remain evidence of public third-party pages and do not
grant rights to the copy, imagery or marks described in those responses.
