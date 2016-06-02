- connection: bigquery-publicdataset

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
- explore: pagecounts_201604

- explore: pagecounts_derived_table

- explore: pagecounts_pdt_with_udf
