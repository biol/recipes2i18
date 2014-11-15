unit guiRecipes; {
  Rel.2xxx: 23jul2014
    nel dettaglio c'è sia il GalvanicID che il ReserveColorCheck
    tolto tutto il target e il setpoint dalla testata

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXFirebird, DB, SqlExpr, DBCtrls, Grids, DBGrids, ExtCtrls, FMTBcd,
  Provider, DBClient, midasLib, StdCtrls, Mask, guiTblPositions, siComp;

type
  TFormRecipes = class(TForm)
    pnlHead: TPanel;
    pnlFoot: TPanel;
    pnlRecipeDetail: TPanel;
    dbgRecipes: TDBGrid;
    DBNavigator1: TDBNavigator;
    cnxRecipes: TSQLConnection;
    dsRecipes: TDataSource;
    btnSaveData: TButton;
    dbeNOME: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    dbeCLIENTE: TDBEdit;
    Label4: TLabel;
    dbcbDISPONIBILE: TDBCheckBox;
    dbmDESCRIZIONE: TDBMemo;
    lblRel: TLabel;
    lblGdb: TLabel;
    DBNavigator2: TDBNavigator;
    btnPositions: TButton;
    lblITA: TLabel;
    lblENG: TLabel;
    btnDropTypes: TButton;
    btnPickupTypes: TButton;
    btnRinsingTypes: TButton;
    lblNewRecipe: TLabel;
    editNewRecipeID: TEdit;
    EditCopyFromID: TEdit;
    lblCopyFromID: TLabel;
    btnNewRecipe: TButton;
    lblSTR: TLabel;
    ImageLogo: TImage;
    siLangDispatcher1: TsiLangDispatcher;
    siLang1: TsiLang;
    btnGoDetails: TButton;
    btnGalvanica: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSaveDataClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgRecipesDblClick(Sender: TObject);
    procedure cnxRecipesBeforeConnect(Sender: TObject);
    procedure btnPositionsClick(Sender: TObject);
    procedure btnDropTypesClick(Sender: TObject);
    procedure btnPickupTypesClick(Sender: TObject);
    procedure btnRinsingTypesClick(Sender: TObject);
    procedure btnNewRecipeClick(Sender: TObject);
    procedure lblITAClick(Sender: TObject);
    procedure dbgRecipesTitleClick(Column: TColumn);
    procedure btnGoDetailsClick(Sender: TObject);
    procedure btnGalvanicaClick(Sender: TObject);
  private
    _booting, _prelDepoRins: boolean;
    procedure doNewRecipe;
  public
    function saveData(pAsk: boolean = false): boolean;
    procedure goDetails;
    procedure buildNewEmptyRecipe(pRecipeID: integer; pName: string);
  end;

var
  FormRecipes: TFormRecipes;

implementation uses recError, guiRecipeDetails, uEtcXE, guiTblTIPIDROP_07, guiTblTIPIPICK_07,
  guiTblTIPIRINS_07, dbiRecipes, guiTblGalvanica;

{$R *.dfm}

procedure TFormRecipes.btnDropTypesClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipes.btnGalvanicaClick(Sender: TObject);
begin
  FormTblGalvanica.show
end;

procedure TFormRecipes.btnGoDetailsClick(Sender: TObject);
begin
  goDetails
end;

procedure TFormRecipes.btnNewRecipeClick(Sender: TObject); begin doNewRecipe end;

procedure TFormRecipes.doNewRecipe;
var newID, copyFromID: integer;   sNewName: string;
begin
  if not saveData(true) then begin
    showMessage('ERROR saving data ... please investigate and retry');
    exit;
  end;

  newID := strToIntDef(editNewRecipeID.Text, 0);   editNewRecipeID.Text := intToStr(newID);
  // verifica NON esistenza di newID e che sia > 0
  if newID <= 0 then begin
    showMessage(siLang1.GetTextOrDefault('IDS_2' (* 'you can only use positive integers for NEW recipe ID' *) ));   exit
  end;
  if dmRecipes.recipeExists(newID) then begin
    showMessage(format(siLang1.GetTextOrDefault('IDS_3' (* 'NEW recipe %d already exists.' *) ), [newID]));   exit
  end;

  copyFromID := strToIntDef(EditCopyFromID .Text, 0);   EditCopyFromID .Text := intToStr(copyFromID);
  // verifica esistenza di copyFromID se e solo se è > 0
  if (copyFromID > 0) and (not dmRecipes.recipeExists(copyFromID)) then begin
    showMessage(format(siLang1.GetTextOrDefault('IDS_4' (* '"copy from" recipe %d does not exist.' *) ), [copyFromID]));   exit
  end else begin   // mi prendo i dati della testata ...
  end;

  // se l'utente conferma ... facciamo un paio di query di inserimento ...
  if (copyFromID > 0) then begin
    if messageDlg(format(siLang1.GetTextOrDefault('IDS_5' (* 'Confirm copying existing recipe %d to NEW recipe %d ?' *) ),
      [copyFromID, newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLang1.GetTextOrDefault('IDS_6' (* 'copy of' *) ) + intToStr(copyFromID);
  end else begin
    if messageDlg(format(siLang1.GetTextOrDefault('IDS_7' (* 'Confirm creating a new EMPTY recipe with ID %d ?' *) ),
      [newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLang1.GetTextOrDefault('IDS_8' (* 'new recipe' *) );
  end;

  if copyFromID = 0 then begin
    buildNewEmptyRecipe(newID, sNewName);
    exit;  // bona lè
  end;

  // duplica
  buildNewEmptyRecipe(newID, sNewName);
  with FormRecipeDetails do begin
    setup(copyFromID, '');   // porto su i dettagli della copyFrom recipe
    DuplicateRecipe(cdsRecipeDetails, newID);   // preparo di dettagli della new recipe
  end;
end;

procedure TFormRecipes.btnPickupTypesClick(Sender: TObject);
begin
  FormTblTIPIPICK_07.Show
end;

procedure TFormRecipes.btnPositionsClick(Sender: TObject);
begin
  FormTblPositions.show
end;

procedure TFormRecipes.btnRinsingTypesClick(Sender: TObject);
begin
  FormTblTIPIRINS_07.show
end;

procedure TFormRecipes.btnSaveDataClick(Sender: TObject);
begin
  saveData
end;

procedure TFormRecipes.buildNewEmptyRecipe(pRecipeID: integer; pName: string);
begin
  if not saveData(false) then begin
    showMessage('error BEFORE creating new empty recipe: can''t save data');
    exit;   // si opera solo a dati salvati
  end;
  dmRecipes.buildNewEmptyRecipe(pRecipeID, pName);
end;

procedure TFormRecipes.cnxRecipesBeforeConnect(Sender: TObject);
begin with Sender as TSqlConnection do begin
  params.Values['database'] := absolutizePath(puntoIni.ReadString('config', 'database',
    changeFileExt(application.ExeName, '.gdb')))
end end;

procedure TFormRecipes.dbgRecipesDblClick(Sender: TObject); begin goDetails end;
procedure TFormRecipes.dbgRecipesTitleClick(Column: TColumn);
begin
  dmRecipes.tblRecipes.IndexFieldNames := Column.FieldName
end;

procedure TFormRecipes.goDetails;
begin
  with FormRecipeDetails do begin
    setup(dmRecipes.tblRecipes.fieldByName('IDRICETTA').asInteger,
          dmRecipes.tblRecipes.fieldByName('NOME').asString);

    showModal;
  end;
end;

procedure TFormRecipes.lblITAClick(Sender: TObject);
begin with Sender as TLabel do begin
  siLangDispatcher1.ActiveLanguage := tag;
end end;

procedure TFormRecipes.FormActivate(Sender: TObject);
begin   if not _booting then exit;                   // eliminare integrando in aooBootXE
  _booting := false;
  lblRel.caption := 'Rel.' + sGetBuildInfo;
  lblGdb.caption := 'Gdb.' + dmRecipes.recipesCnx.Params.Values['database'];
  loadFormDimsNoLang(self);

  siLangDispatcher1.ActiveLanguage := puntoIni.ReadInteger('config', 'lang_num', 1);
  // 22/05/2014 GBM
  _prelDepoRins    := puntoIni.ReadBool('config', 'prelDepoRins'   , true);
  btnDropTypes   .Visible := _prelDepoRins;
  btnPickupTypes .Visible := _prelDepoRins;
  btnRinsingTypes.Visible := _prelDepoRins;

  dbgRecipes.Columns[1].FieldName := puntoIni.ReadString('dbgRecipes', 'NOME', 'NOME');
  dbgRecipes.Columns[2].FieldName := puntoIni.ReadString('dbgRecipes', 'DESCRIZIONE', 'DESCRIZIONE');
  dbeNome.DataField        := dbgRecipes.Columns[1].FieldName;
  dbmDescrizione.DataField := dbgRecipes.Columns[2].FieldName;
end;

procedure TFormRecipes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveData(true);
  saveFormDims(self);
  puntoIni.writeInteger('config', 'lang_num', siLangDispatcher1.ActiveLanguage);
end;

procedure TFormRecipes.FormCreate(Sender: TObject);
begin
  _booting := true;
  with siLangDispatcher1 do begin
    FileName := puntoIni.ReadString('config', 'lang_sib', changeFileExt(application.exeName, '.sib'));
    loadAllFromFile(Filename)
  end;
end;

function TFormRecipes.saveData(pAsk: boolean): boolean;
begin
  with dmRecipes.tblRecipes do begin
    checkBrowseMode;
    if changeCount > 0 then begin
      if pAsk and (messageDlg(siLang1.GetTextOrDefault('IDS_10' (* 'save data ?' *) ), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK) then begin
        result := false;   exit
      end;
      applyUpdates(0);
    end;
  end;
  result := true;
end;

end.
