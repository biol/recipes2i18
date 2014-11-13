unit guiTblTIPIRINS_07;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DB, Mask, Grids, DBGrids, guiRecipeDetails,
  DBClient, siComp, siLngLnk;

type
  TFormTblTIPIRINS_07 = class(TForm)
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Image1: TImage;
    Label10: TLabel;
    Label12: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label3: TLabel;
    DBGrid2: TDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    dsTipiRisciacquo: TDataSource;
    siLangLinked1: TsiLangLinked;
    procedure btnSaveDataClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure saveData(pAsk: boolean = false);
  public
    { Public declarations }
  end;

var
  FormTblTIPIRINS_07: TFormTblTIPIRINS_07;

implementation

{$R *.dfm}

procedure TFormTblTIPIRINS_07.btnSaveDataClick(Sender: TObject);
begin
  saveData
end;

procedure TFormTblTIPIRINS_07.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  saveData(true)
end;

procedure TFormTblTIPIRINS_07.saveData(pAsk: boolean);
begin
  with dsTipiRisciacquo.dataSet as TClientDataSet do begin
    checkBrowseMode;
    if changeCount > 0 then begin
      if pAsk and (messageDlg('save data ?', mtConfirmation, [mbOK, mbCancel], 0) <> mrOK) then exit;
      applyUpdates(0);
    end;
  end;
end;

end.
