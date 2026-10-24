unit untNfeInutilizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  DateUtils, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmNfeInutilizacao = class(TfrmPai)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtAno: TEditFocus;
    edtSerie: TEditFocus;
    edtDocumentoInicial: TEditFocus;
    edtDocumentoFinal: TEditFocus;
    Label5: TLabel;
    edtMotivo: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure pInutilizarDocumentos;
    function fTemDocumentosNaFaixaEscolhida: Boolean;
    procedure pLimparDados;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untLibNfe;

{$R *.dfm}

procedure TfrmNfeInutilizacao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If fMensagem('', 'Confirma a inutilização dos documentos ' + edtDocumentoInicial.Text + ' a ' +
      edtDocumentoFinal.Text + ' de série ' + edtSerie.Text + '?' + #13#10 +
      'Esta operação é irreversível.', ['&Sim', '&Não'], 1) = 1 Then
    Begin
      pInutilizarDocumentos;
    End;
  End;
end;

procedure TfrmNfeInutilizacao.pInutilizarDocumentos;
  Var
    libNfe: TLibNfe;
begin
  If Not fTemDocumentosNaFaixaEscolhida Then
  Begin
    libNfe := TLibNfe.Create(VS_strCodEmp);

    Try
      libNfe.pInutilizarNumeros(edtAno.Text, edtSerie.Text, edtDocumentoInicial.Text,
        edtDocumentoFinal.Text, edtMotivo.Text, 'NF');
      pLimparDados;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmNfeInutilizacao.pInutilizarDocumentos]');
      End;
    End;

    FreeAndNil(libNfe);
  End
  Else
  Begin
    pMensagemOk('Há documentos emitidos no intervalo informado.');
  End;
end;

function TfrmNfeInutilizacao.fTemDocumentosNaFaixaEscolhida: Boolean;
  Var
    qryAux: TUniQuery;
begin
  pnlInfo.Caption := 'Aguarde, verificando intervalor de notas...';
  Application.ProcessMessages;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  COUNT(*) AS QTD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC BETWEEN :DOCINI AND :DOCFIN AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_ESPDOC IN ("NF", "EL", "NV") AND ');
  qryAux.SQL.Add('  FIS_ORIDOC = "V" AND ');
  qryAux.SQL.Add('  FIS_DTAENT >= "2008-01-01" ');

  qryAux.ParamByName('DOCINI').AsString := edtDocumentoInicial.Text;
  qryAux.ParamByName('DOCFIN').AsString := edtDocumentoFinal.Text;
  qryAux.ParamByName('SERIE_').AsString := edtSerie.Text;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);

  pnlInfo.Caption := '';
  Application.ProcessMessages;
end;

procedure TfrmNfeInutilizacao.pLimparDados;
begin
  edtDocumentoInicial.Clear;
  edtDocumentoFinal.Clear;
  edtMotivo.Clear;

  pSetFocus(edtAno);
end;

procedure TfrmNfeInutilizacao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtAno);
end;

procedure TfrmNfeInutilizacao.FormCreate(Sender: TObject);
begin
  inherited;
  edtAno.Text := IntToStr(YearOf(VS_Date));
  edtSerie.Text := fCfgSis('SERFSC');

  edtDocumentoInicial.MaxLength := fTamDocCadRec;
  edtDocumentoInicial.TamCampo  := edtDocumentoInicial.MaxLength;
  edtDocumentoFinal.MaxLength   := edtDocumentoInicial.MaxLength;
  edtDocumentoFinal.TamCampo    := edtDocumentoInicial.MaxLength;
end;

function TfrmNfeInutilizacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtAno Then
  Begin
    If fEmptyStr(edtAno.Text) Then
    Begin
      pMensagemOk('O Ano deve ser preenchido.');
      Result := False;
    End
    Else If StrToIntDef(edtAno.Text, 0) < 2000 Then
    Begin
      pMensagemOk('O Ano deve ser maior que 2000.');
      Result := False;
    End;
  End

  Else If Sender = edtSerie Then
  Begin
    If fEmptyStr(edtSerie.Text) Then
    Begin
      pMensagemOk('A Série deve ser preenchida.');
      Result := False;
    End;
  End

  Else If Sender = edtDocumentoInicial Then
  Begin
    If fEmptyStr(edtDocumentoInicial.Text) Then
    Begin
      pMensagemOk('O documento inicial deve ser preenchido.');
      Result := False;
    End
    Else If fEmptyStr(edtDocumentoFinal.Text) Then
    Begin
      edtDocumentoFinal.Text := edtDocumentoInicial.Text;
    End;
  End
  Else If Sender = edtDocumentoFinal Then
  Begin
    If fEmptyStr(edtDocumentoFinal.Text) Then
    Begin
      pMensagemOk('O documento final deve ser preenchido.');
      Result := False;
    End
    Else If StrToIntDef(edtDocumentoFinal.Text, -1) < StrToIntDef(edtDocumentoInicial.Text, 0) Then
    Begin
      pMensagemOk('O documento final deve ser maior ou igual o documento inicial.');
      Result := False;
    End;
  End
  Else If Sender = edtMotivo Then
  Begin
    If (fEmptyStr(edtMotivo.Text)) Or (Length(edtMotivo.Text) < 15) Then
    Begin
      pMensagemOk('O motivo deve ser preenchido e ter pelo menos 15 caracteres.');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

