 {literal}
  <!-- BEGIN JIVOSITE CODE -->
  <script type='text/javascript'>
    (function(){ var widget_id = 'Dlk7kbxKzY';
    var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);})();
  </script>
  <!-- END JIVOSITE CODE -->
 
  <!-- Yandex.Metrika counter -->
  <script type="text/javascript">(function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter36200345 = new Ya.Metrika({id:36200345, webvisor:true, clickmap:true, trackLinks:true, accurateTrackBounce:true}); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks");
  </script>
  <noscript>
    <div>
      <img src="//mc.yandex.ru/watch/36200345" style="position:absolute; left:-9999px;" alt="" />
    </div>
  </noscript>
  <!-- /Yandex.Metrika counter -->        
{/literal}  

  </div>
  <footer class="footer">
    <div class="footer__wrapper wrapper">
      <div class="footer__info">
        <p class="footer__copyright">© 2015, Copyright Lidersport.<br> «Лидерспорт» — спортивные товары</p>
        <img src="/design/{$settings->theme}/images/pay-cards.png" alt="cards" class="footer__cards">
      </div>

      <nav class="footer__navigation">
        <a href="/o-nas" class="footer__item">О нас</a>
        <a href="" class="footer__item">Каталог товаров</a>
        <a href="/dostavka-i-oplata" class="footer__item">Доставка и оплата</a>
        <a href="/stock" class="footer__item">Новости и Акции</a>
      </nav>

      <nav class="footer__navigation">
        <a href="/contact" class="footer__item">Адреса магазинов</a>
        <a href="/contact" class="footer__item">Точки выдачи товара</a>
        <a href="/" data-popup-button="enter" class="footer__item">Вход в личный кабинет</a>
        <a href="/" data-popup-button="register" class="footer__item">Получить скидку 10%</a>
      </nav>

      <div class="footer__contacts">
        <a href="tel:+78652221577" class="footer__phone">8 (8652) 22-15-77</a>
        <span class="footer__time">ждем звонки с 9:00 до 20:00</span>
        <a href="http://rosmediy.ru" target="_blank" class="footer__development">
          <img src="/design/{$settings->theme}/images/development.png" alt="rosmedia">
        </a>
      </div>
    </div>
    <p style="visibility: hidden;">Ваш IP-адрес: <?php echo $_SERVER['REMOTE_ADDR']; ?></p>
  </footer>

  {include file='popups.tpl'}

  <script type="text/javascript" src="/js/autocomplete/jquery.autocomplete-min1.js"></script>
  <script type="text/javascript" src="/js/ctrlnavigate.js"></script>
  <script type="text/javascript" src="/design/{$settings->theme}/js/javascript.js"></script>
  <script type="text/javascript" src="/design/{$settings->theme}/js/jquery.cookie.js"></script>
  <script type="text/javascript" src="/design/{$settings->theme}/js/common.js"></script>
  <script crossorigin="anonymous" async type="text/javascript" src="//api.pozvonim.com/widget/callback/v3/373401793a6345d5dcd0f216780bb3fa/connect" id="check-code-pozvonim" charset="UTF-8"></script>
  <script src="http://api-maps.yandex.ru/2.0-stable/?load=package.standard&lang=ru-RU" type="text/javascript"></script>
  <script type="text/javascript">
    window.onload = function () {
      $.cookie('city', ymaps.geolocation.city);
      $('.header__town').html($.cookie('city'));
    }
  </script>
              <script src="http://api-maps.yandex.ru/2.0-stable/?load=package.standard&lang=ru-RU" type="text/javascript"></script>

</body>
</html>