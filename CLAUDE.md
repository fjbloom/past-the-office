# Past the Office: project guide

Read `SPEC.md` first. It is the plan. This file is how to work on it.

## What this is

A static website that tells City of London workers which pieces of history they can see on a lunch break. The visitor picks a start point and a break length, and sees which places fit. Each place has the owner's own photos and personal note. Working name: Past the Office. Strapline: "City of London history for your lunch break".

## How to work with me

- I am building a website for the first time. Explain choices in plain English, and say why.
- Work in small steps. After each change, tell me what to look at on screen to check it.
- Ask before adding a dependency, a paid service, or anything that deletes files.
- Choose the simplest framework that does the job, record the choice at the bottom of this file, and keep the code readable. I must be able to explain how it works.
- Commit often with clear messages.
- Write tests for the walking-time and "does it fit" logic. Everything else can be checked by eye.
- Never invent facts. History in the place files is a draft until `factsChecked: true`. If you are unsure of a fact, a coordinate, an opening time or a price, say so and mark it in the file.
- The notes and photos are mine. Never write my personal notes for me, and never add photos I did not provide. Leave `## Your note` empty unless I give you the text.

## Content

- Each place is one Markdown file in `content/places/`, with the fields in `content/places/_template.md`. Files starting with `_` are not places.
- Photos go in `public/images/places/<slug>/`. Every photo needs a description (`alt`) in the place file.
- Start points are in `content/start-points.json`.
- A place with `status: draft` is never shown on the live site.
- All coordinates so far are approximate. They must be checked against the real map before launch (`coordinatesChecked`).

## Walking times and fitting

- Walking speed 80 metres a minute (about 4.8 km/h). Real route is estimated as straight-line distance plus 25%.
- Times between every start point and every place are worked out once and stored in a file, not on every page view.
- A place fits if: walk there + visit minutes + walk back is no more than the break. If the visitor chooses to keep 15 minutes to eat, subtract 15 from the break first.
- Round each walk to whole minutes, minimum 1.
- Lunch slider: 15 to 90 minutes in steps of 5. Default 45.
- Version 1 is one place per break. List fitting places nearest first. Multi-stop routes come later.

## Design: "The Plate"

An engraved 18th-century print look, inspired by John Rocque's 1746 map of London. Mood: classic, sleek, embedded in history. The design boards were made in Claude; the tokens below are the source of truth.

| Token | Value |
| --- | --- |
| Paper (page plate) | `#E8E1CD` |
| Surround | `#D9D1BB` |
| Ink | `#26211B` |
| Soft ink (secondary text) | `#4A4234` |
| Brick accent (pins, highlights) | `#8E2F22` |
| River wash | `#B7C5C0` |
| Display font | IM Fell DW Pica, italic |
| Label font | IM Fell English SC, wide letter-spacing |
| Body font | EB Garamond |

- Page: a plate with a 6px double ink border, fine diagonal hatching in map areas, dotted leader lines in lists.
- Map: compass rose, a scale bar in yards, numbered pins, a "References" list beside it.
- Photos are shown as framed plates.
- Desktop first (the likely moment of use is around 11am at a desk), but the phone layout must be fully finished: stacked layout, big tap targets, no horizontal scroll.
- Single light look. No dark mode in version 1.
- Avoid: stock imagery, gradients, emoji, rounded soft-shadow cards, generic hero sections, anything that looks like a template.
- Consider hosting the fonts on the site itself, to avoid third-party requests.
- Accessibility: keyboard use, visible focus, text contrast of at least 4.5 to 1, descriptions on all photos.

## Map

- Leaflet with OpenStreetMap data. Show the OpenStreetMap attribution.
- Style the map to match the Plate. A Rocque 1746 layer is a later option: confirm the licence of the exact scan before using it.

## Out of scope for version 1

Accounts, logins, a database, ads, paid features, multi-stop routes, "open now", postcode search, themes. A small "buy me a coffee" style donation link for running costs is fine.

## Definition of done for version 1

12 to 15 published places with my notes and photos, checked facts and coordinates, works on phone and desktop, passes a basic accessibility check, live on free hosting.

## Decisions log

Add each decision here as it is made, with the date.

- 2026-10-29 Project folder: `C:\Users\frede\Projects\past-the-office`, outside OneDrive, because OneDrive syncing can damage git's internal files. GitHub will be the backup.
- 2026-10-29 Version control: git, main branch `main`. Text files stored with LF line endings (`.gitattributes`).
- 2026-10-29 Framework: Eleventy 3 (`@11ty/eleventy`). It turns the Markdown place files into plain HTML pages, with no code running in the visitor's browser beyond the map. Pages, places and layouts live in `content/` (layouts in `content/_includes/`); the built site goes to `_site/`; anything in `public/` is copied across as it is. `npm start` runs a local preview at http://localhost:8080, `npm run build` builds once.
- 2026-10-29 Styles: one stylesheet, `public/styles/plate.css`, with the design tokens as CSS variables at the top. Fonts are self-hosted in `public/fonts/` (Latin character set only, SIL Open Font License, licence files alongside), taken from the Fontsource packages. `/style-sample/` shows every style for checking by eye; it is built by `npm start` only, never for the live site.
- Hosting: not chosen yet.
- Domain: not bought; wait until the site is nearly ready.
