{* Список записей блога *}

<!-- Заголовок /-->
<h1>{$page->name}</h1>

{include file='pagination.tpl'}

<!-- Статьи /-->
<ul id="blog">
	{foreach $posts as $post}
	<li>
		<div class="f11">{$post->date|date}</div>
        <h3><a data-post="{$post->id}" href="/news/{$post->url}">{$post->name|escape}</a></h3>
		{$post->annotation}
	</li>
	{/foreach}
</ul>
<!-- Статьи #End /-->    

{include file='pagination.tpl'}
          