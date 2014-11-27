unit guiTblTIPIDROP_07;

interface

uses
  {
  SysUtils, Forms, Dialogs, siComp, siLngLnk, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.Graphics, System.Classes;
  }

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Mask, Grids, DBGrids,
  DB, DBClient, siComp, siLngLnk, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;
type
  TFormTblTIPIDROP_07 = class(TForm)
    pnlHead: TPanel;
    DBNavigator1: TDBNavigator;
    pnlFoot: TPanel;
    DBNavigator2: TDBNavigator;
    Label18: TLabel;
    Label1: TLabel;
    I: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Image1: TImage;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    Label11: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    DBGrid2: TDBGrid;
    dsTipiDeposito: TDataSource;
    siLangLinked1: TsiLangLinked;
    lblNewRecipe: TLabel;
    editNewRecipeID: TEdit;
    lblCopyFromID: TLabel;
    EditCopyFromID: TEdit;
    btnNewRecipe: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNewRecipeClick(Sender: TObject);
  private
    procedure saveData;
  public
    { Public declarations }
  end;

var
  FormTblTIPIDROP_07: TFormTblTIPIDROP_07;

implementation uses dbiRecipes;

{$R *.dfm}

{ TFormTblTIPIDROP_07 }

procedure TFormTblTIPIDROP_07.btnNewRecipeClick(Sender: TObject);
var newID, copyFromID: integer;   sNewName: string;
begin
  saveData;
  newID := strToIntDef(editNewRecipeID.Text, 0);   editNewRecipeID.Text := intToStr(newID);
  // verifica NON esistenza di newID e che sia > 0
  if newID <= 0 then begin
    showMessage('you can only use positive integers for NEW type ID');   exit
  end;
  if dmRecipes.typeExists('TIPIDEPO_07', newID) then begin
    showMessage(format('NEW type %d already exists.', [newID]));   exit
  end;

  copyFromID := strToIntDef(EditCopyFromID .Text, 0);   EditCopyFromID .Text := intToStr(copyFromID);
  // verifica esistenza di copyFromID se e solo se � > 0
  if (copyFromID > 0) and (not dmRecipes.typeExists('TIPIDEPO_07', copyFromID)) then begin
    showMessage(format('"copy from" type %d does not exist.', [copyFromID]));   exit
  end;

  // se l'utente conferma ... facciamo un paio di query di inserimento ...
  if (copyFromID > 0) then begin
    if messageDlg(format('Confirm copying existing type %d to NEW type %d ?',
      [copyFromID, newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLangLinked1.GetTextOrDefault('IDS_6' (* 'copy of' *) ) + intToStr(copyFromID);
  end else begin
    if messageDlg(format('Confirm creating a new EMPTY type with ID %d ?',
      [newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := 'new type';
  end;

  if copyFromID = 0 then begin
    dmRecipes.buildNewEmptyType('TIPIDEPO_07', newID, sNewName);
    exit;  // bona l�
  end;

  // duplica
  dmRecipes.copyTypeFromTo('TIPIDEPO_07', copyFromID, newID);   // preparo di dettagli della new recipe
end;

procedure TFormTblTIPIDROP_07.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveData
end;

procedure TFormTblTIPIDROP_07.saveData;
begin
  dmRecipes.tblTipiDeposito.checkBrowseMode;
end;

end.
