<a href="/cart" class="link_cart">
{* Информера корзины (отдаётся аяксом) *}
{if $cart->total_products>0}
<span class="div_bas_ico fl"></span>
<span class="add_basket1 ml20 mt4 db ttu fl">Корзина</span>
<span class="bolt db mt4 fl ml5">(<span class="number">{$cart->total_products}</span>)</span>
<span class="ml20 summa">сумма</span>
<span class="summa">{$cart->total_price|convert}</span>
{else}
<span class="div_bas_ico fl"></span>
<span class="add_basket1 ml20 mt4 db ttu fl">Корзина</span>
<span class="bolt db mt4 fl ml5">(<span class="number">{$cart->total_products}</span>)</span>
<span class="pusto">Корзина пуста</span>
{/if}
</a>

