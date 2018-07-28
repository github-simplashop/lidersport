{if $category->tags}
    
  <div class="category-tags js-category-tags">
    <div class="category-tags__title">Теги:</div>
    <nav class="category-tags__list">
      {foreach from=$category->tags key=i item=tag}
				{if $tag->value !== ''} 
					<a class="category-tags__link js-category-tags-link" {if $tag@index > 1} style="display: none;" {/if} href="/tags/{if $tag->url}{$tag->url|escape}{else}{$tag->value|escape}{/if}">
						{if $tag->description}{$tag->description|escape}{else}{$tag->value|escape}{/if}
					</a>
				{/if}  
      {/foreach}
      {if $category->tags|count>2}
				<input class="category-tags__link category-tags__link--toggle js-category-tags-control" value="Еще >" type="button" data-toggle="2" data-default-text="Еще >" data-result-text="< Скрыть"/>
			{/if}
    </nav>
  </div>
  
{/if}


{literal}
<script>
	$(function() {

		$(document).on('click', '.js-category-tags-control', function() {
			var self = $(this),
					tagContainer = self.closest('.js-category-tags'),
					tagLink = tagContainer.find('.js-category-tags-link'),
					i = parseInt(self.data('toggle'));
			self.toggleClass('is-active');
			if (self.hasClass('is-active')) {
				tagLink.show();
				self.val(self.data('result-text'));
			} else {
				for (i; i <= tagLink.length; i++) {
					$(tagLink[i]).hide();
				}
				self.val(self.data('default-text'));
			}
		})
	});
</script>
{/literal}