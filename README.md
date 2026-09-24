# Redmine Wiki Books

> **TODO — compatibility work pending:** the `main` branch is intended to host a future version compatible with current Redmine releases. That work has not been done yet. The present code is legacy software and should not be installed on a current Redmine instance without an explicit compatibility, migration and security review.

Redmine plugin for arranging project wiki pages as ordered books and reading them through a chapter-oriented interface.

## Repository status

- `archived` preserves the documented legacy implementation from `master`.
- `main` is the starting point for a future adaptation to current Redmine releases.
- The historical `rm3` branch contains later work aimed at Redmine 3.x and remains separate.
- The `master` implementation declares plugin version `0.0.3` and was tested historically with Redmine 2.3.2.
- No current Redmine version has been validated yet.

## Features

### Books per project

Each project can enable a `Books` module and maintain its own collection of books. A book has:

- a title;
- a formatted description;
- creation and update timestamps;
- an association with its Redmine project;
- optional attachments through Redmine's attachable model support.

Books are exposed in the project menu and participate in Redmine search and activity streams.

### Chapters backed by wiki pages

A book contains an ordered list of chapters. Each chapter stores:

- the title of a wiki page in the same project;
- a display title;
- a free-form chapter number such as `1.2` or `3.a)`;
- a floating-point sorting value.

The reader renders the referenced wiki page inside the book view. If the page does not exist, it offers an authorized user a link to create it.

### Reading and navigation

The chapter view provides previous and next navigation, the book description and a chapter index. The book view presents the complete ordered index and visually marks missing wiki pages.

### Permissions

The plugin registers three project permissions:

- `view_books`;
- `manage_books`;
- `view_book_chapters`.

Visibility is delegated to Redmine project permissions. Public-project access therefore depends on the permissions assigned to anonymous and non-member roles.

### Extension hooks

The views expose hooks at the bottom of book and chapter pages so other plugins can append content.

## Data model

The legacy migrations create and later rename two tables:

- `wiki_books` for books and their project association;
- `wiki_book_chapters` for ordered references to wiki pages.

The current migration chain and its data-preservation behavior must be reviewed before installation on a modern database.

## Limitations of the legacy code

- Controllers use removed APIs such as `before_filter`, `find_all_by_*`, `update_attributes` and legacy finder syntax.
- Models use old association ordering and Redmine activity/search APIs.
- Routes contain overlapping resource and custom declarations that require review.
- Some destructive actions were historically exposed through GET-compatible routes.
- Parameter handling predates strong parameters.
- Views use obsolete helpers, inline JavaScript and old confirmation conventions.
- Chapter order is represented by a float, which is fragile for repeated insertion and reordering.
- The chapter model contains a `parent_id` column but does not implement a chapter hierarchy.
- The legacy tests are not sufficient evidence of compatibility with current Redmine.
- The `master` and `rm3` histories must be reconciled deliberately rather than copied blindly.

## Future adaptation

A future implementation should preserve the useful concept—curated reading sequences over project wiki pages—while adopting current Redmine permissions, routing, controller parameters, view helpers, migrations and tests. It should also define stable ordering and explicit behavior for renamed or deleted wiki pages. The legacy code has deliberately not been ported yet.

## License

Consult the repository history and existing license notices before redistribution or modification.
