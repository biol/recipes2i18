program recipes2i18;

uses
  Forms,
  guiRecipes in 'guiRecipes.pas' {FormRecipes},
  guiRecipeDetails in 'guiRecipeDetails.pas' {FormRecipeDetails},
  uEtcXE in '..\..\..\commonXE\uEtcXE.pas',
  guiTblPositions in 'guiTblPositions.pas' {FormTblPositions},
  guiTblTIPIDROP_07 in 'guiTblTIPIDROP_07.pas' {FormTblTIPIDROP_07},
  guiTblTIPIPICK_07 in 'guiTblTIPIPICK_07.pas' {FormTblTIPIPICK_07},
  guiTblTIPIRINS_07 in 'guiTblTIPIRINS_07.pas' {FormTblTIPIRINS_07},
  CheckPreviousXE in '..\..\..\commonXE\CheckPreviousXE.pas',
  dbiRecipes in 'dbiRecipes.pas' {dmRecipes: TDataModule},
  guiGalvRecipes in 'guiGalvRecipes.pas' {FormGalvRecipes},
  guiSetpointCTRL in 'guiSetpointCTRL.pas' {FormSetpointCTRL};

{$R *.res}

begin if not CheckPreviousXE.RestoreIfRunning(Application.Handle) then begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmRecipes, dmRecipes);
  Application.CreateForm(TFormRecipes, FormRecipes);
  Application.CreateForm(TFormRecipeDetails, FormRecipeDetails);
  Application.CreateForm(TFormTblPositions, FormTblPositions);
  Application.CreateForm(TFormTblTIPIDROP_07, FormTblTIPIDROP_07);
  Application.CreateForm(TFormTblTIPIPICK_07, FormTblTIPIPICK_07);
  Application.CreateForm(TFormTblTIPIRINS_07, FormTblTIPIRINS_07);
  Application.CreateForm(TFormGalvRecipes, FormGalvRecipes);
  Application.CreateForm(TFormSetpointCTRL, FormSetpointCTRL);
  Application.Run;
end end.
