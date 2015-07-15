unit guiRecipes; {
  Rel.2xxx: 23jul2014
    nel dettaglio c'è sia il GalvanicID che il ReserveColorCheck
    tolto tutto il target e il setpoint dalla testata

}

interface

uses
  SysUtils, Forms, Dialogs, guiTblPositions, siComp,
  Vcl.DBCtrls, Vcl.DBGrids, Data.DB,
  Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, System.Classes, Vcl.Graphics,
  Vcl.Controls;

type
  TFormRecipes = class(TForm)
    pnlHead: TPanel;
    pnlFoot: TPanel;
    pnlRecipeDetail: TPanel;
    dbgRecipes: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsRecipes: TDataSource;
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
    lblITA: TLabel;
    lblENG: TLabel;
    lblSTR: TLabel;
    ImageLogo: TImage;
    siLangDispatcher1: TsiLangDispatcher;
    siLang1: TsiLang;
    btnGoDetails: TButton;
    btnPositions: TButton;
    btnGalvanica: TButton;
    btnDropTypes: TButton;
    btnPickupTypes: TButton;
    btnRinsingTypes: TButton;
    lblNewRecipe: TLabel;
    lblCopyFromID: TLabel;
    editNewRecipeID: TEdit;
    EditCopyFromID: TEdit;
    btnNewRecipe: TButton;
    lblTurkish: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgRecipesDblClick(Sender: TObject);
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
    procedure saveData;
    procedure goDetails;
  end;

var
  FormRecipes: TFormRecipes;

implementation uses guiRecipeDetails, uEtcXE, dbiRecipes, guiTblGalvanica, guiGalvRecipes, guiDropTypes, guiPickupTypes,
  guiRinsingTypes, dbiPickupDropRins;

{$R *.dfm}

procedure TFormRecipes.btnDropTypesClick(Sender: TObject);
begin
  FormDropTypes.show
end;

procedure TFormRecipes.btnGalvanicaClick(Sender: TObject);
begin
  FormGalvRecipes.show
end;

procedure TFormRecipes.btnGoDetailsClick(Sender: TObject);
begin
  goDetails
end;

procedure TFormRecipes.btnNewRecipeClick(Sender: TObject);
begin
  doNewRecipe
end;

procedure TFormRecipes.doNewRecipe;
var newID, copyFromID: integer;   sNewName: string;
begin  saveData;

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
    dmRecipes.buildNewEmptyRecipe(newID, sNewName);
    exit;  // bona lè
  end;

  // duplica
  dmRecipes.copyRecipeFromTo(copyFromID, newID);   // preparo di dettagli della new recipe
end;

procedure TFormRecipes.btnPickupTypesClick(Sender: TObject);
begin
  FormPickupTypes.Show
end;

procedure TFormRecipes.btnPositionsClick(Sender: TObject);
begin
  FormTblPositions.show
end;

procedure TFormRecipes.btnRinsingTypesClick(Sender: TObject);
begin
  FormRinsingTypes.show
end;

procedure TFormRecipes.dbgRecipesDblClick(Sender: TObject); begin goDetails end;

procedure TFormRecipes.dbgRecipesTitleClick(Column: TColumn);
begin
  dmRecipes.tblRecipes.IndexFieldNames := Column.FieldName
end;

procedure TFormRecipes.goDetails;
begin
  with FormRecipeDetails do begin
    setup(dmRecipes.tblRecipes.fieldByName('IDRICETTA'  ).asInteger,
          dmRecipes.tblRecipes.fieldByName('NOME'       ).asString,
          dmRecipes.tblRecipes.fieldByName('DESCRIZIONE').asString);
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
  dmRecipes.openRecipesAndFriends;
  dmPickupDropRins.openTypes;
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
  saveData;
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

procedure TFormRecipes.saveData;
begin
  dmRecipes.tblRecipes.checkBrowseMode;
  dmRecipes.tblRecipeSteps.checkBrowseMode;
end;

end.
