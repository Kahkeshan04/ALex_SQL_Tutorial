/* Cleaning Data in SQL Queries */

SELECT * FROM [Nashvile Housing Data]..NashvileHousing


/* Standardize Data Format 
   Extracting only date from the date and time already providing by using CONVERT(Date,ColumnName)
*/

SELECT SaleDate, CONVERT(Date,SaleDate) As Sales_Date 
FROM [Nashvile Housing Data]..NashvileHousing

/* Trying to set the default SaleDate column to only Date values */

/* With just UPDATE its not working */
UPDATE [Nashvile Housing Data]..NashvileHousing
SET SaleDate = CONVERT(Date,SaleDate)

/* With ALTER and ADDing column it worked */
ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD SaleDateConverted Date;

UPDATE [Nashvile Housing Data]..NashvileHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted FROM [Nashvile Housing Data]..NashvileHousing

/* Populate Property Address data */

SELECT PropertyAddress
FROM [Nashvile Housing Data]..NashvileHousing
WHERE PropertyAddress IS NULL

SELECT *
FROM [Nashvile Housing Data]..NashvileHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

/* SELF JOIN */

/* Steps to see & understand the result in better way 
   The ParcelID's are representation of the Property Address.
   And the ParcelID's are repeated, where there are some NULL values in PropertyAddress
   Now we are trying to get the same ParcelID with PropertyAddress with values and NULL, NULL will be replaced with Values*/

/* Step - 1 : Trying to get the ParcelID's with the same values*/
SELECT *
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID

/* Step - 2 : As UniqueID's are not repeated the JOIN will show the ParcelID with UniqueID, hence preventing from self-repeatation */
SELECT *
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]


 /* Step - 3 : We just need NULL values row of PropertyAddress 
			The following dispaly the row with same ParcelID's with NULL Values in PropertyAddress and values in PropertyAddress*/
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
 WHERE a.PropertyAddress IS NULL

/* Step - 3 : Just Copying the same PracelID PropertyAddress to NULL rows*/
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) 
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
 WHERE a.PropertyAddress IS NULL
  

/* New Column from the above query will get update in the table */
UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
 WHERE a.PropertyAddress IS NULL


/* Instead of value we can place a string */
/*
UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress,'NO Address')
FROM [Nashvile Housing Data]..NashvileHousing a
JOIN [Nashvile Housing Data]..NashvileHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
 WHERE a.PropertyAddress IS NULL
*/

/* Breaking out Address into individual columns (Address, City, State) */
/* Method - 2 */

SELECT PropertyAddress
FROM [Nashvile Housing Data]..NashvileHousing
 
/* Step-1 : By default comma is included
			SUBSTRING (ColumnName, PositionNumber, CHARINDEX(' ', ColumnName))
			Column - The column in which need the modification
			PositionNumber - Position from which the new string should start
			CHARINDEX - Finds the INDEX of the Char or string passed as 1st argument, in the column passed as the 2nd argument*/
SELECT SUBSTRING(PropertyAddress, 6, CHARINDEX(',', PropertyAddress)) AS Address, CHARINDEX(',', PropertyAddress)
FROM [Nashvile Housing Data]..NashvileHousing

/* Step-2 : Exclude the comma  
			-1 in the SUBSTRING is Substracting it value from the Index values which is defined by CHARINDEX
			EX: CHARINDEX(',', PropertyAddress) - 1 == 19-1
			Hence the actual arguement will be like 
			SUBSTRING(PropertyAddress, 1, 18) For the first row
			SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress) == SUBSTRING(PropertyAddress, 20, 34)*/
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM [Nashvile Housing Data]..NashvileHousing

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD PropertySplitAddress NVarchar(255);

UPDATE [Nashvile Housing Data]..NashvileHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD PropertySplitCity NVarchar(255);

UPDATE [Nashvile Housing Data]..NashvileHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT * FROM [Nashvile Housing Data]..NashvileHousing

/* Method - 2 */

SELECT OwnerAddress FROM [Nashvile Housing Data]..NashvileHousing

/* PARSENAME - It the do things backwards */
SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM [Nashvile Housing Data]..NashvileHousing

/* To get it in right order - the numbers should be reversed */
SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM [Nashvile Housing Data]..NashvileHousing

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD OwnerSplitAddress NVarchar(255);

UPDATE [Nashvile Housing Data]..NashvileHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD OwnerSplitCity NVarchar(255);

UPDATE [Nashvile Housing Data]..NashvileHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
ADD OwnerSplitState NVarchar(255);

UPDATE [Nashvile Housing Data]..NashvileHousing
SET OwnerSplitState= PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

SELECT * FROM [Nashvile Housing Data]..NashvileHousing

/* Change Y and N to Yes and No in "Sold as Vacant" field */

SELECT Distinct(SoldAsVacant)
FROM [Nashvile Housing Data]..NashvileHousing

SELECT Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM [Nashvile Housing Data]..NashvileHousing
Group by SoldAsVacant
Order by 2

/* To check whether the query is performing correctly or not */
SELECT SoldAsVacant,
CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM [Nashvile Housing Data]..NashvileHousing

/* Acutally updating the table */
UPDATE [Nashvile Housing Data]..NashvileHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END

/* Remove Duplicates */

/* The following query show the incearsed value to the duplicate value in row_num which is created by us */
SELECT *,
	ROW_NUMBER() OVER ( 
	PARTITION BY ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID ) Row_Num
FROM [Nashvile Housing Data]..NashvileHousing
ORDER BY ParcelID

/* Removing that Duplicates value */
WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER ( 
	PARTITION BY ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID ) Row_Num
FROM [Nashvile Housing Data]..NashvileHousing
)
--DELETE FROM RowNumCTE
--WHERE Row_Num > 1
SELECT * FROM RowNumCTE
WHERE Row_Num > 1
ORDER BY PropertyAddress

/* Delete Unused Columns*/
SELECT *
FROM [Nashvile Housing Data]..NashvileHousing

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE [Nashvile Housing Data]..NashvileHousing
DROP COLUMN SaleDate