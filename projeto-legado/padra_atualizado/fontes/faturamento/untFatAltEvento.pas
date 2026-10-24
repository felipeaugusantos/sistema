unit untFatAltEvento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, Uni, System.StrUtils;

type
  TfrmFatAltEvento = class(TfrmPai)
    pnlBusca: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDocum: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    lblEveAtu: TLabel;
    Label7: TLabel;
    edtCodCli: TEditFocus;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    edtDesCli: TEditFocus;
    edtDesEve: TEditFocus;
    edtValDoc: TEditFocus;
    edtCodEve: TEditFocus;
    pnlEvento: TPanel;
    lblEveNew: TLabel;
    edtCodNew: TEditFocus;
    edtDesNew: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodNewKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strTabela, strAutInc: String;
    procedure pLimpaTela;
    procedure pCarregaDados(qryDados: TUniQuery);
    function fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fAlteraEvento: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmFatAltEvento }

procedure TfrmFatAltEvento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Enabled Then
    Exit;

  If Not fPergunta('Confirma alteração do Centro de Custos?') Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If fAlteraEvento Then
    pLimpaTela;
end;

procedure TfrmFatAltEvento.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltEvento.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltEvento.edtCodNewKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqEventos(Self, edtCodNew, edtDesNew, Nil, Key, arrSel, True, True) then
  Begin
    If fValidaCampos(edtCodNew) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltEvento.fAlteraEvento: Boolean;
  Var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);
  Try
    fStartTransaction;
    Try
      If SameText(strTabela, 'FATGOR') Then
      Begin
        qryUpdate.SQL.Add('UPDATE EXTGOR');
        qryUpdate.SQL.Add('  SET FGO_CODEVE = :CODEVE ');
        qryUpdate.SQL.Add('WHERE FGO_SEQFGO = :AUTINC ');
      End
      Else
      Begin
        qryUpdate.SQL.Add('UPDATE '+ strTabela);
        qryUpdate.SQL.Add('  SET GER_CODEVE = :CODEVE ');
        qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
      End;

      qryUpdate.ParamByName('CODEVE').AsString := edtCodNew.Text;
      qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
      qryUpdate.ExecSQL;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE CADREC ');
      qryUpdate.SQL.Add('  SET CTR_CODEVE = :CODEVE ');
      qryUpdate.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC ');
      qryUpdate.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
      qryUpdate.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
      qryUpdate.SQL.Add('  AND CTR_CODCLI = :CODCLI ');
      qryUpdate.ParamByName('CODEVE').AsString := edtCodNew.Text;
      qryUpdate.ParamByName('NUMDOC').AsString := edtDocum.Text;
      qryUpdate.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryUpdate.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryUpdate.ParamByName('CODCLI').AsString := edtCodCli.Text;
      qryUpdate.ExecSQL;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('INSERT INTO LOGEVE( ');
      qryUpdate.SQL.Add('  AUTOINCREM, ');
      qryUpdate.SQL.Add('  LOG_NUMDOC, ');
      qryUpdate.SQL.Add('  LOG_ESPDOC, ');
      qryUpdate.SQL.Add('  LOG_CODCLI, ');
      qryUpdate.SQL.Add('  LOG_CODEMP, ');
      qryUpdate.SQL.Add('  LOG_DTAALT, ');
      qryUpdate.SQL.Add('  LOG_HRAALT, ');
      qryUpdate.SQL.Add('  LOG_OPEALT, ');
      qryUpdate.SQL.Add('  LOG_TABELA, ');
      qryUpdate.SQL.Add('  LOG_AUTINC, ');
      qryUpdate.SQL.Add('  LOG_OLDEVE, ');
      qryUpdate.SQL.Add('  LOG_NEWEVE) ');
      qryUpdate.SQL.Add('VALUES( ');
      qryUpdate.SQL.Add('  :AUTOIN, ');
      qryUpdate.SQL.Add('  :NUMDOC, ');
      qryUpdate.SQL.Add('  :ESPDOC, ');
      qryUpdate.SQL.Add('  :CODCLI, ');
      qryUpdate.SQL.Add('  :CODEMP, ');
      qryUpdate.SQL.Add('  :DTAALT, ');
      qryUpdate.SQL.Add('  :HRAALT, ');
      qryUpdate.SQL.Add('  :OPEALT, ');
      qryUpdate.SQL.Add('  :TABELA, ');
      qryUpdate.SQL.Add('  :AUTINC, ');
      qryUpdate.SQL.Add('  :OLDEVE, ');
      qryUpdate.SQL.Add('  :NEWEVE) ');
      qryUpdate.ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGEVE', VS_strCodEmp);
      qryUpdate.ParamByName('NUMDOC').AsString := edtDocum.Text;
      qryUpdate.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryUpdate.ParamByName('CODCLI').AsString := edtCodCli.Text;
      qryUpdate.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryUpdate.ParamByName('DTAALT').AsDate   := VS_Date;
      qryUpdate.ParamByName('HRAALT').AsTime   := fTime();
      qryUpdate.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      qryUpdate.ParamByName('TABELA').AsString := strTabela;
      qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
      qryUpdate.ParamByName('OLDEVE').Value    := IIF(Not fEmptyStr(edtCodEve.Text), edtCodEve.Text, Null);
      qryUpdate.ParamByName('NEWEVE').AsString := edtCodNew.Text;
      qryUpdate.ExecSQL;

      Result := True;
      fCommit;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[frmFatAltEvento.fAlteraEvento]');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmFatAltEvento.fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryBusca: TUniQuery;
    strSQL, strSQLFatGor, strSQLMovGer, strSQLNotGer: String;
begin
  If AnsiMatchStr(strEspDoc, ['OR','PD']) Then
  Begin
    strSQLFatGor := '';
    strSQLFatGor := strSQLFatGor + 'SELECT SQL_NO_CACHE                           ';
    strSQLFatGor := strSQLFatGor + '  "FATGOR" AS TABGER,                         ';
    strSQLFatGor := strSQLFatGor + '  FATGOR.AUTOINCREM AS AUTGER,                ';
    strSQLFatGor := strSQLFatGor + '  FGO_CODCLI AS CODCLI,                       ';
    strSQLFatGor := strSQLFatGor + '  CLI_NOMCLI AS NOMCLI,                       ';
    strSQLFatGor := strSQLFatGor + '  FGO_DTAENT AS DTAENT,                       ';
    strSQLFatGor := strSQLFatGor + '  FGO_VLRCON AS VALDOC,                       ';
    strSQLFatGor := strSQLFatGor + '  FGO_CONPAG AS CONPAG,                       ';
    strSQLFatGor := strSQLFatGor + '  FGO_CODEVE AS CODEVE,                       ';
    strSQLFatGor := strSQLFatGor + '  EVE_DESEVE AS DESEVE                        ';
    strSQLFatGor := strSQLFatGor + 'FROM FATGOR                                   ';
    strSQLFatGor := strSQLFatGor + 'JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQLFatGor := strSQLFatGor + 'LEFT JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI   ';
    strSQLFatGor := strSQLFatGor + 'LEFT JOIN CADEVE ON EVE_CODEVE = FGO_CODEVE   ';
    strSQLFatGor := strSQLFatGor + 'WHERE FGO_NUMDOC = :NUMDOC                    ';
    strSQLFatGor := strSQLFatGor + '  AND FGO_ESPDOC = :ESPDOC                    ';
    strSQLFatGor := strSQLFatGor + '  AND FGO_CODEMP = :CODEMP                    ';
    strSQLFatGor := strSQLFatGor + '  AND FGO_CODCLI = :CODCLI                    ';

    strSQL := strSQLFatGor;
  End
  Else
  Begin
    strSQLMovGer := '';
    strSQLMovGer := strSQLMovGer + 'SELECT SQL_NO_CACHE                         ';
    strSQLMovGer := strSQLMovGer + '  "MOVGER" AS TABGER,                       ';
    strSQLMovGer := strSQLMovGer + '  MOVGER.AUTOINCREM AS AUTGER,              ';
    strSQLMovGer := strSQLMovGer + '  GER_CODCLI AS CODCLI,                     ';
    strSQLMovGer := strSQLMovGer + '  CLI_NOMCLI AS NOMCLI,                     ';
    strSQLMovGer := strSQLMovGer + '  GER_DTAENT AS DTAENT,                     ';
    strSQLMovGer := strSQLMovGer + '  GER_VLRCON AS VALDOC,                     ';
    strSQLMovGer := strSQLMovGer + '  GER_CONPAG AS CONPAG,                     ';
    strSQLMovGer := strSQLMovGer + '  GER_CODEVE AS CODEVE,                     ';
    strSQLMovGer := strSQLMovGer + '  EVE_DESEVE AS DESEVE                      ';
    strSQLMovGer := strSQLMovGer + 'FROM MOVGER                                 ';
    strSQLMovGer := strSQLMovGer + 'LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQLMovGer := strSQLMovGer + 'LEFT JOIN CADEVE ON EVE_CODEVE = GER_CODEVE ';
    strSQLMovGer := strSQLMovGer + 'WHERE GER_NUMDOC = :NUMDOC                  ';
    strSQLMovGer := strSQLMovGer + '  AND GER_ESPDOC = :ESPDOC                  ';
    strSQLMovGer := strSQLMovGer + '  AND GER_CODEMP = :CODEMP                  ';
    strSQLMovGer := strSQLMovGer + '  AND GER_CODCLI = :CODCLI                  ';
    strSQLMovGer := strSQLMovGer + '  AND GER_TIP_FC = "C"                      ';

    strSQLNotGer := AnsiReplaceStr(strSQLMovGer, 'MOVGER', 'NOTGER');

    strSQL := strSQLMovGer +' UNION ALL '+ strSQLNotGer;
  End;

  qryBusca := fCriaQuery(Nil);
  Try
    qryBusca.SQL.Add(strSQL);
    qryBusca.ParamByName('NUMDOC').AsString := strNumdoc;
    qryBusca.ParamByName('ESPDOC').AsString := strEspDoc;
    qryBusca.ParamByName('CODEMP').AsString := strCodEmp;
    qryBusca.ParamByName('CODCLI').AsString := strCodCli;
    qryBusca.Open;

    Result := Not qryBusca.IsEmpty;

    If Result Then
      pCarregaDados(qryBusca);
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TfrmFatAltEvento.FormShow(Sender: TObject);
begin
  inherited;
  edtDocum.TamCampo  := fTamDocCadRec;
  edtDocum.MaxLength := edtDocum.TamCampo;

  pLimpaTela;
end;

function TfrmFatAltEvento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        pMensagemOk('Digite o número do documento!');
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        pMensagemOk('Digite a espécie do documento!');
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        pMensagemOk('Digite o código da empresa!');
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          pMensagemOk('A Empresa digitada não foi encontrada, verifique!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        pMensagemOk('Digite o código do cliente!');
        Result := False;
      End
      Else
      Begin
        edtDesCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtDesCli.Text) Then
        Begin
          pMensagemOk('O Cliente digitado não foi encontrado, verifique!');
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text) Then
          Begin
            pMensagemOk('O Documento digitado não foi encontrado, verifique!');
            Sender := edtDocum;
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodNew) Then
    Begin
      If fEmptyStr(edtCodNew.Text) Then
      Begin
        pMensagemOk('Digite o código do Centro de Custos!');
        Result := False;
      End
      Else
      Begin
        edtDesNew.Text := fRetNomEventoExiFat(edtCodNew.Text);
        If fEmptyStr(edtDesNew.Text) Then
        Begin
          pMensagemOk('O Centro de Custos digitado não foi encontrado, verifique!');
          Result := False;
        End
        Else If (edtCodNew.Text = edtCodEve.Text) Then
        Begin
          pMensagemOk('O Centro de Custos digitado é o mesmo do documento!');
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltEvento.pCarregaDados(qryDados: TUniQuery);
begin
  edtDtaFat.Text := FormatDateTime('DD/MM/YYYY', qryDados.FieldByName('DTAENT').AsDateTime);
  edtConPag.Text := fFormataCondPag(qryDados.FieldByName('CONPAG').AsString);
  edtValDoc.Text := FormatFloat('##,#0.00', qryDados.FieldByName('VALDOC').AsFloat);
  edtCodEve.Text := qryDados.FieldByName('CODEVE').AsString ;
  edtDesEve.Text := qryDados.FieldByName('DESEVE').AsString;

  strTabela := qryDados.FieldByName('TABGER').AsString;
  strAutInc := qryDados.FieldByName('AUTGER').AsString;

  btnConfirma.Enabled := True;
  pnlBusca.Enabled    := False;
end;

procedure TfrmFatAltEvento.pEscapePressed;
begin
  If Not pnlBusca.Enabled Then
    pLimpaTela
  Else
    inherited;
end;

procedure TfrmFatAltEvento.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  strTabela := '';
  strAutInc := '';

  btnConfirma.Enabled := False;
  pnlBusca.Enabled    := True;

  pSetFocus(edtDocum);
end;

end.
