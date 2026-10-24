unit untTrocaVendedorTemp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, frxClass,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai,
  Vcl.ExtCtrls, Uni, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  MaskEditFocus, UniClientDataSet, cxProgressBar;

type
  TRestricaoProc = (rpSubVendTemp, rpNaoAltVendTemp, rpCancProcessamento);

  TResultProcVendedor = Record
    intQtdRegInc: Integer;
    intQtdRegExc: Integer;
    blnProcCanc : Boolean;
  End;

  TfrmAltVendTemp = class(TfrmPai)
    lblVenAtu: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lblVenTemp: TLabel;
    edtCodVenTemp: TEditFocus;
    edtDesVenTemp: TEditFocus;
    lblPeriodoVig: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblAte: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnConfirma: TBitBtnLocked;
    rdgVenTempJaExiste: TRadioGroup;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodVenTempKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;

    procedure pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
    procedure pLimparTela;
    procedure pProcessarVendTemporario;
    function  fProcessarVendTemporario(pgbProgresso: TcxProgressBar): Boolean;
    function  fHaRegistrosVendedorAtual(strCodVen: String): Boolean;

    class function fGetSQLConsultaClientes: String;
    class function fGetSQLCliVen: String;
    class function fGetSQLConsultaClientVendTempJaInformado(blnContagem, blnRemoverExpirados: Boolean): String;
    class function fGetSQLConsultaClientVendTempExpirados: String;
    class function fGetSQLExcluirCliVen: String;
  public
    { Public declarations }

    class function fAdicionarVendedorTemporario(dteDtaIni, dteDtaFim: TDateTime; strCodVen, strCodVenTemp: String; rpRestricao: TRestricaoProc): TResultProcVendedor;
    class function fRemoverVendedorTemporario(blnRemoverExpirados: Boolean; dteDtaIni, dteDtaFim: TDateTime; strCodVen: String): TResultProcVendedor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untConsultas, untfuncoesSimples, untPesqAux, untTypesSistema,
     Data.DB, untGravando;

{$R *.dfm}

procedure TfrmAltVendTemp.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos()) Then
  Begin
    If (Not fHaRegistrosVendedorAtual(edtCodVen.Text)) Then
    Begin
      fMensagem('ALERTA', 'Não há clientes com o vendedor informado. Operação cancelada!', ['&OK']);
      pLimparTela();
    End
    Else
    Begin
      pProcessarVendTemporario();
    End;
  End;
end;

procedure TfrmAltVendTemp.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtDesVen, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVendTemp.edtCodVenTempKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVenTemp, edtDesVenTemp, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

class function TfrmAltVendTemp.fAdicionarVendedorTemporario(dteDtaIni, dteDtaFim: TDateTime;
  strCodVen, strCodVenTemp: String; rpRestricao: TRestricaoProc): TResultProcVendedor;
  Var
    blnTransacao: Boolean;
    recResultExc: TResultProcVendedor;
    qryClientes, qryCliVen, qryTemp: TUniQuery;

  procedure pConsultarClientes;
  begin
    qryClientes := fCriaQuery(nil);
    qryClientes.Close();
    qryClientes.SQL.Clear();
    qryClientes.SQL.Text := fGetSQLConsultaClientes();
    qryClientes.ParamByName('CODVEN').AsString := strCodVen;
    qryClientes.Open();
    qryClientes.First();
  end;

  procedure pInicializarQryCliVen();
  begin
    If (Not Assigned(qryCliVen)) Then
      qryCliVen := fCriaQuery(nil);

    qryCliVen.Close();
    qryCliVen.SQL.Clear();
    qryCliVen.SQL.Text := fGetSQLCliVen();
  end;

  procedure pAdicionarRegistro;
  begin
    qryCliVen.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CLIVEN', VS_strCodEmp);
    qryCliVen.ParamByName('CODCLI').AsString   := qryClientes.FieldByName('CLI_CODCLI').AsString;
    qryCliVen.ParamByName('CODMAR').Clear();
    qryCliVen.ParamByName('CODFOR').Clear();
    qryCliVen.ParamByName('CODVEN').AsString   := strCodVenTemp;
    qryCliVen.ParamByName('DTVGIN').AsDateTime := Trunc(dteDtaIni);
    qryCliVen.ParamByName('DTVGFN').AsDateTime := Trunc(dteDtaFim);
    qryCliVen.ExecSQL();

    Inc(Result.intQtdRegInc);
  end;

  function fPossuiClienteVendTempJaInformado: Integer;
  begin
    If (Not Assigned(qryTemp)) Then
      qryTemp := fCriaQuery(nil);

    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := fGetSQLConsultaClientVendTempJaInformado(True, True);
    qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(dteDtaIni);
    qryTemp.ParamByName('DTAFIM').AsDateTime := Trunc(dteDtaFim);
    qryTemp.ParamByName('CODVEN').AsString   := strCodVen;
    qryTemp.Open();

    Result := qryTemp.FieldByName('QTDE').AsInteger;

    If (Result > 0) Then
    Begin
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := fGetSQLConsultaClientVendTempJaInformado(False, True);
      qryTemp.ParamByName('DTAINI').AsDateTime := Trunc(dteDtaIni);
      qryTemp.ParamByName('DTAFIM').AsDateTime := Trunc(dteDtaFim);
      qryTemp.ParamByName('CODVEN').AsString   := strCodVen;
      qryTemp.Open();
    End
    Else
    Begin
      qryTemp.Close();
    End;
  end;

  procedure pAtualizarResult;
  begin
    Result.intQtdRegInc := recResultExc.intQtdRegInc;
    Result.intQtdRegExc := recResultExc.intQtdRegExc;
    Result.blnProcCanc  := recResultExc.blnProcCanc;
  end;

begin
  Result.intQtdRegInc := 0;
  Result.intQtdRegExc := 0;
  Result.blnProcCanc  := False;

  blnTransacao := fInTransaction();

  Try
    qryTemp     := nil;
    qryCliVen   := nil;
    qryClientes := nil;

    Try
      Result.blnProcCanc := (fPossuiClienteVendTempJaInformado() > 0) And (rpRestricao = rpCancProcessamento);

      If (Result.blnProcCanc) Then
        Exit;

      If (Not blnTransacao) Then
        fStartTransaction();

      If (rpRestricao = rpSubVendTemp) Then
      Begin
        recResultExc := fRemoverVendedorTemporario(False, dteDtaIni, dteDtaFim, strCodVen);
        pAtualizarResult();
      End;

      pConsultarClientes();

      While (Not qryClientes.Eof) Do
      Begin
        If (rpRestricao = rpNaoAltVendTemp) And
           (qryTemp.Active) And
           (qryTemp.Locate('CVE_CODCLI', qryClientes.FieldByName('CLI_CODCLI').AsString, [])) Then
        Begin
          qryClientes.Next();
          Continue;
        End;

        pInicializarQryCliVen();
        pAdicionarRegistro();

        qryClientes.Next();
      End;

      If (Not blnTransacao) Then
        fCommit();
    Except
      On E: Exception Do
      Begin
        fRollback();
        Result.intQtdRegInc := 0;
				pMensagensErro(E.Message,'[TfrmAltVendTemp.fAdicionarVendedorTemporario]');
      End;
    End;
  Finally
    FreeAndNil(qryCliVen);
    FreeAndNil(qryClientes);
  End;
end;

class function TfrmAltVendTemp.fGetSQLCliVen: String;
begin
  Result := 'INSERT INTO CLIVEN (AUTOINCREM, CVE_CODCLI, CVE_CODMAR, CVE_CODVEN, CVE_DTVGIN, CVE_DTVGFN, CVE_CODFOR) ' +
    'VALUES (:AUTINC, :CODCLI, :CODMAR, :CODVEN, :DTVGIN, :DTVGFN, :CODFOR)';
end;

class function TfrmAltVendTemp.fGetSQLConsultaClientes: String;
begin
  Result := 'SELECT CLI_CODCLI, CLI_CODVEN FROM CADCLI WHERE CLI_CODVEN = :CODVEN AND CLI_STATUS <> "I"';
end;

class function TfrmAltVendTemp.fGetSQLConsultaClientVendTempExpirados: String;
begin
  Result := 'SELECT AUTOINCREM FROM CLIVEN WHERE CVE_DTVGFN <= :DTAFIM';
end;

class function TfrmAltVendTemp.fGetSQLConsultaClientVendTempJaInformado(blnContagem, blnRemoverExpirados: Boolean): String;

  function fRetornarCamposConsulta: String;
  begin
    If (blnContagem) Then
      Result := '  COUNT(DISTINCT CADCLI.CLI_CODCLI) AS QTDE '
    Else
      Result := '  DISTINCT CLIVEN.AUTOINCREM, CLIVEN.CVE_CODCLI ';
  end;

begin
  Result := 'SELECT ' +
              fRetornarCamposConsulta() +
            'FROM ' +
            '  CADCLI INNER JOIN CLIVEN ON CLI_CODCLI = CVE_CODCLI ' +
            'WHERE ( ' +
            '    ( ' +
            '      CVE_DTVGIN >= :DTAINI ' +
            '      AND CVE_DTVGIN <= :DTAFIM ' +
            '    ) ' +
            '    OR ( ' +
            '      CVE_DTVGFN >= :DTAINI ' +
            '      AND CVE_DTVGFN <= :DTAFIM ' +
            '    ) ' +
            '    OR ( ' +
            '      CVE_DTVGIN <= :DTAINI ' +
            '      AND CVE_DTVGFN >= :DTAFIM ' +
            '    ) ' +
            '  ) ';

  If (blnRemoverExpirados) Then
    Result := Result + ' AND CADCLI.CLI_CODVEN = :CODVEN ';
end;

class function TfrmAltVendTemp.fGetSQLExcluirCliVen: String;
begin
  Result := 'DELETE FROM CLIVEN WHERE AUTOINCREM = :AUTINC';
end;

function TfrmAltVendTemp.fHaRegistrosVendedorAtual(strCodVen: String): Boolean;
begin
  Result := (fCampoTabela('COUNT(CLI_CODCLI)',
                          'CADCLI',
                          ['CLI_CODVEN', 'CLI_STATUS'],
                          [edtCodVen.Text, 'A']) > 0);
end;

procedure TfrmAltVendTemp.FormCreate(Sender: TObject);
begin
  inherited;

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmAltVendTemp.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryConOpe);
end;

procedure TfrmAltVendTemp.FormShow(Sender: TObject);
begin
  inherited;

  pLimparTela();
end;

function TfrmAltVendTemp.fProcessarVendTemporario(pgbProgresso: TcxProgressBar): Boolean;
  Var
    recResultProc: TResultProcVendedor;
begin
  Result := True;

  recResultProc := TfrmAltVendTemp.fAdicionarVendedorTemporario(StrToDate(mskDtaIni.Text),
                                                                StrToDate(mskDtaFin.Text),
                                                                edtCodVen.Text,
                                                                edtCodVenTemp.Text,
                                                                TRestricaoProc(rdgVenTempJaExiste.ItemIndex));

  If (recResultProc.blnProcCanc) Then
  Begin
    fMensagem('ALERTA', 'Existem clientes que já possuem um vendedor temporário para o período informado. Processamento cancelado!', ['&OK']);
  End
  Else
  Begin
    Result := (recResultProc.intQtdRegInc > 0) Or (recResultProc.intQtdRegExc > 0);

    If (Result) Then
      fMensagem('INFORMAÇÃO', 'Registros inseridos: ' + IntToStr(recResultProc.intQtdRegInc) + '.' + #13#10 +
                              'Registros excluídos: ' + IntToStr(recResultProc.intQtdRegExc) + '.' + #13#10 +
                              'Processamento finalizado.', ['&OK'])
    Else
      fMensagem('INFORMAÇÃO', 'Processamento finalizado.', ['&OK']);
  End;

  pLimparTela();
end;

class function TfrmAltVendTemp.fRemoverVendedorTemporario(blnRemoverExpirados: Boolean; dteDtaIni, dteDtaFim: TDateTime; strCodVen: String): TResultProcVendedor;
  Var
    blnTransacao: Boolean;
    qryListagem, qryTemp: TUniQuery;

  procedure pListarRegistrosExclusao;
  begin
    qryListagem.Close();
    qryListagem.SQL.Clear();

    If (blnRemoverExpirados) Then
      qryListagem.SQL.Text := fGetSQLConsultaClientVendTempExpirados()
    Else
    Begin
      qryListagem.SQL.Text := fGetSQLConsultaClientVendTempJaInformado(False, Not blnRemoverExpirados);
      qryListagem.ParamByName('DTAINI').AsDateTime := Trunc(dteDtaIni);

      If (Not blnRemoverExpirados) Then
        qryListagem.ParamByName('CODVEN').AsString := strCodVen;
    End;

    qryListagem.ParamByName('DTAFIM').AsDateTime := Trunc(dteDtaFim);
    qryListagem.Open();
    qryListagem.First();
  end;

  procedure pExcluirRegistroCliVen;
  begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := fGetSQLExcluirCliVen();
    qryTemp.ParamByName('AUTINC').AsString := qryListagem.FieldByName('AUTOINCREM').AsString;
    qryTemp.ExecSQL();

    Inc(Result.intQtdRegExc);
  end;

begin
  Result.intQtdRegInc := 0;
  Result.intQtdRegExc := 0;
  Result.blnProcCanc := False;

  blnTransacao := fInTransaction();

  Try
    qryTemp     := fCriaQuery(nil);
    qryListagem := fCriaQuery(nil);

    Try
      If (Not blnTransacao) Then
        fStartTransaction();

      pListarRegistrosExclusao();

      While (Not qryListagem.Eof) Do
      Begin
        pExcluirRegistroCliVen();

        qryListagem.Next();
      End;

      If (Not blnTransacao) Then
        fCommit();

      qryTemp.Close();
    Except
      On E: Exception Do
      Begin
        fRollback();
        Result.intQtdRegInc := 0;
				pMensagensErro(E.Message,'[TfrmAltVendTemp.fRemoverVendedorTemporario]');
      End;
    End;
  Finally
    FreeAndNil(qryListagem);
    FreeAndNil(qryTemp);
  End;
end;

function TfrmAltVendTemp.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
            Result := False;
          End;
        End;
      End
    End;
  End

  Else If (Sender = edtCodVen) Then
  Begin

    If fEmptyStr(edtCodVen.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Vendedor Atual deve ser informado!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      pCarregaVendedor(edtCodVen, edtDesVen);

      If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodVenTemp) Then
  Begin

    If fEmptyStr(edtCodVenTemp.Text) Then
    Begin
      fMensagem('','O Vendedor Temporário deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      If (Not fEmptyStr(edtCodVen.Text))     And
         (Not fEmptyStr(edtCodVenTemp.Text)) And
         (SameText(edtCodVen.Text, edtCodVenTemp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Vendedor Temporário deve ser diferente do Vendedor Atual!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor(edtCodVenTemp, edtDesVenTemp);

        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltVendTemp.pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodigo.Text);

  edtNome.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmAltVendTemp.pLimparTela;
begin
  mskDtaIni.Text     := '  /  /    ';
  mskDtaFin.Text     := '  /  /    ';
  edtCodVen.Text     := '';
  edtCodVenTemp.Text := '';
  edtDesVen.Text     := '';
  edtDesVenTemp.Text := '';
  rdgVenTempJaExiste.ItemIndex := 2;

  pSetFocus(mskDtaIni);
end;

procedure TfrmAltVendTemp.pProcessarVendTemporario;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Adicionando registro de Vendedor Temporário. Aguarde...';
      frmGravando.fExecutarAcao := fProcessarVendTemporario;
      frmGravando.ShowModal();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAltVendTemp.pProcessarVendTemporario]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

end.
