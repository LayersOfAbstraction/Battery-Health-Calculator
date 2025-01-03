	Add-Type -AssemblyName System.Windows.Forms
	
	# Declare variables
	$logFile = "_logFile.txt"
	[int]$intDesignedCapacity = 0
	[int]$intFullChargeCapacity = 0
	[int]$intResult = 0
	
	# Create form
	$frmBatteryHealthCalculator = New-Object System.Windows.Forms.Form
	$frmBatteryHealthCalculator.Text = "Battery Health Calculator"
	$frmBatteryHealthCalculator.Width = 300
	$frmBatteryHealthCalculator.Height = 200
	
	# Create labels and text boxes
	$label1 = New-Object System.Windows.Forms.Label
	$label1.Text = "Design Capacity:"
	$label1.AutoSize = $true
	$label1.Top = 20
	$label1.Left = 10
	$frmBatteryHealthCalculator.Controls.Add($label1)
	
	$txtDCapacity = New-Object System.Windows.Forms.TextBox
	$txtDCapacity.Top = 20
	$txtDCapacity.Left = 150
	$txtDCapacity.Width = 100
	$frmBatteryHealthCalculator.Controls.Add($txtDCapacity)
	
	$label2 = New-Object System.Windows.Forms.Label
	$label2.Text = "Full Charge Capacity:"
	$label2.AutoSize = $true
	$label2.Top = 60
	$label2.Left = 10
	$frmBatteryHealthCalculator.Controls.Add($label2)
	
	$txtFullChargeCapacity = New-Object System.Windows.Forms.TextBox
	$txtFullChargeCapacity.Top = 60
	$txtFullChargeCapacity.Left = 150
	$txtFullChargeCapacity.Width = 100
	$frmBatteryHealthCalculator.Controls.Add($txtFullChargeCapacity)
	
	# Create button
	$btnCalculate = New-Object System.Windows.Forms.Button
	$btnCalculate.Text = "Calculate"
	$btnCalculate.Top = 100
	$btnCalculate.Left = 100
	$frmBatteryHealthCalculator.Controls.Add($btnCalculate)
	
	# Add event handler for button click
	$btnCalculate.Add_Click({
	    try {		
			$currentDateTime = (Get-Date).ToString("yyyy/MM/dd hh:mmtt") 
			Add-Content -Path $logFile -Value "Script started $currentDateTime`n"

	        $intDesignedCapacity = [int]$txtDCapacity.Text
	        $intFullChargeCapacity = [int]$txtFullChargeCapacity.Text
	
	        # Validate input
	        if ($intDesignedCapacity -gt 0 -and $intFullChargeCapacity -gt 0) {
	            # Calculate battery health percentage
	            $intResult = ($intFullChargeCapacity / $intDesignedCapacity) * 100
	            [System.Windows.Forms.MessageBox]::Show("Battery Health: {0}%" -f [math]::Round($intResult, 2))
	        } else {
	            [System.Windows.Forms.MessageBox]::Show("ERROR: Please enter valid numbers greater than zero.")
	        }
	    }
	    catch [System.Exception] {
			
			[System.Windows.Forms.MessageBox]::Show("ERROR: That is not a whole number. Errors logged in application log file. Please ensure not to include symbols or letters." )
			Add-Content -Path $logFile -Value "Error: $($_.Exception.Message) $currentDateTime`n"
	    }
	})
	
	# Show form
$frmBatteryHealthCalculator.ShowDialog()