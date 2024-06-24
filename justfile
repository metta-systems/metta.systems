local:
	zola serve

blog:
	zola build
	rsync -avx --exclude .DS_Store public metta-website@motoko:/web/systems/metta/www/htdocs
