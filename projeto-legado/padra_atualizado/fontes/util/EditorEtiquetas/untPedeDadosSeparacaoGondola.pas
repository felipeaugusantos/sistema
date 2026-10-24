unit untPedeDadosSeparacaoGondola;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass, untpai,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, EditFocus, untTypesSistema;

type
  TfrmFiltroSeparacao = class(TfrmPai)
    dtaDtaEfe: TDateTimePicker;
    lblDataEfetivacao: TLabel;
    rdgFiltroImpresso: TRadioGroup;
    edtCodOpeEfe: TEditFocus;
    edtDesOpeEfe: TEditFocus;
    Label5: TLabel;
    Label1: TLabel;
    edtCodOpeSol: TEditFocus;
    edtCodOpeSolDesc: TEditFocus;
    BitBtnLocked1: TBitBtnLocked;
    procedure edtCodOpeEfeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeSolKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure dtaDtaEfeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procProcessaReimpressao: TprocessaReimpressao;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmFiltroSeparacao: TfrmFiltroSeparacao;

implementation

uses
  untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFiltroSeparacao.BitBtnLocked1Click(Sender: TObject);
var lSeparacaoGondolaFiltro: TSeparacaoGondolaFiltro;
begin
  inherited;
  If Assigned(procProcessaReimpressao) Then
  Begin
    lSeparacaoGondolaFiltro.strOperadorSolicitacao := edtCodOpeSol.Text;
    lSeparacaoGondolaFiltro.strOperadorEfetivacao  := edtCodOpeEfe.Text;
    lSeparacaoGondolaFiltro.dtaDataEfetivacao := dtaDtaEfe.Date;
    case rdgFiltroImpresso.ItemIndex of
      0: lSeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiffTodos;
      1: lSeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiImpresso;
      2: lSeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiffNaoImpresso;
    End;

    procProcessaReimpressao(Self.Name, lSeparacaoGondolaFiltro);

  End
  Else
    ModalResult := mrOk;
end;

procedure TfrmFiltroSeparacao.dtaDtaEfeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If key  = #13 Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmFiltroSeparacao.edtCodOpeEfeKeyPress(Sender: TObject; var Key: Char);
  var arrSel: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self,
                   edtCodOpeEfe,
                   edtDesOpeEfe,
                   nil,
                   Key,
                   arrSel) Then
  Begin
    If fValidaCampos(edtCodOpeEfe, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFiltroSeparacao.edtCodOpeSolKeyPress(Sender: TObject; var Key: Char);
  var arrSel: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self,
                   edtCodOpeSol,
                   edtCodOpeSolDesc,
                   nil,
                   Key,
                   arrSel) Then
  Begin
    If fValidaCampos(edtCodOpeSol, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFiltroSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  dtaDtaEfe.Date := fNow;
end;

function TfrmFiltroSeparacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtCodOpeSol then
    Begin
      edtCodOpeSolDesc.Text := '';
      If Not fEmptyStr(edtCodOpeSol.Text) Then
      Begin
        edtCodOpeSolDesc.Text := fRetNomeOperador(edtCodOpeSol.Text);
        If fEmptyStr(edtCodOpeSolDesc.Text) Then
        begin
          Result := False;
          pMensagemOk('Operador inválido!');
        End;

      End;

    End
    Else
    If Sender = edtCodOpeEfe then
    Begin
      edtDesOpeEfe.Text := '';
      If Not fEmptyStr(edtCodOpeEfe.Text) Then
      Begin
        edtDesOpeEfe.Text := fRetNomeOperador(edtCodOpeEfe.Text);
        If fEmptyStr(edtDesOpeEfe.Text) Then
        begin
          Result := False;
          pMensagemOk('Operador inválido!');
        End;
      End;
    End;
  End;
end;

end.
