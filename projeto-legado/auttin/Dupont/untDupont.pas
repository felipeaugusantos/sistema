unit untDupont;

interface

uses SysUtils, Classes, Uni,  Forms, UniClientDataSet, Variants, DB,
  Math, DateUtils, StrUtils, untTintadeMaquina, XMLDoc, XMLIntf, DBGridCitel, DBGrids, Controls;

Type
  TBaseDup = Record
    strCodBas: String;
    strTipBas: String; // Tipo: (B)ase (C)atalizado (D)iluente
    fltQtdCon: Double;
    fltQtdDil: Double;
  End;

Type
  TStringArray = Array of String;
  TDuponAutomotiva = class(TTintadeMaquina)
  private
    function fGravaCadBasXml(): Boolean;
    function fGravaCadDupXml(): Boolean;
    function fFormataFloatDupont(strValor: Variant): Double;


    function fXmlToDataSet(strArquivo: String): TUniClientDataSet;
    function fXmlProdutoToDataSet(): TUniClientDataSet;
    function fXmlCompQualidadeToDataSet(): TUniClientDataSet;
    function fXmlPadraoRelMistQldToDataSet(): TUniClientDataSet;
    function fXmlLitrografiaToDataSet(): TUniClientDataSet;
    function fXmlProcurarValor(xmlNoPai: IXMLNode; strAtributo: String; valor: String): IXMLNode;

//    procedure pExibeDataSet(dataSet: TDataSet);
  public
    function fGravaNovasFormulas(): Boolean;
    function fGravaArquivos(): Boolean;
    function fGravarNovasFormulas: Boolean; override;
  End;

  TBaseDupArray = Array Of TBaseDup;

  function fGerarBases: Boolean;
  function fDupontGeraArquivo(blnGerBas: Boolean): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodPro: String);
  function fRetProCodSeq: Integer;
  function fGetMd5MySQl(strTexto: String): String;

implementation

uses untFuncoes,  untFuncTinta,
  untModuloTinta, untFuncoesSimples;

function fDupontGeraArquivo(blnGerBas: Boolean): Boolean;
  Var
    strPatDup: String;
    intLinha: Integer;
    strLinha: String;
    intContador: Integer;

    qryCadDup: TUniQuery;
    stlFormulas: TStringList;

    dicArqCp: TDicionario;
    cdsArqCp: TUniClientDataSet;
    cdsCompQualidade: TUniClientDataSet;
    cdsRelMistura: TUniClientDataSet;
    cdsLitrografia: TUniClientDataSet;

    //REFERENTE À FÓRMULA
    strLinhaCor: String;
    strQualidade: String; // (G,K,BP,etc)
    strAnoCor: String;
    strCodigo: String;
    strMontad: String;
    strAltern: String;
    strRegiao: String;
    strDescri: String;
    strCodOem: String;
    fltVolumeFormula: Double;

    strCatalisador: String; // CÓDIGO DO CATALISADOR
    fltPesEspCatal: Double; // PESO ESPECIFICO DO CATALISADOR
    fltRelacCatal: Double; // RELACAO DE MISTURA DO CATALISADOR;

    strDiluente: String; //CÓDIGO DO DILUENTE
    fltPesEspDilul: Double; // PESO ESPECÍFICO DO DILUENTE
    fltRelacDilul: Double; // RELAÇÃO DE MISTURA DO DILUENTE

    fltPartesTinta: Double; // TOTAL DE PARTES DA TINTA
    fltTotalPartes: Double; // TOTAL DE PARTES

    fltFatorRelacao: Double; // FATOR DE RELAÇÃO DE MISTURA

    fltPeso1: Double;
    fltPesoTeorico: Double;

    strIdFormula: String;
    intNumArq: Integer;

    arrBases: TBaseDupArray;
    blnSomenteConc: Boolean;
begin

  If blnGerBas Then
  Begin
    Result := fGerarBases;
    Exit;
  End;

  strPatDup :=  fGetConfTinta('DUP').fGet('PATDUP');
  If (Not FileExists(strPatDup + '\Formulas.csv')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDup + '\Formulas.csv não existe!', ['&Ok']);
    Exit;
  End;

  Result := True;

  pZapTable('DUP_CADDUP');

  qryCadDup := fCriaQuery(Nil);
  qryCadDup.SQL.Clear;
  qryCadDup.SQL.Add('INSERT DELAYED INTO DUP_CADDUP ( ');

  qryCadDup.SQL.Add('DUP_CODSEQ, ');
  qryCadDup.SQL.Add('DUP_CODDUP, ');
  qryCadDup.SQL.Add('DUP_CODOEM, ');
  qryCadDup.SQL.Add('DUP_LINHA_, ');
  qryCadDup.SQL.Add('DUP_QUALID, ');
  qryCadDup.SQL.Add('DUP_ALTERN, ');
  qryCadDup.SQL.Add('DUP_REGIAO, ');
  qryCadDup.SQL.Add('DUP_DESCRI, ');
  qryCadDup.SQL.Add('DUP_MONTAD, ');
  qryCadDup.SQL.Add('DUP_ANOCOR, ');
  qryCadDup.SQL.Add('DUP_CODEMP, ');
  qryCadDup.SQL.Add('AUTOINCREM, ');
  qryCadDup.SQL.Add('DUP_LITRAG, ');

  qryCadDup.SQL.Add('DUP_BASE01, ');
  qryCadDup.SQL.Add('DUP_QTDC01, ');
  qryCadDup.SQL.Add('DUP_QTDD01, ');
  qryCadDup.SQL.Add('DUP_TIPB01, ');
  qryCadDup.SQL.Add('DUP_BASE02, ');
  qryCadDup.SQL.Add('DUP_QTDC02, ');
  qryCadDup.SQL.Add('DUP_QTDD02, ');
  qryCadDup.SQL.Add('DUP_TIPB02, ');
  qryCadDup.SQL.Add('DUP_BASE03, ');
  qryCadDup.SQL.Add('DUP_QTDC03, ');
  qryCadDup.SQL.Add('DUP_QTDD03, ');
  qryCadDup.SQL.Add('DUP_TIPB03, ');
  qryCadDup.SQL.Add('DUP_BASE04, ');
  qryCadDup.SQL.Add('DUP_QTDC04, ');
  qryCadDup.SQL.Add('DUP_QTDD04, ');
  qryCadDup.SQL.Add('DUP_TIPB04, ');
  qryCadDup.SQL.Add('DUP_BASE05, ');
  qryCadDup.SQL.Add('DUP_QTDC05, ');
  qryCadDup.SQL.Add('DUP_QTDD05, ');
  qryCadDup.SQL.Add('DUP_TIPB05, ');
  qryCadDup.SQL.Add('DUP_BASE06, ');
  qryCadDup.SQL.Add('DUP_QTDC06, ');
  qryCadDup.SQL.Add('DUP_QTDD06, ');
  qryCadDup.SQL.Add('DUP_TIPB06, ');
  qryCadDup.SQL.Add('DUP_BASE07, ');
  qryCadDup.SQL.Add('DUP_QTDC07, ');
  qryCadDup.SQL.Add('DUP_QTDD07, ');
  qryCadDup.SQL.Add('DUP_TIPB07, ');
  qryCadDup.SQL.Add('DUP_BASE08, ');
  qryCadDup.SQL.Add('DUP_QTDC08, ');
  qryCadDup.SQL.Add('DUP_QTDD08, ');
  qryCadDup.SQL.Add('DUP_TIPB08, ');
  qryCadDup.SQL.Add('DUP_BASE09, ');
  qryCadDup.SQL.Add('DUP_QTDC09, ');
  qryCadDup.SQL.Add('DUP_QTDD09, ');
  qryCadDup.SQL.Add('DUP_TIPB09, ');
  qryCadDup.SQL.Add('DUP_BASE10, ');
  qryCadDup.SQL.Add('DUP_QTDC10, ');
  qryCadDup.SQL.Add('DUP_QTDD10, ');
  qryCadDup.SQL.Add('DUP_TIPB10, ');
  qryCadDup.SQL.Add('DUP_BASE11, ');
  qryCadDup.SQL.Add('DUP_QTDC11, ');
  qryCadDup.SQL.Add('DUP_QTDD11, ');
  qryCadDup.SQL.Add('DUP_TIPB11, ');
  qryCadDup.SQL.Add('DUP_BASE12, ');
  qryCadDup.SQL.Add('DUP_QTDC12, ');
  qryCadDup.SQL.Add('DUP_QTDD12, ');
  qryCadDup.SQL.Add('DUP_TIPB12, ');
  qryCadDup.SQL.Add('DUP_BASE13, ');
  qryCadDup.SQL.Add('DUP_QTDC13, ');
  qryCadDup.SQL.Add('DUP_QTDD13, ');
  qryCadDup.SQL.Add('DUP_TIPB13, ');
  qryCadDup.SQL.Add('DUP_BASE14, ');
  qryCadDup.SQL.Add('DUP_QTDC14, ');
  qryCadDup.SQL.Add('DUP_QTDD14, ');
  qryCadDup.SQL.Add('DUP_TIPB14, ');
  qryCadDup.SQL.Add('DUP_BASE15, ');
  qryCadDup.SQL.Add('DUP_QTDC15, ');
  qryCadDup.SQL.Add('DUP_QTDD15, ');
  qryCadDup.SQL.Add('DUP_TIPB15, ');
  qryCadDup.SQL.Add('DUP_BASE16, ');
  qryCadDup.SQL.Add('DUP_QTDC16, ');
  qryCadDup.SQL.Add('DUP_QTDD16, ');
  qryCadDup.SQL.Add('DUP_TIPB16, ');
  qryCadDup.SQL.Add('DUP_BASE17, ');
  qryCadDup.SQL.Add('DUP_QTDC17, ');
  qryCadDup.SQL.Add('DUP_QTDD17, ');
  qryCadDup.SQL.Add('DUP_TIPB17, ');
  qryCadDup.SQL.Add('DUP_BASE18, ');
  qryCadDup.SQL.Add('DUP_QTDC18, ');
  qryCadDup.SQL.Add('DUP_QTDD18, ');
  qryCadDup.SQL.Add('DUP_TIPB18, ');
  qryCadDup.SQL.Add('DUP_BASE19, ');
  qryCadDup.SQL.Add('DUP_QTDC19, ');
  qryCadDup.SQL.Add('DUP_QTDD19, ');
  qryCadDup.SQL.Add('DUP_TIPB19, ');
  qryCadDup.SQL.Add('DUP_BASE20, ');
  qryCadDup.SQL.Add('DUP_QTDC20, ');
  qryCadDup.SQL.Add('DUP_QTDD20, ');
  qryCadDup.SQL.Add('DUP_TIPB20) ');
  qryCadDup.SQL.Add(' VALUES ( ');
  qryCadDup.SQL.Add(':DUP_CODSEQ, ');
  qryCadDup.SQL.Add(':DUP_CODDUP, ');
  qryCadDup.SQL.Add(':DUP_CODOEM, ');
  qryCadDup.SQL.Add(':DUP_LINHA_, ');
  qryCadDup.SQL.Add(':DUP_QUALID, ');
  qryCadDup.SQL.Add(':DUP_ALTERN, ');
  qryCadDup.SQL.Add(':DUP_REGIAO, ');
  qryCadDup.SQL.Add(':DUP_DESCRI, ');
  qryCadDup.SQL.Add(':DUP_MONTAD, ');
  qryCadDup.SQL.Add(':DUP_ANOCOR, ');
  qryCadDup.SQL.Add(':DUP_CODEMP, ');
  qryCadDup.SQL.Add(':AUTOINCREM, ');
  qryCadDup.SQL.Add(':DUP_LITRAG, ');

  qryCadDup.SQL.Add(':DUP_BASE01, ');
  qryCadDup.SQL.Add(':DUP_QTDC01, ');
  qryCadDup.SQL.Add(':DUP_QTDD01, ');
  qryCadDup.SQL.Add(':DUP_TIPB01, ');
  qryCadDup.SQL.Add(':DUP_BASE02, ');
  qryCadDup.SQL.Add(':DUP_QTDC02, ');
  qryCadDup.SQL.Add(':DUP_QTDD02, ');
  qryCadDup.SQL.Add(':DUP_TIPB02, ');
  qryCadDup.SQL.Add(':DUP_BASE03, ');
  qryCadDup.SQL.Add(':DUP_QTDC03, ');
  qryCadDup.SQL.Add(':DUP_QTDD03, ');
  qryCadDup.SQL.Add(':DUP_TIPB03, ');
  qryCadDup.SQL.Add(':DUP_BASE04, ');
  qryCadDup.SQL.Add(':DUP_QTDC04, ');
  qryCadDup.SQL.Add(':DUP_QTDD04, ');
  qryCadDup.SQL.Add(':DUP_TIPB04, ');
  qryCadDup.SQL.Add(':DUP_BASE05, ');
  qryCadDup.SQL.Add(':DUP_QTDC05, ');
  qryCadDup.SQL.Add(':DUP_QTDD05, ');
  qryCadDup.SQL.Add(':DUP_TIPB05, ');
  qryCadDup.SQL.Add(':DUP_BASE06, ');
  qryCadDup.SQL.Add(':DUP_QTDC06, ');
  qryCadDup.SQL.Add(':DUP_QTDD06, ');
  qryCadDup.SQL.Add(':DUP_TIPB06, ');
  qryCadDup.SQL.Add(':DUP_BASE07, ');
  qryCadDup.SQL.Add(':DUP_QTDC07, ');
  qryCadDup.SQL.Add(':DUP_QTDD07, ');
  qryCadDup.SQL.Add(':DUP_TIPB07, ');
  qryCadDup.SQL.Add(':DUP_BASE08, ');
  qryCadDup.SQL.Add(':DUP_QTDC08, ');
  qryCadDup.SQL.Add(':DUP_QTDD08, ');
  qryCadDup.SQL.Add(':DUP_TIPB08, ');
  qryCadDup.SQL.Add(':DUP_BASE09, ');
  qryCadDup.SQL.Add(':DUP_QTDC09, ');
  qryCadDup.SQL.Add(':DUP_QTDD09, ');
  qryCadDup.SQL.Add(':DUP_TIPB09, ');
  qryCadDup.SQL.Add(':DUP_BASE10, ');
  qryCadDup.SQL.Add(':DUP_QTDC10, ');
  qryCadDup.SQL.Add(':DUP_QTDD10, ');
  qryCadDup.SQL.Add(':DUP_TIPB10, ');
  qryCadDup.SQL.Add(':DUP_BASE11, ');
  qryCadDup.SQL.Add(':DUP_QTDC11, ');
  qryCadDup.SQL.Add(':DUP_QTDD11, ');
  qryCadDup.SQL.Add(':DUP_TIPB11, ');
  qryCadDup.SQL.Add(':DUP_BASE12, ');
  qryCadDup.SQL.Add(':DUP_QTDC12, ');
  qryCadDup.SQL.Add(':DUP_QTDD12, ');
  qryCadDup.SQL.Add(':DUP_TIPB12, ');
  qryCadDup.SQL.Add(':DUP_BASE13, ');
  qryCadDup.SQL.Add(':DUP_QTDC13, ');
  qryCadDup.SQL.Add(':DUP_QTDD13, ');
  qryCadDup.SQL.Add(':DUP_TIPB13, ');
  qryCadDup.SQL.Add(':DUP_BASE14, ');
  qryCadDup.SQL.Add(':DUP_QTDC14, ');
  qryCadDup.SQL.Add(':DUP_QTDD14, ');
  qryCadDup.SQL.Add(':DUP_TIPB14, ');
  qryCadDup.SQL.Add(':DUP_BASE15, ');
  qryCadDup.SQL.Add(':DUP_QTDC15, ');
  qryCadDup.SQL.Add(':DUP_QTDD15, ');
  qryCadDup.SQL.Add(':DUP_TIPB15, ');
  qryCadDup.SQL.Add(':DUP_BASE16, ');
  qryCadDup.SQL.Add(':DUP_QTDC16, ');
  qryCadDup.SQL.Add(':DUP_QTDD16, ');
  qryCadDup.SQL.Add(':DUP_TIPB16, ');
  qryCadDup.SQL.Add(':DUP_BASE17, ');
  qryCadDup.SQL.Add(':DUP_QTDC17, ');
  qryCadDup.SQL.Add(':DUP_QTDD17, ');
  qryCadDup.SQL.Add(':DUP_TIPB17, ');
  qryCadDup.SQL.Add(':DUP_BASE18, ');
  qryCadDup.SQL.Add(':DUP_QTDC18, ');
  qryCadDup.SQL.Add(':DUP_QTDD18, ');
  qryCadDup.SQL.Add(':DUP_TIPB18, ');
  qryCadDup.SQL.Add(':DUP_BASE19, ');
  qryCadDup.SQL.Add(':DUP_QTDC19, ');
  qryCadDup.SQL.Add(':DUP_QTDD19, ');
  qryCadDup.SQL.Add(':DUP_TIPB19, ');
  qryCadDup.SQL.Add(':DUP_BASE20, ');
  qryCadDup.SQL.Add(':DUP_QTDC20, ');
  qryCadDup.SQL.Add(':DUP_QTDD20, ');
  qryCadDup.SQL.Add(':DUP_TIPB20) ');

  stlFormulas := TStringList.Create;
  stlFormulas.LoadFromFile(strPatDup + '\Formulas.csv');

  cdsCompQualidade := fCsvToClientDataSet(strPatDup + '\Compqualidade.csv', ';');
  cdsRelMistura    := fCsvToClientDataSet(strPatDup + '\PadraoRelMistQld.csv', ';');
  cdsLitrografia   := fCsvToClientDataSet(strPatDup + '\Litografia.csv', ';');

  dicArqCp := TDicionario.Create;

  intLinha := 1;
  While (intLinha < stlFormulas.Count) Do
  Begin

    SetLength(arrBases, 0);

    strLinha     := stlFormulas[intLinha];
    strLinhaCor  := fGetValorLinha(strLinha, ';', 07);
    strQualidade := fGetValorLinha(strLinha, ';', 03);
    strIdFormula := fGetValorLinha(strLinha, ';', 12);
    strAnoCor    := fGetValorLinha(strLinha, ';', 09);
    strCodigo    := fGetValorLinha(strLinha, ';', 01);
    strMontad    := fGetValorLinha(strLinha, ';', 06);
    strAltern    := fGetValorLinha(strLinha, ';', 02);
    strRegiao    := fGetValorLinha(strLinha, ';', 05);
    strDescri    := fGetValorLinha(strLinha, ';', 04);
    strCodOem    := fGetValorLinha(strLinha, ';', 08);

    intNumArq := (StrToIntDef(strIdFormula, 0) Div 90) + 1;
    If StrToIntDef(strIdFormula, 0) Mod 90 = 0  Then
      Dec(intNumArq);

    If (Not FileExists(strPatDup + '\cp' + IntToStr(intNumArq) + '.csv')) Then
    Begin
      Inc(intLinha);
      Continue;
      //gravar um log ou dar mensagem aqui!!!
    End;

//    If (dicArqCp.RetornaObjeto('cp' + IntToStr(intNumArq)) = Nil) Then
      cdsArqCp := fCsvToClientDataSet(strPatDup + '\cp' + IntToStr(intNumArq) + '.csv', ';');
//    Else
//      cdsArqCp := TUniClientDataSet(dicArqCp.RetornaObjeto('cp' + IntToStr(intNumArq)));

    If (Not cdsArqCp.Locate('I', strIdFormula, [])) Then
    Begin
      //Raise Exception.Create('Inconsistência nos aquivos csv: Fórmula ' + strIdFormula + ' não encontrada no arquivo CP.');
      Inc(intLinha);
      Continue;
    End;

    If (Not cdsLitrografia.Locate('LINHA_PRODUTO;QUALIDADE',
      VarArrayOf([strLinhaCor, strQualidade]), [])) Then
    Begin
      Raise Exception.Create('Inconsistência nos aquivos csv: Litrografia não encontrada.');
    End;

    blnSomenteConc := False;
    If (Not cdsRelMistura.Locate('LINHA_PRODUTO;DSCR_QUALIDADE', VarArrayOf([strLinhaCor, strQualidade]), [])) Then
    Begin
      blnSomenteConc := True;
    End;

    {***************************************************}
    {* SALVA A POSICAO INICIAL DA RELAÇÃO DE MISTURA,  *}
    {* POIS PRECISA VOLTAR NELA DEPOIS                 *}
    {** 04/06/2008 - 08:06 **************************MV*}
    strCatalisador   := '';
    fltPesEspCatal   := 0.0;
    fltRelacCatal    := 0.0;

    strDiluente      := '';
    fltPesEspDilul   := 0.0;
    fltRelacDilul    := 0.0;

    fltPartesTinta := cdsRelMistura.FieldByName('RELACAO').AsFloat;
    fltTotalPartes := cdsRelMistura.FieldByName('RELACAO').AsFloat;

    While (Not cdsRelMistura.Eof)                                                And
          (Not blnSomenteConc)                                                   And
          (cdsRelMistura.FieldByName('LINHA_PRODUTO').AsString = strLinhaCor)    And
          (cdsRelMistura.FieldByName('DSCR_QUALIDADE').AsString = strQualidade) Do
    Begin

      fltTotalPartes := fltTotalPartes + cdsRelMistura.FieldByName('VALOR').AsFloat;

      If (cdsRelMistura.FieldByName('DSCR_TIPO_COMPONENTE').AsString = 'CATALISADOR') Then
      Begin
        strCatalisador := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
        fltRelacCatal  := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
      End
      Else
      Begin
        strDiluente    := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
        fltRelacDilul  := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
      End;

      cdsRelMistura.Next;
    End;

    {***************************************************}
    {* PEGA O PESO ESPECÍFICO DO CATALIZADO            *}
    {** 04/06/2008 - 08:27 **************************MV*}
    If (Not fEmptyStr(strCatalisador)) Then
    Begin

      cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
        VarArrayOf([strCatalisador, strLinhaCor, strQualidade]), []);

      fltPesEspCatal := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
    End;

    {***************************************************}
    {* PEGA O PESO ESPECÍFICO DO DILUENTE              *}
    {** 04/06/2008 - 08:27 **************************MV*}
    If (Not fEmptyStr(strDiluente)) Then
    Begin

      cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
        VarArrayOf([strDiluente, strLinhaCor, strQualidade]), []);

      fltPesEspDilul := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
    End;

    {***************************************************}
    {* CALCULA FATOR DE RELAÇÃO DE MISTURA             *}
    {** 04/06/2008 - 08:27 **************************MV*}
    If (blnSomenteConc) Then
      fltFatorRelacao := 0.0
    Else
      fltFatorRelacao := RoundTo(fltPartesTinta / fltTotalPartes, -1);

    {***************************************************}
    {* REALIZA O CÁLCULO (PROCESSA AS BASES DA FORMULA)*}
    {** 03/06/2008 - 17:00 **************************MV*}
    While (Not cdsArqCp.Eof)                                  And
          (cdsArqCp.FieldByName('I').AsString = strIdFormula) Do
    Begin

      {***************************************************}
      {* CÁLCULO DO PREÇO 1:                             *}
      {* [(PC * 100 / 100) * 100] / (100 / PESOTEORICO)  *}
      {** 03/06/2008 - 17:00 **************************MV*}
      If (Not fEmptyStr(cdsArqCp.FieldByName('PP').AsString)) And
         (cdsArqCp.FieldByName('PP').AsFloat > 0)             Then
        fltPesoTeorico := cdsArqCp.FieldByName('PP').AsFloat
      Else
        fltPesoTeorico := cdsArqCp.FieldByName('PT').AsFloat;

      fltPesoTeorico := fltPesoTeorico;

      fltPeso1 := (((cdsArqCp.FieldByName('PC').AsFloat * 100) / 100) * 100) / (100 / fltPesoTeorico);

      SetLength(arrBases, Length(arrBases)+1);
      arrBases[Length(arrBases)-1].strCodBas := cdsArqCp.FieldByName('CC').AsString;
      arrBases[Length(arrBases)-1].strTipBas := 'B';
      arrBases[Length(arrBases)-1].fltQtdCon := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
      arrBases[Length(arrBases)-1].fltQtdDil := fltPeso1 * fltFatorRelacao * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;

      cdsArqCp.Next;
    End;

    {***************************************************}
    {* REALIZA O CÁLCULO DO CATALISADOR E DILUENTE, SE *}
    {* HOUVER                                          *}
    {** 04/06/2008 - 08:35 **************************MV*}
    If (Not fEmptyStr(strCatalisador)) Then
    Begin
      fltPeso1 := (fltRelacCatal / fltTotalPartes) * (fltPesEspCatal / 100);

      SetLength(arrBases, Length(arrBases)+1);
      arrBases[Length(arrBases)-1].strCodBas := strCatalisador;
      arrBases[Length(arrBases)-1].strTipBas := 'C';
      arrBases[Length(arrBases)-1].fltQtdCon := 0.0;
      arrBases[Length(arrBases)-1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
    End;

    If (Not fEmptyStr(strDiluente)) Then
    Begin
      fltPeso1 := (fltRelacDilul / fltTotalPartes) * (fltPesEspDilul / 100);

      SetLength(arrBases, Length(arrBases)+1);
      arrBases[Length(arrBases)-1].strCodBas := strDiluente;
      arrBases[Length(arrBases)-1].strTipBas := 'D';
      arrBases[Length(arrBases)-1].fltQtdCon := 0.0;
      arrBases[Length(arrBases)-1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
    End;

    {***************************************************}
    {* REALIZA GRAVAÇÃO NO ARQUIVO                     *}
    {** 04/06/2008 - 09:20 **************************MV*}
    qryCadDup.Close;
    qryCadDup.ParamByName('DUP_CODSEQ').AsString := fStrZero(intLinha, 6);
    qryCadDup.ParamByName('DUP_CODDUP').AsString := strCodigo;
    qryCadDup.ParamByName('DUP_CODOEM').AsString := strCodOem;
    qryCadDup.ParamByName('DUP_LINHA_').AsString := strLinhaCor;
    qryCadDup.ParamByName('DUP_QUALID').AsString := strQualidade;
    qryCadDup.ParamByName('DUP_ALTERN').AsString := strAltern;
    qryCadDup.ParamByName('DUP_REGIAO').AsString := strRegiao;
    qryCadDup.ParamByName('DUP_DESCRI').AsString := strDescri;
    qryCadDup.ParamByName('DUP_MONTAD').AsString := strMontad;
    qryCadDup.ParamByName('DUP_ANOCOR').AsString := strAnoCor;
    qryCadDup.ParamByName('DUP_CODEMP').AsString := VS_strCodEmp;
    qryCadDup.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intLinha, VS_strCodEmp);
    qryCadDup.ParamByName('DUP_LITRAG').AsFloat  := cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat;

    For intContador := Low(arrBases) To High(arrBases) Do
    Begin
      qryCadDup.ParamByName('DUP_BASE' + fStrZero(intContador+1, 2)).AsString := arrBases[intContador].strCodBas;
      qryCadDup.ParamByName('DUP_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := arrBases[intContador].fltQtdCon;
      qryCadDup.ParamByName('DUP_QTDD' + fStrZero(intContador+1, 2)).AsFloat  := arrBases[intContador].fltQtdDil;
      qryCadDup.ParamByName('DUP_TIPB' + fStrZero(intContador+1, 2)).AsString := arrBases[intContador].strTipBas;
    End;

    For intContador := High(arrBases)+1 To 19 Do
    Begin
      qryCadDup.ParamByName('DUP_BASE' + fStrZero(intContador+1, 2)).AsString := '';
      qryCadDup.ParamByName('DUP_QTDC' + fStrZero(intContador+1, 2)).AsFloat  := 0;
      qryCadDup.ParamByName('DUP_QTDD' + fStrZero(intContador+1, 2)).AsFloat  := 0;
      qryCadDup.ParamByName('DUP_TIPB' + fStrZero(intContador+1, 2)).AsString := '';
    End;

    qryCadDup.ExecSQL;

    FreeAndNil(cdsArqCp);

    Inc(intLinha);

    Application.ProcessMessages;
  End;



  qryCadDup.Close;
  FreeAndNil(qryCadDup);

end;

function fGerarBases: Boolean;
  Var
    strPatDup: String;
    qryCadBas: TUniQuery;
    cdsComQual: TUniClientDataSet;
    cdsDesBas: TUniClientDataSet;

    qryCadNfm: TUniQuery;
begin
  strPatDup := fGetConfTinta('DUP').fGet('PATDUP');
  If (Not FileExists(strPatDup + '\Compqualidade.csv')) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatDup + '\Compqualidade.csv não existe!', ['&Ok']);
    Exit;
  End;

  pZapTable('DUP_CADBAS');

  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Add('INSERT DELAYED INTO DUP_CADBAS (');
  qryCadBas.SQL.Add('  BAS_CODBAS, ');
  qryCadBas.SQL.Add('  BAS_CODEMP, ');
  qryCadBas.SQL.Add('  BAS_PESESP, ');
  qryCadBas.SQL.Add('  BAS_DESBAS, ');
  qryCadBas.SQL.Add('  BAS_EMBALA, ');
  qryCadBas.SQL.Add('  BAS_PESGRA, ');
  qryCadBas.SQL.Add('  AUTOINCREM) ');
  qryCadBas.SQL.Add('VALUES ( ');
  qryCadBas.SQL.Add('  :CODBAS, ');
  qryCadBas.SQL.Add('  :CODEMP, ');
  qryCadBas.SQL.Add('  :PESESP, ');
  qryCadBas.SQL.Add('  :DESBAS, ');
  qryCadBas.SQL.Add('  :EMBALA, ');
  qryCadBas.SQL.Add('  :PESGRA, ');
  qryCadBas.SQL.Add('  :AUTINC) ');

  cdsComQual := fCsvToClientDataSet(strPatDup + '\Compqualidade.csv', ';');
  cdsDesBas := fCsvToClientDataSet(strPatDup + '\Produto.csv', ';');

  cdsComQual.First;
  While (Not cdsComQual.Eof) Do
  Begin
    qryCadBas.Close;
    qryCadBas.ParamByName('CODBAS').AsString := cdsComQual.FieldByName('VCOMPONENTE').AsString;
    qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadBas.ParamByName('PESESP').AsFloat  := cdsComQual.FieldByName('VPESO').AsFloat;
    qryCadBas.ParamByName('AUTINC').AsString := fFormataAutInc(cdsComQual.RecNo, VS_strCodEmp);

    If cdsDesBas.Locate('COMPONENTE', cdsComQual.FieldByName('VCOMPONENTE').AsString, []) Then
    Begin
      qryCadBas.ParamByName('DESBAS').AsString := cdsDesBas.FieldByName('DSCR_COMPONENTE').AsString;

      If RightStr(cdsDesBas.FieldByName('EMBALAGEM').AsString, 2) = 'ML' Then
      Begin
        qryCadBas.ParamByName('EMBALA').AsFloat := fStrToFloat(Trim(AnsiReplaceStr(cdsDesBas.FieldByName('EMBALAGEM').AsString, 'ML', '')));
        qryCadBas.ParamByName('PESGRA').AsString := 'N';
      End
      Else
      Begin
        qryCadBas.ParamByName('EMBALA').AsFloat := fStrToFloat(Trim(AnsiReplaceStr(cdsDesBas.FieldByName('EMBALAGEM').AsString, 'GR', ''))) / 1000;
        qryCadBas.ParamByName('PESGRA').AsString := 'S';
      End;

    End
    Else
    Begin
      qryCadBas.ParamByName('EMBALA').Value := Null;
      qryCadBas.ParamByName('PESGRA').Value := Null;
      qryCadBas.ParamByName('DESBAS').Value := Null;
    End;

    qryCadBas.ExecSQL;

    cdsComQual.Next;
    Application.ProcessMessages;
  End;

  fGravaAutoIncrem('DUP_CADBAS', cdsComQual.RecordCount);

  Result := True;

  FreeAndNil(qryCadBas);

  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Add('SELECT * FROM DUP_CADNFM');
  qryCadNfm.Open;

  While (Not qryCadNfm.Eof) Do
  Begin
    fGeraNovasFormulas(qryCadNfm);
    qryCadNfm.Next;
  End;

  FreeAndNil(qryCadNfm);

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadDup: TUniQuery;
    strCodSeq: String;
    strAutInc: String;
    intContador: Integer;
begin

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
  
  qryCadDup := fCriaQuery;
  qryCadDup.SQL.Add('SELECT * FROM DUP_CADDUP ORDER BY AUTOINCREM DESC LIMIT 1');
  qryCadDup.Open;

//  strCodSeq := fStrZero(StrToIntDef(qryCadDup.FieldByName('DUP_CODSEQ').AsString, 0) + 1, 6);
//  strAutInc := fStrZero((StrToIntDef(LeftStr(qryCadDup.FieldByName('AUTOINCREM').AsString, 17), 0) + 1), 17);
//  if fEmptyStr(qryCadDup.FieldByName('AUTOINCREM').AsString) then
//    strAutInc := fStrZero(fFormataAutInc(1, VS_strCodEmp),20)
//  else
//    strAutInc := fStrZero(fFormataAutInc(StrToInt(Copy(qryCadDup.FieldByName('AUTOINCREM').AsString, 4, 14)) + 1, VS_strCodEmp),20);
//  strAutInc := strAutInc + VS_strCodEmp;

  strCodSeq := fStrZero(fRetProCodSeq,6);
  strAutInc := fRetAutoIncrem('DUP_CADDUP', VS_strCodEmp);

  qryCadDup.Append;

  qryCadDup.FieldByName('DUP_CODSEQ').AsString := strCodSeq;
  qryCadDup.FieldByName('DUP_CODDUP').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadDup.FieldByName('DUP_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadDup.FieldByName('DUP_CODOEM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadDup.FieldByName('DUP_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
  qryCadDup.FieldByName('DUP_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;;
  qryCadDup.FieldByName('DUP_ALTERN').AsString := qryCadNfm.FieldByName('NFM_ALTERN').AsString;;
  qryCadDup.FieldByName('DUP_REGIAO').AsString := '';
  qryCadDup.FieldByName('DUP_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadDup.FieldByName('DUP_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;;
  qryCadDup.FieldByName('DUP_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime));
  qryCadDup.FieldByName('DUP_CODEMP').AsString := VS_strCodEmp;
  qryCadDup.FieldByName('AUTOINCREM').AsString := strAutInc;
  qryCadDup.FieldByName('DUP_LITRAG').AsFloat  := 900;
  qryCadDup.FieldByName('DUP_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
  qryCadDup.FieldByName('DUP_CATALI').AsString := qryCadNfm.FieldByName('NFM_CATALI').AsString;
  qryCadDup.FieldByName('DUP_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
  intContador := 1;

  While intContador <= 20 Do
  Begin

    If (fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString)) Then
    Begin
      Break;
    End;

    qryCadDup.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
    qryCadDup.FieldByName('DUP_QTDC' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat;
    qryCadDup.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intContador, 2)).AsFloat;
    qryCadDup.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString := 'B';

    Inc(intContador);

  End;

  qryCadDup.FieldByName('DUP_MD5KEY').AsString := fGetMd5MySql(qryCadDup.FieldByName('DUP_CODDUP').AsString + qryCadDup.FieldByName('DUP_CODOEM').AsString +
                                                               qryCadDup.FieldByName('DUP_LINHA_').AsString + qryCadDup.FieldByName('DUP_QUALID').AsString +
                                                               qryCadDup.FieldByName('DUP_ALTERN').AsString + qryCadDup.FieldByName('DUP_REGIAO').AsString +
                                                               qryCadDup.FieldByName('DUP_DESCRI').AsString + qryCadDup.FieldByName('DUP_MONTAD').AsString +
                                                               qryCadDup.FieldByName('DUP_ANOCOR').AsString +
                                      qryCadDup.FieldByName('DUP_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC01').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD01').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB01').AsString +
                                      qryCadDup.FieldByName('DUP_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC02').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD02').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB02').AsString +
                                      qryCadDup.FieldByName('DUP_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC03').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD03').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB03').AsString +
                                      qryCadDup.FieldByName('DUP_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC04').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD04').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB04').AsString +
                                      qryCadDup.FieldByName('DUP_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC05').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD05').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB05').AsString +
                                      qryCadDup.FieldByName('DUP_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC06').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD06').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB06').AsString +
                                      qryCadDup.FieldByName('DUP_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC07').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD07').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB07').AsString +
                                      qryCadDup.FieldByName('DUP_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC08').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD08').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB08').AsString +
                                      qryCadDup.FieldByName('DUP_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC09').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD09').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB09').AsString +
                                      qryCadDup.FieldByName('DUP_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC10').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD10').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB10').AsString +
                                      qryCadDup.FieldByName('DUP_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC11').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD11').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB11').AsString +
                                      qryCadDup.FieldByName('DUP_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC12').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD12').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB12').AsString +
                                      qryCadDup.FieldByName('DUP_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC13').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD13').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB13').AsString +
                                      qryCadDup.FieldByName('DUP_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC14').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD14').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB14').AsString +
                                      qryCadDup.FieldByName('DUP_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC15').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD15').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB15').AsString +
                                      qryCadDup.FieldByName('DUP_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC16').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD16').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB16').AsString +
                                      qryCadDup.FieldByName('DUP_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC17').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD17').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB17').AsString +
                                      qryCadDup.FieldByName('DUP_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC18').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD18').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB18').AsString +
                                      qryCadDup.FieldByName('DUP_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC19').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD19').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB19').AsString +
                                      qryCadDup.FieldByName('DUP_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDC20').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.FieldByName('DUP_QTDD20').AsFloat), ',', '.') + qryCadDup.FieldByName('DUP_TIPB20').AsString);

  If (Not fEmptyStr(qryCadNfm.FieldByName('NFM_CODCAT').AsString)) Then
  Begin
    qryCadDup.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODCAT').AsString;
    qryCadDup.FieldByName('DUP_QTDC' + fStrZero(intContador, 2)).AsFloat  := 0.0;
    qryCadDup.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDCAT').AsFloat;
    qryCadDup.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString := 'C';
    Inc(intContador);
  End;

  If (Not fEmptyStr(qryCadNfm.FieldByName('NFM_CODDIL').AsString)) Then
  Begin
    qryCadDup.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODDIL').AsString;
    qryCadDup.FieldByName('DUP_QTDC' + fStrZero(intContador, 2)).AsFloat  := 0.0;
    qryCadDup.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDDIL').AsFloat;
    qryCadDup.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString := 'D';
  End;


  qryCadDup.Post;
  qryCadDup.Close;

  FreeAndNil(qryCadDup);

  Result := True;

end;

procedure pDeletaNovaFormula(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  DUP_CADDUP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DUP_CODNFM = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;
    ExecSQL;
    Close;
  End;
end;

{ TDuponAutomotiva }

function TDuponAutomotiva.fFormataFloatDupont(strValor: Variant): Double;
begin
  If strValor = Null Then
    strValor := '0';

  strValor := AnsiReplaceStr(strValor, '.', ',');
  strValor := '0' + strValor;
  strValor := FloatToStr(fStrToFloat(strValor));
  strValor := AnsiReplaceStr(strValor, '-', '');
  Result := fStrToFloat(strValor);
end;

function TDuponAutomotiva.fGravaArquivos: Boolean;
begin
  Result := fGravaCadBasXml();
  Result := Result And fGravaCadDupXml();
end;

function TDuponAutomotiva.fGravaCadBasXml: Boolean;
var
  strPat: String;

  xmlGen: TXMLDocument;
  xmlNoData: IXMLNode;
  xmlRegistro: IXMLNode;

  qryGen: TUniQuery;
  intQtdAtual: Integer;
  intQtdRegistros: Integer;

  cdsDesBas: TUniClientDataSet;
begin
  strPat := fGetConfTinta('DUP').fGet('PATDUP');
  strPat := strPat + '\compqualidade.xml';

  If Not FileExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := False;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strPat;
  xmlGen.Active := True;

  xmlNoData := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');

  If Not Assigned(xmlNoData) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    Result := False;
    Exit;
  End;

  qryGen := fCriaQuery(Self);
  qryGen.sql.Text := 'SELECT * FROM DUP_CADBAS';
  qryGen.Open;

  intQtdAtual := 1;
  intQtdRegistros := xmlNoData.ChildNodes.Count;

  xmlRegistro := xmlNoData.ChildNodes.First;
  pRegistraAcao('Cadastrando bases...');

  TTintadeMaquina.fAjustaInicialAutoIncremento('DUP_CADBAS', VS_strCodEmp);

  cdsDesBas := fXmlProdutoToDataSet();
  While Assigned(xmlRegistro) Do
  Begin

    If Not qryGen.Locate('BAS_CODBAS;BAS_TIPO__', VarArrayOf([xmlRegistro.Attributes['VCOMPONENTE'],
      xmlRegistro.Attributes['VTIPO']]), []) Then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('BAS_CODBAS').Value := xmlRegistro.Attributes['VCOMPONENTE'];
      qryGen.FieldByName('BAS_TIPO__').Value := xmlRegistro.Attributes['VTIPO'];
      qryGen.FieldByName('BAS_LINHA_').Value := xmlRegistro.Attributes['VLINHA_PRODUTO'];
      qryGen.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DUP_CADBAS', VS_strCodEmp);
      qryGen.FieldByName('BAS_PESESP').AsFloat :=  fFormataFloatDupont(xmlRegistro.Attributes['VPESO']);

      If cdsDesBas.Locate('COMPONENTE', xmlRegistro.Attributes['VCOMPONENTE'], []) Then
      Begin
        qryGen.FieldByName('BAS_DESBAS').AsString := cdsDesBas.FieldByName('DSCR_COMPONENTE').AsString;
        qryGen.FieldByName('BAS_EMBALA').AsFloat :=
          fStrToFloat(Copy(cdsDesBas.FieldByName('EMBALAGEM').AsString, 1, Length(cdsDesBas.FieldByName('EMBALAGEM').AsString) - 3));

        If (cdsDesBas.FieldByName('UM').AsString = 'ML') Then
        Begin
          qryGen.FieldByName('BAS_PESGRA').AsString := 'N';
        End
        Else
        Begin
          qryGen.FieldByName('BAS_PESGRA').AsString := 'S';
        End;
      End
      else
      begin
        qryGen.FieldByName('BAS_PESGRA').AsString := 'N';
      end;

      qryGen.Post;
    End;
    pRegistraProgresso(0, intQtdAtual, intQtdRegistros);
    intQtdAtual := intQtdAtual + 1;

    xmlRegistro := xmlRegistro.NextSibling;
  End;

  pRegistraAcao('Cadastro de bases realizado com sucesso');

  Result := True;
end;

function TDuponAutomotiva.fGravaCadDupXml: Boolean;
  Var
    strPat: String;

    xmlFormulas: TXMLDocument;
    xmlCP: TXMLDocument;

    xmlRegistro: IXMLNode;
    xmlRegistroCP: IXMLNode;

    cdsCompQualidade: TUniClientDataSet;
    cdsRelMistura: TUniClientDataSet;
    cdsLitrografia: TUniClientDataSet;
    cdsArqCp: TUniClientDataSet;

    qryGen: TUniQuery;

    intNumArq: Integer;
    strIdFormula: String;
    blnSomenteConc: Boolean;
    strLinhaCor: String;
    strQualidade: String;

    strCatalisador: String;
    fltPesEspCatal: Double;
    fltRelacCatal: Double;

    strDiluente: String;
    fltPesEspDilul: Double;
    fltRelacDilul: Double;

    fltPartesTinta: Double;
    fltTotalPartes: Double;

    fltFatorRelacao: Double;
    fltPesoTeorico: Double;

    fltPeso1: Double;

    arrBases: TBaseDupArray;

    intCont: Integer;
    intLinha: Integer;
    intAutoInc: Integer;
    intPos: Integer;
    intMaximo: Integer;
    procedure limpar;
    Begin
      If Assigned(xmlFormulas) Then FreeAndNil(xmlFormulas);
      If Assigned(xmlCP) Then FreeAndNil(xmlCP);
      If Assigned(cdsCompQualidade) Then FreeAndNil(cdsCompQualidade);
      If Assigned(cdsRelMistura) Then FreeAndNil(cdsRelMistura);
      If Assigned(cdsLitrografia) Then FreeAndNil(cdsLitrografia);
      If Assigned(cdsArqCp) Then FreeAndNil(cdsArqCp);
    End;

begin
  intLinha := 1;
  intAutoInc := 1;
  strPat := fGetConfTinta('DUP').fGet('PATDUP');

  If Not FileExists(strPat + '\Formulas.xml') Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := False;
    limpar;
    Exit;
  End;

  If Not FileExists(strPat + '\PadraoRelMistQld.xml') Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := False;
    limpar;
    Exit;
  End;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'TRUNCATE TABLE DUP_CADDUP';
  qryGen.ExecSQL;

  qryGen.SQL.Text := 'SELECT * FROM DUP_CADDUP WHERE FALSE';
  qryGen.Open;

  xmlFormulas := TXMLDocument.Create(Self);
  xmlFormulas.FileName := strPat + '\Formulas.xml';
  xmlFormulas.Active := True;

  pRegistraAcao('Carregando arquivo de fórmulas, isso pode demorar alguns minutos...');
  xmlRegistro := xmlFormulas.ChildNodes.FindNode('xml');
  xmlRegistro := xmlRegistro.ChildNodes.FindNode('data');
  xmlRegistro := xmlRegistro.ChildNodes.First;
  RegistraAcao('Arquivo de fórmulas carregado com sucesso!');

  cdsCompQualidade := fXmlCompQualidadeToDataSet();
  cdsRelMistura    := fXmlPadraoRelMistQldToDataSet();
  cdsLitrografia   := fXmlLitrografiaToDataSet();

  If Not Assigned(xmlRegistro) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    limpar;
    Result := False;
    Exit;
  End;

  xmlCP := TXMLDocument.Create(Self);

  intPos := 1;
  pRegistraAcao('Cadastrando tintas...');
  intMaximo := xmlRegistro.ParentNode.ChildNodes.Count;
  While Assigned(xmlRegistro) Do
  Begin
    strLinhaCor := xmlRegistro.Attributes['LP'];
    strQualidade := xmlRegistro.Attributes['DQ'];
    strIdFormula := xmlRegistro.Attributes['ID'];

    SetLength(arrBases, 0);

    intNumArq := (StrToIntDef(strIdFormula, 0) div 90) + 1;
    If ((StrToIntDef(strIdFormula, 0) mod 90) = 0) Then
      intNumArq := intNumArq - 1;

    If Not FileExists(strPat + '\cp' + IntToStr(intNumArq) + '.xml') Then
    Begin
      pRegistraProgresso(0, intPos, intMaximo);
      intPos := intPos + 1;
      xmlRegistro := xmlRegistro.NextSibling;
      Continue;
    End;

//    If Assigned(cdsArqCp) Then
//       FreeAndNil(cdsArqCp);
//
//    cdsArqCp := fXmlCpToDataSet('cp' + IntToStr(intNumArq));

//    If Assigned(xmlCP) Then
//      FreeAndNil(xmlCp);


    xmlCP.Active := False;
    xmlCP.FileName := strPat + '\cp' + IntToStr(intNumArq) + '.xml';
    xmlCP.Active := True;

    xmlRegistroCP := xmlCP.ChildNodes.FindNode('xml').ChildNodes.FindNode('data').ChildNodes.First;
    xmlRegistroCP := fXmlProcurarValor(xmlRegistroCP, 'I', strIdFormula);

//    If Not cdsArqCp.Locate('I', strIdFormula, []) Then
//    Begin
//      pRegistraProgresso(0, intPos, xmlRegistro.ParentNode.ChildNodes.Count);
//      intPos := intPos + 1;
//      xmlRegistro := xmlRegistro.NextSibling;
//      Continue;
//    End;

    If Not Assigned(xmlRegistroCP) Then
    Begin
      pRegistraProgresso(0, intPos, intMaximo);
      intPos := intPos + 1;
      xmlRegistro := xmlRegistro.NextSibling;
      Continue;
    End;

    If Not cdsLitrografia.Locate('LINHA_PRODUTO;QUALIDADE',
      VarArrayOf([strLinhaCor, strQualidade]), []) Then
    Begin
      pRegistraAcao(Format('Não foi possivel encontrar a litografia da Linha: [%s], Qualidade: [%s] no arquivo litografia.xml',
        [strLinhaCor, strQualidade]));
      pRegistraProgresso(0, intPos, intMaximo);
      intPos := intPos + 1;
      xmlRegistro := xmlRegistro.NextSibling;
      Continue;
    End;

    blnSomenteConc := Not cdsRelMistura.Locate('LINHA_PRODUTO;DSCR_QUALIDADE', VarArrayOf([strLinhaCor, strQualidade]), []);

    strCatalisador   := '';
    fltPesEspCatal   := 0.0;
    fltRelacCatal    := 0.0;

    strDiluente      := '';
    fltPesEspDilul   := 0.0;
    fltRelacDilul    := 0.0;

    fltPartesTinta := cdsRelMistura.FieldByName('RELACAO').AsFloat;
    fltTotalPartes := cdsRelMistura.FieldByName('RELACAO').AsFloat;

    While (Not cdsRelMistura.Eof)
      And (Not blnSomenteConc)
      And (cdsRelMistura.FieldByName('LINHA_PRODUTO').AsString = strLinhaCor)
      And (cdsRelMistura.FieldByName('DSCR_QUALIDADE').AsString = strQualidade) Do
    Begin

      fltTotalPartes := fltTotalPartes + cdsRelMistura.FieldByName('VALOR').AsFloat;

      If cdsRelMistura.FieldByName('DSCR_TIPO_COMPONENTE').AsString = 'CATALISADOR' Then
      Begin
        strCatalisador := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
        fltRelacCatal := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
      End
      Else
      Begin
        strDiluente := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
        fltRelacDilul := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
      End;

      cdsRelMistura.Next;
    End;

    If Not fEmptyStr(strCatalisador) Then
    Begin
      cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
        VarArrayOf([strCatalisador, strLinhaCor, strQualidade]), []);

      fltPesEspCatal := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
    End;

    If Not fEmptyStr(strDiluente) Then
    Begin
      cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
        VarArrayOf([strDiluente, strLinhaCor, strQualidade]), []);

      fltPesEspDilul := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
    End;

    While Assigned(xmlRegistroCP) Do
    Begin


      If (xmlRegistroCP.Attributes['PP'] <> Null) And (fFormataFloatDupont(xmlRegistroCP.Attributes['PP']) > 0) Then
        fltPesoTeorico := fFormataFloatDupont(xmlRegistroCP.Attributes['PP'])
      Else
        fltPesoTeorico := fFormataFloatDupont(xmlRegistroCP.Attributes['PT']);

      fltPesoTeorico := fltPesoTeorico;

      fltPeso1 := (((fFormataFloatDupont(xmlRegistroCP.Attributes['PC']) * 100) / 100) * 100) / (100 / fltPesoTeorico);

      SetLength(arrBases, Length(arrBases) + 1);
      arrBases[Length(arrBases) - 1].strCodBas :=  xmlRegistroCP.Attributes['CC']; //cdsArqCp.FieldByName('CC').AsString;
      arrBases[Length(arrBases) - 1].strTipBas := 'B';
      arrBases[Length(arrBases) - 1].fltQtdCon := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;

      arrBases[Length(arrBases) - 1].fltQtdDil := (fFormataFloatDupont(xmlRegistroCP.Attributes['PC']) * fltPesoTeorico) *
        (fltPartesTinta / fltTotalPartes) *
        (cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100);

//      arrBases[Length(arrBases) - 1].fltQtdDil := RoundTo(arrBases[Length(arrBases) - 1].fltQtdDil, -1);

      xmlRegistroCP := fXmlProcurarValor(xmlRegistroCP.NextSibling, 'I', strIdFormula);
    End;

    If (Not fEmptyStr(strCatalisador)) Then
    Begin

      fltPeso1 := (fltRelacCatal / fltTotalPartes) * (fltPesEspCatal / 100);

      SetLength(arrBases, Length(arrBases) + 1);
      arrBases[Length(arrBases) - 1].strCodBas := strCatalisador;
      arrBases[Length(arrBases) - 1].strTipBas := 'C';
      arrBases[Length(arrBases) - 1].fltQtdCon := 0.0;
      arrBases[Length(arrBases) - 1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
    End;

    If (Not fEmptyStr(strDiluente)) Then
    Begin
      fltPeso1 := (fltRelacDilul / fltTotalPartes) * (fltPesEspDilul / 100);

      SetLength(arrBases, Length(arrBases) + 1);
      arrBases[Length(arrBases) - 1].strCodBas := strDiluente;
      arrBases[Length(arrBases) - 1].strTipBas := 'D';
      arrBases[Length(arrBases) - 1].fltQtdCon := 0.0;
      arrBases[Length(arrBases) - 1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
    End;

    qryGen.Insert;
    qryGen.FieldByName('DUP_CODSEQ').Value := fStrZero(intLinha, 6);
    qryGen.FieldByName('DUP_CODDUP').Value := xmlRegistro.Attributes['C'];
    qryGen.FieldByName('DUP_CODOEM').Value := xmlRegistro.Attributes['P'];
    qryGen.FieldByName('DUP_LINHA_').Value := strLinhaCor;
    qryGen.FieldByName('DUP_QUALID').Value := strQualidade;
    qryGen.FieldByName('DUP_ALTERN').Value := xmlRegistro.Attributes['A'];
    qryGen.FieldByName('DUP_REGIAO').Value := xmlRegistro.Attributes['DP'];
    qryGen.FieldByName('DUP_DESCRI').Value := xmlRegistro.Attributes['D'];
    qryGen.FieldByName('DUP_MONTAD').Value := xmlRegistro.Attributes['DM'];
    qryGen.FieldByName('DUP_ANOCOR').Value := xmlRegistro.Attributes['AN'];
    qryGen.FieldByName('DUP_CODEMP').AsString := VS_strCodEmp;
    qryGen.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutoInc, VS_strCodEmp);
    qryGen.FieldByName('DUP_LITRAG').AsFloat := cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat;

    For intCont := Low(arrBases) To High(arrBases) Do
    Begin
      qryGen.FieldByName('DUP_BASE' + fStrZero(intCont + 1, 2)).AsString := arrBases[intCont].strCodBas;
      qryGen.FieldByName('DUP_QTDC' + fStrZero(intCont + 1, 2)).AsFloat := arrBases[intCont].fltQtdCon;
      qryGen.FieldByName('DUP_QTDD' + fStrZero(intCont + 1, 2)).AsFloat := arrBases[intCont].fltQtdDil;
      qryGen.FieldByName('DUP_TIPB' + fStrZero(intCont + 1, 2)).AsString := arrBases[intCont].strTipBas;
    End;

    qryGen.FieldByName('DUP_MD5KEY').AsString := fGetMd5MySql(qryGen.FieldByName('DUP_CODDUP').AsString + qryGen.FieldByName('DUP_CODOEM').AsString +
                                                              qryGen.FieldByName('DUP_LINHA_').AsString + qryGen.FieldByName('DUP_QUALID').AsString +
                                                              qryGen.FieldByName('DUP_ALTERN').AsString + qryGen.FieldByName('DUP_REGIAO').AsString +
                                                              qryGen.FieldByName('DUP_DESCRI').AsString + qryGen.FieldByName('DUP_MONTAD').AsString +
                                                              qryGen.FieldByName('DUP_ANOCOR').AsString +
                                      qryGen.FieldByName('DUP_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC01').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD01').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB01').AsString +
                                      qryGen.FieldByName('DUP_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC02').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD02').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB02').AsString +
                                      qryGen.FieldByName('DUP_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC03').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD03').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB03').AsString +
                                      qryGen.FieldByName('DUP_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC04').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD04').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB04').AsString +
                                      qryGen.FieldByName('DUP_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC05').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD05').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB05').AsString +
                                      qryGen.FieldByName('DUP_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC06').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD06').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB06').AsString +
                                      qryGen.FieldByName('DUP_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC07').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD07').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB07').AsString +
                                      qryGen.FieldByName('DUP_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC08').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD08').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB08').AsString +
                                      qryGen.FieldByName('DUP_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC09').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD09').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB09').AsString +
                                      qryGen.FieldByName('DUP_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC10').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD10').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB10').AsString +
                                      qryGen.FieldByName('DUP_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC11').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD11').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB11').AsString +
                                      qryGen.FieldByName('DUP_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC12').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD12').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB12').AsString +
                                      qryGen.FieldByName('DUP_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC13').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD13').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB13').AsString +
                                      qryGen.FieldByName('DUP_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC14').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD14').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB14').AsString +
                                      qryGen.FieldByName('DUP_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC15').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD15').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB15').AsString +
                                      qryGen.FieldByName('DUP_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC16').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD16').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB16').AsString +
                                      qryGen.FieldByName('DUP_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC17').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD17').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB17').AsString +
                                      qryGen.FieldByName('DUP_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC18').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD18').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB18').AsString +
                                      qryGen.FieldByName('DUP_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC19').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD19').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB19').AsString +
                                      qryGen.FieldByName('DUP_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDC20').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryGen.FieldByName('DUP_QTDD20').AsFloat), ',', '.') + qryGen.FieldByName('DUP_TIPB20').AsString);

    qryGen.Post;
    intLinha := intLinha + 1;
    intAutoInc := intAutoInc + 1;
//    FreeAndNil(cdsArqCp);
    if (intPos mod (intMaximo div 100)) = 0 then
    begin
      qryGen.Close;
      qryGen.Open;
    end;

    pRegistraProgresso(0, intPos, intMaximo);
    xmlRegistro := xmlRegistro.NextSibling;
    intPos := intPos + 1;
  End;

  limpar();
  Result := True;
  pRegistraAcao('Tintas cadastradas com sucesso!');

  If Assigned(xmlCP) Then
    FreeAndNil(xmlCP);
end;

function TDuponAutomotiva.fGravaNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM DUP_CADNFM ';
  qryGen.Open;

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    fGeraNovasFormulas(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizadas com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TDuponAutomotiva.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaNovasFormulas();
end;

function TDuponAutomotiva.fXmlCompQualidadeToDataSet: TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;
    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
begin
  strPat := fGetConfTinta('DUP').fGet('PATDUP');
  strPat := strPat + '\compqualidade.xml';

  If Not FileExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strPat;
  xmlGen.Active := True;

  Result := fXmlToDataSet(strPat);
  Result.Open;

  xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
  xmlRegistro := xmlNoInsert.ChildNodes.First;

  If Not Assigned(xmlRegistro) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  intQtdRegistros := xmlNoInsert.ChildNodes.Count;
  intQtdAtual := 1;

  While (Assigned(xmlRegistro)) Do
  Begin
    Result.Insert;

    Result.FieldByName('VCOMPONENTE').Value := xmlRegistro.Attributes['VCOMPONENTE'];
    Result.FieldByName('VPESO').AsFloat := fFormataFloatDupont(xmlRegistro.Attributes['VPESO']);
    Result.FieldByName('VQUALIDADE').Value := xmlRegistro.Attributes['VQUALIDADE'];
    Result.FieldByName('VTIPO').Value := xmlRegistro.Attributes['VTIPO'];
    Result.FieldByName('VCODCOMERCIAL').Value := xmlRegistro.Attributes['VCODCOMERCIAL'];
    Result.FieldByName('VLINHA_PRODUTO').Value := xmlRegistro.Attributes['VLINHA_PRODUTO'];

    Result.Post;
    
    xmlRegistro := xmlRegistro.NextSibling;
    pRegistraProgresso(0, intQtdAtual, intQtdRegistros);
    intQtdAtual := intQtdAtual + 1;
  End;

  FreeAndNil(xmlGen);
end;



function TDuponAutomotiva.fXmlLitrografiaToDataSet: TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;
    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
begin
  strPat := fGetConfTinta('DUP').fGet('PATDUP');
  strPat := strPat + '\litografia.xml';

  If Not FileExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strPat;
  xmlGen.Active := True;

  Result := fXmlToDataSet(strPat);
  Result.Open;

  xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
  xmlRegistro := xmlNoInsert.ChildNodes.First;

  If Not Assigned(xmlRegistro) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  intQtdRegistros := xmlNoInsert.ChildNodes.Count;
  intQtdAtual := 1;

  While (Assigned(xmlRegistro)) Do
  Begin

    Result.Insert;

    Result.FieldByName('LINHA_PRODUTO').Value := xmlRegistro.Attributes['LINHA_PRODUTO'];
    Result.FieldByName('QUALIDADE').Value := xmlRegistro.Attributes['QUALIDADE'];
    Result.FieldByName('COD_LITOGRAFIA').Value := xmlRegistro.Attributes['COD_LITOGRAFIA'];
    Result.FieldByName('DSCR_LITOGRAFIA').Value := xmlRegistro.Attributes['DSCR_LITOGRAFIA'];
    Result.FieldByName('VOLUME_NOMINAL').Value := xmlRegistro.Attributes['VOLUME_NOMINAL'];
    Result.FieldByName('VOLUME_MAXIMO').Value := xmlRegistro.Attributes['VOLUME_MAXIMO'];
    Result.FieldByName('VOLUME_ENCHIMENTO').Value := xmlRegistro.Attributes['VOLUME_ENCHIMENTO'];
    Result.FieldByName('COD_EMB').Value := xmlRegistro.Attributes['COD_EMB'];
    Result.FieldByName('PADRAO_LINHA').Value := xmlRegistro.Attributes['PADRAO_LINHA'];
    Result.FieldByName('PADRAO_QUALIDADE').Value := xmlRegistro.Attributes['PADRAO_QUALIDADE'];

    Result.Post;

    xmlRegistro := xmlRegistro.NextSibling;
    pRegistraProgresso(0, intQtdAtual, intQtdRegistros);
    intQtdAtual := intQtdAtual + 1;
  End;

  FreeAndNil(xmlGen);
end;

function TDuponAutomotiva.fXmlPadraoRelMistQldToDataSet: TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;
    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
begin
  strPat := fGetConfTinta('DUP').fGet('PATDUP');
  strPat := strPat + '\PadraoRelMistQld.xml';

  If Not FileExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strPat;
  xmlGen.Active := True;

  Result := fXmlToDataSet(strPat);
  Result.Open;

  xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
  xmlRegistro := xmlNoInsert.ChildNodes.First;

  If Not Assigned(xmlRegistro) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  intQtdRegistros := xmlNoInsert.ChildNodes.Count;
  intQtdAtual := 1;

  While (Assigned(xmlRegistro)) Do
  Begin
    Result.Insert;

    Result.FieldByName('RELACAO').Value := xmlRegistro.Attributes['RELACAO'];
    Result.FieldByName('LINHA_PRODUTO').Value := xmlRegistro.Attributes['LINHA_PRODUTO'];
    Result.FieldByName('DSCR_QUALIDADE').Value := xmlRegistro.Attributes['DSCR_QUALIDADE'];
    Result.FieldByName('DSCR_TIPO_COMPONENTE').Value := xmlRegistro.Attributes['DSCR_TIPO_COMPONENTE'];
    Result.FieldByName('COD_COMPONENTE_RELACAO').Value := xmlRegistro.Attributes['COD_COMPONENTE_RELACAO'];
    Result.FieldByName('VALOR').AsFloat :=  fFormataFloatDupont(xmlRegistro.Attributes['VALOR']);

    Result.Post;

    xmlRegistro := xmlRegistro.NextSibling;
    pRegistraProgresso(0, intQtdAtual, intQtdRegistros);
    intQtdAtual := intQtdAtual + 1;
  End;

  FreeAndNil(xmlGen);
end;

function TDuponAutomotiva.fXmlProcurarValor(xmlNoPai: IXMLNode;
  strAtributo: String; valor: String): IXMLNode;
begin
  Result := xmlNoPai;

  While Assigned(Result) Do
  Begin

    If Result.Attributes[strAtributo] = valor Then
    Begin
      Exit;
    End;

    Result := Result.NextSibling;
  End;
end;

function TDuponAutomotiva.fXmlProdutoToDataSet: TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;

    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
begin
  strPat := fGetConfTinta('DUP').fGet('PATDUP');
  strPat := strPat + '\Produto.xml';

  If Not FileExists(strPat) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strPat;
  xmlGen.Active := True;

  Result := fXmlToDataSet(strPat);
  Result.Open;

  xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data').ChildNodes.FindNode('insert');
  xmlRegistro := xmlNoInsert.ChildNodes.First;

  If Not Assigned(xmlRegistro) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strPat]), ['OK']);
    Result := nil;
    Exit;
  End;

  intQtdRegistros := xmlNoInsert.ChildNodes.Count;
  intQtdAtual := 1;

  While (Assigned(xmlRegistro)) Do
  Begin

    If xmlRegistro.Attributes['TIPO_PRODUTO'] <> 'EMBALAGEM' Then
    Begin
      Result.Insert;

      Result.FieldByName('LINHA_PRODUTO').Value := xmlRegistro.Attributes['LINHA_PRODUTO'];
      Result.FieldByName('TIPO_PRODUTO').Value := xmlRegistro.Attributes['TIPO_PRODUTO'];
      Result.FieldByName('PRODUTO').Value := xmlRegistro.Attributes['PRODUTO'];
      Result.FieldByName('DSCR_COMPONENTE').Value := xmlRegistro.Attributes['DSCR_COMPONENTE'];
      Result.FieldByName('LITOGRAFIA').Value := xmlRegistro.Attributes['LITOGRAFIA'];
      Result.FieldByName('COD_EMBALAGEM').Value := xmlRegistro.Attributes['COD_EMBALAGEM'];
      Result.FieldByName('EMBALAGEM').Value := xmlRegistro.Attributes['EMBALAGEM'];
      Result.FieldByName('VALOR').Value := xmlRegistro.Attributes['VALOR'];
      Result.FieldByName('VALOR_GRAMA').Value := xmlRegistro.Attributes['VALOR_GRAMA'];
      Result.FieldByName('TIPO').Value := xmlRegistro.Attributes['TIPO'];
      Result.FieldByName('UM').Value := xmlRegistro.Attributes['UM'];
      Result.FieldByName('COMPONENTE').Value := xmlRegistro.Attributes['COMPONENTE'];
      Result.FieldByName('TIPO_PRODUTO_ESP').Value := xmlRegistro.Attributes['TIPO_PRODUTO_ESP'];

      Result.Post;
    End;

    xmlRegistro := xmlRegistro.NextSibling;
    pRegistraProgresso(0, intQtdAtual, intQtdRegistros);
    intQtdAtual := intQtdAtual + 1;
  End;

  FreeAndNil(xmlGen);
end;

function TDuponAutomotiva.fXmlToDataSet(strArquivo: String): TUniClientDataSet;
  Var
    xmlGen: TXMLDocument;
    xmlNoElementType: IXMLNode;
    xmlRegistro: IXMLNode;

    nomeCampo: String;
    tipoCampo: TFieldType;
    tamanhoCampo: Integer;
    requerido: Boolean;

begin

  If Not FileExists(strArquivo) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strArquivo]), ['OK']);
    Result := nil;
    Exit;
  End;

  xmlGen := TXMLDocument.Create(Self);
  xmlGen.FileName := strArquivo;
  xmlGen.Active := True;

  xmlNoElementType := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('Schema').ChildNodes.FindNode('ElementType');

  If Not Assigned(xmlNoElementType) Then
  Begin
    fMensagem('ATENÇÃO', Format('O arquivo %s não está no formato esperado', [strArquivo]), ['OK']);
    Result := nil;
    Exit;
  End;

  Result := TUniClientDataSet.Create(Self);
  xmlRegistro := xmlNoElementType.ChildNodes.FindNode('AttributeType');


  While (Assigned(xmlRegistro)) Do
  Begin

    If xmlRegistro.Attributes['name'] = Null Then
      Break;

    nomeCampo := xmlRegistro.Attributes['name'];

    If (xmlRegistro.ChildNodes.FindNode('datatype').Attributes['dt:type'] = 'string') Then
    Begin
      tipoCampo := ftString;
      tamanhoCampo := xmlRegistro.ChildNodes.FindNode('datatype').Attributes['dt:maxLength'];
    End
    Else
    Begin
      tipoCampo := ftFloat;
      tamanhoCampo := 0;
    End;

    If xmlRegistro.Attributes['rs:nullable'] = null Then
      requerido := False
    Else
      requerido := Not xmlRegistro.Attributes['rs:nullable'];



    Result.FieldDefs.Add(nomeCampo, tipoCampo, tamanhoCampo, requerido);

    xmlRegistro := xmlRegistro.NextSibling;

  End;

  Result.CreateDataSet;

  FreeAndNil(xmlGen);
end;

//procedure TDuponAutomotiva.pExibeDataSet(dataSet: TDataSet);
//  Var
//    dataSource: TDataSource;
//    form: TForm;
//    grid: TDBGridCitel;
//begin
//  form := TForm.Create(Self);
//  dataSource := fCriaDataSource(dataSet);
//  grid := TDBGridCitel, DBGrids.Create(Self);
//  grid.Parent := form;
//  grid.Align := alClient;
//  grid.DataSource := dataSource;
//  form.ShowModal;
//  FreeAndNil(form);
//end;
function fRetProCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(DUP_CODSEQ),0) + 1 PROX FROM DUP_CADDUP;';
    qryGen.Open;

    Result := qryGen.FieldByName('PROX').AsInteger;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fGetMd5MySQl(strTexto: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.SQL.Text := 'SELECT UPPER(CAST(MD5("' + strTexto + '") AS CHAR)) SAIDA';
    qryGen.Open;
    Result := qryGen.FieldByName('SAIDA').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.

