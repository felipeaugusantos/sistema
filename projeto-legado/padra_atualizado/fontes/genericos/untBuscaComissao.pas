unit untBuscaComissao;

interface

uses
  Windows, Classes, Controls,
  untPai, Menus, StdCtrls, Buttons, ExtCtrls, MaskEditFocus,
  EditFocus, AppEvnts, BitBtnLockedIncrem, Mask;

type
  TfrmBuscaComissao = class(TfrmPai)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    edtCodigo: TEditFocus;
    edtValorVenda: TEditFocus;
    edtDtaCad: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
  private
    blnConfirma: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strValorFiltro: String;
    strCampoFiltro: String;
    { Public declarations }
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmBuscaComissao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodigo);
end;

function TfrmBuscaComissao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO COMISSÃO              *}
    {**************************************JB*}
    If (Sender = edtValorVenda) Then
    Begin
      If Not fEmptyStr(edtCodigo.Text) Then
      Begin
        strCampoFiltro := 'Código';
        strValorFiltro := edtCodigo.Text;
      End
      Else If Not fEmptyStr(fTiraCaracEspeciais(edtDtaCad.Text)) Then
      Begin
        strCampoFiltro := 'Dta Cadastro';
        strValorFiltro := FormatDateTime('dd/MM/yyyy', StrToDate(edtDtaCad.Text));
      End
      Else If Not fEmptyStr(edtValorVenda.Text) Then
      Begin
        strCampoFiltro := 'Vr Venda';
        strValorFiltro := edtValorVenda.Text;
      End
      Else
      Begin
        strValorFiltro := '';
        strCampoFiltro := '';
      End;
      blnConfirma := True;
      Close;
    End

  End;
  
End;


end.

