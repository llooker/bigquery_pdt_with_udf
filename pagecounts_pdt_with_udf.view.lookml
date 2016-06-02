- view: pagecounts_pdt_with_udf

# This is an example PDT that uses an inline JavaScript user-defined
# function to process text that comes back from a query.
#
# This is the same example UDF as in the BigQuery docs here:
# https://cloud.google.com/bigquery/user-defined-functions#webui
#
  derived_table:
    sql: |
      SELECT requests, title
      FROM
        urlDecode(
          SELECT
            title, sum(requests) AS num_requests
          FROM
            [fh-bigquery:wikipedia.pagecounts_201504]
          WHERE language = 'fr'
          GROUP EACH BY title
        )
    js_udf: |
      // The UDF
      function urlDecode(row, emit) {
        emit({title: decodeHelper(row.title),
              requests: row.num_requests});
      }
      // Helper function for error handling
      function decodeHelper(s) {
        try {
          return decodeURI(s);
        } catch (ex) {
          return s;
        }
      }
      // UDF registration
      bigquery.defineFunction(
        'urlDecode',  // Name used to call the function from SQL
        ['title', 'num_requests'],  // Input column names
      
        // JSON representation of the output schema
        [{name: 'title', type: 'string'},
         {name: 'requests', type: 'integer'}],
      
        urlDecode  // The function reference
      );
    persist_for: 5 minutes

  fields:
#     Define your dimensions and measures here, like this:
    - dimension: title
      sql: ${TABLE}.title

    - measure: num_requests
      type: sum
      sql: ${TABLE}.requests
