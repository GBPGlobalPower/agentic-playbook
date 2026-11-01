# Simplified Technical English (ASD-STE100)

ASD-STE100 is a controlled language for technical text. Each word has one meaning, and sentences are short and direct. People who read English as a second language, and translation tools, understand it easily. The `product-owner` agent and the `refine-requirements` skill write everything in STE. Other text can use STE when it must be exact: requirements, acceptance criteria, procedures, safety and security notes.

The authority is the official specification and its dictionary of approved words, which ASD makes available free of charge (asd-ste100.org). This page is a working summary in our own words, not a copy of the specification. When this page and the specification differ, the specification is correct.

## Words

1. **Use approved words, with their approved meaning and part of speech.** For example, use "start", not "commence" or "kick off"; use "help", not "assist"; use "show", not "display" as a verb when "show" is the approved word. When you are not sure, use the simplest common word with one meaning.
2. **Technical names and technical verbs are allowed.** These are the names of things in the product or domain (`AGENTS.md`, "outbox", "invoice", "API", "migration") and the verbs for their technical operations ("compile", "deploy", "encrypt"). Keep a project glossary of them, and use each one consistently. Put the glossary in the project's docs, or in `.playbook/local/principles/16-simplified-technical-english.md`.
3. **One word for one thing.** When you choose a word for a thing, use only that word for it. Do not change "user" to "customer" and then to "member".
4. **One meaning for each word.** Do not use "check" to mean "make sure" in one sentence and "a bank cheque" in another.
5. **Noun clusters have no more than three words.** Write "the sign-in code expiry time", not "the email sign-in code expiry time setting value". Break longer clusters with "of" or "for", or with a second sentence.
6. **Do not use contractions, slang, idioms or phrasal verbs.** Write "do not", not "don't"; "find", not "figure out"; "stop", not "shut down" (unless "shut down" is a technical verb in your glossary).

## Verbs

7. **Use only these verb forms**: the imperative ("Open the file."), the infinitive ("to open"), the simple present ("The app opens the file."), the simple past ("The app opened the file."), the future ("The app will open the file."), and the past participle used as an adjective ("the opened file").
8. **Do not use "-ing" forms**, except in technical names ("sign-in screen" is a name, but write "When you sign in", not "When signing in").
9. **Use the active voice.** Say who or what does the action: "The server rejects the request", not "The request is rejected". In procedures, always use the active voice.
10. **Use one verb for one action.** "Make sure that…", "Do a check of…" and other wordy forms are not necessary. Write "Make sure that the code is correct" only if "make sure" is the approved verb in your project.

## Sentences

11. **Procedural sentences have no more than 20 words. Descriptive sentences have no more than 25 words.**
12. **One instruction in each sentence**, unless you must do two actions at the same time.
13. **One topic in each sentence.** Do not join two ideas with "and" or "but" when you can write two sentences.
14. **Use articles and demonstratives** ("the", "a", "this"). Do not delete them to make text shorter: write "Close the sheet", not "Close sheet".
15. **Write conditions first**: "If the owner does not answer, stop the work." Put the most important information at the start.

## Procedures

16. **Write instructions as commands** (imperative): "Ask the owner which tracker to use."
17. **Number the steps** in the sequence that the reader does them. Each step has one action, or two closely related actions.
18. **Notes give information, not instructions.** If the reader must do something, write it as a step.

## Descriptions

19. **Give the important information first**, then the details.
20. **One topic in each paragraph, and no more than six sentences in a paragraph.**
21. **Use vertical lists** for items, options and conditions. Use tables when the reader must compare items.

## Safety and risk

22. **A warning or caution starts with a clear command**, then gives the risk: "Do not delete the migration. The production database will not apply new changes."

## Examples

| Not STE | STE |
| -- | -- |
| We'd want to kick off by figuring out who's actually going to be using this. | First, find out who will use this feature. |
| Notifications should probably be configurable per user, depending on the type. | Each user can turn each type of notification on or off. |
| Ensure that the onboarding flow, which is currently being redesigned, gracefully handles users without a team. | The onboarding must work for a user who has no team. The onboarding is in redesign now. |
| Data is exported on-device to avoid hitting the storage tier's limits. | The app makes the export file in the browser. Thus, the export does not go above the storage limit of the server plan. |

## Checking a text

- Count the words in each sentence: 20 for procedures, 25 for descriptions.
- Look for "-ing" words, the passive voice, contractions, phrasal verbs and noun clusters longer than three words.
- Look for synonyms: each thing has one name.
- Read the text as a person who learned English as a second language. If a sentence can have two meanings, write it again.
