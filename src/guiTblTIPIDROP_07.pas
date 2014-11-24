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
    btnSaveData: TButton;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveDataClick(Sender: TObject);
  private
    procedure saveData(pAsk: boolean = false);
  public
    { Public declarations }
  end;

var
  FormTblTIPIDROP_07: TFormTblTIPIDROP_07;

implementation uses dbiRecipes;

{$R *.dfm}

{ TFormTblTIPIDROP_07 }

procedure TFormTblTIPIDROP_07.btnSaveDataClick(Sender: TObject);
begin
  saveData
end;

procedure TFormTblTIPIDROP_07.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  saveData(true)
end;

procedure TFormTblTIPIDROP_07.saveData(pAsk: boolean);
begin
  with dsTipiDeposito.dataSet as TFDTable do begin
    checkBrowseMode;
    if changeCount > 0 then begin
      if pAsk and (messageDlg('save data ?', mtConfirmation, [mbOK, mbCancel], 0) <> mrOK) then exit;
      applyUpdates(0);
    end;
  end;
end;

end.
