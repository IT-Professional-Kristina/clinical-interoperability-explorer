library(fhircrackr)
library(dplyr)
library(ggplot2)

fhir_server <- "https://hapi.fhir.org/baseR4"
patient_request <- fhir_url(
  url = fhir_server,
  resource = "Patient",
  parameters = c("_count" = "20")
)
patient_bundle <- fhir_search(
  request = patient_request,
  max_bundles = 1,
  verbose = 0
)
patient_table_desc <- fhir_table_description(
  resource = "Patient",
  cols = c(
    id     = "id",
    family_name = "name/family",
    given_name  = "name/given",
    gender   = "gender",
    birth_date  = "birthDate"
  )
)

patients <- fhir_crack(
  bundles = patient_bundle,
  design  = patient_table_desc,
  verbose = 0
)
head(patients)

med_request <- fhir_url(
  url = fhir_server,
  resource = "MedicationRequest",
  parameters = c("_count" = "50")
)

med_bundle <- fhir_search(
  request = med_request,
  max_bundles = 1,
  verbose = 0
)

med_table_desc <- fhir_table_description(
  resource = "MedicationRequest",
  cols = c(
    id              = "id",
    status          = "status",
    medication_name       = "medicationCodeableConcept/text",
    patient_ref           = "subject/reference",
    authored_on           = "authoredOn"
  )
)
medications <- fhir_crack(
  bundles = med_bundle,
  design = med_table_desc,
  verbose = 0
)
head(medications)

med_status_counts <- medications %>%
  filter(!is.na(status)) %>%
  group_by(status) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(med_status_counts, aes(x = reorder(status, -count), 
                              y = count, fill = status)) +
  geom_col(show.legend = FALSE) +
  labs(
    title    = "Medication Requests by Status",
    subtitle = "Source: HAPI FHIR R4 Public Test Server",
    x        = "Status",
    y        = "Count"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

# Create the output folder first
dir.create("output", showWarnings = FALSE)

# Save your data
write.csv(patients,    "output/patients.csv",    row.names = FALSE)
write.csv(medications, "output/medications.csv", row.names = FALSE)

# Save the chart
ggsave("output/medication_status_chart.png", width = 8, height = 5)