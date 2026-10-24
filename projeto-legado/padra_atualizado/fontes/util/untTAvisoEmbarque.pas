unit untTAvisoEmbarque;

interface

uses Classes, SysUtils, StrUtils, Uni, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

Type
  TAvisoEmbarque = class
  {$M+}
  private
    FCodEmp,                                                                     
    FNumDoc,                                                                     
    FEspDoc,                                                                     
    FCodCli,                                                                     
    FTabGer,                                                                     
    FTabAux,
    FTabDet,
    FTabTri: String;

    FQtdReg: Integer;

    FArquivo: TStringList;
    qryDoc,
    qryItem: TUniQuery;

    procedure pSetCodEmp(const Value: String);
    procedure pSetNumDoc(const Value: String);
    procedure pSetEspDoc(const Value: String);
    procedure pSetCodCli(const Value: String);
    procedure pSetTabGer(const Value: String);

    // Funções do layout
    function f_ITP: String;
    function f_AE1: String;
    function f_NF2: String;
    function f_AE2: String;
    function f_AE4: String;
    function f_FTP: String;

    function fFormatQtd(flt: Double; intTam: Integer): String;
    function fFormatVal(flt: Double; intTam: Integer; intDec: Integer = 2): String;

    procedure pSetarGerado(strAutInc: String = '');
    
  public
    constructor Create;
    destructor Destroy; override;
    procedure Inicializar;

    procedure pGerarArquivo(strPath: String);
    procedure pGerarXmlB2B(strPath: String; strAutInc: String);

  published
    property strCodEmp: String Read FCodEmp Write pSetCodEmp;
    property strNumDoc: String Read FNumDoc Write pSetNumDoc;
    property strEspDoc: String Read FEspDoc Write pSetEspDoc;
    property strCodCli: String Read FCodCli Write pSetCodCli;
    property strTabGer: String Write pSetTabGer;
  End;

implementation

uses untFuncoesSimples, untSQLRepositorio, Data.DB;

{ TAvisoEmbarque }

constructor TAvisoEmbarque.Create;
begin
  FArquivo := TStringList.Create;
  qryDoc := fCriaQuery;
  qryItem := fCriaQuery;

  Inicializar;
end;

destructor TAvisoEmbarque.Destroy;
begin
  FArquivo.Free;
  qryDoc.Free;
  qryItem.Free;
  inherited;
end;

procedure TAvisoEmbarque.Inicializar;
begin
  FCodEmp := '';
  FNumDoc := '';
  FEspDoc := '';
  FCodCli := '';
  FTabGer := '';
  FTabAux := '';
  FQtdReg := 0;

  FArquivo.Clear;
  
  qryDoc.Close;
  qryDoc.SQL.Clear;
  qryItem.Close;
  qryItem.SQL.Clear;
end;

procedure TAvisoEmbarque.pSetarGerado(strAutInc: String = '');
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;
  Try
    qryUpd.SQL.Add('UPDATE '+ FTabAux);
    qryUpd.SQL.Add('   SET AUX_GERAVE = "S"');
    qryUpd.SQL.Add(' WHERE AUX_SEQGER = :AUTINC');

    if fEmptyStr(strAutInc) then
      qryUpd.ParamByName('AUTINC').AsString := qryDoc.FieldByName('AUTINC').AsString
    else
      qryUpd.ParamByName('AUTINC').AsString := strAutInc;

    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;              
end;

procedure TAvisoEmbarque.pSetCodCli(const Value: String);
begin
  FCodCli := Value;
end;

procedure TAvisoEmbarque.pSetCodEmp(const Value: String);
begin
  FCodEmp := Value;
end;

procedure TAvisoEmbarque.pSetEspDoc(const Value: String);
begin
  FEspDoc := Value;
end;

procedure TAvisoEmbarque.pSetNumDoc(const Value: String);
begin
  FNumDoc := Value;
end;

procedure TAvisoEmbarque.pSetTabGer(const Value: String);
begin
  FTabGer := Value;

  If FTabGer = 'MOVGER' Then
  Begin
    FTabAux := 'AUXMOV';
    FTabDet := 'MOVDET';
    FTabTri := 'MOVTRI';
  End

  Else If FTabGer = 'NOTGER' Then
  Begin
    FTabAux := 'AUXNOT';
    FTabDet := 'NOTDET';
    FTabTri := 'NOTTRI';
  End

  Else
    Raise Exception.Create('Tabela '+ FTabGer + ' inexperada!');
end;

function TAvisoEmbarque.fFormatQtd(flt: Double; intTam: Integer): String;
begin
  Result := FormatFloat('0.'+ StringOfChar('0', fCfgSis('DECQTD', varInteger)), flt);
  
  Result := fStrZero(fTiraCaracEspeciais(Result, True, True, True), intTam);
  Result := RightStr(Result, intTam);
end;

function TAvisoEmbarque.fFormatVal(flt: Double; intTam: Integer; intDec: Integer = 2): String;
begin
  Result := FormatFloat('0.' + StringOfChar('0', intDec), flt);

  Result := fStrZero(fTiraCaracEspeciais(Result, True, True, True), intTam);
  Result := RightStr(Result , intTam);
end;

function TAvisoEmbarque.f_AE1: String;
  procedure pAdd(str: String; intTam: Integer = 0);
  begin
    If intTam > 0 Then
      str := fPadR(str, intTam);
      
    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('AE1');

  //6 [4..9] NUMERO NF ORIGEM
  pAdd(fPadL(qryDoc.FieldByName('NUMDOC').AsString, 6));

  //4 [10..13] SERIE DA NOTA FISCAL ORIGEM
  pAdd(qryDoc.FieldByName('SERIE').AsString, 4);

  //6 [14..19] DATA DA NOTA FISCAL
  pAdd(FormatDateTime('yymmdd', qryDoc.FieldByName('DTAENT').AsDateTime));

  //3 [20..22] QUANT. ITENS POR NOTA FISCAL
  pAdd(fStrZero(qryDoc.FieldByName('QTDITE').AsString, 3));

  //17 [23..39] VALOR TOTAL NOTA FISCAL
  pAdd(fFormatVal(qryDoc.FieldByName('VLRCON').AsFloat, 17));

  //1 [40..40] QUANT. DE CASAS DECIMAIS
  pAdd(fCfgSis('DECQTD'), 1);

  //5 [41..45] COD. FISCAL OPERACAO (CFOP)
  pAdd(fStrZero(qryDoc.FieldByName('CLAFIS').AsString, 5), 5);

  //17 [46..62] VALOR TOTAL DO ICMS APLICADO
  pAdd(fFormatVal(qryDoc.FieldByName('TOTICM').AsFloat, 17));

  //6 [63..68] DATA DE VENCIMENTO DO DOCTO.
  pAdd(FormatDateTime('yymmdd', IIF(qryDoc.FieldByName('DTAVEN').AsDateTime = 0, VS_Date, qryDoc.FieldByName('DTAVEN').AsDateTime)), 6);

  //2 [69..70] ESPECIE DA NOTA FISCAL
  pAdd('02', 2);

  //17 [71..87] VALOR TOTAL DO IPI APLICADO
  pAdd(fFormatVal(qryDoc.FieldByName('TOTIPI').AsFloat, 17));

  //3 [88..90] COD. FABRICA DE DESTINO
  pAdd(qryDoc.FieldByName('FABDES').AsString, 3);

  //6 [91..96] DATA PREVISAO ENTREGA N.FISCAL
  pAdd('', 6);

  //4 [97..100] PERIODO DE ENTREGA/EMBARQUE
  pAdd('', 4);

  //15 [101..115] DESCRICAO DA NATUREZA OPERACAO
  pAdd(qryDoc.FieldByName('NATOPE').AsString, 15);

  //6 [116..121] DATA DE EMBARQUE DA MERCADORIA
  pAdd('', 6);

  //4 [122..125] HORA DO EMBARQUE DA MERCADORIA
  pAdd('', 4);

  //3 [126..128] ESPAÇO
  pAdd('', 3);

end;

function TAvisoEmbarque.f_AE2: String;
  procedure pAdd(str: String; intTam: Integer = 0);
  begin
    If intTam > 0 Then
      str := fPadR(str, intTam);
      
    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('AE2');

  //3 [4..6] NUM. DO ITEM NA NOTA FISCAL
  pAdd(fStrZero(IntToStr(qryItem.RecNo), 3));

  //12 [7..18] NUMERO DO PEDIDO DE COMPRA
  pAdd(qryItem.FieldByName('NUMCMP').AsString, 12);

  //30 [19..48] CODIGO DO ITEM
  If fCfgSis('CLIPRO', varBoolean) Then
    pAdd(qryItem.FieldByName('CODITE').AsString, 30)
  Else
    pAdd(qryItem.FieldByName('NUMPLA').AsString + ' ' + qryItem.FieldByName('PARNUM').AsString, 30);

  //9 [49..57] QUANT. ITEM NA NOTA FISCAL
  pAdd(fFormatQtd((qryItem.FieldByName('QTDITE').AsFloat), 9));

  //2 [58..59] UNIDADE MEDIDA N.F.
  pAdd(qryItem.FieldByName('SIGUNI').AsString, 2);

  //10 [60..69] COD. CLASSIFICACAO FISCAL
  pAdd('00' + RightStr(qryItem.FieldByName('CLAIPI').AsString, 8), 10);

  //4 [70..73] ALIQUOTA DO IPI
  pAdd(fFormatVal(qryItem.FieldByName('ALQIPI').AsFloat, 4));

  //12 [74..85] VALOR UNITARIO DO ITEM
  pAdd(fFormatVal(qryItem.FieldByName('UNITAR').AsFloat, 12, 5));

  //9 [86..94] QUANT. DO ITEM UNIDADE ESTOQUE
  pAdd(fFormatQtd(qryItem.FieldByName('QTDITE').AsFloat, 9));

  //2 [95..96] UNIDADE MEDIDA ESTOQUE
  pAdd(qryItem.FieldByName('SIGUNI').AsString, 2);

  //9 [97..105] QUANT. UNIDADE COMPRA
  pAdd(fFormatQtd(qryItem.FieldByName('QTDITE').AsFloat, 9));

  //2 [106..107] UNID. MEDIDA COMPRAS
  pAdd(qryItem.FieldByName('SIGUNI').AsString, 2);

  //1 [108..108] COD. TIPO DE FORNECIMENTO
  pAdd('', 1);

  //4 [109..112] QUANT. PERCENTUAL DESCONTO
  pAdd(fStrZero(qryItem.FieldByName('NITCMP').AsInteger, 4));

  //11 [113..123] VALOR TOTAL DESCONTO ITEM  [P * QTD * FC (IPI/100+1) * PD/100]
  pAdd(fStrZero('0', 11));

  //4 [124..127] ALTERACAO TECNICA DO ITEM
  pAdd('', 4);

  //1 [128..128] ESPACO
  pAdd('', 1);

end;

function TAvisoEmbarque.f_AE4: String;
  procedure pAdd(str: String; intTam: Integer = 0);
  begin
    If intTam > 0 Then
      str := fPadR(str, intTam);

    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('AE4');

  //4 [4..7] ALIQUOTA DE IMCS
  pAdd(fFormatQtd(qryItem.FieldByName('ALQICM').AsFloat, 4));

  //17 [8..24] BASE DE CALCULO ICMS
  pAdd(fFormatVal(qryItem.FieldByName('BASICM').AsFloat, 17));

  //17 [25..41] VALOR DO ICMS APLICADO
  pAdd(fFormatVal(qryItem.FieldByName('VALICM').AsFloat, 17));

  //17 [42..58] VALOR DO IPI APLICADO
  pAdd(fFormatVal(qryItem.FieldByName('VALIPI').AsFloat, 17));

  //2 [59..60] CODIGO DE SITUACAO TRIBUTARIA
  pAdd(RightStr(qryItem.FieldByName('CODFIS').AsString, 2), 2);

  //30 [61..90] NUMERO DO DESENHO DO ITEM
  pAdd('', 30);

  //6 [91..96] DATA DE VALIDADE DO DESENHO
  pAdd('', 6);

  //13 [97..109] PEDIDO DA REVENDA
  pAdd('', 13);

  //5 [110..114] PESO LIQUIDO DO ITEM
  pAdd(fFormatVal(qryItem.FieldByName('PESLIQ').AsFloat, 5));

  //1 [115..115] MULTIPLICADOR DE PRECO UNIT.
  pAdd('', 1);

  //12 [116.127] PRECO TOTAL DA MERCADORIA
  pAdd(fFormatVal(qryItem.FieldByName('TOTITE').AsFloat, 12));

  //1 [128.128] SITUACAO TRIBUTARIA FEDERAL
  pAdd('', 1);

end;

function TAvisoEmbarque.f_FTP: String;
  procedure pAdd(str: String; intTam: Integer = 0);
  begin
    If intTam > 0 Then
      str := fPadR(str, intTam);

    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('FTP');

  //5 [4..8] NUMERO DE CONTROLE TRANSMISSAO
  pAdd(fPadL(fRetSequencial('AVENCO'), 5));

  //9 [9..17] QUANT. REGISTROS NA TRANSACAO
  pAdd(fStrZero(FQtdReg, 9));

  //17 [18..34] NUMERO TOTAL DE VALORES
  pAdd(fStrZero('', 17));

  //1 [35..35] CATEGORIA DA OPERACAO
  pAdd('', 1);

  //93 [36..128]
  pAdd('', 93);

end;

function TAvisoEmbarque.f_ITP: String;
  procedure pAdd(str: String);
  begin
    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('ITP');

  //3 [4..6] IDENTIFICAO DO PROCESSO
  pAdd(fPadR(fCfgSis('AVEIDP'), 3));

  //2 [7..8] NUMERO DA VERSAO DA TRANSACAO
  pAdd(fPadR(fCfgSis('AVENVT'), 2));

  //5 [9..13] NUMERO DE CONTROLE TRANSMISSAO
  pAdd(fPadL(fRetSequencial('AVENCO'), 5));

  //12 [14..25] IDENT. GERACAO DO MOVIMENTO
  pAdd(FormatDateTime('yymmddhhnnss', VS_Date + fTime()));

  //14 [26..39] IDENT. TRANSMISSOR NA COMUNIC.
  pAdd(fStrZero(fTiraCaracEspeciais(qryDoc.FieldByName('EMPCGC').AsString, True, True, True), 14));

  //14 [40..53] IDENT. RECEPTOR NA COMUNIC.
  pAdd(fStrZero(fTiraCaracEspeciais(qryDoc.FieldByName('CLICGC').AsString, True, True, True), 14));

  //8 [54..61] CODIGO INTERNO DO TRANSMISSOR
  pAdd(fPadR(fCfgSis('AVECIT'), 8));

  //8 [62..69] CODIGO INTERNO DO RECEPTOR
  pAdd(qryDoc.FieldByName('CODCLI').AsString);

  //25 [70..94] NOME DO TRANSMISSOR
  pAdd(fPadR(fCfgSis('AVENDT'), 25));

  //25 [95..119] NOME DO RECEPTOR
  pAdd(fPadR(qryDoc.FieldByName('NOMCLI').AsString, 25));

  //9 [120..128] ESPAÇO
  pAdd(fPadR('', 9));

end;

function TAvisoEmbarque.f_NF2: String;
  procedure pAdd(str: String; intTam: Integer = 0);
  begin
    If intTam > 0 Then
      str := fPadR(str, intTam);
      
    Result := Result + str;
  end;
begin
  Inc(FQtdReg);

  Result := '';

  //3 [1..3] IDENT. DO TIPO DE REGISTRO
  pAdd('NF2');

  //12 [4..15] VALOR DESPESAS ACESSORIAS
  pAdd(fFormatVal(qryDoc.FieldByName('DESACE').AsFloat, 12));

  //12 [16..27] VALOR DO FRETE
  pAdd(fFormatVal(qryDoc.FieldByName('TOTFRE').AsFloat, 12));

  //12 [28..39] VALOR DO SEGURO
  pAdd(fFormatVal(qryDoc.FieldByName('SEGURO').AsFloat, 12));

  //12 [40..51] VALOR DO DESCONTO DA NF
  pAdd(fFormatVal(qryDoc.FieldByName('DESESP').AsFloat, 12));

  //12 [52..63] BASE DE CALCULO DO ICMS
  pAdd(fFormatVal(qryDoc.FieldByName('BASICM').AsFloat, 12));

  //12 [64..75] VALOR DO DESCONTO DO ICMS
  pAdd('', 12);

  //6 [76..81] NUMERO NF VENDA DO FORNECEDOR
  pAdd('', 6);

  //6 [82..87] DATA NF DE VENDA DO FORNECEDOR
  pAdd('', 6);

  //4 [88..91] SERIE NF DE VENDA FORNECEDOR
  pAdd('', 4);

  //3 [92..94] CODIGO DA FABRICA TRANSMISSORA
  pAdd('', 3);

  //5 [95..99] COD. FISCAL OPERACAO (CFOP)
  pAdd(fStrZero(qryDoc.FieldByName('CLAFIS').AsString, 5), 5);

  //29 [100..128] ESPACO
  pAdd('', 29);

end;

procedure TAvisoEmbarque.pGerarArquivo(strPath: String);
begin
  pSQL(qryDoc, repFaturamento, 'DOCUMENTO_AVISO_EMBARQUE',
      [FTabGer,  // [0] = TABELA GER (MOVGER, NOTGER)
       FTabAux,  // [1] = TABELA AUX (AUXMOV, AUXNOT)
       FCodEmp,  // [2] = CÓDIGO DA EMPRESA
       FNumDoc,  // [3] = NÚMERO DO DOCUMENTO
       FEspDoc,  // [4] = ESPÉCIE DO DOCUMENTO
       FCodCli,  // [5] = CÓDIGO DO CLIENTE
       FTabDet]);// [6] = TABELA DET (MOVDET, NOTDET)
  qryDoc.Open;

  If qryDoc.IsEmpty Then
    Raise Exception.Create('Não foi encontrado o documento ['+FNumDoc+'-'+FEspDoc+'-'+FCodEmp+']');

  // 'ITP', 'AE1', 'NF2', 'AE2', 'AE4', 'TE1' E 'FTP'

  FArquivo.Add(f_ITP);
  FArquivo.Add(f_AE1);
  FArquivo.Add(f_NF2);

  // Carrega itens
  pSQL(qryItem, repFaturamento, 'ITEM_DOCUMENTO_AVISO_EMBARQUE',
       [FTabDet,
        qryDoc.FieldByName('AUTINC').AsString,
        FCodCli,
        FTabTri]);
  qryItem.Open;

  If qryItem.IsEmpty Then
    Raise Exception.Create('Nenhum item encontrado no documento ['+FNumDoc+'-'+FEspDoc+'-'+FCodEmp+']');

  While Not qryItem.Eof Do
  Begin
    FArquivo.Add(f_AE2);
    FArquivo.Add(f_AE4);
    
    qryItem.Next;
  End;

  FArquivo.Add(f_FTP);

  FArquivo.SaveToFile(strPath + '\'+ 'AEM' + fPadL(FNumDoc, 6) + '.txt');

  pSetarGerado;
end;

procedure TAvisoEmbarque.pGerarXmlB2B(strPath: String; strAutInc: String);
var
  xmlDocNFE: IXMLDocument;
  XmlDoc: IXMLDocument;
  xmlNota: DOMString;
  nfeProcB2B: IXMLNode;
  NFeB2B: IXMLNode;
  iCab: IXMLNode;
  partes: IXMLNode;
  prod: IXMLNode;
  emite: IXMLNode;
  comprador: IXMLNode;
  automotivo: IXMLNode;
  strCodCliPro: string;
  intNumProd: integer;
begin
  pSQL(qryDoc, repFaturamento, 'DOCUMENTO_B2B',
      [FNumDoc,  // [0] = NÚMERO DO DOCUMENTO
       FEspDoc,  // [1] = ESPÉCIE DO DOCUMENTO
       FCodEmp,  // [2] = CÓDIGO DA EMPRESA
       FCodCli]);// [3] = CLIENTE DO DOCUMENTO
  qryDoc.Open;

  If qryDoc.IsEmpty Then
    Raise Exception.Create('XML ou chave de acesso da nota não encontrado ['+FNumDoc+'-'+FEspDoc+'-'+FCodEmp+']');

  pSQL(qryItem, repFaturamento, 'ITEM_DOCUMENTO_B2B',
      [FNumDoc,  // [0] = NÚMERO DO DOCUMENTO
       FEspDoc,  // [1] = ESPÉCIE DO DOCUMENTO
       FCodEmp,  // [2] = CÓDIGO DA EMPRESA
       FCodCli,  // [3] = CLIENTE DO DOCUMENTO
       FTabDet,  // [4] = TABELA DET (MOVDET, NOTDET)
       FTabTri]);// [5] = TABELA TRI (MOVTRI, NOTTRI)
  qryItem.Open;



  If qryItem.IsEmpty Then
    Raise Exception.Create('Nenhum produto encontrado no documento ['+FNumDoc+'-'+FEspDoc+'-'+FCodEmp+']');

  XmlDoc := TXMLDocument.Create(nil);
  XmlDoc.XML.Clear;

  xmlNota := qryDoc.FieldByName('NFE_ARQXML').AsString;
  xmlDocNFE := LoadXMLData(xmlNota);

  XmlDoc.Active := True;
  XmlDoc.Encoding := 'UTF-8';
  nfeProcB2B := XmlDoc.AddChild('nfeProcB2B');

  //Adiciona a tag principal da nota fiscal
  if xmlDocNFE.ChildNodes.Count > 0 then
    nfeProcB2B.ChildNodes.Add(xmlDocNFE.ChildNodes[1].CloneNode(True));

  NFeB2B := nfeProcB2B.AddChild('NFeB2B');
  iCab := NFeB2B.AddChild('iCab');
  icab.Attributes['versao'] := '1.20';
  iCab.ChildValues['fMensg'] := 9;
  iCab.ChildValues['nDoc'] := 'B2BNFE';
  iCab.ChildValues['dEmiDoc'] := FormatDateTime('yyyy-mm-dd',qryDoc.FieldByName('NFE_HORINI').AsDateTime) + 'T' + FormatDateTime('hh:mm:ss',qryDoc.FieldByName('NFE_HORINI').AsDateTime);
  iCab.ChildValues['tpNF'] := 1;
  iCab.ChildValues['nNF'] := StrToIntDef(strNumDoc,0);
  iCab.ChildValues['serie'] := qryDoc.FieldByName('NFE_SERIE_').AsInteger;
  iCab.ChildValues['dEmi'] :=  FormatDateTime('yyyy-mm-dd', qryDoc.FieldByName('NFE_HORINI').AsDateTime);
  iCab.ChildValues['dhPrevEntrega'] := FormatDateTime('yyyy-mm-dd',qryDoc.FieldByName('NFE_HORINI').AsDateTime) + 'T00:00:00';
  iCab.ChildValues['chNFe'] := qryDoc.FieldByName('NFE_ACESSO').AsString;
  partes := iCab.AddChild('partes');
  emite := partes.AddChild('emite');
  emite.ChildValues['tpEmit'] := '001';
  emite.ChildValues['cEmit'] := fRetCGCEmpresa(VS_strCodEmp);
  comprador := partes.AddChild('comprador');
  comprador.ChildValues['tpComprador'] := '001';
  comprador.ChildValues['cComprador'] := fRetCgcCpf(strCodCli);

  intNumProd := 0;
  while not qryItem.Eof do
  begin
    Inc(intNumProd);

    If fCfgSis('CLIPRO', varBoolean) Then
    Begin
      strCodCliPro := fCampoTabela('CLI_COD_NF', 'CLIPRO', ['CLI_CODCLI','CLI_CODITE'], [strCodCli,qryItem.FieldByName('DET_CODITE').AsString], False);
    End
    Else
    Begin
      strCodCliPro := qryItem.FieldByName('DET_PARNUM').AsString;

    End;

    prod := iCab.AddChild('prod');
    prod.ChildValues['nLin'] := intNumProd;
    prod.ChildValues['cProd'] := qryItem.FieldByName('DET_CODITE').AsString;

    if not fEmptyStr(strCodCliPro) then
      prod.ChildValues['cAdicProdClie'] := strCodCliPro;

    prod.ChildValues['npComp'] := qryItem.FieldByName('DET_NUMCMP').AsString;
    prod.ChildValues['unidMedProd'] := qryItem.FieldByName('DET_UNIDAD').AsString;
    automotivo := prod.AddChild('automotivo');
    automotivo.ChildValues['tpFornec'] := 'P';
    qryItem.Next;
  end;

  XmlDoc.SaveToFile(strPath + '\' + strNumDoc + strEspDoc + strCodEmp + '_NFeB2B.xml');

  pSetarGerado(strAutInc);

end;

end.
