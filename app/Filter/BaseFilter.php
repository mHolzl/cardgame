<?php

declare(strict_types=1);

namespace App\Filter;

use App\Helper\DateTimeHelper;

abstract class BaseFilter implements FilterInterface
{
	public const CONDITION_EQ = 1;
	public const CONDITION_GT = 2;
	public const CONDITION_GTE = 3;
	public const CONDITION_LT = 4;
	public const CONDITION_LTE = 5;
	public const CONDITION_LIKE = 6;
	public const CONDITION_FIND_IN_SET = 7;
	public const CONDITION_IS_NULL = 8;

	public const TYPE_INT = 1;
	public const TYPE_STRING = 2;
	public const TYPE_DATE = 3;
	public const TYPE_DATETIME = 4;
	public const TYPE_BOOL = 5;
	public const TYPE_ARRAY = 6;

	protected array $raw_orderby = [];
	protected string $orderby = '';
	protected array $raw_filter = [];
	protected string $filter = '1';
	protected int $offset = 0;
	protected int $row_count = 10; // vychozi pocet radku

	/**
	 * Seznam promennych pro preklad do DB.
	 * Klic je vzdy nazev policka, pod kterym prichazi v requestu
	 * Value je nazev policka v DB.
	 *
	 * @var array
	 */
	protected array $fields = [];


	public function __construct(array $query)
	{
		$this->setFields();

		// nastavit razeni
		if (isset($query['sort'])) {
			$this->raw_orderby = $query['sort'];
			$this->setOrderBy();
		} else {
			$this->setDefaultOrderBy();
		}

		// nastavit surova data filtrovani (data ktera prijdou do API)
		if (isset($query['filter']) && is_countable($query['filter']) && count($query['filter'])) {
			$this->raw_filter = $query['filter'];
			$this->setFilter();
		}

		// nastavit data strankovani
		if (isset($query['range']) && is_countable($query['range']) && count($query['range']) === 2) {
			$this->offset = (int) $query['range'][0];
			$this->row_count = max(((int) $query['range'][1]) - $this->offset + 1, 1);
		} else {
			$this->offset = 0;
			$this->row_count = 10;
		}
	}


	private function setFilter(): void
	{
		if (count($this->raw_filter)) {
			$tmp = [];
			foreach ($this->raw_filter as $key => $value) {
				if (isset($this->fields[$key])) {
					$tmp[] = $this->getQueryString($key, $value);
				}
			}
			$this->filter = implode(" AND ", $tmp);
		}
	}


	public function getFilter(): string
	{
		return $this->filter;
	}


	private function setOrderBy(): void
	{
		if (count($this->raw_orderby) && isset($this->fields[$this->raw_orderby[0]])) {
			$this->orderby = $this->fields[$this->raw_orderby[0]]['field'];
			if (isset($this->raw_orderby[1]) && strtolower($this->raw_orderby[1]) === 'desc') {
				$this->orderby .= ' DESC';
			}
		}
		if (empty($this->orderby)) {
			$this->setDefaultOrderBy();
		}
	}


	public function getOrderBy(): string
	{
		return $this->orderby;
	}


	public function getOffset(): int
	{
		return $this->offset;
	}


	public function getRowCount(): int
	{
		return $this->row_count;
	}


	private function getQueryString(string $field, mixed $value)
	{
		$value = match ($this->fields[$field]['type']) {
			self::TYPE_INT => (int) $value,
			self::TYPE_STRING => htmlspecialchars((string) $value),
			self::TYPE_DATE => DateTimeHelper::validateDate($value) ?: '',
			self::TYPE_DATETIME => DateTimeHelper::validateDateTime($value) ?: '',
			self::TYPE_BOOL => (bool) $value,
			self::TYPE_ARRAY => (array) $value
		};

		$is_int = $this->fields[$field]['type'] === self::TYPE_INT;
		$is_bool = $this->fields[$field]['type'] === self::TYPE_BOOL;
		$result = $this->fields[$field]['field'];
		switch ($this->fields[$field]['condition']) {
			case self::CONDITION_EQ:
				if ($is_int || $is_bool) {
					$result .= "=" . (int) $value;
				} else {
					$result .= "='" . $value ."'";
				}
				break;

			case self::CONDITION_GT:
				if ($is_int) {
					$result .= ">" . (int) $value;
				} else {
					$result .= ">'" . $value ."'";
				}
				break;

			case self::CONDITION_GTE:
				if ($is_int) {
					$result .= ">=" . (int) $value;
				} else {
					$result .= ">='" . $value ."'";
				}
				break;

			case self::CONDITION_LT:
				if ($is_int) {
					$result .= "<" . (int) $value;
				} else {
					$result .= "<'" . $value ."'";
				}
				break;

			case self::CONDITION_LTE:
				if ($is_int) {
					$result .= "<=" . (int) $value;
				} else {
					$result .= "<='" . $value ."'";
				}
				break;

			case self::CONDITION_LIKE:
				$result .= " LIKE '%" . $value ."%'";
				break;

			case self::CONDITION_FIND_IN_SET:
				$result = sprintf("FIND_IN_SET(%s, '%s')", $this->fields[$field]['field'], implode(',', $value));
				break;

			case self::CONDITION_IS_NULL:
				if ($value) {
					$result .= " IS NULL";
				} else {
					$result = "";
				}
				break;
		}

		return $result;
	}
}
