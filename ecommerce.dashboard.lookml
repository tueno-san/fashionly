- dashboard: ecommerce_sample_user_dashboard
  title: eCommerce Sample User Dashboard
  layout: newspaper
  elements:
  - title: Order History
    name: Order History
    model: training
    explore: order_items
    type: table
    fields: [order_items.created_date, order_items.order_id,
      order_items.total_revenue_dashboard]
    sorts: [order_items.created_date desc]
    limit: 500
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 10
    col: 0
    width: 12
    height: 7
  - title: User Age Tier
    name: User Age Tier
    model: training
    explore: users
    type: single_value
    fields: [users.age_tier_dashboard]
    fill_fields: [users.age_tier_dashboard]
    sorts: [users.age_tier_dashboard]
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 0
    col: 0
    width: 6
    height: 3
  - title: User Gender
    name: User Gender
    model: training
    explore: users
    type: single_value
    fields: [users.gender]
    sorts: [users.gender]
    limit: 500
    show_view_names: 'true'
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 0
    col: 6
    width: 6
    height: 3
  - title: User City
    name: User City
    model: training
    explore: users
    type: single_value
    fields: [users.city]
    sorts: [users.city]
    limit: 500
    show_view_names: 'true'
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 0
    col: 12
    width: 6
    height: 3
  - title: User Traffic Source
    name: User Traffic Source
    model: training
    explore: users
    type: single_value
    fields: [users.traffic_source]
    sorts: [users.traffic_source]
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 0
    col: 18
    width: 6
    height: 3
  - title: Popular Category Purchases
    name: Popular Category Purchases
    model: training
    explore: order_items
    type: looker_bar
    fields: [products.category, order_items.order_item_count]
    sorts: [order_items.order_item_count desc]
    limit: 500
    trellis: ''
    stacking: ''
    color_application:
      collection_id: legacy
      palette_id: santa_cruz
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: 'true'
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 10
    col: 12
    width: 12
    height: 7
  - title: Revenue by Month
    name: Revenue by Month
    model: training
    explore: order_items
    type: looker_line
    fields: [order_items.created_month, order_items.total_revenue_dashboard]
    fill_fields: [order_items.created_month]
    limit: 500
    trellis: ''
    stacking: ''
    color_application:
      collection_id: legacy
      palette_id: santa_cruz
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: 'true'
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    y_axes: []
    listen:
      Email: users.email
    row: 3
    col: 0
    width: 24
    height: 7
  filters:
  - name: Email
    title: Email
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: training
    explore: users
    listens_to_filters: []
    field: users.email
