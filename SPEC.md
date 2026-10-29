# Past the Office: Project Spec

29 October 2026

## Overview

Past the Office is a website that shows City of London workers which pieces of history they can see on a lunch break, based on where their office is and how long they have. It is a personal side project with two aims: a real, finished site, and a portfolio piece to share on LinkedIn.

- **Working name:** Past the Office, with the strapline "City of London history for your lunch break". The name and domain are still open (see the last section).
- **Launch target:** about one month from now, using roughly 20 hours of build time with Claude.
- **Money:** no ads and no paid features. A small "buy me a coffee" style button invites optional donations towards server and running costs.

## Audience and use

The audience is any City of London worker. The likely moment of use is around 11am at a desktop, when someone plans their lunch break, so the design is desktop first.

The phone version still has to be fully finished, for two reasons. Many LinkedIn clicks will arrive on a phone, and the walk itself happens outdoors. That means a big, tappable map, readable text in daylight, and no horizontal scrolling.

Typical lunch breaks are 30 to 60 minutes, so the lunch slider runs from 15 to 90 minutes.

## Design direction: The Plate

The chosen look is Direction A, "The Plate": an engraved 18th-century print inspired by John Rocque's 1746 map of London. The mood words are classic, sleek and embedded in history.

- **Page:** warm paper ground, a double-ruled frame, and fine diagonal hatching for built-up areas, as on an engraved plan.
- **Typography:** an 18th-century-style display face (IM Fell DW Pica italic) for the name and place titles, EB Garamond for reading text, and small capitals for labels.
- **Colour:** dark ink on paper, one brick-red accent for pins and highlights, and a muted blue-green wash for the river.
- **Map furniture:** a compass rose, a scale bar in yards, and a numbered "References" list in the manner of old plans.
- **Photos:** your own, shown as framed plates. No stock images.
- **Copy:** plain and specific. Period flourishes, such as the subtitle "within the hour of dinner", are optional and used sparingly.
- **Layout:** the map on the left and the references list and the selected place on the right, with a phone layout that stacks them.

Direction C's "1746 / Today" toggle is kept as a later feature. Direction B's restraint is a useful check: if a detail feels like decoration, leave it out.

## Version 1 scope

Version 1 is a small, polished site with 12 to 15 places. Anything not on this list waits until after launch.

**In version 1**

- A real map showing the places, with numbered pins in the same style as the design.
- A choice of start point: three spots along Gresham Street plus nearby tube stations.
- A lunch-length slider from 15 to 90 minutes, and an option to keep 15 minutes for eating.
- Each place marked as fitting or not, with walking time each way, time needed there and minutes to spare.
- One place per break: the places that fit are listed nearest first, and the visitor picks one.
- A page for each place: photo, short history, what to look for, practical notes and your own note.
- A phone layout, an About page and a short explanation of how times are worked out.

**Later**

- Themes or eras (Roman, medieval, Great Fire, Victorian) and a "surprise me" button.
- A 1746 / Today toggle that swaps the map.
- An "open now" indicator and favourites.
- A postcode box or "use my location".
- A newsletter, visitor suggestions and multi-stop routes that combine several places in one break.

## Content model and adding places

Each place is one text file in the project, plus a folder of your photos. The same fields appear on every place, so the site can sort, filter and display them consistently.

| Field | What it holds |
| --- | --- |
| Name and short name | The full name, and a short form for map labels |
| Coordinates | Latitude and longitude of the entrance or the spot to stand |
| Era | Dates, such as "Built 1671 to 1677" |
| Summary | The history in a few sentences, in your own words |
| Look for | One or two things to spot on the visit |
| Your note | Your personal thoughts: what you noticed, best time to go |
| Time needed | Minutes at the place, and a quicker option where there is one |
| Practical | Opening hours, cost, steps and access, and when to check |
| Photos | Your own, each with a short description for screen readers |
| Sources | Where the facts came from |
| Status | Draft or published, so unfinished places stay hidden |

The workflow for a new place:

1. Copy the place template file and fill in the fields.
2. Add your photos to the images folder.
3. Write your note.
4. Save and publish. The site updates itself and the new place appears on the map.

We start with plain files because there is less to break. If that becomes a chore, a free editing screen can be added later.

## Map and walking times

The maps in the design boards are stand-in drawings, so version 1 needs a real map.

- **Base map:** a real street map built with Leaflet and OpenStreetMap data, which is free. It needs a visible attribution line, and heavy traffic might eventually need a free-tier tile provider instead.
- **Old-map layer:** Rocque's 1746 map is in the public domain, and georeferenced scans exist. We would pick one scan, confirm its terms of use, and either blend it into the base map or offer it later as the "1746 / Today" toggle.
- **Styling:** map colours, pins and labels follow the Plate design, so the real map still feels like an engraving.
- **Start points:** a fixed list: three spots along Gresham Street and nearby tube stations.
- **Walking times:** the places and start points are fixed, so times between them are worked out once and stored. The prototype uses straight-line distance plus 25% for the real route, at about 4.8 km/h (80 metres a minute). A routing service can replace that estimate once, with no running cost.
- **Fitting rule:** a place fits if the walk there, the time at the place and the walk back are within the break (minus 15 minutes if the visitor keeps time to eat).
- **One place per break:** version 1 lists the places that fit, nearest first, and the visitor picks one. Multi-stop routes are a later feature.

## Technical approach and hosting

The site is static: ready-made pages and a set of text files, with no server and no database. That makes it cheap, fast and hard to break.

- **Content in files:** places and notes are text files kept in git, on GitHub, so every change is saved and can be undone.
- **Framework:** kept simple and chosen at the start in Claude Code. The deciding test is whether you can explain how it works.
- **Hosting:** free static hosting (GitHub Pages, Cloudflare Pages or Netlify), publishing automatically when you save a change.
- **Domain:** bought only once the site is nearly ready, at roughly £10 a year. Until then it runs on the free address the host provides.
- **Privacy:** no accounts and no tracking, so no cookie banner is needed. If you want visitor numbers later, use a privacy-friendly analytics tool.
- **Cost and equipment:** everything runs on free tools and an ordinary laptop, because the building and publishing happen in the cloud.
- **Working method in Claude Code:** this spec goes into a project file so Claude knows the plan from the first minute. Changes are small, each is checked on screen before the next, and the design boards are the visual reference.

## Sources, legal and accessibility

Accuracy and permissions matter more once the site is shared publicly on LinkedIn.

- **Facts:** every place lists where its facts came from, such as the official site, a heritage listing or a published history. Claude's drafts are a starting point, and you check each claim against a source before publishing.
- **Photos:** only your own. Avoid close-ups of identifiable people, and check each venue's photography rules before you shoot.
- **Map and old maps:** show the OpenStreetMap attribution, and confirm the terms of any Rocque scan before using it.
- **Opening hours and prices:** these change, so each place says to check before going, and shows the date it was last checked.
- **Accessibility:** full keyboard use, readable contrast, a text description for every photo, and access notes such as the Monument's 311 steps.
- **Credit:** a short About line saying who made it. How you describe using AI to build it is your decision.

## Timeline

The plan is about 20 hours of building with Claude over four weeks, aiming for launch around the end of November 2026.

1. **Week 1, about 4 hours:** finalise the spec, set up the project and GitHub, and turn the Plate design into reusable styles.
2. **Week 2, about 6 hours:** the real map, the place data structure, the start points, the lunch slider and the fitting rule.
3. **Week 3, about 6 hours:** place pages, load 12 to 15 places with your notes and photos, and polish the design.
4. **Week 4, about 4 hours:** testing on phone and desktop, accessibility checks, buying the domain, publishing and the LinkedIn post.

Your own time sits on top of this. Visiting, photographing and writing about 12 to 15 places could take 10 hours or more, mostly on lunch breaks. That is the main risk to the date, so start collecting material in week 1.

## Open decisions and next steps

- [ ] Decide the final name, then check the domain, social handles and any similar existing businesses. "Past the Office" is the working name.
- [ ] Choose 12 to 15 places for launch. The five so far are the Royal Exchange, St Paul's Cross, St Lawrence Jewry, the Jamaica Wine House and the Monument.
- [ ] Visit and photograph each place, and write your note on it.
- [ ] Pick which Rocque scan to use, and confirm its terms.
- [ ] Decide whether to keep the "within the hour of dinner" subtitle.
- [ ] Choose the launch date and plan the LinkedIn post.
- [ ] Set up the Claude Code project and GitHub, and put this spec in the project as its guide.
