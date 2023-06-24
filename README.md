# Skillbridge To Spreadsheets
 Powershell script to scrape the DoD Skillbridge website and export to a CSV file to be used in your preferred spreadsheet editor.

## Latest Available Spreadsheet :hash:
Google Sheets - [22 JUN 2023](https://docs.google.com/spreadsheets/d/1vUvQGKiBTDs6KNwdYSrNpPY_ouG8f7RHZ8w0IOcV0YI/edit?usp=sharing)
<br>
I will upload a new sheet about once per week to facilitate an easy review of the data and prevent too many people from wanting to scrape the site. Ultimately, this was a fun project and allows easier navigation/sorting of the available programs, so please don't abuse this.
#
## Why :question:
As an aspiring Software Engineer on my way out of the Navy's door, I'm always looking for my next "project". After seeing this [post](https://www.reddit.com/r/SkillBridge/comments/1463nip/any_way_to_download_skillbridge_locations_table/) on the [Skillbridge subreddit](https://www.reddit.com/r/SkillBridge/) in regards to locating a spreadsheet of the available programs, I knew I could help filling this void.

## Powershell > Python ? :snake:
I choose to write this in powershell simply because I felt more comfortable with the language. I use powershell fairly regularly at work to automate the renewal of Certificate Authority (CA) issued certificates and Active Directory manipulation, so this was a nice challenge while also expanding on my current knowledge.

## Selenium :brain:
Selenium's a solid web framework allowing for the automation of web applications. This was my first time working with Selenium and Powershell together. I've got brief prior experience with Selenium, so this was a major learning point for myself. I learned a bit more about locating DOM elements, how to manipulate said elements, and even how to use javascript with Selenium as you'll see in my script where I retrieve the "innerText" of all the table cells.

## How To Use :keyboard:
From the code tab, click on the 'script.ps1' file and then the download button. Once downloaded, right-click the file then 'Run with Powershell'.
- To scrape all 570+ pages on the site, took about 3-4 hours. That's also with the random 5-20 second delay that I implemented as I did not want to stress the site.

## Future Improvements :pencil:
1. Re-write the script in Python
2. Clean up the table that's output to CSV
3. Omit the output of the text within the \<span> elements.
    - There are some \<td> elements that also contain a \<span> with the letter N indicating that the program is available nationwide and/or online. This is redundant and ends up shifting rows of data to the right preventing the use of sorting in each column.
4. Create a reddit bot that automatically runs this script at a set interval, updates the Google Sheets link and posts the update to the Skillbridge subreddit.

## License Agreement :page_with_curl:
Licensed under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). [Link](.\LICENSE)
- You are free to:
    1. Share - Copy and redistribute the material in any medium or format
    2. Adapt - Remix, transform, and build upon the material
- Restriction:
    1. Attribution - You <b>must</b> give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    2. You may <b>not</b> use the material for commercial purposes.
