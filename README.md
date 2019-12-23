## Getting Started

``` bash
$ bundle install        # Install dependencies
$ rails db:setup        # Set up the local database
```

## Your assignment

After completing each of the steps below, commit your changes to your local clone with a meaningful commit message.

1.) The `Sample` model needs the ability to automatically calculate unit_weight_in_grams when the unit_of_measurement is in milliliters or fluid_ounces and the density is available. The density is stored in grams per milliliter and we will assume all 'fluid_ounces' are imperial fluid ounces. There are some commented out assertions in `spec/models/sample_spec.rb` which should pass once this step is completed.

2.) The `UnitConverter` service knows how to convert to/from the units of measurement listed within it. Add a new unit called 'MILLIGRAMS_PER_MILLILITER' and update the service so that it can convert to/from this unit. There are some commented out assertions in `spec/services/unit_converter_spec.rb` which should pass once this step is completed.

3.) There is a fixture file located at `spec/fixtures/cannabinoid.csv` that stores some test result data for a handful of cannabinoids. Create a service which parses files with this format and creates test result data for a `SampleTestReport` for a sample with the name provided in the file. The values should be stored in percentages. Add a migration file and for any new table(s) you created to store this data. Be sure to add at least some basic specs which cover your new code.

4.) Create a git bundle with your changes and email it to `arshaun@csalabs.com` along with a brief explanation of your solution. Be sure to include 'little-lims' in the email subject. **Do not push your solution to GitHub.**
