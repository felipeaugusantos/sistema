unit untCadCotacaoGeralCXItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TValidaCampos = Function(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean Of Object;

type
  TOnClickExcluir = procedure(Sender: TObject) Of Object;

  TfrmCadCotacaoGeralCXItem = class(TfrmPaiEdit)
    pnlEmpresa: TPanel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    btnExcluir: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fValidaCamposVenda: TValidaCampos;
    pOnClickExcluir: TOnClickExcluir;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadCotacaoGeralCXItem: TfrmCadCotacaoGeralCXItem;

implementation

{$R *.dfm}

uses untCadCotacaoGeralCX, untFuncoesSimples;

procedure TfrmCadCotacaoGeralCXItem.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pOnClickExcluir(Sender);
end;

procedure TfrmCadCotacaoGeralCXItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: SelectNext(ActiveControl, True, True);
    VK_Escape: Key := 0;
  End;
end;

function TfrmCadCotacaoGeralCXItem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := fValidaCamposVenda(Sender, blnBuscaPorChave);
End;

end.

