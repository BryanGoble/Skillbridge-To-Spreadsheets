# Skillbridge To Spreadsheets - v1.0
# Available for use under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) license.

# Import the Selenium WebDriver module
Import-Module -Name Selenium

# Create a Chrome WebDriver instance
$driver = Start-SeChrome

# Navigate to the target webpage
Enter-SeUrl "https://skillbridge.osd.mil/locations.htm" -Driver $driver

# Wait for the table data to load (adjust the timeout as needed)
$wait = New-Object OpenQA.Selenium.Support.UI.WebDriverWait($driver, [System.TimeSpan]::FromSeconds(60))
$searchButton = $wait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementToBeClickable([OpenQA.Selenium.By]::Id("search-btn")))
$driver.ExecuteScript("arguments[0].scrollIntoView(true);", $searchButton)
$driver.ExecuteScript("arguments[0].click();", $searchButton)
$wait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementToBeClickable([OpenQA.Selenium.By]::Id("search-btn")))

# Wait for the table data to load (adjust the sleep duration as needed)
Start-Sleep -Seconds 10

# Find the table element
$tableElement = Find-SeElement -Driver $driver -Id "location-table"

# Array to store the extracted table data
$tableData = @()

# Loop to click the "Next" button and retrieve table data from each page
$nextButton = Find-SeElement -Driver $driver -Id "location-table_next"
while ([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementToBeClickable([OpenQA.Selenium.By]::Id("location-table_next"))) {
    try {
	
	# Refresh the table element to avoid stale element reference error
    $tableElement = Find-SeElement -Driver $driver -Id "location-table"

    # Execute JavaScript to retrieve the innerText of all table cells
	$cellsScript = @"
        var rows = document.querySelectorAll('#location-table tbody tr');
        var tableData = [];
        for (var i = 0; i < rows.length; i++) {
            var rowData = [];
            var cells = rows[i].querySelectorAll('td');
            for (var j = 0; j < cells.length; j++) {
                var cellText = cells[j].innerText.trim();
                var cellContent = "";
                
                // Check if the cell contains a <span> element with the letter 'N'
                var spanElement = cells[j].querySelector('span');
                if (spanElement && spanElement.innerText.trim().length === 1 && spanElement.innerText.trim() === 'N') {
                    // If the <span> element contains only the letter 'N', exclude it from cellContent
                    cellContent = cellText.replace(spanElement.innerText, "").trim();
                } else {
                    // Otherwise, use the cell text as the content
                    cellContent = cellText;
                }
                
                rowData.push(cellContent);
            }
            tableData.push(rowData);
        }
        return tableData;
"@

    $cellTexts = $driver.ExecuteScript($cellsScript)

    # Add the cell texts to the tableData array
	$tableData += $cellTexts | ForEach-Object {
		$rowData = $_ -split "`r?`n" | ForEach-Object {
			$_ -replace ',', ' '
		}
		$rowData -join ","
	}

	# Refresh the next button element to avoid stale element reference error | Check if the nextButton contains the "disabled" class
	$nextButton = Find-SeElement -Driver $driver -Id "location-table_next"
    if ($nextButton.GetAttribute("class").Contains("disabled")) {
        break  # Exit the loop
    }

    # Refresh the next button element to avoid stale element reference error | Click the "Next" button
	$nextButton = Find-SeElement -Driver $driver -Id "location-table_next"
	$driver.ExecuteScript("arguments[0].click();", $nextButton)

        # Wait for the next page to load and the "Next" button to become enabled
        $wait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementToBeClickable([OpenQA.Selenium.By]::Id("location-table_next")))

    # Generate a random delay between 5 and 20 seconds
    $randomDelay = Get-Random -Minimum 5 -Maximum 20
    Start-Sleep -Seconds $randomDelay

    } catch {
	# Handle any exceptions that occur during the process
	Write-Host "An error occurred: $($_.Exception.Message)"
	break
    }
}

# Convert the table data to a CSV string
$csvContent = $tableData | ForEach-Object {
    $_ -join ","
}

# Save the CSV content to a file
$csvContent | Out-File -FilePath "skillbridge.csv"

# Clean up and quit the WebDriver instance
$driver.Quit()