{# {{ dbt_utils.date_spine(
    datepart='day',
    start_date = 'to_date("2023-01-01", "yyyy-mm-dd")',
    end_date = "current_date"
) }}  #}


{# {{ dbt_date.day_name("date_col") }} as day_of_week_short_name #}