unit guiTblCLBRs;

interface

uses
  SysUtils, Forms, Dialogs, siComp, siLngLnk, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormTblCLBR = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    siLangLinked1: TsiLangLinked;
    dsTblCLBR: TDataSource;
    lblNoInsNoDel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTblCLBR: TFormTblCLBR;

implementation

{$R *.dfm}

uses dbiRecipes;

procedure TFormTblCLBR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmRecipes.tblCLBR.CheckBrowseMode
end;

end.
