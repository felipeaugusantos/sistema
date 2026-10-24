unit untQckDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, Uni, frxDBSet, untFuncoesGenerica;

type
  TfrmQckDAV = class(TForm)
    frxDAV: TfrxReport;
    frxItens: TfrxDBDataset;
    frxDocumento: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
  private
    FPais: TPais;
    procedure pCarregarOrcamento(strNumDoc, strEspDoc: String; qryFatGor, qryFatDor: TUniQuery);
  public
    { Public declarations }
    procedure pImprimirDAV(strNumDoc, strEspDoc, strFila, strSaida: String);
    procedure pImprimirDAVECF(strNumDoc, strEspDoc: String);
  end;

implementation

uses  untFuncoesSimples, untFiscal, StrUtils, untCfgRel;

{$R *.dfm}

{ TfrmQckDAV }

procedure TfrmQckDAV.FormCreate(Sender: TObject);
begin
  FPais := fSetaPais;
end;

procedure TfrmQckDAV.pCarregarOrcamento(strNumDoc, strEspDoc: String;
  qryFatGor, qryFatDor: TUniQuery);
begin
  qryFatGor.SQL.Clear;
  qryFatGor.SQL.Add('SELECT ');
  qryFatGor.SQL.Add('  FGO_NUMDOC, ');
  qryFatGor.SQL.Add('  FGO_VLRCON, ');
  qryFatGor.SQL.Add('  FGO_TOTPRO, ');
  qryFatGor.SQL.Add('  FGO_DESESP, ');
  qryFatGor.SQL.Add('  FGO_TOTRET, ');
  qryFatGor.SQL.Add('  FGO_TOTSER, ');
  qryFatGor.SQL.Add('  FGO_TOTFRE, ');

  If (strEspDoc='OR') And (fCfgSis('IFVLOR', varBoolean)) Then
    qryFatGor.SQL.Add('  FGO_VALORC, ');

  If fCfgSis('CONIPI', varBoolean) Then
    qryFatGor.SQL.Add('  FGO_TOTIPI, ')
  Else
    qryFatGor.SQL.Add('  0.00 AS FGO_TOTIPI, ');

  qryFatGor.SQL.Add('  EMP_NOMEMP, ');
  qryFatGor.SQL.Add('  EMP_C_G_C_, ');
  qryFatGor.SQL.Add('  IFNULL(FGO_NOMCON, CLI_NOMCLI) AS CLI_NOMCLI, ');
  qryFatGor.SQL.Add('  IFNULL(FGO_CGCCON, CLI_C_G_C_) AS CLI_C_G_C_  ');
  qryFatGor.SQL.Add('FROM ');
  qryFatGor.SQL.Add('  FATGOR ');

  If (strEspDoc='OR') And (fCfgSis('IFVLOR', varBoolean)) Then
    qryFatGor.SQL.Add('  JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');

  qryFatGor.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = FGO_CODEMP ');
  qryFatGor.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
  qryFatGor.SQL.Add('WHERE ');
  qryFatGor.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
  qryFatGor.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
  qryFatGor.SQL.Add('  FGO_CODEMP = :CODEMP ');

  qryFatGor.ParamByName('NUMDOC').AsString := strNumDoc;
  qryFatGor.ParamByName('ESPDOC').AsString := strEspDoc;
  qryFatGor.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryFatGor.Open;

  qryFatDor.SQL.Clear;
  qryFatDor.SQL.Add('SELECT ');
  qryFatDor.SQL.Add('  FDO_DESCRI, ');
  qryFatDor.SQL.Add('  FDO_QTDITE, ');
  qryFatDor.SQL.Add('  FDO_UNITAR, ');
  qryFatDor.SQL.Add('  FDO_TOTITE  ');

  qryFatDor.SQL.Add('FROM ');
  qryFatDor.SQL.Add('  FATDOR ');
  qryFatDor.SQL.Add('WHERE ');
  qryFatDor.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryFatDor.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryFatDor.SQL.Add('  FDO_CODEMP = :CODEMP ');

  qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
  qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
  qryFatDor.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryFatDor.Open;
end;

procedure TfrmQckDAV.pImprimirDAV(strNumDoc, strEspDoc, strFila, StrSaida: String);
  Var
    qryFatGor: TUniQuery;
    qryFatDor: TUniQuery;
    qryCfgRel: TUniQuery;
    strFilaORPD: String;
    strTipImpORPD: String;
begin
  qryFatGor := fCriaQuery;
  qryFatDor := fCriaQuery;

  pCarregarOrcamento(strNumDoc, strEspDoc, qryFatGor, qryFatDor);

  frxItens.DataSet := qryFatDor;
  frxDocumento.DataSet := qryFatGor;

  frxDAV.Script.Variables['ESPECIE'] := IIF(strEspDoc='OR', 'ORÇAMENTO', 'PEDIDO');
  frxDAV.Script.Variables['NUMDOC'] := fStrZero(qryFatGor.FieldByName('FGO_NUMDOC').AsString, 13);
  frxDAV.Script.Variables['CGCEMP'] := fFormataCpfCgc(qryFatGor.FieldByName('EMP_C_G_C_').AsString, FPais);
  frxDAV.Script.Variables['RAZSOC'] := qryFatGor.FieldByName('EMP_NOMEMP').AsString;
  frxDAV.Script.Variables['NOMCLI'] := qryFatGor.FieldByName('CLI_NOMCLI').AsString;
  frxDAV.Script.Variables['CGCCLI'] := fFormataCpfCgc(qryFatGor.FieldByName('CLI_C_G_C_').AsString, FPais);

  If (strEspDoc='OR') And (fCfgSis('IFVLOR', varBoolean)) Then
  Begin
    frxDAV.FindObject('PageFooter1').Height    := 50;
    frxDAV.FindObject('rllRodaPeMsg').Top      := 16;
    frxDAV.FindObject('rllValidadeOR').Visible := True;
    frxDAV.FindObject('rllDtaValOR').Visible   := True;
  End;

  qryCfgRel := fCriaQuery;
  Try
    pCarregaConfImpr(qryCfgRel, 'frmFatVendas_' + strEspDoc);
    fPreImpressao(qryCfgRel, strFilaORPD, strTipImpORPD, False, strSaida);
  Finally
    FreeAndNil(qryCfgRel);
  End;

  If (fEmptyStr(strFila)) Then
    strFila := strFilaORPD;

  frxDAV.PrintOptions.Printer := strFila;

  frxDAV.PrintOptions.ShowDialog := fEmptyStr(frxDAV.PrintOptions.Printer);

  If strSaida = 'V' Then
    pPreviewReport('frmFatVendas_' + strEspDoc, 'Impressão DAV', frxDAV)
  Else
  Begin
    frxDAV.PrepareReport;
    pPrintReport('frmFatVendas_' + strEspDoc, 'Impressão DAV', strFila, frxDAV);
  End;

  FreeAndNil(qryFatGor);
  FreeAndNil(qryFatDor);
end;

procedure TfrmQckDAV.pImprimirDAVECF(strNumDoc, strEspDoc: String);
  Var
    strTitulo: String;
    qryFatGor: TUniQuery;
    qryFatDor: TUniQuery;

    strQtdIte,
    strUnitar,
    strTotIte,
    strDesEsp,
    strTotRet,
    strTotSer,
    strTotFre,
    strTotIpi,
    strVlrCon: String;
  Const
    COLECF = 48;
begin
  qryFatGor := fCriaQuery(Self);
  qryFatDor := fCriaQuery(Self);

  pCarregarOrcamento(strNumDoc, strEspDoc, qryFatGor, qryFatDor);

  strTitulo := IIF(strEspDoc='OR', 'ORÇAMENTO', 'PEDIDO');
  If VS_objFiscal.fAbreRelatorioGerencial() Then
  Begin

    VS_objFiscal.fRelatorioGerencial(fPadC('DOCUMENTO AUXILIAR DE VENDA', COLECF));
    VS_objFiscal.fRelatorioGerencial(fPadC(strTitulo, COLECF));
    VS_objFiscal.fRelatorioGerencial(fPadC('NÃO É DOCUMENTO FISCAL - NÃO É VÁLIDO', COLECF));
    VS_objFiscal.fRelatorioGerencial(fPadC('COMO RECIBO E COMO GARANTIA DE', COLECF));
    VS_objFiscal.fRelatorioGerencial(fPadC('MERCADORIA - NÃO COMPROVA PAGAMENTO', COLECF));

    VS_objFiscal.fRelatorioGerencial('   ');

    VS_objFiscal.fRelatorioGerencial(fPadC('Identificação do Estabelecimento Emitente', COLECF));
    VS_objFiscal.fRelatorioGerencial('Denominação: ' + LeftStr(qryFatGor.FieldByName('EMP_NOMEMP').AsString, 23));
    VS_objFiscal.fRelatorioGerencial('CNPJ: ' + fFormataCpfCgc(qryFatGor.FieldByName('EMP_C_G_C_').AsString, FPais));

    VS_objFiscal.fRelatorioGerencial('   ');

    VS_objFiscal.fRelatorioGerencial(fPadC('Identificação do Destinatário', COLECF));
    VS_objFiscal.fRelatorioGerencial('Nome: ' + LeftStr(qryFatGor.FieldByName('CLI_NOMCLI').AsString, 33));
    VS_objFiscal.fRelatorioGerencial('CPNJ/CPF: ' + fFormataCpfCgc(qryFatGor.FieldByName('CLI_C_G_C_').AsString, FPais));
    VS_objFiscal.fRelatorioGerencial('Nº do Documento: ' + fStrZero(qryFatGor.FieldByName('FGO_NUMDOC').AsString, 13));
    VS_objFiscal.fRelatorioGerencial('Nº do Documento Fiscal: ');

    VS_objFiscal.fRelatorioGerencial('   ');

    VS_objFiscal.fRelatorioGerencial('PRODUTO                  QTDE.  UNITAR.    TOTAL');
    VS_objFiscal.fRelatorioGerencial('------------------------------------------------');

    While (Not qryFatDor.Eof) Do
    Begin
      strQtdIte := fPadL(FloatToStrF(qryFatDor.FieldByName('FDO_QTDITE').AsFloat, ffNumber, 12, 2), 6);
      strUnitar := fPadL(FloatToStrF(qryFatDor.FieldByName('FDO_UNITAR').AsFloat, ffNumber, 12, 2), 8);
      strTotIte := fPadL(FloatToStrF(qryFatDor.FieldByName('FDO_TOTITE').AsFloat, ffNumber, 12, 2), 8);

      VS_objFiscal.fRelatorioGerencial(LeftStr(qryFatDor.FieldByName('FDO_DESCRI').AsString, 40));
      VS_objFiscal.fRelatorioGerencial(fstrEspaco(' ', 24) + strQtdIte + ' ' + strUnitar + ' ' + strTotIte);

      qryFatDor.Next;
    End;

    strTotIte := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_TOTPRO').AsFloat, ffNumber, 12, 2), 10);
    strDesEsp := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_DESESP').AsFloat, ffNumber, 12, 2), 10);
    strTotRet := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_TOTRET').AsFloat, ffNumber, 12, 2), 10);
    strTotSer := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_TOTSER').AsFloat, ffNumber, 12, 2), 10);
    strTotFre := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_TOTFRE').AsFloat, ffNumber, 12, 2), 10);
    strTotIpi := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_TOTIPI').AsFloat, ffNumber, 12, 2), 10);
    strVlrCon := fPadL(FloatToStrF(qryFatGor.FieldByName('FGO_VLRCON').AsFloat, ffNumber, 12, 2), 10);

    VS_objFiscal.fRelatorioGerencial(fPadL('Total Produtos...: ', COLECF-10) + strTotIte);

    If fStrToFloat(strDesEsp) <> 0.00 Then
      VS_objFiscal.fRelatorioGerencial(fPadL('Desconto Especial: ', COLECF-10) + strDesEsp);

    If fStrToFloat(strTotRet) <> 0.00 Then
      VS_objFiscal.fRelatorioGerencial(fPadL('Sub. Tributaria..: ', COLECF-10) + strTotRet);

    If fStrToFloat(strTotSer) <> 0.00 Then
      VS_objFiscal.fRelatorioGerencial(fPadL('Total Servico(s).: ', COLECF-10) + strTotSer);

    If fStrToFloat(strTotFre) <> 0.00 Then
      VS_objFiscal.fRelatorioGerencial(fPadL('Valor do Frete...: ', COLECF-10) + strTotFre);

    If fStrToFloat(strTotIpi) <> 0.00 Then
      VS_objFiscal.fRelatorioGerencial(fPadL('Total do IPI.....: ', COLECF-10) + strTotIpi);

    VS_objFiscal.fRelatorioGerencial(fPadL('Total Geral......: ', COLECF-10) + strVlrCon);

    If (strEspDoc='OR') And (fCfgSis('IFVLOR', varBoolean)) Then
    Begin
      VS_objFiscal.fRelatorioGerencial(fPadC(' ', COLECF));
      VS_objFiscal.fRelatorioGerencial(fPadR('Validade do Orçamento: ' +
                                       FormatDateTime('dd/mm/yyyy', qryFatGor.FieldByName('FGO_VALORC').AsDateTime), COLECF));
    End;

    VS_objFiscal.fRelatorioGerencial(fPadC(' ', COLECF));
    VS_objFiscal.fRelatorioGerencial(fPadC('É vedada a autenticação deste documento', COLECF));

    VS_objFiscal.fFechaRelatorioGerencial();
  End;

  FreeAndNil(qryFatGor);
  FreeAndNil(qryFatDor);
end;

end.
