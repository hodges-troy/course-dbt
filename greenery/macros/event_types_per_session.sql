{%- macro value_counts(table, column) -%}

{%
    set values = dbt_utils.get_column_values(
        table = ref(table)
        , column = column
    )
%}

    {%- for value in values -%}
    , sum(case when {{ column }} = '{{value}}' then 1 else 0 end) as {{value}}_count
    {% endfor %}

{%- endmacro -%}