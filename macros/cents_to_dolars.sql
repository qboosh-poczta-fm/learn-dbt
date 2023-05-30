{%- macro cents_to_dollars(amount_name, decimals = 2) -%}
round( 1.0 * {{ amount_name }} / 100, {{ decimals }} ) as amount
{%- endmacro -%}