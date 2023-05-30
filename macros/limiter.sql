{% macro limiter(date_col) %}
    {%- if target.name == 'dev' -%}
    WHERE {{ date_col }} > DATE_FROM_PARTS('2018', '03', '01') -- LIMITER MACRO
    {% endif %}
{% endmacro %}