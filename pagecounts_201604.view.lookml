- view: pagecounts_201604
  sql_table_name: |
      [fh-bigquery:wikipedia.pagecounts_201604]
  fields:

  - dimension: content_size
    type: number
    sql: ${TABLE}.content_size

  - dimension_group: datehour
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.datehour

  - dimension: language
    type: string
    sql: ${TABLE}.language

  - dimension: requests
    type: number
    sql: ${TABLE}.requests

  - dimension: title
    type: string
    sql: ${TABLE}.title

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: []

