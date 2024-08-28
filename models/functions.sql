{% macro margin_percent(revenue, purchase_cost) %}
    ROUND(
        SAFE_DIVIDE(
            {{ purchase_cost }},
            {{ revenue }}
        ) * 100,
        2
    )
{% endmacro %}

