unit guiLastJobsOfBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFormLastJobsOfBar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EditBar: TEdit;
    btnSearchBarJobs: TButton;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    Splitter2: TSplitter;
    DBGrid3: TDBGrid;
    procedure btnSearchBarJobsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLastJobsOfBar: TFormLastJobsOfBar;

implementation uses dbiRecipes;

{$R *.dfm}

procedure TFormLastJobsOfBar.btnSearchBarJobsClick(Sender: TObject);
var pBar: integer;
begin
  pBar := StrToIntDef(EditBar.Text, 0);
  EditBar.Text := IntToStr(pBar);
  dmRecipes.seekLastJobsOfBar(pBar);
end;

end.
