unit untRcxSelecionaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB;

type
  TfrmRcxSelecionaCaixa = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    procedure pCarregaCaixa;

    { Private declarations }
  public
    strCaixaOrigem     : String;
    dtaPrimeiroLancamento,
    dtaDataDoCaixa     : TDateTime;

    blnValidacaoCaixaOrigemEDestino: Boolean;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Protected declarations }
  end;

implementation
Uses untFuncoesSimples, untConsultas, untRcxTResumoDeCaixa, untTypesSistema;
{$R *.dfm}

{ TfrmRcxSelecionaCaixa }

procedure TfrmRcxSelecionaCaixa.edtCodigoCaixaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, Nil, Key, arrCaixa, True, VS_strCodEmp, True) Then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxSelecionaCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  blnValidacaoCaixaOrigemEDestino := True;
end;

function TfrmRcxSelecionaCaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaDataGravacaoFechamento,
    dtaDataUltimoFechamento,
    dtaUltimoLancamentoDestino: TDateTime;

    cdsDadosFechamento: TDataset;

    objResumoDeCaixa: TResumoDeCaixa;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoCaixa) Then
    Begin

      If (fEmptyStr(edtCodigoCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do caixa deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCaixa;
        If (fEmptyStr(edtDescricaoCaixa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse caixa não está cadastrado, está inativo ou não faz parte da empresa atual!', ['&Ok']);
          Result := False;
        End
        Else If (blnValidacaoCaixaOrigemEDestino) And
                (edtCodigoCaixa.Text = strCaixaOrigem) Then
        Begin
          fMensagem('ATENÇÃO!', 'O caixa de destino deve ser diferente do caixa de origem!', ['&Ok']);
          Result := False;
        End
        Else If (blnValidacaoCaixaOrigemEDestino) Then
        Begin
          objResumoDeCaixa := TResumoDeCaixa.Create('C');
          objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaUltimoLancamentoDestino, edtCodigoCaixa.Text, False);
          cdsDadosFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(edtCodigoCaixa.Text, VS_strCodEmp);
          FreeAndNil(objResumoDeCaixa);

          dtaDataUltimoFechamento   := cdsDadosFechamento.FieldByname('RCX_DTACAD').AsDateTime;
          dtaDataGravacaoFechamento := cdsDadosFechamento.FieldByname('RCX_DTAGRV').AsDateTime;
          FreeAndNil(cdsDadosFechamento);

          If (dtaDataUltimoFechamento > dtaDataDoCaixa) Or
             ((dtaDataUltimoFechamento = dtaDataDoCaixa) And
              (dtaDataGravacaoFechamento > dtaPrimeiroLancamento)) Then
          Begin
            fMensagem('ATENÇÃO', 'Existe um fechamento do caixa posterior a data dos lançamentos dos registros.', ['&OK']);
            Result := False;
          End
          Else If (dtaUltimoLancamentoDestino <> dtaDataDoCaixa)Then
          Begin
            fMensagem('ATENÇÃO', 'O caixa de destino está com a data diferente do caixa de origem.', ['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          objResumoDeCaixa := TResumoDeCaixa.Create('C');
          objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaUltimoLancamentoDestino, edtCodigoCaixa.Text, False);
          FreeAndNil(objResumoDeCaixa);

          If (dtaUltimoLancamentoDestino <> VS_Date) Then
          Begin
            fMensagem('ATENÇÃO', 'O caixa do dia ' + FormatDateTime('dd/mm/yyyy', dtaUltimoLancamentoDestino) + ' não foi fechado.', ['&OK']);
            Result := False;
          End;
        End;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRcxSelecionaCaixa.pCarregaCaixa;
begin
  edtDescricaoCaixa.Clear;
  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    edtDescricaoCaixa.Text := fCampoTabela('CAX_DESCRI',
                                           'CADCAX',
                                           ['CAX_CODCAX', 'CAX_CODEMP', 'CAX_STATUS'],
                                           [edtCodigoCaixa.Text, VS_strCodEmp, 'A']);
end;

end.
