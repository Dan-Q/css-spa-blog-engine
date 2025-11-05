# CSS-only Single Page Blog Engine

Inspired by [a conversation on Melonland Forum](https://forum.melonland.net/index.php?topic=4937.0), this is a minimal implementation of a
Middleman-powered static site generator that produces a single-page blog using CSS to show specific posts based on the anchor (hash part)
of the URL. It degrades gracefully such that it works completely wihout JS or CSS (just displays a long page).

See it in action at [https://dan-q.github.io/css-spa-blog-engine/](https://dan-q.github.io/css-spa-blog-engine/).

## Dependencies

- [Ruby](https://www.ruby-lang.org/) (tested with 3.3.10)
- A small number of Rubygems (run `bundle` in this repo's directory to get them)

## Building locally

1. Check out this repository.
2. Run `bundle` to install dependencies.
2. Run `middleman server` to run a local webserver and see your blog at http://localhost:4567/.
3. Run `middleman build` to compile production assets suitable for upload to your webserver (or as part of a pipeline to host on Github Pages, for example) - they'll appear in the `build/` directory.

## Managing content

Posts go into `source/posts`. You can use `.html` (HTML) or `.md` (Markdown files). I'd recommend that you prefix your filenames with the date of the
post to make them easy to sort/find, but you don't have to.

Each post file should start with a frontmatter block like this, specifying the `id` (used in the URL), `title` (used when listing posts), and `date` (used
when sorting posts). You could optionally add your own frontmatter and update the template accordingly to show or use it.

```
---
id: a-test-post
title: A test post
date: 2025-11-01
---
```

Posts with future dates won't be included in the output, so you can use this to schedule content or write drafts.

## Making a real site

If you want a real site, you'll want to edit `source/index.html.erb`. Images (for use in your template or in posts) can go in `source/images/`.
The skeletal stylesheet is in `source/stylesheets/blog.css`, and you'll probably want to expand that too.

There's nothing to stop you adding Javascript too, if that's your jam.

## Deploying to GitHub Pages

`.github/workflows/deploy.yml` contains a fully-functional deployment tool for GitHub Pages. Simply fork this repository, enable Pages from the
Settings, and push any change to the `main` branch and you'll trigger a redeploy. From now on, any change you commit will be propogated to your
site promptly.

Note that using Actions to feed your GitHub Pages in this way is only free if your repository is set to Public, which somewhat undermines the ability to use future-dated posts as drafts (they can still be found via the repo!). Also, if you're using future-dated posts for scheduling,
you might like to amend the workflow so it runs on a schedule, too. [Here's an example](https://github.com/Dan-Q/abnib-birthdays/blob/main/.github/workflows/deploy.yaml).
