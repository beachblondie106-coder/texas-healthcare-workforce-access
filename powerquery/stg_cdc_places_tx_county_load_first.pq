let
    Source =
        Csv.Document(
            Web.Contents(
                "https://data.cdc.gov/resource/fu4u-a9bh.csv",
                [
                    Query = [
                        stateabbr = "TX",
                        #"$limit" = "50000"
                    ]
                ]
            ),
            [
                Delimiter = ",",
                Encoding = 65001,
                QuoteStyle = QuoteStyle.Csv
            ]
        ),

    PromotedHeaders =
        Table.PromoteHeaders(
            Source,
            [PromoteAllScalars = true]
        ),

    KeptColumns =
        Table.SelectColumns(
            PromotedHeaders,
            {
                "stateabbr",
                "statedesc",
                "locationid",
                "locationname",
                "measureid",
                "measure",
                "category",
                "data_value",
                "low_confidence_limit",
                "high_confidence_limit",
                "data_value_type"
            },
            MissingField.Ignore
        ),

    RenamedColumns =
        Table.RenameColumns(
            KeptColumns,
            {
                {"stateabbr", "state_abbr"},
                {"statedesc", "state_name"},
                {"locationid", "county_fips"},
                {"locationname", "county_name"},
                {"measureid", "measure_id"},
                {"measure", "measure_name"},
                {"category", "measure_category"},
                {"data_value", "estimate_value"},
                {"low_confidence_limit", "confidence_interval_low"},
                {"high_confidence_limit", "confidence_interval_high"}
            },
            MissingField.Ignore
        ),

    CleanedCountyFips =
        if Table.HasColumns(RenamedColumns, "county_fips") then
            Table.TransformColumns(
                RenamedColumns,
                {
                    {
                        "county_fips",
                        each Text.PadStart(Text.From(_), 5, "0"),
                        type text
                    }
                }
            )
        else
            RenamedColumns,

    ChangedTypes =
        Table.TransformColumnTypes(
            CleanedCountyFips,
            List.Select(
                {
                    {"state_abbr", type text},
                    {"state_name", type text},
                    {"county_fips", type text},
                    {"county_name", type text},
                    {"measure_id", type text},
                    {"measure_name", type text},
                    {"measure_category", type text},
                    {"estimate_value", type number},
                    {"confidence_interval_low", type number},
                    {"confidence_interval_high", type number},
                    {"data_value_type", type text}
                },
                each Table.HasColumns(CleanedCountyFips, _{0})
            )
        ),

    SelectedMeasures =
        if Table.HasColumns(ChangedTypes, "measure_id") then
            Table.SelectRows(
                ChangedTypes,
                each List.Contains(
                    {
                        "DIABETES",
                        "OBESITY",
                        "CHD",
                        "COPD",
                        "STROKE",
                        "KIDNEY",
                        "PHLTH",
                        "MHLTH",
                        "GHLTH",
                        "CSMOKING",
                        "LPA",
                        "SLEEP",
                        "CHECKUP",
                        "DENTAL",
                        "COLON_SCREEN",
                        "MAMMOUSE",
                        "ACCESS2"
                    },
                    [measure_id]
                )
            )
        else
            ChangedTypes
in
    SelectedMeasures

