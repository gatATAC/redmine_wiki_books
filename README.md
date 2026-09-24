# Redmine Wiki Books

Redmine plugin for arranging a project's wiki pages as ordered books and reading them with chapter navigation.

## Status

Version **0.1.0** targets **Redmine 7.0.1**. It modernises the original plugin while preserving its central model: books belong to projects and chapters refer to wiki pages in those projects.

The historical implementation remains available in the `archived` branch. The former Redmine 3 compatibility work remains in `rm3` for reference.

## Features

### Books per project

Enable the **Books** project module to create one or more curated books. Each book has a title and formatted description and appears in the project menu.

Books participate in Redmine search and activity views and use the project's visibility rules.

### Wiki-backed chapters

A chapter contains:

- the title of a wiki page in the same project;
- a display title;
- a free-form chapter number such as `1.2` or `3.a)`;
- a numeric sorting value.

The book index orders chapters by that sorting value. The reader renders the wiki content and provides previous/next navigation. When the referenced page does not exist, an authorised user can follow the offered link to create it.

### Permissions

The plugin adds three project permissions:

- **View books**
- **Manage books**
- **View book chapters**

Assign them through Redmine roles. Anonymous and non-member access continues to depend on project visibility and role permissions.

### Extension hooks

Book and chapter views expose Redmine hooks so other plugins can append contextual content.

## Requirements

- Redmine 7.0.1 or later in the 7.x line.
- The Wiki module enabled in projects whose pages will be used as chapters.

## Installation

From the Redmine root:

```bash
git clone https://github.com/gatATAC/redmine_wiki_books.git plugins/redmine_wiki_books
RAILS_ENV=production bundle exec rake redmine:plugins:migrate NAME=redmine_wiki_books
```

Restart Redmine, enable **Books** in the desired projects and assign the plugin permissions to the appropriate roles.

## Upgrade from a legacy release

The plugin retains the historical table names `wiki_books` and `wiki_book_chapters`. Before upgrading:

1. back up the database and Redmine files;
2. test the migration against a copy of the installation;
3. review the legacy `master` and `rm3` history if the installation came from a Redmine 3 release;
4. migrate the plugin;
5. verify books, chapter ordering, missing-page links and permissions.

Do not assume that a database created from `rm3` has exactly the same migration state as one created from historical `master`.

## Data model

A book belongs to one project and owns an ordered collection of chapters. Deleting a book deletes its chapter records but does not delete the referenced wiki pages.

A chapter stores a wiki-page title rather than copying wiki content. Changes to that wiki page therefore appear immediately in the book.

## Development and validation

The current implementation uses Rails 8 controller callbacks, strong parameters, RESTful update/delete routes and current Active Record query APIs.

Regression testing should cover:

- project-module and role permissions;
- book creation, editing and deletion;
- chapter creation, editing, deletion and ordering;
- existing and missing wiki pages;
- previous/next navigation;
- search and activity integration;
- upgrades from both historical branches.

## Repository

The canonical repository is [github.com/gatATAC/redmine_wiki_books](https://github.com/gatATAC/redmine_wiki_books).

## Licence

Copyright © Txinto Vaz and contributors.

This program is free software under the **GNU General Public License version 3**. See [LICENSE](LICENSE).
