<?PHP
//error_reporting(E_ALL ^ E_NOTICE);
chdir('../');
include('api/Simpla.php');

setlocale(LC_ALL, "ru_RU.UTF-8");

function process_hits($name)
{
    $simpla = new Simpla();
    $simpla->db->query('SELECT * FROM __products WHERE name=? ', $name);
    $result = $simpla->db->result("name");
    if (!$result) {
        $result = "Такого товара не существует!<br/>";
        return $result;
    }
    if($result) {
        $simpla->db->query('UPDATE __products SET featured=? WHERE name=?', "1", $name);
        $result_2 = $simpla->db->results();
        if (is_array($result_2)) {
            $result .= " <strong style='color:green'>добавлен в хиты</strong>";

            $img_name = "hit.png";

            $simpla->db->query('UPDATE __products SET attachment_files_one=? WHERE name=?', $img_name, $name);
            $result_3 = $simpla->db->results();
            if (is_array($result_3)) {
                $result .= " <strong style='color:green'>флаг добавлен</strong>";
            }
            else
                $result .= " <strong style='color:red'>флаг не добавлен</strong>";

        }
        else
            $result .= " <strong style='color:red'>не добавлен в хиты</strong>";
    }
    return $result;
}

$list = array(
    "БАССЕЙН НАДУВНОЙ INTEX КРИСТАЛ 114 X 25 СМ",
    "БАССЕЙН INTEX EASY SET НАДУВНОЙ 244 СМ X 76 СМ",
    "БАССЕЙН INTEX КАРКАСНЫЙ 457 X 122 СМ",
    "БАССЕЙН INTEX НАДУВНОЙ ВИННИ ПУХ С НАВЕСОМ 102 Х 69 СМ",
    "БАССЕЙН INTEX КАРКАСНЫЙ 300 X 200 X 75 СМ",
    "СКЕЙТБОРД COSMO A009 ОДНОТОННЫЙ В АССОРТИМЕНТЕ",
    "СКЕЙТБОРД COSMO A009W ПРИНТОВАННЫЙ В АССОРТИМЕНТЕ",
    "СКЕЙТБОРД 3108A MIX DESIGN",
    "СКЕЙТБОРД ELIFE",
    "КРУИЗЕР A009С MULTICOLOR",
    "САМОКАТ ТРЮКОВЫЙ NASH",
    "САМОКАТ ДВУХКОЛЕСНЫЙ COSMO REST СКЛАДНОЙ ЗЕЛЕНЫЙ",
    "САМОКАТ ТРЕХКОЛЕСНЫЙ COSMO CROSS СКЛАДНОЙ СВЕТЯЩИЕСЯ КОЛЕСА КРАСНЫЙ",
    "САМОКАТ ТРЕХКОЛЕСНЫЙ COSMO FUNNY СКЛАДНОЙ СВЕТЯЩИЕСЯ КОЛЕСА ПРИНТ В АССОРТИМЕНТЕ",
    "САМОКАТ ТРЕХКОЛЕСНЫЙ COSMO SLIDEX СВЕТЯЩИЕСЯ КОЛЕСА РОЗОВЫЙ",
    "ГИРОСКУТЕР SMART BALANCE 6.5 САМОБАЛАНС GHOST",
    "ГИРОСКУТЕР SMART BALANCE 6.5 САМОБАЛАНС КОСМОС ФИОЛЕТОВЫЙ",
    "ГИРОСКУТЕР SMART BALANCE 10.5 PREMIUM САМОБАЛАНС И ПРИЛОЖЕНИЕ ТАО ТАО UNIVERSE",
    "ГИРОСКУТЕР SMART BALANCE 10.5 PREMIUM САМОБАЛАНС И ПРИЛОЖЕНИЕ ТАО ТАО КОСМОС ФИОЛЕТОВЫЙ",
    "ГИРОСКУТЕР SMART BALANCE 6.5 САМОБАЛАНС ОРАНЖЕВЫЙ",
);

foreach($list as $name) {
    echo "<pre>";
    print_r(process_hits($name));
    echo "</pre>";
}
