unit guiGalvRecipes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, siComp, siLngLnk;

type
  TFormGalvRecipes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dsGalvRecipes: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    dsEleRecipeSteps: TDataSource;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    lblRel: TLabel;
    siLangLinked1: TsiLangLinked;
    lblNewRecipe: TLabel;
    editNewRecipeID: TEdit;
    lblCopyFromID: TLabel;
    EditCopyFromID: TEdit;
    btnNewRecipe: TButton;
    btnCalibrations: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewRecipeClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnCalibrationsClick(Sender: TObject);
  private
    procedure saveData;
    procedure doNewGalvRecipe;
    procedure showSetPoint;
  public
    { Public declarations }
  end;

var
  FormGalvRecipes: TFormGalvRecipes;

implementation uses dbiRecipes, guiSetpointCTRL, uEtcXE, guiRecipes, guiTblCLBRs;

{$R *.dfm}



procedure TFormGalvRecipes.btnNewRecipeClick(Sender: TObject);
begin
  doNewGalvRecipe
end;

procedure TFormGalvRecipes.btnCalibrationsClick(Sender: TObject);
begin
  formTblCLBR.show
end;

procedure TFormGalvRecipes.DBGrid1DblClick(Sender: TObject);
begin
  showSetPoint
end;

procedure TFormGalvRecipes.DBGrid2DblClick(Sender: TObject);
begin
  showSetPoint
end;

procedure TFormGalvRecipes.showSetPoint;
begin
  with FormSetpointCTRL do begin
    hideFields(dbiRecipes.isOxi(dsGalvRecipes.DataSet.FieldByName('IDELETTROCOLORE').asInteger), dbiRecipes.isDIGI, dbiRecipes.isBru);
    showModal
  end
end;

procedure TFormGalvRecipes.doNewGalvRecipe;
var newID, copyFromID: integer;   sNewName: string;
begin  saveData;

  newID := strToIntDef(editNewRecipeID.Text, 0);   editNewRecipeID.Text := intToStr(newID);
  // verifica NON esistenza di newID e che sia > 0
  if newID <= 0 then begin
    showMessage(siLangLinked1.GetTextOrDefault('IDS_2' (* 'you can only use positive integers for NEW recipe ID' *) ));   exit
  end;
  if dmRecipes.recipeExists(newID) then begin
    showMessage(format(siLangLinked1.GetTextOrDefault('IDS_3' (* 'NEW recipe %d already exists.' *) ), [newID]));   exit
  end;

  copyFromID := strToIntDef(EditCopyFromID .Text, 0);   EditCopyFromID .Text := intToStr(copyFromID);
  // verifica esistenza di copyFromID se e solo se è > 0
  if (copyFromID > 0) and (not dmRecipes.recipeExists(copyFromID)) then begin
    showMessage(format(siLangLinked1.GetTextOrDefault('IDS_4' (* '"copy from" recipe %d does not exist.' *) ), [copyFromID]));   exit
  end else begin   // mi prendo i dati della testata ...
  end;

  // se l'utente conferma ... facciamo un paio di query di inserimento ...
  if (copyFromID > 0) then begin
    if messageDlg(format(siLangLinked1.GetTextOrDefault('IDS_5' (* 'Confirm copying existing recipe %d to NEW recipe %d ?' *) ),
      [copyFromID, newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLangLinked1.GetTextOrDefault('IDS_6' (* 'copy of' *) ) + intToStr(copyFromID);
  end else begin
    if messageDlg(format(siLangLinked1.GetTextOrDefault('IDS_7' (* 'Confirm creating a new EMPTY recipe with ID %d ?' *) ),
      [newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLangLinked1.GetTextOrDefault('IDS_8' (* 'new recipe' *) );
  end;

  if copyFromID = 0 then begin
    dmRecipes.buildNewEmptyGalvRecipe(newID, sNewName);
    exit;  // bona lè
  end;

  // duplica
  dmRecipes.copyGalvRecipeFromTo(copyFromID, newID);   // preparo di dettagli della new recipe
end;


procedure TFormGalvRecipes.saveData;
begin
  dmRecipes.tblGalvRecipes.checkBrowseMode;
  dmRecipes.tblGalvRecipeSteps.checkBrowseMode;
end;

procedure TFormGalvRecipes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveData;
  saveFormDims(self);
end;

procedure TFormGalvRecipes.FormCreate(Sender: TObject);
begin
  lblRel.caption := 'Rel.' + sGetBuildInfo
end;

end.
