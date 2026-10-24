unit untCadCotImportacao;

interface

uses
  Windows, Classes, untPaiEdit, StdCtrls, CheckLst, BitBtnLockedIncrem,
  Controls, AppEvnts, Menus, Buttons, ExtCtrls;

type
  TfrmCadCotImportacao = class(TfrmPaiEdit)
    chlLisArq: TCheckListBox;
    Label1: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCotImportacao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chlLisArq);
end;

end.
