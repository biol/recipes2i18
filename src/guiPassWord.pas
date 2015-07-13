unit guiPassWord;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, siComp, siLngLnk;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    EditUser: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    EditPwd: TEdit;
    Label2: TLabel;
    EditNewPwd: TEdit;
    EditNewPwd2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    siLangLinked_PasswordDlg: TsiLangLinked;
  private
    { Private declarations }
  public
    function getUser: string;
    function getPwd: string;
    function getNewPwd: string;
    function getNewPwd2: string;
  end;
{
var
  PasswordDlg: TPasswordDlg;
}
implementation

{$R *.dfm}

{ TPasswordDlg }

function TPasswordDlg.getUser   : string; begin result := EditUser   .Text end;
function TPasswordDlg.getPwd    : string; begin result := EditPwd    .Text end;
function TPasswordDlg.getNewPwd : string; begin result := EditNewPwd .Text end;
function TPasswordDlg.getNewPwd2: string; begin result := EditNewPwd2.Text end;

end.
 
