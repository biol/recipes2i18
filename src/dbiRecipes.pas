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
    CDSClone: TFDMemTable;
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
    procedure recipesCnxBeforeConnect(Sender: TObject);
    procedure tblRecipesBeforeDelete(DataSet: TDataSet);
    procedure tblRecipesBeforeInsert(DataSet: TDataSet);
    procedure tblTipiDepositoNewRecord(DataSet: TDataSet);
    procedure tblTipiDepositoAfterOpen(DataSet: TDataSet);
    procedure tblTipiPrelievoAfterOpen(DataSet: TDataSet);
    procedure tblTipiRisciacquoAfterOpen(DataSet: TDataSet);
    procedure tblTipiRisciacquoNewRecord(DataSet: TDataSet);
    procedure tblTipiPrelievoNewRecord(DataSet: TDataSet);
    procedure tblRecipeStepsNewRecord(DataSet: TDataSet);
  private
    _RecipeID, _lastStep: integer;
  public
    lastPickupID, lastDropID, lastRinsingID: integer;
    function recipeExists(pRecipeID: integer): boolean;
    procedure buildNewEmptyRecipe(pRecipeID: integer; pName: string);
    procedure doDeleteRecipeDetails(pRecipeID: integer);
    procedure DuplicateRecord(cds: TFDDataSet; pID_fieldName: string = 'ID');
    procedure DuplicateRecipe(cds: TFDDataSet; pNewRecipeID: integer; pRecipeID_fieldName: string = 'IDRICETTA');
  end;

var
  dmRecipes: TdmRecipes;

implementation uses Dialogs, System.UITypes {mrOK},
  uEtcXE, guiRecipes;

{%CLASSGROUP 'Vcl.Controls.TControl'}



{$R *.dfm}

procedure TdmRecipes.buildNewEmptyRecipe(pRecipeID: integer; pName: string);
begin
  with qryUtils do try
    close;
    SQL.Text := 'insert into INDICERICETTE (IDRICETTA, NOME, DISPONIBILE) values (:IDRICETTA, :NOME, 1)';
    params.ParamByName('IDRICETTA').AsInteger := pRecipeID;
    params.ParamByName('NOME')     .AsString  := copy(pName,1,15);
    execSql;
  finally
    tblRecipes.Refresh;
    close
  end
end;

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

procedure TdmRecipes.recipesCnxBeforeConnect(Sender: TObject);
begin with Sender as TFDConnection do begin
  params.Values['database'] := absolutizePath(puntoIni.ReadString('config', 'database',
    changeFileExt(application.ExeName, '.gdb')))
end end;

procedure TdmRecipes.tblRecipesBeforeDelete(DataSet: TDataSet);
var iR: integer;
begin iR := DataSet.FieldByName('IDRICETTA').AsInteger;
  if messageDlg(FormRecipes.siLang1.GetTextOrDefault('IDS_13' (* 'Delete recipe ' *) ) + intToStr(iR) + ') ' + DataSet.FieldByName('NOME').AsString + ' ?',
    mtConfirmation, [mbOK, mbCancel], 0) = mrOK then begin
    dmRecipes.doDeleteRecipeDetails(iR);
  end else abort
end;

procedure TdmRecipes.tblRecipesBeforeInsert(DataSet: TDataSet);
begin
  showMessage(FormRecipes.siLang1.GetTextOrDefault('IDS_15' (* 'pleas use "NEW recipe" button to add recipes' *) )); abort
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

procedure TdmRecipes.DuplicateRecord(cds: TFDDataSet; pID_fieldName: string = 'ID');
var i: integer; fldFrom, fld: TField;
begin
  with cds do if (not active) or EOF then exit;
  CDSClone.CloneCursor(cds, True);
  with cds do begin
    edit;
    insert;
    for i := 0 to fieldDefs.count - 1 do begin
      fldFrom := CDSClone.fields[i];
      fld := FindField(fieldDefs[i].name);
      if fld <> nil then begin
        if compareText(fieldDefs[i].name, pID_fieldName) = 0 then begin
          // lascio il dato impostato dalla onNewRecord
        end else fld.assign(fldFrom);
      end else raise exception.Create(format('Field not found: %s', [fieldDefs[i].name]));
    end;   // for
    post;
  end;
  CDSClone.Active := False;
end;

procedure TdmRecipes.DuplicateRecipe(cds: TFDDataSet; pNewRecipeID: integer; pRecipeID_fieldName: string = 'IDRICETTA');
var i: integer; fldFrom, fld: TField;
begin
  with cds do if (not active) or EOF then exit;
  CDSClone.CloneCursor(cds, True);
  CDSClone.first;
  while not CDSClone.EOF do begin
    if CDSClone.fieldByName(pRecipeID_fieldName).AsInteger <> pNewRecipeID then begin
      with cds do begin
        edit;
        insert;
        for i := 0 to fieldDefs.count - 1 do begin
          fldFrom := CDSClone.fields[i];
          fld := FindField(fieldDefs[i].name);
          if fld <> nil then begin
            if compareText(fieldDefs[i].name, pRecipeID_fieldName) = 0 then begin
              fld.AsInteger := pNewRecipeID;
            end else fld.assign(fldFrom);
          end else raise exception.Create(format('Field not found: %s', [fieldDefs[i].name]));
        end;   // for
        post;
      end;
    end;
    CDSClone.next;
  end;
  CDSClone.Active := False;
end;



end.
