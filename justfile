ALL_TAGS := `awk -F '\n' 'BEGIN { ORS = "," } { print "\"" $0 "\"" }' ALL-TAGS | sed 's/,$//'`
DATE_SLUG := `date "+%Y-%m-%d"`
DATE_FULL := `date -u +'%Y-%m-%dT%H:%M:%SZ'`

# Run the local development server with all drafts visible
local:
	zola serve --drafts

# Build and publish the site
blog:
	zola build
	rsync -avx --exclude .DS_Store public metta-website@motoko:/web/systems/metta/www/htdocs

[private]
make-new WHERE TYPE SLUG:
    cat templates/new-post.md | \
        sed -e 's/TAGS/{{ALL_TAGS}}/' \
            -e 's/CATEGORY/{{TYPE}}/' \
            -e 's/TITLE/{{SLUG}}/' \
            -e 's/DATE/{{DATE_FULL}}/' > content/{{WHERE}}/{{DATE_SLUG}}-{{SLUG}}.md

# Create a new blog post
new-post SLUG:
    just make-new blog post {{SLUG}}

# Create a new blog link
new-link SLUG:
    just make-new blog link {{SLUG}}

# Create a new blog quote
new-quote SLUG:
    just make-new blog quote {{SLUG}}

# Create a new note in notes section
new-note SLUG:
    just make-new notes notes {{SLUG}}
