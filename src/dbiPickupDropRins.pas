unit dbiPickupDropRins;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Data.DB,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmPickupDropRins = class(TDataModule)
    fdtPickupTypes: TFDTable;
    fdqRecipesUtil: TFDQuery;
    fdtDropTypes: TFDTable;
    fdtRinsingTypes: TFDTable;
    procedure fdcRecipesBeforeConnect(Sender: TObject);
    procedure fdtPickupTypesBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure fdtDropTypesBeforePost(DataSet: TDataSet);
    procedure fdtRinsingTypesBeforePost(DataSet: TDataSet);
    procedure fdtPickupTypesAfterOpen(DataSet: TDataSet);
    procedure fdtDropTypesAfterOpen(DataSet: TDataSet);
    procedure fdtRinsingTypesAfterOpen(DataSet: TDataSet);
    procedure fdtPickupTypesNewRecord(DataSet: TDataSet);
    procedure fdtDropTypesNewRecord(DataSet: TDataSet);
    procedure fdtRinsingTypesNewRecord(DataSet: TDataSet);
  private
    lastPickupID, lastDropID, lastRinsingID: integer;
    procedure duplicateSomethingType(pTblName: string; pTbl: TFDDataSet; pOldID, pNewID: integer);
  public
    procedure openTypes;
    function DuplicateRecords(justOne: boolean; cdsFrom, cdsTo: TFDDataSet; skipField: string; useValue: variant): integer;
    procedure duplicatePickupType(pOldID, pNewID: integer);
    procedure duplicateDropType(pOldID, pNewID: integer);
    procedure duplicateRinsingType(pOldID, pNewID: integer);
  end;

var
  dmPickupDropRins: TdmPickupDropRins;
  k_maximumInclination_mm: integer = 1000;   // 1m
  k_topLevel_mm: integer = 5000;   // 5m
  k_RinsingDownLevel: integer = 500;   // 50cm
  k_mmXsecs_slow: integer =  70;   // con inverter andiamo circa a 294mm/sec. in veloce e circa 70mm/sec. in lenta
  k_mmXsecs_fast: integer = 294;   // senza inverter: 41,6mm/sec. in lenta e 267mm/sec. in veloce



implementation uses forms, math, dialogs, uEtcXE, dbiRecipes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmPickupDropRins.DataModuleCreate(Sender: TObject);
begin
  k_maximumInclination_mm := puntoIni.readInteger('config', 'maximumInclination_mm', k_maximumInclination_mm);
  k_topLevel_mm           := puntoIni.readInteger('config', 'topLevel_mm', k_topLevel_mm);
  k_RinsingDownLevel      := puntoIni.readInteger('config', 'RinsingDownLevel', k_RinsingDownLevel);
  k_mmXsecs_slow := puntoIni.readInteger('config', 'mmXsecs_slow', k_mmXsecs_slow);
  k_mmXsecs_fast := puntoIni.readInteger('config', 'mmXsecs_fast', k_mmXsecs_fast);
end;

procedure TdmPickupDropRins.fdcRecipesBeforeConnect(Sender: TObject);
begin with Sender as TFDConnection do
  begin
    params.Values['database' ] := puntoIni.ReadString('gdb', 'recipes'          , params.Values['database']);
    params.Values['user_name'] := puntoIni.ReadString('gdb', 'recipes_user_name', params.Values['user_name']);
    params.Values['password' ] := puntoIni.ReadString('gdb', 'recipes_password' , params.Values['password']);
  end;
end;

function blip_maxIncl(dm, op_MM: integer): boolean;
begin
  result := abs(dm - op_MM) > k_maximumInclination_mm
end;

function blip_maxLevel(dm, dm_top: integer): boolean;
begin
  result := dm > dm_top
end;

function blip_totSecs(dm, op_MM, isFast: integer): real;
begin
  result := max(dm, op_MM);
  if isFast <> 0 then result := result / k_mmXsecs_fast else result := result / k_mmXsecs_slow
end;

procedure TdmPickupDropRins.fdtDropTypesAfterOpen(DataSet: TDataSet);
begin with Dataset do begin
  last;   lastDropID := fieldByName('ID').AsInteger;
end end;

procedure TdmPickupDropRins.fdtDropTypesBeforePost(DataSet: TDataSet);
var s: string;
begin
  s := '';
  // checking maximum inclination
  if blip_maxIncl(dataSet.FieldByName('QUOTE_1_MM').asInteger, dataSet.FieldByName('QUOTE_1_OP_MM').asInteger) then
    s := s + 'level 1 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_2_OP_MM').asInteger) then
    s := s + 'level 2 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_3_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 3 inclination exceeded' + #13;

  // checking against top level / sequence
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 1 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_OP_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 1 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_1_MM').asInteger) then
    s := s + 'level 2 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_OP_MM').asInteger, dataSet.FieldByName('QUOTE_1_OP_MM').asInteger) then
    s := s + 'level 2 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_MM').asInteger, dataSet.FieldByName('QUOTE_2_MM').asInteger) then
    s := s + 'level 3 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_OP_MM').asInteger, dataSet.FieldByName('QUOTE_2_OP_MM').asInteger) then
    s := s + 'level 3 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_4_MM').asInteger, dataSet.FieldByName('QUOTE_3_MM').asInteger) then
    s := s + 'level "out of tank" too high' + #13;

  if blip_maxLevel(0, dataSet.FieldByName('QUOTE_4_MM').asInteger) then
    s := s + 'level "out of tank" too low' + #13;

  if s <> '' then begin
    showMessage(s);    abort
  end;

  // calculating total time
  dataSet.FieldByName('TOTAL_SECS').AsInteger := trunc(
    dataSet.FieldByName('PAUSE_1_SECS').asInteger +
    dataSet.FieldByName('PAUSE_2_SECS').asInteger +
    dataSet.FieldByName('PAUSE_3_SECS').asInteger +
    dataSet.FieldByName('PAUSE_4_SECS').asInteger +
    blip_totSecs(k_topLevel_mm - dataSet.FieldByName('QUOTE_1_MM').asInteger, 0,
                 dataSet.FieldByName('SPEED_1_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_1_MM').asInteger    - dataSet.FieldByName('QUOTE_2_MM').asInteger,
                 dataSet.FieldByName('QUOTE_1_OP_MM').asInteger    - dataSet.FieldByName('QUOTE_2_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_2_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_2_MM').asInteger    - dataSet.FieldByName('QUOTE_3_MM').asInteger,
                 dataSet.FieldByName('QUOTE_2_OP_MM').asInteger - dataSet.FieldByName('QUOTE_3_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_3_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_3_MM').asInteger    - dataSet.FieldByName('QUOTE_4_MM').asInteger,
                 dataSet.FieldByName('QUOTE_3_OP_MM').asInteger - dataSet.FieldByName('QUOTE_4_MM').asInteger,
                 dataSet.FieldByName('SPEED_4_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_4_MM').asInteger, 0,
                 dataSet.FieldByName('SPEED_5_FAST').asInteger)
  );

end;

procedure TdmPickupDropRins.fdtDropTypesNewRecord(DataSet: TDataSet);
begin   inc(lastDropID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastDropID;
    FieldByName('SPEED_1_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_2_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_3_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_4_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_5_FAST').AsInteger := 1;   // true by default
  end;
end;

procedure TdmPickupDropRins.fdtPickupTypesAfterOpen(DataSet: TDataSet);
begin with Dataset do begin
  last;   lastPickupID := fieldByName('ID').AsInteger;
end end;

procedure TdmPickupDropRins.fdtPickupTypesBeforePost(DataSet: TDataSet);
var s: string;
begin
  s := '';
  // checking maximum inclination
  if blip_maxIncl(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_2_OP_MM').asInteger) then
    s := s + 'level 1 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_3_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 2 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_4_MM').asInteger, dataSet.FieldByName('QUOTE_4_OP_MM').asInteger) then
    s := s + 'level 3 inclination exceeded' + #13;

  // checking against top level / sequence
  if blip_maxLevel(dataSet.FieldByName('QUOTE_4_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 3 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_4_OP_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 3 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_MM').asInteger, dataSet.FieldByName('QUOTE_4_MM').asInteger) then
    s := s + 'level 2 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_OP_MM').asInteger, dataSet.FieldByName('QUOTE_4_OP_MM').asInteger) then
    s := s + 'level 2 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_3_MM').asInteger) then
    s := s + 'level 1 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_OP_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 1 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_MM').asInteger, dataSet.FieldByName('QUOTE_2_MM').asInteger) then
    s := s + 'level "out of tank" too high' + #13;

  if blip_maxLevel(0, dataSet.FieldByName('QUOTE_1_MM').asInteger) then
    s := s + 'level "out of tank" too low' + #13;

  if s <> '' then begin
    showMessage(s);    abort
  end;

  // calculating total time
  dataSet.FieldByName('TOTAL_SECS').AsInteger := trunc(
    dataSet.FieldByName('PAUSE_1_SECS').asInteger +
    dataSet.FieldByName('PAUSE_2_SECS').asInteger +
    dataSet.FieldByName('PAUSE_3_SECS').asInteger +
    dataSet.FieldByName('PAUSE_4_SECS').asInteger +
    blip_totSecs(dataSet.FieldByName('QUOTE_1_MM').asInteger, 0, dataSet.FieldByName('SPEED_1_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_2_MM').asInteger    - dataSet.FieldByName('QUOTE_1_MM').asInteger,
                 dataSet.FieldByName('QUOTE_2_OP_MM').asInteger - dataSet.FieldByName('QUOTE_1_MM').asInteger,
                 dataSet.FieldByName('SPEED_2_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_3_MM').asInteger    - dataSet.FieldByName('QUOTE_2_MM').asInteger,
                 dataSet.FieldByName('QUOTE_3_OP_MM').asInteger - dataSet.FieldByName('QUOTE_2_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_3_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_4_MM').asInteger    - dataSet.FieldByName('QUOTE_3_MM').asInteger,
                 dataSet.FieldByName('QUOTE_4_OP_MM').asInteger - dataSet.FieldByName('QUOTE_3_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_4_FAST').asInteger) +
    blip_totSecs(k_topLevel_mm - dataSet.FieldByName('QUOTE_4_MM').asInteger, 0,
                 dataSet.FieldByName('SPEED_5_FAST').asInteger)
  );
end;

procedure TdmPickupDropRins.fdtPickupTypesNewRecord(DataSet: TDataSet);
begin   inc(lastPickupID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastPickupID;
    FieldByName('SPEED_1_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_2_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_3_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_4_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_5_FAST').AsInteger := 1;   // true by default
  end;
end;

procedure TdmPickupDropRins.fdtRinsingTypesAfterOpen(DataSet: TDataSet);
begin with Dataset do begin
  last;   lastRinsingID := fieldByName('ID').AsInteger;
end end;

procedure TdmPickupDropRins.fdtRinsingTypesBeforePost(DataSet: TDataSet);
var s: string;
begin
  s := '';
  // checking maximum inclination
  if blip_maxIncl(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_2_OP_MM').asInteger) then
    s := s + 'level 1 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_3_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 2 inclination exceeded' + #13;
  if blip_maxIncl(dataSet.FieldByName('QUOTE_4_MM').asInteger, dataSet.FieldByName('QUOTE_4_OP_MM').asInteger) then
    s := s + 'level 3 inclination exceeded' + #13;

  // checking against top level / sequence
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 3 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_3_OP_MM').asInteger, k_topLevel_mm) then
    s := s + 'level 3 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_MM').asInteger, dataSet.FieldByName('QUOTE_3_MM').asInteger) then
    s := s + 'level 2 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_2_OP_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 2 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_4_MM').asInteger, dataSet.FieldByName('QUOTE_3_MM').asInteger) then
    s := s + 'level 4 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_4_OP_MM').asInteger, dataSet.FieldByName('QUOTE_3_OP_MM').asInteger) then
    s := s + 'level 4 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_MM').asInteger, dataSet.FieldByName('QUOTE_2_MM').asInteger) then
    s := s + 'level 1 too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_MM').asInteger, dataSet.FieldByName('QUOTE_2_OP_MM').asInteger) then
    s := s + 'level 1 operator side too high' + #13;
  if blip_maxLevel(dataSet.FieldByName('QUOTE_1_MM').asInteger, dataSet.FieldByName('QUOTE_2_MM').asInteger) then
    s := s + 'level "out of tank" too high' + #13;

  if blip_maxLevel(k_RinsingDownLevel, dataSet.FieldByName('QUOTE_1_MM').asInteger) then
    s := s + 'level "out of tank" too low' + #13;

  if s <> '' then begin
    showMessage(s);    abort
  end;

  // calculating total time
  dataSet.FieldByName('TOTAL_SECS').AsInteger := trunc(
    dataSet.FieldByName('PAUSE_1_SECS').asInteger +
    dataSet.FieldByName('PAUSE_2_SECS').asInteger +
    dataSet.FieldByName('PAUSE_3_SECS').asInteger +
    dataSet.FieldByName('PAUSE_4_SECS').asInteger +
    blip_totSecs(dataSet.FieldByName('QUOTE_1_MM').asInteger - k_RinsingDownLevel, 0,
                 dataSet.FieldByName('SPEED_1_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_2_MM').asInteger    - dataSet.FieldByName('QUOTE_1_MM').asInteger,
                 dataSet.FieldByName('QUOTE_2_OP_MM').asInteger - dataSet.FieldByName('QUOTE_1_MM').asInteger,
                 dataSet.FieldByName('SPEED_2_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_3_MM').asInteger    - dataSet.FieldByName('QUOTE_2_MM').asInteger,
                 dataSet.FieldByName('QUOTE_3_OP_MM').asInteger - dataSet.FieldByName('QUOTE_2_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_3_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_3_MM').asInteger    - dataSet.FieldByName('QUOTE_4_MM').asInteger,
                 dataSet.FieldByName('QUOTE_3_OP_MM').asInteger - dataSet.FieldByName('QUOTE_4_OP_MM').asInteger,
                 dataSet.FieldByName('SPEED_4_FAST').asInteger) +
    blip_totSecs(dataSet.FieldByName('QUOTE_4_MM').asInteger - k_RinsingDownLevel, 0,
                 dataSet.FieldByName('SPEED_5_FAST').asInteger)
  );
end;

procedure TdmPickupDropRins.fdtRinsingTypesNewRecord(DataSet: TDataSet);
begin   inc(lastRinsingID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastRinsingID;
    FieldByName('SPEED_1_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_2_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_3_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_4_FAST').AsInteger := 1;   // true by default
    FieldByName('SPEED_5_FAST').AsInteger := 1;   // true by default
  end;
end;

procedure TdmPickupDropRins.openTypes;
begin
  fdtDropTypes   .Active := true;
  fdtPickupTypes .Active := true;
  fdtRinsingTypes.Active := true;
end;

procedure TdmPickupDropRins.duplicateDropType(pOldID, pNewID: integer);
begin
  duplicateSomethingType('DROPTYPES', fdtDropTypes, pOldID, pNewID);
end;

procedure TdmPickupDropRins.duplicatePickupType(pOldID, pNewID: integer);
begin
  duplicateSomethingType('PICKUPTYPES', fdtPickupTypes, pOldID, pNewID);
end;

procedure TdmPickupDropRins.duplicateRinsingType(pOldID, pNewID: integer);
begin
  duplicateSomethingType('RINSINGTYPES', fdtRinsingTypes, pOldID, pNewID);
end;

procedure TdmPickupDropRins.duplicateSomethingType(pTblName: string; pTbl: TFDDataSet; pOldID, pNewID: integer);
begin
  with fdqRecipesUtil do
  begin
    close;
    SQL.Text := format('select * from %s where ID = %d', [pTblName, pNewID]);
    open;
    if not EOF then
    begin
      showMessage(format('Duplicate pyckupType ERROR: new ID %d already exists', [pNewID])); exit
    end;
    close;
    SQL.Text := format('select * from %s where ID = %d', [pTblName, pOldID]);
    open;
    if EOF then
    begin
      showMessage(format('Duplicate pyckupType ERROR: old ID %d not found', [pOldID])); exit
    end;
  end;
  DuplicateRecords(true, fdqRecipesUtil, pTbl, 'ID', pNewID);
  fdqRecipesUtil.Close
end;

function TdmPickupDropRins.DuplicateRecords(justOne: boolean; cdsFrom, cdsTo: TFDDataSet; skipField: string; useValue: variant): integer;
var i, k: integer; fldFrom, fldTo: TField;

  function getFieldNamed(pFldName: string): integer;
  var j: integer;
  begin
    result := -1;   // not found
    for j := 0 to cdsFrom.fieldDefs.count - 1 do begin
      if compareText(cdsFrom.fieldDefs[j].Name, pFldName) = 0 then begin
        result := j;   exit
      end;
    end;
  end;

  procedure chkOrderRowId(sFld: string);
  begin
    if (compareText(sFld, 'ORDER_ID') = 0) or (compareText(sFld, 'ORDER_ROW') = 0) then begin
      if trim(cdsFrom.FieldByName(sFld).AsString) = '' then begin
        cdsTo.FieldByName(sFld).AsString := '-'
      end;
    end;
  end;

begin
  result := 0;
  if cdsFrom.EOF then exit;
  repeat
    cdsTo.edit;
    cdsTo.insert;
    for i := 0 to cdsTo.fieldDefs.count - 1 do begin
      if compareText(cdsTo.fieldDefs[i].name, skipField) = 0 then begin
        cdsTo.fields[i].value := useValue;
      end else begin
        if (i < cdsFrom.fieldDefs.count) and (compareText(cdsTo.fieldDefs[i].name, cdsFrom.fieldDefs[i].name) = 0) then begin
          k := i;
        end else k := getFieldNamed(cdsTo.fieldDefs[i].Name);
        if k >= 0 then begin
          cdsTo.fields[i].Assign(cdsFrom.fields[k]);   // chissà se la differenza di lunghezza in MATERIAL_ID manda tutto in vacca
          // qui posso avere il problema dei campi ORDER_ID e ORDER_ROW vuoti ... mettere trattino
          chkOrderRowId(cdsTo.fieldDefs[i].Name);
        end;  // else raise exception.Create(format('Field not found: %s', [cdsTo.fieldDefs[i].name]));
      end;
    end;
    cdsTo.post;            Application.ProcessMessages;
    if not justOne then cdsFrom.next;
    result := result + 1;
  until justOne or cdsFrom.EOF;
end;

end.
