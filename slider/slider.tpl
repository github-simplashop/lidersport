{get_slides var=slide}
{if $slide}

	<div class="owl-carousel">
        {foreach $slide as $s}
            {if $s->visible}
				{if $s->image}
					{if $s->url}<a href="{$s->url}">{/if}
					<div>
						<img src="{$s->image}" alt="{$s->name}" {if $s->description}title="#slide_{$s->id}"{/if} />
					</div>
					{if $s->url}</a>{/if}
				{/if}
            {/if}
        {/foreach}

	</div>

	<script type="text/javascript">
        $(document).ready(function(){
            $(".owl-carousel").owlCarousel({
                items: 1,
                dots: true,
                autoplay: true,

                autoplayTimeout: 5000,
                slideSpeed: 2000,
                loop: true,
            });
        });
	</script>
{/if}

