<!DOCTYPE html>
<html>
<head>
    <title>Pharmacy Purchase Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" rel="stylesheet">
    <style>
        #date {
            width: 300px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>{{ $header }}</h1>

        <!-- Filters Form -->
        <form id="purchase-records-form" class="mb-4">
            <!-- Pharmacy Dropdown -->
            <div class="mb-3">
                <label for="pharmacy" class="form-label">Pharmacy</label>
                <select name="pharmacy" id="pharmacy" class="form-select">
                    <option value="">Select a pharmacy</option>
                    @foreach ($pharmacies as $connection => $pharmacy)
                        <option value="{{ $connection }}">{{ $pharmacy->name }}</option>
                    @endforeach
                </select>
            </div>

            <!-- Warehouse Dropdown (Populated via AJAX) -->
            <div class="mb-3">
                <label for="warehouse" class="form-label">Warehouse</label>
                <select name="warehouse" id="warehouse" class="form-select" disabled>
                    <option value="">Select a warehouse</option>
                </select>
            </div>

            <!-- Date Range -->
            <div class="mb-3">
                <label for="date" class="form-label">Date Range</label>
                <input type="text" name="date" id="date" class="form-control" placeholder="Select date range">
            </div>

            <button type="submit" class="btn btn-primary">Filter</button>
        </form>

        <!-- Purchase Records Table -->
        <div id="purchase-records-table">
            <p>Select a pharmacy and filters to view purchase records.</p>
        </div>

        <!-- Pagination Links -->
        <div id="pagination-links"></div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            // Initialize Date Range Picker
            $("#date").daterangepicker({
                opens: 'left',
                locale: {
                    format: 'YYYY-MM-DD',
                    separator: ' to '
                },
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            }, function (start, end, label) {
                $("#date").val(start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
            });

            // When pharmacy is selected, load warehouses
            $("#pharmacy").change(function () {
                const pharmacy = $(this).val();
                const $warehouseSelect = $("#warehouse");

                $warehouseSelect.prop("disabled", true).html('<option value="">Loading...</option>');

                if (!pharmacy) {
                    $warehouseSelect.html('<option value="">Select a warehouse</option>');
                    return;
                }

                $.ajax({
                    url: "{{ route('pharmacy.purchase-records.warehouses') }}",
                    method: "GET",
                    data: { pharmacy: pharmacy },
                    success: function (data) {
                        let options = '<option value="">Select a warehouse</option>';
                        data.forEach(warehouse => {
                            options += `<option value="${warehouse.id}" data-connection="${warehouse.database_connection}">${warehouse.name}</option>`;
                        });
                        $warehouseSelect.html(options).prop("disabled", false);
                    },
                    error: function (xhr) {
                        $warehouseSelect.html('<option value="">Error loading warehouses</option>');
                        console.error(xhr.responseJSON?.error || "Failed to load warehouses");
                    }
                });
            });

            // Handle form submission to fetch purchase records
            $("#purchase-records-form").submit(function (e) {
                e.preventDefault();

                const formData = $(this).serialize();
                console.log('Form data:', formData);

                $.ajax({
                    url: "{{ route('pharmacy.purchase-records.fetch') }}",
                    method: "GET",
                    data: formData,
                    success: function (data) {
                        $("#purchase-records-table").html(data.html);
                        $("#pagination-links").html(data.pagination);
                    },
                    error: function (xhr) {
                        $("#purchase-records-table").html('<p>Error loading purchase records.</p>');
                        console.error(xhr.responseJSON?.error || "Failed to fetch purchase records");
                    }
                });
            });

            // Handle pagination clicks
            $(document).on("click", "#pagination-links a", function (e) {
                e.preventDefault();
                const url = $(this).attr("href");
                const formData = $("#purchase-records-form").serialize();

                $.ajax({
                    url: url,
                    method: "GET",
                    data: formData,
                    success: function (data) {
                        $("#purchase-records-table").html(data.html);
                        $("#pagination-links").html(data.pagination);
                    },
                    error: function (xhr) {
                        $("#purchase-records-table").html('<p>Error loading purchase records.</p>');
                        console.error(xhr.responseJSON?.error || "Failed to fetch purchase records");
                    }
                });
            });
        });
    </script>
</body>
</html>