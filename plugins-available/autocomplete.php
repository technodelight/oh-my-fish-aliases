#!/usr/bin/env php
<?php

function _log($entry) {
	file_put_contents(
		__DIR__ . '/autocomplete.log', 
		date('Y-m-d H:i:s') . ' ' . var_export($entry, true) . PHP_EOL,
		FILE_APPEND
	);
}

$args = $_SERVER['argv'];
array_shift($args);

_log($_SERVER['argv']);


