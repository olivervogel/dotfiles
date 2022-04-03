" set ruler
set colorcolumn=80,120

" generate tags when writing php
autocmd BufWritePost *.php silent! !ctags --tag-relative=yes -R --fields=+aimlS --languages=php --PHP-kinds=+cdfint-av --exclude="\.git" --exclude="node_modules"
