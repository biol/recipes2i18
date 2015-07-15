object dmPickupDropRins: TdmPickupDropRins
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 315
  Width = 383
  object fdtPickupTypes: TFDTable
    AfterOpen = fdtPickupTypesAfterOpen
    BeforePost = fdtPickupTypesBeforePost
    OnNewRecord = fdtPickupTypesNewRecord
    IndexFieldNames = 'ID'
    Connection = dmRecipes.recipesCnx
    UpdateOptions.UpdateTableName = 'PICKUPTYPES'
    TableName = 'PICKUPTYPES'
    Left = 56
    Top = 56
  end
  object fdqRecipesUtil: TFDQuery
    Connection = dmRecipes.recipesCnx
    Left = 56
    Top = 152
  end
  object fdtDropTypes: TFDTable
    AfterOpen = fdtDropTypesAfterOpen
    BeforePost = fdtDropTypesBeforePost
    OnNewRecord = fdtDropTypesNewRecord
    IndexFieldNames = 'ID'
    Connection = dmRecipes.recipesCnx
    UpdateOptions.UpdateTableName = 'DROPTYPES'
    TableName = 'DROPTYPES'
    Left = 160
    Top = 56
  end
  object fdtRinsingTypes: TFDTable
    AfterOpen = fdtRinsingTypesAfterOpen
    BeforePost = fdtRinsingTypesBeforePost
    OnNewRecord = fdtRinsingTypesNewRecord
    IndexFieldNames = 'ID'
    Connection = dmRecipes.recipesCnx
    UpdateOptions.UpdateTableName = 'RINSINGTYPES'
    TableName = 'RINSINGTYPES'
    Left = 264
    Top = 56
  end
end
