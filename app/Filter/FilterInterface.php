<?php

declare(strict_types=1);

namespace App\Filter;

interface FilterInterface
{
	function setFields(): void;
	function setDefaultOrderBy(): void;
}