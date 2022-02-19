select * from housing;


Update Housing
set SaleDate=convert(date,SaleDate)

Alter table housing
Add SaleDateConverted date;

Update Housing
Set SaleDateConverted=convert(date,SaleDate);


select SaleDateConverted from housing;

select PropertyAddress from housing;

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from housing a
join housing b
on a.ParcelID=b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null

Update a
SET a.PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
from housing a
join housing b
on a.ParcelID=b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null

select substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) as address ,
substring(propertyaddress,CHARINDEX(',',propertyaddress)+1,len(PropertyAddress)) as address
from housing;


Alter table housing
Add PropertySplitAddress nvarchar(255);

Update Housing
Set PropertySplitAddress=substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) 

Alter table housing
Add PropertyCity nvarchar(255);

Update Housing
Set PropertyCity=substring(propertyaddress,CHARINDEX(',',propertyaddress)+1,len(PropertyAddress))

select OwnerAddress from housing
parsename(replace((OwnerAddress,',','.'),3),
parsename(replace((OwnerAddress,',','.'),2),
parsename(replace((OwnerAddress,',','.'),1)
from housing;

Alter table housing
Add OwnerSplitAddress nvarchar(255) ;

Update Housing
Set OwnerSplitAddress=parsename(replace((OwnerAddress,',','.'),3)

Alter table housing
Add OwnerSplitState nvarchar(255) ;

Update Housing
Set OwnerSplitState=parsename(replace((OwnerAddress,',','.'),2)

Alter table housing
Add OwnerSplitCity nvrchar(255) ;

Update Housing
Set OwnerSplitCity=parsename(replace((OwnerAddress,',','.'),1)

Select Distinct SoldAsVacant,count(SoldAsVacant) from housing
group by SoldAsVacant
order by 2;

Select SoldAsVacant
CASE When SoldAsVacant='Y' then 'Yes'
When SoldAsVacant='N' then 'No'
Else SoldAsVacant
END
from housing;

Update Housing
Set SoldAsVacant=CASE When SoldAsVacant='Y' then 'Yes'
When SoldAsVacant='N' then 'No'
Else SoldAsVacant
END

WITH RowNumCTE as(
Select *, 
      Row_Number() over (
	  Partition By ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   Order By UniqueID)row_num
from housing
)

Select * from RowNumCTE 
where row_num>1
order by PropertyAddress;

Delete from RowNumCTE 
where row_num>1
