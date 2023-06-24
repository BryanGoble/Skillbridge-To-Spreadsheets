# Skillbridge To Spreadsheets
 Powershell script to scrape the DoD Skillbridge website and export to a CSV file to be used in your preferred spreadsheet editor.

## Why :question:
As an aspiring Software Engineer on my way out of the Navy's door, I'm always looking for my next "project". After seeing this [post](https://www.reddit.com/r/SkillBridge/comments/1463nip/any_way_to_download_skillbridge_locations_table/) on the Skillbridge subreddit in regards to locating a spreadsheet of the available programs, I knew I could help filling this void.

## Powershell > Python ? :snake:
I choose to write this in powershell simply because I felt more comfortable with the language. I use powershell fairly regularly at work to automate the renewal of Certificate Authority (CA) issued certificates and Active Directory manipulation, so this was a nice challenge while also expanding on my current knowledge.

## Selenium :brain:
Selenium's a solid web framework allowing for the automation of web applications. This was my first time working with Selenium and Powershell together. I've got brief prior experience with Selenium, so this was a major learning point for myself. I learned a bit more about locating DOM elements, how to manipulate said elements, and even how to use javascript with Selenium as you'll see in my script where I retrieve the "innerText" of all the table cells.

## Future Improvements :pencil:
1. Re-write the script in Python
2. Clean up the table that's output to CSV
3. Omit the output of the text within the \<span> elements.
    - There are some \<td> elements that also contain a \<span> with the letter N indicating that the program is available nationwide and/or online. This is redundant and ends up shifting rows of data to the right preventing the use of sorting in each column.

## License Agreement :page_with_curl:
Licensed under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). [Link](.\LICENSE)
- You are free to:
    1. Share - Copy and redistribute the material in any medium or format
    2. Adapt - Remix, transform, and build upon the material
- Restriction:
    1. Attribution - You <b>must</b> give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    2. You may <b>not</b> use the material for commercial purposes.
