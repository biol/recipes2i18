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
    procedure recipesCnxBeforeConnect(Sender: TObject);
    procedure tblRecipesBeforeDelete(DataSet: TDataSet);
    procedure tblRecipesBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function recipeExists(pRecipeID: integer): boolean;
    procedure buildNewEmptyRecipe(pRecipeID: integer; pName: string);
    procedure doDeleteRecipeDetails(pRecipeID: integer);
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

end.