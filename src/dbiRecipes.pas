unit dbiRecipes;

interface uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.VCLUI.Error, FireDAC.Stan.Error,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Forms, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmRecipes = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    recipesCnx: TFDConnection;
    tblRecipes: TFDTable;
    qryUtils: TFDQuery;
    tblPositions: TFDTable;
    tblTipiPrelievo: TFDTable;
    tblTipiDeposito: TFDTable;
    tblTipiRisciacquo: TFDTable;
    tblGalvRecipes: TFDTable;
    tblGalvRecipeSteps: TFDTable;
    dsGalvRecipesLink: TDataSource;
    dsRecipesLink: TDataSource;
    tblRecipeSteps: TFDTable;
    tblRecipeStepsIDRICETTA: TIntegerField;
    tblRecipeStepsID: TIntegerField;
    tblRecipeStepsDESCRIZIONE: TWideStringField;
    tblRecipeStepsPOSIZIONE: TIntegerField;
    tblRecipeStepsTBAGNO: TIntegerField;
    tblRecipeStepsPRIORITA: TIntegerField;
    tblRecipeStepsIDPRELIEVO: TIntegerField;
    tblRecipeStepsIDDEPOSITO: TIntegerField;
    tblRecipeStepsRINSINGID: TIntegerField;
    tblRecipeStepsRINSINGCOUNT: TIntegerField;
    tblRecipeStepsSPRUZZO: TIntegerField;
    tblRecipeStepsPAUSACONTROLLO: TIntegerField;
    tblRecipeStepsGALVANICID: TIntegerField;
    tblRecipeStepsRESERVECOLORCHECK: TIntegerField;
    tblRecipeStepsposName: TStringField;
    tblRecipeStepsposDSCR: TStringField;
    tblRecipeStepsgalvNome: TStringField;
    tblRecipeStepsgalvDscr: TStringField;
    fdqEleRecipeStepsTotalSecs: TFDQuery;
    fdqDeleteEleRecipeSteps: TFDQuery;
    tblGalvRecipeStepsIDELETTROCOLORE: TIntegerField;
    tblGalvRecipeStepsPRO: TIntegerField;
    tblGalvRecipeStepsDSCR: TWideStringField;
    tblGalvRecipeStepsPAUSE_SECS: TIntegerField;
    tblGalvRecipeStepsRAMP_SECS: TIntegerField;
    tblGalvRecipeStepsDWELL_SECS: TIntegerField;
    tblGalvRecipeStepsSETPOINT: TSingleField;
    tblGalvRecipeStepsUNIT_MEASURE: TIntegerField;
    tblGalvRecipeStepsELE_PHASE: TIntegerField;
    tblGalvRecipeStepsWACPOS: TIntegerField;
    tblGalvRecipeStepsWACNEG: TIntegerField;
    tblGalvRecipeStepsTANK_CHANGED: TIntegerField;
    tblGalvRecipeStepsAUXILIARY_REX: TIntegerField;
    tblGalvRecipeStepsFROM_REF_VAL: TIntegerField;
    tblCLBR: TFDTable;
    tblCLBRIDCLBR: TIntegerField;
    tblCLBRDSCR: TWideStringField;
    tblCLBRRO: TSingleField;
    tblCLBRKAPPA: TSingleField;
    tblCLBROFFSET_STIMA_MICRON: TIntegerField;
    tblRecipeStepsNO_ALIAS: TIntegerField;
    tblRecipeStepsnoAliasDscr: TStringField;
    logCnx: TFDConnection;
    fdqLastJobsOfBar: TFDQuery;
    fdqMaterialsOfJob: TFDQuery;
    dsLastJobsOfBar: TDataSource;
    fdqBarMovementsOfJob: TFDQuery;
    dsMaterialsOfJob: TDataSource;
    BarMovementsOfJob: TDataSource;
    procedure recipesCnxBeforeConnect(Sender: TObject);
    procedure tblRecipesBeforeDelete(DataSet: TDataSet);
    procedure tblTipiDepositoNewRecord(DataSet: TDataSet);
    procedure tblTipiDepositoAfterOpen(DataSet: TDataSet);
    procedure tblTipiPrelievoAfterOpen(DataSet: TDataSet);
    procedure tblTipiRisciacquoAfterOpen(DataSet: TDataSet);
    procedure tblTipiRisciacquoNewRecord(DataSet: TDataSet);
    procedure tblTipiPrelievoNewRecord(DataSet: TDataSet);
    procedure tblRecipeStepsNewRecord(DataSet: TDataSet);
    procedure tblGalvRecipesBeforeDelete(DataSet: TDataSet);
    procedure tblGalvRecipeStepsCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure tblCLBRBeforeInsert(DataSet: TDataSet);
    procedure tblCLBRBeforeDelete(DataSet: TDataSet);
    procedure tblRecipeStepsCalcFields(DataSet: TDataSet);
    procedure logCnxBeforeConnect(Sender: TObject);
  private
    _RecipeID, _lastStep: integer;
    procedure DuplicateRecords(justOne: boolean; cdsFrom, cdsTo: TFDDataSet; skipField: string; useValue: variant);
  public
    lastPickupID, lastDropID, lastRinsingID: integer;
    function stepExists(pRecipeID, pStepID: integer): boolean;
    function typeExists(pTblName: string; pTypeID: integer): boolean;
    function recipeExists(pRecipeID: integer): boolean;
    function galvRecipeExists(pRecipeID: integer): boolean;
    procedure copyStepFromTo(pRecipeID, copyFromStepID, copyToStepID: integer);
    procedure copyTypeFromTo(pTblName: string; copyFromTypeID, copyToTypeID: integer);
    procedure copyRecipeFromTo(copyFromRecipeID, copyToRecipeID: integer);
    procedure copyGalvRecipeFromTo(copyFromRecipeID, copyToRecipeID: integer);
    procedure buildNewEmptyStep(pRecipeID, pStepID: integer; pName: string);
    procedure buildNewEmptyType(pTblName: string; pTypeID: integer; pName: string);
    procedure buildNewEmptyRecipe(pRecipeID: integer; pName: string);
    procedure buildNewEmptyGalvRecipe(pRecipeID: integer; pName: string);
    procedure doDeleteRecipeDetails(pRecipeID: integer);
    procedure seekLastJobsOfBar(pBar: integer);
    procedure openRecipesAndFriends;
  end;

var
  dmRecipes: TdmRecipes;
  OXI_ID_RANGE_MIN: integer = 101;
  OXI_ID_RANGE_MAX: integer = 199;
  ELE_ID_RANGE_MIN: integer =   1;
  ELE_ID_RANGE_MAX: integer =  99;
  BRI_ID_RANGE_MIN: integer = 901;
  BRI_ID_RANGE_MAX: integer = 999;
  isDigi: boolean = True;
  isBru : boolean = False;

function isOxi(pEleRecipeID: integer): boolean;

implementation uses Dialogs, System.UITypes {mrOK},
  uEtcXE, guiRecipes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function isOxi(pEleRecipeID: integer): boolean;
begin
  result := (pEleRecipeID >= OXI_ID_RANGE_MIN) and (pEleRecipeID <= OXI_ID_RANGE_MAX)
end;

procedure TdmRecipes.buildNewEmptyGalvRecipe(pRecipeID: integer; pName: string);
begin
  with qryUtils do try
    close;
    SQL.Text := 'insert into INDICEELETTROCOLRE (IDELETTROCOLORE, NOME, INUSO) values (:IDRICETTA, :NOME, 1)';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    params.ParamByName('NOME')     .AsString  := copy(pName,1,15);
    execSql;
  finally
    tblGalvRecipes.Refresh;
    close
  end
end;

procedure TdmRecipes.buildNewEmptyRecipe(pRecipeID: integer; pName: string);
begin
  with qryUtils do try
    close;
    SQL.Text := 'insert into INDICERICETTE (IDRICETTA, NOME, DISPONIBILE) values (:IDRICETTA, :NOME, 1)';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    params.ParamByName('NOME')     .AsString  := copy(pName, 1, 15);
    execSql;
  finally
    tblRecipes.Refresh;
    close
  end
end;

procedure TdmRecipes.buildNewEmptyStep(pRecipeID, pStepID: integer; pName: string);
begin
  with qryUtils do try
    close;
    SQL.Text := 'insert into DETTAGLIORICETTE (IDRICETTA, ID, DESCRIZIONE, TBAGNO) values (:IDRICETTA, :ID, :DSCR, 0)';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    params.ParamByName('ID').AsInteger := pStepID;
    params.ParamByName('DSCR').AsString  := copy(pName, 1, 100);
    execSql;
  finally
     tblRecipeSteps.Refresh;
     close
  end
end;

procedure TdmRecipes.buildNewEmptyType(pTblName: string; pTypeID: integer; pName: string);
begin
  with qryUtils do try
    close;
    SQL.Text := 'insert into ' + pTblName + ' (ID, DSCR, TIPO) values (:ID, :DSCR, 0)';
    params.ParamByName('ID').AsInteger := pTypeID;
    params.ParamByName('DSCR').AsString  := copy(pName, 1, 64);
    execSql;
  finally
    tblTipiPrelievo.Refresh;
    tblTipiDeposito.Refresh;
    tblTipiRisciacquo.Refresh;
    close
  end
end;

procedure TdmRecipes.copyGalvRecipeFromTo(copyFromRecipeID, copyToRecipeID: integer);
begin
  with qryUtils do begin
    Close;
    SQL.Text := 'select * from INDICEELETTROCOLRE where IDELETTROCOLORE = ' + IntToStr(copyFromRecipeID);
    open
  end;
  DuplicateRecords(True, qryUtils, tblGalvRecipes, 'IDELETTROCOLORE', copyToRecipeID);
  with qryUtils do begin
    Close;
    SQL.Text := 'select * from DETTELOXI where IDELETTROCOLORE = ' + IntToStr(copyFromRecipeID);
    open
  end;
  DuplicateRecords(false, qryUtils, tblGalvRecipeSteps, 'IDELETTROCOLORE', copyToRecipeID);
  tblRecipes.Refresh;
end;

procedure TdmRecipes.copyRecipeFromTo(copyFromRecipeID, copyToRecipeID: integer);
begin
  with qryUtils do begin
    Close;
    SQL.Text := 'select * from INDICERICETTE where IDRICETTA = ' + IntToStr(copyFromRecipeID);
    open
  end;
  DuplicateRecords(True, qryUtils, tblRecipes, 'IDRICETTA', copyToRecipeID);
  with qryUtils do begin
    Close;
    SQL.Text := 'select * from DETTAGLIORICETTE where IDRICETTA = ' + IntToStr(copyFromRecipeID);
    open
  end;
  DuplicateRecords(false, qryUtils, tblRecipeSteps, 'IDRICETTA', copyToRecipeID);
  tblRecipes.Refresh;
  qryUtils.Close;
end;

procedure TdmRecipes.copyStepFromTo(pRecipeID, copyFromStepID, copyToStepID: integer);
begin
  with qryUtils do begin
    Close;
    SQL.Text := Format('select * from DETTAGLIORICETTE where IDRICETTA = %d and ID = %d', [pRecipeID, copyFromStepID]);
    open
  end;
  DuplicateRecords(True, qryUtils, tblRecipeSteps, 'ID', copyToStepID);
  qryUtils.Close;
end;

procedure TdmRecipes.copyTypeFromTo(pTblName: string; copyFromTypeID, copyToTypeID: integer);
var ttt: TFDDataSet;
begin
  if CompareText('TIPIPREL_07', pTblName) = 0 then begin
    ttt := tblTipiPrelievo;
  end else if CompareText('TIPIDEPO_07', pTblName) = 0 then begin
    ttt := tblTipiDeposito;
  end else ttt := tblTipiRisciacquo;

  with qryUtils do begin
    Close;
    SQL.Text := 'select * from ' + pTblName + ' where ID = ' + IntToStr(copyFromTypeID);
    open
  end;
  DuplicateRecords(True, qryUtils, ttt, 'ID', copyToTypeID);
  qryUtils.Close;
  ttt.Refresh
end;

procedure TdmRecipes.DataModuleCreate(Sender: TObject);
begin with puntoIni do begin
  OXI_ID_RANGE_MIN := readInteger('config', 'OXI_ID_RANGE_MIN', OXI_ID_RANGE_MIN);
  OXI_ID_RANGE_MAX := readInteger('config', 'OXI_ID_RANGE_MAX', OXI_ID_RANGE_MAX);
  ELE_ID_RANGE_MIN := readInteger('config', 'ELE_ID_RANGE_MIN', ELE_ID_RANGE_MIN);
  ELE_ID_RANGE_MAX := readInteger('config', 'ELE_ID_RANGE_MAX', ELE_ID_RANGE_MAX);
  BRI_ID_RANGE_MIN := readInteger('config', 'BRI_ID_RANGE_MIN', BRI_ID_RANGE_MIN);
  BRI_ID_RANGE_MAX := readInteger('config', 'BRI_ID_RANGE_MAX', BRI_ID_RANGE_MAX);
  isDigi := readBool('config', 'isDigi', isDigi);
  isBru  := readBool('config', 'isBru' , isBru );
end end;

procedure TdmRecipes.doDeleteRecipeDetails(pRecipeID: integer);
begin
  with qryUtils do try
    close;
    SQL.Text := 'delete from DETTAGLIORICETTE where IDRICETTA =:IDRICETTA';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    execSql;
  finally
    close
  end
end;

function TdmRecipes.recipeExists(pRecipeID: integer): boolean;
begin
  with qryUtils do try
    close;
    SQL.Text := 'select * from INDICERICETTE where IDRICETTA = ' + intToStr(pRecipeID);
    open;
    result := fieldByName('IDRICETTA').AsInteger = pRecipeID;
  finally
    close
  end;
end;

function TdmRecipes.galvRecipeExists(pRecipeID: integer): boolean;
begin
  with qryUtils do try
    close;
    SQL.Text := 'select * from INDICEELETTROCOLRE where IDELETTROCOLORE = ' + intToStr(pRecipeID);
    open;
    result := fieldByName('IDELETTROCOLORE').AsInteger = pRecipeID;
  finally
    close
  end;
end;

procedure TdmRecipes.logCnxBeforeConnect(Sender: TObject);
begin with Sender as TFDConnection do begin
  params.Values['database'] := absolutizePath(puntoIni.ReadString('config', 'LOG_database',
    changeFileExt(application.ExeName, '.gdb')))
end end;

procedure TdmRecipes.openRecipesAndFriends;
begin
  tblPositions      .Active := true;
  tblCLBR           .Active := true;
  tblRecipes        .Active := true;
  tblRecipeSteps    .Active := true;
  tblTipiPrelievo   .Active := true;
  tblTipiDeposito   .Active := true;
  tblTipiRisciacquo .Active := true;
  tblGalvRecipes    .Active := true;
  tblGalvRecipeSteps.Active := true;
end;

procedure TdmRecipes.recipesCnxBeforeConnect(Sender: TObject);
begin with Sender as TFDConnection do begin
  params.Values['database'] := absolutizePath(puntoIni.ReadString('config', 'database',
    changeFileExt(application.ExeName, '.gdb')))
end end;

function TdmRecipes.stepExists(pRecipeID, pStepID: integer): boolean;
begin
  with qryUtils do try
    close;
    SQL.Text := Format('select * from DETTAGLIORICETTE where IDRICETTA = %d and ID = %d', [pRecipeID, pStepID]);
    open;
    result := (fieldByName('IDRICETTA').AsInteger = pRecipeID) and (fieldByName('ID').AsInteger = pStepID);
  finally
    close
  end;
end;

procedure TdmRecipes.tblCLBRBeforeDelete(DataSet: TDataSet);
begin
  abort
end;

procedure TdmRecipes.tblCLBRBeforeInsert(DataSet: TDataSet);
begin
  abort
end;

procedure TdmRecipes.tblGalvRecipesBeforeDelete(DataSet: TDataSet);
begin with fdqDeleteEleRecipeSteps do begin
  params.ParamValues['IDELETTROCOLORE'] := DataSet.FieldByName('IDELETTROCOLORE').AsInteger;
  execSQL;
end end;

procedure TdmRecipes.tblGalvRecipeStepsCalcFields(DataSet: TDataSet);
var s: string;     myUnitMeasure, myElePhase: integer;

  function buildCtrlFlags(pEleRecipeID, pUnitMeasure, pElePhase, pAusiliaryRex: integer): integer;
  {     OXI          ELE
  ----------------------------
    0   Volt         DC Phase
    1   Ampere       AC Phase
    2   Ampere/dm²
  }
  begin
    if isOxi(pEleRecipeID) then begin
      result := 8;   // positive polarity
      if pUnitMeasure in [1, 2] then result := result + 4;
    end else begin
      if pElePhase = 0 then result := 4 * 8 else result := 3 * 8;
      if pAusiliaryRex <> 0 then result := result + 256;
    end;
  end;

begin with Dataset do begin
  myUnitMeasure := fieldByName('UNIT_MEASURE').AsInteger;
  case myUnitMeasure of
    0: s := 'Volt';
    1: s := 'KAmpere';
    2: s := 'Ampere/dm²';
    else s := '???';
  end;
  fieldByName('umDscr').AsString := s;
  myElePhase    := fieldByName('ELE_PHASE'   ).AsInteger;
  case myElePhase of
    0: s := 'DC Phase';
    1: s := 'AC Phase';
    else s := '???';
  end;
  fieldByName('ePhDscr').AsString := s;
  fieldByName('calcCtrlFlags').AsInteger :=  buildCtrlFlags(fieldByName('IDELETTROCOLORE').AsInteger,
    myUnitMeasure, myElePhase, fieldByName('AUXILIARY_REX').AsInteger );
end end;

procedure TdmRecipes.tblRecipesBeforeDelete(DataSet: TDataSet);
var iR: integer;
begin iR := DataSet.FieldByName('IDRICETTA').AsInteger;
  if messageDlg(FormRecipes.siLang1.GetTextOrDefault('IDS_13' (* 'Delete recipe ' *) ) + intToStr(iR) + ') ' + DataSet.FieldByName('NOME').AsString + ' ?',
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then begin
    dmRecipes.doDeleteRecipeDetails(iR);
  end else abort
end;

procedure TdmRecipes.tblRecipeStepsCalcFields(DataSet: TDataSet);
var sName, sDSCR, sNoAlias: string;
begin
  with DataSet do begin
    if tblPositions.Locate('ID', fieldByName('POSIZIONE').AsInteger) then begin
      sName := tblPositions.FieldByName('NAME').AsString;
      sDSCR := tblPositions.FieldByName('DSCR').AsString;
    end else begin
      sName := 'ERROR';  sDSCR := sName;
    end;
    if fieldByName('NO_ALIAS').AsInteger = 1 then begin
      sNoAlias := ' !';
    end else sNoAlias := '';;
    fieldByName('posName').AsString := sName + sNoAlias;
    fieldByName('posDSCR').AsString := sDSCR + sNoAlias;
  end
end;

procedure TdmRecipes.tblRecipeStepsNewRecord(DataSet: TDataSet);
var tblClone: TFDTable;
begin
  tblClone := TFDTable.Create(self);
  try
    tblClone.CloneCursor(DataSet as TFDTable);
    tblClone.Last;
    DataSet.fieldByName('ID').AsInteger := 10 + tblClone.fieldByName('ID').AsInteger;
  finally
    tblClone.Free
  end;
end;

procedure TdmRecipes.tblTipiDepositoAfterOpen(DataSet: TDataSet);
begin with Dataset do begin
  last;   lastDropID := fieldByName('ID').AsInteger;
end end;

procedure TdmRecipes.tblTipiPrelievoAfterOpen(DataSet: TDataSet);
begin with DataSet do begin
  last;   lastPickupID := fieldByName('ID').AsInteger;
end end;

procedure TdmRecipes.tblTipiPrelievoNewRecord(DataSet: TDataSet);
begin   inc(lastPickupID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastPickupID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_Q4').AsInteger := -1;   // true by default
    FieldByName('VEL_Q5').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

procedure TdmRecipes.tblTipiRisciacquoAfterOpen(DataSet: TDataSet);
begin with DataSet do begin
  last;   lastRinsingID := fieldByName('ID').AsInteger;
end end;

procedure TdmRecipes.tblTipiRisciacquoNewRecord(DataSet: TDataSet);
begin   inc(lastRinsingID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastRinsingID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

function TdmRecipes.typeExists(pTblName: string; pTypeID: integer): boolean;
begin
  with qryUtils do try
    close;
    SQL.Text := 'select * from ' + pTblName + ' where ID = ' + intToStr(pTypeID);
    open;
    result := fieldByName('ID').AsInteger = pTypeID;
  finally
    close
  end;
end;

procedure TdmRecipes.tblTipiDepositoNewRecord(DataSet: TDataSet);
begin inc(lastDropID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastDropID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_Q4').AsInteger := -1;   // true by default
    FieldByName('VEL_Q5').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

procedure TdmRecipes.DuplicateRecords(justOne: boolean; cdsFrom, cdsTo: TFDDataSet; skipField: string; useValue: variant);
var i: integer; fldFrom, fldTo: TField;
begin
  repeat
    cdsTo.edit;
    cdsTo.insert;
    for i := 0 to cdsTo.fieldDefs.count - 1 do begin
      if compareText(cdsTo.fieldDefs[i].name, skipField) = 0 then begin
        cdsTo.fields[i].value := useValue;
      end else if cdsTo.fieldDefs[i].Name = cdsFrom.fieldDefs[i].Name then begin
        cdsTo.fields[i].Assign(cdsFrom.fields[i]);
      end else raise exception.Create(format('Field not found: %s', [cdsTo.fieldDefs[i].name]));
    end;
    cdsTo.post;
    cdsFrom.next;
  until justOne or cdsFrom.EOF;
end;

procedure TdmRecipes.seekLastJobsOfBar(pBar: integer);
begin
  with fdqLastJobsOfBar do begin
    close;
    params.paramValues['IDBARRA'] := pBar;
    open;
  end;
  fdqMaterialsOfJob.Open;
  fdqBarMovementsOfJob.Open;
end;

end.
