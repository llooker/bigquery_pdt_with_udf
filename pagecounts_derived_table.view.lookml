- view: pagecounts_derived_table

# This derived table shows how the title information in the
# wikipedia data isn't URL escaped.

  derived_table:
    sql: |
      SELECT
        title
      , sum(requests) AS num_requests
      FROM
        [fh-bigquery:wikipedia.pagecounts_201604]
      WHERE language = 'fr'
      GROUP EACH BY title

  fields:
#     Define your dimensions and measures here, like this:
    - dimension: title
      sql: ${TABLE}.title

    - measure: num_requests
      type: sum
      sql: ${TABLE}.num_requests
