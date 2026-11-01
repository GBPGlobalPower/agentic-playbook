# Product and planning

Build what the customer needs, in an order that gets something real into their hands early.

## The PRD

1. **One PRD per product**, with numbered requirements: functional (`FR-<AREA>-NN`) and non-functional (`NFR-NN`: performance, accessibility, privacy, offline, security). Tickets, tests and ADRs cite these ids.
2. **Each requirement says who it's for and what "works" means**, observable from outside.
3. **Open questions are listed** with who decides, and stay open until the owner answers (then the answer goes to the Decision Log).

## Tickets

4. **Every ticket has acceptance criteria** that someone could check without asking (`templates/ticket.md`), plus the requirement ids it serves.
5. **Labels**: type (feature, bug, chore, owner task), area (backend, app, design, infra), and accessibility, security or performance when relevant.
6. **Milestones group a usable slice** (M1 sign-in and workspaces, M2 invoices, …), so each one ends with something a person can use.
7. **Owner-blocked work is visible**: separate tickets, labelled, with exact steps. It never silently stalls other work.
8. **Found something? File it.** Bugs and follow-ups found during work become tickets with evidence, linked to where they were found.

## Choosing what's next

9. **Usable beats complete.** Prefer the work that makes an existing feature actually usable (states, errors, offline, accessibility) over starting a new one.
10. **Unblock yourself.** If the next item needs the owner, move to the next one that doesn't, and list what's waiting.
11. **Ask product questions early** (`00-working-agreement.md` §2): options, the recommendation first, and trade-offs in customer terms.
12. **Re-check the goal** at the start and end of each task: "Does this serve the customer as the PRD describes? Am I cutting a corner they'll feel?"

## Scope control

13. **A v0 scope list** says what's in, what's explicitly out, and what's later. Changes to it are owner decisions.
14. **Spikes are time-boxed** and end in an ADR or a ticket, never in half-built production code.
