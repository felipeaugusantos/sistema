unit untTProcessaArquivo_Deceuninck_Kommerling;

interface
uses cxProgressBar, classes, SysUtils, untTValidaExcel, untZClient, uni, untSaldoLojas, Data.DB,
     untGerarOrcamentoCompraAuto, Forms, untSelecionaItemDuplicadoCodFabrica, strUtils,
     untImportarArquivoParaAnalise_de_Compras_Totais, System.Character;
  type
  TTipoLayout = (tlKommerling, tlDeceuninck, tlDeceuninckOrdemProducao);
  TTipoOrigem = (toListaMaterial, toAnaliseDeCompra);

  TProcessaArquivo = Class
  private
    FqryOrdem: TUniQuery;
    FProgress: TcxProgressBar;
    FArquivo: string;
    FobjExcel: TValidadorExcel;
    FQryConsulta: TUniQuery;
    FCodForOldValue: string;
    FCodIteOldValue: String;
    FQtdIteOldValue: Double;
    FcdsTotais: TZClient;
    objSalLoj: TSaldoLojas;
    blnEntFut: Boolean;
    blnOrdPro: Boolean;
    intCalSal: Integer;
    FTipoLayout: TTipoLayout;
    FTipoOrigem: TTipoOrigem;
    FProjeto :   string;
    FGrupoAtual: string;
    procedure pPreparaArquivo;
    procedure pSetArqArquivo(const Value: string);
    procedure pLeArquivo;
    procedure pLocalizaColunas(intLinha: integer; var strColunaCodigo: string; var strColunaQuantidade: string; var strColunaPreco: string);
    function IsNumeric(Value: String): Boolean;
    function IsDeceuninck: Boolean;
    function fPodeInserir(strCodIte, strQuantidade: String): Boolean;

    procedure preencheDadosDeceuninck(intLinha: integer; strColunaCodigo, strColunaNome, strColunaQuantidade, strColunaPreco: String);

    procedure processaDeceuninck;
    function fTrataStringProjeto(AProjeto: String): String;

    procedure pSetaGrupoAtual(intLinha: integer);
    procedure pInsereCDS(strCodIte, strQuantidade, strNome, strPreco: string);
    function fCarregaItem(strCodIte: string; var intQtdFornecedores: Integer; blnCodFab: Boolean = True): Boolean;
    function fTrataQuantidadeSugestao(Value: Double): Double;
    procedure pInsereCamposPadrao(blnIndentificadoAposImportacao: Boolean);
    procedure pCalculaCDSTotais;
    function fValidaCodigoFabrica(strCodFor, strCodFab, strCodIte: String): Boolean;
    function fPodeValidarCodFab(strCodFor, strCodFab, strCodIte: String): Boolean;

    procedure pTrataFornecedor(var strBckDes: string);
    procedure pTrataProduto(var qtdFornecedor: integer);
    function fInsertKommerling: Boolean;
    procedure pTrataInsertKommerling(var qtdFornecedor: integer);
    procedure pTrataItem(var qtdFornecedor: integer; var strCodItePar: string);

    function fDefineCodItePar(strCodItePar: string): Boolean;




  protected
    procedure OnAfterPost(DataSet: TDataSet);
    procedure OnBeforePost(DataSet: TDataSet);
    procedure OnAfterEdit(DataSet: TDataSet);
    function fRetSaldoReservadoOrdem(strCodIte: String): Double;
    procedure pCarregaQryOrdem(var strErro: String);


  public
    StrTabPreco: String;
    FqryDados: TZClient;
    blnTemItemSemSaldo: Boolean;
    strNumPed: String;
    strEmpPed: String;
    strEspPed: String;

    constructor Create(aProgress: TcxProgressBar; ATipoOrigem: TTipoOrigem);
    destructor Destroy; override;
    procedure pSQlBase(blnIteFor: Boolean; strCodIte: String);

    procedure pVisualizaTotais;
    procedure pEscolheItensDuplicados;
    procedure pSelecionaItens;

    procedure pGravaITEFOR;
    function fGeraPedidoCompra: Boolean;
    property TipoLayout: TTipoLayout read FTipoLayout write FTipoLayout Default tlDeceuninck;
    property Arquivo: string read FArquivo write pSetArqArquivo;
    property TipoOrigem: TTipoOrigem read FTipoOrigem;
    property Projeto: String read FProjeto;
  End;


Const  tsiNaoEncontrado = 0;
       tsiEncontrado = 1;
       tsiInformado = 2;
       tsiDuplicado = 3;
implementation

uses
  untFuncoesSimples, untGravando, untConsultas, untTypesSistema, untImportarListaDeMateriais,
  untFuncoes;


{ TProcessaArquivo }

constructor TProcessaArquivo.Create(aProgress: TcxProgressBar; ATipoOrigem: TTipoOrigem);
begin
  blnTemItemSemSaldo := False;
  FqryOrdem := fCriaQuery;
  objSalLoj := TSaldoLojas.Create(nil);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  intCalSal := fCfgSis('CALSAL', varInteger);

  StrTabPreco:= '1';
  FTipoOrigem := ATipoOrigem;
  FProgress := aProgress;
  FqryDados := TZClient.Create(nil);
  FQryDados.qryQuery.SQL.Add('SELECT CAST("" AS CHAR(30)) AS CODITE,');
  FQryDados.qryQuery.SQL.Add('       ITE_DESITE AS DESITE,');
  FQryDados.qryQuery.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
  FQryDados.qryQuery.SQL.Add('       ITE_CODUNI AS CODUNI,');
  FQryDados.qryQuery.SQL.Add('       ITEGER.ITE_CODEMP AS CODEMP,');
  FQryDados.qryQuery.SQL.Add('       ITE_CODMAR as CODMAR,');
  FQryDados.qryQuery.SQL.Add('       ITE_SALDOS AS SALDOS,');
  FQryDados.qryQuery.SQL.Add('       ITE_SALDOS AS SALDIS,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS  PEDCOM,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS QTDIMP,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS QTDSUG,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS VLRUNI,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS VLRTOT,');
  FQryDados.qryQuery.SQL.Add('       CAST("" AS CHAR(50)) AS GRUPO,');
  FQryDados.qryQuery.SQL.Add('       ITE_CODFOR AS CODFOR,');
  FQryDados.qryQuery.SQL.Add('       FOR_NOMFOR AS NOMFOR,');
  FQryDados.qryQuery.SQL.Add('       0 AS IDENTIFICADO,');
  FQryDados.qryQuery.SQL.Add('       0 AS MARCADO,');
  FQryDados.qryQuery.SQL.Add('       ITE_CODFAB AS ARQ_CODFAB,');
  FQryDados.qryQuery.SQL.Add('       ITE_DESITE AS ARQ_DESITE,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS ARQ_QTDITE,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS ARQ_PRCITE,');
  FQryDados.qryQuery.SQL.Add('       0.00 AS AUT_PRCITE');
  FQryDados.qryQuery.SQL.Add('  FROM CADITE');
  FQryDados.qryQuery.SQL.Add(' INNER JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE');
  FQryDados.qryQuery.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = CADITE.ITE_CODFOR');
  FQryDados.qryQuery.SQL.Add(' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
  FQryDados.qryQuery.SQL.Add(' WHERE FALSE ');

  FQryDados.fAbreClient(True);
  FQryConsulta := fCriaQuery;
  FqryDados.IndexFieldNames := 'CODITE;DESITE';

  FcdsTotais :=  TZClient.Create(Nil);
  FcdsTotais.qryQuery.SQL.Add('SELECT FOR_CODFOR AS CODFOR, FOR_NOMFOR AS NOMFOR, 0.00 AS TOTPED FROM CADFOR WHERE FALSE ');
  FcdsTotais.fAbreClient(True);

end;

destructor TProcessaArquivo.Destroy;
begin
  FreeAndNil(FqryDados);
  FreeAndNil(FqryOrdem);
  FreeAndNil(FQryConsulta);

  inherited;
end;

procedure TProcessaArquivo.pSQlBase(blnIteFor: Boolean; strCodIte: String);
Begin
  FQryConsulta.SQL.Add('SELECT SIS_VALCFG,');
  FQryConsulta.SQL.Add('       CADITE.ITE_CODITE AS CODITE,');
  FQryConsulta.SQL.Add('       ITE_DESITE AS DESITE,');
  FQryConsulta.SQL.Add('       UNI_SIGUNI AS SIGUNI,');
  FQryConsulta.SQL.Add('       UNI_CODUNI AS CODUNI,');

  FQryConsulta.SQL.Add('       ITE_SALDOS AS SALDOS,');
  FQryConsulta.SQL.Add('       I.ITE_CODEMP AS CODEMP,');
  FQryConsulta.SQL.Add('       I.ITE_PREVE' + StrTabPreco + ' AS ITE_PREVEN,');
  FQryConsulta.SQL.Add('       ITE_CODMAR AS CODMAR,');
  FQryConsulta.SQL.Add('       0 AS SALDIS,');
  FQryConsulta.SQL.Add('       (IFNULL((SELECT IFNULL(SUM(PCD_QTDITE - PCD_QTDBAI),0)');
  FQryConsulta.SQL.Add('                  FROM PCMDET');
  FQryConsulta.SQL.Add('                 INNER JOIN PCMGER ON  PCD_NUMPED = PCG_NUMPED AND  PCD_ESPDOC = PCG_ESPDOC AND  PCD_CODEMP = PCG_CODEMP');
  FQryConsulta.SQL.Add('                 WHERE PCD_ESPDOC = "PD"');
  FQryConsulta.SQL.Add('                   AND PCD_CODITE = I.ITE_CODITE');
  FQryConsulta.SQL.Add('                   AND  PCD_BAIXAD = 0');
  FQryConsulta.SQL.Add('                   AND LOCATE(IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES),I.ITE_CODEMP ) > 0 ), 0)) AS PEDCOM,');
  FQryConsulta.SQL.Add('       0 AS QTDIMP,');
  FQryConsulta.SQL.Add('       0 AS QTDSUG,');
  FQryConsulta.SQL.Add('       IF(FPR_VALITE > 0, FPR_VALITE,');
  FQryConsulta.SQL.Add('       CASE WHEN (SIS_VALCFG = "1") OR (SIS_VALCFG = "7")  THEN I.ITE_PRECOM');
  FQryConsulta.SQL.Add('            WHEN (SIS_VALCFG = "2") OR (SIS_VALCFG = "6") THEN I.ITE_PRECOM * (1 - I.ITE_DESF01 / 100) *');
  FQryConsulta.SQL.Add('                                                                              (1 - I.ITE_DESF02 / 100) *');
  FQryConsulta.SQL.Add('                                                                              (1 - I.ITE_DESF03 / 100) *');
  FQryConsulta.SQL.Add('                                                                              (1 - I.ITE_DESF04 / 100) *');
  FQryConsulta.SQL.Add('                                                                              (1 - I.ITE_DESF05 / 100) *');
  FQryConsulta.SQL.Add('                                                                              (1 - I.ITE_DESF06 / 100)');
  FQryConsulta.SQL.Add('            WHEN SIS_VALCFG = "3" THEN I.ITE_PRECUS');
  FQryConsulta.SQL.Add('            WHEN SIS_VALCFG = "4" THEN I.ITE_PRECOM * (1 - I.ITE_DESF01 / 100) *');
  FQryConsulta.SQL.Add('                                                      (1 - I.ITE_DESF02 / 100) *');
  FQryConsulta.SQL.Add('                                                      (1 - I.ITE_DESF03 / 100) *');
  FQryConsulta.SQL.Add('                                                      (1 - I.ITE_DESF04 / 100) *');
  FQryConsulta.SQL.Add('                                                      (1 - I.ITE_DESF05 / 100) *');
  FQryConsulta.SQL.Add('                                                      (1 - I.ITE_DESF06 / 100) *');
  FQryConsulta.SQL.Add('                                                      (I.ITE_ACRFIN/ 100 )');
  FQryConsulta.SQL.Add('            WHEN SIS_VALCFG = "8" THEN ITE_PREULT');
  FQryConsulta.SQL.Add('        ELSE');
  FQryConsulta.SQL.Add('          I.ITE_PRECOM END) AS VLRUNI,');
  FQryConsulta.SQL.Add('       0 AS VLRTOT,');
  FQryConsulta.SQL.Add('       CADFOR.FOR_CODFOR AS CODFOR,');
  FQryConsulta.SQL.Add('       FOR_NOMFOR AS NOMFOR');
  FQryConsulta.SQL.Add('  FROM CADITE');
  FQryConsulta.SQL.Add(' INNER JOIN ITEGER I ON CADITE.ITE_CODITE = I.ITE_CODITE');
  If blnIteFor Then
  Begin
    FQryConsulta.SQL.Add(' INNER JOIN ITEFOR F ON F.ITE_CODITE = CADITE.ITE_CODITE AND F.ITE_CODITF= "' +  Trim(strCodIte) +'"' );
    FQryConsulta.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = F.ITE_CODFOR');
  End
  Else
  FQryConsulta.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = CADITE.ITE_CODFOR');
  FQryConsulta.SQL.Add(' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
  FQryConsulta.SQL.Add(' LEFT JOIN FORPRE ON FPR_CODFOR = CADITE.ITE_CODFOR AND FPR_CODITE = CADITE.ITE_CODITE');
  FQryConsulta.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_UNIPCG" AND SIS_CODEMP = "' +  VS_strCodEmp + '"');

End;


function TProcessaArquivo.fCarregaItem(strCodIte: string; var intQtdFornecedores: Integer; blnCodFab: Boolean = True): Boolean;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT * FROM (');
  pSQLBase(False, strCodIte);
  FQryConsulta.SQL.Add('WHERE I.ITE_CODEMP =  "' +  VS_strCodEmp + '"');
  If blnCodFab Then
      FQryConsulta.SQL.Add('  AND CADITE.ITE_CODFAB LIKE (' + QuotedStr('%' + Trim(strCodIte) + '%') + ') ')
    Else
      FQryConsulta.SQL.Add('  AND CADITE.ITE_CODITE = "' +  strCodIte +'"');
  If blnCodFab Then
  Begin
    FQryConsulta.SQL.Add('UNION ALL ');
    pSQLBase(True, strCodIte);
    FQryConsulta.SQL.Add('WHERE I.ITE_CODEMP =  "' +  VS_strCodEmp + '"');
  End;

  FQryConsulta.SQL.Add(') AS TMP ');
  FQryConsulta.SQL.Add('GROUP BY CODITE, CODFOR');

  FQryConsulta.Open;
  Result := Not FQryConsulta.IsEmpty;
  intQtdFornecedores := FQryConsulta.RecordCount;
end;


function TProcessaArquivo.fGeraPedidoCompra: Boolean;
  Var
    objGeraOrc: TGeraOrc;
    item: TItem;
    intDecUni: integer;
begin
  Result := False;
  FqryDados.Filtered := False;
  FQryDados.Filter := 'IDENTIFICADO <> 0 AND CODFOR = ' +QuotedStr('') + ' AND QTDSUG > 0';
  FqryDados.Filtered := True;
  If Not FqryDados.IsEmpty Then
  Begin
    pMensagemOk('Um ou mais itens não foi informado o fornecedor. Será preciso corrigir para prosseguir.');
    Result := False;
    Exit;
  End;

  pGravaIteFor;

  FqryDados.Filtered := False;
  FQryDados.Filter := 'IDENTIFICADO <> 0 AND CODFOR <> ' +QuotedStr('') + ' AND QTDSUG > 0';
  FqryDados.Filtered := True;

  objGeraOrc := TGeraOrc.Create;
  Try
    FProgress.Visible := True;
    FProgress.Position := 0;
    FProgress.Properties.Max := FQryDados.RecordCount;
    Application.ProcessMessages;

    intDecUni := fCfgSis('DECUNI');

    While Not FQryDados.Eof Do
    Begin
      item.strCodEmp := FqryDados.FieldByName('CODEMP').AsString;
      item.strCodFor := FqryDados.FieldByName('CODFOR').AsString;
      item.strCodIte := FqryDados.FieldByName('CODITE').AsString;
      item.strCodMar := FqryDados.FieldByName('CODMAR').AsString;
      item.strCodUni := FqryDados.FieldByName('CODUNI').AsString;
      item.strDesIte := FqryDados.FieldByName('DESITE').AsString;

      item.fltPreCus := fFormataFloatInterna(FqryDados.FieldByName('VLRUNI').AsFloat, intDecUni);

      item.fltQtdIte := FqryDados.FieldByName('QTDSUG').AsFloat;

      item.fltEmbala := 1;

      objGeraOrc.pAddItem(item, 0);

      FProgress.Position :=  FProgress.Position + 1;
      Application.ProcessMessages;

      FqryDados.Next;
    End;

    If Assigned(frmGravando) Then
    Begin
      frmGravando.lblGravando.Caption := 'Aguarde, gerando orçamentos de compra...';
      Application.ProcessMessages;
    End;

    objGeraOrc.pgbProgress := FProgress;

    objGeraOrc.pGerarOrcamentos(True);

    If objGeraOrc.intQtdOrcamentoGerado = 0 Then
      fMensagem('', 'Nenhum orçamento gerado!', ['&Ok'])
    Else
    Begin
      fMensagem('', 'Foram gerados '+ IntToStr(objGeraOrc.intQtdOrcamentoGerado) +' orçamentos!', ['&Ok']);
      FqryDados.EmptyDataSet;
      Result := True;
    End;

  Finally
    objGeraOrc.Free;
    FProgress.Visible := True;
    FProgress.Position := 0;
    FqryDados.Filtered := False;
    FQryDados.Filter := '';

  End;

end;

function TProcessaArquivo.fInsertKommerling: Boolean;
begin
  Result := (FqryDados.State = dsInsert);
  If Result Then
    result := (FTipoLayout = tlKommerling)
end;

procedure TProcessaArquivo.OnAfterEdit(DataSet: TDataSet);
begin
  FCodForOldValue := FqryDados.FieldByName('CODFOR').AsString;
  FCodIteOldValue := FqryDados.FieldByName('CODITE').AsString;
  FQtdIteOldValue := FqryDados.FieldByName('QTDSUG').AsFloat;
end;

procedure TProcessaArquivo.OnAfterPost(DataSet: TDataSet);
var strCodFor: String;
    strDescFor: String;
    intRecNo: integer;
begin
  intRecNo := 0;
  If (FqryDados.FieldByName('MARCADO').AsInteger = 1) And
     (FqryDados.FieldByName('CODFOR').AsString <> FCodForOldValue) Then
  Begin
    strCodFor := FqryDados.FieldByName('CODFOR').AsString;
    strDescFor := FqryDados.FieldByName('NOMFOR').AsString;
    FqryDados.AfterPost := nil;
    FqryDados.DisableControls;
    Try
      intRecNo := FqryDados.RecNo;
      FqryDados.Filtered := False;
      FqryDados.Filter := 'MARCADO = 1';
      FqryDados.Filtered := True;
      FqryDados.First;
      While Not FqryDados.IsEmpty Do
      Begin
        FqryDados.Edit;
        FqryDados.FieldByName('CODFOR').AsString := strCodFor;
        FqryDados.FieldByName('NOMFOR').AsString := strDescFor;
        FqryDados.FieldByName('MARCADO').AsInteger := 0;
        FQryDados.Post;
        FqryDados.Next;
      End;
      FqryDados.AfterPost := OnAfterPost;
      FqryDados.Filtered := False;
    Finally
      FqryDados.RecNo := intRecNo;
      FqryDados.EnableControls;
    End;
  End;

end;

procedure TProcessaArquivo.pTrataFornecedor(var strBckDes: string);
begin
  strBckDes := FqryDados.FieldByName('NOMFOR').AsString;
  FqryDados.FieldByName('CODFOR').AsString := fPadL(FqryDados.FieldByName('CODFOR').AsString, 8, '0');
  FqryDados.FieldByName('NOMFOR').AsString := fRetNomFornecedor(FqryDados.FieldByName('CODFOR').AsString);
  If fEmptyStr(FqryDados.FieldByName('NOMFOR').AsString) Then
  Begin
    FqryDados.FieldByName('NOMFOR').AsString := strBckDes;
    FqryDados.FieldByName('CODFOR').AsString := FCodForOldValue;
    pMensagemOk('Código do Fornecedor Inválido.')
  End;
  If (FqryDados.FieldByName('CODFOR').AsString <> FCodForOldValue) Then
  Begin
    If Not fValidaCodigoFabrica(FqryDados.FieldByName('CODFOR').AsString,
                                FqryDados.FieldByName('ARQ_CODFAB').AsString,
                                FQryDados.FieldByName('CODITE').AsString) Then
    Begin
      FqryDados.FieldByName('NOMFOR').AsString := strBckDes;
      FqryDados.FieldByName('CODFOR').AsString := FCodForOldValue;
    End
    Else If FqryDados.FieldByName('IDENTIFICADO').AsInteger <> tsiDuplicado Then
      FqryDados.FieldByName('IDENTIFICADO').AsInteger := tsiInformado;
  End;
end;

procedure TProcessaArquivo.pTrataProduto(var qtdFornecedor: integer);
begin
  If FQryDados.FieldByName('CODITE').AsString <> FCodIteOldValue Then
  Begin
    If fCarregaItem(FQryDados.FieldByName('CODITE').AsString, qtdFornecedor,False) Then
    Begin
      If (FqryDados.FieldByName('IDENTIFICADO').AsInteger = tsiNaoEncontrado) And
         (Not fValidaCodigoFabrica( IIf(FqryDados.FieldByName('CODFOR').AsString = '',
                                        FQryConsulta.FieldByName('CODFOR').AsString,
                                        FqryDados.FieldByName('CODFOR').AsString),

                                    FqryDados.FieldByName('ARQ_CODFAB').AsString,
                                    FQryDados.FieldByName('CODITE').AsString)) Then
         FQryDados.FieldByName('CODITE').AsString := FCodIteOldValue
       Else
         pInsereCamposPadrao(True);

    End
    Else
    begin
      FQryDados.FieldByName('CODITE').AsString := FCodIteOldValue;
      pMensagemOk('Código de produto Inválido.')

    End
  End;
end;

function TProcessaArquivo.fDefineCodItePar(strCodItePar: string): Boolean;
begin
  If (FTipoOrigem = toAnaliseDeCompra) Then
    Exit(true);
  result := (strCodItePar = '');
  If result  Then
    result := (FQryDados.FieldByName('ARQ_CODFAB').AsString <> '')
end;

procedure TProcessaArquivo.pTrataInsertKommerling(var qtdFornecedor: integer);
var strCodItePar: string;
begin
  strCodItePar := FQryDados.FieldByName('CODITE').AsString;
  If fDefineCodItePar(strCodItePar) then
    strCodItePar := FQryDados.FieldByName('ARQ_CODFAB').AsString;

  pTrataItem(qtdFornecedor, strCodItePar);

  If FTipoOrigem = toAnaliseDeCompra Then
  Begin
    If FQryDados.FieldByName('CODITE').AsString = '' Then
      FQryDados.FieldByName('CODITE').AsString := FQryDados.FieldByName('ARQ_CODFAB').AsString;
    FQryDados.FieldByName('DESITE').AsString := FQryDados.FieldByName('ARQ_DESITE').AsString;
  End;
End;


procedure TProcessaArquivo.pTrataItem(var qtdFornecedor: integer; var strCodItePar: string);
begin
  If fCarregaItem(strCodItePar, qtdFornecedor, IIf(FTipoOrigem = toAnaliseDeCompra, True, (FQryDados.FieldByName('CODITE').AsString =  ''))) Then
  Begin
    If FQryDados.FieldByName('CODITE').AsString = ''  Then
      FQryDados.FieldByName('QTDIMP').AsFloat  := FQryDados.FieldByName('ARQ_QTDITE').AsFloat;

    pInsereCamposPadrao(False);
    If qtdFornecedor > 1 Then
      FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiDuplicado;
  End
  Else
    FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiNaoEncontrado;
End;

procedure TProcessaArquivo.OnBeforePost(DataSet: TDataSet);
  var strBckDes: string;
      qtdFornecedor: integer;

begin
  If FqryDados.State = dsEdit Then
  Begin
    If FqryDados.FieldByName('CODFOR').AsString = '' Then
      FqryDados.FieldByName('NOMFOR').AsString := ''
    Else If (FqryDados.FieldByName('CODFOR').AsString <> FCodForOldValue) Then
      pTrataFornecedor(strBckDes);

    If FQryDados.FieldByName('QTDSUG').AsFloat <> FQtdIteOldValue then
      FQryDados.FieldByName('VLRTOT').AsFloat  := FQryDados.FieldByName('QTDSUG').AsFloat *
                                                  FQryDados.FieldByName('VLRUNI').AsFloat;
    pTrataProduto(qtdFornecedor);
  End
  Else If fInsertKommerling Then
    pTrataInsertKommerling(qtdFornecedor)

end;

function TProcessaArquivo.fTrataQuantidadeSugestao(Value: Double): Double;
Begin
  Result := Value;
  If Value > 0 Then
    Result := 0
  Else
    Result := (Result * -1);
End;

function TProcessaArquivo.fTrataStringProjeto(AProjeto: String): String;
begin
  AProjeto := AnsiReverseString(AProjeto);
  AProjeto := AnsiReplaceStr(AProjeto, Copy(AProjeto, 1, 19), '');
  AProjeto := AnsiReverseString(AProjeto);
  Result := AProjeto;
   {}
end;

procedure TProcessaArquivo.pCalculaCDSTotais;
var recNo: integer;
begin
  recNo := FqryDados.RecNo;
  FcdsTotais.EmptyDataSet;
  Try
//  FcdsTotais.IndexFieldNames := 'CODFOR';
    FqryDados.DisableControls;
    FqryDados.First;
    FProgress.Visible := True;
    FProgress.Properties.Max := FqryDados.RecordCount -1;

    while not FqryDados.Eof do
    Begin

      Try
        If FqryDados.FieldByName('CODFOR').AsString = '' Then
          Continue;
        FcdsTotais.Filtered := False;
        FcdsTotais.Filter := 'CODFOR = ' + fQuotedStr(FqryDados.FieldByName('CODFOR').AsString);
        FcdsTotais.Filtered := True;

        If FCdsTotais.IsEmpty THen
        Begin
          FcdsTotais.Filtered := False;
          FcdsTotais.Insert;
          FcdsTotais.FieldByName('CODFOR').AsString := FqryDados.FieldByName('CODFOR').AsString;
          FcdsTotais.FieldByName('NOMFOR').AsString := FqryDados.FieldByName('NOMFOR').AsString;

        End
        Else
           FcdsTotais.Edit;
        FcdsTotais.FieldByName('TOTPED').AsFloat:= FcdsTotais.FieldByName('TOTPED').AsFloat + FqryDados.FieldByName('VLRTOT').AsFloat;
        FcdsTotais.Post;
      Finally
        FqryDados.Next;
        FProgress.Position := FProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;
    FProgress.Visible := False;

    FcdsTotais.Filtered := False;
  Finally
    FqryDados.RecNo := recNo;
    FqryDados.EnableControls;
  End
end;

procedure TProcessaArquivo.pEscolheItensDuplicados;
begin
  inherited;
  If FQryDados.FieldByName('IDENTIFICADO').AsInteger = tsiDuplicado Then
  Begin
    FQryConsulta.sql.Clear;
    FQryConsulta.SQL.Add('SELECT * FROM ( ');
    FQryConsulta.SQL.Add('SELECT F.ITE_CODITE AS CODITE,');
    If fCfgSis('TABPRF', varBoolean) Then
      FQryConsulta.SQL.Add('       F.ITE_CODFAB AS CODFAB,')
    Else
      FQryConsulta.SQL.Add('       F.ITE_CODITF AS CODFAB,');
    FQryConsulta.SQL.Add('       C.ITE_DESITE AS DESITE,');
    FQryConsulta.SQL.Add('       F.ITE_CODFOR AS CODFOR,');
    FQryConsulta.SQL.Add('       G.ITE_SALDOS AS SALDOS,');
    FQryConsulta.SQL.Add('       FOR_NOMFOR AS DESFOR');
    FQryConsulta.SQL.Add('  FROM ITEFOR F');
    FQryConsulta.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE');
    FQryConsulta.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND G.ITE_CODEMP = "'+VS_StrCodEmp+'"');

    FQryConsulta.SQL.Add(' INNER JOIN CADFOR  ON FOR_CODFOR = F.ITE_CODFOR');
    FQryConsulta.SQL.Add(' WHERE TRUE');
    If fCfgSis('TABPRF', varBoolean) Then
      FQryConsulta.SQL.Add('  AND F.ITE_CODFAB = :CODFAB    ')
    Else
      FQryConsulta.SQL.Add('  AND F.ITE_CODITF = :CODFAB    ');
    FQryConsulta.SQL.Add(' UNION ALL');
    FQryConsulta.SQL.Add('SELECT C.ITE_CODITE AS CODITE,');
    FQryConsulta.SQL.Add('       C.ITE_CODFAB AS CODFAB,');
    FQryConsulta.SQL.Add('       C.ITE_DESITE AS DESITE,');
    FQryConsulta.SQL.Add('       C.ITE_CODFOR AS CODFOR,');
    FQryConsulta.SQL.Add('       G.ITE_SALDOS AS SALDOS,');
    FQryConsulta.SQL.Add('       F.FOR_NOMFOR AS DESFOR');
    FQryConsulta.SQL.Add('  FROM CADITE C');
    FQryConsulta.SQL.Add(' INNER JOIN CADFOR F ON FOR_CODFOR = ITE_CODFOR');
    FQryConsulta.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND G.ITE_CODEMP = "'+VS_StrCodEmp+'"');
    FQryConsulta.SQL.Add('  WHERE C.ITE_CODFAB LIKE (' + QuotedStr('%' + FqryDados.FieldByName('ARQ_CODFAB').AsString + '%') + ') ');
    FQryConsulta.SQL.Add('  )AS TMP ');
    FQryConsulta.SQL.Add(' GROUP BY CODITE, CODFOR ');

    FQryConsulta.ParamByName('CODFAB').AsString := FqryDados.FieldByName('ARQ_CODFAB').AsString;
    FQryConsulta.Open;

    If FQryConsulta.IsEmpty Then
      Exit;
    pSelecionaItens ;
  End;

end;

procedure TProcessaArquivo.pSelecionaItens;
var frmSelecionaItemDuplicadoCodFabrica: TfrmSelecionaItemDuplicadoCodFabrica;
    recSaldos,
    recSaldosML: TRecSaldos;
    fltCnvML,
    fltSaldos: Double;
begin
  fltCnvML := 0;

  pCriarFormularios(TfrmSelecionaItemDuplicadoCodFabrica, frmSelecionaItemDuplicadoCodFabrica);
  Try
    frmSelecionaItemDuplicadoCodFabrica.dtsItens.DataSet := FQryConsulta;
    frmSelecionaItemDuplicadoCodFabrica.ShowModal;
    If frmSelecionaItemDuplicadoCodFabrica.blnConfirmou Then
    Begin
      FqryDados.Edit;
      FqryDados.FieldByName('CODITE').AsString := FQryConsulta.FieldByName('CODITE').AsString;
      FqryDados.FieldByName('CODFOR').AsString := FQryConsulta.FieldByName('CODFOR').AsString;

      fltSaldos := FQryConsulta.FieldByName('SALDOS').AsFloat;
      FQryDados.FieldByName('SALDOS').AsString := FQryConsulta.FieldByName('SALDOS').AsString;
      objSalLoj.pCalculaSaldos(nil, recSaldos, recSaldosML,
                                fltSaldos, VS_StrCodEmp, VS_StrCodEmp,
                                FQryConsulta.FieldByName('CODITE').AsString, fltCnvML,
                                blnEntFut, False, blnOrdPro, intCalSal);

      FQryDados.FieldByName('SALDIS').AsFloat  := recSaldos.fltSalDis + fRetSaldoReservadoOrdem(FQryDados.FieldByName('CODITE').AsString);

      FqryDados.Post;
    End
  Finally
    pFreeAndNil(frmSelecionaItemDuplicadoCodFabrica);
  End;
End;

procedure TProcessaArquivo.pGravaITEFOR;
begin
  FqryDados.Filtered := False;
  FQryDados.Filter := 'IDENTIFICADO = 2 AND CODFOR <> ' +QuotedStr('');
  FqryDados.Filtered := True;
  FqryDados.First;

  While Not FqryDados.Eof Do
  Begin
    FQryConsulta.SQL.Clear;
    FQryConsulta.SQL.Add('INSERT INTO ITEFOR (AUTOINCREM, ITE_CODITE, ITE_CODFOR, ITE_CODEMP,  ITE_CODITF, ITE_CODFAB ) VALUES (');
    FQryConsulta.SQL.Add('                    :AUTINC, :CODITE, :CODFOR, :CODEMP, :CODITF, :CODFAB)');
    FQryConsulta.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEFOR', VS_StrCodEmp);
    FQryConsulta.ParamByName('CODITE').AsString := FqryDados.FieldByName('CODITE').AsString;
    FQryConsulta.ParamByName('CODFOR').AsString := FqryDados.FieldByName('CODFOR').AsString;
    FQryConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    FQryConsulta.ParamByName('CODFAB').AsString := FqryDados.FieldByName('ARQ_CODFAB').AsString;
    FQryConsulta.ParamByName('CODITF').AsString := FqryDados.FieldByName('ARQ_CODFAB').AsString;
    FQryConsulta.ExecSQL;
    FqryDados.Next;
  End;
  FqryDados.Filtered := False;
  FQryDados.Filter := '';

end;

function TProcessaArquivo.fRetSaldoReservadoOrdem(strCodIte: String): Double;
begin
  Result := 0;
  If fEmptyStr(strNumPed) Then
    Exit;

  FqryOrdem.First;

  If FqryOrdem.Locate('DOP_ITESUB', strCodIte, []) then
    Result := FqryOrdem.FieldByName('DOP_QTDITE').AsFloat;
End;

procedure TProcessaArquivo.pInsereCamposPadrao(blnIndentificadoAposImportacao: Boolean);
var recSaldos,
    recSaldosML: TRecSaldos;
    fltCnvML,
    fltSaldos: Double;

Begin
  fltCnvML := 0;
  fltSaldos := FQryConsulta.FieldByName('SALDOS').AsFloat;

  FQryDados.FieldByName('CODITE').AsString := FQryConsulta.FieldByName('CODITE').AsString;
  FQryDados.FieldByName('DESITE').AsString := FQryConsulta.FieldByName('DESITE').AsString;
  FQryDados.FieldByName('CODUNI').AsString := FQryConsulta.FieldByName('CODUNI').AsString;
  FQryDados.FieldByName('SALDOS').AsString := FQryConsulta.FieldByName('SALDOS').AsString;
  FqryDados.FieldByName('CODEMP').AsString := FQryConsulta.FieldByName('CODEMP').AsString;
  FqryDados.FieldByName('CODMAR').AsString := FQryConsulta.FieldByName('CODMAR').AsString;
  FqryDados.FieldByName('SIGUNI').AsString := FQryConsulta.FieldByName('SIGUNI').AsString;
  objSalLoj.pCalculaSaldos(Nil, recSaldos, recSaldosML,
                            fltSaldos, VS_StrCodEmp, VS_StrCodEmp,
                            FQryConsulta.FieldByName('CODITE').AsString, fltCnvML,
                            blnEntFut, False, blnOrdPro, intCalSal);

  FQryDados.FieldByName('SALDIS').AsFloat  := recSaldos.fltSalDis + fRetSaldoReservadoOrdem(FQryDados.FieldByName('CODITE').AsString);

  If  recSaldos.fltSalDis <= 0 Then
    blnTemItemSemSaldo := true;
  FQryDados.FieldByName('PEDCOM').AsString := FQryConsulta.FieldByName('PEDCOM').AsString;
  If TipoLayout =  tlDeceuninckOrdemProducao Then
    FQryDados.FieldByName('QTDSUG').AsFloat  := FQryDados.FieldByName('QTDIMP').AsFloat
  Else
    FQryDados.FieldByName('QTDSUG').AsFloat  := fTrataQuantidadeSugestao(FQryDados.FieldByName('SALDIS').AsFloat +
                                                FQryDados.FieldByName('PEDCOM').AsFloat -
                                                FQryDados.FieldByName('QTDIMP').AsFloat);
  FQryDados.FieldByName('VLRUNI').AsString := FQryConsulta.FieldByName('VLRUNI').AsString;
  FQryDados.FieldByName('VLRTOT').AsFloat  := FQryDados.FieldByName('QTDSUG').AsFloat *
                                              FQryDados.FieldByName('VLRUNI').AsFloat;
  FQryDados.FieldByName('CODFOR').AsString := FQryConsulta.FieldByName('CODFOR').AsString;
  FQryDados.FieldByName('NOMFOR').AsString := FQryConsulta.FieldByName('NOMFOR').AsString;
  FQryDados.FieldByName('NOMFOR').AsString := FQryConsulta.FieldByName('NOMFOR').AsString;
  FQryDados.FieldByName('AUT_PRCITE').AsFloat := FQryConsulta.FieldByName('ITE_PREVEN').AsFloat;
  If (FQryDados.FieldByName('IDENTIFICADO').AsInteger = tsiNaoEncontrado) Then
  Begin
    If (blnIndentificadoAposImportacao) Then
      FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiInformado
    Else
      FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiEncontrado;
  End;
End;

function TProcessaArquivo.fPodeValidarCodFab(strCodFor, strCodFab, strCodIte: String): Boolean;
begin
  Result := True;
  If (strCodFor <> '') Then
    Exit(False);
  If (strCodIte = '') Then
    Exit(False);
  If (StrCodFab = '') Then
    Exit(False);
End;

function TProcessaArquivo.fValidaCodigoFabrica(strCodFor, strCodFab, strCodIte: String): Boolean;
var strItemAssociado: string;
begin
  Result := True;
  If fPodeValidarCodFab(strCodFor, strCodFab, strCodIte) Then
    Result :=  fValidaCodForFab(strCodFor, strCodFab, strCodIte, strItemAssociado);
  If Not result Then
    fMensagem('', 'O Código de Fabrica ' + StrCodFab +
                    ' não pode ser associado ao item  ' + strCodIte +
                    ' e fornecedor ' + strCodFor +
                    ' pois esta associação já esta feita para o item ' + strItemAssociado, ['&Ok']);
end;

procedure TProcessaArquivo.pInsereCDS(strCodIte, strQuantidade, strNome, strPreco: string);
var intQtdFornec: Integer;
begin
  FQryDados.Insert;
  FQryDados.FieldByName('ARQ_CODFAB').AsString := strCodIte;
  FQryDados.FieldByName('ARQ_DESITE').AsString := strNome;
  FQryDados.FieldByName('ARQ_QTDITE').AsString := strQuantidade;
  FQryDados.FieldByName('ARQ_PRCITE').AsString := strPreco;
  FQryDados.FieldByName('GRUPO').AsString := FGrupoAtual;

  If fCarregaItem(strCodIte, intQtdFornec, True) Then
  Begin
    FQryDados.FieldByName('QTDIMP').AsString := strQuantidade;
    pInsereCamposPadrao(False);
    //Encontrado porem mais de um item para este codigo de fabrica com fornecedor distinto
    If intQtdFornec > 1 Then
      FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiDuplicado;
  End
  Else
  Begin
    If FTipoOrigem <> toListaMaterial Then
    Begin
      FQryDados.FieldByName('CODITE').AsString := strCodIte;
      FQryDados.FieldByName('DESITE').AsString := strNome;
      FQryDados.FieldByName('QTDIMP').AsString := strQuantidade;
    End;
    FQryDados.FieldByName('IDENTIFICADO').AsInteger := tsiNaoEncontrado;
  End;
  FQryDados.Post;
end;


procedure TProcessaArquivo.pLocalizaColunas(intLinha: integer; var strColunaCodigo: string; var strColunaQuantidade: string; var strColunaPreco: string);
begin
  If Not FobjExcel.fLocalizaColunaCSV('Código', strColunaCodigo, intLinha) Then
    raise Exception.Create('Falha ao ler estrutura do arquivo. Não possivel encontrar o campo "Código" , linha ' + intToStr(intLinha + 1) + '.');

  If Not FobjExcel.fLocalizaColunaCSV('Quantidade', strColunaQuantidade, intLinha) Then
    raise Exception.Create('Falha ao ler estrutura do arquivo. Não possivel encontrar os campos "Quantidade", linha ' + intToStr(intLinha + 1) + '.');

  If Not FobjExcel.fLocalizaColunaCSV('Valor Unitário', strColunaPreco, intLinha) Then
    raise Exception.Create('Falha ao ler estrutura do arquivo. Não possivel encontrar o campo "Valor Unitário", linha ' + intToStr(intLinha + 1) + '.');
end;

function TProcessaArquivo.IsNumeric(Value: String): Boolean;
 var iChar: Integer;
Begin
  Value := Trim(Value);
  Result := False;
  For iChar := 1 To Length(Value) Do
  Begin
    Result := Value[iChar].IsNumber;
    If not Result Then
      Break;
  End;
End;

function TProcessaArquivo.IsDeceuninck: Boolean;
begin
  result := TipoLayout = tlDeceuninck;
  If not Result then
    Result := (TipoLayout = tlDeceuninckOrdemProducao)
end;

function TProcessaArquivo.fPodeInserir(strCodIte, strQuantidade: String): Boolean;
begin
  Result := True;
  If (strCodIte = '') Then
    Exit(False);
  If (strQuantidade = '') Then
    Exit(False);
end;

procedure TProcessaArquivo.preencheDadosDeceuninck(intLinha: integer; strColunaCodigo, strColunaNome, strColunaQuantidade, strColunaPreco: String);
var strCodIte,
    strQuantidade,
    strPreco,
    strNome: String;

begin
  strCodIte     := '';
  strQuantidade := '';
  strPreco      := '';

  strCodIte := FobjExcel.fGetValueCSV(intLinha, strColunaCodigo);
  strNome   := FobjExcel.fGetValueCSV(intLinha, strColunaNome);
  If strCodIte <> '' Then
  Begin
    strQuantidade := AnsiReplaceStr(FobjExcel.fGetValueCSV(intLinha, strColunaQuantidade), '.', '');
    strPreco      := FobjExcel.fGetValueCSV(intLinha, strColunaPreco);
  End;
  If fPodeInserir(strCodIte, strQuantidade) Then
    pInsereCDS(strCodIte, strQuantidade, strNome, strPreco);
end;


procedure TProcessaArquivo.processaDeceuninck;
  var strColunaCodigo, strColunaQuantidade, strColunaNome, strColunaPreco: string;
      intLinha: Integer;
      strErro: String;
begin

  blnTemItemSemSaldo := False;
  FProgress.Properties.Max := (FobjExcel.ArquivoCSV.Count -1);
  If (TipoLayout = tlDeceuninckOrdemProducao) Then
    FProjeto :=  fTrataStringProjeto(FobjExcel.fGetValueCSV(6, 'J'));
  If strNumPed <> '' Then
  Begin
    pCarregaQryOrdem(strErro);
    If strErro <> '' Then
    Begin
      pMensagemOk(strErro);
      Exit;
    End;
  End;
  FGrupoAtual := '';
  For intLinha := 0 To (FobjExcel.ArquivoCSV.Count -1) Do
  Begin
    pSetaGrupoAtual(intLinha);
    //Localizou Titulos
    If Trim(FobjExcel.fGetValueCSV(intLinha, 'A')) = 'Nº.' Then
    Begin
       If FobjExcel.fLocalizaColunaCSV('Características', strColunaNome, intLinha) Then
         break;
       pLocalizaColunas(intLinha, strColunaCodigo, strColunaQuantidade, strColunaPreco);
       FobjExcel.fLocalizaColunaCSV('Nome', strColunaNome, intLinha);
    End
    Else If IsNumeric(FobjExcel.fGetValueCSV(intLinha, 'A')) Then
        preencheDadosDeceuninck(intLinha, strColunaCodigo, strColunaNome, strColunaQuantidade, strColunaPreco);
    FProgress.Position := intLinha;
    Application.ProcessMessages;
  End
End;


procedure TProcessaArquivo.pCarregaQryOrdem(var strErro: String);
begin
  strErro := '';
  If FProjeto <> '' Then
  Begin
    FQryOrdem.SQL.Clear;
    FQryOrdem.SQL.Add('SELECT D.DOP_QTDITE, D.DOP_ITESUB, PRO_PROJEC FROM DETPRO D');
    FQryOrdem.SQL.Add('INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER');
    FQryOrdem.SQL.Add('WHERE PRO_NUMPED = ' + QuotedStr(strNumPed));
    FQryOrdem.SQL.Add('  AND PRO_ESPPED = ' + QuotedStr(strEspPed));
    FQryOrdem.SQL.Add('  AND PRO_EMPPED = ' + QuotedStr(strEmpPed));
    FQryOrdem.SQL.Add('  AND PRO_PROJEC <> "'+ FProjeto + '"');
    FQryOrdem.Open;
    If Not FQryOrdem.IsEmpty Then
    Begin
      strErro := 'Este pedido já esta vinculado a outro projeto ('+FQryOrdem.FieldByName('PRO_PROJEC').AsString+').';
      Exit;
    End;

    FQryOrdem.SQL.Clear;
    FQryOrdem.SQL.Add('SELECT D.DOP_QTDITE, D.DOP_ITESUB, PRO_NUMPED, PRO_ESPPED, PRO_EMPPED FROM DETPRO D');
    FQryOrdem.SQL.Add('INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER');
    FQryOrdem.SQL.Add('WHERE PRO_NUMPED <> ' + QuotedStr(strNumPed));
    FQryOrdem.SQL.Add('  AND PRO_ESPPED <>' + QuotedStr(strEspPed));
    FQryOrdem.SQL.Add('  AND PRO_EMPPED <> ' + QuotedStr(strEmpPed));
    FQryOrdem.SQL.Add('  AND PRO_PROJEC = "'+ FProjeto + '"');
    FQryOrdem.Open;
    If Not FQryOrdem.IsEmpty Then
    Begin
      strErro := 'Este projeto já esta vinculado a outro pedido('+FQryOrdem.FieldByName('PRO_NUMPED').AsString+ ' - ' +
                                                                  FQryOrdem.FieldByName('PRO_ESPPED').AsString+ ' - ' +
                                                                  FQryOrdem.FieldByName('PRO_EMPPED').AsString+').';
      Exit;
    End;


  End;
  FQryOrdem.SQL.Clear;
  FQryOrdem.SQL.Add('SELECT D.DOP_QTDITE, D.DOP_ITESUB FROM DETPRO D');
  FQryOrdem.SQL.Add('INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER');
  FQryOrdem.SQL.Add('WHERE PRO_NUMPED = ' + QuotedStr(strNumPed));
  FQryOrdem.SQL.Add('  AND PRO_ESPPED = ' + QuotedStr(strEspPed));
  FQryOrdem.SQL.Add('  AND PRO_EMPPED = ' + QuotedStr(strEmpPed));
  FQryOrdem.SQL.Add('  AND PRO_DTABAI IS NULL');
  FQryOrdem.SQL.Add('  AND PRO_PROJEC = "'+ FProjeto + '"');

  FQryOrdem.Open;
end;

procedure TProcessaArquivo.pLeArquivo;
  var blnCrioufrmImportarListaDeMateriais: Boolean;
begin
  blnCrioufrmImportarListaDeMateriais := False;
  FqryDados.DisableControls;
  FProgress.Visible := True;
  Try
    If Not FQryDados.IsEmpty Then
      FqryDados.EmptyDataSet;
    If IsDeceuninck Then
      processaDeceuninck
    Else
    Begin
      If Not Assigned(frmImportarListaDeMateriais) Then
      Begin
        Application.CreateForm(TfrmImportarListaDeMateriais, frmImportarListaDeMateriais);
        blnCrioufrmImportarListaDeMateriais := True;
      End;
      FqryDados.BeforePost := OnBeforePost;
      frmImportarListaDeMateriais.pImportarArquivo(FArquivo, FProgress, FqryDados, Self);
    End;
  Finally
    If blnCrioufrmImportarListaDeMateriais Then
      FreeAndNil(frmImportarListaDeMateriais);
    Fprogress.Visible := False;
    FqryDados.AfterPost := OnAfterPost;
    FqryDados.BeforePost := OnBeforePost;
    FqryDados.AfterEdit := OnAfterEdit;
    FqryDados.First;
    FqryDados.EnableControls;
    FqryDados.IndexFieldNames := '';
  End;
end;

procedure TProcessaArquivo.pPreparaArquivo;
begin
  If (IsDeceuninck) Then
    FobjExcel := TValidadorExcel.Create(FArquivo, 0, '', '', -1);
  Try
    pLeArquivo;
  Finally
    If (IsDeceuninck)  Then
      FreeAndNil(FobjExcel);
  End;
end;


procedure TProcessaArquivo.pSetaGrupoAtual(intLinha: integer);
var strGrupoFind: string;
begin
  strGrupoFind := Trim(FobjExcel.fGetValueCSV(intLinha, 'A'));
  If strGrupoFind = 'Pedido de Perfis - otimizado'  Then
    FGrupoAtual := strGrupoFind;
  If strGrupoFind = 'Grupo de Componentes:' Then
    FGrupoAtual := strGrupoFind;
  If strGrupoFind = 'Pedido de Vidro' Then
    FGrupoAtual := strGrupoFind;
end;

procedure TProcessaArquivo.pSetArqArquivo(const Value: string);
begin
  FArquivo := Value;
  pPreparaArquivo;
end;

procedure TProcessaArquivo.pVisualizaTotais;
var frmImportarArquivoParaAnalise_de_Compras_Totais: TfrmImportarArquivoParaAnalise_de_Compras_Totais;
begin
  pCriarFormularios(TfrmImportarArquivoParaAnalise_de_Compras_Totais, frmImportarArquivoParaAnalise_de_Compras_Totais);
  Try
    pCalculaCDSTotais;
    frmImportarArquivoParaAnalise_de_Compras_Totais.dtsDados.DataSet := FcdsTotais;
    frmImportarArquivoParaAnalise_de_Compras_Totais.Showmodal;
  Finally
    pFreeAndNil(frmImportarArquivoParaAnalise_de_Compras_Totais);
  End;
end;

end.
