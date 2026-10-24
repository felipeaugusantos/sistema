unit untRcxNFCePendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, UniDataSetProvider,   Uni, DB,
  UniClientDataSet, StdCtrls, DBCtrls, DBMemoFocus, Grids, DBGridCitel, DBGrids, AppEvnts, Menus,
  Buttons, BitBtnLockedIncrem, ExtCtrls, MemDS, DBAccess, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmRcxNFCePendentes = class(TfrmPai)
    dbgNFCes: TDBGridCitel;
    dbeMensagem: TDBMemoFocus;
    dtsNFCe: TDataSource;
    qryNFCe: TUniQuery;
    lblReenviar: TLabel;
    btnAjustarConsumidor: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure dbgNFCesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAjustarConsumidorClick(Sender: TObject);
    procedure qryNFCeAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    strLisAutInc: String;
    procedure pReenviarDocumento;
    procedure pAtualizar;
    procedure pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli,
                                   strNomCli, strEndere, strBairro, strNumCep, strCidade,
                                   strTelCon, strCgcCpf, strNumCgc, strInsEst, strRgCli, strEmail: String);
    procedure pVerificaConsumidor;
  public
    { Public declarations }
    strNome: String;
    intTempoEmSegundosPendente: Integer;
  end;

var
  frmRcxNFCePendentes: TfrmRcxNFCePendentes;

implementation

uses untLibNfe, untFuncoesSimples, untQckFatImpNFCe, untRcxDigDadConsumidor,
  untGravando;

{$R *.dfm}

{ TfrmRcxNFCePendentes }

procedure TfrmRcxNFCePendentes.btnAjustarConsumidorClick(Sender: TObject);
Var
  strSQL: String;
  qryAux: TUniQuery;
begin
  inherited;
  If fEmptyStr(qryNFCe.FieldByName('NUMDOC').AsString) Then
    Exit;

  qryAux := fCriaQuery;
  Try
    strSQL := ' SELECT ' ;
    strSQL := strSQL + '  IFNULL(G.GER_NOMCON, N.GER_NOMCON) AS GER_NOMCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_ENDCON, N.GER_ENDCON) AS GER_ENDCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_BAICON, N.GER_BAICON) AS GER_BAICON, ';
    strSQL := strSQL + '  IFNULL(G.GER_CEPCON, N.GER_CEPCON) AS GER_CEPCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_CIDCON, N.GER_CIDCON) AS GER_CIDCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_TELCON, N.GER_TELCON) AS GER_TELCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_CGCCPF, N.GER_CGCCPF) AS GER_CGCCPF, ';
    strSQL := strSQL + '  IFNULL(G.GER_CGCCON, N.GER_CGCCON) AS GER_CGCCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_IESCON, N.GER_IESCON) AS GER_IESCON, ';
    strSQL := strSQL + '  IFNULL(G.GER_R_GCON, N.GER_R_GCON) AS GER_R_GCON ';

    If fCampoExiste('MOVGER', 'GER_EMLCON', True) Then
      strSQL := strSQL + ',  IFNULL(G.GER_EMLCON, N.GER_EMLCON) AS GER_EMLCON ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  LOGNFE ';

    strSQL := strSQL + 'LEFT JOIN MOVGER G ON G.GER_NUMDOC = NFE_NUMDOC AND ';
    strSQL := strSQL + '                      G.GER_ESPDOC = NFE_ESPDOC AND ';
    strSQL := strSQL + '                      G.GER_CODEMP = NFE_CODEMP AND ';
    strSQL := strSQL + '                      IF(NFE_TIP_FC="C", G.GER_CODCLI, G.GER_CODFOR) = NFE_CODCLI AND ';
    strSQL := strSQL + '                      IFNULL(G.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

    strSQL := strSQL + 'LEFT JOIN NOTGER N ON N.GER_NUMDOC = NFE_NUMDOC AND ';
    strSQL := strSQL + '                      N.GER_ESPDOC = NFE_ESPDOC AND ';
    strSQL := strSQL + '                      N.GER_CODEMP = NFE_CODEMP AND ';
    strSQL := strSQL + '                      IF(NFE_TIP_FC="C", N.GER_CODCLI, N.GER_CODFOR) = NFE_CODCLI AND ';
    strSQL := strSQL + '                      IFNULL(N.GER_SERIE_, "") = IFNULL(NFE_SERIE_, "") ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  NFE_ESPDOC = "IF" AND ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  NFE_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  NFE_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  NFE_TIP_FC = :TIP_FC AND ';
    strSQL := strSQL + '  NFE_NUMDOC = :NUMDOC ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('CODEMP').AsString := qryNFCe.FieldByName('CODEMP').AsString;
    qryAux.ParamByName('SERIE_').AsString := qryNFCe.FieldByName('SERIE_').AsString;
    qryAux.ParamByName('CODCLI').AsString := qryNFCe.FieldByName('CODCLI').AsString;
    qryAux.ParamByName('TIP_FC').AsString := qryNFCe.FieldByName('TIP_FC').AsString;
    qryAux.ParamByName('NUMDOC').AsString := qryNFCe.FieldByName('NUMDOC').AsString;
    qryAux.Open;

    Try
      Application.CreateForm(TfrmRcxDigDadConsumidor,frmRcxDigDadConsumidor);
      frmRcxDigDadConsumidor.strCodCli := qryNFCe.FieldByName('CODCLI').AsString;

      frmRcxDigDadConsumidor.edtNomCli.Text := qryAux.FieldByName('GER_NOMCON').AsString;
      frmRcxDigDadConsumidor.edtEndere.Text := qryAux.FieldByName('GER_ENDCON').AsString;
      frmRcxDigDadConsumidor.edtBairro.Text := qryAux.FieldByName('GER_BAICON').AsString;
      frmRcxDigDadConsumidor.mskNumCep.Text := qryAux.FieldByName('GER_CEPCON').AsString;
      frmRcxDigDadConsumidor.edtCodCid.Text := qryAux.FieldByName('GER_CIDCON').AsString;
      frmRcxDigDadConsumidor.edtNomCid.Text := fRetNomCidade(qryAux.FieldByName('GER_CIDCON').AsString);
      frmRcxDigDadConsumidor.edtEstado.Text := fRetNomCidade(qryAux.FieldByName('GER_CIDCON').AsString, 1);
      frmRcxDigDadConsumidor.mskTelCon.Text := qryAux.FieldByName('GER_TELCON').AsString;
      frmRcxDigDadConsumidor.edtCgcCpf.Text := qryAux.FieldByName('GER_CGCCPF').AsString;
      frmRcxDigDadConsumidor.mskNumCgc.Text := qryAux.FieldByName('GER_CGCCON').AsString;
      frmRcxDigDadConsumidor.edtInsEst.Text := qryAux.FieldByName('GER_IESCON').AsString;
      frmRcxDigDadConsumidor.edtRgCli.Text  := qryAux.FieldByName('GER_R_GCON').AsString;
      {***************************************************}
      {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
      {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
      {************************************************RV*}
      If fCampoExiste('MOVGER', 'GER_EMLCON', True) Then
        frmRcxDigDadConsumidor.edtEmail.Text       := qryAux.FieldByName('GER_EMLCON').AsString;

      frmRcxDigDadConsumidor.ShowModal;

      If frmRcxDigDadConsumidor.blnConfirma Then
      Begin
        pAtualizaDadosConsumidor(qryNFCe.FieldByName('NUMDOC').AsString,
                                 'IF',
                                 qryNFCe.FieldByName('CODEMP').AsString,
                                 qryNFCe.FieldByName('SERIE_').AsString,
                                 qryNFCe.FieldByName('CODCLI').AsString,
                                 frmRcxDigDadConsumidor.edtNomCli.Text,
                                 frmRcxDigDadConsumidor.edtEndere.Text,
                                 frmRcxDigDadConsumidor.edtBairro.Text,
                                 frmRcxDigDadConsumidor.mskNumCep.Text,
                                 frmRcxDigDadConsumidor.edtCodCid.Text,
                                 frmRcxDigDadConsumidor.mskTelCon.Text,
                                 frmRcxDigDadConsumidor.edtCgcCpf.Text,
                                 frmRcxDigDadConsumidor.mskNumCgc.Text,
                                 frmRcxDigDadConsumidor.edtInsEst.Text,
                                 frmRcxDigDadConsumidor.edtRgCli.Text,
                                 frmRcxDigDadConsumidor.edtEmail.Text);
        pAtualizar;

        pMensagemOk('Dados do consumidor atualizados somente para esta venda. Para torná-los permanentes, verificar Cadastro de Consumidores.');
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[btnAjustarConsumidorClick]');
    End;
    FreeAndNil(frmRcxDigDadConsumidor);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmRcxNFCePendentes.pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli,
                                   strNomCli, strEndere, strBairro, strNumCep, strCidade,
                                   strTelCon, strCgcCpf, strNumCgc, strInsEst, strRgCli, strEmail: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_NUMDOC ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  MOVGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  GER_NOMCON = :NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON = :ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON = :BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON = :CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON = :CIDCON, ');
    qryAux.SQL.Add('  GER_TELCON = :TELCON, ');
    qryAux.SQL.Add('  GER_CGCCPF = :CGCCPF, ');
    qryAux.SQL.Add('  GER_CGCCON = :CGCCON, ');
    qryAux.SQL.Add('  GER_IESCON = :IESCON, ');
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If fCampoExiste('MOVGER', 'GER_EMLCON', True) Then
      qryAux.SQL.Add('  GER_EMLCON = :EMLCON, ');

    qryAux.SQL.Add('  GER_R_GCON = :R_GCON  ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End
  Else
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  NOTGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  GER_NOMCON = :NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON = :ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON = :BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON = :CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON = :CIDCON, ');
    qryAux.SQL.Add('  GER_TELCON = :TELCON, ');
    qryAux.SQL.Add('  GER_CGCCPF = :CGCCPF, ');
    qryAux.SQL.Add('  GER_CGCCON = :CGCCON, ');
    qryAux.SQL.Add('  GER_IESCON = :IESCON, ');
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If fCampoExiste('MOVGER', 'GER_EMLCON', True) Then
      qryAux.SQL.Add('  GER_EMLCON = :EMLCON, ');

    qryAux.SQL.Add('  GER_R_GCON = :R_GCON  ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End;

  qryAux.ParamByName('NOMCON').AsString := strNomCli;
  qryAux.ParamByName('ENDCON').AsString := strEndere;
  qryAux.ParamByName('BAICON').AsString := strBairro;
  qryAux.ParamByName('CEPCON').AsString := strNumCep;
  qryAux.ParamByName('CIDCON').AsString := strCidade;
  qryAux.ParamByName('TELCON').AsString := strTelCon;
  qryAux.ParamByName('CGCCPF').AsString := strCgcCpf;
  qryAux.ParamByName('CGCCON').AsString := strNumCgc;
  qryAux.ParamByName('IESCON').AsString := strInsEst;
  {***************************************************}
  {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
  {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
  {************************************************RV*}
  If fCampoExiste('MOVGER', 'GER_EMLCON', True) Then
    qryAux.ParamByName('EMLCON').AsString := strEmail;

  qryAux.ParamByName('R_GCON').AsString := strRgCli;

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

procedure TfrmRcxNFCePendentes.dbgNFCesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F1 Then
  Begin
    If Not frmRcxNFCePendentes.qryNFCe.IsEmpty Then
      TfrmGravando.fExecutarModal(pReenviarDocumento, 'Aguarde, Reenviando documento...','')
    Else
      pMensagemOk('Não há nenhum ' + strNome + IIF(intTempoEmSegundosPendente > 0,' pendente a mais de '+IntToStr(intTempoEmSegundosPendente)+' segundos.',' pendente.'));
  End

  Else If Key = VK_F3 Then
  Begin
    If btnAjustarConsumidor.Visible Then
      btnAjustarConsumidor.Click;
  End

  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmRcxNFCePendentes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgNFCes);
end;

procedure TfrmRcxNFCePendentes.FormCreate(Sender: TObject);
begin
  inherited;
  strLisAutInc := '';
  strNome := 'NFCe';
  intTempoEmSegundosPendente := -1;
end;

procedure TfrmRcxNFCePendentes.FormShow(Sender: TObject);
begin
  inherited;
  If (intTempoEmSegundosPendente > 0) Then
    Self.Caption := Self.Caption + ' (há mais de '+IntToStr(intTempoEmSegundosPendente)+' segundos da emissão)';
  lblReenviar.Caption := 'F1 - Reenviar ' + strNome;
  pAtualizar;
end;

procedure TfrmRcxNFCePendentes.pVerificaConsumidor;
Var
  qryAux: TUniQuery;
begin
  If qryNFCe.IsEmpty Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    qryAux.ParamByName('CODCLI').AsString := qryNFCe.FieldByName('CODCLI').AsString;
    qryAux.Open;

    If Pos('CONSUMIDOR', AnsiUpperCase(qryAux.FieldByName('CLI_NOMCLI').AsString)) > 0 Then
      btnAjustarConsumidor.Visible := True
    Else
      btnAjustarConsumidor.Visible := False;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmRcxNFCePendentes.pAtualizar;
begin
  qryNFCe.DisableControls;
  Try
    pCarregaNFCePendente(qryNFCe, intTempoEmSegundosPendente, strLisAutInc);
    strLisAutInc := '';
    qryNFCe.First;
    While Not qryNFCe.Eof Do
    Begin
      pIncrementaListaStr(qryNFCe.FieldByName('AUTINC').AsString, strLisAutInc, True);
      qryNFCe.Next;
    End;
  Finally
    qryNFCe.First;
    qryNFCe.EnableControls;
  End;
  
  If Not frmRcxNFCePendentes.qryNFCe.IsEmpty Then
  Begin
    TFLoatField(frmRcxNFCePendentes.qryNFCe.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
  End
  Else
  Begin
    pMensagemOk('Não há nenhum ' + strNome + IIF(intTempoEmSegundosPendente > 0,' pendente a mais de '+IntToStr(intTempoEmSegundosPendente)+' segundos.',' pendente.'));
    blnFecharFormPai := True;
  End;
end;

procedure TfrmRcxNFCePendentes.pReenviarDocumento;
  Var
    strNomeTrava : String;
    strMensagemSemSerie : String;
begin
  If (Not fNFCePendente(qryNFCe.FieldByName('NUMDOC').AsString,
                        qryNFCe.FieldByName('CODEMP').AsString,
                        qryNFCe.FieldByName('CODCLI').AsString,
                        qryNFCe.FieldByName('TABELA').AsString)) Then
  Begin
    pAtualizar;
    Exit;
  End;

  strNomeTrava := 'REENVIO_F8_' + qryNFCe.FieldByName('NUMDOC').AsString + qryNFCe.FieldByName('ESPDOC').AsString + qryNFCe.FieldByName('CODEMP').AsString;

  If fLock_Unlock(strNomeTrava, True, False, False, '', False) Then
  Begin
    Try
      Screen.Cursor := crHourGlass;

      If fUsaIntegradorSatCitel Then
      Begin
        If (fEmptyStr(VS_NumSerSat)) Then
        Begin
          strMensagemSemSerie := EmptyStr;
          strMensagemSemSerie := strMensagemSemSerie + 'O número de série do SAT está vazio.' + sLineBreak;
          strMensagemSemSerie := strMensagemSemSerie + 'Verifique o arquivo "opcoes_sat.ini"' + sLineBreak;

          If (Not fEmptyStr(fCfgSis('PATSAT'))) Then
            strMensagemSemSerie := strMensagemSemSerie + 'Esse arquivo pode ser encontrado no seguinte caminho (CFG_PATSAT): ' + fCfgSis('PATSAT')
          Else
            strMensagemSemSerie := strMensagemSemSerie + 'O caminho para o arquivo "opcoes_sat.ini" está vazio (CFG_PATSAT)';

          fMensagem('AVISO', strMensagemSemSerie, ['&OK']);
          Exit;
        End;

        If not fReenviarLogSat(qryNFCe.FieldByName('NUMDOC').AsString,
                               qryNFCe.FieldByName('ESPDOC').AsString,
                               qryNFCe.FieldByName('CODEMP').AsString,
                               qryNFCe.FieldByName('SERIE_').AsString,
                               qryNFCe.FieldByName('CODCLI').AsString,
                               qryNFCe.FieldByName('TIP_FC').AsString,
                               'EV', VS_NumSerSat, '', VS_ImpressoraSat) Then
        Begin
          fMensagem('AVISO', 'Ocorreu um problema com a tabela LOGSAT !', ['&OK']);
        End;
        Exit ;
      End;

      If fEnviarNFCeLibNfe(qryNFCe.FieldByName('NUMDOC').AsString,
                           qryNFCe.FieldByName('ESPDOC').AsString,
                           qryNFCe.FieldByName('CODEMP').AsString,
                           qryNFCe.FieldByName('SERIE_').AsString,
                           qryNFCe.FieldByName('CODCLI').AsString,
                           qryNFCe.FieldByName('TIP_FC').AsString) Then
      Begin
        If qryNFCe.FieldByName('STATUS').AsString = 'OF' Then
          fMensagem('AVISO', 'NFCe Off-Line enviada com sucesso!', ['&OK'])
        Else
          pImprimirNFCe(qryNFCe.FieldByName('NUMDOC').AsString,
                        qryNFCe.FieldByName('ESPDOC').AsString,
                        qryNFCe.FieldByName('CODEMP').AsString,
                        qryNFCe.FieldByName('CODCLI').AsString,
                        qryNFCe.FieldByName('SERIE_').AsString,
                        qryNFCe.FieldByName('TIP_FC').AsString,
                        '',
                        (qryNFCe.FieldByName('TABELA').AsString='CADFIS'));
      End;
    Finally
      fLock_Unlock(strNomeTrava, False, False, False, '', False);
      pAtualizar;
      Screen.Cursor := crDefault;
    End;
  End
  Else
    fMensagem('', 'Há outra estação reenviando esse documento no momento!', ['&OK']);
end;

procedure TfrmRcxNFCePendentes.qryNFCeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pVerificaConsumidor;
end;

end.
