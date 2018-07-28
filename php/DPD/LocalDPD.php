<?php

class LocalDPD {

    function getLocalCityID($city) {
        $file="getParcelShops.txt";
        $data = unserialize(file_get_contents($file));

        $cities = array();
        foreach($data->return->parcelShop as $item) {
            $cities[$item->address->cityName] = $item->address->cityId;
        }

        if($cities[$city]) {
            return $cities[$city];
        }
    }

    function getLocalShops($city) {
        $file="getParcelShops.txt";
        $data = unserialize(file_get_contents($file));

        $data_sort = array();
        foreach($data->return->parcelShop as $key => $item) {
            if ($item->address->cityName == $city) {
                $data_sort[]= $item;
            }
        }
        return $data_sort;
    }

    function getLocalCities($region) {
        $file="cities.txt";
        $data = unserialize(file_get_contents($file));
        $cities_arr = array();
        foreach ($data as $key => $item) {
            if ($item[region_code] == $region) {
                $cities_arr[] = $item[region_name];
            }
        }
        $cities_arr = array_unique($cities_arr);
        sort($cities_arr);

        return $cities_arr;
    }

    function getLocalRegions() {
        $file="getParcelShops.txt";
        $data = unserialize(file_get_contents($file));

        $file2="regions.txt";
        $regions = unserialize(file_get_contents($file2));

        $data_sort = array();

        foreach($data->return->parcelShop as $key => $item) {
            $data_sort[]= $item->address->regionCode;
        }

        $data_sort = array_unique($data_sort);
        sort($data_sort);

        foreach($regions as $key => $region) {
            $match = false;
            foreach ($data_sort as $region_exist) {
                if ($region[region_code] == $region_exist){
                    $match = true;
                }
            }
            if (!$match) {
                unset($regions[$key]);
            }
        }

        sort($regions);

        return $regions;
    }

    function saveLocalDPD () {
        include "settings.php";
        $client = new SoapClient ("$server[0]geography2?wsdl");

        $arData['auth'] = array(
            'clientNumber' => $MY_NUMBER,
            'clientKey' => $MY_KEY);
        $arRequest['request'] = $arData; //помещаем наш масив авторизации в масив запроса request.

        $ret = $client->getParcelShops($arRequest); //обращаемся к функции getParcelShops  и получаем список пунктов выдачи.

        $ret2 = $client->getCitiesCashPay($arRequest); //обращаемся к функции getCitiesCashPay  и получаем список городов.

        $cities = array();
        foreach($ret->return->parcelShop as $item) {
            if($item->address->countryCode == "RU") {
                $cities[] = array(
                    "region_name" => $item->address->cityName,
                    "region_code" => $item->address->regionCode,
                );
            }
        }

        $regions = array(
            array(
                "region_name" => "Республика Адыгея",
                "region_code" => "01",
            ),
            array(
                "region_name" => "Республика Башкортостан",
                "region_code" => "02",
            ),
            array(
                "region_name" => "Республика Бурятия",
                "region_code" => "03",
            ),
            array(
                "region_name" => "Республика Алтай",
                "region_code" => "04",
            ),
            array(
                "region_name" => "Республика Дагестан",
                "region_code" => "05",
            ),
            array(
                "region_name" => "Республика Ингушетия",
                "region_code" => "06",
            ),
            array(
                "region_name" => "Кабардино-Балкарская республика",
                "region_code" => "07",
            ),
            array(
                "region_name" => "Республика Калмыкия",
                "region_code" => "08",
            ),
            array(
                "region_name" => "Карачаево-Черкесская республика",
                "region_code" => "09",
            ),
            array(
                "region_name" => "Республика Карелия",
                "region_code" => "10",
            ),
            array(
                "region_name" => "Республика Коми",
                "region_code" => "11",
            ),
            array(
                "region_name" => "Республика Марий Эл",
                "region_code" => "12",
            ),
            array(
                "region_name" => "Республика Мордовия",
                "region_code" => "13",
            ),
            array(
                "region_name" => "Республика Саха (Якутия)",
                "region_code" => "14",
            ),
            array(
                "region_name" => "Республика Северная Осетия — Алания",
                "region_code" => "15",
            ),
            array(
                "region_name" => "Республика Татарстан",
                "region_code" => "16",
            ),
            array(
                "region_name" => "Республика Тыва",
                "region_code" => "17",
            ),
            array(
                "region_name" => "Удмуртская республика",
                "region_code" => "18",
            ),
            array(
                "region_name" => "Республика Хакасия",
                "region_code" => "19",
            ),
            array(
                "region_name" => "Чеченская республика",
                "region_code" => "20",
            ),
            array(
                "region_name" => "Чувашская республика",
                "region_code" => "21",
            ),
            array(
                "region_name" => "Алтайский край",
                "region_code" => "22",
            ),
            array(
                "region_name" => "Краснодарский край",
                "region_code" => "23",
            ),
            array(
                "region_name" => "Красноярский край",
                "region_code" => "24",
            ),
            array(
                "region_name" => "Приморский край",
                "region_code" => "25",
            ),
            array(
                "region_name" => "Ставропольский край",
                "region_code" => "26",
            ),
            array(
                "region_name" => "Хабаровский край",
                "region_code" => "27",
            ),
            array(
                "region_name" => "Амурская область",
                "region_code" => "28",
            ),
            array(
                "region_name" => "Архангельская область",
                "region_code" => "29",
            ),
            array(
                "region_name" => "Астраханская область",
                "region_code" => "30",
            ),
            array(
                "region_name" => "Белгородская область",
                "region_code" => "31",
            ),
            array(
                "region_name" => "Брянская область",
                "region_code" => "32",
            ),
            array(
                "region_name" => "Владимирская область",
                "region_code" => "33",
            ),
            array(
                "region_name" => "Волгоградская область",
                "region_code" => "34",
            ),
            array(
                "region_name" => "Вологодская область",
                "region_code" => "35",
            ),
            array(
                "region_name" => "Воронежская область",
                "region_code" => "36",
            ),
            array(
                "region_name" => "Ивановская область",
                "region_code" => "37",
            ),
            array(
                "region_name" => "Иркутская область",
                "region_code" => "38",
            ),
            array(
                "region_name" => "Калининградская область",
                "region_code" => "39",
            ),
            array(
                "region_name" => "Калужская область",
                "region_code" => "40",
            ),
            array(
                "region_name" => "Камчатский край",
                "region_code" => "41",
            ),
            array(
                "region_name" => "Кемеровская область",
                "region_code" => "42",
            ),
            array(
                "region_name" => "Кировская область",
                "region_code" => "43",
            ),
            array(
                "region_name" => "Костромская область",
                "region_code" => "44",
            ),
            array(
                "region_name" => "Курганская область",
                "region_code" => "45",
            ),
            array(
                "region_name" => "Курская область",
                "region_code" => "46",
            ),
            array(
                "region_name" => "Ленинградская область",
                "region_code" => "47",
            ),
            array(
                "region_name" => "Липецкая область",
                "region_code" => "48",
            ),
            array(
                "region_name" => "Магаданская область",
                "region_code" => "49",
            ),
            array(
                "region_name" => "Московская область",
                "region_code" => "50",
            ),
            array(
                "region_name" => "Мурманская область",
                "region_code" => "51",
            ),
            array(
                "region_name" => "Нижегородская область",
                "region_code" => "52",
            ),
            array(
                "region_name" => "Новгородская область",
                "region_code" => "53",
            ),
            array(
                "region_name" => "Новосибирская область",
                "region_code" => "54",
            ),
            array(
                "region_name" => "Омская область",
                "region_code" => "55",
            ),
            array(
                "region_name" => "Оренбургская область",
                "region_code" => "56",
            ),
            array(
                "region_name" => "Орловская область",
                "region_code" => "57",
            ),
            array(
                "region_name" => "Пензенская область",
                "region_code" => "58",
            ),
            array(
                "region_name" => "Пермский край",
                "region_code" => "59",
            ),
            array(
                "region_name" => "Псковская область",
                "region_code" => "60",
            ),
            array(
                "region_name" => "Ростовская область",
                "region_code" => "61",
            ),
            array(
                "region_name" => "Рязанская область",
                "region_code" => "62",
            ),
            array(
                "region_name" => "Самарская область",
                "region_code" => "63",
            ),
            array(
                "region_name" => "Саратовская область",
                "region_code" => "64",
            ),
            array(
                "region_name" => "Сахалинская область",
                "region_code" => "65",
            ),
            array(
                "region_name" => "Свердловская область",
                "region_code" => "66",
            ),
            array(
                "region_name" => "Смоленская область",
                "region_code" => "67",
            ),
            array(
                "region_name" => "Тамбовская область",
                "region_code" => "68",
            ),
            array(
                "region_name" => "Тверская область",
                "region_code" => "69",
            ),
            array(
                "region_name" => "Томская область",
                "region_code" => "70",
            ),
            array(
                "region_name" => "Тульская область",
                "region_code" => "71",
            ),
            array(
                "region_name" => "Тюменская область",
                "region_code" => "72",
            ),
            array(
                "region_name" => "Ульяновская область",
                "region_code" => "73",
            ),
            array(
                "region_name" => "Челябинская область",
                "region_code" => "74",
            ),
            array(
                "region_name" => "Забайкальский край",
                "region_code" => "75",
            ),
            array(
                "region_name" => "Ярославская область",
                "region_code" => "76",
            ),
            array(
                "region_name" => "Москва",
                "region_code" => "77",
            ),
            array(
                "region_name" => "Санкт-Петербург",
                "region_code" => "78",
            ),
            array(
                "region_name" => "Еврейская автономная область",
                "region_code" => "79",
            ),
            array(
                "region_name" => "Ненецкий автономный округ",
                "region_code" => "83",
            ),
            array(
                "region_name" => "Ханты-Мансийский автономный округ - Югра",
                "region_code" => "86",
            ),
            array(
                "region_name" => "Чукотский автономный округ",
                "region_code" => "87",
            ),
            array(
                "region_name" => "Ямало-Ненецкий автономный округ",
                "region_code" => "89",
            ),
            array(
                "region_name" => "Республика Крым",
                "region_code" => "91",
            ),
            array(
                "region_name" => "Севастополь",
                "region_code" => "92",
            )
        );

        $file = 'getParcelShops.txt';
        $file2 = 'getCitiesCashPay.txt';
        $file3 = 'cities.txt';
        $file4 = 'regions.txt';

        //Пишем содержимое в файл
        file_put_contents($file, serialize($ret));
        file_put_contents($file2, serialize($ret2));
        file_put_contents($file3, serialize($cities));
        file_put_contents($file4, serialize($regions));

    }

}


