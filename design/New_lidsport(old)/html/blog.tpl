<div class="shares">
	<div class="shares__wrapper wrapper">
	<h2 class="shares__title" data-page="26">{$page->name}</h2>
		<ul class="shares__list">
			{foreach $posts as $post}
			<li class="shares__item">
				<img src="/files/stock/{$post->image}" alt="{$post->name|escape}" class="shares__image">
				<p class="shares__date">{$post->date|date}</p>
				<h3 class="shares__caption"><a data-post="{$post->id}" href="/stock/{$post->url}" class="shares__link">{$post->name|escape}</a></h3>
				<p class="shares__prewie">{$post->annotation}</p>
			</li>
			{/foreach}
		</ul> 

		{include file='pagination.tpl'}
	</div>
</div>