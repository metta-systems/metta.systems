local:
	zola serve

blog:
	zola build
	rsync -avx public hetzner:/web/net/atta-metta/www/htdocs/
