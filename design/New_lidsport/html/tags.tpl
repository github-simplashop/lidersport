{* Шаблон страницы тегов *}

{* Канонический адрес страницы *}
{$canonical="/{$page->url}" scope=parent}
<div class="wrapper__page wrapper">

<!-- Заголовок страницы -->
<h1>{if $keyword}{$keyword|escape}{elseif $page}{$page->header|escape}{else}Теги{/if}</h1>

<!-- Тело страницы -->
{$page->body}

{if !$keyword}
{if $tags}
<div class="wrapper__page wrapper">
	<div class="navigation tags_ss-pr">
		<div class="navigation__wrapper">
			<span>Все теги:</span> 
			{foreach $tags as $tag}
			<a href="/tags/{$tag->url|escape}">{$tag->value|escape}</a>{if !$tag@last}, {/if}
			{/foreach}
		</div>
	</div>
</div>
{/if} 
{else}{*if !$keyword*}
{if $products}
{*<h2>Продукты с тегом "{$keyword|escape}"</h2>*}
<!-- Список товаров-->
<div class="wrapper">
	<div class="product-list">
		{foreach $products as $product}
			<div class="product-list__item product-list__item--thin">
				{include file='_tiny-product.tpl'}
			</div>
		{/foreach}
</div>
{/if}
{*if $products*}

{if $text}
  <div class="annotation">
	  {$text}
  </div>
{/if}

{if $posts}
<!-- Статьи /-->
{*<h2>Статьи с тегом "{$keyword|escape}"</h2>*}
<ul id="blog">
    {foreach $posts as $post}
    <li>
        <h3><a data-post="{$post->id}" href="blog/{$post->url}">{$post->name|escape}</a></h3>
        <p>{$post->date|date}</p>
        <p>{$post->annotation}</p>
    </li>
    {/foreach}
</ul>
<!-- Статьи #End /-->  
{/if}{*if $posts*}

{/if}{*if !$keyword*}
</div>