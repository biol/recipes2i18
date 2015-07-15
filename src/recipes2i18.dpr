program recipes2i18;

uses
  Forms,
  guiRecipes in 'guiRecipes.pas' {FormRecipes},
  guiRecipeDetails in 'guiRecipeDetails.pas' {FormRecipeDetails},
  uEtcXE in '..\..\..\commonXE\uEtcXE.pas',
  guiTblPositions in 'guiTblPositions.pas' {FormTblPositions},
  CheckPreviousXE in '..\..\..\commonXE\CheckPreviousXE.pas',
  dbiRecipes in 'dbiRecipes.pas' {dmRecipes: TDataModule},
  guiGalvRecipes in 'guiGalvRecipes.pas' {FormGalvRecipes},
  guiSetpointCTRL in 'guiSetpointCTRL.pas' {FormSetpointCTRL},
  guiTblCLBRs in 'guiTblCLBRs.pas' {FormTblCLBR},
  dbiPickupDropRins in 'dbiPickupDropRins.pas' {dmPickupDropRins: TDataModule},
  guiDropTypes in 'guiDropTypes.pas' {FormDropTypes},
  guiPickupTypes in 'guiPickupTypes.pas' {FormPickupTypes},
  guiRinsingTypes in 'guiRinsingTypes.pas' {FormRinsingTypes};

{$R *.res}

begin if not CheckPreviousXE.RestoreIfRunning(Application.Handle) then begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmRecipes, dmRecipes);
  Application.CreateForm(TdmPickupDropRins, dmPickupDropRins);
  Application.CreateForm(TFormRecipes, FormRecipes);
  Application.CreateForm(TFormRecipeDetails, FormRecipeDetails);
  Application.CreateForm(TFormTblPositions, FormTblPositions);
  Application.CreateForm(TFormGalvRecipes, FormGalvRecipes);
  Application.CreateForm(TFormSetpointCTRL, FormSetpointCTRL);
  Application.CreateForm(TFormTblCLBR, FormTblCLBR);
  Application.CreateForm(TFormDropTypes, FormDropTypes);
  Application.CreateForm(TFormPickupTypes, FormPickupTypes);
  Application.CreateForm(TFormRinsingTypes, FormRinsingTypes);
  Application.Run;
end end.
