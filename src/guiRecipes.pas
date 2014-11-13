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
    qdsRecipes: TSQLDataSet;
    dspRecipes: TDataSetProvider;
    cdsRecipes: TClientDataSet;
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
    qdsUtils: TSQLDataSet;
    lblSTR: TLabel;
    ImageLogo: TImage;
    siLangDispatcher1: TsiLangDispatcher;
    siLang1: TsiLang;
    btnGoDetails: TButton;
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
    procedure cdsRecipesBeforeInsert(DataSet: TDataSet);
    procedure cdsRecipesBeforeDelete(DataSet: TDataSet);
    procedure lblITAClick(Sender: TObject);
    procedure cdsRecipesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsRecipesNewRecord(DataSet: TDataSet);
    procedure dbgRecipesTitleClick(Column: TColumn);
    procedure btnGoDetailsClick(Sender: TObject);
  private
    _booting, _EloxiRecipes, _EloxiSetPoint, _DensitySetPoint,
    _prelDepoRins: boolean;
    procedure doNewRecipe;
    procedure doDeleteRecipeDetails(pRecipeID: integer);
    procedure updateSetpointsTargetsFromDetails;
  public
    function saveData(pAsk: boolean = false): boolean;
    procedure goDetails;
    function recipeExists(pRecipeID: integer): boolean;
    procedure buildNewEmptyRecipe(pRecipeID: integer; pName: string);
    procedure buildNewCopyRecipe(pRecipeID: integer; pName: string);
  end;

var
  FormRecipes: TFormRecipes;

implementation uses recError, guiRecipeDetails, uEtcXE, guiTblTIPIDROP_07, guiTblTIPIPICK_07,
  guiTblTIPIRINS_07;

{$R *.dfm}

var
  copyFrom_ELERECIPEID
, copyFrom_OXIVOLTSETPOINTX10
, copyFrom_OXIAMPSETPOINT
, copyFrom_OXIDENSITYSETPOINTX100
, copyFrom_OXIMICRONSETPOINTX10
, copyFrom_OXISECONDSSETPOINT: integer;


procedure TFormRecipes.btnDropTypesClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipes.btnGoDetailsClick(Sender: TObject);
begin
  goDetails
end;

procedure TFormRecipes.btnNewRecipeClick(Sender: TObject); begin doNewRecipe end;

procedure TFormRecipes.doDeleteRecipeDetails(pRecipeID: integer);
begin
  with qdsUtils do try
    close;
    commandText := 'delete from DETTAGLIORICETTE where IDRICETTA =:IDRICETTA';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    execSql;
  finally
    close
  end
end;

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
  if recipeExists(newID) then begin
    showMessage(format(siLang1.GetTextOrDefault('IDS_3' (* 'NEW recipe %d already exists.' *) ), [newID]));   exit
  end;

  copyFromID := strToIntDef(EditCopyFromID .Text, 0);   EditCopyFromID .Text := intToStr(copyFromID);
  // verifica esistenza di copyFromID se e solo se è > 0
  if (copyFromID > 0) and (not recipeExists(copyFromID)) then begin
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
  buildNewCopyRecipe(newID, sNewName);
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

procedure TFormRecipes.buildNewCopyRecipe(pRecipeID: integer; pName: string);
begin
  buildNewEmptyRecipe(pRecipeID, pName);
  application.ProcessMessages;
  with cdsRecipes do if Locate('IDRICETTA', pRecipeID, []) then begin
    edit;
    fieldByName('ELERECIPEID'           ).AsInteger := copyFrom_ELERECIPEID           ;
    fieldByName('OXIVOLTSETPOINTX10'    ).AsInteger := copyFrom_OXIVOLTSETPOINTX10    ;
    fieldByName('OXIAMPSETPOINT'        ).AsInteger := copyFrom_OXIAMPSETPOINT        ;
    fieldByName('OXIDENSITYSETPOINTX100').AsInteger := copyFrom_OXIDENSITYSETPOINTX100;
    fieldByName('OXIMICRONSETPOINTX10'  ).AsInteger := copyFrom_OXIMICRONSETPOINTX10  ;
    fieldByName('OXISECONDSSETPOINT'    ).AsInteger := copyFrom_OXISECONDSSETPOINT    ;
    post;
    if not saveData(true) then showMessage('error copying recipe: can''t save data');
  end else showMessage('error copying recipe: can''t find recipe copy');
end;

procedure TFormRecipes.buildNewEmptyRecipe(pRecipeID: integer; pName: string);
begin
  if not saveData(false) then begin
    showMessage('error BEFORE creating new empty recipe: can''t save data');
    exit;   // si opera solo a dati salvati
  end;
  with qdsUtils do try
    close;
    commandText := 'insert into INDICERICETTE (IDRICETTA, NOME, DISPONIBILE) values (:IDRICETTA, :NOME, 1)';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    params.ParamByName('NOME')     .AsString  := copy(pName,1,15);
    execSql;
  finally
    cdsRecipes.Refresh;
    close
  end
end;

procedure TFormRecipes.cdsRecipesBeforeDelete(DataSet: TDataSet);
var iR: integer;
begin iR := DataSet.FieldByName('IDRICETTA').AsInteger;
  if messageDlg(siLang1.GetTextOrDefault('IDS_13' (* 'Delete recipe ' *) ) + intToStr(iR) + ') ' + DataSet.FieldByName('NOME').AsString + ' ?',
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then begin
    doDeleteRecipeDetails(iR);
  end else abort
end;

procedure TFormRecipes.cdsRecipesBeforeInsert(DataSet: TDataSet);
begin
  showMessage(siLang1.GetTextOrDefault('IDS_15' (* 'pleas use "NEW recipe" button to add recipes' *) )); abort
end;

procedure TFormRecipes.cdsRecipesNewRecord(DataSet: TDataSet);
begin with DataSet do begin
  (*   DA QUI NON PASSA MAI PERCHé INSERISCO VIA SQL !!!
  fieldByName('DISPONIBILE').AsInteger            := 1;   // disponibile per default
  fieldByName('OXIDENSITYSETPOINTX100').AsInteger := 140;   // 1.4 A/dm2 per default
  fieldByName('OXIMICRONSETPOINTX10').AsInteger   := 120;   // 12 micron per default
  *)
end end;

procedure TFormRecipes.cdsRecipesReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TFormRecipes.cnxRecipesBeforeConnect(Sender: TObject);
begin with Sender as TSqlConnection do begin
  params.Values['database'] := absolutizePath(puntoIni.ReadString('config', 'database',
    changeFileExt(application.ExeName, '.gdb')))
end end;

procedure TFormRecipes.dbgRecipesDblClick(Sender: TObject); begin goDetails end;
procedure TFormRecipes.dbgRecipesTitleClick(Column: TColumn);
begin
  cdsRecipes.IndexFieldNames := Column.FieldName
end;

procedure TFormRecipes.goDetails;
begin
  with FormRecipeDetails do begin
{    // andata ... eliminata 22/05/2014
    FormRecipeDetails.details_ELERECIPEID            := cdsRecipes.fieldByName('ELERECIPEID'           ).AsInteger;
    FormRecipeDetails.details_OXIVOLTSETPOINTX10     := cdsRecipes.fieldByName('OXIVOLTSETPOINTX10'    ).AsInteger;
    FormRecipeDetails.details_OXIAMPSETPOINT         := cdsRecipes.fieldByName('OXIAMPSETPOINT'        ).AsInteger;
    FormRecipeDetails.details_OXIDENSITYSETPOINTX100 := cdsRecipes.fieldByName('OXIDENSITYSETPOINTX100').AsInteger;
    FormRecipeDetails.details_OXIMICRONSETPOINTX10   := cdsRecipes.fieldByName('OXIMICRONSETPOINTX10'  ).AsInteger;
    FormRecipeDetails.details_OXISECONDSSETPOINT     := cdsRecipes.fieldByName('OXISECONDSSETPOINT'    ).AsInteger;
}
    setup(cdsRecipes.fieldByName('IDRICETTA').asInteger,
          cdsRecipes.fieldByName('NOME').asString);

    showModal;
  end;
  // updateSetpointsTargetsFromDetails;   eliminata 22/05/2014
end;

procedure TFormRecipes.updateSetpointsTargetsFromDetails;
begin
  with cdsRecipes do begin
    edit;   // ... e ritorno !
    fieldByName('ELERECIPEID'           ).AsInteger := FormRecipeDetails.details_ELERECIPEID           ;
    fieldByName('OXIVOLTSETPOINTX10'    ).AsInteger := FormRecipeDetails.details_OXIVOLTSETPOINTX10    ;
    fieldByName('OXIAMPSETPOINT'        ).AsInteger := FormRecipeDetails.details_OXIAMPSETPOINT        ;
    fieldByName('OXIDENSITYSETPOINTX100').AsInteger := FormRecipeDetails.details_OXIDENSITYSETPOINTX100;
    fieldByName('OXIMICRONSETPOINTX10'  ).AsInteger := FormRecipeDetails.details_OXIMICRONSETPOINTX10  ;
    fieldByName('OXISECONDSSETPOINT'    ).AsInteger := FormRecipeDetails.details_OXISECONDSSETPOINT    ;
    post;
    if not saveData(false) then showMessage('error updating recipe: can''t save data');
  end;
end;

procedure TFormRecipes.lblITAClick(Sender: TObject);
begin with Sender as TLabel do begin
  siLangDispatcher1.ActiveLanguage := tag;
end end;

function TFormRecipes.recipeExists(pRecipeID: integer): boolean;
begin
with qdsUtils do try
  close;
  commandText := 'select * from INDICERICETTE where IDRICETTA = ' + intToStr(pRecipeID);
  open;
  result := fieldByName('IDRICETTA').AsInteger = pRecipeID;
  if result then Begin
    copyFrom_ELERECIPEID            := fieldByName('ELERECIPEID'           ).AsInteger;
    copyFrom_OXIVOLTSETPOINTX10     := fieldByName('OXIVOLTSETPOINTX10'    ).AsInteger;
    copyFrom_OXIAMPSETPOINT         := fieldByName('OXIAMPSETPOINT'        ).AsInteger;
    copyFrom_OXIDENSITYSETPOINTX100 := fieldByName('OXIDENSITYSETPOINTX100').AsInteger;
    copyFrom_OXIMICRONSETPOINTX10   := fieldByName('OXIMICRONSETPOINTX10'  ).AsInteger;
    copyFrom_OXISECONDSSETPOINT     := fieldByName('OXISECONDSSETPOINT'    ).AsInteger;
  end;
finally
  close
end end;

procedure TFormRecipes.FormActivate(Sender: TObject);
begin   if not _booting then exit;                   // eliminare integrando in aooBootXE
  _booting := false;
  lblRel.caption := 'Rel.' + sGetBuildInfo;
  cdsRecipes.Active := true;   formRecipeDetails.openCDSs;
  lblGdb.caption := 'Gdb.' + cnxRecipes.Params.Values['database'];
  loadFormDimsNoLang(self);

  siLangDispatcher1.ActiveLanguage := puntoIni.ReadInteger('config', 'lang_num', 1);
  // 22/05/2014 GBM
  _EloxiRecipes    := puntoIni.ReadBool('config', 'eloxiRecipes'   , true);
  _EloxiSetPoint   := puntoIni.ReadBool('config', 'eloxiSetpoint'  , true);
  _DensitySetPoint := puntoIni.ReadBool('config', 'densitySetpoint', true);
  _prelDepoRins    := puntoIni.ReadBool('config', 'prelDepoRins'   , true);
  dbgRecipes.columns[5].visible := _EloxiRecipes;
  dbgRecipes.columns[6].visible := _EloxiRecipes;
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
  with cdsRecipes do begin
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
