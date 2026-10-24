unit untPromocaoBrindes;

interface

Uses
  untZClient, CheckLst, Uni, cxProgressBar, SysUtils, strUtils, DB, Forms,
  UniClientDataSet, Controls, StdCtrls, Classes, untFuncFatTypes,
  untFuncoesSimples, untFuncFat;

Type
  TTipoItem = (itemVenda, itemBrinde);

Type
  TPromocaoBrindes = class
  private
    FItens: TZClient;
    FBrindes: TZClient;
    FTabela: TUniQuery;
    FEmpresas: TCheckListBox;
    FTabPreco: TCheckListBox;
    FTipoItem: TTipoItem;
    FCodigoItem: String;

    class function fSqlWhere(strProAtu, strTabPre: String): String;
    class function fGetFiltroTabelaPrecoPromocao(strTabPre: String): String;

    procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
    procedure pStepStatusGravacao(pgbStatus: TcxProgressBar);

    procedure pMarcarEmpresas(strEmpresas: String);
    procedure pMarcarTabelasPreco(strTabelas: String);

    procedure pAfterScroll(Dataset: TDataset);
    procedure pAfterOpen(Dataset: TDataset);

    procedure pCarregaEmpresas;
    procedure pCarregaTabelasPreco;
    procedure pGravarEmpresas;
    procedure pDeletaItensVendaPromocao;
    procedure pDeletaItensBrindePromocao;

    function fGravaItemVendaPromocao(strCodIte: String; fltQtdPon: Double): Boolean;
    function fGravaItemBrindePromocao(strCodBri: String; fltQtdBri: Double): Boolean;

    function fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
    function fGravarPromocaoInterna(pgbStatus: TcxProgressBar): Boolean;

    function fGetEmpresas(strSeqGer: String): String;

    class function fCarregaItemVenda(var qryGen: TUniQuery; strTabDet,
      strTabTri, strNumDoc, strEspDoc, strCodEmp, strSeqDet: String): Boolean;

  public
    class function fItemCadastradoPromocaoBrindes(strProAtu, strCodIte,
      strEmpSel, strTabPre: String; dtaDtaIni, dtaDtaFin: TDateTime;
      Var strPromocoes: String): Boolean; overload;

    class procedure pRetornaQuantidadePontosProdutoVenda(Var itemVen: TDadosFechamento);
    class procedure pRetornaQuantidadePontosProdutoDevolucao(Var itemDev: TDadosFechamento);
    class procedure pRetornaQuantidadePontosProdutoConfirmacao(Var itemConf: TDadosFechamento);
    class procedure pCalculaPontosGeradosVenda(Var arrProdutos: TMatrizFechamento; strOpcDoc: String); overload;
    class procedure pCalculaPontosGeradosVenda(cdsDados: TDataSet; strOpcDoc: String); overload;

    class function fTemPromocaoDeBrindeEmVigencia: Boolean;

    function fItemCadastradoPromocaoBrindes(strCodIte: String; Var strPromocoes: String): Boolean; overload;

    function fCarregaItensBrinde(strCodPro: String = ''): Boolean;
    function fCarregaItensVenda(strCodPro: String = ''): Boolean;

    function fGetEmpresasSelecionadas: String;
    function fGetTabelasPrecoSelecionadas: String;

    function fHerancaPromocao: Boolean;

    procedure pLimparProdutos;
//    procedure pOnBeforeDeletePromocaoBrinde;

    procedure pAdicionaItem(_tipoItem: TTipoItem; _strCodigoItem: String = '');
    procedure pExcluirProdutos(_tipoItem: TTipoItem; _strCodigoItem: String = '');

    function fGravarPromocao: Boolean;

    constructor Create(clbEmpresas, clbTabelasPreco: TCheckListBox);
    destructor Destroy; override;

    property TipoItem: TTipoItem read FTipoItem write FTipoItem;
    property strCodigoItem: String read FCodigoItem write FCodigoItem;
    property cdsItensVenda: TZClient read FItens Write FItens;
    property cdsItensBrinde: TZClient read FBrindes Write FBrindes;
    property qryTabela: TUniQuery read FTabela Write FTabela;
  end;

Type
  TFatEmitirBrindePromocao = class
    private
      FItens: TZClient;
      FNumDoc: String;
      FEspDoc: String;
      FCodEmp: String;
      FCodCli: String;
      FCodOpe: String;
      FDtaIni: TDateTime;
      FDtaFin: TDateTime;
      FSomPon: Boolean;
      FPromocoes: TUniClientDataSet;
      FBrindes: TUniClientDataSet;
      FDicBrindes: TDicionario;
      FEntRet: String;

      function fGetTotalPontosVendas: Double;
      function fGetTotalPontosSelecionado: Double;

      procedure pAfterScrollPromocoes(DataSet: TDataSet);

      function fEmitirDocumentoBrindeInterna(pgbStatus: TcxprogressBar): Boolean;

      function fCriaQueryItem: TUniQuery;

      function fInserirProduto(fatVenda: TFatVenda; strCodIte: String; fltQtdIte: Double): Boolean;

      function fGravarArquivos(fatVenda: TFatVenda): Boolean;
      procedure pCarregaQueryCadCli(var qryDados: TUniQuery; strCodCli: String);
      procedure pRecarregaDadosCliente(Var fatVenda: TFatVenda);

    public
      blnFatVenda: Boolean;

      constructor Create;
      destructor Destroy; override;

      function fCarregarItensVenda(blnFilFil: Boolean = True; blnApenasPromoVigente: Boolean = False): Boolean;

      procedure pSelecionarItem(strIteSel: String = '');
      procedure pMarcarTodos(strIteSel: String = 'S');

      function fEmitirDocumentoBrinde(pgbStatus: TcxprogressBar): Boolean;

      procedure pSintetizarPromocoesSelecionadas;
      procedure pCarregaBrindesPromocoesSelecionadas;

      procedure pSelecionarBrinde(blnConfirma : Boolean = True);
      procedure pRemoverBrinde(blnConfirma : Boolean = True);
      procedure pSelecionarTodosBrindes;
      procedure pRemoverTodosBrindes;
      class function fClienteTemPontosParaBrindes(strCodCli, strNumDoc, strEspDoc: String;
        Var dtaMinDta, dtaMaxDta: TDateTime; blnApenasPromoVigente: Boolean = False): Boolean;

      property cdsItensVenda: TZClient read FItens Write FItens;
      property cdsPromocoesSel: TUniClientDataSet read FPromocoes Write FPromocoes;
      property cdsBrindesSel: TUniClientDataSet read FBrindes Write FBrindes;

      property strDocumento: String read FNumDoc write FNumDoc;
      property strEspecie: String read FEspDoc write FEspDoc;
      property strEmpresa: String read FCodEmp write FCodEmp;
      property strCliente: String read FCodCli write FCodCli;
      property strOperador: String read FCodOpe write FCodOpe;
      property dtaDataInicial: TDateTime read FDtaIni write FDtaIni;
      property dtaDataFinal: TDateTime read FDtaFin write FDtaFin;
      property blnSomenteComPontos: Boolean read FSomPon write FSomPon;
      property fltTotalPontosVendas: Double read fGetTotalPontosVendas;
      property fltTotalPontosSelecionado: Double read fGetTotalPontosSelecionado;
      property strEntRet: String read FEntRet write FEntRet;
  end;

implementation

uses untCadPromocaoBrindesHeranca, untTypesSistema,
  untObservacao, untCadPromocaoBrindesFiltro, untConstantes, untGravando,
  untFatPromocaoBrindesResumo, untFuncoes, untTConfiguracao,
  untParCalculaPrecoCusto, untCadPro;

constructor TPromocaoBrindes.Create(clbEmpresas, clbTabelasPreco: TCheckListBox);
begin
  FTabela    := fCriarQuery('SELECT * FROM PROBRI_GER WHERE FALSE');
  FItens     := TZClient.Create(nil);
  FBrindes   := TZClient.Create(nil);
  FEmpresas  := clbEmpresas;
  FTabPreco  := clbTabelasPreco;

  FTabela.AfterScroll := pAfterScroll;
  FTabela.AfterOpen   := pAfterOpen;
  FTipoItem           := itemVenda;
  FCodigoItem         := '';

  pCarregaEmpresas;
  pCarregaTabelasPreco;
end;

destructor TPromocaoBrindes.Destroy;
begin
  FreeAndNil(FTabela);
  FreeAndNil(FItens);
  FreeAndNil(FBrindes);
  inherited Destroy;
end;

function TPromocaoBrindes.fGetEmpresasSelecionadas: String;
Var
  intContador: Integer;
begin
  Result := '';
  For intContador := 0 To FEmpresas.Items.Count - 1 Do
  Begin
    If FEmpresas.Checked[intContador] Then
      Result := Result + LeftStr(FEmpresas.Items[intContador], 3) + '_';
  End;
end;

function TPromocaoBrindes.fGetTabelasPrecoSelecionadas: String;
Var
  intTabPre: Integer;
begin
  Result := '';
  For intTabPre := 1 To FTabPreco.Items.Count Do
    Result := Result + IIF(FTabPreco.Checked[intTabPre - 1], 'S', 'N');
end;

procedure TPromocaoBrindes.pLimparProdutos;
begin
  If FItens.Active Then FItens.EmptyDataSet;
  If FBrindes.Active Then FBrindes.EmptyDataSet;
end;

function TPromocaoBrindes.fCarregaItensVenda(strCodPro: String = ''): Boolean;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PRO_CODITE AS CODITE, ';
  strSQL := strSQL + '  ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  PRO_QTDPON AS QTDPON  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER  ';
  strSQL := strSQL + '  INNER JOIN PROBRI_ITE ON PRO_SEQGER = PROBRI_GER.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN CADITE     ON ITE_CODITE = PRO_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADUNI     ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_CODPRO = :CODPRO ';

  If fEmptyStr(strCodPro) Then
    strCodPro := qryTabela.FieldByName('PRO_CODPRO').AsString;

  With FItens.qryQuery, SQL Do
  Begin
    FItens.Close;

    Close;
    Clear;

    Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;

    FItens.pSetProvider;

    Open;

    pSetaClient(FItens.qryQuery);

    FItens.Open;

    Result := Not IsEmpty;
  End;

  TFloatField(FItens.FieldByName('QTDPON')).DisplayFormat := '#,##0.00';
end;

function TPromocaoBrindes.fCarregaItensBrinde(strCodPro: String = ''): Boolean;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PRO_CODBRI AS CODBRI, ';
  strSQL := strSQL + '  ITE_DESITE AS DESBRI, ';
  strSQL := strSQL + '  ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  PRO_QTDBRI AS QTDBRI  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER  ';
  strSQL := strSQL + '  INNER JOIN PROBRI_BRI ON PRO_SEQGER = PROBRI_GER.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN CADITE     ON ITE_CODITE = PRO_CODBRI ';
  strSQL := strSQL + '  INNER JOIN CADUNI     ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_CODPRO = :CODPRO ';

  If fEmptyStr(strCodPro) Then
    strCodPro := qryTabela.FieldByName('PRO_CODPRO').AsString;

  With FBrindes.qryQuery, SQL Do
  Begin
    FBrindes.Close;

    Close;
    Clear;

    Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;

    FBrindes.pSetProvider;

    Open;

    pSetaClient(FBrindes.qryQuery);

    FBrindes.Open;

    Result := Not IsEmpty;
  End;

  TFloatField(FBrindes.FieldByName('QTDBRI')).DisplayFormat := '#,##0.00';
end;

procedure TPromocaoBrindes.pInfoStatusGravacao(pgbStatus: TcxProgressBar;
  strInformacao: String; intMax: Integer = 0);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;
    Application.ProcessMessages;
  End;
end;

procedure TPromocaoBrindes.pStepStatusGravacao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TPromocaoBrindes.fGravarPromocao: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravarPromocaoInterna;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmGravando);
end;

function TPromocaoBrindes.fGravarPromocaoInterna(pgbStatus: TcxProgressBar): Boolean;
  Var
    strPromocoes: String;
    strMsg: String;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

  Result := False;

  If fEmptyStr(fGetEmpresasSelecionadas) Then
  Begin
    fMensagem('', 'Selecione alguma empresa!', ['&OK']);
    Exit;
  End;

  If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
  Begin
    fMensagem('', 'Selecione alguma tabela de preço!', ['&OK']);
    Exit;
  End;

  If (Not FItens.Active) Or (FItens.IsEmpty) Then
  Begin
    fMensagem('', 'Inclua os produtos da Venda!', ['&OK']);
    Exit;
  End;

  If (Not FBrindes.Active) Or (FBrindes.IsEmpty) Then
  Begin
    fMensagem('', 'Inclua os produtos para Brinde!', ['&OK']);
    Exit;
  End;

  If (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 2) Then
    Exit;


  Try
    FItens.DisableControls;
    FBrindes.DisableControls;

    Try
      strMsg := '';

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Validando Itens...', FItens.RecordCount);

      FItens.First;

      While Not FItens.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        If fItemCadastradoPromocaoBrindes(FItens.FieldByName('CODITE').AsString, strPromocoes) Then
        Begin
          If Pos(FItens.FieldByName('CODITE').AsString, strMsg) <= 0 Then
            strMsg := FItens.FieldByName('CODITE').AsString + '  -  ' +
                      FItens.FieldByName('DESITE').AsString + #13#10 + strMsg;
        End;

        FItens.Next;
      End;

      FItens.First;

      If Not fEmptyStr(strMsg) Then
      Begin
        Result := False;

        Try
          pCriarFormularios(TfrmObservacao, frmObservacao);

          frmObservacao.lblMensagem.Caption := 'Promoção não incluída! O(s) item(s) abaixo já estão em outras promoções vigentes:';
          frmObservacao.memObs.Texto := strMsg;

          frmObservacao.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmuntCadPromocaoBrindes.btnGravarClick]');
          End;
        End;

        pFreeAndNil(frmObservacao);

        Exit;
      End;

      { ******************************** }
      { * COMEÇA A GRAVAR AS PROMOÇÕES * }
      { *****************************LU* }
      fStartTransaction;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

      If qryTabela.State = dsInsert Then
      Begin
        qryTabela.FieldByName('PRO_CODPRO').AsString := fAtualizaProCod('PROBRI_GER', 'PRO_CODPRO');
        qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PROBRI_GER', VS_strCodEmp);
      End;

      qryTabela.FieldByName('PRO_TABPRE').AsString   := fGetTabelasPrecoSelecionadas;

      qryTabela.Post;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Deletando Itens de Venda da Promoção...');

      pDeletaItensVendaPromocao;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Itens de Venda da Promoção...', FItens.RecordCount);

      FItens.First;

      While Not FItens.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        Result := fGravaItemVendaPromocao(FItens.FieldByName('CODITE').AsString,
                                          FItens.FieldByName('QTDPON').AsFloat);
        If (Not Result) Then
        Begin
          fRollBack;
          fMensagem('', 'Ocorreu um erro na gravação dos itens de Venda!', ['&OK']);
          Exit;
        End;

        FItens.Next;
      End;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Deletando Itens de Brinde da Promoção...');

      pDeletaItensBrindePromocao;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Itens de Brinde da Promoção...', FBrindes.RecordCount);

      FBrindes.First;

      While Not FBrindes.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        Result := fGravaItemBrindePromocao(FBrindes.FieldByName('CODBRI').AsString,
                                           FBrindes.FieldByName('QTDBRI').AsFloat);
        If (Not Result) Then
        Begin
          fRollBack;
          fMensagem('', 'Ocorreu um erro na gravação dos itens de Brinde!', ['&OK']);
          Exit;
        End;

        FBrindes.Next;
      End;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Empresas...');
      pGravarEmpresas;

      fCommit;

      pInfoStatusGravacao(pgbStatus, 'Gravação da Promoção Concluída...');

    Except
      On E: EUniError Do
      Begin
        Result := False;
        fRollBack;

        If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
          pMensagensErro(E.Message,'Já existe um registro com esses Dados!', '[ Gravar registro ]')
        Else
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;

      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FItens.EnableControls;
    FBrindes.EnableControls;
  End;
end;

class function TPromocaoBrindes.fGetFiltroTabelaPrecoPromocao(strTabPre: String): String;
begin
  Result := untCadPro.fGetFiltroTabelaPrecoPromocao(strTabPre);
end;

class function TPromocaoBrindes.fSqlWhere(strProAtu, strTabPre: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  PRO_CODITE = :CODITE AND ';
  strSQL := strSQL + '  LOCATE(E.PRO_CODEMP,:CODEMP) > 0 AND ';
  strSQL := strSQL + '  ( ';
  strSQL := strSQL + '    :DTAINI BETWEEN PRO_DTAINI AND PRO_DTAFIN OR ';
  strSQL := strSQL + '    :DTAFIN BETWEEN PRO_DTAINI AND PRO_DTAFIN    ';
  strSQL := strSQL + '  )  ';

  If (Not fEmptyStr(strProAtu)) Then
    strSQL := strSQL + '  AND PRO_CODPRO <> :CODPRO ';

  strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre);

  Result := strSQL;
End;

class function TPromocaoBrindes.fTemPromocaoDeBrindeEmVigencia: Boolean;
  Var
    qryGenPro: TUniQuery;
begin
  qryGenPro := fCriaQuery(nil);
  Try
    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) AS CNT ');
      SQL.Add('   FROM PROBRI_GER P ');
      SQL.Add('   JOIN PROBRI_EMP E ON P.AUTOINCREM = E.PRO_SEQGER ');
      SQL.Add('  WHERE PRO_CODEMP = ' + QuotedStr(VS_strCodEmp));
      SQL.Add('    AND :DTAINI BETWEEN PRO_DTAINI AND PRO_DTAFIN ');
      ParamByName('DTAINI').AsDate := VS_Date;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryGenPro);
  End;
end;

function TPromocaoBrindes.fItemCadastradoPromocaoBrindes(strCodIte: String; Var strPromocoes: String): Boolean;
begin
  Result := fItemCadastradoPromocaoBrindes(qryTabela.FieldByName('PRO_CODPRO').AsString,
    strCodIte, fGetEmpresasSelecionadas, fGetTabelasPrecoSelecionadas, qryTabela.FieldByName('PRO_DTAINI').AsDateTime,
    qryTabela.FieldByName('PRO_DTAFIN').AsDateTime, strPromocoes);
end;

class function TPromocaoBrindes.fItemCadastradoPromocaoBrindes(strProAtu,
  strCodIte, strEmpSel, strTabPre: String; dtaDtaIni, dtaDtaFin: TDateTime;
  Var strPromocoes: String): Boolean;
Var
  strSQL: String;
  qryGenPro: TUniQuery;
begin
  qryGenPro := fCriaQuery(nil);

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DISTINCT PRO_CODPRO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER P ';
  strSQL := strSQL + '  INNER JOIN PROBRI_ITE I ON P.AUTOINCREM = I.PRO_SEQGER ';
  strSQL := strSQL + '  INNER JOIN PROBRI_EMP E ON P.AUTOINCREM = E.PRO_SEQGER  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + fSqlWhere(strProAtu, strTabPre);

  With qryGenPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('DTAINI').AsDate   := dtaDtaIni;
    ParamByName('DTAFIN').AsDate   := dtaDtaFin;
    ParamByName('CODEMP').AsString := strEmpSel;

    If (Not fEmptyStr(strProAtu)) Then
      ParamByName('CODPRO').AsString := strProAtu;

    Open;

    strPromocoes := '';

    If (RecordCount > 0) Then
    Begin
      Repeat
        strPromocoes := strPromocoes + FieldByName('PRO_CODPRO').AsString + ', ';
        Next;
      Until Eof;
      strPromocoes := 'Promoção: ' + copy(strPromocoes, 1, Length(strPromocoes) - 2);
    End;

    Result := (RecordCount > 0);
    Close;
  End;

  FreeAndNil(qryGenPro);
end;

procedure TPromocaoBrindes.pMarcarEmpresas(strEmpresas: String);
Var
  intContador: Integer;
begin
  For intContador := 0 To FEmpresas.Items.Count - 1 Do
  Begin
    If Pos(LeftStr(FEmpresas.Items[intContador], 3), strEmpresas) > 0 Then
      FEmpresas.Checked[intContador] := True
    Else
      FEmpresas.Checked[intContador] := False;
  End;
end;

procedure TPromocaoBrindes.pMarcarTabelasPreco(strTabelas: String);
Var
  intTabPre: Integer;
begin
  strTabelas := fPadR(strTabelas, FTabPreco.Items.Count, 'N'); // 'NNNNNNN'
  For intTabPre := 1 To FTabPreco.Items.Count Do
    FTabPreco.Checked[intTabPre - 1] := (strTabelas[intTabPre] = 'S') And (VS_strTabVen[intTabPre] = 'S');
end;

{procedure TPromocaoBrindes.pOnBeforeDeletePromocaoBrinde;
  Const
    ARR_TABELAS_AUX: Array[1..3] Of String = ('PROBRI_EMP', 'PROBRI_ITE', 'PROBRI_BRI');
  Var
    qryGen: TUniQuery;
    strTab: String;
begin
  qryGen := fCriaQuery;

  For strTab In ARR_TABELAS_AUX Do
  Begin
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM ' + strTab + ' WHERE PRO_SEQGER = :SEQGER');
    qryGen.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryGen.Open;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      fExecutaSQL(fVerificaIntegridade('TPromocaoBrindes', strTab, qryGen, False));
      qryGen.Next;
    End;
    qryGen.First;
  End;

  FreeAndNil(qryGen);
end;}

procedure TPromocaoBrindes.pAfterOpen(Dataset: TDataset);
begin
  With Dataset do
  begin
    If Active then
    begin
      If FindField('PRO_DTAINI') <> nil Then
        TDateField(FieldByName('PRO_DTAINI')).EditMask := '99/99/9999';

      If FindField('PRO_DTAFIN') <> nil Then
        TDateField(FieldByName('PRO_DTAFIN')).EditMask := '99/99/9999';

      If FindField('PRO_PONACU') <> nil Then
        TFloatField(FieldByName('PRO_PONACU')).DisplayFormat := '#,##0.00';
    end;
  end;
end;

function TPromocaoBrindes.fGetEmpresas(strSeqGer: String): String;
begin
  Result := fCampoTabela('GROUP_CONCAT(PRO_CODEMP)', 'PROBRI_EMP', ['PRO_SEQGER'], [strSeqGer]);
end;

procedure TPromocaoBrindes.pAfterScroll(Dataset: TDataset);
  Var
    intContador: Integer;
begin
  pMarcarEmpresas(fGetEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString));
  pMarcarTabelasPreco(qryTabela.FieldByName('PRO_TABPRE').AsString);

  fCarregaItensVenda;
  fCarregaItensBrinde;

  If qryTabela.State = dsInsert Then
  Begin
    For intContador := 0 To FEmpresas.Items.Count - 1 Do
      FEmpresas.Checked[intContador] := True;

    pMarcarTabelasPreco('SSSSSSS');
    pLimparProdutos;
  End;
end;

class procedure TPromocaoBrindes.pRetornaQuantidadePontosProdutoVenda(Var itemVen: TDadosFechamento);
  Var
    strSQL: String;
    qryGenPro: TUniQuery;
begin
  qryGenPro := fCriaQuery(nil);

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PRO_CODPRO, PRO_QTDPON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER P ';
  strSQL := strSQL + '  INNER JOIN PROBRI_ITE I ON P.AUTOINCREM = I.PRO_SEQGER ';
  strSQL := strSQL + '  INNER JOIN PROBRI_EMP E ON P.AUTOINCREM = E.PRO_SEQGER  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + fSqlWhere('', itemVen.strTabPre);

  With qryGenPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODITE').AsString := itemVen.strCodIte;
    ParamByName('DTAINI').AsDate   := VS_Date;
    ParamByName('DTAFIN').AsDate   := VS_Date;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    itemVen.strProBri := '';
    itemVen.fltPonBri := 0.00;

    If Not IsEmpty Then
    Begin
      itemVen.strProBri := FieldByName('PRO_CODPRO').AsString;
      itemVen.fltPonBri := FieldByName('PRO_QTDPON').AsFloat * itemVen.fltQtdIte;
    End;
  End;

  FreeAndNil(qryGenPro);
end;

class function TPromocaoBrindes.fCarregaItemVenda(Var qryGen: TUniQuery;
  strTabDet, strTabTri, strNumDoc, strEspDoc, strCodEmp, strSeqDet: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  T.DET_PROBRI AS CODPRO, ';//Promocao
  strSQL := strSQL + '  T.DET_PONBRI / D.DET_QTDITE AS QTDPON '; //Quantidade de Pontos
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + strTabDet + ' D ';
  strSQL := strSQL + '  INNER JOIN ' + strTabTri + ' T ON T.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  D.DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  D.DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  D.AUTOINCREM = :SEQDET     ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SEQDET').AsString := strSeqDet;

    Open;
  End;

  Result := Not qryGen.IsEmpty;
end;

class procedure TPromocaoBrindes.pRetornaQuantidadePontosProdutoDevolucao(Var itemDev: TDadosFechamento);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);

  With itemDev, qryGen Do
  Begin
    strProBri := '';
    fltPonBri := 0.00;

       //Devolvendo documento da venda
    If fCarregaItemVenda(qryGen, 'MOVDET', 'MOVTRI',
                         strDocDev, strEspDev, strEmpDev, strSeqDet) Or
       //Devolvendo documento confirmado
       fCarregaItemVenda(qryGen, 'NOTDET', 'NOTTRI',
                         strDocDev, strEspDev, strEmpDev, strSeqDet) Then
    Begin
      strProBri := FieldByName('CODPRO').AsString;
      fltPonBri := FieldByName('QTDPON').AsFloat * fltQtdIte;
    End;
  End;

  FreeAndNil(qryGen);
end;

class procedure TPromocaoBrindes.pRetornaQuantidadePontosProdutoConfirmacao(Var itemConf: TDadosFechamento);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);

  With itemConf, qryGen Do
  Begin
    strProBri := '';
    fltPonBri := 0.00;

    If fCarregaItemVenda(qryGen, 'MOVDET', 'MOVTRI',
                         strDocCnf, strEspCnf, strEmpCnf, strSeqDet) Then
    Begin
      strProBri := FieldByName('CODPRO').AsString;
      fltPonBri := FieldByName('QTDPON').AsFloat * fltQtdIte;
    End;
  End;

  FreeAndNil(qryGen);
end;

class procedure TPromocaoBrindes.pCalculaPontosGeradosVenda(Var arrProdutos: TMatrizFechamento; strOpcDoc: String);
  Var
    intItem: Integer;
begin
  If (Pos(strOpcDoc, 'DV_CF_CI_') <= 0) And (Not fTemPromocaoDeBrindeEmVigencia) Then
    Exit;

  For intItem := Low(arrProdutos) To High(arrProdutos) Do
  Begin
    If strOpcDoc = 'DV' Then
      pRetornaQuantidadePontosProdutoDevolucao(arrProdutos[intItem])

    Else If (strOpcDoc = 'CF') Or (strOpcDoc = 'CI') Then
      pRetornaQuantidadePontosProdutoConfirmacao(arrProdutos[intItem])

    Else
      pRetornaQuantidadePontosProdutoVenda(arrProdutos[intItem]);
  End;
end;

class procedure TPromocaoBrindes.pCalculaPontosGeradosVenda(cdsDados: TDataSet;
  strOpcDoc: String);
  Var
    strSQL: String;
    qryGenPro: TUniQuery;
begin
  If cdsDados.IsEmpty Then
    Exit;

  cdsDados.First;
  qryGenPro := fCriaQuery(nil);

  While Not cdsDados.Eof Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_CODPRO, PRO_QTDPON ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROBRI_GER P ';
    strSQL := strSQL + '  INNER JOIN PROBRI_ITE I ON P.AUTOINCREM = I.PRO_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROBRI_EMP E ON P.AUTOINCREM = E.PRO_SEQGER  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere('', cdsDados.FieldByName('ITE_TABPRE').AsString);

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
      ParamByName('DTAINI').AsDate   := VS_Date;
      ParamByName('DTAFIN').AsDate   := VS_Date;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      cdsDados.Edit;

      If Not IsEmpty Then
        cdsDados.FieldByName('ITE_PONBRI').AsFloat := FieldByName('PRO_QTDPON').AsFloat * cdsDados.FieldByName('ITE_QTDITE').AsFloat
      Else
        cdsDados.FieldByName('ITE_PONBRI').AsFloat := 0;

      cdsDados.Post;
    End;

    cdsDados.Next;
  End;

  FreeAndNil(qryGenPro);
end;

procedure TPromocaoBrindes.pCarregaEmpresas;
Var
  qryGen: TUniQuery;
  intContador: Integer;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    FEmpresas.Items.Clear;
    Clear;
    Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
    Open;

    FEmpresas.Columns := RecordCount Div 4;

    First;
    While Not Eof Do
    Begin
      FEmpresas.Items.Add(FieldByName('EMPNOM').AsString);
      Next;
    End;
    Close;
  End;

  { ******************************** }
  { * SELECIONA TODAS AS EMPRESAS  * }
  { *****************************LU* }
  For intContador := 0 To FEmpresas.Items.Count - 1 Do
  Begin
    FEmpresas.Checked[intContador] := True;
  End;

  FreeAndNil(qryGen);
End;

procedure TPromocaoBrindes.pCarregaTabelasPreco;
begin
  FTabPreco.Clear;
  FTabPreco.Items.Add('Tabela 1');
  FTabPreco.Items.Add('Tabela 2');
  FTabPreco.Items.Add('Tabela 3');
  FTabPreco.Items.Add('Tabela 4');
  FTabPreco.Items.Add('Tabela 5');
  FTabPreco.Items.Add('Tabela 6');
  FTabPreco.Items.Add('Tabela 7');
  pMarcarTabelasPreco('SSSSSSS');
end;

function TPromocaoBrindes.fHerancaPromocao: Boolean;
  Var
    qryGenPro: TUniQuery;
    frmCadPromocaoBrindesHeranca : TfrmCadPromocaoBrindesHeranca;
begin
  qryGenPro := fCriaQuery(nil);

  Try
    pCriarFormularios(TfrmCadPromocaoBrindesHeranca, frmCadPromocaoBrindesHeranca);
    frmCadPromocaoBrindesHeranca.qryGenPro := qryGenPro;
    frmCadPromocaoBrindesHeranca.ShowModal;

    Result := frmCadPromocaoBrindesHeranca.blnConfirma;

    If Result Then
    Begin
      qryTabela.FieldByName('PRO_DESPRO').AsString   := qryGenPro.FieldByName('PRO_DESPRO').AsString;
      qryTabela.FieldByName('PRO_TABPRE').AsString   := qryGenPro.FieldByName('PRO_TABPRE').AsString;
      qryTabela.FieldByName('PRO_PONACU').AsFloat    := qryGenPro.FieldByName('PRO_PONACU').AsFloat;
      qryTabela.FieldByName('PRO_DTAINI').AsDateTime := qryGenPro.FieldByName('PRO_DTAINI').AsDateTime;
      qryTabela.FieldByName('PRO_DTAFIN').AsDateTime := qryGenPro.FieldByName('PRO_DTAFIN').AsDateTime;

      pMarcarEmpresas(fGetEmpresas(qryGenPro.FieldByName('AUTOINCREM').AsString));
      pMarcarTabelasPreco(qryGenPro.FieldByName('PRO_TABPRE').AsString);

      fCarregaItensVenda(qryGenPro.FieldByName('PRO_CODPRO').AsString);
      fCarregaItensBrinde(qryGenPro.FieldByName('PRO_CODPRO').AsString);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmuntCadPromocaoBrindes.btnHerancaClick]');
    End;
  End;

  pFreeAndNil(frmCadPromocaoBrindesHeranca);
  FreeAndNil(qryGenPro);
end;

procedure TPromocaoBrindes.pExcluirProdutos(_tipoItem: TTipoItem; _strCodigoItem: String = '');
Begin
  Self.TipoItem := _tipoItem;
  Self.strCodigoItem := _strCodigoItem;

  If (TipoItem = itemVenda) Then
  Begin
    If Not fEmptyStr(Self.strCodigoItem) Then
    Begin
      If FItens.Locate('CODITE', Self.strCodigoItem, []) Then
        FItens.Delete;
    End
    Else
      FItens.EmptyDataSet;

    If Not fEmptyStr(Self.strCodigoItem) Then
      pMensagemOk('Produto (' + Self.strCodigoItem + ') excluído com sucesso!')
    Else
      pMensagemOk('Produtos excluídos com sucesso!');
  End
  Else If (TipoItem = itemBrinde) Then
  Begin
    If Not fEmptyStr(Self.strCodigoItem) Then
    Begin
      If FBrindes.Locate('CODBRI', Self.strCodigoItem, []) Then
        FBrindes.Delete;
    End
    Else
      FBrindes.EmptyDataSet;

    If Not fEmptyStr(Self.strCodigoItem) Then
      pMensagemOk('Brinde (' + Self.strCodigoItem + ') excluído com sucesso!')
    Else
      pMensagemOk('Brindes excluídos com sucesso!');
  End;
End;

procedure TPromocaoBrindes.pAdicionaItem(_tipoItem: TTipoItem; _strCodigoItem: String = '');
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Self.TipoItem := _tipoItem;
    Self.strCodigoItem := _strCodigoItem;
    frmGravando.fExecutarAcao := fAdicionaItem;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);
End;

function TPromocaoBrindes.fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
  Var
    qryGen: TUniQuery;
    cdsItens: TUniClientDataSet;
    strSQL, strMsg, strPromocoes: String;
    frmCadPromocaoBrindesFiltro: TfrmCadPromocaoBrindesFiltro;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...');

  qryGen := fCriaQuery;
  cdsItens := TUniClientDataSet.Create(nil);

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 70;
  End;

  cdsItens.CreateDataSet;

  Try
    FItens.DisableControls;
    FBrindes.DisableControls;

    Try
      pCriarFormularios(TfrmCadPromocaoBrindesFiltro, frmCadPromocaoBrindesFiltro);

      With frmCadPromocaoBrindesFiltro Do
      Begin
        objPromocaoBrindes := Self;

        Result := ShowModal = mrOK;

        If Result Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  ITE_CODITE AS CODITE, ';
          strSQL := strSQL + '  ITE_DESITE AS DESITE, ';
          strSQL := strSQL + '  ITE_REFERE AS REFERE, ';
          strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI  ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADITE  ';
          strSQL := strSQL + '  INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
          strSQL := strSQL + 'WHERE  ';
          strSQL := strSQL + '  TRUE ';

          If (Not fEmptyStr(edtCodIte.Text)) Then
            strSQL := strSQL + '  AND ITE_CODITE = :CODITE  ';

          If Not fEmptyStr(mskLinhaGrupo.Text) Then
          Begin
            If RightStr(mskLinhaGrupo.Text, 3) = '000' Then
              strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
            Else
              strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
          End;

          If Not fEmptyStr(edtFornecedor.Text) Then
            strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

          If Not fEmptyStr(edtMarca.Text) Then
            strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

          If (Not fEmptyStr(edtDescriIni.Text)) And (Not fEmptyStr(edtDescriFin.Text)) Then
            strSQL := strSQL + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

          If Not fEmptyStr(edtRefere.Text) Then
            strSQL := strSQL + '  AND ITE_REFERE = :REFERE ';

          If Not fEmptyStr(edtUnidade.Text) Then
            strSQL := strSQL + '  AND ITE_CODUNI = :CODUNI ';

          If (TipoItem = itemBrinde) Then
            strSQL := strSQL + '  AND ITE_USABON = "S" ';

          strSQL := strSQL + 'ORDER BY ITE_DESITE ';

          With qryGen Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            If (Not fEmptyStr(edtCodIte.Text)) Then
              ParamByName('CODITE').AsString := edtCodIte.Text;

            If Not fEmptyStr(mskLinhaGrupo.Text) Then
              ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

            If Not fEmptyStr(edtFornecedor.Text) Then
              ParamByName('CODFOR').AsString := edtFornecedor.Text;

            If Not fEmptyStr(edtMarca.Text) Then
              ParamByName('CODMAR').AsString := edtMarca.Text;

            If (Not fEmptyStr(edtDescriIni.Text)) And (Not fEmptyStr(edtDescriFin.Text)) Then
            Begin
              ParamByName('MAIOR').AsString   := edtDescriIni.Text;
              ParamByName('DESITE').AsString  := edtDescriIni.Text;
              ParamByName('DESITE1').AsString := edtDescriFin.Text;
            End
            Else
            Begin
              If Not fEmptyStr(edtDescriIni.Text) Then
                ParamByName('DESITE').AsString := edtDescriIni.Text + '%';
            End;

            If Not fEmptyStr(edtRefere.Text) Then
              ParamByName('REFERE').AsString := edtRefere.Text;

            If Not fEmptyStr(edtUnidade.Text) Then
              ParamByName('CODUNI').AsString := edtUnidade.Text;

            Open;

          End;

          Result := False;

          If qryGen.RecordCount = 0 Then
          Begin
            fMensagem('', 'Nenhum Produto foi encontrado!', ['&OK'], 0);
          End
          Else
          Begin
            pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...', qryGen.RecordCount);

            While Not qryGen.Eof Do
            Begin
              pStepStatusGravacao(pgbStatus);

              If (TipoItem = itemVenda) And
                 (fItemCadastradoPromocaoBrindes(qryGen.FieldByName('CODITE').AsString, strPromocoes)) Then
              Begin
                cdsItens.Insert;
                cdsItens.FieldByName('CODITE').AsString := qryGen.FieldByName('CODITE').AsString;
                cdsItens.FieldByName('DESITE').AsString := qryGen.FieldByName('DESITE').AsString;
                cdsItens.Post;
              End
              Else
              Begin
                If (TipoItem = itemVenda) Then
                Begin
                  If FItens.Locate('CODITE', qryGen.FieldByName('CODITE').AsString, []) Then
                    FItens.Edit
                  Else
                    FItens.Append;

                  FItens.FieldByName('CODITE').AsString := qryGen.FieldByName('CODITE').AsString;
                  FItens.FieldByName('DESITE').AsString := qryGen.FieldByName('DESITE').AsString;
                  FItens.FieldByName('REFERE').AsString := qryGen.FieldByName('REFERE').AsString;
                  FItens.FieldByName('SIGUNI').AsString := qryGen.FieldByName('SIGUNI').AsString;
                  FItens.FieldByName('QTDPON').AsFloat  := fStrToFloat(edtQtdPon.Text);
                  FItens.Post;
                End
                Else
                Begin
                  If FBrindes.Locate('CODBRI', qryGen.FieldByName('CODITE').AsString, []) Then
                    FBrindes.Edit
                  Else
                    FBrindes.Append;

                  FBrindes.FieldByName('CODBRI').AsString := qryGen.FieldByName('CODITE').AsString;
                  FBrindes.FieldByName('DESBRI').AsString := qryGen.FieldByName('DESITE').AsString;
                  FBrindes.FieldByName('REFERE').AsString := qryGen.FieldByName('REFERE').AsString;
                  FBrindes.FieldByName('SIGUNI').AsString := qryGen.FieldByName('SIGUNI').AsString;
                  FBrindes.FieldByName('QTDBRI').AsFloat  := fStrToFloat(edtQtdBri.Text);
                  FBrindes.Post;
                End;
                Result := True;
              End;
              qryGen.Next;
            End;
          End;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmCadPromocaoBrindesFiltro);

  Finally
    FItens.EnableControls;
    FBrindes.EnableControls;
  End;

  If (cdsItens.RecordCount > 0) Then
  Begin
    While Not cdsItens.Eof Do
    Begin
      strMsg := cdsItens.FieldByName('CODITE').AsString + '  -  ' +
                cdsItens.FieldByName('DESITE').AsString + #13#10 + strMsg;
      cdsItens.Next;
    End;

    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);

      frmObservacao.lblMensagem.Caption := 'Produtos não inseridos na promoção! O(s) item(s) abaixo já estão em outras promoções vigentes:';
      frmObservacao.memObs.Texto := strMsg;

      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmuntCadPromocaoBrindes.pAdicionaItem]');
      End;
    End;

    pFreeAndNil(frmObservacao);
  End;

  FreeAndNil(qryGen);
  FreeAndNil(cdsItens);
end;

procedure TPromocaoBrindes.pGravarEmpresas;
  Var
    qryGen: TUniQuery;
    intContador: Integer;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Add('DELETE FROM PROBRI_EMP WHERE PRO_SEQGER = :SEQGER');
  qryGen.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add('INSERT INTO PROBRI_EMP (PRO_SEQGER, PRO_CODEMP) VALUES (:SEQGER, :CODEMP) ');

  For intContador := 0 To FEmpresas.Items.Count - 1 Do
  Begin
    If FEmpresas.Checked[intContador] Then
    Begin
      qryGen.Close;
      qryGen.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryGen.ParamByName('CODEMP').AsString := LeftStr(FEmpresas.Items[intContador], 3);
      qryGen.ExecSQL;
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TPromocaoBrindes.pDeletaItensVendaPromocao;
begin
  fExecutaSQL('DELETE FROM PROBRI_ITE WHERE PRO_SEQGER = ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString));
end;

procedure TPromocaoBrindes.pDeletaItensBrindePromocao;
begin
  fExecutaSQL('DELETE FROM PROBRI_BRI WHERE PRO_SEQGER = ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString));
end;

function TPromocaoBrindes.fGravaItemVendaPromocao(strCodIte: String; fltQtdPon: Double): Boolean;
  Var
    qryIteVen: TUniQuery;
begin
  Try
    qryIteVen := fCriarQuery('SELECT * FROM PROBRI_ITE WHERE FALSE');

    With qryIteVen Do
    Begin
      If (Not Active) Then Open;
      Append;
      FieldByName('PRO_SEQGER').AsString  := qryTabela.FieldByName('AUTOINCREM').AsString;
      FieldByName('PRO_CODITE').AsString  := strCodIte;
      FieldByName('PRO_QTDPON').AsFloat   := fltQtdPon;
      Post;
    End;

    Result := True;
  Finally
    FreeAndNil(qryIteVen);
  End;
end;

function TPromocaoBrindes.fGravaItemBrindePromocao(strCodBri: String; fltQtdBri: Double): Boolean;
  Var
    qryIteBri: TUniQuery;
begin
  Try
    qryIteBri := fCriarQuery('SELECT * FROM PROBRI_BRI WHERE FALSE');

    With qryIteBri Do
    Begin
      If (Not Active) Then Open;
      Append;
      FieldByName('PRO_SEQGER').AsString  := qryTabela.FieldByName('AUTOINCREM').AsString;
      FieldByName('PRO_CODBRI').AsString  := strCodBri;
      FieldByName('PRO_QTDBRI').AsFloat   := fltQtdBri;
      Post;
    End;

    Result := True;
  Finally
    FreeAndNil(qryIteBri);
  End;
end;

{ TFatEmitirBrindePromocao }

constructor TFatEmitirBrindePromocao.Create;
begin
  FCodOpe     := strLoginUsuarioLogado;

  FItens      := TZClient.Create(nil);
  FDicBrindes := TDicionario.Create;

  FPromocoes := TUniClientDataSet.Create(nil);
  FPromocoes.FieldDefs.Add('CODPRO', ftString, 08);
  FPromocoes.FieldDefs.Add('DESPRO', ftString, 80);
  FPromocoes.FieldDefs.Add('TABPRE', ftString, 20);
  FPromocoes.FieldDefs.Add('PERVAL', ftString, 50);
  FPromocoes.FieldDefs.Add('PONACU', ftFloat,  00);
  FPromocoes.FieldDefs.Add('PONVEN', ftFloat,  00);
  FPromocoes.FieldDefs.Add('PONUTI', ftFloat,  00);
  FPromocoes.FieldDefs.Add('PONDIS', ftFloat,  00);
  FPromocoes.CreateDataSet;

  TFloatField(FPromocoes.FieldByName('PONACU')).DisplayFormat := '#,##0.00';
  TFloatField(FPromocoes.FieldByName('PONVEN')).DisplayFormat := '#,##0.00';
  TFloatField(FPromocoes.FieldByName('PONUTI')).DisplayFormat := '#,##0.00';
  TFloatField(FPromocoes.FieldByName('PONDIS')).DisplayFormat := '#,##0.00';

  TStringField(FPromocoes.FieldByName('CODPRO')).Alignment := taCenter;
  TStringField(FPromocoes.FieldByName('TABPRE')).Alignment := taCenter;
  TStringField(FPromocoes.FieldByName('PERVAL')).Alignment := taCenter;

  FPromocoes.IndexFieldNames := 'CODPRO';

  FBrindes := TUniClientDataSet.Create(nil);
  FBrindes.FieldDefs.Add('CODPRO', ftString, 08);
  FBrindes.FieldDefs.Add('CODBRI', ftString, fTamCodIte);
  FBrindes.FieldDefs.Add('DESBRI', ftString, 70);
  FBrindes.FieldDefs.Add('REFBRI', ftString, 20);
  FBrindes.FieldDefs.Add('UNIBRI', ftString, 05);
  FBrindes.FieldDefs.Add('QTDBRI', ftFloat,  00);
  FBrindes.FieldDefs.Add('QTDSEL', ftFloat,  00);
  FBrindes.CreateDataSet;

  TFloatField(FBrindes.FieldByName('QTDBRI')).DisplayFormat := '#,##0.00';
  TFloatField(FBrindes.FieldByName('QTDSEL')).DisplayFormat := '#,##0.00';

  TStringField(FBrindes.FieldByName('CODBRI')).Alignment := taCenter;
  TStringField(FBrindes.FieldByName('UNIBRI')).Alignment := taCenter;

  FBrindes.IndexFieldNames := 'CODPRO;DESBRI';

  FEntRet := 'R';
end;

destructor TFatEmitirBrindePromocao.Destroy;
begin
  FreeAndNil(FItens);
  FreeAndNil(FPromocoes);
  FreeAndNil(FBrindes);
  FreeAndNil(FDicBrindes);
  inherited;
end;

function TFatEmitirBrindePromocao.fCarregarItensVenda(blnFilFil: Boolean = True; blnApenasPromoVigente: Boolean = False): Boolean;
  Var
    strSQL: String;
    intField: Integer;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE       ';
  strSQL := strSQL + '   "N"          AS ITESEL, ';
  strSQL := strSQL + '   "MOVDET"     AS TABDET, ';
  strSQL := strSQL + '   "MOVGER"     AS TABGER, ';
  strSQL := strSQL + '   "MOVTRI"     AS TABTRI, ';
  strSQL := strSQL + '   D.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   D.DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   D.DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   D.DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   D.DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '   D.DET_CODVEN AS CODVEN, ';
  strSQL := strSQL + '   D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '   D.DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   D.DET_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '   T.DET_PROBRI AS PROBRI, ';
  strSQL := strSQL + '   T.DET_PONBRI AS PONBRI, ';
  strSQL := strSQL + '   D.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '   G.GER_ENTFAT AS ENTFAT, ';
  strSQL := strSQL + '   (D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) / D.DET_QTDITE AS UNITAR, ';
  strSQL := strSQL + '   (D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) AS TOTITE,                ';
  //Dados do cliente consumidor
  strSQL := strSQL  + '  GER_NOMCON AS NOMCON, ';
  strSQL := strSQL  + '  GER_ENDCON AS ENDCON, ';
  strSQL := strSQL  + '  GER_BAICON AS BAICON, ';
  strSQL := strSQL  + '  GER_CEPCON AS CEPCON, ';
  strSQL := strSQL  + '  GER_CIDCON AS CIDCON, ';
  strSQL := strSQL  + '  GER_ESTCON AS ESTCON, ';
  strSQL := strSQL  + '  GER_TELCON AS TELCON, ';
  strSQL := strSQL  + '  AUX_NASCON AS NASCON, ';
  strSQL := strSQL  + '  GER_CGCCPF AS CGCCPF, ';
  strSQL := strSQL  + '  GER_CGCCON AS CGCCON, ';
  strSQL := strSQL  + '  GER_IESCON AS IESCON, ';
  strSQL := strSQL  + '  GER_EMLCON AS EMLCON, ';
  strSQL := strSQL  + '  GER_R_GCON AS R_GCON, ';
  strSQL := strSQL  + fSQLIFClienteConsumidor('C.CLI_NOMCLI', 'AUX_CODATI', 'C.CLI_CODATI ') + ' AS CODATI, ';
  //Dados da promocao
  strSQL := strSQL + '   P.*                   ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET D ';
  strSQL := strSQL + '   INNER JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + '   LEFT  JOIN CADUNI U ON D.DET_UNIDAD = U.UNI_CODUNI ';
  strSQL := strSQL + '   LEFT  JOIN PROBRI_GER P ON P.PRO_CODPRO = T.DET_PROBRI ';
  strSQL := strSQL + '   LEFT  JOIN CADCLI C ON D.DET_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + ' WHERE DET_DOCBRI IS NULL ';
  strSQL := strSQL + '   AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '   AND DET_TIP_FC = "C" ';

  If (blnFilFil) Then
    strSQL := strSQL + '   AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ';

  strSQL := strSQL + '   AND ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

//  Nao deve exibir os documentos de brinde
//  If fCfgSis('ENTBRF', varBoolean) Then
//    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
//  Else
    strSQL := strSQL + ') ';

  If FDtaFin <> 0 Then
    strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(FCodEmp) Then
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(FCodCli) Then
    strSQL := strSQL + '  AND DET_CODCLI = :CODCLI ';

  If Not fEmptyStr(FNumDoc) Then
    strSQL := strSQL + '  AND DET_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(FEspDoc) Then
    strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';

  If FSomPon Then
    strSQL := strSQL + '  AND DET_PONBRI > 0 ';

  if blnApenasPromoVigente then
    strSQL := strSQL + '  AND CURRENT_DATE BETWEEN PRO_DTAINI AND PRO_DTAFIN ';

  strSQL := strSQL + ' ORDER BY  ';
  strSQL := strSQL + '   DTAENT, ';
  strSQL := strSQL + '   CODEMP, ';
  strSQL := strSQL + '   ESPDOC, ';
  strSQL := strSQL + '   NUMDOC, ';
  strSQL := strSQL + '   DESCRI  ';

  With FItens.qryQuery, SQL Do
  Begin
    FItens.Close;

    Close;
    Clear;

    Add(strSQL);

    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    If FDtaFin <> 0 Then
    Begin
      ParamByName('DTAINI').AsDateTime := FDtaIni;
      ParamByName('DTAFIN').AsDateTime := FDtaFin;
    End;

    If Not fEmptyStr(FCodEmp) Then
      ParamByName('CODEMP').AsString := FCodEmp;

    If Not fEmptyStr(FCodCli) Then
      ParamByName('CODCLI').AsString := FCodCli;

    If Not fEmptyStr(FNumDoc) Then
      ParamByName('NUMDOC').AsString := FNumDoc;

    If Not fEmptyStr(FEspDoc) Then
      ParamByName('ESPDOC').AsString := FEspDoc;

    FItens.pSetProvider;

    Open;

    pSetaClient(FItens.qryQuery);

    FItens.Open;

    Result := Not IsEmpty;
  End;

  For intField := 0 To FItens.FieldCount -1 Do
  Begin
    If FItens.Fields[intField].DataType In [ftDate, ftDateTime] Then
      TDateTimeField(FItens.Fields[intField]).Alignment := taCenter

    Else If FItens.Fields[intField].DataType In [ftString] Then
      TStringField(FItens.Fields[intField]).Alignment := taCenter

    Else If FItens.Fields[intField].DataType In [ftFloat] Then
      TFloatField(FItens.Fields[intField]).DisplayFormat := fMskDigitos(2);
  End;

  TStringField(FItens.FieldByName('DESCRI')).Alignment     := taLeftJustify;
  TFloatField (FItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField (FItens.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
end;

class function TFatEmitirBrindePromocao.fClienteTemPontosParaBrindes(strCodCli,
  strNumDoc, strEspDoc: String; Var dtaMinDta, dtaMaxDta: TDateTime; blnApenasPromoVigente: Boolean = False): Boolean;
  Var
    blnTemPontosSuficiente: Boolean;
    objEmitirBrinde: TFatEmitirBrindePromocao;
begin
  If (Not fEmptyStr(strCodCli)) And (fClienteFilial(strCodCli)) Then
  Begin
    Result := False;
    Exit;
  End;

  blnTemPontosSuficiente         := False;
  objEmitirBrinde                := TFatEmitirBrindePromocao.Create;
  objEmitirBrinde.strCliente     := strCodCli;
  objEmitirBrinde.strDocumento   := strNumDoc;
  objEmitirBrinde.strEspecie     := strEspDoc;
  objEmitirBrinde.strEmpresa     := VS_strCodEmp;
  objEmitirBrinde.dtaDataInicial := 0;
  objEmitirBrinde.dtaDataFinal   := 0;
  objEmitirBrinde.blnSomenteComPontos := True;

  If objEmitirBrinde.fCarregarItensVenda(fEmptyStr(strCodCli), blnApenasPromoVigente) Then
  Begin
    objEmitirBrinde.pMarcarTodos;
    objEmitirBrinde.pSintetizarPromocoesSelecionadas;

    objEmitirBrinde.cdsPromocoesSel.First;
    While Not objEmitirBrinde.cdsPromocoesSel.Eof Do
    Begin
      If objEmitirBrinde.cdsPromocoesSel.FieldByName('PONVEN').AsFloat >
         objEmitirBrinde.cdsPromocoesSel.FieldByName('PONACU').AsFloat Then
      Begin
        blnTemPontosSuficiente := True;
        Break;
      End;
      objEmitirBrinde.cdsPromocoesSel.Next;
    End;

    //Indexa por data
    objEmitirBrinde.cdsItensVenda.IndexFieldNames := 'DTAENT';
    //Pega a menor data
    objEmitirBrinde.cdsItensVenda.First;
    dtaMinDta := objEmitirBrinde.cdsItensVenda.FieldByName('DTAENT').AsDateTime;
    //Pega a maior data
    objEmitirBrinde.cdsItensVenda.Last;
    dtaMaxDta := objEmitirBrinde.cdsItensVenda.FieldByName('DTAENT').AsDateTime;
  End;

  Result := blnTemPontosSuficiente;

  FreeAndNil(objEmitirBrinde);
end;

function TFatEmitirBrindePromocao.fGetTotalPontosSelecionado: Double;
  Var
    cdsTmp: TUniClientDataSet;
begin
  Result := 0.00;

  If Not FItens.Active Then
    Exit;

  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FItens.Data;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If cdsTmp.FieldByName('ITESEL').AsString = 'S' Then
    Begin
      If cdsTmp.FieldByName('CLAFIS').AsString > '5000' Then
        Result := Result + cdsTmp.FieldByName('PONBRI').AsFloat
      Else
        Result := Result - cdsTmp.FieldByName('PONBRI').AsFloat;
    End;
    cdsTmp.Next;
  End;
  FreeAndNil(cdsTmp);
end;

function TFatEmitirBrindePromocao.fGetTotalPontosVendas: Double;
  Var
    cdsTmp: TUniClientDataSet;
begin
  Result := 0.00;

  If Not FItens.Active Then
    Exit;

  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FItens.Data;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If cdsTmp.FieldByName('CLAFIS').AsString > '5000' Then
      Result := Result + cdsTmp.FieldByName('PONBRI').AsFloat
    Else
      Result := Result - cdsTmp.FieldByName('PONBRI').AsFloat;
    cdsTmp.Next;
  End;
  FreeAndNil(cdsTmp);
end;


procedure TFatEmitirBrindePromocao.pAfterScrollPromocoes(DataSet: TDataSet);
begin
  FBrindes.Filtered := False;
  FBrindes.Filter   := 'CODPRO = ' + QuotedStr(DataSet.FieldByName('CODPRO').AsString);
  FBrindes.Filtered := True;
end;

function TFatEmitirBrindePromocao.fCriaQueryItem: TUniQuery;
begin
  Result := fCriaQuery(nil);

  With Result, SQL Do
  Begin
    Add(' SELECT ');
    Add('   ITE_CLAIPI, ');
    Add('   CADITE.ITE_EXCIPI, ');

    If fCfgSis('TIPABF') = '1' Then
      Add('   CADITE.ITE_CODABF AS ITE_CODABF, ')
    Else
      Add('   ITEGER.ITE_CODABF AS ITE_CODABF, ');

    Add('   ITE_CODBAR, ');
    Add('   ITE_CODFAB, ');
    Add('   ITE_CODFOR, ');
    Add('   ITE_CODGRU, ');
    Add('   CADITE.ITE_CODITE, ');
    Add('   ITE_CODMAR, ');
    Add('   ITE_CODUNI, ');
    Add('   ITE_COMATA, ');
    Add('   ITE_COMDIS, ');
    Add('   ITE_COMLUB, ');
    Add('   ITE_COMTB1, ');
    Add('   ITE_COMTB2, ');
    Add('   ITE_COMTB3, ');
    Add('   ITE_COMTB4, ');
    Add('   ITE_COMTB5, ');
    Add('   ITE_COMTB6, ');
    Add('   ITE_COMTB7, ');
    Add('   ITE_COMVAR, ');
    Add('   ITE_DESFAB, ');
    Add('   ITE_DESITE, ');
    Add('   ITE_DESMAX, ');
    Add('   ITE_DESMGE, ');
    Add('   ITE_DESMSU, ');
    Add('   ITE_DESOPE, ');
    Add('   ITE_DESSIM, ');
    Add('   ITE_FREENT, ');
    Add('   ITE_ICMSAI, ');

    If (fCfgSis('IMPDIG') = '1') Then
      Add('   CADITE.ITE_IMPDIR AS ITE_IMPDIR, ')
    Else
      Add('   ITEGER.ITE_IMPDIR AS ITE_IMPDIR, ');

    Add('   ITE_IMPFED, ');
    Add('   ITE_IMPULT, ');
    Add('   ITE_INCPIS, ');
    Add('   ITE_IPIENT, ');
    Add('   ITE_IPISAI, ');
    Add('   ITE_LOCFIS, ');
    Add('   ITE_MARMGE, ');
    Add('   ITE_MARMIN, ');
    Add('   ITE_MARMSG, ');

    Add('   ITE_DESMVM, ');
    Add('   ITE_DESMSM, ');
    Add('   ITE_DESMGM, ');

    Add('   ITE_MARMMV, ');
    Add('   ITE_MARMMS, ');
    Add('   ITE_MARMMG, ');

    Add('   ITE_OBRCPF, ');
    Add('   ITE_OUTVAL, ');
    Add('   ITE_PESLIQ, ');
    Add('   ITE_PESOIT, ');
    Add('   ITE_PRECOM, ');
    Add('   ITE_PRECUS, ');
    Add('   ITE_PREMED, ');
    Add('   ITE_PREULT, ');
    Add('   ITE_PREVE1, ');
    Add('   ITE_PREVE2, ');
    Add('   ITE_PREVE3, ');
    Add('   ITE_PREVE4, ');
    Add('   ITE_PREVE5, ');
    Add('   ITE_PREVE6, ');
    Add('   ITE_PREVE7, ');
    Add('   ITE_QTPPRO, ');
    Add('   ITE_REFERE, ');
    Add('   ITE_SALDOS  ');
    Add(' FROM CADITE ');
    Add('   INNER JOIN ITEGER ');
    Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
    Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
    Add('     AND CADITE.ITE_CODITE = :CODITE ');
  End;

end;

function TFatEmitirBrindePromocao.fEmitirDocumentoBrindeInterna(pgbStatus: TcxprogressBar): Boolean;
  Var
    fatVenda : TFatVenda;
    strOpcDoc: String;
    strEspDoc: String;
    intItem  : Integer;
    strItem  : String;
    arrDatas : TDateArray;
    blnMostraDigDuplic: Boolean;
begin
  Try
    Result := False;

    pProgresso(0, 0, pgbStatus);
    pInformacao('Criando documento de Brinde.', pgbStatus);

    if (not blnFatVenda) or ((blnFatVenda) and (cdsVenda = nil)) then
      pCriarCdsVenda(nil);

    strOpcDoc := IIF(VS_strTipExp = '2', 'VN', 'PD');
    strEspDoc := IIF(VS_strTipExp = '2', 'NF', 'PD');

    fatVenda := TFatVenda.CreateInstance(strOpcDoc);
    fatVenda.strNomeForm := 'frmFatVendas';
    fatVenda.strEspDoc   := strEspDoc;
    fatVenda.strCodOpe   := strOperador;
    fatVenda.blnDocumentoBrindePromocao := True;

    fatVenda.cdsItensPromocaoBrindes := FItens;

    fatVenda.qryConIte := fCriarQueryIteGer(fatVenda);

    cdsVenda.EmptyDataSet;

    pInformacao('Carregando Cliente.', pgbStatus);

    fatVenda.pCarregaDadosClienteBaixa(strCliente);

    If fClienteConsumidor(fatVenda.strCliOri) Then
    Begin
      fatVenda.strCliNom := FItens.FieldByName('NOMCON').AsString;                   // Nome do Consumidor
      fatVenda.strCliEnd := FItens.FieldByName('ENDCON').AsString;                   // Endereço do Consumidor
      fatVenda.strCliBai := FItens.FieldByName('BAICON').AsString;                   // Bairro do Consumidor
      fatVenda.strCliCep := FItens.FieldByName('CEPCON').AsString;                   // Cep do Consumidor
      fatVenda.strCodCid := FItens.FieldByName('CIDCON').AsString;                   // Cidade do Consumidor
      fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);                       // - Cidade
      fatVenda.strCliEst := FItens.FieldByName('ESTCON').AsString;                   // Estado do Consumidor
      fatVenda.strCliTel := FItens.FieldByName('TELCON').AsString;                   // Telefone do Consumidor
      fatVenda.dtaNasCon := FItens.FieldByName('NASCON').AsDateTime;                 // Nascimento consumidor
      fatVenda.strCliCgc := FItens.FieldByName('CGCCON').AsString;                   // CNPJ / CGC do consumidor
      fatVenda.strCli_Rg := FItens.FieldByName('R_GCON').AsString;                   // RG do consumidor
      fatVenda.intCgcCpf := StrToIntDef(FItens.FieldByName('CGCCPF').AsString, 0);   // CGC/CPF
      fatVenda.strCliIes := FItens.FieldByName('IESCON').AsString;                   // Inscrição estadual do Consumidor
      fatVenda.strCliEma := FItens.FieldByName('EMLCON').AsString;                   // - Email para NFe
      fatVenda.strCodAti := FItens.FieldByName('CODATI').AsString;                   // - Código de Atividade
      fatVenda.strNomAti := fRetAtividade(fatVenda.strCodAti);                       // - Nome de Atividade

      While (Not fatvenda.fValidaCPFConsumidor) Do
      Begin
        If fPergunta('É necessário informar o CPF/CNPJ do consumidor para emissão ' +
                     'do documento de brinde. Deseja informar agora?') Then
        Begin
          If Not fatVenda.fDigDadosConsumidor(Nil) Then
            Exit
          Else If (Not fEmptyStr(fatVenda.strCodCliPreCadastro)) Then
            pRecarregaDadosCliente(fatVenda);
        End
        Else
          Exit;
      End;
    End;

    pInformacao('Carregando Condição de Pagamento.', pgbStatus);

    fatVenda.strCodCnd := fRetCodCndAVista;
    fatVenda.strCodFpg := '001';
    fatVenda.strConPag := '01000';
    fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
    fatVenda.pAtualizaInformacoesCondPagamento;

    pInformacao('Carregando Dados do Vendedor.', pgbStatus);

    fatVenda.strCodVen := fatVenda.strCodOpe;
    fatVenda.strCodDig := fatVenda.strCodOpe;
    fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
    fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);

    pInformacao('Carregando Informacoes do Brinde.', pgbStatus);

    fatVenda.strTipPed := 'A';
    fatVenda.strTipOpe := 'B';
    fatVenda.strTabPre := IIF(fEmptyStr(fatVenda.strTabPre), '1', fatVenda.strTabPre);
    fatVenda.strMen001 := 'PROMOÇÃO DE BRINDES POR PRODUTO VENDIDO';
    fatVenda.strEntFat := IIF(FEntRet = 'E', 'S', 'N');

    pInformacao('Inserindo Produtos de Brinde.', pgbStatus);

    For intItem := 0 To FDicBrindes.Chaves.Count -1 Do
    Begin
      pProgresso(intItem + 1, FDicBrindes.Chaves.Count, pgbStatus);

      strItem := FDicBrindes.Chaves[intItem];

      Result := fInserirProduto(fatVenda, strItem, FDicBrindes[strItem]);

      If Not Result Then
        Exit;
    End;

    pProgresso(0, 0, pgbStatus);

    pInformacao('Carregando produtos para fechamento.', pgbStatus);

    fatVenda.pPreencheMatrizFechamento;

    fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

    If fatVenda.blnTaxVpr Then
      fatVenda.pCalculaTaxVpr;

    pInformacao('Calculando Peso Produtos.', pgbStatus);

    fatVenda.pCalculaPesBruLiq;

    pInformacao('Calculando Valor Total.', pgbStatus);

    fatVenda.pDestacaRetencoes;
    fatVenda.pRetemImpostosNoDescontoEspecial;

    fatVenda.pCalculaTotGer;

    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    pInformacao('Calculando Total Parcelas.', pgbStatus);

    fatVenda.pCalculaTotalParaCadRec;

    fatVenda.pRateiaValores;

    blnMostraDigDuplic := False;

    fatVenda.fDigitaDuplicata(blnMostraDigDuplic,
                              arrDatas, fatVenda.dtaPreVis,
                              True, fatVenda.arrDuplicCop);

    If fatVenda.fltValAdt > 0 Then
    Begin
      Result := Result And fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
    End;

    pInformacao('Gravando documento de Brinde.', pgbStatus);

    Result := Result And fGravarArquivos(fatVenda);

    If Result Then
    Begin
      pMensagemOk('Documento de Brinde (' + fatVenda.strNumDoc + '-' +
        fatVenda.strEspDoc + ') emitido com sucesso!');
    End;
  Finally
    If Assigned(fatVenda) Then FreeAndNil(fatVenda);
    If (cdsVenda <> nil) and (not blnFatVenda) Then
      pFreeCdsVenda;
  End;
end;

function TFatEmitirBrindePromocao.fGravarArquivos(fatVenda: TFatVenda): Boolean;
  Var
    frmGravar: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravar);
    frmGravar.strChave := 'FATVENDAS';
    frmGravar.fExecutarAcao := fatVenda.fGravaArquivos;
    frmGravar.ShowModal;
    Result := frmGravar.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;
  pFreeAndNil(frmGravar);
end;

function TFatEmitirBrindePromocao.fInserirProduto(fatVenda: TFatVenda;
  strCodIte: String; fltQtdIte: Double): Boolean;
  Var
    qryItem: TUniQuery;
    recForTin: TForTin;
    fltUnitar: Double;
    fltIcmSai: Double;
    recMadeira: TDadosMadeira;
    parPreCus: TParCalculaPrecoCusto;
    strBrinde : String;
    fltUniOri : Double;
    fltUniVis : Double;
begin
  Try
    qryItem := fCriaQueryItem;

    qryItem.Close;
    qryItem.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryItem.ParamByName('CODITE').AsString := strCodIte;
    qryItem.Open;

    Result := Not qryItem.IsEmpty;

    If Result Then
    With qryItem Do
    Begin
      case fCfgSis('SUG_BR', varInteger) of
        1:fltUnitar := FieldByName('ITE_PRECUS').AsFloat;
        2:fltUnitar := FieldByName('ITE_PREVE' + fatVenda.strTabPre).AsFloat;
        3:fltUnitar := FieldByName('ITE_PREULT').AsFloat;
        4:fltUnitar := FieldByName('ITE_IMPULT').AsFloat;
      else
        fltUnitar := FieldByName('ITE_PRECUS').AsFloat;
      end;

      fltUniOri := fltUnitar;
      fltUniVis := fltUnitar;

      If (fCfgSis('IMPCF4') = 'S') Then
        fltIcmSai := fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, FieldByName('ITE_IMPDIR').AsString)
      Else
        fltIcmSai := FieldByName('ITE_ICMSAI').AsFloat;

      parPreCus := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

      fatVenda.fltPreCus := FieldByName('ITE_PRECUS').AsFloat;
      fatVenda.fltPreCu2 := parPreCus.fCalculaPrecoCustoRealVenda(fltUnitar,
                                                                  FieldByName('ITE_PRECUS').AsFloat,
                                                                  FieldByName('ITE_OUTVAL').AsFloat,
                                                                  fltIcmSai,
                                                                  FieldByName('ITE_IMPFED').AsFloat,
                                                                  FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli,
                                                                  0,
                                                                  0);
      FreeAndNil(parPreCus);

      strBrinde := 'N';
      If (fCfgSis('USABRI', varString) = 'S') And (fPermiteBrindeComValorZero) Then
      Begin
        fltUnitar := 0;
        strBrinde := 'S';
      End;

      fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                            Nil,
                                            'NOR',
                                            FieldByName('ITE_CODGRU').AsString,
                                            strCodIte,
                                            FieldByName('ITE_DESITE').AsString,
                                            FieldByName('ITE_DESITE').AsString,
                                            FieldByName('ITE_DESFAB').AsString,
                                            FieldByName('ITE_CODUNI').AsString,
                                            FieldByName('ITE_CODUNI').AsString,
                                            FieldByName('ITE_CODMAR').AsString,
                                            FieldByName('ITE_CODFOR').AsString,
                                            FieldByName('ITE_REFERE').AsString,
                                            fltUniOri,
                                            fltUniVis,
                                            fltUnitar,
                                            fltUnitar,
                                            0.00,
                                            fltQtdIte,
                                            fltQtdIte * fltUnitar,
                                            'S',
                                            fatVenda.fltPreCus,
                                            fatVenda.fltPreCus * fltQtdIte,
                                            FieldByName('ITE_COMLUB').AsString,
                                            FieldByName('ITE_IPISAI').AsFloat,
                                            FieldByName('ITE_DESMAX').AsFloat,
                                            FieldByName('ITE_PREVE1').AsFloat,
                                            FieldByName('ITE_PREVE2').AsFloat,
                                            FieldByName('ITE_PREVE3').AsFloat,
                                            FieldByName('ITE_PREVE4').AsFloat,
                                            FieldByName('ITE_PREVE5').AsFloat,
                                            FieldByName('ITE_PREVE6').AsFloat,
                                            FieldByName('ITE_PREVE7').AsFloat,

                                            fCalculaPrecoVenda(2, FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                  fltUnitar,
                                                                  0,
                                                                  fltIcmSai,
                                                                  FieldByName('ITE_IMPFED').AsFloat,
                                                                  FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli,
                                                                  FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat, fatVenda.VS_strMARMKP),

                                            FieldByName('ITE_SALDOS').AsFloat,
                                            FieldByName('ITE_INCPIS').AsString,
                                            FieldByName('ITE_COMVAR').AsFloat,
                                            FieldByName('ITE_COMATA').AsFloat,
                                            FieldByName('ITE_COMDIS').AsFloat,
                                            '',
                                            '',
                                            '',
                                            0.0,
                                            0.0,
                                            '',
                                            FieldByName('ITE_PREULT').AsFloat * fltQtdIte,
                                            FieldByName('ITE_IMPULT').AsFloat,
                                            FieldByName('ITE_PREULT').AsFloat,
                                            FieldByName('ITE_PREMED').AsFloat,
                                            FieldByName('ITE_CLAIPI').AsString,
                                            '',
                                            '',  //CODIGO DA TINTA
                                            '',
                                            '',
                                            0,
                                            '',
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                            'N',
                                            '',
                                            0.0,
                                            0.0,

                                            FieldByName('ITE_CODABF').AsString,
                                            FieldByName('ITE_PESOIT').AsFloat,
                                            FieldByName('ITE_PESLIQ').AsFloat,
                                            'N',
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                            '',
                                            0.0,
                                            FieldByName('ITE_CODFAB').AsString,
                                            cdsVenda.RecordCount + 1,
                                            0.0,
                                            '',
                                            '',
                                            '',
                                            FieldByName('ITE_MARMIN').AsFloat,
                                            FieldByName('ITE_MARMSG').AsFloat,
                                            FieldByName('ITE_MARMGE').AsFloat,
                                            FatVenda.strDesMar,
                                            fatVenda.strStatus,
                                            0.0,
                                            0.0,
                                            '',
                                            '',
                                            '',
                                            0.0,
                                            '',
                                            '',
                                            '',
                                            FieldByName('ITE_PRECOM').AsFloat,
                                            fltUnitar,
                                            FieldByName('ITE_QTPPRO').AsFloat,
                                            '',
                                            '',
                                            FieldByName('ITE_OBRCPF').AsString,
                                            '',
                                            '',
                                            fRetSiglaUnidade(FieldByName('ITE_CODUNI').AsString),
                                            0.0,
                                            fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                            '',
                                            '',
                                            '',
                                            False,
                                            '',
                                            '',
                                            '',
                                            FieldByName('ITE_OUTVAL').AsFloat,
                                            FieldByName('ITE_COMTB' + fatVenda.strTabPre).AsFloat,
                                            FieldByName('ITE_DESOPE').AsFloat,
                                            fltIcmSai,
                                            FieldByName('ITE_IMPFED').AsFloat,
                                            FieldByName('ITE_DESMGE').AsFloat,
                                            '',
                                            '',
                                            '',
                                            fatVenda.strTabPre,
                                            FieldByName('ITE_IPIENT').AsFloat,
                                            FieldByName('ITE_FREENT').AsFloat,
                                            '',
                                            0.0,
                                            '',
                                            0.0,
                                            FEntRet,
                                            '',
                                            'N',
                                            '',
                                            0,
                                            fltQtdIte,
                                            0,
                                            0,
                                            FieldByName('ITE_IMPDIR').AsString,
                                            FieldByName('ITE_LOCFIS').AsString,
                                            fatVenda.fltPreCu2,
                                            fatVenda.fltPreCu2 * fltQtdIte,
                                            0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            recForTin,
                                            '',
                                            '',
                                            fatVenda.objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(FieldByName('ITE_CODITE').AsString),
                                            '',
                                            '',
                                            False,
                                            'N',
                                            'NOR',
                                            0,
                                            '',
                                            FieldByName('ITE_CODBAR').AsString,
                                            '',
                                            0,
                                            0,
                                            0,
                                            '',
                                            1,
                                            True,
                                            '',
                                            '',
                                            '',
                                            0,
                                            FieldByName('ITE_PRECUS').AsFloat,
                                            FieldByName('ITE_DESSIM').AsString,
                                            '',
                                            recMadeira,
                                            FieldByName('ITE_IMPULT').AsFloat * fltQtdIte,
                                            0,
                                            0,
                                            '',
                                            0,
                                            '',
                                            '',
                                            0,
                                            0,
                                            '',
                                            '',
                                            0,
                                            '',
                                            'N',
                                            0,
                                            0,
                                            0,
                                            False,
                                            False,
                                            'N',
                                            '',
                                            0,
                                            0,
                                            '',
                                            'N',
                                            0,
                                            '',
                                            '',
                                            '',
                                            '',
                                            FieldByName('ITE_EXCIPI').AsString,
                                            FieldByName('ITE_DESMSU').AsFloat,
                                            '',
                                            '',
                                            '',
                                            'S',
                                            strBrinde,
                                            '',
                                            '',
                                            '',
                                            '',
                                            False,
                                            -1,
                                            -1,
                                            'N',
                                            '',
                                            'N',
                                            0,
                                            0,
                                            0,
                                            '',
                                            0,
                                            0,
                                            0,
                                            '',
                                            0,
                                            0,
                                            0,
                                            '',
                                            '',
                                            0,
                                            0,
                                            0,
                                            False,
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            0,
                                            '',
                                            '',
                                            0,
                                            0,
                                            '',
                                            '',
                                            'N',
                                            'N',
                                            '',
                                            0,
                                            0,
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            FieldByName('ITE_DESMVM').AsFloat,
                                            FieldByName('ITE_DESMSM').AsFloat,
                                            FieldByName('ITE_DESMGM').AsFloat,
                                            FieldByName('ITE_MARMMV').AsFloat,
                                            FieldByName('ITE_MARMMS').AsFloat,
                                            FieldByName('ITE_MARMMG').AsFloat);
    End;

    Result := True;
  Except

    On E: ExceptionAutcom Do
    Begin
      Result := False;
      pMensagemOK(E.Message);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryItem);
end;

function TFatEmitirBrindePromocao.fEmitirDocumentoBrinde(pgbStatus: TcxprogressBar): Boolean;
  Var
    frmFatPromocaoBrindesResumo: TfrmFatPromocaoBrindesResumo;
begin
  Try
    pProgresso(0, 0, pgbStatus);

    pInformacao('Sintetizando promoções dos produtos selecionados.', pgbStatus);
    pSintetizarPromocoesSelecionadas;

    pInformacao('Carregando produto(s) de brinde das promoções.', pgbStatus);
    pCarregaBrindesPromocoesSelecionadas;

    FPromocoes.AfterScroll := pAfterScrollPromocoes;
    FPromocoes.AfterScroll(FPromocoes);
    FPromocoes.First;

    If FPromocoes.RecordCount > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmFatPromocaoBrindesResumo, frmFatPromocaoBrindesResumo);
        frmFatPromocaoBrindesResumo.objEmitirBrinde := Self;
        Result := frmFatPromocaoBrindesResumo.ShowModal = mrOk;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '');
        End;
      End;
      pFreeAndNil(frmFatPromocaoBrindesResumo);
    End
    Else
    Begin
      pMensagemOK('Não foram encontradas promoções para emissão de brindes. ' +
                  'Verifique os documentos selecionados!');
      Result := False;
    End;

    If Result Then
    Begin
      pInformacao('Carregando produto(s) de brinde selecionados.', pgbStatus);
      FDicBrindes.Limpar;
      FPromocoes.First;

      While Not FPromocoes.Eof Do
      Begin
        pProgresso(FPromocoes.RecNo, FPromocoes.RecordCount, pgbStatus);
        FBrindes.First;
        While Not FBrindes.Eof Do
        Begin
          If FBrindes.FieldByName('QTDSEL').AsFloat > 0 Then
          Begin
            FDicBrindes[FBrindes.FieldByName('CODBRI').AsString] :=
              IfNull(FDicBrindes[FBrindes.FieldByName('CODBRI').AsString], 0) +
                FBrindes.FieldByName('QTDSEL').AsFloat;
          End;
          FBrindes.Next;
        End;
        FPromocoes.Next;
      End;

      Result := FDicBrindes.Chaves.Count > 0;

      If Not Result Then
      Begin
        pMensagemOK('Não foi selecionado nenhum produto para a emissão do documento ' +
                    'de brinde. Por favor verifique as promoções e os brindes!');
      End
      Else
        Result := fEmitirDocumentoBrindeInterna(pgbStatus);
    End;

  Finally
    FBrindes.Filter   := '';
    FBrindes.Filtered := False;
    FPromocoes.AfterScroll := nil;
  End;
end;

procedure TFatEmitirBrindePromocao.pCarregaBrindesPromocoesSelecionadas;
  Var
    strSQL: String;
    qryBrindes: TUniQuery;
    intField: Integer;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PRO_CODPRO AS CODPRO, ';
  strSQL := strSQL + '  PRO_CODBRI AS CODBRI, ';
  strSQL := strSQL + '  ITE_DESITE AS DESBRI, ';
  strSQL := strSQL + '  ITE_REFERE AS REFBRI, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIBRI, ';
  strSQL := strSQL + '  PRO_QTDBRI AS QTDBRI, ';
  strSQL := strSQL + '  0.00       AS QTDSEL  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER  ';
  strSQL := strSQL + '  INNER JOIN PROBRI_BRI ON PRO_SEQGER = PROBRI_GER.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN CADITE     ON ITE_CODITE = PRO_CODBRI ';
  strSQL := strSQL + '  INNER JOIN CADUNI     ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_CODPRO = :CODPRO ';

  Try
    qryBrindes := fCriaQuery;
    qryBrindes.SQL.Text := strSQL;

    FBrindes.EmptyDataSet;
    FBrindes.DisableControls;
    FPromocoes.DisableControls;
    FPromocoes.First;

    While Not FPromocoes.Eof Do
    Begin
      qryBrindes.Close;
      qryBrindes.ParamByName('CODPRO').AsString := FPromocoes.FieldByName('CODPRO').AsString;
      qryBrindes.Open;

      qryBrindes.First;
      While Not qryBrindes.Eof Do
      Begin
        FBrindes.Append;

        For intField := 0 To qryBrindes.FieldCount -1 Do
          FBrindes.FieldByName(qryBrindes.Fields[intField].FieldName).Value := qryBrindes.Fields[intField].Value;

        FBrindes.Post;

        qryBrindes.Next;
      End;

      FPromocoes.Next;
    End;
  Finally
    FPromocoes.EnableControls;
    FBrindes.EnableControls;
    FreeAndNil(qryBrindes);
  End;
end;

procedure TFatEmitirBrindePromocao.pMarcarTodos(strIteSel: String = 'S');
begin
  Try
    FItens.DisableControls;
    With FItens Do
    Begin
      If Active And Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pSelecionarItem(strIteSel);
          Next;
        End;
      End;
    End;
  Finally
    FItens.EnableControls;
  End;
end;

procedure TFatEmitirBrindePromocao.pSelecionarTodosBrindes;
begin
  Try
    FBrindes.DisableControls;
    If (FBrindes.Active) And (Not FBrindes.IsEmpty) Then
    Begin
      FBrindes.First;
      While Not FBrindes.Eof Do
      Begin
        pSelecionarBrinde(False);
        FBrindes.Next;
      End;
    End;

  Finally
    FBrindes.EnableControls;
  End;
end;

procedure TFatEmitirBrindePromocao.pRemoverTodosBrindes;
begin
  Try
    FBrindes.DisableControls;

    If (FBrindes.Active) And (Not FBrindes.IsEmpty) Then
    Begin
      FBrindes.First;
      While Not FBrindes.Eof Do
      Begin
        pRemoverBrinde(False);
        FBrindes.Next;
      End;
    End;

  Finally
    FBrindes.EnableControls;
  End;
end;
procedure TFatEmitirBrindePromocao.pSelecionarBrinde(blnConfirma : Boolean = True);
  Var
    intRecNo: Integer;
begin
  If blnConfirma Then
    If Not fPergunta('Confirma selecionar este brinde?') Then
      Exit;

  If FPromocoes.FieldByName('PONDIS').AsFloat < FPromocoes.FieldByName('PONACU').AsFloat Then
  Begin
    pMensagemOk('A quantidade de pontos disponíveis é inferior a quantidade de pontos ' +
                'acumulados da promoção para adquirir direito a brinde!');
    Exit;
  End;

  With FBrindes Do
  Begin
    Edit;
    FieldByName('QTDSEL').AsFloat := FieldByName('QTDSEL').AsFloat + FieldByName('QTDBRI').AsFloat;
    Post;
  End;

  intRecNo := FBrindes.RecNo;

  With FPromocoes Do
  Begin
    Edit;
    FieldByName('PONUTI').AsFloat := FieldByName('PONUTI').AsFloat + FieldByName('PONACU').AsFloat;
    FieldByName('PONDIS').AsFloat := FieldByName('PONDIS').AsFloat - FieldByName('PONACU').AsFloat;
    Post;
  End;

  FBrindes.RecNo := intRecNo;
end;

procedure TFatEmitirBrindePromocao.pRemoverBrinde(blnConfirma : Boolean = True);
  Var
    intRecNo: Integer;
begin
  If FBrindes.FieldByName('QTDSEL').AsFloat <= 0 Then
    Exit;

  If blnConfirma Then
    If Not fPergunta('Confirma remover este brinde?') Then
      Exit;

  With FBrindes Do
  Begin
    Edit;
    FieldByName('QTDSEL').AsFloat := FieldByName('QTDSEL').AsFloat - FieldByName('QTDBRI').AsFloat;
    Post;
  End;

  intRecNo := FBrindes.RecNo;

  With FPromocoes Do
  Begin
    Edit;
    FieldByName('PONUTI').AsFloat := FieldByName('PONUTI').AsFloat - FieldByName('PONACU').AsFloat;
    FieldByName('PONDIS').AsFloat := FieldByName('PONDIS').AsFloat + FieldByName('PONACU').AsFloat;
    Post;
  End;

  FBrindes.RecNo := intRecNo;
end;

procedure TFatEmitirBrindePromocao.pSelecionarItem(strIteSel: String = '');
begin
  With FItens Do
  Begin
    If Active And Not IsEmpty Then
    Begin
      If fEmptyStr(strIteSel) Then
        strIteSel := IIF(FieldByName('ITESEL').AsString = 'S', 'N', 'S');
      Edit;
      FieldByName('ITESEL').AsString := strIteSel;
      Post;
    End;
  End;
end;

procedure TFatEmitirBrindePromocao.pSintetizarPromocoesSelecionadas;
  Var
    intTabPre: Integer;
    strTabPre: String;
begin
  Try
    FPromocoes.EmptyDataSet;
    FItens.DisableControls;
    FItens.First;
    While Not FItens.Eof Do
    Begin
      If (FItens.FieldByName('ITESEL').AsString = 'S') And (FItens.FieldByName('PRO_CODPRO').AsString <> '') Then
      Begin
        If Not FPromocoes.Locate('CODPRO', FItens.FieldByName('PRO_CODPRO').AsString, []) Then
        Begin
          FPromocoes.Append;
          FPromocoes.FieldByName('CODPRO').AsString := FItens.FieldByName('PRO_CODPRO').AsString;
          FPromocoes.FieldByName('DESPRO').AsString := FItens.FieldByName('PRO_DESPRO').AsString;
          FPromocoes.FieldByName('PONACU').AsFloat  := FItens.FieldByName('PRO_PONACU').AsFloat;
          FPromocoes.FieldByName('PONVEN').AsFloat  := 0.00;
          FPromocoes.FieldByName('PONUTI').AsFloat  := 0.00;
          FPromocoes.FieldByName('PONDIS').AsFloat  := 0.00;
          FPromocoes.FieldByName('PERVAL').AsString := FItens.FieldByName('PRO_DTAINI').AsString + ' à ' +
                                                       FItens.FieldByName('PRO_DTAFIN').AsString;
          strTabPre := '';
          For intTabPre := 1 To Length(FItens.FieldByName('PRO_TABPRE').AsString) Do
            If FItens.FieldByName('PRO_TABPRE').AsString[intTabPre] = 'S' Then
            Begin
              If strTabPre <> '' Then strTabPre := strTabPre + ', ';
              strTabPre := strTabPre + intToStr(intTabPre);
            End;

          FPromocoes.FieldByName('TABPRE').AsString := strTabPre;
        End
        Else
          FPromocoes.Edit;

        If FItens.FieldByName('CLAFIS').AsString > '5000' Then
          FPromocoes.FieldByName('PONVEN').AsFloat :=
            FPromocoes.FieldByName('PONVEN').AsFloat + FItens.FieldByName('PONBRI').AsFloat
        Else
          FPromocoes.FieldByName('PONVEN').AsFloat :=
            FPromocoes.FieldByName('PONVEN').AsFloat - FItens.FieldByName('PONBRI').AsFloat;

        FPromocoes.FieldByName('PONDIS').AsFloat := FPromocoes.FieldByName('PONVEN').AsFloat;
      End;
      FItens.Next;
    End;
  Finally
    FItens.EnableControls;
  End;
end;

procedure TFatEmitirBrindePromocao.pRecarregaDadosCliente(Var fatVenda: TFatVenda);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;

  Try
    pCarregaQueryCadCli(qryDados, fatVenda.strCodCliPreCadastro);

    If (qryDados.IsEmpty) Then
      Exit;

    fatVenda.strCodCli := fatVenda.strCodCliPreCadastro;
    fatVenda.strCliNom := qryDados.FieldByName('CLI_NOMCLI').AsString;
    fatVenda.strCliEnd := qryDados.FieldByName('CLI_ENDERE').AsString;
    fatVenda.strCliBai := qryDados.FieldByName('CLI_BAIRRO').AsString;
    fatVenda.strCliCep := qryDados.FieldByName('CLI_C_E_P_').AsString;
    fatVenda.strCodCid := qryDados.FieldByName('CLI_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
    fatVenda.strCliEst := fRetNomCidade(fatVenda.strCodCid, 1);
    fatVenda.strCliTel := qryDados.FieldByName('CLI_FONE01').AsString;
    fatVenda.dtaNasCon := qryDados.FieldByName('CLI_NASCON').AsDateTime;
    fatVenda.strCliCgc := qryDados.FieldByName('CLI_C_G_C_').AsString;
    fatVenda.strCli_Rg := qryDados.FieldByName('CLI_NUMR_G').AsString;
    fatVenda.intCgcCpf := StrToIntDef(qryDados.FieldByName('CLI_CGCCPF').AsString, 0);
    fatVenda.strCliIes := qryDados.FieldByName('CLI_I_E_S_').AsString;
    fatVenda.strCliEma := qryDados.FieldByName('CLI_EMAIL3').AsString;
    fatVenda.strCodAti := qryDados.FieldByName('CLI_CODATI').AsString;
    fatVenda.strNomAti := fRetAtividade(fatVenda.strCodAti);
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TFatEmitirBrindePromocao.pCarregaQueryCadCli(Var qryDados: TUniQuery; strCodCli: String);
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Text := ' SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI ';
  qryDados.ParamByName('CODCLI').AsString := strCodCli;
  qryDados.Open;
end;

end.
