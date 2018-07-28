<h1>{if $page}{$page->name}{else}Карта сайта{/if}</h1>

<nav class="breadcrumbs">
  <ul>
    <li><a href="/">Главная</a></li>
    <li>{if $page}{$page->name}{else}Карта сайта{/if}</li>
  </ul>
</nav>

{$page->body}

{if $pages}
<h3>Страницы</h3> 
<ul>
  {foreach $pages as $p}
  <li><a href="{$p->url}">{$p->header}</a></li>   
  {/foreach}
</ul>
{/if}

{if $posts}
<h3>Новости</h3> 
<ul>
  {foreach $posts as $p}
  <li><a href="blog/{$p->url}">{$p->name|escape}</a></li>
  {/foreach}
</ul>
{/if}

{if $all_brands}
<h3>Производители</h3> 
<ul>
  {foreach $all_brands as $b}
  <li><a href="brands/{$b->url}">{$b->name}</a></li>
  {/foreach} 
</ul>
{/if}

{if $cats}
<h3>Каталог</h3>
{function name=cat_prod}
{if $prod}
<ul>
  {foreach $prod as $p}
  <li><a href="products/{$p->url}">{$p->name}</a></li>
  {/foreach}
</ul>
{/if}
{/function}    

{function name=cat_tree}
{if $cats}
<ul>
{foreach $cats as $c}
{if $c->visible}
  <li><a href="catalog/{$c->url}">{$c->name}</a>
    {cat_tree cats=$c->subcategories}
    {cat_prod prod=$c->products}
  </li>
{/if}
{/foreach}
</ul>
{/if}
{/function}

{cat_tree cats=$cats} 
{/if}