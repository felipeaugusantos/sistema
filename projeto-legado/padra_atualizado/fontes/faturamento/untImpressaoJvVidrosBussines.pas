unit untImpressaoJvVidrosBussines;

interface

uses
  SysUtils, DB, UniClientDataSet, untImpressaoEspecifica, untImpressaoJvVidrosIntf,
  Uni, frxClass, StrUtils, Forms;

type
  TImpressaoJvVidrosBussines = Class(TImpressaoEspecifica)
  private
    procedure pMontaResumoDespesas(frxImpressao: TfrxReport; objImpDadosJvVidros: IImpressaoJvVidrosIntf);
    procedure pCarregaInformacoesVidro(frxImpressao: TfrxReport; objImpDadosJvVidros: IImpressaoJvVidrosIntf);
  public
    procedure pCriaClients; override;

    procedure pPreencheCabecalho(objImpDadosJvVidros: IImpressaoJvVidrosIntf); overload;
    procedure pPreencheItens(objImpDadosJvVidros: IImpressaoJvVidrosIntf; qryItens: TDataset; blnImpDescSimp: Boolean); overload;
    procedure pPreencheRodape(objImpDadosJvVidros: IImpressaoJvVidrosIntf); overload;
    procedure pImprimeDocumento(objImpDadosJvVidros: IImpressaoJvVidrosIntf); overload;

    function fGeraDocumento(objImpDadosJvVidros: IImpressaoJvVidrosIntf): String;
  End;

implementation

uses untFuncoesSimples, untFuncoesGenerica, untFatDigEstruturaVidro;

{ TImpressaoJvVidrosBussines }

function TImpressaoJvVidrosBussines.fGeraDocumento(objImpDadosJvVidros: IImpressaoJvVidrosIntf): String;
  Var
    strExecutavel,
    strNomeArquivo: String;
begin
  With FModuloImpEspecifica Do
  Begin
    frxImpressaoJvVidrosOR_PD_J.DotMatrixReport           := False;
    frxImpressaoJvVidrosOR_PD_J.PrintOptions.PrintMode    := pmScale;
    frxImpressaoJvVidrosOR_PD_J.PrintOptions.PrintOnSheet := 9; //A4

    pMontaResumoDespesas(frxImpressaoJvVidrosOR_PD_J, objImpDadosJvVidros);

    TfrxMemoView(frxImpressaoJvVidrosOR_PD_J.FindObject('rllEntrega')).Visible := SameText(fCfgSis('END80C', varString), '2');
    TfrxMemoView(frxImpressaoJvVidrosOR_PD_J.FindObject('rllValUniTit')).Visible := objImpDadosJvVidros.blnComPre;
    TfrxMemoView(frxImpressaoJvVidrosOR_PD_J.FindObject('rllValTotTit')).Visible := objImpDadosJvVidros.blnComPre;
    TfrxMemoView(frxImpressaoJvVidrosOR_PD_J.FindObject('rlbValUni')).Visible    := objImpDadosJvVidros.blnComPre;
    TfrxMemoView(frxImpressaoJvVidrosOR_PD_J.FindObject('rlbValTot')).Visible    := objImpDadosJvVidros.blnComPre;

    strExecutavel := ExtractFilePath(Application.ExeName);

    If Not DirectoryExists(strExecutavel+'PedidoOrcamento') Then
      CreateDir(strExecutavel+'PedidoOrcamento');

    If SameText(objImpDadosJvVidros.strEspDoc, 'PD') Then
    Begin
      If (fCfgSis('EXPDOR') = 1) Then
        strNomeArquivo := 'PD_' + objImpDadosJvVidros.strNumDoc + IIF(objImpDadosJvVidros.strTipExp = 'P','.pdf','.xls')
      Else
        strNomeArquivo := 'PD_' + objImpDadosJvVidros.strNumDoc + IIF(objImpDadosJvVidros.strTipExp = 'P','.pdf','.ods');
    End
    Else
    Begin
      If (fCfgSis('EXPDOR') = 1) Then
        strNomeArquivo := 'OR_' + objImpDadosJvVidros.strNumDoc + IIF(objImpDadosJvVidros.strTipExp = 'P','.pdf','.xls')
      Else
        strNomeArquivo := 'OR_' + objImpDadosJvVidros.strNumDoc + IIF(objImpDadosJvVidros.strTipExp = 'P','.pdf','.ods');
    End;

    If objImpDadosJvVidros.strTipExp = 'P' Then
    Begin
      frxImpressaoJvVidrosOR_PD_J.PrepareReport;
      frxExportaPDF.FileName    := strNomeArquivo;
      frxExportaPDF.DefaultPath := strExecutavel + 'PedidoOrcamento';
      frxExportaPDF.ShowDialog  := False;
      frxImpressaoJvVidrosOR_PD_J.Export(frxExportaPDF);
    End
    Else
    Begin
      frxImpressaoJvVidrosOR_PD_J.PrepareReport;

      If ((fCfgSis('EXPDOR')) = 1) Then
      Begin
        frxExportaXLS.FileName    := strNomeArquivo;
        frxExportaXLS.DefaultPath := strExecutavel + 'PedidoOrcamento';
        frxExportaXLS.ShowDialog  := False;
        frxExportaXLS.AsText := True;
        frxImpressaoJvVidrosOR_PD_J.Export(frxExportaXLS);
      End
      Else
      Begin
        frxExportaODS.FileName    := strNomeArquivo;
        frxExportaODS.DefaultPath := strExecutavel + 'PedidoOrcamento';
        frxExportaODS.ShowDialog  := False;
        frxImpressaoJvVidrosOR_PD_J.Export(frxExportaODS);
      End;
    End;

    strNomeArquivo := strExecutavel + 'PedidoOrcamento\' + strNomeArquivo;
    Result := strNomeArquivo;
  End;
end;

procedure TImpressaoJvVidrosBussines.pCriaClients;
begin
  inherited;

  With cdsCabecalho Do
  Begin
    {***************************}
    {* DADOS CABECALHO EMPRESA *}
    {************************FC*}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMDOC';
      DataType := ftString;
      Size     := 40;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMEMP';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONEMP';
      DataType := ftString;
      Size     := 40;
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
      Name     := 'BAIEMP';
      DataType := ftString;
      Size     := 100;
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
      Name     := 'CEPEMP';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ESTEMP';
      DataType := ftString;
      Size     := 02;
      Required := False;
    End;

    {***************************}
    {* DADOS CABEÇALHO CLIENTE *}
    {************************FC*}
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMCLI';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODCLI';
      DataType := ftString;
      Size     := 008;
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
      Name     := 'CEPCLI';
      DataType := ftString;
      Size     := 10;
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
      Name     := 'CNDPGT';
      DataType := ftString;
      Size     := 100;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'FONCLI';
      DataType := ftString;
      Size     := 14;
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
      Name     := 'DESESP';
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
      Name     := 'TOTFRE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOTDOC';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMVEN';
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
      Name     := 'DTADOC';
      DataType := ftString;
      Size     := 10;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'HORDOC';
      DataType := ftString;
      Size     := 08;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ENDENT';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MENSAG';
      DataType := ftString;
      Size     := 400;
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
      Name     := 'PERCOM';
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
      Name     := 'ITEVID';
      DataType := ftString;
      Size     := 50;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ID_VID';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDVID';
      DataType := ftFloat;
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
      Name := 'UNIDAD';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENTSAI';
      DataType := ftString;
      Size     := 3;
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
      Name := 'QTDLAR';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDALT';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDMT2';
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
      Name := 'TOTITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTGER';
      DataType := ftFloat;
      Required := False;
    End;

    IndexFieldNames := 'ITEVID;ID_VID;QTDLAR;QTDALT';
    CreateDataSet;
    Open;
  End;
end;

procedure TImpressaoJvVidrosBussines.pImprimeDocumento(
  objImpDadosJvVidros: IImpressaoJvVidrosIntf);
  Var
    frxImpressao: TfrxReport;
begin
  inherited;

  With FModuloImpEspecifica Do
  Begin
    If SameText(objImpDadosJvVidros.strTipImp, 'M') Then
    Begin
      If Pos(objImpDadosJvVidros.strEspDoc, 'PD_OR_') > 0 Then
        frxImpressao := frxImpressaoJvVidrosOR_PD_M
      Else
        frxImpressao := frxImpressaoJvVidrosRQ_M;
    End
    Else
    Begin
      If Pos(objImpDadosJvVidros.strEspDoc, 'PD_OR_') > 0 Then
        frxImpressao := frxImpressaoJvVidrosOR_PD_J
      Else
        frxImpressao := frxImpressaoJvVidrosRQ_J;

      frxImpressao.DotMatrixReport           := False;
      frxImpressao.PrintOptions.PrintMode    := pmScale;
      frxImpressao.PrintOptions.PrintOnSheet := 9; //A4
    End;

    If Pos(objImpDadosJvVidros.strEspDoc, 'PD_OR_') > 0 Then
    Begin
      pMontaResumoDespesas(frxImpressao, objImpDadosJvVidros);
      TfrxMemoView(frxImpressao.FindObject('rllEntrega')).Visible := SameText(fCfgSis('END80C', varString), '2');
    End
    Else
      pCarregaInformacoesVidro(frxImpressao, objImpDadosJvVidros);

    If fEmptyStr(objImpDadosJvVidros.strNomFil) Then
      frxImpressao.PrintOptions.ShowDialog := True
    Else
    Begin
      frxImpressao.PrintOptions.Printer := AnsiReplaceText(objImpDadosJvVidros.strNomFil, '\\' + fRetNomeRede + '\', '');
      frxImpressao.PrintOptions.ShowDialog := False;
    End;

    If SameText(objImpDadosJvVidros.strDesImp, 'I') Then
    Begin
      If frxImpressao.PrepareReport Then
        frxImpressao.Print;
    End
    Else
      frxImpressao.ShowReport;
  End;
end;

procedure TImpressaoJvVidrosBussines.pMontaResumoDespesas(frxImpressao: TfrxReport; objImpDadosJvVidros: IImpressaoJvVidrosIntf);
begin
  TfrxChild(frxImpressao.FindObject('CDespesasViagem')).Visible := False;

  If Assigned(objImpDadosJvVidros.objDespesas) And Not objImpDadosJvVidros.objDespesas.cdsDespesas.IsEmpty Then
  Begin
    TfrxChild(frxImpressao.FindObject('CDespesasViagem')).Visible := True;
    TfrxMemoView(frxImpressao.FindObject('rllDespesasViagem')).Clear;

    With objImpDadosJvVidros.objDespesas, cdsDespesas, TfrxMemoView(frxImpressao.FindObject('rllDespesasViagem')) Do
    Begin
      Lines.Add('-------------------------------- DESPESAS COM VIAGEM --------------------------------');

      First;
      While Not Eof Do
      Begin
        Lines.Add(fPadR(FieldByName('descricao').AsString, 67) + ' R$ ' +
                  fPadL(FormatFloat(fMskDigitos(2), FieldByName('valortotal').AsFloat), 14));
        Next;
      End;
      Lines.Add('-------------------------------------------------------------------------------------');
      Lines.Add(fPadR('TOTAL DESPESAS:', 67) + ' R$ ' + fPadL(FormatFloat(fMskDigitos(2), fltValorTotal), 14));
      Lines.Add('-------------------------------------------------------------------------------------');
    End;
  End;

end;

procedure TImpressaoJvVidrosBussines.pCarregaInformacoesVidro(frxImpressao: TfrxReport; objImpDadosJvVidros: IImpressaoJvVidrosIntf);
  Var
    qryInfVid: TUniQuery;
begin
  qryInfVid := fCriaQuery;

  With qryInfVid, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT ');
    Add('  INFVIDX.* ');
    Add('FROM ');
    Add('  MOVGERX ');
    Add('  INNER JOIN INFVIDX ON INFVIDX.GER_SEQGER = MOVGERX.AUTOINCREM ');
    Add('WHERE ');
    Add('  GER_NUMDOC = :NUMDOC AND ');
    Add('  GER_ESPDOC = :ESPDOC AND ');
    Add('  GER_CODEMP = :CODEMP AND ');
    Add('  GER_CODCLI = :CODCLI ');

    ParamByName('NUMDOC').AsString := objImpDadosJvVidros.strNumDoc;
    ParamByName('ESPDOC').AsString := objImpDadosJvVidros.strEspDoc;
    ParamByName('CODEMP').AsString := objImpDadosJvVidros.strCodEmp;
    ParamByName('CODCLI').AsString := objImpDadosJvVidros.strCodCli;

    Open;
  End;

  With frxImpressao, Script, qryInfVid Do
  Begin
    Variables['INFVID'] := FieldByName('GER_INFVID').AsString;
    Variables['INFFER'] := FieldByName('GER_INFFER').AsString;
    Variables['INFALU'] := FieldByName('GER_INFALU').AsString;
    Variables['OBSERV'] := FieldByName('GER_OBSERV').AsString;
  End;

  FreeAndNil(qryInfVid);
end;

procedure TImpressaoJvVidrosBussines.pPreencheCabecalho(
  objImpDadosJvVidros: IImpressaoJvVidrosIntf);
  Var
    qryEmpTmp: TUniQuery;
    strTitulo: String;
    
  procedure pGetDadosEmpresa;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    If objImpDadosJvVidros.strTipNomEmp = 'F' Then
      strSQL := strSQL + '  EMP_NOMFAN NOMEMP, '
    Else
      strSQL := strSQL + '  EMP_NOMEMP NOMEMP, ';

    strSQL := strSQL + '   COALESCE(EMP_FONE01, EMP_FONE02) FONEMP, ';
    strSQL := strSQL + '   EMP_ENDERE ENDEMP, ';
    strSQL := strSQL + '   EMP_BAIRRO BAIEMP, ';
    strSQL := strSQL + '   CONCAT(COALESCE(CID_NOMCID, ""), " ", COALESCE(CID_ESTADO, "")) CIDEMP, ';
    strSQL := strSQL + '   EMP_C_E_P_ CEPEMP, ';
    strSQL := strSQL + '   CID_ESTADO ESTEMP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + ' JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';

    Try
     qryEmpTmp := fCriaQuery;

     With qryEmpTmp Do
     Begin
       SQL.Clear;
       SQL.Add(strSQL);
       ParamByName('CODEMP').AsString := objImpDadosJvVidros.strCodEmp;
       Open;
     End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pGetDadosEmpresa]');
        FreeAndNil(qryEmpTmp);
      End;
    End;
  End;
begin
  pGetDadosEmpresa;

  With cdsCabecalho Do
  Begin
    Append;

    If SameText(objImpDadosJvVidros.strEspDoc, 'OR') Then
      strTitulo := 'Orçamento Nº '
    Else If SameText(objImpDadosJvVidros.strEspDoc, 'PD') Then
      strTitulo := 'Pedido Nº '
    Else If SameText(objImpDadosJvVidros.strEspDoc, 'RQ') Then
      strTitulo := 'Requisição Nº ';

    If objImpDadosJvVidros.strTipImp = 'M' Then
      strTitulo := fTiraCaracEspeciais(strTitulo, False);

    FieldByName('NUMDOC').AsString := Trim(strTitulo + objImpDadosJvVidros.strNumDoc);
    FieldByName('NOMEMP').AsString := Trim(Copy(qryEmpTmp.FieldByName('NOMEMP').AsString, 1, 40));
    FieldByName('FONEMP').AsString := Trim(Copy('FONE/FAX: ' + fFormataFone(qryEmpTmp.FieldByName('FONEMP').AsString), 1, 40));
    FieldByName('ENDEMP').AsString := qryEmpTmp.FieldByName('ENDEMP').AsString;
    FieldByName('BAIEMP').AsString := qryEmpTmp.FieldByName('BAIEMP').AsString;
    FieldByName('CIDEMP').AsString := qryEmpTmp.FieldByName('CIDEMP').AsString;
    FieldByName('CEPEMP').AsString := fFormataCEP(qryEmpTmp.FieldByName('CEPEMP').AsString);
    FieldByName('ESTEMP').AsString := qryEmpTmp.FieldByName('ESTEMP').AsString;
    FieldByName('NOMCLI').AsString := objImpDadosJvVidros.strNomCli;
    FieldByName('CODCLI').AsString := objImpDadosJvVidros.strCodCli;
    FieldByName('ENDCLI').AsString := objImpDadosJvVidros.strEndCli;
    FieldByName('BAICLI').AsString := objImpDadosJvVidros.strBaiCli;
    FieldByName('CIDCLI').AsString := objImpDadosJvVidros.strCidCli;
    FieldByName('CEPCLI').AsString := fFormataCEP(objImpDadosJvVidros.strCepCli);
    FieldByName('CPFCGC').AsString := objImpDadosJvVidros.strCpfCgc;
    FieldByName('RG_IE_').AsString := objImpDadosJvVidros.strRg_Ie_;
    FieldByName('CNDPGT').AsString := objImpDadosJvVidros.strCndPgt;
    FieldByName('FONCLI').AsString := fFormataFone(objImpDadosJvVidros.strFonCli);
    Post;
  End;

  If Assigned(qryEmpTmp) Then
    FreeAndNil(qryEmpTmp);
end;

procedure TImpressaoJvVidrosBussines.pPreencheItens(objImpDadosJvVidros: IImpressaoJvVidrosIntf;
  qryItens: TDataset; blnImpDescSimp: Boolean);
  Var
    strTabela: String;
    strSigTab: String;
    subItem: TSubItemVidro;
    subItens: TSubItemVidroArray;
    fltTotalGeralItem: Double;
begin
  With qryItens Do
  Begin
    First;

    While Not Eof Do
    Begin
      If Pos(objImpDadosJvVidros.strEspDoc, 'PD_OR_') > 0 Then
      Begin
        strTabela := 'FATDOR';
        strSigTab := 'FDO_';
      End
      Else If Pos(objImpDadosJvVidros.strEspDoc, 'NF_NE_NS_IF_') > 0 Then
      Begin
        strTabela := 'MOVDET';
        strSigTab := 'DET_';
      End
      Else
      Begin
        strTabela := 'MOVDETX';
        strSigTab := 'DET_';
      End;

      If (FieldByName('QTDITE').AsFloat > 0) And
         ((Not fEmptyStr(FieldByName('DESSIM').AsString)) Or
          (Not fEmptyStr(FieldByName('DESITE2').AsString))) Then
      Begin
        fltTotalGeralItem := FieldByName('VALITE').AsFloat +
          fCampoTabela(strSigTab + 'DESACE', strTabela, ['AUTOINCREM'], [FieldByName('AUTOINCREM').AsString]);

        objImpDadosJvVidros.strCodPro := IIF(Not fEmptyStr(FieldByName(strSigTab + 'CODDIV').AsString), FieldByName(strSigTab + 'CODDIV').AsString + ' - ' + fRetNomProfissional(FieldByName(strSigTab + 'CODDIV').AsString), '');
        objImpDadosJvVidros.fltPerCom := fCampoTabela('DIV_PERCOM', 'CADDIV', ['DIV_CODDIV'], [FieldByName(strSigTab + 'CODDIV').AsString]);

        If fEhItemVendaVidro(FieldByName('CODITE').AsString) And (strTabela = 'FATDOR') Then
        Begin
          TSubItensVidroManager.pCarregarSubItensPedOrc(subItens, FieldByName('AUTOINCREM').AsString);
          TSubItensVidroManager.pAcertarPrecos(subItens, (fltTotalGeralItem / FieldByName('QTDITE').AsFloat));

          For subItem In subItens Do
          Begin
            cdsItens.Append;
            cdsItens.FieldByName('ITEVID').AsString := FieldByName('FDO_DESCRI').AsString;
            cdsItens.FieldByName('ID_VID').AsString := FieldByName('AUTOINCREM').AsString;
            cdsItens.FieldByName('ENTSAI').AsString := FieldByName('ENTSAI').AsString;
            cdsItens.FieldByName('QTDVID').AsFloat  := FieldByName('QTDITE').AsFloat;
            cdsItens.FieldByName('DESITE').AsString := subItem.fGetDescricaoCompleta;
            cdsItens.FieldByName('UNIDAD').AsString := subItem.strSiglaUnidade;
            cdsItens.FieldByName('QTDITE').AsFloat  := subItem.fltQuantidade;
            cdsItens.FieldByName('QTDLAR').AsFloat  := subItem.fltLargura;
            cdsItens.FieldByName('QTDALT').AsFloat  := subItem.fltAltura;
            cdsItens.FieldByName('QTDMT2').AsFloat  := subItem.fltAreaM2;
            cdsItens.FieldByName('VALITE').AsFloat  := subItem.fltPrecoVenda;
            cdsItens.FieldByName('TOTITE').AsFloat  := subItem.ValoresTotais.fltPrecoVendaTotal;
            cdsItens.FieldByName('TOTGER').AsFloat  := subItem.ValoresTotais.fltPrecoVendaTotal * FieldByName('QTDITE').AsFloat;;
            cdsItens.Post;
          End;
        End
        Else
        Begin
          cdsItens.Append;
          cdsItens.FieldByName('ITEVID').AsString := '';
          cdsItens.FieldByName('ID_VID').AsString := '';
          cdsItens.FieldByName('QTDVID').AsFloat  := 1;

          If blnImpDescSimp Then
            cdsItens.FieldByName('DESITE').AsString := FieldByName('DESSIM').AsString
          Else
            cdsItens.FieldByName('DESITE').AsString := FieldByName('DESITE2').AsString;

          cdsItens.FieldByName('ENTSAI').AsString := FieldByName('ENTSAI').AsString;
          cdsItens.FieldByName('UNIDAD').AsString := FieldByName('UNIDAD').AsString;
          cdsItens.FieldByName('QTDITE').AsFloat  := IIF(FieldByName('QTDPEC').AsFloat = 0, FieldByName('QTDITE').AsFloat, FieldByName('QTDPEC').AsFloat);
          cdsItens.FieldByName('QTDLAR').AsFloat  := FieldByName('LARPEC').AsFloat;
          cdsItens.FieldByName('QTDALT').AsFloat  := FieldByName('COMPEC').AsFloat;
          cdsItens.FieldByName('QTDMT2').AsFloat  := IIF(FieldByName('QTDPEC').AsFloat = 0, 0, FieldByName('QTDITE').AsFloat);
          cdsItens.FieldByName('VALITE').AsFloat  := fltTotalGeralItem / FieldByName('QTDITE').AsFloat;
          cdsItens.FieldByName('TOTITE').AsFloat  := fltTotalGeralItem;
          cdsItens.FieldByName('TOTGER').AsFloat  := fltTotalGeralItem;
          cdsItens.Post;
        End;
      End;

      Next;
    End;
  End;
end;

procedure TImpressaoJvVidrosBussines.pPreencheRodape(
  objImpDadosJvVidros: IImpressaoJvVidrosIntf);
begin
  With cdsRodape Do
  Begin
    Append;
    FieldByName('DESESP').AsFloat  := objImpDadosJvVidros.fltDesEsp;
    FieldByName('DESACE').AsFloat  := objImpDadosJvVidros.fltDesAce;
    FieldByName('TOTFRE').AsFloat  := objImpDadosJvVidros.fltTotFre;
    FieldByName('TOTDOC').AsFloat  := objImpDadosJvVidros.fltTotDoc;
    FieldByName('NOMVEN').AsString := objImpDadosJvVidros.strCodVen;
    FieldByName('NOMDIG').AsString := objImpDadosJvVidros.strCodDig;
    FieldByName('DTADOC').AsString := FormatDateTime('dd/mm/yyyy', objImpDadosJvVidros.dtaDtaDoc);
    FieldByName('HORDOC').AsString := FormatDateTime('hh:mm:ss', objImpDadosJvVidros.dtaHorDoc);
    FieldByName('ENDENT').AsString := objImpDadosJvVidros.strEntCli;
    FieldByName('MENSAG').AsString := objImpDadosJvVidros.strMensag;
    FieldByName('NOMPRO').AsString := objImpDadosJvVidros.strCodPro;
    FieldByName('PERCOM').AsFloat  := objImpDadosJvVidros.fltPerCom;
    Post;
  End;
end;

end.
