unit Promocao.Classes.CatalogoPromocao;

interface

uses
  SysUtils, Uni, untTypesSistema, untFuncoesConsulta, UniClientDataSet,
  untFuncoesImagem, Data.DB, untFuncFat, untFuncFatTypes, System.Classes,
  System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Graphics, frxClass,
  frxExportPDF, frxDBSet, frxExportCSVTestabilidade, untModuloSPR, Forms;

Type
  TCatalogoPromocao = Class
  private
    FTabelaTemp: String;
    FstrNumOrc: String;
    FstrEspOrc: String;
    FstrCodCli: String;
    FstrTabPre: String;
    FintPraMedio: Integer;
    FstrCndPag: String;
    FstrCodCnd: String;
    FblnUsaTabPreco: Boolean;
    FblnUsaTabPrecoProm: Boolean;
    FstrTabPrecoProm: String;
    FstrTabPreco: String;
    FdtaVigencia: TDateTime;
    FblnFiltraDadosUltVndEmp: Boolean;
    FblnFiltraDadosUltVnd: Boolean;
    FNroDiasSemVenda: Integer;
    FdtaSemVendaIni: TDateTime;
    FdtaSemVendaFin: TDateTime;
    FblnSomenteEmPromocao: Boolean;
    FstrCodIte: String;
    FarrProduto: TConsultasArray;
    FstrLinGru: String;
    FarrGrupo: TConsultasArray;
    FstrCodMar: String;
    FarrMarca: TConsultasArray;
    FstrCodDep: String;
    FarrDepartamento: TConsultasArray;
    FstrCodFor: String;
    FarrFornec: TConsultasArray;
    FstrDescri: String;
    FblnComSaldo: Boolean;
    FstrCodProm: String;
    FarrPromocao: TConsultasArray;
    FblnRestaurandoPadrao: Boolean;
    FintIndexTipSaldo: Integer;
    FstrCodEmp: String;
    FarrEmpVnd: TConsultasArray;
    FqryItens: TUniQuery;
    FPathImagem: String;
    FfltValorDesc: Double;

    FcdsDados: TUniClientDataSet;
    FcdsDadosCli: TUniClientDataSet;
    FcdsDadosAux: TUniClientDataSet;
    FcdsDadosRel: TUniClientDataSet;

    FstrProduto,
    FstrMarca,
    FstrGrupo,
    FstrPromocao,
    FstrDepartamento,
    FstrFornecedor,
    FstrEmpVnd: String;
    FblnPrecoImposto: Boolean;

    FTituloRelatorio: String;
    FstrLayPromo: String;
    FblnCatalogoComPreco: Boolean;
    FTamanhoImagemCfg: Double;
    FBlnOtimizaImg: Boolean;
    FBlnCarregaImgRede: Boolean;
    FNomDirArq: String;
    FMensagemRetorno: String;

    FfrxRelJato: TfrxReport;
    FcxImageCollection1: TcxImageCollection;
    FfrxExpPDF: TfrxPDFExport;
    FfrxRelatorio: TfrxDBDataset;
    FNomArq: String;

    FarrCodCliCons: Array of String;
    FblnGeracaoGlobalOco: Boolean;
    FDirPDF: String;
    FblnEmConsultaPorCliente: Boolean;
    FblnFiltrarPromoPorCli: Boolean;
    FCfgIncrem: Boolean;

    procedure pCriaTabelaTemp;
    procedure pExcluiTabelaTemp;

    function fRetornaNomeTabelaTemp: String;
    function fRetSubQryComRegrasPromocao: String;
    function fRetSQLQtdReservadaPedido: String;
    function fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp: String): String;
    function fRetPraMedio: Integer;
    function fGetSQLCondicaoPromocaoPorDesconto: String;
    function fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;
    function fRetSQLQtdSVenda: String;
    function fRetSQLWhere: String;

    function fGetSQL: String;
    procedure pSetaParametros;
    procedure pFormatarCampos(const cdsDadosParam: TUniClientDataSet);
    procedure pIncluirItemVenda(const cdsDadosParam: TUniClientDataSet; objFatVenda: TFatVenda; strTabela: String; fltVlrVnd: Double; fltVlrDesc: Double = 0);
    function fCalculaMargem(fltPreCus, fltPreVen : Double): Double;
    function fVerificaPodeAplicarDesconto(const cdsDadosParam: TUniClientDataSet): Boolean;
    procedure pCriarDataSetDados(const cdsDadosParam: TUniClientDataSet);

    //relatorio
    procedure pSetarVariaveisRelatorio;
    procedure pInformarTituloRelatorio;
    procedure pCarregarModeloPersonalizado;
    procedure pPreparaCamposRelatorio;
    procedure pExibirInformacaoOfertasPromocaoRelatorio;
    function fRetornaPrecoRelatorio: String;
    function fRetValidadePromocaoRelatorio: String;
    function fRetornaValidadePromocaoProdutos: TStringList;
    function fAdicionarImagemList(ImageList: TcxImageCollection; tbImagem: TPicture): Boolean; overload;
    function frxRelJatoUserFunction(const MethodName: string; var Params: Variant): Variant;
    procedure pCarregarImagens;
    procedure pCalcularMargem;
    procedure pCalcularMargemCds(const cdsDadosParam: TUniClientDataSet);
    procedure pCalcularPrecoComImpostos;
    procedure pCalcularPrecoComImpostosCds(const cdsDadosParam: TUniClientDataSet);
    procedure pAplicarDesconto;
    procedure pAplicarDescontoCds(const cdsDadosParam: TUniClientDataSet);
    procedure pCarregaDadosTabelaTmp(const strTabPre, strTabPreProm: String; strCodCli: String = '';
      dtaVig: TDateTime = 0; strCndPag: String = ''; strNumOrc: String = ''; strEspOrc: String = '');
    function fRetSQLPrecoVendaPromoItem(strTabPre: String =''): String;
    function fGerarArquivoAnexo: String;
    procedure pGerarDadosRel;
    function fRetornaStringThumbnail: String;
    function fPathLayoutPromocao(var blnCarregarModelo: Boolean): String;
    function fMaiorDataPromocao: String;
    function fMenorDataPromocao: String;
  public
     constructor Create;
     destructor Destroy;  override;

     function fAddClienteParaConsulta(const strCodCliParam: String): Boolean;
     procedure pConsultarGeral;
     procedure pConsultarPorCliente;
     procedure pConsultarGrupoClientes;
     procedure pLimpar;
     procedure pGerarArquivo(ASaidaTela: Boolean; AEnviarEmail: Boolean; AGerarPDF: Boolean);
     procedure pEnviarArquivoPorEmail;
     procedure pIniciaRelatorio(afrxRelJato: TfrxReport; afrxExpPDF : TfrxPDFExport; afrxRelatorio: TfrxDBDataset);
     procedure pAdicionaItensCatalogo;
     procedure pLimparDadosConsulta;

     property strNomTabTemp: String read FTabelaTemp;
     property strCodCli: String read FstrCodCli write FstrCodCli;
     property blnUsaTabPreco: Boolean read FblnUsaTabPreco write FblnUsaTabPreco;
     property blnUsaTabPrecoProm: Boolean read FblnUsaTabPrecoProm write FblnUsaTabPrecoProm;
     property strTabPrecoProm: String read FstrTabPrecoProm write FstrTabPrecoProm;
     property strTabPreco: String read FstrTabPreco write FstrTabPreco;
     property dtaVigencia: TDateTime read FdtaVigencia write FdtaVigencia;
     property strCodCnd: String read FstrCodCnd write FstrCodCnd;
     property strCndPag: String read FstrCndPag write FstrCndPag;
     property blnFiltraDadosUltVnd: Boolean read FblnFiltraDadosUltVnd write FblnFiltraDadosUltVnd;
     property blnFiltraDadosUltVndEmp: Boolean read FblnFiltraDadosUltVndEmp write FblnFiltraDadosUltVndEmp;
     property intNroDiasSemVenda: Integer read FNroDiasSemVenda write FNroDiasSemVenda;
     property dtaSemVendaIni: TDateTime read FdtaSemVendaIni write FdtaSemVendaIni;
     property dtaSemVendaFin: TDateTime read FdtaSemVendaFin write FdtaSemVendaFin;
     property blnSomenteEmPromocao: Boolean read FblnSomenteEmPromocao write FblnSomenteEmPromocao;
     property strCodIte: String read FstrCodIte write FstrCodIte;
     property arrProduto: TConsultasArray read FarrProduto write FarrProduto;
     property strLinGru: String read FstrLinGru write FstrLinGru;
     property arrGrupo: TConsultasArray read FarrGrupo write FarrGrupo;
     property strCodMar: String read FstrCodMar write FstrCodMar;
     property arrMarca: TConsultasArray read FarrMarca write FarrMarca;
     property strCodDep: String read FstrCodDep write FstrCodDep;
     property arrDepartamento: TConsultasArray read FarrDepartamento write FarrDepartamento;
     property strCodFor: String read FstrCodFor write FstrCodFor;
     property arrFornec: TConsultasArray read FarrFornec write FarrFornec;
     property strDescri: String read FstrDescri write FstrDescri;
     property blnComSaldo: Boolean read FblnComSaldo write FblnComSaldo;
     property strCodPromocao: String read FstrCodProm write FstrCodProm;
     property arrPromocao: TConsultasArray read FarrPromocao write FarrPromocao;
     property blnRestaurandoPadrao: Boolean read FblnRestaurandoPadrao write FblnRestaurandoPadrao;
     property intIndexTipSaldo: Integer read FintIndexTipSaldo write FintIndexTipSaldo;
     property cdsDados: TUniClientDataSet read FcdsDados write FcdsDados;
     property cdsDadosCliente: TUniClientDataSet read FcdsDadosCli write FcdsDadosCli;
     property fltValorDesc: Double read FfltValorDesc write FfltValorDesc;
     property blnPrecoImposto: Boolean read FblnPrecoImposto write FblnPrecoImposto;
     property strEmpVnd: String read FstrEmpVnd write FstrEmpVnd;
     property arrEmpVnd: TConsultasArray read FarrEmpVnd write FarrEmpVnd;
     property blnGeracaoGlobalOco: Boolean read FblnGeracaoGlobalOco write FblnGeracaoGlobalOco;
     property blnCatalogoComPreco: Boolean read FblnCatalogoComPreco write FblnCatalogoComPreco;
     property strNomDirArq: String read FNomDirArq write FNomDirArq;
     property strMensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;

     property frxRelJato: TfrxReport read FfrxRelJato write FfrxRelJato;
     property frxExpPDF: TfrxPDFExport read FfrxExpPDF write FfrxExpPDF;
     property frxRelatorio: TfrxDBDataset read FfrxRelatorio write FfrxRelatorio;
     property strDirPDF: String read FDirPDF write FDirPDF;
  End;

implementation

uses
  untFuncoesSimples, untCadPro, untConstantes, untLiberacao,
  untFuncoesGenerica, untInputDialog, untTEnvioEmail, untDisparaEmailAut,
  untImagemBase64 ;

{ TCatalogoPromocao }

constructor TCatalogoPromocao.Create;
begin
  inherited;

  FqryItens := fCriaquery;

  FblnGeracaoGlobalOco:= False;

  FTamanhoImagemCfg := fCfgSis('TAMIMG', varDouble);
  FBlnOtimizaImg    := fCfgSis('OTMIMG', varBoolean);
  FBlnCarregaImgRede:= fCfgSis('CARIMG', varBoolean);

  FcxImageCollection1 := TcxImageCollection.Create(Nil);

  FcdsDadosRel := TUniClientDataSet.Create(Nil);
  FcdsDadosAux := TUniClientDataSet.Create(Nil);

  pCriarDataSetDados(FcdsDadosRel);
  pCriarDataSetDados(FcdsDadosAux);

  FCfgIncrem := fCfgSis('CATINC', varBoolean);

  pLimpar;
end;

destructor TCatalogoPromocao.Destroy;
begin
  pExcluiTabelaTemp;

  inherited;

  If Assigned(FqryItens) Then
    FreeAndNil(FqryItens);

  If Assigned(FcdsDadosAux) Then
    FreeAndNil(FcdsDadosAux);

  If Assigned(FcdsDadosCli) Then
    FreeAndNil(FcdsDadosCli);

  If Assigned(FcdsDados) Then
    FreeAndNil(FcdsDados);

  If Assigned(FcdsDadosRel) Then
    FreeAndNil(FcdsDadosRel);

  If Assigned(FcxImageCollection1) Then
    FreeAndNil(FcxImageCollection1);
end;

function TCatalogoPromocao.fRetornaNomeTabelaTemp: String;
var
  strSeqTab: String;
begin
  strSeqTab := fRetSequencial('TMPPRM', VS_strCodEmp, 12);
  Result := 'TMP_PRM'+ strSeqTab;
end;

function TCatalogoPromocao.fRetornaPrecoRelatorio: String;
Var
  fltPreco: Double;
begin
  Result := '';

  If FblnCatalogoComPreco Then
  Begin
    If FcdsDadosRel.FieldByName('Preço Promoção').AsFloat > 0 Then
      fltPreco := IIF(FblnPrecoImposto,
                      FcdsDadosRel.FieldByName('Preço Promoção c/ Imp.').AsFloat,
                      FcdsDadosRel.FieldByName('Preço Promoção').AsFloat)
    Else
      fltPreco := IIF(FblnPrecoImposto,
                      FcdsDadosRel.FieldByName('Preço com Impostos').AsFloat,
                      FcdsDadosRel.FieldByName('Preço Venda').AsFloat);
    Result := 'R$'+FormatFloat(fMskDigitos(2), fltPreco);
  End;
end;

function TCatalogoPromocao.fRetornaStringThumbnail: String;
var
  strThumbB64: String;
  strIteThu64: String;
  strIteImg64: String;
  picTmp: TPicture;
begin
  strThumbB64 := EmptyStr;
  picTmp := TPicture.Create;
  Try
    strIteThu64 := fCampoTabela('ITE_THUB64', 'ITEIMG', ['AUTOINCREM'], [FcdsDadosRel.FieldByName('AUTINCIMG').AsString]);
    If (FcdsDadosRel.FieldByName('ThumGerado').AsString = 'N') Then
    Begin
      strIteImg64 :=  fCampoTabela('ITE_IMGB64', 'ITEIMG', ['AUTOINCREM'], [FcdsDadosRel.FieldByName('AUTINCIMG').AsString]);

      If (fGerarThumbProduto(FcdsDadosRel.FieldByName('Código').AsString,
                             picTmp,
                             FTamanhoImagemCfg,
                             FcdsDadosRel.FieldByName('CaminhoImagem').AsString,
                             strIteImg64,
                             False, FBlnOtimizaImg, FBlnCarregaImgRede) = riOK ) Then
      Begin
        strThumbB64 := fBase64FromImg(picTmp.Graphic);

        If Not fEmptyStr(strThumbB64) Then
        Begin
          pGravarThumbItem(strThumbB64, FcdsDadosRel.FieldByName('AUTINCIMG').AsString);
          FcdsDadosRel.Edit;
          FcdsDadosRel.FieldByName('ThumGerado').AsString := 'S';
          FcdsDadosRel.Post;
        End;
      End;
    End
    Else
    If (FcdsDadosRel.FieldByName('ThumGerado').AsString = 'S') Then
    Begin
      strThumbB64 := strIteThu64;
    End;

  Finally
    Result := strThumbB64;
    FreeAndNil(picTmp);
  End;
end;

function TCatalogoPromocao.fRetornaValidadePromocaoProdutos: TStringList;
begin
  Result := TStringList.Create();
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;

  Try
    FcdsDadosRel.DisableControls;
    FcdsDadosRel.First;
    While Not FcdsDadosRel.Eof Do
    Begin
      If FcdsDadosRel.FieldByName('Preço Promoção').AsFloat > 0 Then
        Result.Add(FcdsDadosRel.FieldByName('Valid. Final').AsString);
      FcdsDadosRel.Next;
    End;
  Finally
    FcdsDadosRel.EnableControls;
    FcdsDadosRel.First;
  End;
end;

function TCatalogoPromocao.fRetPraMedio: Integer;
var
  intPraMedio: Integer;
begin
  Result := 0;

  If FstrCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(FstrCndPag))
  Else
    intPraMedio := 0;

  If untFuncoesSimples.fCfgSis('PRZPRO', varBoolean) Then
    Result := intPraMedio;
end;

function TCatalogoPromocao.fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp: String): String;
begin
  Result := '';
  Result := Result + '  SELECT C.PRO_CODCLI ';
  Result := Result + '  FROM CADPRO P INNER JOIN PROCLI C ON C.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN ITEPRO I ON I.IPR_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN PROEMP E ON E.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '  WHERE ';
  Result := Result + '   '  + fCurrentDate + ' BETWEEN P.PRO_DTAINI AND P.PRO_DTAFIN ';
  Result := Result + fGetFiltroTabelaPrecoPromocao(FstrTabPre, 'P.');
  Result := Result + fGetFiltroPromocaoRestritaClientesNaoConsumidor(FstrCodCli, 'P.');
  Result := Result + '  AND E.PRO_CODEMP = ' + IIF(Pos('.',strCodEmp) > 0, strCodEmp, QuotedStr(strCodEmp));
  Result := Result + '  AND I.IPR_CODITE = ' + IIF(Pos('.',strCodIte) > 0, strCodIte, QuotedStr(strCodIte));
  Result := Result + '  AND (IFNULL(I.IPR_QTDLIM, 0) > 0) ';
end;

function TCatalogoPromocao.fRetSQLQtdReservadaPedido: String;
begin
  Result := '';
  If (Not fEmptyStr(FstrNumOrc)) And (Not fEmptyStr(FstrEspOrc)) And (FstrEspOrc = 'PD') Then
  Begin
    Result := Result + ' + (SELECT IFNULL(SUM(FDO_QTDITE), 0)            ';
    Result := Result + '      FROM FATDOR                                ';
    Result := Result + '        INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    Result := Result + '     WHERE FDO_NUMDOC = ' + QuotedStr(FstrNumOrc);
    Result := Result + '       AND FDO_ESPDOC = ' + QuotedStr(FstrEspOrc);
    Result := Result + '       AND FDO_CODEMP = PROEMP.PRO_CODEMP        ';
    Result := Result + '       AND FDO_CODITE = ITEPRO.IPR_CODITE        ';

    If fCfgSis('TABLOI', VarBoolean) Then
      Result := Result + '     AND FDO_CODPRO = PRO_CODPRO               ';

    Result := Result + '       AND FDO_PROMOC = "S"                      )';
  End;
end;

function TCatalogoPromocao.fRetSQLQtdSVenda: String;
begin
  Result := EmptyStr;
  If FblnFiltraDadosUltVndEmp  Then
  Begin
    Result := Result +
              ' (SELECT COUNT(D.AUTOINCREM) ' +
              '  FROM MOVDET D             ' +
              '  JOIN CADITE CI ON D.DET_CODITE = CI.ITE_CODITE      ' +
              '  INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER  ' +
              ' WHERE D.DET_PROEMB <> "S"                            ' +
              '   AND D.DET_TIP_FC = "C"                             ' +
              '   AND D.DET_CODCLI = :CODCLI                         ' +
              '   AND D.DET_CODITE = G.ITE_CODITE                    ' +
              '   AND LOCATE(D.DET_CODEMP, :CODEMPVND) > 0           ';

    If FNroDiasSemVenda > 0 Then
      Result := Result + '   AND (DATEDIFF(CURRENT_DATE, D.DET_DTAENT) <= :QTDSEMVND) )  '
    Else If (FDtaSemVendaFin > 0) Then
      Result := Result + '   AND D.DET_DTAENT BETWEEN :DTAINIVND AND :DTAFINVND )  '
    Else
      Result := Result + ' ) ';
  End
  Else If FblnFiltraDadosUltVnd Then
  Begin
    If (FNroDiasSemVenda > 0) Then
      Result := Result +  ' DATEDIFF(CURRENT_DATE, G.ITE_DTAUVE)  ';
  End;

  if fEmptyStr(Result) then
    Result := Result +  ' 0  ';
end;

function TCatalogoPromocao.fRetSQLWhere: String;
begin
  Result := EmptyStr;
  If Not fEmptyStr(FstrCodIte) Then
    Result := Result + fStrLocate(FstrCodIte, FarrProduto, 'CADITE.ITE_CODITE', 'CODITE');

  If Not fEmptyStr(FstrLinGru) Then
    Result := Result + fStrLocateLinGru(Nil, FarrGrupo, 'CADITE.ITE_CODGRU', 'CODGRU', False, False, FstrLinGru);

  If Not fEmptyStr(FstrCodMar) Then
    Result := Result + fStrLocate(FstrCodMar, FarrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

  If Not fEmptyStr(FstrCodDep) Then
    Result := Result + fStrLocate(FstrCodDep, FarrDepartamento, 'CADITE.ITE_CODDEP', 'CODDEP');

  If Not fEmptyStr(FstrCodFor) Then
    Result := Result + fStrLocate(FstrCodFor, FarrFornec, 'CADITE.ITE_CODFOR', 'CODFOR');

  If Not fEmptyStr(FstrDescri) Then
    Result := Result + ' AND UPPER(CADITE.ITE_DESITE) LIKE  :DESITE ';

  If (FblnFiltraDadosUltVnd) And
     (Not FblnFiltraDadosUltVndEmp) Then
  Begin
    If (FdtaSemVendaIni > 0) Then
      Result := Result + '   AND G.ITE_DTAUVE BETWEEN :DTAINIVND AND :DTAFINVND ';

    If (FNroDiasSemVenda > 0) Then
      Result := Result + '   AND (DATEDIFF(CURRENT_DATE, G.ITE_DTAUVE) >= :QTDSEMVND )';

  End;

  Result := Result + ' HAVING TRUE ';

  Case FintIndexTipSaldo Of
    0: Result := Result + ' AND `Saldos`  > 0 ';
    1: Result := Result + ' AND `Saldos` <= 0 ';
  End;

  Result := Result + IIF( Not fEmptyStr(FstrCodProm),  fStrLocate(FstrCodProm, arrPromocao, '`Promoção`', 'CODPRO'), '');

  Result := Result + IIF(FblnSomenteEmPromocao, ' AND `Promoção` IS NOT NULL ', '');

  Result := Result + IIF(FblnFiltraDadosUltVndEmp, ' AND ((`QTDIA_SVND` <= 0) AND (`Promoção` IS NULL))  ', '');

  Result := Result + IIF(FblnFiltraDadosUltVnd, ' AND `Promoção` IS NULL ', '');

end;

function TCatalogoPromocao.fRetSubQryComRegrasPromocao: String;
Begin
  Result := '';

  If fEmptyStr(FstrCodCli) Then
  Begin
    Result := Result + ' (PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + ' (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE))) AND ';
  End
  Else
  Begin
    Result := Result + ' (((PROCLI.PRO_CODCLI = '+ QuotedStr(Self.FstrCodCli)+') AND (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '  OR (((PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + '      ((IPR_QTDLIM <= 0) OR ((IPR_QTDLIM > 0) AND '+QuotedStr(Self.FstrCodCli)+ ' NOT IN ('+Self.fRetSubQryCodCliEmPromoPorQtdLim('ITEPRO.IPR_CODITE', 'PROEMP.PRO_CODEMP')+'))) AND ';
    Result := Result + '      (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '     ) ';
    Result := Result + ' ) AND ';
  End;
end;

function TCatalogoPromocao.fRetValidadePromocaoRelatorio: String;
Var
  stlValidade: TStringList;
begin
  Result := '';
  stlValidade := fRetornaValidadePromocaoProdutos;
  Try
    If stlValidade.Count > 1 Then
      Result := 'Promoção válida por tempo limitado ou até finalizar o estoque. Consulte seu vendedor.'
    Else If stlValidade.Count = 1 Then
      Result := 'Promoção válida até ' + stlValidade[0] + ' ou até finalizar o estoque. Consulte seu vendedor.';
  Finally
    FreeAndNil(stlValidade);
  End;
end;

function TCatalogoPromocao.frxRelJatoUserFunction(
  const MethodName: string; var Params: Variant): Variant;
var
  picAux: TPicture;
  intIndice: Integer;
begin
    inherited;

  If MethodName = UpperCase('fRetornaPrecoRelatorio') Then
    Result := fRetornaPrecoRelatorio

  Else If MethodName = UpperCase('pCarregarImagemProduto') Then
  Begin
    picAux := TPicture.Create;
    Try
      If (FcdsDadosRel.FieldByName('ImgCarregada').AsString = 'N') Then
      Begin
        TfrxPictureView(FfrxRelJato.FindObject('ImgProduto')).Picture := nil;
        Exit;
      End;

      intIndice := FcdsDadosRel.FieldByName('IndiceImagem').AsInteger;

      If Not Assigned(FcxImageCollection1.Items[intIndice].Picture) Then
      Begin
        TfrxPictureView(FfrxRelJato.FindObject('ImgProduto')).Picture := nil;
        Exit;
      End;
      picAux.Graphic := FcxImageCollection1.Items[intIndice].Picture.Graphic;

      Case fCarregarImagemProduto(FcdsDadosRel.FieldByName('Código').AsString,
                                 picAux,
                                 TfrxPictureView(FfrxRelJato.FindObject('ImgProduto'))
                                 ) Of
        riErro,
        riNulo,
        riNaoConfig: TfrxPictureView(FfrxRelJato.FindObject('ImgProduto')).Picture := nil;
      End;
    Finally
      FreeAndNil(picAux);
    End;

  End;
end;

function TCatalogoPromocao.fVerificaPodeAplicarDesconto(const cdsDadosParam: TUniClientDataSet): Boolean;
var
  intQtd: Integer;
  fltDesMax : Double;
  fltMinDes : Double;
  objLiberacao : TLiberacao;
begin
  intQtd := 0;
  fltMinDes := 0;
  cdsDadosParam.DisableControls;
  objLiberacao := TLiberacao.Create;
  Try
    cdsDadosParam.First;
    While Not cdsDadosParam.Eof Do
    Begin
      fltDesMax := cdsDadosParam.FieldByName('ITE_DESMAX').AsFloat;
      If (fltMinDes <= 0) Or (fltDesMax < fltMinDes) Then
        fltMinDes := fltDesMax;

      If (FfltValorDesc > fltMinDes ) Then
      Begin
        Inc(intQtd);
      End;
      cdsDadosParam.Next;
    End;

    If ( intQtd > 0 ) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Permissão para informar desconto maior que o permitido na geração de Catálogo de Promoções.');
      objLiberacao.objMsgLibera.pAddTexto('');
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FstrCodCli + ' - ' + fRetNomCliente(FstrCodCli));
      objLiberacao.objMsgLibera.pAddTexto('Desconto informado: ' + FloatToStr(FfltValorDesc) + ' %');
      objLiberacao.objMsgLibera.pAddTexto('Qtd Produtos com desconto máximo acima do informado: ' + IntToStr(intQtd));

      objLiberacao.strDirAce := 'CRMPDC';
      objLiberacao.strMsgSen := 'Permissão para informar desconto maior que o permitido na geração de Catálogo de Promoções.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    End
    Else
      Result := True;
  Finally
    cdsDadosParam.EnableControls;
    FreeAndNil(objLiberacao);
  end;
end;

procedure TCatalogoPromocao.pAdicionaItensCatalogo;
begin
  FqryItens.DisableControls;
  Try
    FqryItens.First;
    While Not FqryItens.Eof Do
    Begin
      FcdsDados.Append;

      FcdsDados.FieldByName('Cliente').AsString := FqryItens.FieldByName('Cliente').AsString;
      FcdsDados.FieldByName('Referência').AsString  := FqryItens.FieldByName('Referência').AsString;
      FcdsDados.FieldByName('Código').AsString  := FqryItens.FieldByName('Código').AsString;
      FcdsDados.FieldByName('Código de Fábrica').AsString  := FqryItens.FieldByName('Código de Fábrica').AsString;
      FcdsDados.FieldByName('Descrição').AsString  := FqryItens.FieldByName('Descrição').AsString;
      FcdsDados.FieldByName('Aplicação').AsString  := FqryItens.FieldByName('Aplicação').AsString;
      FcdsDados.FieldByName('Unidade').AsString  := FqryItens.FieldByName('Unidade').AsString;
      FcdsDados.FieldByName('Saldos').AsFloat  := FqryItens.FieldByName('Saldos').AsFloat;
      FcdsDados.FieldByName('Preço Custo').AsFloat  := FqryItens.FieldByName('Preço Custo').AsFloat;
      FcdsDados.FieldByName('Preço Venda').AsFloat  := FqryItens.FieldByName('Preço Venda').AsFloat;
      FcdsDados.FieldByName('Preço c/ Imp. c/').AsFloat  := FqryItens.FieldByName('Preço c/ Imp. c/').AsFloat;
      FcdsDados.FieldByName('Preço Promoção').AsFloat  := FqryItens.FieldByName('Preço Promoção').AsFloat;
      FcdsDados.FieldByName('Preço Promoção c/ Imp.').AsFloat  := FqryItens.FieldByName('Preço Promoção c/ Imp.').AsFloat;
      FcdsDados.FieldByName('Preço Tabela').AsFloat  := FqryItens.FieldByName('Preço Tabela').AsFloat;
      FcdsDados.FieldByName('Preço com Impostos').AsFloat  := FqryItens.FieldByName('Preço com Impostos').AsFloat;
      FcdsDados.FieldByName('Promoção').AsString := FqryItens.FieldByName('Promoção').AsString;
      FcdsDados.FieldByName('DescPromo').AsString := FqryItens.FieldByName('DescPromo').AsString;
      FcdsDados.FieldByName('Valid. Inicial').AsDateTime := FqryItens.FieldByName('Valid. Inicial').AsDateTime;
      FcdsDados.FieldByName('Valid. Final').AsDateTime := FqryItens.FieldByName('Valid. Final').AsDateTime;
      FcdsDados.FieldByName('Desc. Porcentagem').AsFloat := FqryItens.FieldByName('Desc. Porcentagem').AsFloat;
      FcdsDados.FieldByName('Margem').AsFloat := FqryItens.FieldByName('Margem').AsFloat;
      FcdsDados.FieldByName('Marcado').AsString := FqryItens.FieldByName('Marcado').AsString;
      FcdsDados.FieldByName('Marca').AsString := FqryItens.FieldByName('Marca').AsString;
      FcdsDados.FieldByName('Nvl. Giro E.Geral').AsString := FqryItens.FieldByName('Nvl. Giro E.Geral').AsString;
      FcdsDados.FieldByName('Preço').AsString := FqryItens.FieldByName('Preço').AsString;
      FcdsDados.FieldByName('CaminhoImagem').AsString := FqryItens.FieldByName('CaminhoImagem').AsString;
      FcdsDados.FieldByName('Montadora').AsString := FqryItens.FieldByName('Montadora').AsString;
      FcdsDados.FieldByName('Aplicacao').AsString := FqryItens.FieldByName('Aplicacao').AsString;
      FcdsDados.FieldByName('IndiceImagem').AsInteger := FqryItens.FieldByName('IndiceImagem').AsInteger;
      FcdsDados.FieldByName('ImgCarregada').AsString := FqryItens.FieldByName('ImgCarregada').AsString;
      FcdsDados.FieldByName('ThumGerado').AsString := FqryItens.FieldByName('ThumGerado').AsString;
      FcdsDados.FieldByName('AUTINCIMG').AsString := FqryItens.FieldByName('AUTINCIMG').AsString;
      FcdsDados.FieldByName('ITE_DESMAX').AsFloat  := FqryItens.FieldByName('ITE_DESMAX').AsFloat;
      FcdsDados.FieldByName('ITE_CODGRU').AsString := FqryItens.FieldByName('ITE_CODGRU').AsString;
      FcdsDados.FieldByName('UNI_CODUNI').AsString := FqryItens.FieldByName('UNI_CODUNI').AsString;
      FcdsDados.FieldByName('ITE_CODFOR').AsString := FqryItens.FieldByName('ITE_CODFOR').AsString;
      FcdsDados.FieldByName('ITE_COMLUB').AsString := FqryItens.FieldByName('ITE_COMLUB').AsString;
      FcdsDados.FieldByName('ITE_IPISAI').AsFloat := FqryItens.FieldByName('ITE_IPISAI').AsFloat;
      FcdsDados.FieldByName('ITE_COMVAR').AsString := FqryItens.FieldByName('ITE_COMVAR').AsString;
      FcdsDados.FieldByName('ITE_COMATA').AsString := FqryItens.FieldByName('ITE_COMATA').AsString;
      FcdsDados.FieldByName('ITE_COMDIS').AsString := FqryItens.FieldByName('ITE_COMDIS').AsString;
      FcdsDados.FieldByName('ITE_PREULT').AsFloat := FqryItens.FieldByName('ITE_PREULT').AsFloat;
      FcdsDados.FieldByName('ITE_IMPULT').AsFloat := FqryItens.FieldByName('ITE_IMPULT').AsFloat;
      FcdsDados.FieldByName('ITE_PREMED').AsFloat := FqryItens.FieldByName('ITE_PREMED').AsFloat;
      FcdsDados.FieldByName('ITE_PREMED').AsFloat := FqryItens.FieldByName('ITE_PREMED').AsFloat;
      FcdsDados.FieldByName('ITE_CLAIPI').AsString := FqryItens.FieldByName('ITE_CLAIPI').AsString;
      FcdsDados.FieldByName('ITE_PESOIT').AsFloat := FqryItens.FieldByName('ITE_PESOIT').AsFloat;
      FcdsDados.FieldByName('ITE_PESLIQ').AsFloat := FqryItens.FieldByName('ITE_PESLIQ').AsFloat;
      FcdsDados.FieldByName('ITE_CODFAB').AsString := FqryItens.FieldByName('ITE_CODFAB').AsString;
      FcdsDados.FieldByName('ITE_MARMIN').AsFloat := FqryItens.FieldByName('ITE_MARMIN').AsFloat;
      FcdsDados.FieldByName('ITE_MARMSG').AsFloat := FqryItens.FieldByName('ITE_MARMSG').AsFloat;
      FcdsDados.FieldByName('ITE_MARMGE').AsFloat := FqryItens.FieldByName('ITE_MARMGE').AsFloat;
      FcdsDados.FieldByName('ITE_CODMAR').AsString := FqryItens.FieldByName('ITE_CODMAR').AsString;
      FcdsDados.FieldByName('ITE_PRECOM').AsFloat := FqryItens.FieldByName('ITE_PRECOM').AsFloat;
      FcdsDados.FieldByName('ITE_QTPPRO').AsFloat := FqryItens.FieldByName('ITE_QTPPRO').AsFloat;
      FcdsDados.FieldByName('ITE_IPIENT').AsFloat := FqryItens.FieldByName('ITE_IPIENT').AsFloat;
      FcdsDados.FieldByName('ITE_FREENT').AsFloat := FqryItens.FieldByName('ITE_FREENT').AsFloat;
      FcdsDados.FieldByName('ITE_PRECUS').AsFloat := FqryItens.FieldByName('ITE_PRECUS').AsFloat;
      FcdsDados.FieldByName('ITE_OBRCPF').AsString := FqryItens.FieldByName('ITE_OBRCPF').AsString;
      FcdsDados.FieldByName('ITE_CODBAR').AsString := FqryItens.FieldByName('ITE_CODBAR').AsString;
      FcdsDados.FieldByName('ITE_PREVE1').AsFloat := FqryItens.FieldByName('ITE_PREVE1').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE2').AsFloat := FqryItens.FieldByName('ITE_PREVE2').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE3').AsFloat := FqryItens.FieldByName('ITE_PREVE3').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE4').AsFloat := FqryItens.FieldByName('ITE_PREVE4').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE5').AsFloat := FqryItens.FieldByName('ITE_PREVE5').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE6').AsFloat := FqryItens.FieldByName('ITE_PREVE6').AsFloat;
      FcdsDados.FieldByName('ITE_PREVE7').AsFloat := FqryItens.FieldByName('ITE_PREVE7').AsFloat;
      FcdsDados.FieldByName('ITE_CODABF').AsString := FqryItens.FieldByName('ITE_CODABF').AsString;
      FcdsDados.FieldByName('ITE_DTAUVE').AsDateTime := FqryItens.FieldByName('ITE_DTAUVE').AsDateTime;
      FcdsDados.FieldByName('QTDIA_SVND').AsInteger := FqryItens.FieldByName('QTDIA_SVND').AsInteger;

      FcdsDados.Post;

      FqryItens.Next;
    End;
  Finally
    FqryItens.EnableControls;
  End;
end;

procedure TCatalogoPromocao.pAplicarDesconto();
begin
  If FblnEmConsultaPorCliente Then
  Begin
    pAplicarDescontoCds(FcdsDadosCli)
  End
  Else
    pAplicarDescontoCds(FcdsDados)
end;

procedure TCatalogoPromocao.pAplicarDescontoCds(
  const cdsDadosParam: TUniClientDataSet);
begin
  cdsDadosParam.DisableControls;
  Try
    cdsDadosParam.First;
    While Not cdsDadosParam.Eof Do
    Begin
      cdsDadosParam.Edit;

      cdsDadosParam.FieldByName('Preço Venda').AsFloat :=
        cdsDadosParam.FieldByName('Preço Venda').AsFloat *
        (1 - FfltValorDesc / 100);
      cdsDadosParam.FieldByName('Desc. Porcentagem').AsFloat :=
        FfltValorDesc;

      cdsDadosParam.Post;
      cdsDadosParam.Next;
    End;
  Finally
    cdsDadosParam.EnableControls;
  end;
end;

procedure TCatalogoPromocao.pCalcularMargem;
Begin
  If FblnEmConsultaPorCliente Then
  Begin
    pCalcularMargemCds(FcdsDadosCli);
  End
  Else
    pCalcularMargemCds(FcdsDados);
End;

procedure TCatalogoPromocao.pCalcularMargemCds(
  const cdsDadosParam: TUniClientDataSet);
begin
  cdsDadosParam.DisableControls;
  Try
    cdsDadosParam.First;
    While Not cdsDadosParam.Eof Do
    Begin
      cdsDadosParam.Edit;
      cdsDadosParam.FieldByName('Margem').AsFloat :=
        fCalculaMargem(cdsDadosParam.FieldByName('Preço Custo').AsFloat,
                       cdsDadosParam.FieldByName('Preço Venda').AsFloat);
      cdsDadosParam.Post;
      cdsDadosParam.Next;
    End;
  Finally
    cdsDadosParam.EnableControls;
  End;
end;

procedure TCatalogoPromocao.pCalcularPrecoComImpostosCds(const cdsDadosParam: TUniClientDataSet);
var
  FobjFatVendas: TFatVenda;
  item: TDadosFechamento;
  intRecNo : Integer;
  fltImpCalc: Double;
begin
  If Not(FblnPrecoImposto) Then
    Exit;

  FobjFatVendas := TFatVenda.CreateInstance('OR', True);
  pCriarCdsVenda(nil);
  cdsVenda.EmptyDataSet;

  intRecNo := cdsDadosParam.RecNo;
  Try
    Try
      FobjFatVendas.strOriDoc := 'V';
      FobjFatVendas.strOpcDocTrue := 'OR';
      FobjFatVendas.blnVerEstOrc  := False;
      FobjFatVendas.strEspDoc := 'OR';
      FobjFatVendas.pCarregaDadosClienteBaixa(FstrCodCli);
      FobjFatVendas.pDefineTipoFaturamentoExpedicao;

      cdsDadosParam.DisableControls;
      cdsDadosParam.First;
      While Not cdsDadosParam.Eof Do
      Begin
        cdsVenda.EmptyDataSet;
        fltImpCalc := 0;
        pIncluirItemVenda(cdsDadosParam, FobjFatVendas, FstrTabPreco,
          cdsDadosParam.FieldByName('Preço Venda').AsFloat);
        FobjFatVendas.pPreparaParaEmitirMeiaNotaNotaNormal;
        FobjFatVendas.pCalculaTotGer;
        FobjFatVendas.pCalculaTotalParaCadRec;
        For item In FobjFatVendas.arrMatItens Do
        Begin
          fltImpCalc := fFormataFloat(item.fltTotIte - item.fltDesEsp + item.fltValFre +
            item.fltDesAce + item.fltValIpi + item.fltValRet + item.recDifalFCP.fltValFcp +
            item.fltIcmOrg + item.fltValCBS + item.fltValIBS + item.fltVal_IS, 2);
        End;
        cdsDadosParam.Edit;
        cdsDadosParam.FieldByName('Preço c/ Imp. c/').AsFloat := fltImpCalc;
        cdsDadosParam.Post;

        cdsVenda.EmptyDataSet;
        fltImpCalc := 0;
        pIncluirItemVenda(cdsDadosParam, FobjFatVendas, FstrTabPreco,
          cdsDadosParam.FieldByName('Preço Venda').AsFloat, FfltValorDesc);
        FobjFatVendas.pPreparaParaEmitirMeiaNotaNotaNormal;
        FobjFatVendas.pCalculaTotGer;
        FobjFatVendas.pCalculaTotalParaCadRec;
        For item In FobjFatVendas.arrMatItens Do
        Begin
          fltImpCalc := fFormataFloat(item.fltTotIte - item.fltDesEsp + item.fltValFre +
            item.fltDesAce + item.fltValIpi + item.fltValRet + item.recDifalFCP.fltValFcp +
            item.fltIcmOrg + item.fltValCBS + item.fltValIBS + item.fltVal_IS, 2);
        End;
        cdsDadosParam.Edit;
        cdsDadosParam.FieldByName('Preço com Impostos').AsFloat := fltImpCalc;
        cdsDadosParam.Post;

        If (cdsDadosParam.FieldByName('Preço Promoção').AsFloat > 0) Then
        Begin
          cdsVenda.EmptyDataSet;
          fltImpCalc := 0;
          pIncluirItemVenda(cdsDadosParam, FobjFatVendas, FstrTabPrecoProm,
            cdsDadosParam.FieldByName('Preço Promoção').AsFloat);
          FobjFatVendas.pPreparaParaEmitirMeiaNotaNotaNormal;
          FobjFatVendas.pCalculaTotGer;
          FobjFatVendas.pCalculaTotalParaCadRec;
          For item In FobjFatVendas.arrMatItens Do
          Begin
            fltImpCalc := fFormataFloat(item.fltTotIte - item.fltDesEsp + item.fltValFre +
              item.fltDesAce + item.fltValIpi + item.fltValRet + item.recDifalFCP.fltValFcp +
              item.fltIcmOrg + item.fltValCBS + item.fltValIBS + item.fltVal_IS, 2);
          End;
          cdsDadosParam.Edit;
          cdsDadosParam.FieldByName('Preço Promoção c/ Imp.').AsFloat := fltImpCalc;
          cdsDadosParam.Post;
        End;

        cdsDadosParam.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TCatalogoPromocao.pCalcularPrecoComImpostos]');
      End;
    End;

  Finally;
    cdsDadosParam.RecNo := intRecNo;
    cdsDadosParam.EnableControls;

    pFreeCdsVenda;
    FreeAndNil(FobjFatVendas);
  End;
end;

procedure TCatalogoPromocao.pCalcularPrecoComImpostos;
begin
  If FblnEmConsultaPorCliente Then
  Begin
    pCalcularPrecoComImpostosCds(FcdsDadosCli);
  End
  Else
    pCalcularPrecoComImpostosCds(FcdsDados);
end;

procedure TCatalogoPromocao.pCarregaDadosTabelaTmp(const strTabPre, strTabPreProm: String; strCodCli: String = '';
  dtaVig: TDateTime = 0; strCndPag: String = ''; strNumOrc: String = ''; strEspOrc: String = '');
var
  strSQL: String;
  strPraMedioLoc: String;
begin
  Try
    FstrNumOrc := strNumOrc;
    FstrEspOrc := strEspOrc;
    FstrCodCli := strCodCli;
    FstrTabPre := strTabPre;
    FstrCndPag := strCndPag;

    pExcluiTabelaTemp;
    pCriaTabelaTemp;

    strSQL := 'INSERT INTO ' + FTabelaTemp;
    strSQL := strSQL + ' SELECT  CADPRO.AUTOINCREM,';
    strSQL := strSQL + '         ITEPRO.AUTOINCREM,';
    strSQL := strSQL + '         CADPRO.PRO_CODPRO,';
    strSQL := strSQL + '         CADPRO.PRO_DESPRO,';
    strSQL := strSQL + '         CADPRO.PRO_DTAINI,';
    strSQL := strSQL + '         CADPRO.PRO_DTAFIN,';
    strSQL := strSQL + '         ITEPRO.IPR_CODITE,';
    strSQL := strSQL + '         CADPRO.PRO_CODCLI,';
    strSQL := strSQL + '         PROEMP.PRO_CODEMP,';
    strSQL := strSQL + '         CADPRO.PRO_IDXPRO,';
    strSQL := strSQL + '         CADPRO.PRO_PREDES,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVEN,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE2,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE3,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE4,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE5,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE6,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE7,';
    strSQL := strSQL + '         CADPRO.PRO_TABPRE,';
    strSQL := strSQL + '         ITEPRO.IPR_PERDES ';
    strSQL := strSQL + '  FROM CADPRO INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '              INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '               LEFT JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '               LEFT JOIN IPREMP ON IPREMP.IPR_SEQGER = ITEPRO.AUTOINCREM ';
    strSQL := strSQL + '                               AND PROEMP.PRO_CODEMP = IPREMP.IPR_CODEMP ';
    strSQL := strSQL + '                               AND PROEMP.PRO_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  PROEMP.PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) +  ' AND ';
    strSQL := strSQL + fRetSubQryComRegrasPromocao;
    strSQL := strSQL + '    ' + fCurrentDate(dtaVig) + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
    strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre) + ' ';
    strSQL := strSQL + fGetFiltroPromocaoRestritaClientesNaoConsumidor(FstrCodCli) + ' ';
    strSQL := strSQL + fGetFiltroQuantidadeLimite() + ' ';

    If (FintPraMedio <> -999) Then
    Begin
      strPraMedioLoc := IIF(FintPraMedio <> -999, IntToStr(FintPraMedio), '');

      If Not fEmptyStr(strPraMedioLoc) Then
      Begin
        If ((fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S')) Then
        Begin
          strSQL := strSQL + ' AND IF(' + ' (SELECT COUNT(CNDPRO.CPR_SEQGER) FROM CNDPRO WHERE CNDPRO.CPR_SEQGER = CADPRO.AUTOINCREM )'+
                                          ' = 0, ITEPRO.IPR_PRZMED >= '+strPraMedioLoc+', '+
                                          ' TRUE) ';
        End
        Else
        Begin
          strSQL := strSQL + ' AND ITEPRO.IPR_PRZMED >= ' + strPraMedioLoc;
        End;
      End;
    End;

    If FblnEmConsultaPorCliente Then
    Begin
      strSQL := strSQL + ' AND PROCLI.PRO_CODCLI = '+ QuotedStr(FstrCodCli);
    End;

    strSQL := strSQL + ' ORDER BY CADPRO.PRO_TABLOI DESC ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosTabelaTmp]');
    End;
  End;
end;

procedure TCatalogoPromocao.pCarregarImagens;
var
  intRecNo: Integer;
  strImagemProduto: String;
  bmp: TBitMap;
  picTmp: TPicture;
  intIndice: Integer;
Begin
  If FileExists(fCfgSis('PATLOG')) And (FfrxRelJato.FindObject('imgLogo') <> Nil) Then
    TfrxPictureView(FfrxRelJato.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('PATLOG'));

  If FcdsDadosRel.RecordCount <= 0 Then
    Exit;

  FcxImageCollection1.Items.Clear;

  bmp := TBitMap.Create;
  picTmp := TPicture.Create;

  FcdsDadosRel.DisableControls;
  FcdsDadosRel.First;

  intRecNo := FcdsDadosRel.RecNo;
  Try
    Try
      While Not FcdsDadosRel.Eof Do
      Begin
        If (FcdsDadosRel.FieldByName('Marcado').AsString = 'S') Then
        Begin
          pTrimAppMemorySize;

          If (Not fCfgSis('IMGMCT', varBoolean)) Then
            strImagemProduto :=  fCampoTabela('ITE_IMGB64', 'ITEIMG', ['AUTOINCREM'], [FcdsDadosRel.FieldByName('AUTINCIMG').AsString])
          Else
            strImagemProduto := fRetornaStringThumbnail;

          If (fCarregarImagemProduto(strImagemProduto,
                                    picTmp) = riOK ) Then

          Begin
            If fAdicionarImagemList( FcxImageCollection1, picTmp) Then
            Begin
              If FcxImageCollection1.Items.Count-1 >= 0 Then
              Begin
                intIndice := FcxImageCollection1.Items.Count-1;

                FcdsDadosRel.Edit;
                FcdsDadosRel.FieldByName('IndiceImagem').AsInteger := intIndice;
                FcdsDadosRel.FieldByName('ImgCarregada').AsString := 'S';
                FcdsDadosRel.Post;
              End;
            End;
          End;
        End;

        FcdsDadosRel.Next;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatSelItensCatalogoPromocoes.pCarregarImagens]');
    End;

  Finally
    FcdsDadosRel.RecNo := intRecNo;
    FcdsDadosRel.EnableControls;

    If Assigned(bmp) Then
      FreeAndNil(bmp);
    If Assigned(picTmp) Then
      FreeAndNil(picTmp);
  End;
End;

procedure TCatalogoPromocao.pCarregarModeloPersonalizado;
  Var
    blnCarregarModelo: Boolean;
Begin
  FstrLayPromo := fCfgSis('PATETI') + '\produtos_promocoes_CRM.fr3';
  blnCarregarModelo := FileExists(FstrLayPromo);

  If Not  blnCarregarModelo Then
  Begin
    FstrLayPromo := fCfgSis('PATETI') + '\Relatorio_Promocao_CRM.fr3';
    blnCarregarModelo := FileExists(FstrLayPromo);

    If fEmptyStr(FTituloRelatorio) And blnCarregarModelo Then
    Begin
      FTituloRelatorio := 'QUINZENAL';
    End
    Else If (Not blnCarregarModelo) Then
    Begin
      FstrLayPromo := fPathLayoutPromocao(blnCarregarModelo);
    End;
  End;

  If blnCarregarModelo  Then
  Begin
    FfrxRelJato.LoadFromFile(FstrLayPromo);
    pSetarVariaveisRelatorio;
  End;
End;

function TCatalogoPromocao.fPathLayoutPromocao(Var blnCarregarModelo: Boolean): String;
  Const
    LAYPRO = '\Layout_Promocao_CRM.fr3';
  Var
    strPath: String;
begin
  strPath := ExtractFilePath(Application.ExeName) + LAYPRO;

  If (FileExists(strPath)) Then
  Begin
    blnCarregarModelo := True;
    Result := strPath;
  End
  Else
  Begin
    strPath := fCfgSis('PATETI') + LAYPRO;

    If (FileExists(strPath)) Then
    Begin
      blnCarregarModelo := True;
      Result := strPath;
    End;
  End;
end;

procedure TCatalogoPromocao.pConsultarGeral;
begin
  FblnEmConsultaPorCliente := False;

  FqryItens.Close;
  FqryItens.SQL.Clear;
  FqryItens.SQL.Text := fGetSQL;
  pSetaParametros;
  FqryItens.Open;

  If Not FCfgIncrem Then
  Begin
    If Assigned(FcdsDados) Then
      FreeAndNil(FcdsDados);

    FcdsDados := fCriaClientDatSet(FqryItens);
  End
  Else
  Begin
    If Not Assigned(FcdsDados) Then
      FcdsDados := fCriaClientDatSet(FqryItens)
    Else
      pAdicionaItensCatalogo;
  End;

  pFormatarCampos(FcdsDados);

  If (FfltValorDesc > 0) Then
  Begin
    If Not (fVerificaPodeAplicarDesconto(FcdsDados)) Then
    Begin
      Exit;
    End;

    If Not FblnGeracaoGlobalOco Then
    Begin
      fExecutarModal(pAplicarDesconto, 'Aguarde, calculando '+
        'preço de venda com desconto ...', '');
    End
    Else
      pAplicarDesconto;
  End;

  If Not FblnGeracaoGlobalOco Then
  Begin
    fExecutarModal(pCalcularMargem, 'Aguarde, calculando '+
      'margem dos produtos ...', '');
  End
  Else
    pCalcularMargem;

  If Not FblnGeracaoGlobalOco Then
  Begin
    fExecutarModal(pCalcularPrecoComImpostos, 'Aguarde, calculando '+
      'preço com impostos  ...', '');
  End
  Else
    pCalcularPrecoComImpostos;

end;

procedure TCatalogoPromocao.pConsultarGrupoClientes;
var
  intCnt: Integer;
begin
  If (Not Assigned(FcdsDadosAux)) Then
    Exit;

  FcdsDadosAux.EmptyDataSet;

  FblnGeracaoGlobalOco := True;

  FblnFiltrarPromoPorCli := True;

  Try
    For intCnt:=0 To Length(FarrCodCliCons)-1 Do
    Begin
      FstrCodCli := FarrCodCliCons[intCnt];
      pConsultarPorCliente;

      If (Assigned(FcdsDadosCli)) Then
      Begin

        FcdsDadosCli.First;
        While Not FcdsDadosCli.EOF Do
        Begin
          FcdsDadosAux.Append;
          FcdsDadosAux.FieldByname('Cliente').AsString   := FstrCodCli;
          FcdsDadosAux.FieldByname('Código').AsString    := FcdsDadosCli.FieldByname('Código').AsString;
          FcdsDadosAux.FieldByname('Descrição').AsString := FcdsDadosCli.FieldByname('Descrição').AsString;
          FcdsDadosAux.FieldByname('Referência').AsString := FcdsDadosCli.FieldByname('Referência').AsString;
          FcdsDadosAux.FieldByname('Código de Fábrica').AsString := FcdsDadosCli.FieldByname('Código de Fábrica').AsString;
          FcdsDadosAux.FieldByname('Aplicação').AsString := FcdsDadosCli.FieldByname('Aplicação').AsString;
          FcdsDadosAux.FieldByname('Unidade').AsString := FcdsDadosCli.FieldByname('Unidade').AsString;
          FcdsDadosAux.FieldByname('Saldos').AsFloat := FcdsDadosCli.FieldByname('Saldos').AsFloat;
          FcdsDadosAux.FieldByname('Preço Custo').AsFloat := FcdsDadosCli.FieldByname('Preço Custo').AsFloat;
          FcdsDadosAux.FieldByname('Preço Venda').AsFloat := FcdsDadosCli.FieldByname('Preço Venda').AsFloat;

          FcdsDadosAux.FieldByname('Preço c/ Imp. c/').AsFloat := FcdsDadosCli.FieldByname('Preço c/ Imp. c/').AsFloat;
          FcdsDadosAux.FieldByname('Preço Promoção').AsFloat := FcdsDadosCli.FieldByname('Preço Promoção').AsFloat;
          FcdsDadosAux.FieldByname('Preço Promoção c/ Imp.').AsFloat := FcdsDadosCli.FieldByname('Preço Promoção c/ Imp.').AsFloat;
          FcdsDadosAux.FieldByname('Preço Tabela').AsFloat := FcdsDadosCli.FieldByname('Preço Tabela').AsFloat;
          FcdsDadosAux.FieldByname('Preço com Impostos').AsFloat := FcdsDadosCli.FieldByname('Preço com Impostos').AsFloat;

          FcdsDadosAux.FieldByname('Promoção').AsString := FcdsDadosCli.FieldByname('Promoção').AsString;
          FcdsDadosAux.FieldByname('DescPromo').AsString := FcdsDadosCli.FieldByname('DescPromo').AsString;
          If FcdsDadosCli.FieldByname('Valid. Inicial').AsDateTime > 0 Then
            FcdsDadosAux.FieldByname('Valid. Inicial').AsDateTime := FcdsDadosCli.FieldByname('Valid. Inicial').AsDateTime;
          If FcdsDadosCli.FieldByname('Valid. Final').AsDateTime > 0 Then
            FcdsDadosAux.FieldByname('Valid. Final').AsDateTime := FcdsDadosCli.FieldByname('Valid. Final').AsDateTime;
          FcdsDadosAux.FieldByname('Desc. Porcentagem').AsFloat := FcdsDadosCli.FieldByname('Desc. Porcentagem').AsFloat;
          FcdsDadosAux.FieldByname('Margem').AsFloat := FcdsDadosCli.FieldByname('Margem').AsFloat;
          FcdsDadosAux.FieldByname('Marca').AsString := FcdsDadosCli.FieldByname('Marca').AsString;
          FcdsDadosAux.FieldByname('Nvl. Giro E.Geral').AsString := FcdsDadosCli.FieldByname('Nvl. Giro E.Geral').AsString;
          FcdsDadosAux.FieldByname('Preço').AsString := FcdsDadosCli.FieldByname('Preço').AsString;
          FcdsDadosAux.FieldByname('CaminhoImagem').AsString := FcdsDadosCli.FieldByname('CaminhoImagem').AsString;
          FcdsDadosAux.FieldByname('Montadora').AsString := FcdsDadosCli.FieldByname('Montadora').AsString;
          FcdsDadosAux.FieldByname('Aplicacao').AsString := FcdsDadosCli.FieldByname('Aplicacao').AsString;
          FcdsDadosAux.FieldByname('IndiceImagem').AsInteger := FcdsDadosCli.FieldByname('IndiceImagem').AsInteger;
          FcdsDadosAux.FieldByname('ImgCarregada').AsString := FcdsDadosCli.FieldByname('ImgCarregada').AsString;
          FcdsDadosAux.FieldByname('ThumGerado').AsString := FcdsDadosCli.FieldByname('ThumGerado').AsString;
          FcdsDadosAux.FieldByname('AUTINCIMG').AsString := FcdsDadosCli.FieldByname('AUTINCIMG').AsString;
          FcdsDadosAux.FieldByname('ITE_DESMAX').AsFloat := FcdsDadosCli.FieldByname('ITE_DESMAX').AsFloat;
          FcdsDadosAux.FieldByname('ITE_CODGRU').AsString := FcdsDadosCli.FieldByname('ITE_CODGRU').AsString;
          FcdsDadosAux.FieldByname('UNI_CODUNI').AsString := FcdsDadosCli.FieldByname('UNI_CODUNI').AsString;
          FcdsDadosAux.FieldByname('ITE_CODFOR').AsString := FcdsDadosCli.FieldByname('ITE_CODFOR').AsString;
          FcdsDadosAux.FieldByname('ITE_COMLUB').AsString := FcdsDadosCli.FieldByname('ITE_COMLUB').AsString;
          FcdsDadosAux.FieldByname('ITE_IPISAI').AsFloat := FcdsDadosCli.FieldByname('ITE_IPISAI').AsFloat;
          FcdsDadosAux.FieldByname('ITE_COMVAR').AsFloat := FcdsDadosCli.FieldByname('ITE_COMVAR').AsFloat;
          FcdsDadosAux.FieldByname('ITE_COMATA').AsFloat := FcdsDadosCli.FieldByname('ITE_COMATA').AsFloat;
          FcdsDadosAux.FieldByname('ITE_COMDIS').AsFloat := FcdsDadosCli.FieldByname('ITE_COMDIS').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREULT').AsFloat := FcdsDadosCli.FieldByname('ITE_PREULT').AsFloat;
          FcdsDadosAux.FieldByname('ITE_IMPULT').AsFloat := FcdsDadosCli.FieldByname('ITE_IMPULT').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREMED').AsFloat := FcdsDadosCli.FieldByname('ITE_PREMED').AsFloat;
          FcdsDadosAux.FieldByname('ITE_CLAIPI').AsString := FcdsDadosCli.FieldByname('ITE_CLAIPI').AsString;
          FcdsDadosAux.FieldByname('ITE_PESOIT').AsFloat := FcdsDadosCli.FieldByname('ITE_PESOIT').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PESLIQ').AsFloat := FcdsDadosCli.FieldByname('ITE_PESLIQ').AsFloat;
          FcdsDadosAux.FieldByname('ITE_CODFAB').AsString := FcdsDadosCli.FieldByname('ITE_CODFAB').AsString;
          FcdsDadosAux.FieldByname('ITE_MARMIN').AsFloat := FcdsDadosCli.FieldByname('ITE_MARMIN').AsFloat;
          FcdsDadosAux.FieldByname('ITE_MARMSG').AsFloat := FcdsDadosCli.FieldByname('ITE_MARMSG').AsFloat;
          FcdsDadosAux.FieldByname('ITE_MARMGE').AsFloat := FcdsDadosCli.FieldByname('ITE_MARMGE').AsFloat;
          FcdsDadosAux.FieldByname('ITE_CODMAR').AsString := FcdsDadosCli.FieldByname('ITE_CODMAR').AsString;
          FcdsDadosAux.FieldByname('ITE_PRECOM').AsFloat := FcdsDadosCli.FieldByname('ITE_PRECOM').AsFloat;
          FcdsDadosAux.FieldByname('ITE_QTPPRO').AsFloat := FcdsDadosCli.FieldByname('ITE_QTPPRO').AsFloat;
          FcdsDadosAux.FieldByname('ITE_IPIENT').AsFloat := FcdsDadosCli.FieldByname('ITE_IPIENT').AsFloat;
          FcdsDadosAux.FieldByname('ITE_FREENT').AsFloat := FcdsDadosCli.FieldByname('ITE_FREENT').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PRECUS').AsFloat := FcdsDadosCli.FieldByname('ITE_PRECUS').AsFloat;
          FcdsDadosAux.FieldByname('ITE_OBRCPF').AsString := FcdsDadosCli.FieldByname('ITE_OBRCPF').AsString;
          FcdsDadosAux.FieldByname('ITE_CODBAR').AsString := FcdsDadosCli.FieldByname('ITE_CODBAR').AsString;
          FcdsDadosAux.FieldByname('ITE_PREVE1').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE1').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE2').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE2').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE3').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE3').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE4').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE4').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE5').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE5').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE6').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE6').AsFloat;
          FcdsDadosAux.FieldByname('ITE_PREVE7').AsFloat := FcdsDadosCli.FieldByname('ITE_PREVE7').AsFloat;
          FcdsDadosAux.FieldByname('ITE_CODABF').AsString := FcdsDadosCli.FieldByname('ITE_CODABF').AsString;
          FcdsDadosAux.FieldByname('ITE_PRECUS').AsFloat := FcdsDadosCli.FieldByname('ITE_PRECUS').AsFloat;
          FcdsDadosAux.FieldByname('ITE_DTAUVE').AsDateTime := FcdsDadosCli.FieldByname('ITE_DTAUVE').AsDateTime;
          FcdsDadosAux.FieldByname('QTDIA_SVND').AsInteger := FcdsDadosCli.FieldByname('QTDIA_SVND').AsInteger;
          FcdsDadosAux.Post;

          FcdsDadosCli.Next;
        End;
      End;
    End;
  Finally

    If (Assigned(FcdsDadosCli)) Then
    Begin
      FcdsDadosCli.EmptyDataSet;
      pCloneDataSet(FcdsDadosCli, FcdsDadosAux);

      pFormatarCampos(FcdsDadosCli);
      FcdsDadosCli.EnableControls;
    End;

  End;
end;

procedure TCatalogoPromocao.pConsultarPorCliente;
begin
  FblnEmConsultaPorCliente := True;
  FqryItens.Close;
  FqryItens.SQL.Clear;
  FqryItens.SQL.Text := fGetSQL;
  pSetaParametros;
  FqryItens.Open;

  If Assigned(FcdsDadosCli) Then
    FreeAndNil(FcdsDadosCli);

  FcdsDadosCli := fCriaClientDatSet(FqryItens);

  pFormatarCampos(FcdsDadosCli);

  If (FfltValorDesc > 0) Then
  Begin
    If Not (fVerificaPodeAplicarDesconto(FcdsDadosCli)) Then
    Begin
      Exit;
    End;

    If Not FblnGeracaoGlobalOco Then
    Begin
      fExecutarModal(pAplicarDesconto, 'Aguarde, calculando '+
        'preço de venda com desconto ...', '');
    End
    Else
      pAplicarDesconto;
  End;

  If Not FblnGeracaoGlobalOco Then
  Begin
    fExecutarModal(pCalcularMargem, 'Aguarde, calculando '+
      'margem dos produtos ...', '');
  End
  Else
    pCalcularMargem;

  If Not FblnGeracaoGlobalOco Then
  Begin
    fExecutarModal(pCalcularPrecoComImpostos, 'Aguarde, calculando '+
      'preço com impostos  ...', '');
  End
  Else
    pCalcularPrecoComImpostos;
end;

function TCatalogoPromocao.fAddClienteParaConsulta(
  const strCodCliParam: String): Boolean;
var
  intTam,
  intCnt: Integer;
  blnEncontrou: Boolean;
begin
  If fEmptyStr(strCodCliParam) Then
    Exit(False);

  blnEncontrou := False;
  For intCnt:=0 To Length(FarrCodCliCons)-1 Do
  Begin
    blnEncontrou := (strCodCliParam = FarrCodCliCons[intCnt]);
  End;

  Result := False;
  If Not blnEncontrou Then
  Begin
    intTam := Length(FarrCodCliCons) + 1;
    SetLength(FarrCodCliCons, intTam);
    FarrCodCliCons[intTam-1] := strCodCliParam;

    Result := True;
  End;
end;

function TCatalogoPromocao.fAdicionarImagemList(ImageList: TcxImageCollection;
  tbImagem: TPicture): Boolean;
var
  item: TcxImageCollectionItem;
begin
  If Not Assigned(tbImagem) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    item := ImageList.Items.Add;
    item.Picture.Assign(tbImagem);
    Result := True;
  Except
    On E: Exception do
    Begin
      Result := False;
    End;
  End;
end;

function TCatalogoPromocao.fCalculaMargem(fltPreCus, fltPreVen: Double): Double;
begin
  Result := fCalculaPrecoVenda(2, fltPreCus, fltPreVen, 0, 0, 0, 0, 0);
end;

function TCatalogoPromocao.fGerarArquivoAnexo: String;
var
  strNomArq: String;
  strNomDir: String;
begin
  If Not fEmptyStr(FDirPDF) Then
    strNomDir := FDirPDF
  Else
    strNomDir := IncludeTrailingPathDelimiter(FNomDirArq) + 'Catalogo Promocoes\';

  Try
    If Not DirectoryExists(strNomDir) Then
      ForceDirectories(strNomDir);

    strNomArq := IncludeTrailingPathDelimiter(strNomDir) +
                 FstrCodCli + '-' +
                 FormatDateTime('dd-mm-yyyy hh_mm_ss', VS_Date + fTime()) + '-' +
                 FTituloRelatorio +'.pdf';

    FfrxExpPDF.FileName    := strNomArq;
    FfrxExpPDF.DefaultPath := strNomDir;
    FfrxExpPDF.ShowDialog  := False;
    FfrxRelJato.Export(FfrxExpPDF);
  Finally
    Result := strNomArq;
  End;
end;

function TCatalogoPromocao.fGetSQL: String;
begin
  Try
    pCarregaDadosTabelaTmp(IIF(FblnUsaTabPrecoProm, FstrTabPrecoProm, '1'),
                           FstrTabPrecoProm,
                           FstrCodCli,
                           FdtaVigencia,
                           FstrCndPag
                          );

    Result := 'SELECT SQL_NO_CACHE ' +
              '  " " As Cliente, ' +
              '  CADITE.ITE_REFERE AS "Referência", ' +
              '  CADITE.ITE_CODITE AS "Código", ' +
              '  CADITE.ITE_CODFAB AS "Código de Fábrica", ' +
              '  CADITE.ITE_DESITE AS "Descrição", ' +
              '  REPLACE(CADITE.ITE_APLICA, "<<csq>>"," ") AS "Aplicação", ' +
              '  CADUNI.UNI_SIGUNI AS "Unidade", ' +
                fSQLSaldoDisponivel('G') + ' AS "Saldos", ' +
              '  G.ITE_PRECUS      AS "Preço Custo", ' +
              ' (CASE WHEN TMP_CODPRO IS NOT NULL THEN G.ITE_PREVE' + (FstrTabPrecoProm) +  ' ' +
              '  ELSE G.ITE_PREVE'+ (FstrTabPreco) + ' END)' +  ' AS "Preço Venda", ' +


              ' 0.00 AS "Preço c/ Imp. c/", ' +
                fRetSQLPrecoVendaPromoItem(' (CASE WHEN TMP_CODPRO IS NOT NULL THEN ITE_PREVE' + (FstrTabPrecoProm) +  ' ' +
                                                    '  ELSE ITE_PREVE'+ (FstrTabPreco) + ' END)') +
              ' AS "Preço Promoção" , ' +
              ' 0.00 AS "Preço Promoção c/ Imp.", ' +
              '  G.ITE_PREVE' + IIF(FblnUsaTabPreco, FstrTabPreco, '1') + ' AS "Preço Tabela", ' +
              ' 0.00 As "Preço com Impostos", ' +
              ' TMP_CODPRO AS "Promoção", ' +
              ' TMP_DESPRO AS "DescPromo", ' +
              ' TMP_VALINI AS "Valid. Inicial", ' +
              ' TMP_VALFIN AS "Valid. Final", ' +
              ' TMP_PERDES AS "Desc. Porcentagem", ' +
              '  CAST(NULL AS DECIMAL(12,4)) AS "Margem", ' +
              '  "N" AS "Marcado", ' +
              '  CADMAR.MAR_DESMAR AS "Marca",   '+
              '  CADITE.ITE_NVLGIR AS "Nvl. Giro E.Geral", ' +
              '  "                            " AS "Preço",  ' +
              '  CONCAT(:PATHIMG, CADITE.ITE_CODITE, ".jpg") AS "CaminhoImagem", ' +
              '  MON_DESCRI AS "Montadora", ' +
              '  CADITE.ITE_APLICA AS "Aplicacao", ' +
              '  0 as IndiceImagem,    ' +
              '  "N" as ImgCarregada,  ' +
              ' (CASE WHEN ITE_THUB64 IS NOT NULL THEN "S" ELSE "N"  END ) as ThumGerado,  ' +
              ' ITEIMG.AUTOINCREM AS AUTINCIMG, ' +
              ' ITE_DESMAX, ' +
              ' ITE_CODGRU, ' +
              ' UNI_CODUNI, ' +
              ' ITE_CODFOR, ' +
              ' ITE_COMLUB, ' +
              ' ITE_IPISAI, ' +
              ' ITE_COMVAR, ' +
              ' ITE_COMATA, ' +
              ' ITE_COMDIS, ' +
              ' ITE_PREULT, ' +
              ' ITE_IMPULT, ' +
              ' ITE_PREMED, ' +
              ' ITE_CLAIPI, ' +
              ' ITE_PESOIT, ' +
              ' ITE_PESLIQ, ' +
              ' ITE_CODFAB, ' +
              ' ITE_MARMIN, ' +
              ' ITE_MARMSG, ' +
              ' ITE_MARMGE, ' +
              ' ITE_CODMAR, ' +
              ' ITE_PRECOM, ' +
              ' ITE_QTPPRO, ' +
              ' ITE_IPIENT, ' +
              ' ITE_FREENT, ' +
              ' ITE_PRECUS, ' +
              ' ITE_OBRCPF, ' +
              ' ITE_CODBAR, ' +
              ' ITE_PREVE1, ' +
              ' ITE_PREVE2, ' +
              ' ITE_PREVE3, ' +
              ' ITE_PREVE4, ' +
              ' ITE_PREVE5, ' +
              ' ITE_PREVE6, ' +
              ' ITE_PREVE7, ' +
              ' CADITE.ITE_CODABF, ' +
              ' G.ITE_DTAUVE, ' +
               fRetSQLQtdSVenda + ' AS QTDIA_SVND ';
              Result := Result +
              '  FROM CADITE ' +
              '  INNER JOIN CADGRU ' +
              '    ON CADITE.ITE_CODGRU = CADGRU.GRU_CODGRU ' +
              '  INNER JOIN CADUNI ' +
              '    ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ' +
              '  INNER JOIN ITEGER G ' +
              '    ON G.ITE_CODITE = CADITE.ITE_CODITE ' +
              '    AND G.ITE_CODEMP = :CODEMP ' +
              '  LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ' +
              'LEFT JOIN ITEIMG ON ITEIMG.ITE_CODITE = CADITE.ITE_CODITE AND ITE_PRINCI = "S" ' +
              'LEFT JOIN CADMON ON ITE_CODMON = MON_CODMON ';

    Result := Result +  IIF(FblnSomenteEmPromocao, ' INNER JOIN ',  ' LEFT JOIN ');
    Result := Result +  strNomTabTemp + ' PROMOCAO ON (PROMOCAO.TMP_CODEMP = G.ITE_CODEMP AND PROMOCAO.TMP_CODITE = CADITE.ITE_CODITE)';
    Result := Result +  ' WHERE CADITE.ITE_ITEATI = "S" ';

    Result := Result +  fRetSQLWhere;

    Result := Result + ' ORDER BY `Descrição`, `Código` ';

    Result := Result + IIF(FblnRestaurandoPadrao,  ' LIMIT 100 ', '');

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TCatalogoPromocao.fGetSQL]');
  End;
end;

function TCatalogoPromocao.fGetSQLCondicaoPromocaoPorDesconto: String;
begin
  Result := ' ((TMP_PREDES = "D" AND TMP_IDXPRO <> '+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional])+')'+
            '  OR (TMP_IDXPRO IN ('+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon])+','+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva])+'))) '
end;

function TCatalogoPromocao.fRetSQLPrecoVendaPromoItem(strTabPre: String =''): String;
Begin
  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + ' ((1 - (TMP_PERDES / 100)) * ' + strTabPre +') ';
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 1, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 2, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE2) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 3, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE3) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 4, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE4) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 5, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE5) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 6, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE6) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 7, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE7) ';
    Result := Result + '   ELSE ((1 - (TMP_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + ' END ';
  End;

  Result := ' IF('+fGetSQLCondicaoPromocaoPorDesconto+', ' + Result + ', TMP_PREVEN) ';

  Result := fRetSQLPorcentoDescontoComDescontoAdicionalItem(Result, strTabPre);
End;

function TCatalogoPromocao.fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;
  Var
    strIdxPro : String;
begin
  strIdxPro := IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]);

  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + IIF( Pos('1', strTabPre) > 0, 'TMP_PREVEN', strTabPre);
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 1, 1) = "S" THEN TMP_PREVEN';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 2, 1) = "S" THEN TMP_PREVE2';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 3, 1) = "S" THEN TMP_PREVE3';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 4, 1) = "S" THEN TMP_PREVE4';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 5, 1) = "S" THEN TMP_PREVE5';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 6, 1) = "S" THEN TMP_PREVE6';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 7, 1) = "S" THEN TMP_PREVE7';
    Result := Result + '   ELSE TMP_PREVEN ';
    Result := Result + ' END ';
  End;

  Result := ' IF(TMP_IDXPRO = ' + strIdxPro + ', ' + Result + ', ' + strSQLPreco + ') ';
end;

procedure TCatalogoPromocao.pCriarDataSetDados(const cdsDadosParam: TUniClientDataSet);
Begin
  cdsDadosParam.FieldDefs.Add('Marcado', ftString, 1);
  cdsDadosParam.FieldDefs.Add('Cliente', ftString, 8);
  cdsDadosParam.FieldDefs.Add('Referência', ftString, 16);
  cdsDadosParam.FieldDefs.Add('Código', ftString, 5);
  cdsDadosParam.FieldDefs.Add('Código de Fábrica', ftString, 50);
  cdsDadosParam.FieldDefs.Add('Descrição', ftString, 70);
  cdsDadosParam.FieldDefs.Add('Aplicação', ftString, 100);
  cdsDadosParam.FieldDefs.Add('Unidade', ftString, 4);
  cdsDadosParam.FieldDefs.Add('Saldos', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço Custo', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço Venda', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço c/ Imp. c/', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço Promoção', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço Promoção c/ Imp.', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço Tabela', ftFloat);
  cdsDadosParam.FieldDefs.Add('Preço com Impostos', ftFloat);
  cdsDadosParam.FieldDefs.Add('Promoção', ftFloat);
  cdsDadosParam.FieldDefs.Add('DescPromo', ftString, 80);
  cdsDadosParam.FieldDefs.Add('Valid. Inicial', ftDateTime);
  cdsDadosParam.FieldDefs.Add('Valid. Final', ftDateTime);
  cdsDadosParam.FieldDefs.Add('Desc. Porcentagem', ftFloat);
  cdsDadosParam.FieldDefs.Add('Margem', ftFloat);
  cdsDadosParam.FieldDefs.Add('Marca', ftString, 30);
  cdsDadosParam.FieldDefs.Add('Nvl. Giro E.Geral', ftString, 1);
  cdsDadosParam.FieldDefs.Add('Preço', ftString, 40);
  cdsDadosParam.FieldDefs.Add('CaminhoImagem', ftBlob);
  cdsDadosParam.FieldDefs.Add('Montadora', ftString, 40);
  cdsDadosParam.FieldDefs.Add('Aplicacao', ftString, 1);
  cdsDadosParam.FieldDefs.Add('IndiceImagem', ftInteger);
  cdsDadosParam.FieldDefs.Add('ImgCarregada', ftString, 1);
  cdsDadosParam.FieldDefs.Add('ThumGerado', ftString, 1);
  cdsDadosParam.FieldDefs.Add('AUTINCIMG', ftString, 20);
  cdsDadosParam.FieldDefs.Add('ITE_DESMAX', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_CODGRU', ftString, 6);
  cdsDadosParam.FieldDefs.Add('UNI_CODUNI', ftString, 1);
  cdsDadosParam.FieldDefs.Add('ITE_CODFOR', ftString, 8);
  cdsDadosParam.FieldDefs.Add('ITE_COMLUB', ftString, 1);
  cdsDadosParam.FieldDefs.Add('ITE_IPISAI', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_COMVAR', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_COMATA', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_COMDIS', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREULT', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_IMPULT', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREMED', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_CLAIPI', ftString, 10);
  cdsDadosParam.FieldDefs.Add('ITE_PESOIT', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PESLIQ', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_CODFAB', ftString, 50);
  cdsDadosParam.FieldDefs.Add('ITE_MARMIN', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_MARMSG', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_MARMGE', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_CODMAR', ftString, 6);
  cdsDadosParam.FieldDefs.Add('ITE_PRECOM', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_QTPPRO', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_IPIENT', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_FREENT', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PRECUS', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_OBRCPF', ftString, 1);
  cdsDadosParam.FieldDefs.Add('ITE_CODBAR', ftString, 20);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE1', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE2', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE3', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE4', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE5', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE6', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_PREVE7', ftFloat);
  cdsDadosParam.FieldDefs.Add('ITE_CODABF', ftString, 3);
  cdsDadosParam.FieldDefs.Add('ITE_DTAUVE', ftDateTime);
  cdsDadosParam.FieldDefs.Add('QTDIA_SVND', ftInteger);

  cdsDadosParam.CreateDataSet;
  cdsDadosParam.LogChanges := False;
  cdsDadosParam.IndexFieldNames := 'Cliente';

  cdsDadosParam.Open;
  pFormatarCampos(cdsDadosParam);
end;

procedure TCatalogoPromocao.pCriaTabelaTemp;
var
  strSQL: String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + ' CREATE TABLE ' + FTabelaTemp + ' ( ';
    strSQL := strSQL + '   TMP_SEQPRO VARCHAR(20),          ';
    strSQL := strSQL + '   TMP_SEQITE VARCHAR(20),          ';
    strSQL := strSQL + '   TMP_CODPRO VARCHAR(08),          ';
    strSQL := strSQL + '   TMP_DESPRO VARCHAR(80),          ';
    strSQL := strSQL + '   TMP_VALINI DATE,                 ';
    strSQL := strSQL + '   TMP_VALFIN DATE,                 ';
    strSQL := strSQL + '   TMP_CODITE VARCHAR(' + IntToStr(VS_intTamCadIte) + '),  ';
    strSQL := strSQL + '   TMP_CODCLI VARCHAR(08),          ';
    strSQL := strSQL + '   TMP_CODEMP CHAR(03),             ';
    strSQL := strSQL + '   TMP_IDXPRO INT(11),              ';
    strSQL := strSQL + '   TMP_PREDES CHAR(1),              ';
    strSQL := strSQL + '   TMP_PREVEN DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE2 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE3 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE4 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE5 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE6 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE7 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_TABPRE VARCHAR(7),           ';
    strSQL := strSQL + '   TMP_PERDES DECIMAL(12,4),        ';
    strSQL := strSQL + '   KEY IDX_' + FTabelaTemp + '_01 (TMP_CODEMP, TMP_CODPRO, TMP_CODITE, TMP_SEQPRO) ';
    strSQL := strSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaTabelaTemp]');
    End;
  End;

end;

procedure TCatalogoPromocao.pEnviarArquivoPorEmail;
var LQuery : TUniQuery;
    LEmailCliente : String;
    LobjEnvioEmail : TEmaAut;
    LDadosAutenticacao: TDadosLoginEmail;
    arrDestinatarios: TStringArray;
    arrArquivos: TStringArray;
begin
  Try
    LQuery := fCriaQuery(Nil);
    LobjEnvioEmail := TEmaAut.Create(Nil);
    Try
      LQuery.Sql.Add('SELECT CLI_EMAIL_ AS EMAIL_, '+
                     '       CLI_EMAIL2 AS EMAIL2, '+
                     '       CLI_EMAIL3 AS EMAIL3, '+
                     '       CLI_NOMCLI, '+
                     '       CONCAT(CID_NOMCID, "-", CID_ESTADO) AS NOMCID '+
                     '  FROM CADCLI '+
                     ' LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID '+
                     ' WHERE CLI_CODCLI = :CODCLI ');

      LQuery.ParamByName('CODCLI').AsString := strCodCli;
      LQuery.Open;
      if not fEmptyStr(LQuery.FieldByName('EMAIL_').AsString) then
        LEmailCliente := LQuery.FieldByName('EMAIL_').AsString
      else
      if not fEmptyStr(LQuery.FieldByName('EMAIL2').AsString) then
        LEmailCliente := LQuery.FieldByName('EMAIL2').AsString
      else
      if not fEmptyStr(LQuery.FieldByName('EMAIL3').AsString) then
        LEmailCliente := LQuery.FieldByName('EMAIL3').AsString;

      LobjEnvioEmail.strCodGru             := '010';
      LobjEnvioEmail.strCodigo             := '001';
      LobjEnvioEmail.strCodOpe             := strLoginUsuarioLogado;
      LobjEnvioEmail.strEmaCli             := LEmailCliente;
      LobjEnvioEmail.strNomCli             := LQuery.FieldByName('CLI_NOMCLI').AsString;
      LobjEnvioEmail.strPriCli             := fRetPrimeiraPalavra(LQuery.FieldByName('CLI_NOMCLI').AsString);
      LobjEnvioEmail.strCidCli             := LQuery.FieldByName('NOMCID').AsString;

      If not(LobjEnvioEmail.fTemEmailAtivo) then
        pMensagemOk('A configuração de e-mail para expedição de promoções não está'+
                    ' ativa. O envio do e-mail será abortado.')
      Else
        LobjEnvioEmail.fEnviaEmailAutomatico(False);

      LDadosAutenticacao.Senha := LobjEnvioEmail.FSenha;
      LDadosAutenticacao.Email := LobjEnvioEmail.FEmail;
      LDadosAutenticacao.Login := LobjEnvioEmail.FLogin;
      LDadosAutenticacao.Remetente := LobjEnvioEmail.FRemete;
      LDadosAutenticacao.ServidorSMTP := LobjEnvioEmail.FSerSmt;
      LDadosAutenticacao.ServidorImap := LobjEnvioEmail.FSerIma;
      LDadosAutenticacao.TextoAssinatura := LobjEnvioEmail.FTxtAss;
      LDadosAutenticacao.GravaPastaEnviados := LobjEnvioEmail.FGravaPastaEnviados;
      LDadosAutenticacao.Provedor := LobjEnvioEmail.FCodPrv;
      LDadosAutenticacao.PortaSMTP := LobjEnvioEmail.FPorSmt;
      LDadosAutenticacao.PortaImap := LobjEnvioEmail.FPorIma;
      LDadosAutenticacao.LimiteArquivos := LobjEnvioEmail.FLimArq;
      LDadosAutenticacao.ImagemAssinatura := LobjEnvioEmail.FImgAss;
      LDadosAutenticacao.AutenticacaoSSL := LobjEnvioEmail.FSSLSai;
      LDadosAutenticacao.AutenticacaoSSLImap := LobjEnvioEmail.FSSLEnt;
      LDadosAutenticacao.ImagemAssinaturaStream := LobjEnvioEmail.FImaAss;

      If (LobjEnvioEmail.FImgAss) Then
      Begin
        LDadosAutenticacao.ImagemAssinaturaStream := TMemoryStream.Create;

        If LobjEnvioEmail.FImaAss <> Nil Then
        Begin
          LobjEnvioEmail.FImaAss.SaveToStream(LDadosAutenticacao.ImagemAssinaturaStream);
          LDadosAutenticacao.ImagemAssinaturaStream.Seek(0,soFromBeginning);
        End;
      End
      Else
        LDadosAutenticacao.ImagemAssinaturaStream := nil;

      pCriarArrayAnexosEDestinatarios(fGerarArquivoAnexo, LEmailCliente, arrDestinatarios, arrArquivos);

      TEnvioEmail.EnviarEmail(nil,
                              strLoginUsuarioLogado,
                              LobjEnvioEmail.strAssunt,
                              arrDestinatarios,
                              [],
                              [],
                              [LobjEnvioEmail.strCorpo],
                              arrArquivos,
                              True,
                              False,
                              EmptyStr,
                              EmptyStr,
                              0,
                              False,
                              LDadosAutenticacao.Senha,
                              LDadosAutenticacao.Email,
                              LDadosAutenticacao.Login,
                              LDadosAutenticacao.Remetente,
                              LDadosAutenticacao.Provedor,
                              LDadosAutenticacao.PortaSMTP,
                              LDadosAutenticacao.PortaIMAP,
                              LDadosAutenticacao.ServidorSMTP,
                              LDadosAutenticacao.ServidorImap,
                              LDadosAutenticacao.LimiteArquivos,
                              LDadosAutenticacao.ImagemAssinatura,
                              LDadosAutenticacao.TextoAssinatura,
                              LDadosAutenticacao.ImagemAssinaturaStream,
                              EmptyStr,
                              EmptyStr,
                              LDadosAutenticacao.AutenticacaoSSL,
                              LDadosAutenticacao.AutenticacaoSSLImap,
                              LDadosAutenticacao.GravaPastaEnviados,
                              'N',
                              strCodCli);
    Finally
      FreeAndNil(LQuery);
      FreeAndNil(LobjEnvioEmail);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCatalogoPromocao.pEnviarArquivoPorEmail]');
    End;
  End;
end;

procedure TCatalogoPromocao.pExcluiTabelaTemp;
begin
  If fTabelaExiste(FTabelaTemp) Then
    fDropTable(FTabelaTemp);
end;

procedure TCatalogoPromocao.pExibirInformacaoOfertasPromocaoRelatorio;
var
  LMensagemValidadePromocao : String;
begin
  If (Assigned(FfrxRelJato.FindObject('memObservacao'))) Then
  Begin
    TfrxMemoView(FfrxRelJato.FindObject('memObservacao')).Text := StringReplace(
      TfrxMemoView(FfrxRelJato.FindObject('memObservacao')).Text, #13#10, '', [rfReplaceAll]) + ' ' + FTituloRelatorio;
  End;

  If (Not Assigned(FfrxRelJato.FindObject('memObsPromocao'))) Then
    Exit;

  TfrxMemoView(FfrxRelJato.FindObject('memObsPromocao')).Visible := False;

  LMensagemValidadePromocao := fRetValidadePromocaoRelatorio;

  If not fEmptyStr(LMensagemValidadePromocao) Then
  Begin
    TfrxMemoView(FfrxRelJato.FindObject('memObsPromocao')).Visible := True;
    TfrxMemoView(FfrxRelJato.FindObject('memObsPromocao')).Text    := LMensagemValidadePromocao;
  End;

end;

procedure TCatalogoPromocao.pFormatarCampos(const cdsDadosParam: TUniClientDataSet) ;
begin
  TFloatField(cdsDadosParam.FieldByName('Saldos')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsDadosParam.FieldByName('Preço Venda')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDadosParam.FieldByName('Preço Promoção')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDadosParam.FieldByName('Margem')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDadosParam.FieldByName('Desc. Porcentagem')).DisplayFormat := fMskDigitos(2);
  If FfltValorDesc > 0 Then
  begin
    TFloatField(cdsDadosParam.FieldByName('Preço Venda')).DisplayLabel := 'Preço c/ ' + FloatToStr(FfltValorDesc) + '%';
    TFloatField(cdsDadosParam.FieldByName('Preço c/ Imp. c/')).DisplayLabel := 'Preço c/ Imp. c/ ' + FloatToStr(FfltValorDesc) + '%';
  end;
  TFloatField(cdsDadosParam.FieldByName('Preço Tabela')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDadosParam.FieldByName('Preço Promoção c/ Imp.')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDadosParam.FieldByName('Preço com Impostos')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
end;

procedure TCatalogoPromocao.pGerarArquivo(ASaidaTela: Boolean; AEnviarEmail: Boolean; AGerarPDF: Boolean);
var
  strTempDir: String;
  strMenorDataPromocao : String;
  strMaiorDataPromocao : String;
begin
  Try
    Try
      pGerarDadosRel;

      strTempDir := IncludeTrailingPathDelimiter( FNomDirArq ) + 'Thumbnail';
      If Not DirectoryExists(strTempDir) Then
        CreateDir(strTempDir);

      If FcdsDadosRel.IsEmpty Then
      Begin
        FMensagemRetorno := 'Não foram selecionados produtos para gerar o relatório!';
        Exit;
      End;

      FcdsDadosRel.Filtered := False;
      FcdsDadosRel.Filter := 'Marcado = ' + QuotedStr('S');
      FcdsDadosRel.Filtered := True;
      FcdsDadosRel.IndexFieldNames := 'Descrição;Código;';

      pInformarTituloRelatorio;
      pCarregarModeloPersonalizado;
      pPreparaCamposRelatorio;
      pExibirInformacaoOfertasPromocaoRelatorio;
      pCarregarImagens;

      FcdsDadosRel.First;

      FfrxRelatorio.DataSet := FcdsDadosRel;
      FfrxRelJato.Script.Variables['REL_EXEC'] := FormatDateTime('dd/mm/yyyy hh:nn', fNow);
      FfrxRelJato.EngineOptions.TempDir := strTempDir;
      FfrxRelJato.OnUserFunction := frxRelJatoUserFunction;

      If (frxRelJato.FindObject('memRodape') <> nil) Then
      Begin
        strMenorDataPromocao := fMenorDataPromocao;
        strMaiorDataPromocao := fMaiorDataPromocao;

        If (Not fEmptyStr(strMenorDataPromocao)) And (Not fEmptyStr(strMaiorDataPromocao)) Then
          frxRelJato.Script.Variables['REL_RODAPE'] := '* Promoção válida de '+strMenorDataPromocao+' até '+strMaiorDataPromocao+' ou até enquanto durarem os estoques.'
        Else
          frxRelJato.Script.Variables['REL_RODAPE'] := '';
      End;

      IF FfrxRelJato.PrepareReport Then
      Begin
        If AEnviarEmail Then
          pEnviarArquivoPorEmail;

        If AGerarPDF Then
          FNomArq := fGerarArquivoAnexo;

        If ASaidaTela Then
          pPreviewReport('X', 'Y', FfrxRelJato);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TCatalogoPromocao.pCalcularPrecoComImpostos]');
      End;
    End;

  Finally
    FcdsDadosRel.Filter := '';
    FcdsDadosRel.Filtered := False;
    FcdsDadosRel.IndexFieldNames := '';
    FcdsDadosRel.EnableControls;
  End;
end;

function TCatalogoPromocao.fMenorDataPromocao: String;
  Var
    cdsClone : TUniClientDataSet;
begin
  Result := EmptyStr;

  If (FcdsDadosRel.IsEmpty) Then
    Exit();

  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, FcdsDadosRel);

    cdsClone.Filter := 'Marcado = ' + QuotedStr('S') ;
    cdsClone.Filtered := True;
    cdsClone.IndexFieldNames := 'Valid. Inicial;';

    cdsClone.First;
    While (Not cdsClone.Eof) Do
    Begin
      If (Not fEmptyStr(cdsClone.FieldByName('Valid. Inicial').AsString)) Then
        Result := FormatDateTime('dd/mm/yyyy hh:nn', cdsClone.FieldByName('Valid. Inicial').AsDateTime);

      cdsClone.Next;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TCatalogoPromocao.fMaiorDataPromocao: String;
  Var
    cdsClone : TUniClientDataSet;
begin
  Result := EmptyStr;

  If (FcdsDadosRel.IsEmpty) Then
    Exit();

  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, FcdsDadosRel);

    cdsClone.Filter := 'Marcado = ' + QuotedStr('S');
    cdsClone.Filtered := True;

    With cdsClone.IndexDefs.AddIndexDef Do
    Begin
      Name   := 'IDX_VLDFIN';
      Fields := 'Valid. Final';
      Options:= [ixDescending];
    End;

    cdsClone.First;
    While (Not cdsClone.Eof) Do
    Begin
      If (Not fEmptyStr(cdsClone.FieldByName('Valid. Final').AsString)) Then
        Result := FormatDateTime('dd/mm/yyyy hh:nn', cdsClone.FieldByName('Valid. Final').AsDateTime);

      cdsClone.Next;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TCatalogoPromocao.pGerarDadosRel;
begin
  If Assigned(FcdsDados) Then
  Begin
    FcdsDadosRel.Data := FcdsDados.Data;
  End;

  If Assigned(FcdsDadosCli) Then
  Begin
    FcdsDadosCli.DisableControls;
    Try
      FcdsDadosCli.Filtered := False;
      FcdsDadosCli.Filter := 'Marcado = ' + QuotedStr('S') + ' And Cliente = ' +  QuotedStr(FstrCodCli) ;
      FcdsDadosCli.Filtered := True;
      FcdsDadosCli.IndexFieldNames := 'Descrição;Código;';

      FcdsDadosCli.First;
      While Not FcdsDadosCli.Eof Do
      Begin
        FcdsDadosRel.Append;
        FcdsDadosRel.FieldByname('Marcado').AsString   := FcdsDadosCli.FieldByname('Marcado').AsString;;
        FcdsDadosRel.FieldByname('Cliente').AsString   := FstrCodCli;
        FcdsDadosRel.FieldByname('Código').AsString    := FcdsDadosCli.FieldByname('Código').AsString;
        FcdsDadosRel.FieldByname('Descrição').AsString := FcdsDadosCli.FieldByname('Descrição').AsString;
        FcdsDadosRel.FieldByname('Referência').AsString := FcdsDadosCli.FieldByname('Referência').AsString;
        FcdsDadosRel.FieldByname('Código de Fábrica').AsString := FcdsDadosCli.FieldByname('Código de Fábrica').AsString;
        FcdsDadosRel.FieldByname('Aplicação').AsString := FcdsDadosCli.FieldByname('Aplicação').AsString;
        FcdsDadosRel.FieldByname('Unidade').AsString := FcdsDadosCli.FieldByname('Unidade').AsString;
        FcdsDadosRel.FieldByname('Saldos').AsFloat := FcdsDadosCli.FieldByname('Saldos').AsFloat;
        FcdsDadosRel.FieldByname('Preço Custo').AsFloat := FcdsDadosCli.FieldByname('Preço Custo').AsFloat;
        FcdsDadosRel.FieldByname('Preço Venda').AsFloat := FcdsDadosCli.FieldByname('Preço Venda').AsFloat;

        FcdsDadosRel.FieldByname('Preço c/ Imp. c/').AsFloat := FcdsDadosCli.FieldByname('Preço c/ Imp. c/').AsFloat;
        FcdsDadosRel.FieldByname('Preço Promoção').AsFloat := FcdsDadosCli.FieldByname('Preço Promoção').AsFloat;
        FcdsDadosRel.FieldByname('Preço Promoção c/ Imp.').AsFloat := FcdsDadosCli.FieldByname('Preço Promoção c/ Imp.').AsFloat;
        FcdsDadosRel.FieldByname('Preço Tabela').AsFloat := FcdsDadosCli.FieldByname('Preço Tabela').AsFloat;
        FcdsDadosRel.FieldByname('Preço com Impostos').AsFloat := FcdsDadosCli.FieldByname('Preço com Impostos').AsFloat;

        FcdsDadosRel.FieldByname('Promoção').AsString := FcdsDadosCli.FieldByname('Promoção').AsString;
        FcdsDadosRel.FieldByname('DescPromo').AsString := FcdsDadosCli.FieldByname('DescPromo').AsString;
        If FcdsDadosCli.FieldByname('Valid. Inicial').AsDateTime > 0 Then
          FcdsDadosRel.FieldByname('Valid. Inicial').AsDateTime := FcdsDadosCli.FieldByname('Valid. Inicial').AsDateTime;
        If FcdsDadosCli.FieldByname('Valid. Final').AsDateTime > 0 Then
          FcdsDadosRel.FieldByname('Valid. Final').AsDateTime := FcdsDadosCli.FieldByname('Valid. Final').AsDateTime;
        FcdsDadosRel.FieldByname('Desc. Porcentagem').AsFloat := FcdsDadosCli.FieldByname('Desc. Porcentagem').AsFloat;
        FcdsDadosRel.FieldByname('Margem').AsFloat := FcdsDadosCli.FieldByname('Margem').AsFloat;
        FcdsDadosRel.FieldByname('Marca').AsString := FcdsDadosCli.FieldByname('Marca').AsString;
        FcdsDadosRel.FieldByname('Nvl. Giro E.Geral').AsString := FcdsDadosCli.FieldByname('Nvl. Giro E.Geral').AsString;
        FcdsDadosRel.FieldByname('Preço').AsString := FcdsDadosCli.FieldByname('Preço').AsString;
        FcdsDadosRel.FieldByname('CaminhoImagem').AsString := FcdsDadosCli.FieldByname('CaminhoImagem').AsString;
        FcdsDadosRel.FieldByname('Montadora').AsString := FcdsDadosCli.FieldByname('Montadora').AsString;
        FcdsDadosRel.FieldByname('Aplicacao').AsString := FcdsDadosCli.FieldByname('Aplicacao').AsString;
        FcdsDadosRel.FieldByname('IndiceImagem').AsInteger := FcdsDadosCli.FieldByname('IndiceImagem').AsInteger;
        FcdsDadosRel.FieldByname('ImgCarregada').AsString := FcdsDadosCli.FieldByname('ImgCarregada').AsString;
        FcdsDadosRel.FieldByname('ThumGerado').AsString := FcdsDadosCli.FieldByname('ThumGerado').AsString;
        FcdsDadosRel.FieldByname('AUTINCIMG').AsString := FcdsDadosCli.FieldByname('AUTINCIMG').AsString;

        FcdsDadosCli.Next;
      End;
    Finally
      FcdsDadosCli.EnableControls;
    End;
  End;
end;

procedure TCatalogoPromocao.pIncluirItemVenda(const cdsDadosParam: TUniClientDataSet; objFatVenda: TFatVenda;
  strTabela: String; fltVlrVnd, fltVlrDesc: Double);
var
  intCont: Integer;
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
begin

  intCont := 0;
  objFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                          Nil,                                                          // btnAdicionar
                                          'NOR',                                                        // strIdePro
                                          cdsDadosParam.FieldByName('ITE_CODGRU').AsString,                  // strCodGru
                                          cdsDadosParam.FieldByName('Código').AsString,                      // strCodIte
                                          cdsDadosParam.FieldByName('Descrição').AsString,                   // strDesOri
                                          cdsDadosParam.FieldByName('Descrição').AsString,                   // strDesIte
                                          cdsDadosParam.FieldByName('Código de Fábrica').AsString,           // strDesFab
                                          cdsDadosParam.FieldByName('Unidade').AsString,                     // strUnidad
                                          cdsDadosParam.FieldByName('Unidade').AsString,                     // strCodUni
                                          '',                                                           // strCodMar
                                          cdsDadosParam.FieldByName('ITE_CODFOR').AsString,                  // strCodFor
                                          cdsDadosParam.FieldByName('Referência').AsString,                  // strRefere
                                          fltVlrVnd,                                                    // fltUniOri
                                          fltVlrVnd,                                                    // fltUniVis
                                          fltVlrVnd,                                                    // fltUniTar
                                          0.0,                                                          // fltUniTmp
                                          fltVlrDesc,                                                   // fltDesCon
                                          1,                                                            // fltQtdIte
                                          1,                                                            // fltTotIte
                                          'S',                                                          // strEntSai
                                          cdsDadosParam.FieldByName('Preço Custo').AsFloat,                  // fltPreCus
                                          cdsDadosParam.FieldByName('Preço Custo').AsFloat,                  // fltTotCus
                                          cdsDadosParam.FieldByName('ITE_COMLUB').AsString,                  // strComLub
                                          cdsDadosParam.FieldByName('ITE_IPISAI').AsFloat,                   // fltIpiSai
                                          0,                                                            // fltDesMax
                                          cdsDadosParam.FieldByName('ITE_PREVE1').AsFloat,                   // fltPreVe1
                                          cdsDadosParam.FieldByName('ITE_PREVE2').AsFloat,                   // fltPreVe2
                                          cdsDadosParam.FieldByName('ITE_PREVE3').AsFloat,                   // fltPreVe3
                                          cdsDadosParam.FieldByName('ITE_PREVE4').AsFloat,                   // fltPreVe4
                                          cdsDadosParam.FieldByName('ITE_PREVE5').AsFloat,                   // fltPreVe5
                                          cdsDadosParam.FieldByName('ITE_PREVE6').AsFloat,                   // fltPreVe6
                                          cdsDadosParam.FieldByName('ITE_PREVE7').AsFloat,                   // fltPreVe7
                                          0.0,                                                          // fltMarLuc
                                          cdsDadosParam.FieldByName('Saldos').AsFloat,                       // fltSaldos
                                          'N',                                                          // strIncPis
                                          cdsDadosParam.FieldByName('ITE_COMVAR').AsFloat,                   // fltComVar
                                          cdsDadosParam.FieldByName('ITE_COMATA').AsFloat,                   // fltComAta
                                          cdsDadosParam.FieldByName('ITE_COMDIS').AsFloat,                   // fltComDis
                                          '',                                                           // strDocDev
                                          '',                                                           // strEspDev
                                          '',                                                           // strEmpDev
                                          0.0,                                                          // fltQtdDev
                                          0.0,                                                          // fltUniDev
                                          '',                                                           // strIncDev
                                          cdsDadosParam.FieldByName('ITE_PREULT').AsFloat,                   // fltTotUlt
                                          cdsDadosParam.FieldByName('ITE_IMPULT').AsFloat,                   // fltImpUlt
                                          cdsDadosParam.FieldByName('ITE_PREULT').AsFloat,                   // fltPreUlt
                                          cdsDadosParam.FieldByName('ITE_PREMED').AsFloat,                   // fltPreMed
                                          cdsDadosParam.FieldByName('ITE_CLAIPI').AsString,                  // strClaIpi
                                          '',                                                           // strIteCha
                                          '',                                                           // strIteTin
                                          '',                                                           // strDesCor
                                          '',                                                           // strTipPre
                                          0,                                                            // intLazQua
                                          '',                                                           // strTipEmb
                                          0.0,                                                          // fltQtdEmb
                                          0.0,                                                          // fltPreEmb
                                          0.0,                                                          // fltPrvTin
                                          0.0,                                                          // fltPrcTin
                                          0.0,                                                          // fltFatTin
                                          'N',                                                          // strProEmb
                                          '',                                                           // strIteEmb
                                          0.0,                                                          // fltUniEmb
                                          0.0,                                                          // fltEmbAnt
                                          cdsDadosParam.FieldByName('ITE_CODABF').AsString,                  // strCodAbf
                                          cdsDadosParam.FieldByName('ITE_PESOIT').AsFloat,                   // fltPesoIt
                                          cdsDadosParam.FieldByName('ITE_PESLIQ').AsFloat,                   // fltPesLiq
                                          'N',                                                          // strPromoc
                                          0.0,                                                          // fltProPreCus
                                          0.0,                                                          // fltProPreVen
                                          0.0,                                                          // fltProComVar
                                          0.0,                                                          // fltProDesF07
                                          '',                                                           // strTipTin
                                          objFatVenda.fRetPerComGrupo(cdsDadosParam.FieldByName('ITE_CODGRU').AsString), // fltGPeCom
                                          cdsDadosParam.FieldByName('ITE_CODFAB').AsString,                  // strCodFab
                                          -1,                                                           // intSeqInd
                                          0.0,                                                          // fltQtdBai
                                          '',                                                           // strNumOrc
                                          '',                                                           // strEspOrc
                                          '',                                                           // strEmpOrc
                                          cdsDadosParam.FieldByName('ITE_MARMIN').AsFloat,                   // fltMarMin
                                          cdsDadosParam.FieldByName('ITE_MARMSG').AsFloat,                   // fltMarMSG
                                          cdsDadosParam.FieldByName('ITE_MARMGE').AsFloat,                   // fltMarMGe
                                          fRetNomMarca(cdsDadosParam.FieldByName('ITE_CODMAR').AsString),    // strMarca
                                          '',                                                           // strStatus
                                          0.0,                                                          // fltComDev
                                          0.0,                                                          // fltDesDev
                                          '',                                                           // strSeqDet
                                          '',                                                           // strCatali
                                          '',                                                           // strLinTin
                                          0.0,                                                          // fltEmbala
                                          '',                                                           // strDesNes
                                          '',                                                           // strSemEst
                                          '',                                                           // strLibEst
                                          cdsDadosParam.FieldByName('ITE_PRECOM').AsFloat,                   // fltPreCom
                                          cdsDadosParam.FieldByName('Preço Venda').AsFloat,                  // fltUniDig
                                          cdsDadosParam.FieldByName('ITE_QTPPRO').AsFloat,                   // fltQtdPon
                                          '',                                                           // strComple
                                          '',                                                           // strDivDev
                                          cdsDadosParam.FieldByName('ITE_OBRCPF').AsString,                  // strObrCpf
                                          '',                                                           // strMontad
                                          '',                                                           // strA_n_o_
                                          cdsDadosParam.FieldByName('Unidade').AsString,                     // strSigUni
                                          0.0,                                                          // fltVolPro
                                          intCont+1,                                                    // intOrdite
                                          '',                                                           // strChaFor
                                          '',                                                           // strCodAca
                                          '',                                                           // strEmpAca
                                          False,                                                        // blnProAca
                                          '',                                                           // strEspFut
                                          '',                                                           // strDocFut
                                          '',                                                           // strEmpFut
                                          0.0,                                                          // fltOutVal
                                          0.0,                                                          // fltComTbl
                                          0.0,                                                          // fltDesOpe
                                          0.0,                                                          // fltICMSai
                                          0.0,                                                          // fltImpFed
                                          0.0,                                                          // fltDesMge
                                          '',                                                           // strDocCnf
                                          '',                                                           // strEspCnf
                                          '',                                                           // strEmpCnf
                                          strTabela,                                                    // strTabPre
                                          cdsDadosParam.FieldByName('ITE_IPIENT').AsFloat,                   // fltIpiEnt
                                          cdsDadosParam.FieldByName('ITE_FREENT').AsFloat,                   // fltFreEnt
                                          '',                                                           // strCodDil
                                          0.0,                                                          // fltPorDil
                                          '',                                                           // strDilCon
                                          0.0,                                                          // fltPorCat
                                          'R',                                                          // strEntRet
                                          '',                                                           // strLocRet
                                          'N',                                                          // strEntFut
                                          '',                                                           // strMotFut
                                          0,                                                            // dtaDtaEnt
                                          1.0,                                                          // fltQtdOri
                                          0.0,                                                          // fltDesEsp
                                          0.0,                                                          // fltDesBai
                                          '',                                                           // strImpDir
                                          '',                                                           // strLocFis
                                          0.0,                                                          // fltPreCu2
                                          0.0,                                                          // fltTotCu2
                                          0.0,                                                          // fltProComAta
                                          0.0,                                                          // fltProComDis
                                          0.0,                                                          // fltTotPed
                                          0.0,                                                          // fltPanUti
                                          0.0,                                                          // fltTotDes
                                          0.0,                                                          // ftlTotFre
                                          recForTin,                                                    // recForTin
                                          '',                                                           // strKey_EP
                                          '',                                                           // strLotAnt
                                          '',                                                           // strNumLot
                                          '',                                                           // strEmpPrd
                                          '',                                                           // strVenCnf
                                          False,                                                        // blnBxSbIt
                                          'N',                                                          // strPigBas
                                          'NOR',                                                        // strIdeDev
                                          0.0,                                                          // fltQtdDet
                                          '',                                                           // strTabDev
                                          cdsDadosParam.FieldByName('ITE_CODBAR').AsString,                  // strCodBar
                                          '',                                                           // strTipFin
                                          0.0,                                                          // fltDesFin
                                          0.0,                                                          // fltPreLot
                                          0.0,                                                          // fltCoDvRp
                                          '',                                                           // strEmpIte
                                          1.0,                                                          // fltFatAce
                                          True,                                                         // blnPodAlt
                                          '',                                                           // strEmpSol
                                          '',                                                           // strCndDev
                                          '',                                                           // strCCndDv
                                          0,                                                            // dtaEmiDev
                                          cdsDadosParam.FieldByName('ITE_PRECUS').AsFloat,                   // fltCusIte
                                          '',                                                           // strDesSim
                                          '',                                                           // strOrdPro
                                          recMadeira,                                                   // recMadeira
                                          cdsDadosParam.FieldByName('ITE_IMPULT').AsFloat,                   // fltTotImp
                                          0.0,                                                          // fltVal_RT
                                          0.0,                                                          // fltTaxJur
                                          '',                                                           // strSeqGad
                                          0.0,                                                          // fltQtdExp
                                          '',                                                           // strBarEmb
                                          '',                                                           // strNumCmp
                                          0,                                                            // intNItCmp
                                          0.0,                                                          // fltDeDVCf
                                          '',                                                           // strCodMec
                                          '',                                                           // strSeqRcd
                                          0,                                                            // intSeqInc
                                          '',                                                           // strCodVenIte
                                          'N',                                                          // strAltPCoIte
                                          0.0,                                                          // fltPerComIte
                                          0.0,                                                          // fltFreDev
                                          0.0,                                                          // fltDeADev
                                          False,                                                        // blnAlterandoPDORCarregado
                                          False,                                                        // blnInserindoPDORCarregado
                                          'N',                                                          // strCliBus
                                          '',                                                           // strTurEnt
                                          0,                                                            // intSeqCcr
                                          0.0,                                                          // fltDopTin
                                          '',                                                           // strCodVe2Ite
                                          'N',                                                          // strLibUni
                                          0.0,                                                          // fltValDif
                                          '',                                                           // strLotAba
                                          '',                                                           // strIncFut
                                          '',                                                           // strSepExp
                                          '',                                                           // strTabPreEmb
                                          '',                                                           // strExcIpi
                                          0.0,                                                          // fltDesMSu
                                          '',                                                           // strAiDvOr
                                          '');
end;

procedure TCatalogoPromocao.pInformarTituloRelatorio;
begin
  If FblnGeracaoGlobalOco Then
    FTituloRelatorio := 'Promocoes'
  Else
    FTituloRelatorio := fInputDialog('Título', 'Informe o título do relatório:');
  FfrxRelJato.Script.Variables['TITULO'] := FTituloRelatorio;
end;

procedure TCatalogoPromocao.pIniciaRelatorio(afrxRelJato: TfrxReport;
                                             afrxExpPDF : TfrxPDFExport;
                                             afrxRelatorio: TfrxDBDataset);
begin

  FfrxRelJato := afrxRelJato;
  FfrxExpPDF  := afrxExpPDF;
  FfrxRelatorio := afrxRelatorio;

  If (Not Assigned(FfrxRelJato)) or
     (Not Assigned(FfrxExpPDF))  or
     (Not Assigned(FfrxRelatorio)) Then
    Exit;

  FfrxRelJato.DotMatrixReport := False;
  FfrxRelJato.PrintOptions.PrintMode := pmScale;
  FfrxRelJato.PrintOptions.PrintOnSheet := 9; //A4

  FfrxRelJato.AddFunction('procedure pCarregarImagemProduto;');
  FfrxRelJato.AddFunction('function fRetornaPrecoRelatorio: String;');

  If FileExists(fCfgSis('PATLOG')) And (FfrxRelJato.FindObject('imgLogo') <> Nil) Then
    TfrxPictureView(FfrxRelJato.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('PATLOG'));

  pSetarVariaveisRelatorio;
end;

procedure TCatalogoPromocao.pSetarVariaveisRelatorio;
Begin
  FfrxRelJato.Script.Variables['OPE_NOMOPE'] := fRetNomeOperador(strLoginUsuarioLogado);
  FfrxRelJato.Script.Variables['OPE_EMAIL_'] := fCampoTabela('OPE_E_MAIL', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  FfrxRelJato.Script.Variables['EMP_HOMEPA'] := fCadEmp('HOMEPA');
  FfrxRelJato.Script.Variables['EMP_FONE01'] := fFormataFone(fCadEmp('FONE01'));
  FfrxRelJato.Script.Variables['EMP_ENDERE'] := fCadEmp('ENDERE') + ', '+fCadEmp('ENDNUM');
  FfrxRelJato.Script.Variables['EMP_NOMCID'] := fCadEmp('NOMCID') + ' - ' + fCadEmp('ESTADO');
  FfrxRelJato.Script.Variables['TITULO'] := FTituloRelatorio;
End;

procedure TCatalogoPromocao.pLimpar;
begin
  FintPraMedio := fRetPraMedio;
  FstrCodCnd := EmptyStr;
  FTabelaTemp := fRetornaNomeTabelaTemp;
  FblnUsaTabPrecoProm := False;
  FstrTabPrecoProm := EmptyStr;
  FstrTabPreco := EmptyStr;
  FdtaVigencia := 0;
  FblnFiltraDadosUltVndEmp := False;
  FblnFiltraDadosUltVnd := False;
  FNroDiasSemVenda := 0;
  FdtaSemVendaIni := 0;
  FdtaSemVendaFin := 0;
  FblnSomenteEmPromocao := False;
  FstrCodIte := EmptyStr;
  FstrLinGru := EmptyStr;
  FstrCodMar := EmptyStr;
  FstrCodDep := EmptyStr;
  FstrCodFor := EmptyStr;
  FstrDescri := EmptyStr;
  FblnComSaldo := True;
  FstrCodProm := EmptyStr;
  FblnRestaurandoPadrao := False;
  FintIndexTipSaldo := 2;
  FPathImagem := fRetornaPathImagem;
  FfltValorDesc := 0;
  FblnPrecoImposto := False;
  SetLength(FarrCodCliCons, 0);
  FNomDirArq := EmptyStr;

  If Not FCfgIncrem Then
  Begin
    pLimparDadosConsulta;
  End;

  FblnEmConsultaPorCliente := False;
  FblnFiltrarPromoPorCli := False;
end;

procedure TCatalogoPromocao.pLimparDadosConsulta;
begin
  If Assigned(FcdsDados) Then
    FcdsDados.EmptyDataSet;
  If Assigned(FcdsDadosAux) Then
    FcdsDadosAux.EmptyDataSet;
end;

procedure TCatalogoPromocao.pPreparaCamposRelatorio;
begin
  FcdsDadosRel.DisableControls;
  Try
    FcdsDadosRel.First;
    While Not FcdsDadosRel.Eof Do
    Begin
      FcdsDadosRel.Edit;
      FcdsDadosRel.FieldByName('Preço').AsString := fRetornaPrecoRelatorio;
      FcdsDadosRel.Post;

      FcdsDadosRel.Next;
    End;
  Finally
    FcdsDadosRel.EnableControls;
  End;
end;

procedure TCatalogoPromocao.pSetaParametros;
begin
  Try
    FqryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
    FqryItens.ParamByName('PATHIMG').AsString := FPathImagem;

    pSetaParam(FstrCodIte, FarrProduto,  FstrProduto, 'CODITE', FqryItens);
    pSetaParam(FstrCodMar, FarrMarca,    FstrMarca,   'CODMAR', FqryItens);
    pSetaParam(FstrLinGru, FarrGrupo,    FstrGrupo,   'CODGRU', FqryItens);
    pSetaParam(FstrCodProm, FarrPromocao, FstrPromocao,'CODPRO', FqryItens);
    pSetaParam(FstrCodDep, FarrDepartamento, FstrDepartamento,'CODDEP', FqryItens);
    pSetaParam(FstrCodFor, FarrFornec, FstrFornecedor,'CODFOR', FqryItens);

    If Not fEmptyStr(FstrDescri) Then
      FqryItens.ParamByName('DESITE').AsString := '%'+ AnsiUpperCase(FstrDescri) +'%';

    If FblnFiltraDadosUltVndEmp Then
    Begin
      FqryItens.ParamByName('CODCLI').AsString := strCodCli;
      pSetaParam(FstrCodEmp, FarrEmpVnd,  FstrEmpVnd, 'CODEMPVND', FqryItens);

      If (Assigned(FqryItens.FindParam('QTDSEMVND'))) Then
        FqryItens.ParamByName('QTDSEMVND').AsInteger := FNroDiasSemVenda;
      If (Assigned(FqryItens.FindParam('DTAINIVND'))) Then
        FqryItens.ParamByName('DTAINIVND').AsDateTime := FDtaSemVendaIni;
      If (Assigned(FqryItens.FindParam('DTAFINVND'))) Then
        FqryItens.ParamByName('DTAFINVND').AsDateTime := FDtaSemVendaFin;
    End;

    If FblnFiltraDadosUltVnd Then
    Begin
      If (Assigned(FqryItens.FindParam('QTDSEMVND'))) Then
        FqryItens.ParamByName('QTDSEMVND').AsInteger := FNroDiasSemVenda;
      If (Assigned(FqryItens.FindParam('DTAINIVND'))) Then
        FqryItens.ParamByName('DTAINIVND').AsDateTime := FDtaSemVendaIni;
      If (Assigned(FqryItens.FindParam('DTAFINVND'))) Then
        FqryItens.ParamByName('DTAFINVND').AsDateTime := FDtaSemVendaFin;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TCatalogoPromocao.pSetaParametros]');
  End;
end;

end.
