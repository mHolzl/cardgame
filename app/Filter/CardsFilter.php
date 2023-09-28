<?php

declare(strict_types=1);

namespace App\Filter;

final class CardsFilter extends BaseFilter
{
	public function setFields(): void
	{
		$this->fields['id'] = ["field" => "c.id", "condition" => self::CONDITION_EQ, "type" => self::TYPE_INT];
		$this->fields['name'] = ["field" => "c.name", "condition" => self::CONDITION_LIKE, "type" => self::TYPE_STRING];
		$this->fields['name'] = ["field" => "c.title", "condition" => self::CONDITION_LIKE, "type" => self::TYPE_STRING];
		$this->fields['value'] = ["field" => "c.value", "condition" => self::CONDITION_EQ, "type" => self::TYPE_INT];
		$this->fields['price'] = ["price" => "c.price", "condition" => self::CONDITION_EQ, "type" => self::TYPE_INT];
		$this->fields['cardtype_id'] = ["field" => "c.cardtype_id", "condition" => self::CONDITION_FIND_IN_SET, "type" => self::TYPE_ARRAY];
		$this->fields['landtype_id'] = ["field" => "c.landtype_id", "condition" => self::CONDITION_EQ, "type" => self::TYPE_INT];

		//$this->fields['ids'] = ["field" => "d.id", "condition" => self::CONDITION_FIND_IN_SET, "type" => self::TYPE_ARRAY];
	}


	public function setDefaultOrderBy(): void
	{
		$this->orderby = "d.id";
	}
}
