{* Список записей блога *}

<!-- Заголовок /-->
<div class="category_title mb20 mt20">
                  	<span data-page="26">{$page->name}</span>
</div>
<div class="shadow_div"></div>
<!--<h1></h1>-->

{include file='pagination.tpl'}

<!-- Статьи /-->
<ul id="blog">
	{foreach $posts as $post}
	<li>
		<div class="prevImg"><img src="/files/stock/{$post->image}" alt=""></div>
		<div class="anot"><div class="f11">{$post->date|date}</div>
        <h3><a data-post="{$post->id}" href="/stock/{$post->url}">{$post->name|escape}</a></h3>
		{$post->annotation}</div>
	</li>
	{/foreach}
</ul>
<!-- Статьи #End /-->    

{include file='pagination.tpl'}
          