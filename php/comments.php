<?php
$image->id = "1639008057580896505";
$data->access_token = "6270148388.9e11d47.648a460f8e93420a8502a36772a333ff";

$comments = json_decode(file_get_contents('https://api.instagram.com/v1/' . 'media/'. $image->id . '/comments?access_token='. $data->access_token));
echo "<pre>";
print_r($comments);
echo "</pre>";
