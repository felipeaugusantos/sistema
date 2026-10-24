unit untPedidoCompraImpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, QColorLabel,
  EditFocus, untFuncoes, untfuncoesSimples, AppEvnts;

type
  TfrmPedidoCompraImpr = class(TfrmPai)
    gbImprimir: TGroupBox;
    gbPreco: TGroupBox;
    gbOrdem: TGroupBox;
    btnConfirmar: TBitBtn;
    edtImprimir: TEditFocus;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    edtPreco: TEditFocus;
    ColorLabel3: TColorLabel;
    edtOrdem: TEditFocus;
    gbOpcao: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel4: TColorLabel;
    GroupBox1: TGroupBox;
    ColorLabel5: TColorLabel;
    edtResLitragem: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    blnSemPre: Boolean;
    blnOrdDig: Boolean;
    intOpcao : Integer;
    blnImprim: Boolean;
    blnImpRes: Boolean;
  end;

var
  frmPedidoCompraImpr: TfrmPedidoCompraImpr;

implementation

{$R *.dfm}

function TfrmPedidoCompraImpr.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {****************************}
    {* VERIFICA CAMPO IMPRIMIR  *}
    {*************************LU*}
    If (Sender = edtImprimir) Then
    Begin
      If (edtImprimir.Text <> 'S') And (edtImprimir.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir deve ser S ou N.',['&O K']);
        Result := False;
      End;
      If (edtImprimir.Text = 'N') Then
      Begin
        edtPreco.Enabled := False;
        edtOrdem.Enabled := False;
        edtResLitragem.Enabled := False;
        btnConfirmar.Click;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO PREÇO     *}
    {*************************LU*}
    Else
    If (Sender = edtPreco) Then
    Begin
      If (edtPreco.Text <> 'C') And (edtPreco.Text <> 'S') Then
      Begin
        fMensagem('','O campo Preço deve ser C ou S.',['&O K']);
        Result := False;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO ORDEM     *}
    {*************************LU*}
    Else
    If (Sender = edtOrdem) Then
    Begin
      If (edtOrdem.Text <> 'D') And (edtOrdem.Text <> 'A') Then
      Begin
        fMensagem('','O campo Ordem deve ser D ou A.',['&O K']);
        Result := False;
      End;
    End
    {****************************}
    {* VERIFICA CAMPO OPÇÃO     *}
    {*************************LU*}
    Else
    If (Sender = edtOpcao) Then
    Begin
      If (gbOpcao.Visible) Then
      Begin
        If (edtOpcao.Text <> 'I') And (edtOpcao.Text <> 'S') And (edtOpcao.Text <> 'C') Then
        Begin
          fMensagem('','O campo Opção deve ser I, S ou C.',['&O K']);
          Result := False;
        End;
      End;
    End
    {*************************************}
    {* VERIFICA CAMPO RESUMO DE LITRAGEM *}
    {**********************************LU*}
    Else
    If (Sender = edtResLitragem) Then
    Begin
      If (edtResLitragem.Text <> 'S') And (edtResLitragem.Text <> 'N') Then
      Begin
        fMensagem('','O campo Imprimir Resumo de Litragem por Grupo deve ser S ou N.',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;
end;


procedure TfrmPedidoCompraImpr.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  intOpcao := 1;

  If edtImprimir.Text = 'S' Then
  Begin
    blnImprim := True;
    If edtResLitragem.Text = 'S' Then
      blnImpRes := True
    Else
      blnImpRes := False;
    If edtPreco.Text = 'C' Then
      blnSemPre := False
    Else
      blnSemPre := True;
    If edtOrdem.Text = 'D' Then
      blnOrdDig := True
    Else
      blnOrdDig := False;
    If gbOpcao.Visible Then
    Begin
      If edtOpcao.Text = 'I' Then
        intOpcao := 1
      Else
      Begin
        If edtOpcao.Text = 'S' Then
          intOpcao := 2
        Else
          intOpcao := 3;
      End;
    End;
  End
  Else
    blnImprim := False;

  Close;

end;

end.

