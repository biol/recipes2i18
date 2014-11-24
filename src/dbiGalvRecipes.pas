unit dbiGalvRecipes;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FBDef;

type
  TdmGalvRecipes = class(TDataModule)
    fdqEleRecipes: TFDQuery;
    dsEleRecipeLink: TDataSource;
    fdqEleRecipeSteps: TFDQuery;
    fdqEleRecipeStepsumDscr: TStringField;
    fdqEleRecipeStepsePhDscr: TStringField;
    fdqEleRecipeStepscalcCtrlFlags: TIntegerField;
    fdqDeleteEleRecipeSteps: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    SingleField1: TSingleField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    IntegerField12: TIntegerField;
    fdqUtils: TFDQuery;
    fdqInsertEleRecipeSteps: TFDQuery;
    fdqInsertEleRecipes: TFDQuery;
    fdqEleRecipeStepsTotalSecs: TFDQuery;
    fdqEleRecipestotalSecs: TIntegerField;
    fdqEleRecipesIDELETTROCOLORE: TIntegerField;
    fdqEleRecipesNOME: TWideStringField;
    fdqEleRecipesCLIENTE: TWideStringField;
    fdqEleRecipesDESCRIZIONE: TWideStringField;
    fdqEleRecipesCATEGORIA: TIntegerField;
    fdqEleRecipesINUSO: TIntegerField;
    fdqEleRecipesDISPONIBILE: TIntegerField;
    fdqEleRecipesPREDEFINITO: TIntegerField;
    fdqEleRecipesMICRON: TIntegerField;
    fdqEleRecipesIDCLBR: TIntegerField;
    fdqEleRecipesCONTINUE_PERCENTAGE: TIntegerField;
    fdqEleRecipesRETREATMENT_PERCENTAGE: TIntegerField;
    fdqEleRecipeStepsIDELETTROCOLORE: TIntegerField;
    fdqEleRecipeStepsPRO: TIntegerField;
    fdqEleRecipeStepsDSCR: TWideStringField;
    fdqEleRecipeStepsPAUSE_SECS: TIntegerField;
    fdqEleRecipeStepsRAMP_SECS: TIntegerField;
    fdqEleRecipeStepsDWELL_SECS: TIntegerField;
    fdqEleRecipeStepsSETPOINT: TSingleField;
    fdqEleRecipeStepsUNIT_MEASURE: TIntegerField;
    fdqEleRecipeStepsELE_PHASE: TIntegerField;
    fdqEleRecipeStepsWACPOS: TIntegerField;
    fdqEleRecipeStepsWACNEG: TIntegerField;
    fdqEleRecipeStepsTANK_CHANGED: TIntegerField;
    fdqEleRecipeStepsAUXILIARY_REX: TIntegerField;
    procedure fdqEleRecipeStepsCalcFields(DataSet: TDataSet);
    procedure fdqEleRecipesAfterOpen(DataSet: TDataSet);
    procedure fdqEleRecipesBeforeDelete(DataSet: TDataSet);
    procedure fdqEleRecipesAfterDelete(DataSet: TDataSet);
    procedure fdqEleRecipesNewRecord(DataSet: TDataSet);
    procedure fdqEleRecipeStepsNewRecord(DataSet: TDataSet);
    procedure fdqEleRecipesBeforePost(DataSet: TDataSet);
    procedure fdqEleRecipeStepsBeforePost(DataSet: TDataSet);
    procedure fdqEleRecipesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure saveData;
    procedure eleRecipeDuplicate(iRecipe: integer);
    procedure eleRecipeRenum    (iRecipe: integer);
    function  eleRecipeDupRenBase(iRecipe, iOld: integer; sMsg: string): boolean;
  end;

var
  dmGalvRecipes: TdmGalvRecipes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dialogs, Vcl.Controls, dbiRecipes;

{$R *.dfm}

var
  _isOxi: boolean = false;
  _lastID: integer = 0;
  _deleID: integer = 0;

function buildCtrlFlags(pUnitMeasure, pElePhase, pAusiliaryRex: integer): integer;
{     OXI          ELE
----------------------------
  0   Volt         DC Phase
  1   Ampere       AC Phase
  2   Ampere/dm²
}
begin
  if _isOxi then begin
    result := 8;   // positive polarity
    if pUnitMeasure in [1, 2] then result := result + 4;
  end else begin
    if pElePhase = 0 then result := 4 * 8 else result := 3 * 8;
    if pAusiliaryRex <> 0 then result := result + 256;
  end;
end;

procedure TdmGalvRecipes.fdqEleRecipesAfterDelete(DataSet: TDataSet);
begin with fdqDeleteEleRecipeSteps do begin
  params.ParamValues['IDELETTROCOLORE'] := _deleID;
  execSQL;
end end;

procedure TdmGalvRecipes.fdqEleRecipesAfterOpen(DataSet: TDataSet);
begin with DataSet do begin
  last;
  _lastID := fieldByName('IDELETTROCOLORE').asInteger;
end end;

procedure TdmGalvRecipes.fdqEleRecipesBeforeDelete(DataSet: TDataSet);
begin with DataSet do begin
  _deleID := fieldByName('IDELETTROCOLORE').asInteger;
end end;

procedure chkFldRng(var sErr: string; sFldDscr: string; iMin, iMax: integer; fld: TField);
begin
  if fld.AsInteger < iMin then begin
    sErr := sErr + sFldDscr + ' deve essere almeno ' + intToStr(iMin) + #$A;
    fld.AsInteger := iMin;
  end else if fld.AsInteger > iMax then begin
    sErr := sErr + sFldDscr + ' non può superare ' + intToStr(iMax) + #$A;
    fld.AsInteger := iMax;
  end;
end;

procedure chkFldRngFloat(var sErr: string; sFldDscr: string; iMin, iMax: real; fld: TField);
begin
  if fld.AsFloat < iMin then begin
    sErr := sErr + sFldDscr + ' deve essere almeno ' + floatToStr(iMin) + #$A;
    fld.AsFloat := iMin;
  end else if fld.AsFloat > iMax then begin
    sErr := sErr + sFldDscr + ' non può superare ' + floatToStr(iMax) + #$A;
    fld.AsFloat := iMax;
  end;
end;

procedure TdmGalvRecipes.fdqEleRecipesBeforePost(DataSet: TDataSet);
var s: string;
begin with Dataset do begin
  s := '';
  chkFldRng(s, 'µ', 0,  99, FieldByName('MICRON'));
  chkFldRng(s, 'Cont.%', 0, 100, FieldByName('CONTINUE_PERCENTAGE'));
  if s <> '' then showMessage(s);
end end;

procedure TdmGalvRecipes.fdqEleRecipesCalcFields(DataSet: TDataSet);
begin try
    fdqEleRecipeStepsTotalSecs.params.ParamValues['ID'] :=
      Dataset.fieldByName('IDELETTROCOLORE').AsInteger;
    fdqEleRecipeStepsTotalSecs.open;
    Dataset.fieldByName('totalSecs').AsInteger :=
      fdqEleRecipeStepsTotalSecs.fieldByName('TOTALE').AsInteger;
finally
  fdqEleRecipeStepsTotalSecs.close;
end end;

procedure TdmGalvRecipes.fdqEleRecipesNewRecord(DataSet: TDataSet);
begin with DataSet do begin
  inc(_lastID);
  fieldByName('IDELETTROCOLORE').asInteger := _lastID;
end end;

procedure TdmGalvRecipes.fdqEleRecipeStepsBeforePost(DataSet: TDataSet);
var s: string;
begin with Dataset do begin
  s := '';
  chkFldRng(s, 'secondi di PAUSA', 0, 100, FieldByName('PAUSE_SECS'));
  chkFldRng(s, 'secondi di RAMPA', 0, 100, FieldByName('RAMP_SECS'));
  chkFldRng(s, 'fase', 0, 1, FieldByName('ELE_PHASE'));  // ELE ONLY, no OXI
  if FieldByName('ELE_PHASE').AsInteger = 0 then begin   // fase DC
    chkFldRng(s, 'secondi di STASI', 10, 1000, FieldByName('DWELL_SECS'));
    chkFldRng(s, 'wAC+', 0, 0, FieldByName('WACPOS'));
    chkFldRng(s, 'wAC-', 0, 0, FieldByName('WACNEG'));
  end else begin   // fase AC
    chkFldRng(s, 'secondi di STASI', 30, 1000, FieldByName('DWELL_SECS'));
    chkFldRng(s, 'wAC+', 20, 50, FieldByName('WACPOS'));
    chkFldRng(s, 'wAC-', 20, 50, FieldByName('WACNEG'));
  end;
  chkFldRng(s, 'unità di misura', 0, 0, FieldByName('UNIT_MEASURE'));  // ELE ONLY, no OXI
  chkFldRngFloat(s, 'setpoint', 1, 25, FieldByName('SETPOINT'));  // ELE ONLY, no OXI
  if s <> '' then showMessage(s);
end end;

procedure TdmGalvRecipes.fdqEleRecipeStepsCalcFields(DataSet: TDataSet);
var s: string;     myUnitMeasure, myElePhase: integer;
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
  fieldByName('calcCtrlFlags').AsInteger :=  buildCtrlFlags(
    myUnitMeasure, myElePhase, fieldByName('AUXILIARY_REX').AsInteger );
end end;

procedure TdmGalvRecipes.fdqEleRecipeStepsNewRecord(DataSet: TDataSet);
begin with dataset do begin
  fieldByName('PAUSE_SECS'   ).AsInteger := 0;
  fieldByName('TANK_CHANGED' ).AsInteger := 0;
  fieldByName('AUXILIARY_REX').AsInteger := 0;
end end;

procedure TdmGalvRecipes.eleRecipeDuplicate(iRecipe: integer);
var iOld: integer;
begin
  saveData;
  iOld := fdqEleRecipes.FieldByName('IDELETTROCOLORE').asInteger;
  if eleRecipeDupRenBase(iRecipe, iOld, 'Duplicare') then with fdqUtils do try
    with fdqInsertEleRecipes do begin
      params.ParamValues['IDELETTROCOLORE'] := iRecipe;
      params.ParamValues['NOME'       ] := fdqEleRecipes.FieldByName('NOME'       ).AsString;
      params.ParamValues['CLIENTE'    ] := fdqEleRecipes.FieldByName('CLIENTE'    ).AsString;
      params.ParamValues['DESCRIZIONE'] := fdqEleRecipes.FieldByName('DESCRIZIONE').AsString;
      params.ParamValues['CATEGORIA'  ] := fdqEleRecipes.FieldByName('CATEGORIA'  ).AsInteger;
      params.ParamValues['INUSO'      ] := fdqEleRecipes.FieldByName('INUSO'      ).AsInteger;
      params.ParamValues['DISPONIBILE'] := fdqEleRecipes.FieldByName('DISPONIBILE').AsInteger;
      params.ParamValues['PREDEFINITO'] := fdqEleRecipes.FieldByName('PREDEFINITO').AsInteger;
      params.ParamValues['MICRON'     ] := fdqEleRecipes.FieldByName('MICRON'     ).AsInteger; // ÷ 0÷99
      params.ParamValues['IDCLBR'     ] := fdqEleRecipes.FieldByName('IDCLBR'     ).AsInteger;
      params.ParamValues['CONTINUE_PERCENTAGE'] := fdqEleRecipes.FieldByName('CONTINUE_PERCENTAGE').AsInteger; // 0÷100
      execSQL;
    end;
    with fdqEleRecipeSteps do begin
      first;
      while not EoF do begin
        fdqInsertEleRecipeSteps.params.ParamValues['IDELETTROCOLORE'] := iRecipe;
        fdqInsertEleRecipeSteps.params.ParamValues['PRO'            ] := FieldByName('PRO').AsInteger;
        fdqInsertEleRecipeSteps.params.ParamValues['DSCR'           ] := FieldByName('DSCR').AsString;
        fdqInsertEleRecipeSteps.params.ParamValues['PAUSE_SECS'     ] := FieldByName('PAUSE_SECS').AsInteger;   // 0÷100
        fdqInsertEleRecipeSteps.params.ParamValues['RAMP_SECS'      ] := FieldByName('RAMP_SECS').AsInteger;    // 0÷100
        fdqInsertEleRecipeSteps.params.ParamValues['DWELL_SECS'     ] := FieldByName('DWELL_SECS').AsInteger;   // DC: 10÷1000 - AC: 30÷1000
        fdqInsertEleRecipeSteps.params.ParamValues['SETPOINT'       ] := FieldByName('SETPOINT').AsFloat;     // 1÷25   // toDo: passare a float per modifica ossido
        fdqInsertEleRecipeSteps.params.ParamValues['UNIT_MEASURE'   ] := FieldByName('UNIT_MEASURE').AsInteger;
        fdqInsertEleRecipeSteps.params.ParamValues['ELE_PHASE'      ] := FieldByName('ELE_PHASE').AsInteger;
        fdqInsertEleRecipeSteps.params.ParamValues['WACPOS'         ] := FieldByName('WACPOS').AsInteger;       // DC:0 - AC: 20÷50
        fdqInsertEleRecipeSteps.params.ParamValues['WACNEG'         ] := FieldByName('WACNEG').AsInteger;       // DC:0 - AC: 20÷50
        fdqInsertEleRecipeSteps.params.ParamValues['TANK_CHANGED'   ] := FieldByName('TANK_CHANGED').AsInteger;
        fdqInsertEleRecipeSteps.params.ParamValues['AUXILIARY_REX'  ] := FieldByName('AUXILIARY_REX').AsInteger;
        fdqInsertEleRecipeSteps.execSQL;
        next;
      end;
    end;
  finally
    fdqEleRecipes.Refresh;
  end
end;

procedure TdmGalvRecipes.eleRecipeRenum(iRecipe: integer);
var iOld: integer;
begin
  saveData;
  iOld := fdqEleRecipes.FieldByName('IDELETTROCOLORE').asInteger;
  if eleRecipeDupRenBase(iRecipe, iOld, 'Rinumerare') then with fdqUtils do try
    close;
    SQL.Text := format('update INDICEELETTROCOLRE  set IDELETTROCOLORE = %d where IDELETTROCOLORE = %d', [iRecipe, iOld]);
    execSQL;
    close;
    SQL.Text := format('update DETTELOXI  set IDELETTROCOLORE = %d where IDELETTROCOLORE = %d', [iRecipe, iOld]);
    execSQL;
  finally
    close;
    fdqEleRecipes.Refresh;
  end
end;

function TdmGalvRecipes.eleRecipeDupRenBase(iRecipe, iOld: integer; sMsg: string): boolean;
begin result := false;
  with fdqUtils do try
    close;
    SQL.Text := 'select * from INDICEELETTROCOLRE where IDELETTROCOLORE = ' + intToStr(iRecipe);
    open;
    if FieldByName('IDELETTROCOLORE').asInteger = iRecipe then begin
      showMessage(format('La ricetta %d esiste già! Specificare un altro ID', [iRecipe])); exit;
    end;
    close;
    if MessageDlg(format('%s da %d a %d ?', [sMsg, iOld, iRecipe]), mtConfirmation, [mbOk, mbCancel], 0) <> mrOK then exit;
    result := true;
    SQL.Text := 'select * from DETTELOXI  where IDELETTROCOLORE = ' + intToStr(iRecipe);
    open;
    if FieldByName('IDELETTROCOLORE').asInteger = iRecipe then begin
      close;
      SQL.Text := 'delete from DETTELOXI  where IDELETTROCOLORE = ' + intToStr(iRecipe);
      execSQL;
    end;
  finally
    close;
  end
end;

procedure TdmGalvRecipes.saveData;
begin
  if fdqEleRecipes    .State in [dsEdit, dsInsert] then fdqEleRecipes    .Post;
  if fdqEleRecipeSteps.State in [dsEdit, dsInsert] then fdqEleRecipeSteps.Post;
end;

end.
