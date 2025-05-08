<!DOCTYPE html>
<html>
<head>
    <title>Pharmacy Purchase Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" rel="stylesheet">
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
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
        @if ($pharmacies->isNotEmpty())
            @foreach ($pharmacies as $connection => $pharmacy)
                <option value="{{ $connection }}">{{ $pharmacy->name }}</option>
            @endforeach
        @else
            <option value="" disabled>No pharmacies available</option>
        @endif
    </select>
</div>
            <!-- Warehouse Dropdown (Populated via AJAX) -->
            <div class="mb-3">
                <label for="warehouse" class="form-label">Warehouse</label>
                <select name="warehouse" id="warehouse" class="form-select" disabled>
                    <option value="">Select a warehouse</option>
                </select>
            </div>

            <!-- Drug Autocomplete -->
            <div class="mb-3">
                <label for="drug_name" class="form-label">Drug</label>
                <input type="text" name="drug_name" id="drug_name" class="form-control" placeholder="Type to search for a drug" autocomplete="off">
                <input type="hidden" name="drug" id="drug_id">
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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
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

            // Autocomplete for drugs (only after pharmacy and warehouse are selected)
            $("#drug_name").autocomplete({
    source: function (request, response) {
        const pharmacy = $("#pharmacy").val();
        const warehouse = $("#warehouse").val();

        if (!pharmacy) {
            console.log("Pharmacy not selected, aborting product search.");
            response([]);
            return;
        }

        console.log("Searching products for:", {
            pharmacy: pharmacy,
            warehouse: warehouse,
            term: request.term
        });

        $.ajax({
            url: "{{ route('pharmacy.purchase-records.products') }}",
            method: "GET",
            data: {
                pharmacy: pharmacy,
                warehouse: warehouse || '', // Send empty string if no warehouse
                term: request.term
            },
            success: function (data) {
                console.log("Products received:", data);
                response(data);
            },
            error: function (xhr) {
                console.error("Failed to fetch products:", xhr.responseJSON?.error || xhr.statusText);
                response([]);
            }
        });
    },
    minLength: 2,
    select: function (event, ui) {
        console.log("Selected product:", ui.item);
        $("#drug_name").val(ui.item.label);
        $("#drug_id").val(ui.item.id);
        return false;
    }
});

            // Clear drug selection if pharmacy or warehouse changes
            $("#pharmacy").change(function () {
    const pharmacy = $(this).val();
    const $warehouseSelect = $("#warehouse");

    // Clear the warehouse dropdown and disable it while loading
    $warehouseSelect
        .prop("disabled", true)
        .html('<option value="">Loading...</option>');

    // Reset drug field since warehouse is changing
    $("#drug_name").val('');
    $("#drug_id").val('');

    if (!pharmacy) {
        $warehouseSelect
            .prop("disabled", false)
            .html('<option value="">Select a warehouse</option>');
        return;
    }

    console.log('Fetching warehouses for:', { pharmacy: pharmacy });

    $.ajax({
        url: "{{ route('pharmacy.purchase-records.warehouses') }}",
        method: "GET",
        data: { pharmacy: pharmacy },
        success: function (data) {
            console.log('Warehouses received:', data);
            let options = '<option value="">Select a warehouse</option>';
            if (data.length > 0) {
                data.forEach(warehouse => {
                    options += `<option value="${warehouse.id}" data-connection="${warehouse.database_connection}">${warehouse.name}</option>`;
                });
            } else {
                options = '<option value="" disabled>No warehouses available for this pharmacy</option>';
            }
            $warehouseSelect.html(options).prop("disabled", false);
        },
        error: function (xhr) {
            console.error('Failed to load warehouses:', xhr.responseJSON?.error || xhr.statusText);
            $warehouseSelect
                .html('<option value="" disabled>Error loading warehouses</option>')
                .prop("disabled", true);
        }
    });
});
            // Handle form submission to fetch purchase records
            $("#purchase-records-form").submit(function (e) {
    e.preventDefault();

    const formData = $(this).serialize();
    console.log('Form data submitted:', formData);

    $.ajax({
        url: "{{ route('pharmacy.purchase-records.fetch') }}",
        method: "GET",
        data: formData,
        success: function (data) {
            console.log("Purchase records received:", data);
            $("#purchase-records-table").html(data.html);
            $("#pagination-links").html(data.pagination);
        },
        error: function (xhr) {
            console.error("Failed to fetch purchase records:", xhr.responseJSON?.error || xhr.statusText);
            $("#purchase-records-table").html('<p>Error loading purchase records: ' + (xhr.responseJSON?.error || 'Unknown error') + '</p>');
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