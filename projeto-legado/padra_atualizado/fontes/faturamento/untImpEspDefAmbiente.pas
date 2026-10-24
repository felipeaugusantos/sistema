unit untImpEspDefAmbiente;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, untZClient, System.StrUtils,
  Forms, Data.DB, frxDMPExport, Uni, Datasnap.DBClient, UniClientDataSet,
  frxExportPDF, frxBarcode, Printers, untSaldoLojas, untValorPorExtenso;

type
  TTipoEspDefAmbiente = (tedaComPreco, tedaSemPreco, tedaSemPrecoSimplificado, tedaSeparacao, tedaFaturamentoFuturo, tedaReferenciaMarca, tedaReferencia, tedaCodigoFabricaMarca, tedaCodigoFabrica, tedaReferenciaMarcaFF, tedaReferenciaFF, tedaCodigoFabricaMarcaFF, tedaCodigoFabricaFF,
                         tedaComPrecoComMarca, tedaSemPrecoSemMarca, tedaComPrecoSemMarca, tedaSemPrecoComMarca, tedaPedidoCortado);

  TfrmImpEspDefAmbiente = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxDefAmbiente: TfrxReport;
    frxCabecalho: TfrxDBDataset;
    frxRodape: TfrxDBDataset;
    frxItens: TfrxDBDataset;
    frxServicos: TfrxDBDataset;
    frxDefAmbiente_SemPreco: TfrxReport;
    frxExportaPDF: TfrxPDFExport;
    frxParcelas: TfrxDBDataset;
    frxDefAmbiente_SemPreco_Simplificado: TfrxReport;
    frxDefAmbienteSeparacao: TfrxReport;
    frxResumo: TfrxDBDataset;
    frxDefAmbiente_Referencia: TfrxReport;
    frxDefAmbiente_CodigoFabricaMarca: TfrxReport;
    frxDefAmbiente_CodigoFabrica: TfrxReport;
    frxDefAmbiente_ReferenciaMarca: TfrxReport;
    frxDefAmbiente_CodigoFabrica_FF: TfrxReport;
    frxDefAmbiente_CodigoFabricaMarca_FF: TfrxReport;
    frxDefAmbiente_Referencia_FF: TfrxReport;
    frxDefAmbiente_ReferenciaMarca_FF: TfrxReport;
    frxFaltas: TfrxDBDataset;
    frxItensCortados: TfrxDBDataset;
    frxPedidoCortado: TfrxReport;
    function frxDefAmbienteUserFunction(const MethodName: string; var Params: Variant): Variant;
    function frxDefAmbiente_SemPrecoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxDefAmbiente_SemPreco_SimplificadoUserFunction(
      const MethodName: string; var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objSalLoj: TSaldoLojas;
    FLegIPI: String;
    strCampoOrdemItens: String;
    FTotalDifal: Double;
    function fRetornaQuantidadeItemDoc(strNumDoc, strEspDoc, strCodEmp, strCodIte: string): Double;
    procedure pMontaDuplicatas;
    function fRetornaQtdeCasaDecimalQuantidade: Integer;
    function fRetornaQtdeCasaDecimalValorUnit: Integer;
    function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String;
    function fRemoveCaracteresEspeciais(strDescri: String): String;
    procedure pMontaListaClassificacao;
    function fAjustaOrdenacaoItens(strFields: string):boolean;
    function fAjustaOrdenacaoItensCortados(strFields: string):boolean;
    procedure pOtimizaImagensProduto(strNumdoc, strEspdoc, strCodemp, strCodCli: String);
    class function fUtilizaImagemOtimizada: Boolean;
    function fRetornaTotalDifal(cdsRelatorio : TZClient): Double;
  public
    { Public declarations }
    strNomCli,
    strEndCli,
    strBaiCli,
    strCidCli,
    strUF_Cli,
    strCpfCgc,
    strFonCli,
    strConCli,
    strFaxCli,
    strRg_Ie_,
    strCepCli,
    strEndEnt,
    strEndEnt_,
    strEndEnt2,
    strCelCli,
    strFonCli02 : String;
    blnDocSep : boolean;

    cdsCabecalho : TUniClientDataSet;
    cdsRodape    : TUniClientDataSet;
    cdsItens     : TUniClientDataSet;
    cdsServicos  : TUniClientDataSet;
    cdsParcelas  : TUniClientDataSet;
    cdsResumo    : TUniClientDataSet;
    cdsFaltas    : TUniClientDataSet;
    cdsItensCortados: TUniClientDataSet;

    procedure pCriaClients(Tipo: TTipoEspDefAmbiente);

    procedure pPreencheDadosCliente(cdsRelatorio : TZClient);
    procedure pPreencheCabecalho(cdsRelatorio : TZClient; var ACodigoBarrasDocumento : String);
    procedure pPreencheItens(cdsRelatorio : TZClient; blnImpDescSimp: Boolean);
    procedure pPreencheServicos(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
    procedure pPreencheRodape(cdsRelatorio : TZClient);
    procedure pPreencheParcelas(cdsRelatorio : TZClient; strNumDoc: string);
    procedure pPreencheResumo(cdsRelatorio : TZClient);
    procedure pPreencheFaltas(cdsRelatorio : TZClient);
    procedure pPreencheItensCortados(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String);

    class function fTemFR3(Tipo: TTipoEspDefAmbiente = tedaComPreco) : Boolean;
    class function fGetCaminhoFR3(Tipo: TTipoEspDefAmbiente = tedaComPreco): String;
    class procedure pImprime(strNumDoc,
                             strEspDoc,
                             strCodCli,
                             strCodEmp   : String;
                             intQtdImp   : Integer;
                             strSaida    : String;
                             blnVisPdf   : Boolean;
                             Var strPath : String;
                             Tipo: TTipoEspDefAmbiente = tedaComPreco;
                             blnReimpressao: Boolean = False;
                             blnDocSep : Boolean = False);
  end;

var
  frmImpEspDefAmbiente: TfrmImpEspDefAmbiente;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples, untFuncoesGenerica, untCfgRel, untFuncoes,
  untConstantes, untTFatReservaSaldo, untIFatReservaSaldo,
  untFuncoesImagem, untTypesSistema, System.DateUtils, untImagemBase64;

{$R *.dfm}

{ TfrmImpEsp }

class function TfrmImpEspDefAmbiente.fGetCaminhoFR3(Tipo: TTipoEspDefAmbiente = tedaComPreco): String;
var
  strPatEti: String;
begin
  strPatEti := fCfgSis('PATETI');

  //PARA MELHOR TESTE, DESCOMENTAR A LINHA A BAIXO
  //strPatEti := 'C:\JZ\FR3';

  case Tipo of
    tedaComPreco: Result := strPatEti + '\frxDefAmbiente.fr3';
    tedaSemPreco: Result := strPatEti + '\frxDefAmbiente_SemPreco.fr3';
    tedaSemPrecoSimplificado: Result := strPatEti + '\frxDefAmbiente_SemPreco_Simplificado.fr3';
    tedaSeparacao: Result := strPatEti + '\frxDefAmbiente_Separacao.fr3';
    tedaFaturamentoFuturo: Result := strPatEti + '\frxDefAmbiente_FF.fr3';
    tedaReferenciaMarca: Result := strPatEti + '\frxDefAmbiente_ReferenciaMarca.fr3';
    tedaReferencia: Result := strPatEti + '\frxDefAmbiente_Referencia.fr3';
    tedaCodigoFabricaMarca: Result := strPatEti + '\frxDefAmbiente_CodigoFabricaMarca.fr3';
    tedaCodigoFabrica: Result := strPatEti + '\frxDefAmbiente_CodigoFabrica.fr3';
    tedaReferenciaMarcaFF: Result := strPatEti + '\frxDefAmbiente_ReferenciaMarca_FF.fr3';
    tedaReferenciaFF: Result := strPatEti + '\frxDefAmbiente_Referencia_FF.fr3';
    tedaCodigoFabricaMarcaFF: Result := strPatEti + '\frxDefAmbiente_CodigoFabricaMarca_FF.fr3';
    tedaCodigoFabricaFF: Result := strPatEti + '\frxDefAmbiente_CodigoFabrica_FF.fr3';
    tedaComPrecoComMarca: Result := strPatEti + '\frxDefAmbiente_ComPrecoComMarca.fr3';
    tedaSemPrecoSemMarca: Result := strPatEti + '\frxDefAmbiente_SemPrecoSemMarca.fr3';
    tedaComPrecoSemMarca: Result := strPatEti + '\frxDefAmbiente_ComPrecoSemMarca.fr3';
    tedaSemPrecoComMarca: Result := strPatEti + '\frxDefAmbiente_SemPrecoComMarca.fr3';
    tedaPedidoCortado: Result := strPatEti + '\PedidosCortados.fr3';
  end;
end;

procedure TfrmImpEspDefAmbiente.FormCreate(Sender: TObject);
begin
  frxDefAmbiente.AddFunction('function fRetornaQtdeCasaDecimalQuantidade(): Integer');
  frxDefAmbiente.AddFunction('function fRetornaQtdeCasaDecimalValorUnit(): Integer');
  frxDefAmbiente.AddFunction('function DaysBetween(const ANow, AThen: TDateTime): Integer');
  frxDefAmbiente.AddFunction('function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String');
  frxDefAmbiente.AddFunction('function fRemoveCaracteresEspeciais(strDescri: String): String');
  frxDefAmbiente.AddFunction('function fPergunta(strMensagem: String): Boolean');
  frxDefAmbiente.AddFunction('function fAjustaOrdenacaoItens(strFields: string): Boolean');
  frxDefAmbiente.AddFunction('function fAjustaOrdenacaoItensCortados(strFields: string): Boolean');

  frxPedidoCortado.AddFunction('function fRetornaQtdeCasaDecimalQuantidade(): Integer');
  frxPedidoCortado.AddFunction('function fRetornaQtdeCasaDecimalValorUnit(): Integer');
  frxPedidoCortado.AddFunction('function DaysBetween(const ANow, AThen: TDateTime): Integer');
  frxPedidoCortado.AddFunction('function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String');
  frxPedidoCortado.AddFunction('function fRemoveCaracteresEspeciais(strDescri: String): String');
  frxPedidoCortado.AddFunction('function fPergunta(strMensagem: String): Boolean');
  frxPedidoCortado.AddFunction('function fAjustaOrdenacaoItens(strFields: string): Boolean');
  frxPedidoCortado.AddFunction('function fAjustaOrdenacaoItensCortados(strFields: string): Boolean');

  frxDefAmbiente_SemPreco.AddFunction('function fRetornaQtdeCasaDecimalQuantidade(): Integer');
  frxDefAmbiente_SemPreco.AddFunction('function fRetornaQtdeCasaDecimalValorUnit(): Integer');
  frxDefAmbiente_SemPreco.AddFunction('function DaysBetween(const ANow, AThen: TDateTime): Integer');
  frxDefAmbiente_SemPreco.AddFunction('function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String');
  frxDefAmbiente_SemPreco.AddFunction('function fRemoveCaracteresEspeciais(strDescri: String): String');
  frxDefAmbiente_SemPreco.AddFunction('function fPergunta(strMensagem: String): Boolean');
  frxDefAmbiente_SemPreco.AddFunction('function fAjustaOrdenacaoItens(strFields: string): Boolean');
  frxDefAmbiente_SemPreco.AddFunction('function fAjustaOrdenacaoItensCortados(strFields: string): Boolean');

  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fRetornaQtdeCasaDecimalQuantidade(): Integer');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fRetornaQtdeCasaDecimalValorUnit(): Integer');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function DaysBetween(const ANow, AThen: TDateTime): Integer');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fRemoveCaracteresEspeciais(strDescri: String): String');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fPergunta(strMensagem: String): Boolean');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fAjustaOrdenacaoItens(strFields: string): Boolean');
  frxDefAmbiente_SemPreco_Simplificado.AddFunction('function fAjustaOrdenacaoItensCortados(strFields: string): Boolean');

  frxDefAmbienteSeparacao.AddFunction('function fRetornaQtdeCasaDecimalQuantidade(): Integer');
  frxDefAmbienteSeparacao.AddFunction('function fRetornaQtdeCasaDecimalValorUnit(): Integer');
  frxDefAmbienteSeparacao.AddFunction('function DaysBetween(const ANow, AThen: TDateTime): Integer');
  frxDefAmbienteSeparacao.AddFunction('function fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String');
  frxDefAmbienteSeparacao.AddFunction('function fRemoveCaracteresEspeciais(strDescri: String): String');
  frxDefAmbienteSeparacao.AddFunction('function fPergunta(strMensagem: String): Boolean');
  frxDefAmbienteSeparacao.AddFunction('function fAjustaOrdenacaoItens(strFields: string): Boolean');
  frxDefAmbienteSeparacao.AddFunction('function fAjustaOrdenacaoItensCortados(strFields: string): Boolean');

  blnDocSep := False;

end;

function TfrmImpEspDefAmbiente.fRetornaQtdeCasaDecimalQuantidade: Integer;
begin
  result := fCfgSis('DECQTD', varInteger);
end;

function TfrmImpEspDefAmbiente.fRetornaQtdeCasaDecimalValorUnit: Integer;
begin
  result := fCfgSis('DECUNI', varInteger);
end;

Function TfrmImpEspDefAmbiente.fRetornaDuplicatas(strNumdoc, strEspdoc, strCodemp, strCodcli: String): String;
  Var
    strSQL: String;
    qryDups: TUniQuery;
Begin
  Result := '';

  Try
    qryDups := fCriaQuery;
    qryDups.SQL.Clear;
    Try
      qryDups.Close;

      qryDups.SQL.Text := 'SELECT fAmbienteImpressaoRetornaDuplicatas(:NUMDOC, :ESPDOC, :CODEMP, :CODCLI) AS RESUMO';

      qryDups.ParamByName('NUMDOC').AsString := strNumdoc;
      qryDups.ParamByName('ESPDOC').AsString := strEspdoc;
      qryDups.ParamByName('CODEMP').AsString := strCodemp;
      qryDups.ParamByName('CODCLI').AsString := strCodcli;

      qryDups.Open;
      qryDups.First;
      Result := qryDups.FieldByName('RESUMO').AsString;

    Except
      qryDups.Close;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '    GROUP_CONCAT( ';
      strSQL := strSQL + '        CONCAT(RIGHT(CTR_NUMDUP, 6), " ", LEFT(CND_DESCRI, 8), " ", LPAD(FORMAT(CTR_VALDUP, 2, "de_DE"), 9, " "), " ", DATE_FORMAT(CTR_DTAVEN, "%d/%m/%Y"))  ';
      strSQL := strSQL + '		    SEPARATOR "\n" ';
      strSQL := strSQL + '    ) AS RESUMO ';
      strSQL := strSQL + 'FROM CADREC ';
      strSQL := strSQL + 'LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = CADREC.CTR_NUMDUP ';
      strSQL := strSQL + '    AND MOVGER.GER_ESPDOC = CADREC.CTR_ESPDOC ';
      strSQL := strSQL + '    AND MOVGER.GER_CODEMP = CADREC.CTR_CODEMP ';
      strSQL := strSQL + '    AND MOVGER.GER_CODCLI = CADREC.CTR_CODCLI ';
      strSQL := strSQL + 'LEFT JOIN CADCND ON CADCND.CND_CODIGO = MOVGER.GER_CODCND ';
      strSQL := strSQL + 'WHERE TRUE ';
      strSQL := strSQL + '    AND CTR_NUMDUP = :NUMDOC ';
      strSQL := strSQL + '	  AND CTR_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '    AND CTR_CODEMP = :CODEMP ';
      strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';
      strSQL := strSQL + '    ORDER BY CTR_DTAVEN LIMIT 7 ';

      qryDups.SQL.Text := strSQL;

      qryDups.ParamByName('NUMDOC').AsString := strNumdoc;
      qryDups.ParamByName('ESPDOC').AsString := strEspdoc;
      qryDups.ParamByName('CODEMP').AsString := strCodemp;
      qryDups.ParamByName('CODCLI').AsString := strCodcli;

      qryDups.Open;
      qryDups.First;
      Result := qryDups.FieldByName('RESUMO').AsString;
    end;

  Finally
    FreeAndNil(qryDups);
  End;

End;

function TfrmImpEspDefAmbiente.fRemoveCaracteresEspeciais(strDescri: String): String;
Begin
  Result := fTiraCaracEspeciais(strDescri, False);
End;

function TfrmImpEspDefAmbiente.fRetornaQuantidadeItemDoc(strNumDoc, strEspDoc,
  strCodEmp, strCodIte: string): Double;
var
  qryQtd: TUniQuery;
  strPrefixo, strTabela: string;
begin
  Result := 0;
  qryQtd := fCriaQuery;

  try
    qryQtd.Close;
    qryQtd.SQL.Clear;

    if Pos(strEspDoc, 'NF_FF_IF_') > 0 then
    begin
      qryQtd.SQL.Add('SELECT DET_QTDITE AS QTDITE');
      strPrefixo := 'DET_';
      strTabela := 'MOVDET';
    end
    else
    begin
      qryQtd.SQL.Add('SELECT (FDO_QTDITE - FDO_QTDBAI) AS QTDITE ');
      strPrefixo := 'FDO_';
      strTabela := 'FATDOR';
    end;

    qryQtd.SQL.Add('FROM '+strTabela+'');
    qryQtd.SQL.Add('WHERE '+strPrefixo+'NUMDOC = :NUMDOC');
    qryQtd.SQL.Add('AND '+strPrefixo+'ESPDOC = :ESPDOC');
    qryQtd.SQL.Add('AND '+strPrefixo+'CODEMP = :CODEMP');
    qryQtd.SQL.Add('AND '+strPrefixo+'CODITE = :CODITE');

    qryQtd.ParamByName('NUMDOC').AsString := strNumDoc;
    qryQtd.ParamByName('ESPDOC').AsString := strEspDoc;
    qryQtd.ParamByName('CODEMP').AsString := strCodEmp;
    qryQtd.ParamByName('CODITE').AsString := strCodIte;

    qryQtd.Open;

    if not qryQtd.IsEmpty then
    begin
      Result := qryQtd.FieldByName('QTDITE').AsFloat;
    end;
  finally
    FreeAndNil(qryQtd);
  end;
end;

function TfrmImpEspDefAmbiente.fRetornaTotalDifal(
  cdsRelatorio: TZClient): Double;
begin
  Result := 0;

  if not Assigned(cdsRelatorio) then
    Exit;

  if not cdsRelatorio.Active then
    Exit;

  if cdsRelatorio.RecordCount <= 0 then
    Exit;

  cdsRelatorio.First;

  try
    while not cdsRelatorio.Eof do
    begin
      Result := Result + cdsRelatorio.FieldByName('VDPORI').AsFloat;

      cdsRelatorio.Next;
    end;
  finally
    cdsRelatorio.First;
  end;
end;

function TfrmImpEspDefAmbiente.fAjustaOrdenacaoItens(strFields: string):boolean;
begin
  Result := True;

  if not Assigned(frxItens) then
    exit(false);

  if not Assigned(cdsItens) then
    exit(false);

  try
    cdsItens.IndexFieldNames := strFields;
  except
    exit(false);
  end;

end;

function TfrmImpEspDefAmbiente.fAjustaOrdenacaoItensCortados(strFields: string):boolean;
begin
  Result := True;

  if not Assigned(frxItensCortados) then
    exit(false);

  if not Assigned(cdsItensCortados) then
    exit(false);

  try
    cdsItensCortados.IndexFieldNames := strFields;
  except
    exit(false);
  end;

end;

function TfrmImpEspDefAmbiente.frxDefAmbienteUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACEP' Then
    Result := fFormataCEP(Params[0])
  Else If MethodName = 'FFORMATAFONE' Then
    Result := fFormataFone(Params[0])
  Else If MethodName = 'FFORMATACPFCGC' Then
    Result := fFormataCpfCgc(Params[0], opcBrasil, '')
  Else If MethodName = 'FRETORNAQTDECASADECIMALQUANTIDADE' Then
    Result := fRetornaQtdeCasaDecimalQuantidade()
  Else If MethodName = 'FRETORNAQTDECASADECIMALVALORUNIT' Then
    Result := fRetornaQtdeCasaDecimalValorUnit()
  Else If MethodName = 'DAYSBETWEEN' Then
    Result := DaysBetween(Params[0], Params[1])
  Else if MethodName = 'FRETORNADUPLICATAS' then
    Result := fRetornaDuplicatas(Params[0], Params[1], Params[2], Params[3])
  Else if MethodName = 'FREMOVECARACTERESESPECIAIS' then
    Result := fRemoveCaracteresEspeciais(Params[0])
  Else If MethodName = 'FPERGUNTA' then
    Result := fPergunta(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENS' then
    Result := fAjustaOrdenacaoItens(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENSCORTADOS' then
    Result := fAjustaOrdenacaoItensCortados(Params[0]);

end;

function TfrmImpEspDefAmbiente.frxDefAmbiente_SemPrecoUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACEP' Then
    Result := fFormataCEP(Params[0])
  Else If MethodName = 'FFORMATAFONE' Then
    Result := fFormataFone(Params[0])
  Else If MethodName = 'FFORMATACPFCGC' Then
    Result := fFormataCpfCgc(Params[0], opcBrasil, '')
  Else If MethodName = 'FRETORNAQTDECASADECIMALQUANTIDADE' Then
    Result := fRetornaQtdeCasaDecimalQuantidade()
  Else If MethodName = 'FRETORNAQTDECASADECIMALVALORUNIT' Then
    Result := fRetornaQtdeCasaDecimalValorUnit()
  Else If MethodName = 'DAYSBETWEEN' Then
    Result := DaysBetween(Params[0], Params[1])
  Else if MethodName = 'FRETORNADUPLICATAS' then
    Result := fRetornaDuplicatas(Params[0], Params[1], Params[2], Params[3])
  Else if MethodName = 'FREMOVECARACTERESESPECIAIS' then
    Result := fRemoveCaracteresEspeciais(Params[0])
  Else If MethodName = 'FPERGUNTA' then
    Result := fPergunta(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENS' then
    Result := fAjustaOrdenacaoItens(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENSCORTADOS' then
    Result := fAjustaOrdenacaoItensCortados(Params[0]);
end;

function TfrmImpEspDefAmbiente.frxDefAmbiente_SemPreco_SimplificadoUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACEP' Then
    Result := fFormataCEP(Params[0])
  Else If MethodName = 'FFORMATAFONE' Then
    Result := fFormataFone(Params[0])
  Else If MethodName = 'FFORMATACPFCGC' Then
    Result := fFormataCpfCgc(Params[0], opcBrasil, '')
  Else If MethodName = 'FRETORNAQTDECASADECIMALQUANTIDADE' Then
    Result := fRetornaQtdeCasaDecimalQuantidade()
  Else If MethodName = 'FRETORNAQTDECASADECIMALVALORUNIT' Then
    Result := fRetornaQtdeCasaDecimalValorUnit()
  Else If MethodName = 'DAYSBETWEEN' Then
    Result := DaysBetween(Params[0], Params[1])
  Else if MethodName = 'FRETORNADUPLICATAS' then
    Result := fRetornaDuplicatas(Params[0], Params[1], Params[2], Params[3])
  Else if MethodName = 'FREMOVECARACTERESESPECIAIS' then
    Result := fRemoveCaracteresEspeciais(Params[0])
  Else If MethodName = 'FPERGUNTA' then
    Result := fPergunta(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENS' then
    Result := fAjustaOrdenacaoItens(Params[0])
  Else If MethodName = 'FAJUSTAORDENACAOITENSCORTADOS' then
    Result := fAjustaOrdenacaoItensCortados(Params[0]);
end;

class function TfrmImpEspDefAmbiente.fTemFR3(Tipo: TTipoEspDefAmbiente = tedaComPreco): Boolean;
var
  strPathEti: String;
begin
  Result := False;
  If fCfgSis('UTIDEF', varBoolean)  Then
  Begin
    strPathEti := fCfgSis('PATETI', varString);

    If Not fEmptyStr(strPathEti) Then
      Result := FileExists(fGetCaminhoFR3(Tipo));
  End;

end;

procedure TfrmImpEspDefAmbiente.pCriaClients(Tipo: TTipoEspDefAmbiente);
begin

  inherited;

  if not Assigned(cdsCabecalho) then
    cdsCabecalho := TUniClientDataSet.Create(Self);

  if not Assigned(cdsRodape) then
    cdsRodape := TUniClientDataSet.Create(Self);

  if not Assigned(cdsItens) then
    cdsItens := TUniClientDataSet.Create(Self);

  if not Assigned(cdsServicos) then
    cdsServicos := TUniClientDataSet.Create(Self);

  if not Assigned(cdsParcelas) then
    cdsParcelas := TUniClientDataSet.Create(Self);

  if not Assigned(cdsResumo) then
    cdsResumo := TUniClientDataSet.Create(Self);

  if not Assigned(cdsFaltas) then
    cdsFaltas := TUniClientDataSet.Create(Self);

  if not Assigned(cdsItensCortados) then
    cdsItensCortados := TUniClientDataSet.Create(Self);

  With cdsCabecalho Do
  Begin
    {***************************}
    {* DADOS CABECALHO EMPRESA *}
    {************************FC*}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMDOC';
      DataType := ftString;
      Size     := 06;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMDCC';
      DataType := ftString;
      Size     := 12;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ESPDOC';
      DataType := ftString;
      Size     := 06;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODPRF';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMPRF';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMCMP';
      DataType := ftMemo;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMEMP';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONEMP';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMPFAX';
      DataType := ftString;
      Size     := 15;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONE_E_FAX';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDEMP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEPEMP';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CIDEMP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CONEMP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMAIL_';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CGCEMP';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'IE_EMP';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMPRO';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENEXP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENEX2';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENEX3';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENEX4';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EXPSEP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'STASEP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONFAXEXP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDEXP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEPEXP';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CIDEXP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CGCEXP';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'IE_EXP';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODEMP';
      DataType := ftString;
      Size     := 03;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONEM2';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'HOMEPA';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEP_CL';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MAI_CL';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEL_CL';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CONPA2';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    {***************************}
    {* DADOS CABEÇALHO CLIENTE *}
    {************************FC*}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTADOC';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'HORDOC';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODCLI';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMCLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FANSOB';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMCID';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CONCLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CPFCGC';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'RG_IE_';
      DataType := ftString;
      Size     := 12;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDCLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'BAICLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CIDCLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UF_CLI';
      DataType := ftString;
      Size     := 2;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEPCLI';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONCLI';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CLIF02';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FAXCLI';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CPFCLI';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CNPCLI';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEPCLI_';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMACLI';
      DataType := ftString;
      Size     := 255;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'IESCLI';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDCOM';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTAFAT';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDFAT';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDCOB';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CONPAG';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'REFENT_';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMAIL3';
      DataType := ftString;
      Size     := 255;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMCOB1';
      DataType := ftString;
      Size     := 255;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMAVED';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODVEN';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMVEN';
      DataType := ftString;
      Size     := 30;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ETCENT';
      DataType := ftString;
      Size     := 150;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ETCBAI';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NCIDEN';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'JAFATU';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FO1VEN';
      DataType := ftString;
      Size     := 15;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONEM1';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CELCLI';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CELCON';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UF_EMP';
      DataType := ftString;
      Size     := 2;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'OR_ORIGEM';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsRodape Do
  Begin
    {**************************}
    {* DADOS RODAPÉ DOCUMENTO *}
    {***********************FC*}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTAVAL';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VLORCA';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTENTR';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESFPG';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESCPG';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTAPRE';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDENT';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    {Endereço completo!}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDENT_';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDENT2';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMPRO';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMDIG';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;


    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MEN001';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MEN002';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MEN003';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MEN004';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTFRE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESBRT';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESLIQ';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VOLUME';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENDOC';
      DataType := ftString;
      Size     := 800;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTAIMP';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'HORIMP';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TELENT';
      DataType := ftString;
      Size     := 15;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CONENT';
      DataType := ftString;
      Size     := 25;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESESG';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DUPLIC';
      DataType := ftString;
      Size     := 1000;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENTFUT';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTRET';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTSER';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESFRE';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODTRA';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NOMTRA';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENDTRA';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'BAITRA';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CEPTRA';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CIDTRA';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UF_TRA';
      DataType := ftString;
      Size     := 2;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONTRA';
      DataType := ftString;
      Size     := 14;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMCTT';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CELCTT';
      DataType := ftString;
      Size     := 15;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMACTT';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'PORDES';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VLRCON';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTFCP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESACE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODCND';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODFPG';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'LEGIPI';
      DataType := ftString;
      Size     := 600;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTIPI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'BASICM';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTICM';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'BASRET';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'REGIAO';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTPRO';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'IMGASS';
      DataType := ftBlob;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMASS';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

     With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TPADES';
      DataType := ftString;
      Size     := 256;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ORIORC';
      DataType := ftString;
      Size     := 256;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DTAORC';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VALEXT';
      DataType := ftString;
      Size     := 256;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PRIVEN';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TDPORI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DUPALF';
      DataType := ftString;
      Size     := 1000;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DTCTAT';
      DataType := ftDateTime;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLCTAT';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DTCTVN';
      DataType := ftDateTime;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLCTVN';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsItens Do
  Begin

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DTEITE';
      DataType := ftDateTime;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DRELIN';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMITE';
      DataType := ftInteger;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CLIBUS';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENTRET';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ETRETI';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'COMPLE';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'AUTOINCREM';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESITE';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESSIM';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMLOT';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'MARDES';
      DataType := ftString;
      Size     := 30;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESMAR';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DEMARC';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'MARCA_';
      DataType := ftString;
      Size     := 30;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'UNIDAD';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'PROMOC';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENTITE';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDRES';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESESP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'UNIORI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'UNIDIG';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'PRCUNI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOT_PRCUNI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTORI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTUNI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DSCITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESCON';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTRES';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESBRI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESGRU';
      DataType := ftString;
      Size     := 70;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'REFERE';
      DataType := ftString;
      Size     := 16;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ESTOQU';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTFRE';
      DataType := ftFloat;
      Required := False;
    End;


    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'LOCFIS';
      DataType := ftString;
      Size     := 70;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'LOCSEP';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODAMZ';
      DataType := ftString;
      Size     := 16;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODFAB';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMPED';
      DataType := ftString;
      Size     := 12;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'MLTVEN';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODBAR';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTIPI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENTRFU';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMPITE';
      DataType := ftString;
      Size     := 03;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODEMP';
      DataType := ftString;
      Size     := 03;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALBRU';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTDES';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESTOT';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTADE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLRBRU';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CLAIPI';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'SIGDES';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'LEGEND';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ALQICM';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODFIS';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ITEBRU';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ITELIQ';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODREP';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NOMREP';
      DataType := ftString;
      Size     := 30;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMCMP';
      DataType := ftString;
      Size     := 15;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'COMORD';
      DataType := ftInteger;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESNES';
      DataType := ftString;
      Size     := 500;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESACE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODNCM';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALPRO';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'OPCSIM';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ITEDES';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ITEREQ';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALRET';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ITEIMG';
      DataType := ftBlob;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENTFUT';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CORTPR';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TITNAC';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TITIMP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESNAC';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESIMP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'RETNAC';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'RETIMP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALFCP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTIMP';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CLAFIS';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'BASICM';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VALICM';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ALQIPI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VALIPI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VDPORI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VDPDES';
      DataType := ftFloat;
      Required := False;
    End;

    strCampoOrdemItens := '';

    case fCfgSis('ITEDEF', varInteger) of
      1: strCampoOrdemItens := 'CODITE';
      2: strCampoOrdemItens := 'DESITE';
      3: strCampoOrdemItens := 'AUTOINCREM';
    else
      strCampoOrdemItens := 'CODITE';
    end;

    case fCfgSis('AMBDEF', varInteger) of
      1: strCampoOrdemItens := 'COMPLE;'+strCampoOrdemItens;
      2: strCampoOrdemItens := 'COMORD;'+strCampoOrdemItens;
      3: strCampoOrdemItens := 'LOCSEP;'+strCampoOrdemItens;
      4: strCampoOrdemItens := 'LOCFIS;'+strCampoOrdemItens;
    else
      strCampoOrdemItens := 'COMPLE;'+strCampoOrdemItens;
    end;

    if (Tipo = tedaPedidoCortado) then
       strCampoOrdemItens := 'NUMPED;CODITE';

    IndexFieldNames := strCampoOrdemItens;

    CreateDataSet;
    Open;
  End;

  With cdsServicos Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODSER';
      DataType := ftString;
      Size     := 05;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESSER';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDSER';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALUNI';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALSER';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsItensCortados Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODITE';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESITE';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'REFERE';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMDOC';
      DataType := ftString;
      Size     := 12;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UNITAR';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTITE';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsParcelas Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'PARCEL';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DTAPAR';
      DataType := ftString;
      Size     := 19;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALPAR';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODFPG';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLRPRC';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsResumo Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'AMBIEN';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDAMB';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'UNIAMB';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTAMB';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;

  With cdsFaltas Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESITE';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'MARCA_';
      DataType := ftString;
      Size     := 30;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODFAB';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'UNIDAD';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESMAR';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'CLIBUS';
      DataType := ftString;
      Size     := 1;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENTRET';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'NUMLOT';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESCON';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VALPRO';
      DataType := ftFloat;
      Required := False;
    End;

    CreateDataSet;
    Open;
  End;
end;

class procedure TfrmImpEspDefAmbiente.pImprime(strNumDoc,
                                               strEspDoc,
                                               strCodCli,
                                               strCodEmp   : String;
                                               intQtdImp   : Integer;
                                               strSaida    : String;
                                               blnVisPdf   : Boolean;
                                               Var strPath : String;
                                               Tipo: TTipoEspDefAmbiente = tedaComPreco;
                                               blnReimpressao: Boolean = False;
                                               blnDocSep : Boolean = False);
var
  frmImpEspDefAmbiente : TfrmImpEspDefAmbiente;
  cdsRelatorio    : TZClient;
  intPosicao      : Integer;
  qryCfgRel       : TUniQuery;
  strNomFil,
  strTipImp,
  strTitulo       : String;
  frxDefAmbiente_ : TfrxReport;
  strNomArq       : String;
  LstrCodigoBarrasDocumento : String;
  strPrefixoFila  : String;

  function fGetSql(strEspDoc: String): String;
  begin

    Result    := '';

    Result := Result + ' SET @ROW := 0; ';
    Result := Result + ' SELECT ';
    Result := Result + '  (@ROW := @ROW + 1) AS NUMITE, ';
    Result := Result + '  FGO_CODEMP AS CODEMP, ';
    Result := Result + '  FDO_EMPITE AS EMPITE, ';
    Result := Result + '  FDO_CODVEN AS CODVEN, ';
    Result := Result + '  FDO_CODVE2 AS CODVE2, ';
    Result := Result + '  CONCAT(''SEPARAÇÃO DE '', IF ( FGO_ENTFAT = ''S'' , ''ENTREGA'' , ''RETIRA'' ),'''' '''', IF ( FGO_ENTFUT = ''S'' , ''FUTURA'' , '''') ) AS EXPSEP, ';
    Result := Result + '  CONCAT(IF(FDO_MOTFUT = ''A'' , ''AGUARDANDO CLIENTE'' , '''' ), IF (FDO_MOTFUT = ''F'' , ''FALTA DE MERCADORIA'' , '''' ), IF (FDO_MOTFUT = ''P'' , ''PREVISAO DE ENTREGA'' , '''' )) STASEP, ';
    Result := Result + fSQLBarDoc('FDO') + ' AS BARDOC, ';
    Result := Result + '  FDO_CODDIG AS CODDIG, ';
    Result := Result + '  COALESCE(O1.OPE_NOMOPE, "") AS NOMVEN, ';
    Result := Result + '  COALESCE(O2.OPE_NOMOPE, "") AS NOMVE2, ';
    Result := Result + '  FATDOR.FDO_CODDIV AS CODPRF, ';
    Result := Result + '  COALESCE(CADDIV.DIV_NOMDIV, "") AS NOMPRF, ';
    Result := Result + '  (SELECT GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR " / ") FROM NUMCMP WHERE CMP_SEQGER = FATGOR.AUTOINCREM AND IFNULL(CMP_NUMCMP, "") <> "") AS CMPNUM,';
    Result := Result + '  FDO_CODCLI AS CODCLI, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_NOMCON,CLI_NOMCLI) AS NOMCLI, ';
    Result := Result + '  CLI_FANSOB       AS FANSOB, ';
    Result := Result + '  CLI_ORGPUB       AS ORGPUB, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_ENDCON,CLI_ENDERE) AS ENDERE, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_BAICON,CLI_BAIRRO) AS BAIRRO, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CIDCON,CLI_CODCID) AS CODCID, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",COALESCE(Z.CID_NOMCID, ""),COALESCE(C.CID_NOMCID, "")) AS NOMCID, ';
    Result := Result + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CGCCPF,CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CGCCON,CLI_C_G_C_) AS C_G_C_, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CEPCON,CLI_C_E_P_) AS C_E_P_, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",COALESCE(Z.CID_ESTADO, ""),COALESCE(C.CID_ESTADO, "")) AS ESTADO, ';
    Result := Result + '  IF(CLI_CGCCPF = 1, IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_IESCON,CLI_I_E_S_), ';
    Result := Result + '                     IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_R_GCON,CADCLI.CLI_NUMR_G)) AS NUMR_G, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_TELCON,CLI_FONE01) AS FONE01, ';
    Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_EMLCON,CLI_EMAIL_) AS EMACON, ';

    if Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CELCON,CLI_CELULA) AS CELCON, '
    else
      Result := Result + '  CAST("" AS CHAR(1)) AS CELCON,  ';


    Result := Result + '  FDO_CODCND AS CODCND, ';
    Result := Result + '  CND_DESCRI       AS DESCND, ';
    Result := Result + '  IF(COALESCE(ETC_ENDENT, "") <> "", CONCAT(COALESCE(ETC_ENDENT, ""), " - ", COALESCE(ETC_BAIENT, ""), " - ", COALESCE(E.CID_NOMCID, "")), "") AS ENDENT, ';
    Result := Result + '  IF(COALESCE(ETC_ENDENT, "") <> "", CONCAT(COALESCE(ETC_ENDENT, ""), " - ", COALESCE(ETC_BAIENT, "")), "") AS ENDENT_, ';
    Result := Result + '  FDO_DTAENT AS DTAENT, ';
    Result := Result + '  FDO_HORENT AS HORENT, ';
    Result := Result + '  IF(LEFT(FDO_CLAFIS, 1) >= 5, "S", "E") AS ENTSAI, ';
    Result := Result + '  FDO_NUMDOC AS NUMDOC, ';
    Result := Result + '  FDO_ESPDOC AS ESPDOC, ';
    Result := Result + '  CONCAT(FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP, FDO_CODCLI) AS DOCQUEBRA, ';
    Result := Result + '  FDO_QTDITE AS QTDITE, ';
    Result := Result + '  UN.UNI_SIGUNI AS UNIDAD, ';
    Result := Result + '  FDO_DESCRI AS DESITE, ';
    Result := Result + '  ITE_DESSIM AS DESSIM, ';
    Result := Result + '  FDO_CLAFIS AS CLAFIS, ';
    Result := Result + '  IF((LEFT(FDO_CLAFIS, 1) < 5) AND (FDO_ESPDOC = "TR"), -1, 1) * FDO_UNITAR AS UNITAR, ';
    Result := Result + '  IF((LEFT(FDO_CLAFIS, 1) < 5) AND (FDO_ESPDOC = "TR"), -1, 1) * FDO_TOTITE AS TOTITE, ';
    Result := Result + '  FDO_DESESP AS DESESP,  ';
    Result := Result + '  FGO_PESBRU AS PESBRT,  ';
    Result := Result + '  FGO_PESLIQ AS PESLIQ,  ';
    Result := Result + '  FGO_VOLUME AS VOLUME,  ';
    Result := Result + '  FGO_MEN001 AS MEN001,  ';
    Result := Result + '  FGO_MEN002 AS MEN002,  ';

    If Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
    Begin
      Result := Result + '  AUX_MEN003 AS MEN003,  ';
      Result := Result + '  AUX_MEN004 AS MEN004,  ';
    End
    Else
    Begin
      Result := Result + '  CAST("" AS CHAR(1)) AS MEN003,  ';
      Result := Result + '  CAST("" AS CHAR(1)) AS MEN004,  ';
    End;

    Result := Result + '  FDO_CODFPG AS CODFPG,  ';
    Result := Result + '  FDO_HORENT AS HORENT,  ';
    Result := Result + '  FGO_MEN001 AS MEN001,  ';
    Result := Result + '  FGO_MEN002 AS MEN002,  ';
    Result := Result + '  FGO_TOTFRE AS TOTFRE,  ';
    Result := Result + '  CLI_CIDENT AS CIDENT,  ';
    Result := Result + '  CLI_CONTAT AS CONTAT,  ';
    Result := Result + '  CLI_FONE02 AS CLIF02,  ';

    Result := Result + '  CLI_F_A_X_ AS F_A_X_,  ';
    Result := Result + '  CLI_C_E_P_ AS CEPCLI,  ';
    Result := Result + '  CLI_EMAIL_ AS EMACLI,  ';
    Result := Result + '  CLI_ENDCOM AS ENDCOM,  ';

    Result := Result + '  CLI_I_E_S_ AS I_E_S_,  ';
    Result := Result + '  FGO_CGCCON AS CGCCON,  ';
    Result := Result + '  FGO_CIDCON AS CIDCON,  ';
    Result := Result + '  FGO_IESCON AS IESCON,  ';
    Result := Result + '  FGO_R_GCON AS R_GCON,  ';
    Result := Result + '  FGO_TELCON AS TELCON,  ';
    Result := Result + '  FGO_CEPCON AS CEPCON,  ';
    Result := Result + '  FGO_ENDCON AS ENDCON,  ';
    Result := Result + '  FGO_BAICON AS BAICON,  ';
    Result := Result + '  FGO_CIDCON AS CIDCON,  ';
    Result := Result + '  FGO_DTENTR AS DTENTR,  ';
    Result := Result + '  FDO_ENTFUT AS ENTFUT,  ';
    Result := Result + '  FDO_MOTFUT AS MOTFUT,  ';
    Result := Result + '  FDO_CODITE AS CODITE,  ';
    Result := Result + '  FATDOR.AUTOINCREM AS ITE_AUTOINC, ';
    Result := Result + '  FDO_NUMLOT AS NUMLOT,  ';
    Result := Result + '  FDO_UNIDAD AS UNIDAD,  ';
    Result := Result + '  FDO_DESESP AS DESESP,  ';
    Result := Result + '  CLI_CEPENT AS CEPENT,  ';
    Result := Result + '  CLI_BAIENT AS BAIENT,  ';
    Result := Result + '  E.CID_NOMCID AS NCIDEN,';
    Result := Result + '  E.CID_ESTADO AS NESTEN,';
    Result := Result + '  FDO_COMPLE AS COMPLE,  ';

    If Pos(strEspDoc, 'NF_FF_IF_') > 0 Then
    Begin
      Result := Result + '  0 AS VALFCP,  ';
    End
    Else
    Begin
      Result := Result + '  FDO_VALFCP AS VALFCP,  ';
    End;

    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FDO_ENTRET', '" "')+' AS ENTRET, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FDO_CLIBUS', '" "')+' AS CLIBUS, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FGO_VALORC', '"0"')+' AS VALORC, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FGO_PREVIS', '"0"')+' AS PREVIS, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FDO_NUMDOC', 'DET_NUM_PD')+' AS NUMPED, ';


    Result := Result + '  MAR_DESMAR AS DESMAR,  ';
    Result := Result + '  FDO_UNITAR AS VALUNI,  ';
    Result := Result + '  FDO_DESCON AS DESCON,  ';
    Result := Result + '  FDO_UNIORI AS UNIORI,  ';
    Result := Result + '  FDO_UNIDIG AS UNIDIG,  ';
    Result := Result + '  FDO_PROMOC AS PROMOC,  ';
    Result := Result + '  FDO_DTENTR AS ENTITE,  ';
    Result := Result + '  FDO_DTENTR AS DTEITE,  ';
    Result := Result + '  ROUND(FDO_TOTITE, 2) AS VALITE, ';
    Result := Result + '  FGO_CONPAG AS CONPAG,  ';
    Result := Result + '  FGO_VLRCON AS VLRCON,  ';
    Result := Result + '  FGO_CODFPG AS CODFPG,  ';
    Result := Result + '  FGO_VPAR01 AS VPAR01,  ';
    Result := Result + '  FGO_VPAR02 AS VPAR02,  ';
    Result := Result + '  FGO_VPAR03 AS VPAR03,  ';
    Result := Result + '  FGO_VPAR04 AS VPAR04,  ';
    Result := Result + '  FGO_VPAR05 AS VPAR05,  ';
    Result := Result + '  FGO_VPAR06 AS VPAR06,  ';
    Result := Result + '  FGO_VPAR07 AS VPAR07,  ';
    Result := Result + '  FGO_VPAR08 AS VPAR08,  ';
    Result := Result + '  FGO_VPAR09 AS VPAR09,  ';
    Result := Result + '  FGO_VPAR10 AS VPAR10,  ';
    Result := Result + '  FGO_VPAR11 AS VPAR11,  ';
    Result := Result + '  FGO_VPAR12 AS VPAR12,  ';
    Result := Result + '  FATGOR.AUTOINCREM AS CAP_AUTOINC, ';
    Result := Result + '  GRU_DESGRU AS DESGRU,  ';
    Result := Result + '  GRU_DRELIN AS DRELIN,  ';
    Result := Result + '  FDO_QTDITE - EXTDOR.FDO_QTDEXP AS QTDRES,  ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FDO_PESBRU ', ' 0.00 ')+' AS PESBRI, ';
    Result := Result + '  IF(IFNULL(FDO_NUMLOT, "") = "", ITEGER.ITE_LOCFIS, CL.LOT_LOCFIS) AS LOCFIS, ';
    Result := Result + '  ITE_CODFAB AS CODFAB,  ';
    Result := Result + '  CL.LOT_NUMLOT AS CODAMZ, ';
    Result := Result + '  FGO_MENEXP AS MENEXP, ';
    Result := Result + '  FGO_MENEX2 AS MENEX2, ';
    Result := Result + '  FGO_MENEX3 AS MENEX3, ';
    Result := Result + '  FGO_MENEX4 AS MENEX4, ';
    Result := Result + '  ITE_REFERE AS REFERE,  ';
    Result := Result + '  ETC_CEPENT AS CEPENT_,  ';
    Result := Result + '  ETC_TELENT AS TELENT_,  ';
    Result := Result + '  ETC_REFENT AS REFENT_,  ';
    Result := Result + '  ITE_MLTVEN AS MLTVEN,   ';

    Result := Result + '  FDO_DTAFAT AS DTAFAT, ';

    Result := Result + '  CLI_ENDCOB AS ENDCOB, ';
    Result := Result + '  CLI_BAICOB AS BAICOB, ';
    Result := Result + '  CLI_CEPCOB AS CEPCOB, ';
    Result := Result + '  CLI_CIDCOB AS CIDCOB, ';


    Result := Result + '  ETC_CONENT AS CONENT_, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FGO_EMPEXP', '" "')+' AS EMPEXP, ';

    Result := Result + '  FGO_DESESP AS DESESG, ';
    Result := Result + '  FGO_TOTRET AS TOTRET, ';
    Result := Result + '  FGO_TOTSER AS TOTSER, ';
    Result := Result + '  FGO_TIPFRE AS TIPFRE, ';
    Result := Result + fSQLTipoFrete('FGO_TIPFRE') +
                                 ' AS DESFRE,   ';
    Result := Result + '  FGO_CODTRA AS CODTRA, ';
    Result := Result + '  TRA_NOMTRA AS NOMTRA, ';
    Result := Result + '  TRA_ENDERE AS ENDTRA, ';
    Result := Result + '  TRA_BAIRRO AS BAITRA, ';
    Result := Result + '  TRA_C_E_P_ AS CEPTRA, ';
    Result := Result + '  TRA_FONE01 AS FONTRA, ';
    Result := Result + '  TRA_CODCID AS CIDTRA, ';

    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' TT.CLI_NOMCTT', '" "')+' AS NOMCTT, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' TT.CLI_CELCTT', '" "')+' AS CELCTT, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' TT.CLI_EMACTT', '" "')+' AS EMACTT, ';

    Result := Result + '  CLI_EMAIL3 AS EMAIL3, ';
    Result := Result + '  CLI_EMCOB1 AS EMCOB1, ';

    Result := Result + '  FGO_PORDES AS PORDES, ';
    Result := Result + '  (FDO_UNIORI * FDO_QTDITE) AS VALBRU, '; // Valor Bruto
    Result := Result + '  ((FDO_UNIORI * FDO_QTDITE) - (FDO_UNITAR * FDO_QTDITE)) AS TOTDES,  '; // Desconto Total
    Result := Result + '  ITE_CODBAR AS CODBAR, ';
    Result := Result + '  FGO_TOTIPI AS TOTIPI,  ';

    Result := Result + ' (SELECT SUM(E1.'+IIF((Pos(strEspDoc, 'NF_FF_IF_') > 0), 'DET_VFCPST','FDO_VALFCP')+') AS TOTFCP ';
    Result := Result + '    FROM ';
    Result := Result + '  FATDOR F1 ';
    Result := Result + '    JOIN EXTDOR E1 ';
    Result := Result + '      ON E1.FDO_SEQFDO = F1.AUTOINCREM ';
    Result := Result + '   WHERE F1.FDO_SEQGER = FATGOR.AUTOINCREM) AS TOTFCP, ';

    Result := Result + ' FGO_DESACE AS DESACE, ';

    If (fCfgSis('CUSESP', varBoolean)) then
      Result := Result + '  IF( LOCATE("ITEM ESPECIAL", IT.ITE_DESITE) > 0, EXTDOR.TRI_NCMTIN, IT.ITE_CLAIPI ) AS CLAIPI, '
    Else
      Result := Result + '  IT.ITE_CLAIPI AS CLAIPI, ';

    If (Pos(strEspDoc, 'NF_FF_IF_') <= 0) then
    Begin
      Result := Result + '    IF( ';
      Result := Result + '      FDO_ENTRET = "R", ';
      Result := Result + '      CONCAT(FDO_ENTRET, IFNULL(FDO_LOCRET,"")), ';
      Result := Result + '      IF( ';
      Result := Result + '        FDO_ENTRET = "E" ';
      Result := Result + '        AND FDO_ENTFUT = "S", ';
      Result := Result + '        "EF", ';
      Result := Result + '        "EI" ';
      Result := Result + '      ) ';
      Result := Result + '    ) AS SIGDES, ';
    End
    Else
      Result := Result + '  "" AS SIGDES, ';

    Result := Result + ' O1.OPE_E_MAIL AS EMAVED, ';
    Result := Result + ' ETC_ENDENT AS ETCENT, ';
    Result := Result + ' ETC_BAIENT AS ETCBAI, ';
    Result := Result + ' FDO_CODFIS AS CODFIS, ';
    Result := Result + ' FDO_BASICM AS BASICM, ';
    Result := Result + ' FDO_ALQICM AS ALQICM, ';
    Result := Result + ' FDO_VALICM AS VALICM, ';
    Result := Result + ' FDO_ALQIPI AS ALQIPI, ';
    Result := Result + ' FDO_VALIPI AS VALIPI, ';
    Result := Result + ' IF(FDO_UNIDIG > FDO_UNITAR, FDO_UNIDIG, FDO_UNITAR) AS ITEBRU, ';
    Result := Result + ' IF(FDO_UNIDIG > FDO_UNITAR, FDO_UNITAR, FDO_UNIDIG) AS ITELIQ, ';
    Result := Result + ' IF(FGO_JAFATU=0, "Não Faturado.", "Faturado.")      AS JAFATU,  ';
    Result := Result + ' FGO_BASICM AS BASICM, ';
    Result := Result + ' FGO_TOTICM AS TOTICM, ';
    Result := Result + ' FGO_BASRET AS BASRET, ';
    Result := Result + ' FDO_CODREP AS CODREP, ';
    Result := Result + ' OP.OPE_NOMOPE AS NOMREP, ';
    Result := Result + ' FDO_NUMCMP AS NUMCMP,';
    Result := Result + ' O1.OPE_FONE01 AS FO1VEN, ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' FDO_DESNES', '" "')+' AS DESNES, ';
    Result := Result + ' CLI_CELULA AS CELCLI, ';
    Result := Result + ' IT.ITE_DESITE AS DESCIT, ';
    Result := Result + ' FDO_DESACE AS DESACE, ';

    Result := Result + ' IF( IFNULL(TRI_NCMTIN,"") = "", IT.ITE_CLAIPI, TRI_NCMTIN) AS CODNCM, ';
    Result := Result + ' (FDO_UNITAR * FDO_QTDITE) AS UNTARI, ';
    Result := Result + ' (FDO_UNIORI * FDO_QTDITE) AS UNORIG, ';
    Result := Result + ' CONCAT(CADCLI.CLI_CODREG, " - ", RG.REG_DESREG) AS REGIAO, ';
    Result := Result + ' FGO_TOTPRO AS TOTPRO ';
    Result := Result + ' ,ITE_SALDOS AS SALDO ';
    Result := Result + ' ,IT.ITE_PRDGRU AS PRDGRU ';


    If (fUtilizaImagemOtimizada) Then
    Begin
      If Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
      begin
        Result := Result + ' , (SELECT FROM_BASE64(IFNULL(ITE_SPOB64, ITE_IMGB64)) FROM ITEIMG ';
        Result := Result + '     WHERE ITEIMG.ITE_CODITE = FATDOR.FDO_CODITE ';
        Result := Result + '       AND ITEIMG.ITE_PRINCI = "S" LIMIT 1) AS ITEIMG ';
      end
      else
      begin
        Result := Result + ' , (SELECT FROM_BASE64(IFNULL(ITE_SPOB64, ITE_IMGB64)) FROM ITEIMG ';
        Result := Result + '     WHERE ITEIMG.ITE_CODITE = MOVDET.DET_CODITE ';
        Result := Result + '       AND ITEIMG.ITE_PRINCI = "S" LIMIT 1) AS ITEIMG ';
      end;
    End
    Else
    Begin
      If Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
      begin
        Result := Result + ' , (SELECT FROM_BASE64(IFNULL(ITE_THUB64, ITE_IMGB64)) FROM ITEIMG ';
        Result := Result + '     WHERE ITEIMG.ITE_CODITE = FATDOR.FDO_CODITE ';
        Result := Result + '       AND ITEIMG.ITE_PRINCI = "S" LIMIT 1) AS ITEIMG ';
      end
      else
      begin
        Result := Result + ' , (SELECT FROM_BASE64(IFNULL(ITE_THUB64, ITE_IMGB64)) FROM ITEIMG ';
        Result := Result + '     WHERE ITEIMG.ITE_CODITE = MOVDET.DET_CODITE ';
        Result := Result + '       AND ITEIMG.ITE_PRINCI = "S" LIMIT 1) AS ITEIMG ';
      end;
    End;

    If Pos(strEspDoc, 'NF_FF_IF_') <= 0 Then
    Begin
      Result := Result + ' , DATEDIFF(EXTGOR.FGO_VALORC, FDO_DTAENT) AS QTDDIA ';
      Result := Result + ' , CONCAT(CT.TPA_CODIGO, "-", CT.TPA_DESCRI)  AS TPADES ';
    End
    Else
    Begin
      Result := Result + ' , 0 AS QTDDIA ';
      Result := Result + ' , CAST("" AS CHAR(1)) AS TPADES ';
    End;

    If Pos(strEspDoc, 'NF_FF_IF_') > 0 Then
    Begin
      Result := Result + ' , IF(GER_ENTFAT = "N" , "R", "E") AS ETRETI, ';
      Result := Result + '   FROM_BASE64(ASS_IMGASS) AS IMGASS,           ';
      Result := Result + '   ASS_NOMASS AS NOMASS           ';
    End;

    If Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
    Begin
      Result := Result + ' , (SELECT DISTINCT CONCAT(FD1.FDO_NUMDOC, "-", FD1.FDO_ESPDOC, "-", FD1.FDO_CODEMP) ';
      Result := Result + '      FROM FATDOR FD1 ';
      Result := Result + '     WHERE FD1.FDO_TIPFAT = FATDOR.FDO_ESPDOC ';
      Result := Result + '       AND FD1.FDO_NUMFAT = FATDOR.FDO_NUMDOC ';
      Result := Result + '       AND FD1.FDO_EMPFAT = FATDOR.FDO_CODEMP) AS ORIORC ';

      Result := Result + ' , (SELECT DISTINCT FD1.FDO_DTAENT ';
      Result := Result + '      FROM FATDOR FD1 ';
      Result := Result + '     WHERE FD1.FDO_TIPFAT = FATDOR.FDO_ESPDOC ';
      Result := Result + '       AND FD1.FDO_NUMFAT = FATDOR.FDO_NUMDOC ';
      Result := Result + '       AND FD1.FDO_EMPFAT = FATDOR.FDO_CODEMP) AS DTAORC ';
    End
    Else If Pos(strEspDoc, 'NF_FF_IF_') > 0 then
    begin
      Result := Result + ' , CAST("" AS CHAR(1)) AS ORIORC ';
      Result := Result + ' , CAST("30/12/1899" AS CHAR(10)) AS DTAORC ';
    end;

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      Result := Result + '    ,IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI)  AS LOCSEP '
    Else
      Result := Result + '    ,LSE_DESCRI AS LOCSEP ';

    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' ,FDO_VALRET', ',0.00')+' AS VALRET ';
    Result := Result + IIF(Pos(strEspDoc, 'NF_FF_IF_') <= 0, ' ,0' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM'), ',0.00')+' AS VALREF ';

    If Pos(strEspDoc, 'PD_OR_') > 0 Then
    Begin
      Result := Result + ' , EXTGOR.FGO_CELCON AS CELCON                                                           ';
    End
    Else
    Begin
      Result := Result + ' ,CAST("" AS CHAR(1)) AS CELCON ';
    End;

    If Pos(strEspDoc, '_FF_') > 0 Then
    Begin
      Result := Result + ' , ( SELECT C.CTR_DTAVEN            ';
      Result := Result + '       FROM CADREC C                ';
      Result := Result + '      WHERE C.CTR_NUMDUP = :NUMDOC  ';
      Result := Result + '        AND C.CTR_ESPDOC = :ESPDOC  ';
      Result := Result + '        AND C.CTR_CODEMP = :CODEMP  ';
      Result := Result + '        AND C.CTR_CODCLI = :CODCLI  ';
      Result := Result + '      LIMIT 1) AS PRIVEN            ';
    End
    Else
      Result := Result + ' , "" AS PRIVEN ';

    If Pos(strEspDoc, 'PD_OR_') > 0 Then
    begin
      Result := Result + ' ,IFNULL(ID.ICD_VALORI, 0) AS VDPORI ';
      Result := Result + ' ,IFNULL(ID.ICD_VALDES, 0) AS VDPDES ';
    end
    else
    begin
      Result := Result + ' ,0.00 AS VDPORI ';
      Result := Result + ' ,0.00 AS VDPDES ';
    end;

    Result := Result + ' ,(SELECT MAX(MOE_DTAMOE) FROM CADMOE) AS DTCTAT ';
    Result := Result + ' ,(SELECT MOE_DOLVEN FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE)) AS VLCTAT ';
    Result := Result + ' ,FGO_DTCTVN AS DTCTVN ';
    Result := Result + ' ,FGO_VLCTVN AS VLCTVN ';

    If Pos(strEspDoc, 'PD_') > 0 then  //Se for PD, então buscar o OR de origem
    Begin
      Result := Result + ' , (SELECT DISTINCT CONCAT(DATE_FORMAT(FDO_DTAENT, "%d/%m/%Y"), "    ", FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) ';
      Result := Result + '      FROM FATDOR FD1 ';
      Result := Result + '     WHERE FD1.FDO_TIPFAT = FATDOR.FDO_ESPDOC ';
      Result := Result + '       AND FD1.FDO_NUMFAT = FATDOR.FDO_NUMDOC ';
      Result := Result + '       AND FD1.FDO_EMPFAT = FATDOR.FDO_CODEMP ORDER BY FDO_DTAENT LIMIT 1) AS OR_ORIGEM ';
    End
    Else
      Result := Result + ' , CAST("" AS CHAR(1)) AS OR_ORIGEM ';


    Result := Result + ' FROM ';
    Result := Result + ' FATDOR ';
    Result := Result + '   LEFT JOIN CADMAR ON (CADMAR.MAR_CODMAR = FATDOR.FDO_CODMAR) ';
    Result := Result + '   LEFT JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM) ';
    Result := Result + '        JOIN FATGOR ON (FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM) ';

    if Pos(strEspDoc, 'NF_FF_IF_') <= 0 then
    Begin
      Result := Result + ' JOIN EXTGOR ON (EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM) ';
      Result := Result + ' LEFT JOIN CLICTT TT ON (FATGOR.FGO_CLICTT = TT.AUTOINCREM) ';
      Result := Result + ' LEFT JOIN CADTPA CT ON CT.TPA_CODIGO = EXTGOR.FGO_CODTPA ';
    End;

    Result := Result + '   LEFT JOIN AUXGOR ON (FATGOR.AUTOINCREM = AUX_SEQGER) ';
    Result := Result + '   LEFT JOIN ENTCLI ON (AUXGOR.AUX_ENTGER = ENTCLI.AUTOINCREM) ';
    Result := Result + '        JOIN CADCLI ON (CADCLI.CLI_CODCLI = FDO_CODCLI) ';
    Result := Result + '  LEFT JOIN CADCID C  ON (C.CID_CODCID = CLI_CODCID) ';
    Result := Result + '  LEFT JOIN CADCID E  ON (E.CID_CODCID = ETC_CIDENT) ';
    Result := Result + '  LEFT JOIN CADCID Z  ON (Z.CID_CODCID = FGO_CIDCON) ';
    Result := Result + '  LEFT JOIN CADDIV    ON (CADDIV.DIV_CODDIV = FATDOR.FDO_CODDIV) ';
    Result := Result + '  LEFT JOIN CADOPE O1 ON (O1.OPE_CODOPE   = FDO_CODVEN) ';
    Result := Result + '  LEFT JOIN CADOPE O2 ON (O2.OPE_CODOPE   = FDO_CODVE2) ';
    Result := Result + '  LEFT JOIN CADCND    ON (CND_CODIGO   = FDO_CODCND) ';
    Result := Result + '  LEFT JOIN CADUNI UN ON(UN.UNI_CODUNI = FDO_UNIDAD) ';
    Result := Result + '  LEFT JOIN CADITE IT ON(IT.ITE_CODITE = FDO_CODITE) ';
    Result := Result + '  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = FDO_CODITE ';
    Result := Result + '                  AND ITEGER.ITE_CODEMP = FDO_CODEMP ';
    Result := Result + '  LEFT JOIN CADLOT CL ON FDO_NUMLOT = CL.LOT_NUMLOT  ';
    Result := Result + '                     AND FDO_CODITE = CL.LOT_CODITE  ';
    Result := Result + '                     AND FDO_CODEMP = CL.LOT_CODEMP  ';
    Result := Result + '  LEFT JOIN CADGRU GR ON(GR.GRU_CODGRU = IT.ITE_CODGRU) ';
    Result := Result + '  LEFT JOIN CADTRA ON(FATGOR.FGO_CODTRA = TRA_CODTRA) ';
    Result := Result + '  LEFT JOIN CADOPE OP ON (OP.OPE_CODOPE = FDO_CODREP) ';

    Result := Result + '  LEFT JOIN CADREG RG ON RG.REG_CODREG = CADCLI.CLI_CODREG ';

    If Pos(strEspDoc, 'NF_FF_IF_') > 0 Then
    Begin
      Result := Result + '  LEFT JOIN ASSGER ON ASS_SEQGER = MOVGER.AUTOINCREM ';
    End;

    Result := Result + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CL.LOT_LOCFIS AND L1.LOC_CODEMP = CL.LOT_CODEMP  ';
    Result := Result + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = ITEGER.ITE_LOCFIS  AND L2.LOC_CODEMP = ITEGER.ITE_CODEMP ';

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      Result := Result + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = L1.LOC_CODLSE ';
      Result := Result + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = L2.LOC_CODLSE ';
    end
    else
    Begin
      Result := Result + ' LEFT JOIN CADLSE LS ON LS.LSE_CODIGO = ITEGER.ITE_CODLSE  ';
    End;

    If Pos(strEspDoc, 'PD_OR_') > 0 Then
    Begin
      Result := Result + ' LEFT JOIN DORICD ID ON ID.ICD_SEQFDO = FATDOR.AUTOINCREM     ';
    End;

    Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC AND ';
    Result := Result + '   FDO_ESPDOC = :ESPDOC AND ';
    Result := Result + '   FDO_CODEMP = :CODEMP AND ';
    Result := Result + '   FDO_CODCLI = :CODCLI AND ';
    Result := Result + '   FDO_CLAFIS NOT IN ("1999", "5999") ';

    if (Tipo = tedaPedidoCortado) then
    begin
      Result := Result + ' OR (FGO_MEN001 = "PEDIDO DE ITENS CORTADOS REF. PD Nº '+strNumDoc+'" ';
      Result := Result + ' AND FDO_ESPDOC = :ESPDOC ';
      Result := Result + ' AND FDO_CODEMP = :CODEMP ';
      Result := Result + ' AND FDO_CODCLI = :CODCLI) ';
    end;

    if Pos(strEspDoc, 'NF_FF_IF_') > 0 then
    begin
      If (blnDocSep) Then
        Result := Result + ' AND (DET_QTDITE - IFNULL(MOVTRI.DET_QTDEXP, 0) > 0) ';

      Result := AnsiReplaceStr(Result, 'FATDOR', 'MOVDET');
      Result := AnsiReplaceStr(Result, 'FATGOR', 'MOVGER');
      Result := AnsiReplaceStr(Result, 'AUXGOR', 'AUXMOV');
      Result := AnsiReplaceStr(Result, 'EXTDOR', 'MOVTRI');
      Result := AnsiReplaceStr(Result, 'FDO_EMPITE', 'DET_CODEMP');
      Result := AnsiReplaceStr(Result, 'FDO_SEQFDO', 'DET_SEQGER');
      Result := AnsiReplaceStr(Result, 'FDO_DTENTR', 'GER_DTENTR');
      Result := AnsiReplaceStr(Result, 'FGO_DTCTVN', 'CAST(NULL AS DATETIME)');
      Result := AnsiReplaceStr(Result, 'FGO_VLCTVN', '0.00');
      Result := AnsiReplaceStr(Result, 'FGO_', 'GER_');
      Result := AnsiReplaceStr(Result, 'FDO_', 'DET_');
    end;

    if (Tipo = tedaPedidoCortado) then
      Result := Result + ' ORDER BY NUMDOC ';
  End;

begin

  Try

    pCriarFormularios(TfrmImpEspDefAmbiente, frmImpEspDefAmbiente);

    With frmImpEspDefAmbiente Do
    Begin
      strNomCli := '';
      strEndCli := '';
      strBaiCli := '';
      strCidCli := '';
      strUF_Cli := '';
      strCpfCgc := '';
      strFonCli := '';
      strConCli := '';
      strFaxCli := '';
      strRg_Ie_ := '';
      strCepCli := '';
      strEndEnt := '';
      strEndEnt_ := '';
      strEndEnt2 := '';
      FLegIPI    := '';
      strCelCli  := '';
      strFonCli02 := '';
      FTotalDifal := 0;

      cdsRelatorio := TZClient.Create(frmImpEspDefAmbiente, fGetSql(strEspDoc));
      cdsRelatorio.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
      cdsRelatorio.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
      cdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
      cdsRelatorio.qryQuery.ParamByName('CODCLI').AsString := strCodCli;

      If (fUtilizaImagemOtimizada) Then
        pOtimizaImagensProduto(strNumDoc, strEspDoc, strCodEmp, strCodCli);

      cdsRelatorio.fAbreClient(True, 'TfrmImpEspDefAmbiente.pImprime');

      If cdsRelatorio.IsEmpty Then
      Begin
        If (blnDocSep) Then
        Begin
          fMensagem('Atenção',
                    'A impressão da separação por ambiente é feita apenas dos itens que ainda ' +
                    'não foram expedidos e todos os itens do documento selecionado já foram expedidos. ' +
                    'Portanto, não há nenhum item para ser impresso.',
                    ['&OK']);
        End;

        Exit;
      End;

      FTotalDifal := fRetornaTotalDifal(cdsRelatorio);

      pPreencheDadosCliente(cdsRelatorio);
      pCriaClients(Tipo);

      {Cabeçalho}
      pPreencheCabecalho(cdsRelatorio, LstrCodigoBarrasDocumento);

      {Itens}
      pPreencheItens(cdsRelatorio, False);
      pMontaListaClassificacao();

      if (Tipo = tedaPedidoCortado) then
        cdsRelatorio.First;

      {Rodapé}
      pPreencheRodape(cdsRelatorio);

      {Resumo}
      pPreencheResumo(cdsRelatorio);


      frxCabecalho.DataSet := cdsCabecalho;
      frxItens.DataSet     := cdsItens;
      frxServicos.DataSet  := cdsServicos;
      frxRodape.DataSet    := cdsRodape;
      frxParcelas.DataSet  := cdsParcelas;
      frxResumo.DataSet    := cdsResumo;
      frxFaltas.DataSet    := cdsFaltas;
      frxItensCortados.DataSet := cdsItensCortados;

      frxDefAmbiente_ := nil;
      case Tipo of
        tedaComPreco: frxDefAmbiente_ := frxDefAmbiente;
        tedaSemPreco: frxDefAmbiente_ := frxDefAmbiente_SemPreco;
        tedaSemPrecoSimplificado: frxDefAmbiente_ := frxDefAmbiente_SemPreco_Simplificado;
        tedaSeparacao : begin
                          frxDefAmbiente_ := frxDefAmbienteSeparacao;
                          blnDocSep := true;
                        end;
        tedaFaturamentoFuturo: frxDefAmbiente_ := frxDefAmbiente;
        tedaReferenciaMarca: frxDefAmbiente_ := frxDefAmbiente_ReferenciaMarca;
        tedaReferencia: frxDefAmbiente_ := frxDefAmbiente_Referencia;
        tedaCodigoFabricaMarca: frxDefAmbiente_ := frxDefAmbiente_CodigoFabricaMarca;
        tedaCodigoFabrica: frxDefAmbiente_ := frxDefAmbiente_CodigoFabrica;
        tedaReferenciaMarcaFF: frxDefAmbiente_ := frxDefAmbiente_ReferenciaMarca_FF;
        tedaReferenciaFF: frxDefAmbiente_ := frxDefAmbiente_Referencia_FF;
        tedaCodigoFabricaMarcaFF: frxDefAmbiente_ := frxDefAmbiente_CodigoFabricaMarca_FF;
        tedaCodigoFabricaFF: frxDefAmbiente_ := frxDefAmbiente_CodigoFabrica_FF;
        // incluidos tipos abaixo para não dar erro de layout não encontrado
        tedaComPrecoComMarca: frxDefAmbiente_ := frxDefAmbiente;
        tedaSemPrecoSemMarca: frxDefAmbiente_ := frxDefAmbiente;
        tedaComPrecoSemMarca: frxDefAmbiente_ := frxDefAmbiente;
        tedaSemPrecoComMarca: frxDefAmbiente_ := frxDefAmbiente;
        tedaPedidoCortado: frxDefAmbiente_ := frxPedidoCortado;
      end;

      if not Assigned(frxDefAmbiente_) then
      begin
        fMensagem('', 'Não foi possível encontrar um layout válido!',['&OK']);
        Exit;
      end;

      frxDefAmbiente_.DotMatrixReport           := False;
      frxDefAmbiente_.PrintOptions.PrintMode    := pmScale;
      frxDefAmbiente_.PrintOptions.PrintOnSheet := 9; //A4

      If (strEspDoc = 'OR') Then
        strTitulo := 'Orçamento'
      Else
      If (strEspDoc = 'PD') Then
        strTitulo := 'Pedido'
      Else If (strEspDoc = 'FF') Then
        strTitulo := 'Faturamento Futuro';

      frxDefAmbiente_.Script.Variables['NUMDOC'] := 'Nrº ' + strTitulo + ' ' + strNumDoc;
      frxDefAmbiente_.Script.Variables['ESPDOC'] := strEspDoc;
      frxDefAmbiente_.Script.Variables['TIPDOC'] := strTitulo;
      frxDefAmbiente_.Script.Variables['REIMPR'] := IfThen(blnReimpressao, 'S', 'N');
      frxDefAmbiente_.Script.Variables['MODOROBO'] := IfThen(VS_AutcomIniciadoModoRobo, 'S', 'N');
      frxDefAmbiente_.Script.Variables['REIMPRDESC'] := IfThen(blnReimpressao, '"REIMPRESSÃO"', '');

      if Assigned(TfrxChild(frxDefAmbiente_.FindObject('ChildProposta'))) then
      begin
        TfrxChild(frxDefAmbiente_.FindObject('ChildProposta')).Visible := (strEspDoc = 'OR');
      end;

      qryCfgRel := fCriaQuery;

      If Tipo = tedaSeparacao Then
        strPrefixoFila := 'frmFatVendas_SEP'
      Else
        strPrefixoFila := 'frmFatVendas_' + strEspDoc;

      pCarregaConfImpr(qryCfgRel, strPrefixoFila);

      strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      If fEmptyStr(strNomFil) And ((strSaida <> 'V') and (strSaida <> 'P')) Then
      Begin

        If fCfgSis('CADIMP', VarBoolean) Or VS_SpoolImpressaoCitel Then
          TCfgRel.fSelecionaFila('','','','',strNomFil,strTipImp,True)
        Else If Not (TCfgRel.fExecutePrintDialog(strNomFil)) Then
          strNomFil := TCfgRel.fGetImpressoraSelecionada;//default

      End;

      if fTemFR3(Tipo) then
      begin
        frxDefAmbiente_.Script.Variables['NUMDOC'] := 'Nº ' + strNumDoc;
        frxDefAmbiente_.Script.Variables['TIPDOC'] := AnsiUpperCase(strTitulo);
        frxDefAmbiente_.LoadFromFile(fGetCaminhoFR3(Tipo));
      end
      else if fTemFR3(tedaComPreco) then
      begin
        frxDefAmbiente_.Script.Variables['NUMDOC'] := 'Nº ' + strNumDoc;
        frxDefAmbiente_.Script.Variables['TIPDOC'] := AnsiUpperCase(strTitulo);
        frxDefAmbiente_.LoadFromFile(fGetCaminhoFR3(tedaComPreco));
      end;

      If (FileExists(fCfgSis('PATETI') + '\frxDefAmbiente_PD.fr3')) And (strEspDoc = 'PD') And (Not blnDocSep) Then
        frxDefAmbiente_.LoadFromFile(fCfgSis('PATETI') + '\frxDefAmbiente_PD.fr3');

      {Ocultar coluna estoque S/N}
      If (strEspDoc = 'OR') Then
      Begin

        If frxDefAmbiente_.FindObject('memEstoque') <> Nil Then
          If frxDefAmbiente_.FindObject('memEstoque') Is TfrxMemoView Then
            (frxDefAmbiente_.FindObject('memEstoque') As TfrxMemoView).Visible := False;

        If frxDefAmbiente_.FindObject('memEstoqueSN') <> Nil Then
          If frxDefAmbiente_.FindObject('memEstoqueSN') Is TfrxMemoView Then
            (frxDefAmbiente_.FindObject('memEstoqueSN') As TfrxMemoView).Visible := False;

        If frxDefAmbiente_.FindObject('lineEstoque') <> Nil Then
          If frxDefAmbiente_.FindObject('lineEstoque') Is TfrxLineView Then
            (frxDefAmbiente_.FindObject('lineEstoque') As TfrxLineView).Visible := False;

        If frxDefAmbiente_.FindObject('lineEstoque_') <> Nil Then
          If frxDefAmbiente_.FindObject('lineEstoque_') Is TfrxLineView Then
            (frxDefAmbiente_.FindObject('lineEstoque_') As TfrxLineView).Visible := False;

      End;

      If (strEspDoc = 'OR') then
      begin
        If Assigned(TfrxMemoView(frxDefAmbiente_.FindObject('memDiaOrc'))) then
          TfrxMemoView(frxDefAmbiente_.FindObject('memDiaOrc')).Visible := True;
      End;

      if Assigned(TfrxBarCodeView(frxDefAmbiente_.FindObject('BarCode1'))) then
        TfrxBarCodeView(frxDefAmbiente_.FindObject('BarCode1')).Text := LstrCodigoBarrasDocumento;

      if (Assigned(TfrxMemoView(frxDefAmbiente_.FindObject('memParcelaAmbiente')))) and (Assigned(TfrxMemoView(frxDefAmbiente_.FindObject('memVencimentoAmbiente'))))  then
      begin
        if cdsRelatorio.FieldByName('CODFPG').AsString = '009' then
        begin
          TfrxMemoView(frxDefAmbiente_.FindObject('memParcelaAmbiente')).Text := 'Qtd. Parcelas';
          TfrxMemoView(frxDefAmbiente_.FindObject('memVencimentoAmbiente')).Text := 'Forma Negociada';
        end
        else
        begin
          TfrxMemoView(frxDefAmbiente_.FindObject('memParcelaAmbiente')).Text := 'Parcela';
          TfrxMemoView(frxDefAmbiente_.FindObject('memVencimentoAmbiente')).Text := 'Vencimento';
        end;
      end;

      if Assigned(TfrxMasterData(frxDefAmbiente_.FindObject('rlbParcelas'))) then
      begin
        {Parcelas}
        pPreencheParcelas(cdsRelatorio, strNumDoc);
      end;

      if Assigned(TfrxChild(frxDefAmbiente_.FindObject('ChildRodapeDados'))) then
      begin
        pPreencheParcelas(cdsRelatorio, strNumDoc);
      end;

      if Assigned(TfrxMasterData(frxDefAmbiente_.FindObject('rlbdtItensCortados'))) then
      begin
        {Itens cortados gerando vendas perdidas}
        pPreencheItensCortados(strNumDoc, strEspDoc, strCodEmp, strCodCli);
      end;

      if Assigned(TfrxMasterData(frxDefAmbiente_.FindObject('rlbServicos'))) then
      begin
        {Serviços}
        pPreencheServicos(strNumDoc, strEspDoc, strCodEmp, strCodCli);
      end;

      if Assigned(TfrxChild(frxDefAmbiente_.FindObject('rlbFaltas'))) then
      begin
        pPreencheFaltas(cdsRelatorio);

        If fCfgSis('QUESAL') = 'N' Then
         Begin
          TfrxChild(frxDefAmbiente_.FindObject('rlbFaltas')).Visible := False;
          TfrxChild(frxDefAmbiente_.FindObject('Header2')).Visible := False;
         End
      end;

      If Assigned(TfrxChild(frxDefAmbiente_.FindObject('ChildMsng'))) Then
        TfrxChild(frxDefAmbiente_.FindObject('ChildMsng')).Visible := (strEspDoc = 'OR');

      If (fCfgSis('AMBDEF', varInteger) = 2) and (Assigned(TfrxGroupHeader(frxDefAmbiente_.FindObject('rlbGrupo')))) Then
        TfrxGroupHeader(frxDefAmbiente_.FindObject('rlbGrupo')).Condition := 'frxItens."COMORD"';

      If Assigned(frxDefAmbiente_.FindObject('imgLogo')) then
      Begin
        if (fCarregaImagemEmpresa(strCodEmp, TfrxPictureView(frxDefAmbiente_.FindObject('imgLogo')).Picture) <> riOk) then
        Begin
          If FileExists(fCfgSis('PATLOG')) Then
            TfrxPictureView(frxDefAmbiente_.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('PATLOG'));
        End;
      End;

      If (strSaida = 'I') Then
      begin

        For intPosicao := 1 To intQtdImp Do
        Begin

          frxDefAmbiente_.PrintOptions.ShowDialog := False;

          if not fEmptyStr(strNomFil) then
            frxDefAmbiente_.PrintOptions.Printer := AnsiReplaceText(strNomFil,'\\' + fRetNomeRede + '\','');

          If frxDefAmbiente_.PrepareReport Then
            pPrintReport(strPrefixoFila, 'Impressão por definição de ambiente (' + strNumDoc + '-' + strEspDoc + ')', strNomFil, frxDefAmbiente_);

        End;

      end
      Else
      Begin

        {PDF}
        If (strSaida = 'P') Then
        Begin

          If frxDefAmbiente_.PrepareReport Then
          Begin

            strNomArq := strEspDoc + '_' + strNumDoc + '_' + strCodEmp + '.pdf';
            strPath := ExtractFilePath(Application.ExeName) + 'PedidoOrcamento' + '\';

            frxExportaPDF.ShowDialog  := Not fCriaDiretorio(strPath);
            frxExportaPDF.DefaultPath := strPath;

            frxExportaPDF.FileName    := strNomArq;
            frxDefAmbiente_.Export(frxExportaPDF);

            strPath := strPath + strNomArq;

            If (blnVisPdf) Then
              pExecArquivo(strPath, 0)
          End;

        End
        Else
        Begin
          frxDefAmbiente_.PrintOptions.ShowDialog := True;
          pPreviewReport('frmFatVendas_' + strEspDoc, 'Impressão por definição de ambiente (' + strNumDoc + '-' + strEspDoc + ')', frxDefAmbiente_);
        End;

      End;

    End;

  Finally
    FreeAndNil(qryCfgRel);
    FreeAndNil(frmImpEspDefAmbiente);
  End;

end;

procedure TfrmImpEspDefAmbiente.pPreencheCabecalho(cdsRelatorio : TZClient; var ACodigoBarrasDocumento : String);
  Var
    blnTemEmpExp: Boolean;
    qryEmpTmp,
    qryEmpExp: TUniQuery;
    strSQL: String;

begin
  inherited;

  qryEmpTmp := fCriaQuery;
  qryEmpExp := fCriaQuery;

  Try

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
    strSQL := strSQL + '   COALESCE(EMP_FONE01, EMP_FONE02) FONEMP, ';
    strSQL := strSQL + '   CONCAT(COALESCE(EMP_ENDERE, ""), " ", COALESCE(EMP_ENDNUM, ""), " ", COALESCE(EMP_BAIRRO, "")) ENDEMP, ';
    strSQL := strSQL + '   EMP_C_E_P_ CEPEMP, ';
    strSQL := strSQL + '   CONCAT(COALESCE(CID_NOMCID, ""), "-", COALESCE(CID_ESTADO, "")) CIDEMP, ';
    strSQL := strSQL + '   EMP_CONTAT CONEMP, ';
    strSQL := strSQL + '   EMP_EMAILV EMAIL_, ';
    strSQL := strSQL + '   EMP_C_G_C_ CGCEMP, ';
    strSQL := strSQL + '   EMP_I_E_S_ IE_EMP, ';
    strSQL := strSQL + '   EMP_EMAIL_ EMAEMP, ';
    strSQL := strSQL + '   EMP_F_A_X_ EMPFAX, ';
    strSQL := strSQL + '   EMP_FONE02 AS FONEM2, ';
    strSQL := strSQL + '   EMP_HOMEPA AS HOMEPA, ';
    strSQL := strSQL + '   EMP_FONE01 AS FONEM1, ';
    strSQL := strSQL + '   CID_ESTADO AS UF_EMP  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + ' JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';

    qryEmpTmp.SQL.Clear;
    qryEmpTmp.SQL.Add(strSQL);
    qryEmpTmp.ParamByName('CODEMP').AsString := cdsRelatorio.FieldByName('CODEMP').AsString;
    qryEmpTmp.Open;

    qryEmpExp.SQL.Clear;
    qryEmpExp.SQL.Add(strSQL);
    qryEmpExp.ParamByName('CODEMP').AsString := IIF(cdsRelatorio.FieldByName('CODEMP').AsString <> cdsRelatorio.FieldByName('EMPEXP').AsString,
                                                    cdsRelatorio.FieldByName('EMPEXP').AsString,
                                                    cdsRelatorio.FieldByName('CODEMP').AsString);
    qryEmpExp.Open;

    With cdsCabecalho Do
    Begin
      Append;
      FieldByName('NUMDOC').AsString := cdsRelatorio.FieldByName('NUMDOC').AsString;
      FieldByName('NUMDCC').AsString := cdsRelatorio.FieldByName('NUMDOC').AsString;
      FieldByName('ESPDOC').AsString := cdsRelatorio.FieldByName('ESPDOC').AsString;
      FieldByName('NOMEMP').AsString := qryEmpTmp.FieldByName('NOMEMP').AsString;
      FieldByName('FONEMP').AsString := fFormataFone(qryEmpTmp.FieldByName('FONEMP').AsString);
      FieldByName('EMPFAX').AsString := fFormataFone(qryEmpTmp.FieldByName('EMPFAX').AsString);

      FieldByName('FONE_E_FAX').AsString := fFormataFone(qryEmpTmp.FieldByName('FONEMP').AsString);
      If Not fEmptyStr(qryEmpTmp.FieldByName('EMPFAX').AsString) Then
        FieldByName('FONE_E_FAX').AsString := FieldByName('FONE_E_FAX').AsString + ' Fax: ' + fFormataFone(qryEmpTmp.FieldByName('EMPFAX').AsString);

      FieldByName('ENDEMP').AsString := qryEmpTmp.FieldByName('ENDEMP').AsString;
      FieldByName('CEPEMP').AsString := fFormataCEP(qryEmpTmp.FieldByName('CEPEMP').AsString);
      FieldByName('CIDEMP').AsString := qryEmpTmp.FieldByName('CIDEMP').AsString;
      FieldByName('CONEMP').AsString := qryEmpTmp.FieldByName('CONEMP').AsString;
      FieldByName('EMAIL_').AsString := IIF(Not fEmptyStr(qryEmpTmp.FieldByName('EMAIL_').AsString), qryEmpTmp.FieldByName('EMAIL_').AsString, qryEmpTmp.FieldByName('EMAEMP').AsString);
      FieldByName('DTADOC').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAENT').AsDateTime);
      FieldByName('HORDOC').AsString := FormatDateTime('hh:nn:ss', cdsRelatorio.FieldByName('HORENT').AsDateTime);

      FieldByName('CODCLI').AsString := cdsRelatorio.FieldByName('CODCLI').AsString;
      FieldByName('NOMCLI').AsString := Self.strNomCli;
      FieldByName('CONCLI').AsString := Self.strConCli;
      FieldByName('CPFCGC').AsString := fFormataCpfCgc(Self.strCpfCgc, opcBrasil);
      FieldByName('RG_IE_').AsString := Self.strRg_Ie_;
      FieldByName('ENDCLI').AsString := Self.strEndCli;
      FieldByName('BAICLI').AsString := Self.strBaiCli;
      FieldByName('CIDCLI').AsString := Self.strCidCli;
      FieldByName('UF_CLI').AsString := Self.strUF_Cli;
      FieldByName('CEPCLI').AsString := fFormataCEP(Self.strCepCli);
      FieldByName('FONCLI').AsString := fFormataFone(Self.strFonCli);
      FieldByName('CLIF02').AsString := fFormataFone(Self.strFonCli02);

      FieldByName('FAXCLI').AsString  := fFormataFone(Self.strFaxCli);
      FieldByName('CEPCLI_').AsString := fFormataCEP(cdsRelatorio.FieldByName('CEPCLI').AsString);
      FieldByName('EMACLI').AsString  := cdsRelatorio.FieldByName('EMACLI').AsString;
      FieldByName('IESCLI').AsString  := cdsRelatorio.FieldByName('I_E_S_').AsString;
      FieldByName('ENDCOM').AsString  := cdsRelatorio.FieldByName('ENDCOM').AsString; {Complemento}

      {1 - CNPJ / 2 - CPF}
      FieldByName('CNPCLI').AsString := '';
      FieldByName('CPFCLI').AsString := '';

      If (cdsRelatorio.FieldByName('CGCCPF').AsInteger = 1) Then
        FieldByName('CNPCLI').AsString := fFormataCpfCgc(cdsRelatorio.FieldByName('C_G_C_').AsString, opcBrasil)
      Else
      If (cdsRelatorio.FieldByName('CGCCPF').AsInteger = 2) Then
        FieldByName('CPFCLI').AsString := fFormataCpfCgc(cdsRelatorio.FieldByName('C_G_C_').AsString, opcBrasil);

      FieldByName('CODPRF').AsString := cdsRelatorio.FieldByName('CODPRF').AsString;
      FieldByName('NOMPRF').AsString := cdsRelatorio.FieldByName('NOMPRF').AsString;
      FieldByName('NUMCMP').AsString := cdsRelatorio.FieldByName('CMPNUM').AsString;
      FieldByName('CGCEMP').AsString := fFormataCpfCgc(qryEmpTmp.FieldByName('CGCEMP').AsString, opcBrasil);
      FieldByName('IE_EMP').AsString := qryEmpTmp.FieldByName('IE_EMP').AsString;
      FieldByName('NOMPRO').AsString := IIF(Not fEmptyStr(cdsRelatorio.FieldByName('CODVEN').AsString), cdsRelatorio.FieldByName('CODVEN').AsString + ' - ' + fRetNomVendRep(cdsRelatorio.FieldByName('CODVEN').AsString), '') +
                                        IIF(Not fEmptyStr(cdsRelatorio.FieldByName('CODVE2').AsString), ' / ' + cdsRelatorio.FieldByName('CODVE2').AsString + ' - ' + fRetNomVendRep(cdsRelatorio.FieldByName('CODVE2').AsString), '') ;
      FieldByName('MENEXP').AsString := cdsRelatorio.FieldByName('MENEXP').AsString;
      FieldByName('MENEX2').AsString := cdsRelatorio.FieldByName('MENEX2').AsString;
      FieldByName('MENEX3').AsString := cdsRelatorio.FieldByName('MENEX3').AsString;
      FieldByName('MENEX4').AsString := cdsRelatorio.FieldByName('MENEX4').AsString;
      FieldByName('EXPSEP').AsString := cdsRelatorio.FieldByName('EXPSEP').AsString;
      FieldByName('STASEP').AsString := cdsRelatorio.FieldByName('STASEP').AsString;
      FieldByName('FANSOB').AsString := cdsRelatorio.FieldByName('FANSOB').AsString;
      FieldByName('NOMCID').AsString := cdsRelatorio.FieldByName('NOMCID').AsString;

      FieldByName('DTAFAT').AsString := IIF(FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAFAT').AsDateTime) = '30/12/1899',
                                            '',
                                            FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAFAT').AsDateTime));

      FieldByName('ENDFAT').AsString := cdsRelatorio.FieldByName('ENDERE').AsString+', '+
                                        cdsRelatorio.FieldByName('ENDNUM').AsString+' - '+
                                        cdsRelatorio.FieldByName('BAIRRO').AsString+' - '+
                                        cdsRelatorio.FieldByName('NOMCID').AsString+' - '+
                                        cdsRelatorio.FieldByName('ESTADO').AsString+' | CEP: '+
                                        fFormataCEP(cdsRelatorio.FieldByName('C_E_P_').AsString);

      FieldByName('ENDCOB').AsString := cdsRelatorio.FieldByName('ENDCOB').AsString+' - '+
                                        cdsRelatorio.FieldByName('BAICOB').AsString+' - '+
                                        fRetNomCidade(cdsRelatorio.FieldByName('CIDCOB').AsString,0)+' - '+
                                        fRetNomCidade(cdsRelatorio.FieldByName('CIDCOB').AsString,1)+' | CEP: '+
                                        fFormataCEP(cdsRelatorio.FieldByName('CEPCOB').AsString);

      ACodigoBarrasDocumento :=  cdsRelatorio.FieldByName('BARDOC').AsString;

      blnTemEmpExp := (Not fEmptyStr(cdsRelatorio.FieldByName('EMPEXP').AsString)) And
                      (cdsRelatorio.FieldByName('CODEMP').AsString <> cdsRelatorio.FieldByName('EMPEXP').AsString);

      FieldByName('ENDEXP').AsString := IIF(blnTemEmpExp, qryEmpExp.FieldByName('ENDEMP').AsString, qryEmpTmp.FieldByName('ENDEMP').AsString);
      FieldByName('CEPEXP').AsString := IIF(blnTemEmpExp, fFormataCEP(qryEmpExp.FieldByName('CEPEMP').AsString), fFormataCEP(qryEmpTmp.FieldByName('CEPEMP').AsString));
      FieldByName('CIDEXP').AsString := IIF(blnTemEmpExp, qryEmpExp.FieldByName('CIDEMP').AsString, qryEmpTmp.FieldByName('CIDEMP').AsString);
      FieldByName('FONFAXEXP').AsString := IIF(blnTemEmpExp, fFormataFone(qryEmpExp.FieldByName('FONEMP').AsString), fFormataFone(qryEmpTmp.FieldByName('FONEMP').AsString));
      if (blnTemEmpExp) then
      begin
        If Not fEmptyStr(qryEmpExp.FieldByName('EMPFAX').AsString) Then
          FieldByName('FONFAXEXP').AsString := FieldByName('FONFAXEXP').AsString + ' Fax: ' + fFormataFone(qryEmpExp.FieldByName('EMPFAX').AsString);
      end
      else
      begin
        If Not fEmptyStr(qryEmpTmp.FieldByName('EMPFAX').AsString) Then
          FieldByName('FONFAXEXP').AsString := FieldByName('FONFAXEXP').AsString + ' Fax: ' + fFormataFone(qryEmpTmp.FieldByName('EMPFAX').AsString);
      end;
      FieldByName('CGCEXP').AsString := IIF(blnTemEmpExp, fFormataCpfCgc(qryEmpExp.FieldByName('CGCEMP').AsString, opcBrasil), fFormataCpfCgc(qryEmpTmp.FieldByName('CGCEMP').AsString, opcBrasil));
      FieldByName('IE_EXP').AsString := IIF(blnTemEmpExp, qryEmpExp.FieldByName('IE_EMP').AsString, qryEmpTmp.FieldByName('IE_EMP').AsString);

      FieldByName('CONPAG').AsString := fRetornaCndPagFormatado(cdsRelatorio.FieldByName('CONPAG').AsString);
      FieldByName('CONPA2').AsString := fRetornaCndPagFormatado(cdsRelatorio.FieldByName('CONPAG').AsString, True);
      ACodigoBarrasDocumento :=  cdsRelatorio.FieldByName('BARDOC').AsString;
      FieldByName('REFENT_').AsString := cdsRelatorio.FieldByName('REFENT_').AsString;
      FieldByName('EMAIL3').AsString := cdsRelatorio.FieldByName('EMAIL3').AsString;
      FieldByName('EMCOB1').AsString := cdsRelatorio.FieldByName('EMCOB1').AsString;
      FieldByName('CODEMP').AsString := cdsRelatorio.FieldByName('CODEMP').AsString;
      FieldByName('FONEM2').AsString := fFormataFone(qryEmpTmp.FieldByName('FONEM2').AsString);
      FieldByName('HOMEPA').AsString := qryEmpTmp.FieldByName('HOMEPA').AsString;
      FieldByName('EMAVED').AsString := cdsRelatorio.FieldByName('EMAVED').AsString;
      FieldByName('CODVEN').AsString := cdsRelatorio.FieldByName('CODVEN').AsString;
      FieldByName('NOMVEN').AsString := cdsRelatorio.FieldByName('NOMVEN').AsString;
      FieldByName('ETCENT').AsString := cdsRelatorio.FieldByName('ETCENT').AsString;
      FieldByName('ETCBAI').AsString := cdsRelatorio.FieldByName('ETCBAI').AsString;
      FieldByName('NCIDEN').AsString := cdsRelatorio.FieldByName('NCIDEN').AsString + ' / '+cdsRelatorio.FieldByName('NESTEN').AsString;
      FieldByName('JAFATU').AsString := cdsRelatorio.FieldByName('JAFATU').AsString;
      FieldByName('FO1VEN').AsString := fFormataFone(cdsRelatorio.FieldByName('FO1VEN').AsString);
      FieldByName('FONEM1').AsString := fFormataFone(qryEmpTmp.FieldByName('FONEM1').AsString);
      FieldByName('CELCLI').AsString := fFormataFone(Self.strCelCli);
      FieldByName('CELCON').AsString := fFormataFone(cdsRelatorio.FieldByName('CELCON').AsString);
      FieldByName('CEP_CL').AsString := fFormataCEP(cdsRelatorio.FieldByName('C_E_P_').AsString);
      FieldByName('MAI_CL').AsString := cdsRelatorio.FieldByName('EMACON').AsString;
      FieldByName('CEL_CL').AsString := fFormataFone(cdsRelatorio.FieldByName('CELCON').AsString);
      FieldByName('UF_EMP').AsString := qryEmpTmp.FieldByName('UF_EMP').AsString;
      FieldByName('OR_ORIGEM').AsString := cdsRelatorio.FieldByName('OR_ORIGEM').AsString;
    end;

  finally
    FreeAndNil(qryEmpTmp);
    FreeAndNil(qryEmpExp);
  end;

end;

procedure TfrmImpEspDefAmbiente.pPreencheDadosCliente(cdsRelatorio : TZClient);
begin

  If Not fClienteConsumidor(cdsRelatorio.FieldByName('NOMCLI').AsString, True, True) Then
  Begin
    strNomCli := cdsRelatorio.FieldByName('NOMCLI').AsString;
    strEndCli := cdsRelatorio.FieldByName('ENDERE').AsString + ', ' + cdsRelatorio.FieldByName('ENDNUM').AsString;
    strBaiCli := cdsRelatorio.FieldByName('BAIRRO').AsString;
    strCidCli := cdsRelatorio.FieldByName('NOMCID').AsString;
    strUF_Cli := cdsRelatorio.FieldByName('ESTADO').AsString;
    strCpfCgc := fFormataCpfCgc(cdsRelatorio.FieldByName('C_G_C_').AsString,opcBrasil,fRetNomCidade(IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString), cdsRelatorio.FieldByName('CODCID').AsString, cdsRelatorio.FieldByName('CIDENT').AsString),1));
    strFonCli := cdsRelatorio.FieldByName('FONE01').AsString;
    strConCli := cdsRelatorio.FieldByName('CONTAT').AsString;
    strFaxCli := cdsRelatorio.FieldByName('F_A_X_').AsString;
    strFonCli02 := cdsRelatorio.FieldByName('CLIF02').AsString;


    If (cdsRelatorio.FieldByName('CGCCPF').AsInteger = 1) Then
      strRg_Ie_ := cdsRelatorio.FieldByName('I_E_S_').AsString
    Else
      strRg_Ie_ := cdsRelatorio.FieldByName('NUMR_G').AsString;

    strCepCli := IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                               cdsRelatorio.FieldByName('C_E_P_').AsString,
                               cdsRelatorio.FieldByName('CEPENT').AsString);

    strEndEnt := IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                               cdsRelatorio.FieldByName('ENDERE').AsString,
                               cdsRelatorio.FieldByName('ENDENT').AsString) +
                 IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                               ', ' + cdsRelatorio.FieldByName('ENDNUM').AsString, '') + '  ' +
                 IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                               cdsRelatorio.FieldByName('BAIRRO').AsString,
                               cdsRelatorio.FieldByName('BAIENT').AsString) + '  ' +
                 fFormataCEP(IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                           cdsRelatorio.FieldByName('C_E_P_').AsString,
                                           cdsRelatorio.FieldByName('CEPENT').AsString)) + '  ' +
                 IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                               cdsRelatorio.FieldByName('NOMCID').AsString,
                               cdsRelatorio.FieldByName('NCIDEN').AsString) + ' - ' +
                               cdsRelatorio.FieldByName('NESTEN').AsString;

    strEndEnt_ := IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('ENDERE').AsString,
                                cdsRelatorio.FieldByName('ENDENT_').AsString) +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                ', ' + cdsRelatorio.FieldByName('ENDNUM').AsString, '') + '  ' +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('BAIRRO').AsString,
                                cdsRelatorio.FieldByName('BAIENT').AsString) + '  ' +

                  IIF(Not fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString) And
                      Not fEmptyStr(cdsRelatorio.FieldByName('REFENT_').AsString), #13#10 + 'Referência: ' + cdsRelatorio.FieldByName('REFENT_').AsString, '') + ' ' +

                  IIF(Not fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString) And
                      Not fEmptyStr(cdsRelatorio.FieldByName('TELENT_').AsString), #13#10 + 'Telefone: ' + fFormataFone(cdsRelatorio.FieldByName('TELENT_').AsString), '') + ' ' + #13#10 +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('ENDCOM').AsString, '') + '  ' +

                  fFormataCEP(IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                            cdsRelatorio.FieldByName('C_E_P_').AsString,
                                            cdsRelatorio.FieldByName('CEPENT_').AsString)) + '  ' +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('NOMCID').AsString,
                                cdsRelatorio.FieldByName('NCIDEN').AsString) + ' - ' +
                                cdsRelatorio.FieldByName('NESTEN').AsString;

    strEndEnt2 := IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('ENDERE').AsString,
                                cdsRelatorio.FieldByName('ENDENT_').AsString) +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                ', ' + cdsRelatorio.FieldByName('ENDNUM').AsString, '') + ' - ' +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('BAIRRO').AsString,
                                cdsRelatorio.FieldByName('BAIENT').AsString) + ' - ' +

                  IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                cdsRelatorio.FieldByName('NOMCID').AsString,
                                cdsRelatorio.FieldByName('NCIDEN').AsString) + ' - ' +
                                cdsRelatorio.FieldByName('NESTEN').AsString + ' | CEP: ' +

                  fFormataCEP(IIF(fEmptyStr(cdsRelatorio.FieldByName('ENDENT').AsString),
                                            cdsRelatorio.FieldByName('C_E_P_').AsString,
                                            cdsRelatorio.FieldByName('CEPENT_').AsString));

    strCelCli := cdsRelatorio.FieldByName('CELCLI').AsString;

  End
  Else
  Begin

    strNomCli := cdsRelatorio.FieldByName('NOMCLI').AsString;
    strEndCli := cdsRelatorio.FieldByName('ENDCON').AsString;
    strBaiCli := cdsRelatorio.FieldByName('BAICON').AsString;
    strCpfCgc := fFormataCpfCgc(cdsRelatorio.FieldByName('CGCCON').AsString,opcBrasil,fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,1));
    strConCli := '';
    strFaxCli := '';
    strFonCli02 := '';

    If (cdsRelatorio.FieldByName('CGCCPF').AsInteger = 1) Then
      strRg_Ie_ := cdsRelatorio.FieldByName('IESCON').AsString
    Else
      strRg_Ie_ := cdsRelatorio.FieldByName('R_GCON').AsString;

    strCidCli := fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,0);
    strUF_Cli := fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,1);
    strFonCli := cdsRelatorio.FieldByName('TELCON').AsString;
    strCepCli := cdsRelatorio.FieldByName('CEPCON').AsString;
    strEndEnt := cdsRelatorio.FieldByName('ENDCON').AsString + '  ' +
                 cdsRelatorio.FieldByName('BAICON').AsString + '  ' +
                 fFormataCEP(cdsRelatorio.FieldByName('CEPCON').AsString) + '  ' +
                 fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,0) + ' - ' +
                 fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,1);
    strEndEnt2 := cdsRelatorio.FieldByName('ENDCON').AsString + ' - ' +
                  cdsRelatorio.FieldByName('BAICON').AsString + ' - ' +
                  fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,0) + ' - ' +
                  fRetNomCidade(cdsRelatorio.FieldByName('CIDCON').AsString,1) + ' | CEP:' +
                  fFormataCEP(cdsRelatorio.FieldByName('CEPCON').AsString);
    strCelCli := '';
  End;

end;

procedure TfrmImpEspDefAmbiente.pPreencheFaltas(cdsRelatorio : TZClient);
begin
  cdsRelatorio.First;

  while not cdsRelatorio.Eof do
  begin
    cdsFaltas.Append;

    cdsFaltas.FieldByName('DESMAR').AsString := Copy(cdsRelatorio.FieldByName('DESMAR').AsString, 5, Length(cdsRelatorio.FieldByName('DESMAR').AsString));
    cdsFaltas.FieldByName('MARCA_').AsString := cdsRelatorio.FieldByName('DESMAR').AsString;
    cdsFaltas.FieldByName('UNIDAD').AsString := cdsRelatorio.FieldByName('UNIDAD').AsString;
    cdsFaltas.FieldByName('QTDITE').AsFloat  := cdsRelatorio.FieldByName('QTDITE').AsFloat;
    cdsFaltas.FieldByName('VALITE').AsFloat  := cdsRelatorio.FieldByName('VALUNI').AsFloat;
    cdsFaltas.FieldByName('TOTITE').AsFloat  := cdsRelatorio.FieldByName('VALITE').AsFloat;
    cdsFaltas.FieldByName('DESITE').AsString := cdsRelatorio.FieldByName('DESITE').AsString;
    cdsFaltas.FieldByName('CODITE').AsString := cdsRelatorio.FieldByName('CODITE').AsString;
    cdsFaltas.FieldByName('NUMLOT').AsString := cdsRelatorio.FieldByName('NUMLOT').AsString;
    cdsFaltas.FieldByName('DESCON').AsFloat  := cdsRelatorio.FieldByName('DESCON').AsFloat;
    cdsFaltas.FieldByName('VALPRO').AsFloat  := IIF(cdsRelatorio.FieldByName('UNIORI').AsFloat > cdsRelatorio.FieldByName('VALUNI').AsFloat,
                                                    cdsRelatorio.FieldByName('UNIORI').AsFloat, cdsRelatorio.FieldByName('VALUNI').AsFloat);

    If cdsRelatorio.FieldByName('SALDO').AsInteger <= 0 Then
    Begin
      cdsFaltas.Post;
    End
    Else
      cdsFaltas.Delete;

    cdsRelatorio.Next;
  end;
end;

procedure TfrmImpEspDefAmbiente.pPreencheItens(cdsRelatorio : TZClient; blnImpDescSimp: Boolean);
  Var
    blnDesSim, blnItemEspecial: Boolean;
    strEntRet,
    strCliBus: String;
    fltSaldos, fltCnvML, fltSalML, fltQtdDoc: Double;
    recSaldos, recSaldosML: TRecSaldos;
    stlSeqAmb: TStringList;
    intIdx : Integer;
begin
  inherited;

  stlSeqAmb := TStringList.Create;

  try
    With cdsRelatorio Do
    Begin
      {********************************************************}
      {* SE FOR ORÇAMENTO E ESTIVER CONFIGURADO PARA UTILIZAR *}
      {* A DESCRIÇÃO SIMPLES                                  *}
      {*****************************************************RV*}
      blnDesSim := False;
      If ((cdsRelatorio.FieldByName('ESPDOC').AsString  = 'OR') And
          (cdsRelatorio.FieldByName('ORGPUB').AsString <> 'S' ) And
          ((fCfgSis('IDSORC') = 'S') or ((fCfgSis('IDSORC') = 'P') And (fGetMenu('Descrição do Produto:', ['Completa','Simplificada'], 2) = 2)) )
         ) Then
      Begin
        blnDesSim := True;
      End;

      First;

      While Not Eof Do
      Begin
        blnItemEspecial := (Pos('ITEM ESPECIAL', FieldByName('DESCIT').AsString) > 0);

        cdsItens.Append;

        strEntRet := IIF(FieldByName('ENTFUT').AsString = 'S',
                         'F' + IIF(Not fEmptyStr(FieldByName('MOTFUT').AsString), '-' + FieldByName('MOTFUT').AsString, ''),
                         IIF(FieldByName('ENTRET').AsString = 'R', 'R', 'I'));

        If FieldByName('ENTFUT').AsString = 'S' Then
        Begin
          strCliBus := FieldByName('CLIBUS').AsString;
        End
        Else
        Begin
          strCliBus := IIF(strEntRet = 'R', 'S', 'N');
        End;

        cdsItens.FieldByName('NUMITE').AsInteger := FieldByName('NUMITE').AsInteger;
        cdsItens.FieldByName('AUTOINCREM').AsString := FieldByName('ITE_AUTOINC').AsString;
        cdsItens.FieldByName('CLIBUS').AsString := strCliBus;
        cdsItens.FieldByName('ENTRET').AsString := strEntRet;

        IF FieldByName('ESPDOC').AsString = 'FF' Then
          cdsItens.FieldByName('ETRETI').AsString := FieldByName('ETRETI').AsString;

        cdsItens.FieldByName('COMPLE').AsString := FieldByName('COMPLE').AsString;
        cdsItens.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsItens.FieldByName('NUMLOT').AsString := FieldByName('NUMLOT').AsString;
        cdsItens.FieldByName('DESSIM').AsString := FieldByName('DESSIM').AsString;
        cdsItens.FieldByName('CLAFIS').AsString := FieldByName('CLAFIS').AsString;
        cdsItens.FieldByName('OPCSIM').AsString := IIF (blnDesSim , 'S', 'N');

        If blnDesSim And ((Not fEmptyStr(FieldByName('DESSIM').AsString)) or blnItemEspecial) Then
        Begin
          If (blnItemEspecial) Then
            cdsItens.FieldByName('DESITE').AsString := Copy(FieldByName('DESITE').AsString, 1, Pos(' ', FieldByName('DESITE').AsString))
          Else
            cdsItens.FieldByName('DESITE').AsString := FieldByName('DESSIM').AsString;
        End
        Else
          cdsItens.FieldByName('DESITE').AsString :=  FieldByName('DESITE').AsString;

        cdsItens.FieldByName('ITEDES').AsString :=  FieldByName('DESITE').AsString;
        cdsItens.FieldByName('MARDES').AsString := FieldByName('DESMAR').AsString;
        cdsItens.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;
        cdsItens.FieldByName('DRELIN').AsString := FieldByName('DRELIN').AsString;
        cdsItens.FieldByName('DESMAR').AsString := Copy(FieldByName('DESMAR').AsString, 5, Length(FieldByName('DESMAR').AsString));
        cdsItens.FieldByName('DEMARC').AsString := FieldByName('DESMAR').AsString;
        cdsItens.FieldByName('MARCA_').AsString := FieldByName('DESMAR').AsString;
        cdsItens.FieldByName('UNIDAD').AsString := FieldByName('UNIDAD').AsString;
        cdsItens.FieldByName('PROMOC').AsString := FieldByName('PROMOC').AsString;

        if (FieldByName('ENTFUT').AsString = 'S') and (FieldByName('MOTFUT').AsString = 'A') then
        begin
          cdsItens.FieldByName('ENTITE').AsString := EmptyStr;
        end
        else
        begin
          cdsItens.FieldByName('ENTITE').AsString := FieldByName('ENTITE').AsString;
        end;

        if ( FieldByName('ENTITE').AsString = '31/12/9999' ) then
        begin
          cdsItens.FieldByName('ENTRFU').AsString := EmptyStr;
        end
        else
        begin
          cdsItens.FieldByName('ENTRFU').AsString := FieldByName('ENTITE').AsString;
        end;

        cdsItens.FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat;
        cdsItens.FieldByName('QTDRES').AsFloat  := FieldByName('QTDRES').AsFloat;
        cdsItens.FieldByName('VALITE').AsFloat  := FieldByName('VALUNI').AsFloat;
        cdsItens.FieldByName('DESESP').AsFloat  := FieldByName('DESESP').AsFloat; // Valor do desconto especial rateado
        cdsItens.FieldByName('DESCON').AsFloat  := FieldByName('DESCON').AsFloat; // % ded esconto
        cdsItens.FieldByName('UNIORI').AsFloat  := FieldByName('UNIORI').AsFloat; // Valor unitário original
        cdsItens.FieldByName('UNIDIG').AsFloat  := FieldByName('UNIDIG').AsFloat;

        If (FieldByName('UNIORI').AsFloat > FieldByName('UNIDIG').AsFloat) Then
        Begin
          cdsItens.FieldByName('PRCUNI').AsFloat     := FieldByName('UNIORI').AsFloat;
          cdsItens.FieldByName('TOT_PRCUNI').AsFloat := FieldByName('UNIORI').AsFloat * FieldByName('QTDITE').AsFloat;
        End
        Else
        Begin
          cdsItens.FieldByName('PRCUNI').AsFloat     := FieldByName('UNIDIG').AsFloat;
          cdsItens.FieldByName('TOT_PRCUNI').AsFloat := FieldByName('UNIDIG').AsFloat * FieldByName('QTDITE').AsFloat;
        End;

        If (FieldByName('UNTARI').AsFloat > FieldByName('UNORIG').AsFloat) Then
          cdsItens.FieldByName('VLRBRU').AsFloat := FieldByName('UNTARI').AsFloat
        Else
          cdsItens.FieldByName('VLRBRU').AsFloat := FieldByName('UNORIG').AsFloat;

        If (FieldByName('UNORIG').AsFloat > FieldByName('UNTARI').AsFloat) Then
          cdsItens.FieldByName('DESTOT').AsFloat := FieldByName('UNORIG').AsFloat - FieldByName('UNTARI').AsFloat
        Else
          cdsItens.FieldByName('DESTOT').AsFloat := 0;

        If (FieldByName('UNIORI').AsFloat > FieldByName('UNIDIG').AsFloat) Then
          cdsItens.FieldByName('TOTADE').AsFloat := FieldByName('UNORIG').AsFloat - (FieldByName('UNIDIG').AsFloat *  FieldByName('QTDITE').AsFloat)
        Else
          cdsItens.FieldByName('TOTADE').AsFloat := 0;

        cdsItens.FieldByName('TOTORI').AsFloat  := FieldByName('UNIORI').AsFloat * FieldByName('QTDITE').AsFloat; // Valor total original
        cdsItens.FieldByName('TOTUNI').AsFloat  := FieldByName('VALUNI').AsFloat * FieldByName('QTDITE').AsFloat; // Valor total unitário
        cdsItens.FieldByName('DSCITE').AsFloat  := (FieldByName('UNIORI').AsFloat - FieldByName('VALUNI').AsFloat) * FieldByName('QTDITE').AsFloat; // Valor do desconto dado pelo %
        cdsItens.FieldByName('TOTITE').AsFloat  := FieldByName('VALITE').AsFloat; // Total líquido do item

        cdsItens.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
        cdsItens.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;

        fltQtdDoc := fRetornaQuantidadeItemDoc(FieldByName('NUMDOC').AsString, FieldByName('ESPDOC').AsString, FieldByName('CODEMP').AsString, FieldByName('CODITE').AsString);
        pBuscaInfSaldos(fltSaldos, fltCnvML, fltSalML, FieldByName('CODITE').AsString, FieldByName('CODEMP').AsString);

        if fltCnvML > 0 then
        begin
          fltSaldos := fltSaldos + fltSalML;
        end;

        objSalLoj := TSaldoLojas.Create(Self);
        objSalLoj.pCalculaSaldos(Nil,
                                 recSaldos, recSaldosML,
                                 fltSaldos, FieldByName('CODEMP').AsString, FieldByName('CODEMP').AsString,
                                 FieldByName('CODITE').AsString, fltCnvML,
                                 fCfgSis('ENTFUT', varBoolean), False, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));

        cdsItens.FieldByName('ESTOQU').AsString := IIF((recSaldos.fltSalDis - fltQtdDoc) > 0, 'S', 'N');
        cdsItens.FieldByName('TOTFRE').AsFloat  := FieldByName('TOTFRE').AsFloat;
        cdsItens.FieldByName('TOTRES').AsFloat  := FieldByName('VALUNI').AsFloat * FieldByName('QTDRES').AsFloat; // Total restante do item
        cdsItens.FieldByName('PESBRI').AsFloat  := FieldByName('PESBRI').AsFloat;
        cdsItens.FieldByName('LOCFIS').AsString := FieldByName('LOCFIS').AsString;
        cdsItens.FieldByName('CODAMZ').AsString := FieldByName('CODAMZ').AsString;
        cdsItens.FieldByName('NUMPED').AsString := FieldByName('NUMPED').AsString;

        cdsItens.FieldByName('MLTVEN').AsFloat  := FieldByName('MLTVEN').AsFloat;
        cdsItens.FieldByName('EMPITE').AsString := FieldByName('EMPITE').AsString;
        cdsItens.FieldByName('CODEMP').AsString := FieldByName('CODEMP').AsString;

        cdsItens.FieldByName('VALBRU').AsFloat  := FieldByName('VALBRU').AsFloat;
        cdsItens.FieldByName('TOTDES').AsFloat  := FieldByName('TOTDES').AsFloat;
        cdsItens.FieldByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
        cdsItens.FieldByName('TOTIPI').AsFloat  := FieldByName('TOTIPI').AsFloat;
        cdsItens.FieldByName('CLAIPI').AsString := FieldByName('CLAIPI').AsString;
        cdsItens.FieldByName('SIGDES').AsString := FieldByName('SIGDES').AsString;
        cdsItens.FieldByName('BASICM').AsFloat  := FieldByName('BASICM').AsFloat;
        cdsItens.FieldByName('ALQICM').AsFloat  := FieldByName('ALQICM').AsFloat;
        cdsItens.FieldByName('VALICM').AsFloat  := FieldByName('VALICM').AsFloat;
        cdsItens.FieldByName('ALQIPI').AsFloat  := FieldByName('ALQIPI').AsFloat;
        cdsItens.FieldByName('VALIPI').AsFloat  := FieldByName('VALIPI').AsFloat;
        cdsItens.FieldByName('CODFIS').AsString := FieldByName('CODFIS').AsString;
        cdsItens.FieldByName('ITEBRU').AsFloat  := FieldByName('ITEBRU').AsFloat;
        cdsItens.FieldByName('ITELIQ').AsFloat  := FieldByName('ITELIQ').AsFloat;
        cdsItens.FieldByName('CODREP').AsString := FieldByName('CODREP').AsString;
        cdsItens.FieldByName('NOMREP').AsString := FieldByName('NOMREP').AsString;
        cdsItens.FieldByName('NUMCMP').AsString := FieldByName('NUMCMP').AsString;

        if (not stlSeqAmb.Find(FieldByName('COMPLE').AsString, intIdx)) then
          stlSeqAmb.Add(FieldByName('COMPLE').AsString);

        cdsItens.FieldByName('COMORD').AsInteger := stlSeqAmb.IndexOf(FieldByName('COMPLE').AsString);
        cdsItens.FieldByName('DESNES').AsString  := FieldByName('DESNES').AsString;
        cdsItens.FieldByName('DESACE').AsFloat   := FieldByName('DESACE').AsFloat;
        cdsItens.FieldByName('CODNCM').AsString  := FieldByName('CODNCM').AsString;
        cdsItens.FieldByName('VALPRO').AsFloat   := IIF(FieldByName('UNIORI').AsFloat > FieldByName('VALUNI').AsFloat, FieldByName('UNIORI').AsFloat, FieldByName('VALUNI').AsFloat);

        cdsItens.FieldByName('ITEREQ').AsString  := IIF(fItemComRequisicaoEmAberto(cdsRelatorio.FieldByName('CODEMP').AsString, cdsRelatorio.FieldByName('CODITE').AsString) = True, 'S', 'N');
        cdsItens.FieldByName('LOCSEP').AsString  := FieldByName('LOCSEP').AsString;
        cdsItens.FieldByName('VALRET').AsFloat   := FieldByName('VALRET').AsFloat;
        cdsItens.FieldByName('ITEIMG').AsVariant := FieldByName('ITEIMG').AsVariant;
        cdsItens.FieldByName('ENTFUT').AsString  := FieldByName('ENTFUT').AsString;
        cdsItens.FieldByName('CORTPR').AsString  := IIF(Pos('CORTADOS',FieldByName('MEN001').AsString) > 0, 'Produtos com Pendências','');
        cdsItens.FieldByName('TITNAC').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00001', FieldByName('VALITE').AsFloat, 0);
        cdsItens.FieldByName('TITIMP').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00002', FieldByName('VALITE').AsFloat, 0);
        cdsItens.FieldByName('DESNAC').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00001', FieldByName('DESESP').AsFloat, 0);
        cdsItens.FieldByName('DESIMP').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00002', FieldByName('DESESP').AsFloat, 0);
        cdsItens.FieldByName('RETNAC').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00001', FieldByName('VALRET').AsFloat, 0);
        cdsItens.FieldByName('RETIMP').AsFloat   := IIF(FieldByName('PRDGRU').AsString = '00002', FieldByName('VALRET').AsFloat, 0);
        cdsItens.FieldByName('VALFCP').AsFloat   := FieldByName('VALFCP').AsFloat;
        cdsItens.FieldByName('TOTIMP').AsFloat   := cdsItens.FieldByName('VALITE').AsFloat + cdsItens.FieldByName('VALRET').AsFloat + cdsItens.FieldByName('VALIPI').AsFloat + cdsItens.FieldByName('VALFCP').AsFloat + FieldByName('VALREF').AsFloat;
        cdsItens.FieldByName('VDPORI').AsString  := FieldByName('VDPORI').asString;
        cdsItens.FieldByName('VDPDES').AsString  := FieldByName('VDPDES').asString;
        cdsItens.FieldByName('DTEITE').AsDateTime := FieldByName('DTEITE').AsDateTime;
        If fCfgSis('QUESAL') = 'S' Then
        Begin
          If FieldByName('SALDO').AsInteger <= 0 Then
          Begin
            cdsItens.Delete;
          End
          Else
            cdsItens.Post;
        End
        Else
          cdsItens.Post;
        Next;

      End;

      cdsItens.IndexFieldNames := strCampoOrdemItens;
    End;
  finally
    FreeAndNil(stlSeqAmb);
  end;
end;

procedure TfrmImpEspDefAmbiente.pPreencheServicos(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
var
  strPos: String;
  strSQL: String;
  intPos: Integer;
  qryServicos: TUniQuery;
begin
  qryServicos := Nil;
  Try
    Try
      qryServicos := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' SELECT    ';
      strSQL := strSQL + '   CODSER, ';
      strSQL := strSQL + '   DESSER, ';
      strSQL := strSQL + '   QTDSER, ';
      strSQL := strSQL + '   VALUNI, ';
      strSQL := strSQL + '   VALSER  ';
      strSQL := strSQL + ' FROM (    ';

      for intPos := 1 to 30 do
      begin
        strPos := fPadL(IntToStr(intPos), 2, '0');

        strSQL := strSQL + '   SELECT                                                ';
        if (intPos < 7) then
        begin
          strSQL := strSQL + '   FATGOR.FGO_CODS' + strPos + ' AS CODSER,            ';
          strSQL := strSQL + '   FATGOR.FGO_DESS' + strPos + ' AS DESSER,            ';
          strSQL := strSQL + '   FATGOR.FGO_VALS' + strPos + ' AS VALSER,            ';
        end
        else
        begin
          strSQL := strSQL + '   SERGOR.FGO_CODS' + strPos + ' AS CODSER,            ';
          strSQL := strSQL + '   SERGOR.FGO_DESS' + strPos + ' AS DESSER,            ';
          strSQL := strSQL + '   SERGOR.FGO_VALS' + strPos + ' AS VALSER,            ';
        end;
        strSQL := strSQL + '     SERGOR.FGO_QTDS' + strPos + ' AS QTDSER,            ';
        strSQL := strSQL + '     SERGOR.FGO_UNIS' + strPos + ' AS VALUNI             ';
        strSQL := strSQL + '   FROM FATGOR                                           ';
        strSQL := strSQL + '     LEFT JOIN SERGOR                                    ';
        strSQL := strSQL + '       ON FATGOR.AUTOINCREM = SERGOR.FGO_SEQFGO          ';
        strSQL := strSQL + '   WHERE TRUE                                            ';
        if (intPos < 7) then
          strSQL := strSQL + '   AND IFNULL(FATGOR.FGO_CODS' + strPos + ', "") <> "" '
        else
          strSQL := strSQL + '   AND IFNULL(SERGOR.FGO_CODS' + strPos + ', "") <> "" ';
        strSQL := strSQL + '     AND FATGOR.FGO_NUMDOC = :NUMDOC                     ';
        strSQL := strSQL + '     AND FATGOR.FGO_ESPDOC = :ESPDOC                     ';
        strSQL := strSQL + '     AND FATGOR.FGO_CODEMP = :CODEMP                     ';
        strSQL := strSQL + '     AND FATGOR.FGO_CODCLI = :CODCLI                     ';

        if (intPos < 30) then
          strSQL := strSQL + ' UNION ALL ';
      end;

      strSQL := strSQL + ' ) AS TAB ';

      if Pos(strEspDoc, 'NF_FF_IF_') > 0 then
      begin
        strSQL := AnsiReplaceStr(strSQL, 'FATGOR', 'MOVGER');
        strSQL := AnsiReplaceStr(strSQL, 'SERGOR', 'SERMOV');
        strSQL := AnsiReplaceStr(strSQL, 'SEQFGO', 'SEQGER');
        strSQL := AnsiReplaceStr(strSQL, 'FGO_', 'GER_');
      end;

      qryServicos.Close;
      qryServicos.SQL.Clear;
      qryServicos.SQL.Add(strSQL);
      qryServicos.ParamByName('NUMDOC').AsString := strNumDoc;
      qryServicos.ParamByName('ESPDOC').AsString := strEspDoc;
      qryServicos.ParamByName('CODEMP').AsString := strCodEmp;
      qryServicos.ParamByName('CODCLI').AsString := strCodCli;
      qryServicos.Open;

      if qryServicos.IsEmpty then
        Exit;

      cdsServicos.EmptyDataSet;

      while not qryServicos.Eof do
      begin
        cdsServicos.Append;
        cdsServicos.FieldByName('CODSER').AsString := qryServicos.FieldByName('CODSER').AsString;
        cdsServicos.FieldByName('DESSER').AsString := qryServicos.FieldByName('DESSER').AsString;
        cdsServicos.FieldByName('QTDSER').AsFloat  := qryServicos.FieldByName('QTDSER').AsFloat;
        cdsServicos.FieldByName('VALUNI').AsFloat  := qryServicos.FieldByName('VALUNI').AsFloat;
        cdsServicos.FieldByName('VALSER').AsFloat  := qryServicos.FieldByName('VALSER').AsFloat;
        cdsServicos.Post;

        qryServicos.Next;
      end;
    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryServicos);
        pMensagensErro(E.Message,'[TfrmImpEspDefAmbiente.pPreencheServicos]');
        Exit;
      End;
    End;

  Finally
    FreeAndNil(qryServicos);
  End;
end;

procedure TfrmImpEspDefAmbiente.pPreencheItensCortados(const strNumDoc,
  strEspDoc, strCodEmp, strCodCli: String);
var
  qryItensCortados: TUniQuery;
begin
  qryItensCortados := fCriaQuery;

  try
    qryItensCortados.Close;
    qryItensCortados.SQL.Clear;
    qryItensCortados.SQL.Add('SELECT D.VPD_CODITE, D.VPD_DESITE, C.ITE_REFERE, G.VPG_NUMDOC,');
    qryItensCortados.SQL.Add('       D.VPD_QTDITE, D.VPD_UNITAR, D.VPD_TOTITE');
    qryItensCortados.SQL.Add('FROM MOVVPG G');
    qryItensCortados.SQL.Add('INNER JOIN MOVVPD D');
    qryItensCortados.SQL.Add('ON(G.VPG_CODIGO = D.VPD_CODIGO)');
    qryItensCortados.SQL.Add('INNER JOIN CADITE C');
    qryItensCortados.SQL.Add('ON(D.VPD_CODITE = C.ITE_CODITE)');
    qryItensCortados.SQL.Add('WHERE G.VPG_CODEMP = :CODEMP');
    qryItensCortados.SQL.Add('AND G.VPG_ESPDOC = :ESPDOC');
    qryItensCortados.SQL.Add('AND G.VPG_NUMDOC = :NUMDOC');
    qryItensCortados.SQL.Add('AND G.VPG_CODCLI = :CODCLI');

    qryItensCortados.ParamByName('CODEMP').AsString := strCodEmp;
    qryItensCortados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItensCortados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItensCortados.ParamByName('CODCLI').AsString := strCodCli;

    qryItensCortados.Open;

    if qryItensCortados.IsEmpty then
      Exit;

    while not qryItensCortados.Eof do
    begin
      cdsItensCortados.Append;
      cdsItensCortados.FieldByName('CODITE').AsString := qryItensCortados.FieldByName('VPD_CODITE').AsString;
      cdsItensCortados.FieldByName('DESITE').AsString := qryItensCortados.FieldByName('VPD_DESITE').AsString;
      cdsItensCortados.FieldByName('REFERE').AsString := qryItensCortados.FieldByName('ITE_REFERE').AsString;
      cdsItensCortados.FieldByName('NUMDOC').AsString := qryItensCortados.FieldByName('VPG_NUMDOC').AsString;
      cdsItensCortados.FieldByName('QTDITE').AsFloat := qryItensCortados.FieldByName('VPD_QTDITE').AsFloat;
      cdsItensCortados.FieldByName('UNITAR').AsFloat := qryItensCortados.FieldByName('VPD_UNITAR').AsFloat;
      cdsItensCortados.FieldByName('TOTITE').AsFloat := qryItensCortados.FieldByName('VPD_TOTITE').AsFloat;
      cdsItensCortados.Post;

      qryItensCortados.Next;
    end;
  finally
    FreeAndNil(qryItensCortados);
  end;
end;

procedure TfrmImpEspDefAmbiente.pPreencheParcelas(cdsRelatorio: TZClient; strNumDoc: string);
var
  intContador,
  intQtdDup: integer;
  fltTotRes: Currency;
  qryNegociada: TUniQuery;
  arrDuplicata: TarrDuplicata;
begin
  pZeraDigDuplic(arrDuplicata);
  cdsParcelas.EmptyDataSet;

  if fStatusCndPag(cdsRelatorio.FieldByName('CONPAG').AsString) = A_VISTA then
  begin
    cdsParcelas.Append;
    cdsParcelas.FieldByName('PARCEL').AsString := 'A Vista';
    cdsParcelas.FieldByName('DTAPAR').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAENT').AsDateTime);
    cdsParcelas.FieldByName('VALPAR').AsFloat  := cdsRelatorio.FieldByName('VLRCON').AsFloat;
    cdsParcelas.FieldByName('CODFPG').AsString := cdsRelatorio.FieldByName('CODFPG').AsString;

    cdsParcelas.FieldByName('VLRPRC').AsFloat  := (cdsRelatorio.FieldByName('VALBRU').AsFloat + cdsRelatorio.FieldByName('TOTFRE').AsFloat);
    cdsParcelas.Post;
  end
  else
  begin
    if cdsRelatorio.FieldByName('CODFPG').AsString = '009' then  // FORMA DE PAGAMENTO NEGOCIADA
    begin
      qryNegociada := fCriaQuery;
      try
        qryNegociada.Close;
        qryNegociada.SQL.Clear;
        qryNegociada.SQL.Add('SELECT C.FPG_DESCRI, F.FPN_VALFPG, F.FPN_QTDPAR');
        qryNegociada.SQL.Add('FROM FPGNEG F');
        qryNegociada.SQL.Add('INNER JOIN CADFPG C');
        qryNegociada.SQL.Add('ON(F.FPN_CODFPG = C.FPG_CODIGO)');
        qryNegociada.SQL.Add('WHERE F.FPN_SEQFGO = :SEQFGO');

        qryNegociada.ParamByName('SEQFGO').AsString := cdsRelatorio.FieldByName('CAP_AUTOINC').AsString;

        qryNegociada.Open;

        if not qryNegociada.IsEmpty then
        begin
          qryNegociada.First;
          while not qryNegociada.Eof do
          begin
            cdsParcelas.Append;
            cdsParcelas.FieldByName('PARCEL').AsString := IIF(qryNegociada.FieldByName('FPN_QTDPAR').AsInteger = 0, '1', qryNegociada.FieldByName('FPN_QTDPAR').AsString);
            cdsParcelas.FieldByName('DTAPAR').AsString := qryNegociada.FieldByName('FPG_DESCRI').AsString;
            cdsParcelas.FieldByName('VALPAR').AsFloat  := qryNegociada.FieldByName('FPN_VALFPG').AsFloat;
            cdsParcelas.FieldByName('CODFPG').AsString := cdsRelatorio.FieldByName('CODFPG').AsString;

            cdsParcelas.FieldByName('VLRPRC').AsFloat  := qryNegociada.FieldByName('FPN_VALFPG').AsFloat;
            cdsParcelas.Post;
            qryNegociada.Next;
          end;
        end;
      finally
        FreeAndNil(qryNegociada);
      end;
    end
    else
    begin
      fDigDuplicSemTela(arrDuplicata,
                        intQtdDup,
                        fltTotRes,
                        cdsRelatorio.FieldByName('CONPAG').AsString,
                        123,
                        cdsRelatorio.FieldByName('VLRCON').AsFloat,
                        False,
                        False,
                        cdsRelatorio.FieldByName('PREVIS').AsDateTime,
                        False);

      for intContador := 1 to 12 do
      begin
        if cdsRelatorio.FieldByName('VPAR' + fStrZero(intContador, 2)).AsFloat > 0 then
        begin
          cdsParcelas.Append;
          cdsParcelas.FieldByName('PARCEL').AsString := IntToStr(intContador);
          cdsParcelas.FieldByName('DTAPAR').AsString := arrDuplicata[intContador - 1].dtaDtaVen;
          cdsParcelas.FieldByName('VALPAR').AsFloat  := cdsRelatorio.FieldByName('VPAR' + fStrZero(intContador, 2)).AsFloat;
          cdsParcelas.FieldByName('CODFPG').AsString := cdsRelatorio.FieldByName('CODFPG').AsString;

          cdsParcelas.FieldByName('VLRPRC').AsFloat  := cdsRelatorio.FieldByName('VPAR' + fStrZero(intContador, 2)).AsFloat;
          cdsParcelas.Post;
        end;
      end;
    end;
  end;

  pMontaDuplicatas;

end;

procedure TfrmImpEspDefAmbiente.pPreencheResumo(cdsRelatorio: TZClient);
var
  strAmbiente: String;
  fltQtdIte: Double;
  fltValIte: Double;
  fltTotIte: Double;
begin

  fltQtdIte := 0;
  fltValIte := 0;
  fltTotIte := 0;

  cdsRelatorio.First;

  while not cdsRelatorio.Eof do
  begin

    strAmbiente := cdsRelatorio.FieldByName('COMPLE').AsString;
    fltQtdIte   := fltQtdIte + cdsRelatorio.FieldByName('QTDITE').AsFloat;
    fltValIte   := fltValIte + cdsRelatorio.FieldByName('VALITE').AsFloat;
    fltTotIte   := fltTotIte + cdsRelatorio.FieldByName('TOTITE').AsFloat;
    cdsRelatorio.Next;

    if Not (strAmbiente = cdsRelatorio.FieldByName('COMPLE').AsString) then
    begin

      cdsResumo.Append;
      cdsResumo.FieldByName('AMBIEN').AsString := strAmbiente;
      cdsResumo.FieldByName('QTDAMB').AsFloat  := fltQtdIte;
      cdsResumo.FieldByName('UNIAMB').AsFloat  := fltValIte;
      cdsResumo.FieldByName('TOTAMB').AsFloat  := fltTotIte;
      cdsResumo.Post;

      fltQtdIte := 0;
      fltValIte := 0;
      fltTotIte := 0;

    end;
  end;

end;

procedure TfrmImpEspDefAmbiente.pPreencheRodape(cdsRelatorio : TZClient);
begin

  inherited;

  With cdsRodape Do
  Begin
    Append;
    If fCfgSis('IFVLOR', varBoolean) Then
    Begin
      FieldByName('DTAVAL').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('VALORC').AsDateTime);

      If cdsRelatorio.FieldByName('ESPDOC').AsString = 'OR' Then
        FieldByName('VLORCA').AsString := cdsRelatorio.FieldByName('QTDDIA').AsString;
    End
    Else
    Begin
      FieldByName('DTAVAL').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAENT').AsDateTime + fCfgSis('ORCVEN', varInteger));
      FieldByName('VLORCA').AsString := fCfgSis('ORCVEN', varInteger);
    End;

    FieldByName('DTENTR').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTENTR').AsDateTime);
    FieldByName('DESFPG').AsString := fRetDesFpg(cdsRelatorio.FieldByName('CODFPG').AsString);
    FieldByName('DESCPG').AsString := cdsRelatorio.FieldByName('DESCND').AsString;
    FieldByName('DTAPRE').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('PREVIS').AsDateTime);
    FieldByName('ENDENT').AsString  := Self.strEndEnt;
    FieldByName('ENDENT_').AsString := Self.strEndEnt_;
    FieldByName('ENDENT2').AsString := Self.strEndEnt2;
    FieldByName('MEN001').AsString := cdsRelatorio.FieldByName('MEN001').AsString;
    FieldByName('MEN002').AsString := cdsRelatorio.FieldByName('MEN002').AsString;
    FieldByName('MEN003').AsString := cdsRelatorio.FieldByName('MEN003').AsString;
    FieldByName('MEN004').AsString := cdsRelatorio.FieldByName('MEN004').AsString;
    FieldByName('NOMPRO').AsString := IIF(Not fEmptyStr(cdsRelatorio.FieldByName('CODVEN').AsString), cdsRelatorio.FieldByName('CODVEN').AsString + ' - ' + fRetNomVendRep(cdsRelatorio.FieldByName('CODVEN').AsString), '') +
                                      IIF(Not fEmptyStr(cdsRelatorio.FieldByName('CODVE2').AsString), ' / ' + cdsRelatorio.FieldByName('CODVE2').AsString + ' - ' + fRetNomVendRep(cdsRelatorio.FieldByName('CODVE2').AsString), '');
    FieldByName('NOMDIG').AsString := IIF(Not fEmptyStr(cdsRelatorio.FieldByName('CODDIG').AsString), cdsRelatorio.FieldByName('CODDIG').AsString + ' - ' + fRetNomVendRep(cdsRelatorio.FieldByName('CODDIG').AsString), '');
    FieldByName('TOTFRE').AsFloat  := cdsRelatorio.FieldByName('TOTFRE').AsFloat;
    FieldByName('PESBRT').AsFloat  := cdsRelatorio.FieldByName('PESBRT').AsFloat;
    FieldByName('PESLIQ').AsFloat  := cdsRelatorio.FieldByName('PESLIQ').AsFloat;
    FieldByName('VOLUME').AsFloat  := cdsRelatorio.FieldByName('VOLUME').AsFloat;

    FieldByName('DTAIMP').AsString := FormatDateTime('dd/mm/yyyy', fRetDataServidor);
    FieldByName('HORIMP').AsString := FormatDateTime('hh:nn:ss', fRetHoraServidor);

    If cdsRelatorio.FieldByName('ESPDOC').AsString = 'OR' Then
      FieldByName('MENDOC').AsString := fCfgSis('MSGORC');

    If cdsRelatorio.FieldByName('ESPDOC').AsString = 'PD' Then
      FieldByName('MENDOC').AsString := fCfgSis('MSGPED');

    FieldByName('TELENT').AsString := cdsRelatorio.FieldByName('TELENT_').AsString;
    FieldByName('CONENT').AsString := cdsRelatorio.FieldByName('CONENT_').AsString;
    FieldByName('DESESG').AsFloat  := cdsRelatorio.FieldByName('DESESG').AsFloat;

    FieldByName('ENTFUT').AsString := cdsRelatorio.FieldByName('ENTFUT').AsString;
    FieldByName('TOTRET').AsFloat  := cdsRelatorio.FieldByName('TOTRET').AsFloat;
    FieldByName('TOTSER').AsFloat  := cdsRelatorio.FieldByName('TOTSER').AsFloat;

    FieldByName('DESFRE').AsString := cdsRelatorio.FieldByName('DESFRE').AsString;
    FieldByName('CODTRA').AsString := cdsRelatorio.FieldByName('CODTRA').AsString;
    FieldByName('NOMTRA').AsString := cdsRelatorio.FieldByName('NOMTRA').AsString;
    FieldByName('ENDTRA').AsString := cdsRelatorio.FieldByName('ENDTRA').AsString;
    FieldByName('BAITRA').AsString := cdsRelatorio.FieldByName('BAITRA').AsString;
    FieldByName('CEPTRA').AsString := fFormataCEP(cdsRelatorio.FieldByName('CEPTRA').AsString);
    FieldByName('FONTRA').AsString := fFormataFone(cdsRelatorio.FieldByName('FONTRA').AsString);
    FieldByName('CIDTRA').AsString := fRetNomCidade(cdsRelatorio.FieldByName('CIDTRA').AsString, 0);
    FieldByName('UF_TRA').AsString := fRetNomCidade(cdsRelatorio.FieldByName('CIDTRA').AsString, 1);

    FieldByName('NOMCTT').AsString := cdsRelatorio.FieldByName('NOMCTT').AsString;
    FieldByName('CELCTT').AsString := cdsRelatorio.FieldByName('CELCTT').AsString;
    FieldByName('EMACTT').AsString := cdsRelatorio.FieldByName('EMACTT').AsString;
    FieldByName('PORDES').AsFloat  := cdsRelatorio.FieldByName('PORDES').AsFloat;
    FieldByName('VLRCON').AsFloat  := cdsRelatorio.FieldByName('VLRCON').AsFloat;
    FieldByName('TOTFCP').AsFloat  := cdsRelatorio.FieldByName('TOTFCP').AsFloat;
    FieldByName('DESACE').AsFloat  := cdsRelatorio.FieldByName('DESACE').AsFloat;
    FieldByName('CODCND').AsString := cdsRelatorio.FieldByName('CODCND').AsString;
    FieldByName('CODFPG').AsString := cdsRelatorio.FieldByName('CODFPG').AsString;
    FieldByName('LEGIPI').AsString := FLegIPI;
    FieldByName('TOTIPI').AsFloat  := cdsRelatorio.FieldByName('TOTIPI').AsFloat;
    FieldByName('BASICM').AsFloat  := cdsRelatorio.FieldByName('BASICM').AsFloat;
    FieldByName('TOTICM').AsFloat  := cdsRelatorio.FieldByName('TOTICM').AsFloat;
    FieldByName('BASRET').AsFloat  := cdsRelatorio.FieldByName('BASRET').AsFloat;
    FieldByName('REGIAO').AsString := cdsRelatorio.FieldByName('REGIAO').AsString;
    FieldByName('TOTPRO').AsString := cdsRelatorio.FieldByName('TOTPRO').AsString;

    If cdsRelatorio.FieldByName('ESPDOC').AsString = 'FF' Then
    Begin
      FieldByName('IMGASS').AsString := cdsRelatorio.FieldByName('IMGASS').AsString;
      FieldByName('NOMASS').AsString := cdsRelatorio.FieldByName('NOMASS').AsString;
    End;

    FieldByName('TPADES').AsString := cdsRelatorio.FieldByName('TPADES').AsString;
    FieldByName('ORIORC').AsString := cdsRelatorio.FieldByName('ORIORC').AsString;
    FieldByName('DTAORC').AsString := FormatDateTime('dd/mm/yyyy', cdsRelatorio.FieldByName('DTAORC').AsDateTime);
    FieldByName('VALEXT').AsString := fValorPorExtenso(cdsRelatorio.FieldByName('VLRCON').asString);
    FieldByName('PRIVEN').AsString := cdsRelatorio.FieldByName('PRIVEN').asString;
    FieldByName('TDPORI').AsFloat  := FTotalDifal;
    FieldByName('DTCTAT').AsDateTime := cdsRelatorio.FieldByName('DTCTAT').AsDateTime;
    FieldByName('VLCTAT').AsFloat := cdsRelatorio.FieldByName('VLCTAT').AsFloat;
    FieldByName('DTCTVN').AsDateTime := cdsRelatorio.FieldByName('DTCTVN').AsDateTime;
    FieldByName('VLCTVN').AsFloat := cdsRelatorio.FieldByName('VLCTVN').AsFloat;

    Post;
  End;

end;

procedure TfrmImpEspDefAmbiente.pMontaDuplicatas;
var
  strDuplic: string;
  strDupAlf: String;
begin
  strDuplic := EmptyStr;
  strDupAlf := EmptyStr;

  if not cdsParcelas.isEmpty then
  begin
    cdsParcelas.First;
    while not cdsParcelas.Eof do
    begin
      strDuplic := strDuplic +
                   cdsParcelas.FieldByName('PARCEL').AsString + ') ' +
                   cdsParcelas.FieldByName('DTAPAR').AsString + ' ' +
                   fstrEspaco(FloatToStrF(cdsParcelas.FieldByName('VALPAR').AsFloat, ffNumber, 15, 2), 12, 2)+ ' ';

      strDupAlf := strDupAlf +
                   fGetLetraAlfa(StrToIntDef(cdsParcelas.FieldByName('PARCEL').AsString,1)) + ') ' +
                   cdsParcelas.FieldByName('DTAPAR').AsString + ' ' +
                   fstrEspaco(FloatToStrF(cdsParcelas.FieldByName('VALPAR').AsFloat, ffNumber, 15, 2), 12, 2)+ ' ';

      cdsParcelas.Next;
    end;
    cdsRodape.Edit;
    cdsRodape.FieldByName('DUPLIC').asString := strDuplic;
    cdsRodape.FieldByName('DUPALF').asString := strDupAlf;
    cdsRodape.Post;
  end;

end;

procedure TfrmImpEspDefAmbiente.pMontaListaClassificacao;
   Var
     intCount: Integer;
     stlClaIpi: TStringList;
Begin
  stlClaIpi := TStringList.Create;

  try
    stlClaIpi.Sorted := True;
    stlClaIpi.Duplicates := dupIgnore;

    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        If Not fEmptyStr(FieldByName('CLAIPI').AsString) Then
          stlClaIpi.Add(FieldByName('CLAIPI').AsString);

        Next;
      End;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('LEGEND').AsString := IfThen(stlClaIpi.IndexOf(FieldByName('CLAIPI').AsString) >= 0, fGetLetraAlfa(stlClaIpi.IndexOf(FieldByName('CLAIPI').AsString) + 1), '');
        Post;
        Next;
      End;

      First;
    End;

    FLegIPI := '';
    For intCount := 1 To stlClaIpi.Count Do
    Begin
      FLegIPI := FLegIPI + ' ' + fGetLetraAlfa(intCount) + ': ' + stlClaIpi[intCount - 1];
    End;
  finally
    FreeAndNil(stlClaIpi);
  end;
end;

class function TfrmImpEspDefAmbiente.fUtilizaImagemOtimizada: Boolean;
begin
  Result := (VS_SpoolImpressaoCitel) and (fCfgSis('SPOOTM', VarBoolean));
end;

procedure TfrmImpEspDefAmbiente.pOtimizaImagensProduto(strNumdoc, strEspdoc,
  strCodemp, strCodCli: String);
var
  qryAux: TUniQuery;
  strBase64, strAutInc: String;
begin
  try
    qryAux := fCriaQuery;

    if (Pos(strEspDoc, '_OR_PD_') > 0) Then
    Begin
      qryAux.SQL.Text := '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM FATDOR ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = FATDOR.FDO_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND FDO_NUMDOC = :NUMDOC ' +
                         '   AND FDO_ESPDOC = :ESPDOC ' +
                         '   AND FDO_CODEMP = :CODEMP ' +
                         '   AND FDO_CODCLI = :CODCLI ';
    End
    Else if (Pos(strEspDoc, '_NF_FF_IF_') > 0) Then
    Begin
      qryAux.SQL.Text := '  SELECT * FROM ( ' +
                         '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM MOVDET ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = MOVDET.DET_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND DET_NUMDOC = :NUMDOC ' +
                         '   AND DET_ESPDOC = :ESPDOC ' +
                         '   AND DET_CODEMP = :CODEMP ' +
                         '   AND DET_CODCLI = :CODCLI ' +
                         ' ' +
                         ' UNION ALL ' +
                         ' ' +
                         '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM NOTDET ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = NOTDET.DET_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND DET_NUMDOC = :NUMDOC ' +
                         '   AND DET_ESPDOC = :ESPDOC ' +
                         '   AND DET_CODEMP = :CODEMP ' +
                         '   AND DET_CODCLI = :CODCLI ) AS ITE ';
    End;

    If (qryAux.SQL.Text = '') Then
      Exit;

    qryAux.ParamByName('NUMDOC').AsString := strNumdoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspdoc;
    qryAux.ParamByName('CODEMP').AsString := strCodemp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.Open;
    while not qryAux.Eof do
    Begin
      strBase64 := qryAux.FieldByName('ITE_IMGB64').AsString;
      fOtimizaImagemTam(strBase64, 150);
      strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;

      pGravarThumbItemSPO(strBase64, strAutInc);
      qryAux.Next;
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

end.
