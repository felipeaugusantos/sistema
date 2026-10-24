unit untImpressaoDelLamaBussines;

interface

uses
  SysUtils, DB, UniClientDataSet, untImpressaoEspecifica, untImpressaoDelLamaIntf,
  Uni, frxClass, StrUtils;

type
  TImpressaoDelLamaBussines = Class(TImpressaoEspecifica)
  private
    strEntMsg : string;
  public
    procedure pCriaClients; override;

    procedure pPreencheCabecalho(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; override;
    procedure pPreencheItens(qryItens: TDataset; blnImpDescSimp: Boolean); overload; override;
    procedure pPreencheRodape(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; override;
    procedure pImprimeDocumento(objImpDadosDelLama: IImpressaoDelLamaIntf); overload; override;
  End;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, untModuloImpEspecifica, untFuncoes;

{ TImpressaoDelLamaBussines }

procedure TImpressaoDelLamaBussines.pCriaClients;
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
      Size     := 06;
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
      Name     := 'NOMCLI';
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
      Name     := 'FAXCLI';
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
      Name     := 'DTAVAL';
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

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMPRO';
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
      Name     := 'TOTFRE';
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

    CreateDataSet;
    Open;
  End;

  With cdsItens Do
  Begin
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
      Name := 'COMPLE';
      DataType := ftString;
      Size     := 50;
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
      Name := 'DESITE';
      DataType := ftString;
      Size     := 100;
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
      Name := 'UNIDAD';
      DataType := ftString;
      Size     := 4;
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
      Name := 'TOTITE';
      DataType := ftFloat;
      Required := False;
    End;

    IndexFieldNames := 'COMPLE;CODITE';
    CreateDataSet;
    Open;
  End;
end;

procedure TImpressaoDelLamaBussines.pImprimeDocumento(objImpDadosDelLama: IImpressaoDelLamaIntf);
  Var
    strTitulo: String;
begin
  inherited;

  With FModuloImpEspecifica Do
  Begin
    frxImpressaoDelLama.DotMatrixReport           := False;
    frxImpressaoDelLama.PrintOptions.PrintMode    := pmScale;
    frxImpressaoDelLama.PrintOptions.PrintOnSheet := 9; //A4

    If SameText(objImpDadosDelLama.strEspDoc, 'OR') Then
      strTitulo := 'Orçamento'
    Else If SameText(objImpDadosDelLama.strEspDoc, 'PD') Then
      strTitulo := 'Pedido';

    frxImpressaoDelLama.Script.Variables['NUMDOC'] := 'Nrº ' + strTitulo + ' ' + objImpDadosDelLama.strNumDoc;
    frxImpressaoDelLama.Script.Variables['TIPDOC'] := strTitulo;

    TfrxChild(frxImpressaoDelLama.FindObject('ChildProposta')).Visible := SameText(objImpDadosDelLama.strEspDoc, 'OR');

    If FileExists(fCfgSis('PATLOG')) Then
      TfrxPictureView(frxImpressaoDelLama.FindObject('imgLogo')).Picture.LoadFromFile(fCfgSis('PATLOG'));

    If fEmptyStr(objImpDadosDelLama.strNomFil) Then
      frxImpressaoDelLama.PrintOptions.ShowDialog := True
    Else
    Begin
      frxImpressaoDelLama.PrintOptions.Printer := AnsiReplaceText(objImpDadosDelLama.strNomFil, '\\' + fRetNomeRede + '\', '');
      frxImpressaoDelLama.PrintOptions.ShowDialog := False;
    End;

    If SameText(objImpDadosDelLama.strDesImp, 'I') Then
    Begin
      If frxImpressaoDelLama.PrepareReport Then
        frxImpressaoDelLama.Print;
    End
    Else
      frxImpressaoDelLama.ShowReport;
  End;
end;

procedure TImpressaoDelLamaBussines.pPreencheCabecalho(objImpDadosDelLama: IImpressaoDelLamaIntf);
  Var
    qryEmpTmp: TUniQuery;

  procedure pGetDadosEmpresa;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COALESCE(EMP_FONE01, EMP_FONE02) FONEMP, ';
    strSQL := strSQL + '   CONCAT(COALESCE(EMP_ENDERE, ""), " ", COALESCE(EMP_ENDNUM, ""), " ", COALESCE(EMP_BAIRRO, "")) ENDEMP, ';
    strSQL := strSQL + '   EMP_C_E_P_ CEPEMP, ';
    strSQL := strSQL + '   CONCAT(COALESCE(CID_NOMCID, ""), " ", COALESCE(CID_ESTADO, "")) CIDEMP, ';
    strSQL := strSQL + '   EMP_CONTAT CONEMP, ';
    strSQL := strSQL + '   EMP_EMAILV EMAIL_ ';
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
       ParamByName('CODEMP').AsString := objImpDadosDelLama.strCodEmp;
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
  inherited;
  
  pGetDadosEmpresa;

  With cdsCabecalho Do
  Begin
    Append;
    FieldByName('NUMDOC').AsString := objImpDadosDelLama.strNumDoc;
    FieldByName('FONEMP').AsString := fFormataFone(qryEmpTmp.FieldByName('FONEMP').AsString);
    FieldByName('ENDEMP').AsString := qryEmpTmp.FieldByName('ENDEMP').AsString;
    FieldByName('CEPEMP').AsString := fFormataCEP(qryEmpTmp.FieldByName('CEPEMP').AsString);
    FieldByName('CIDEMP').AsString := qryEmpTmp.FieldByName('CIDEMP').AsString;
    FieldByName('CONEMP').AsString := qryEmpTmp.FieldByName('CONEMP').AsString;
    FieldByName('EMAIL_').AsString := qryEmpTmp.FieldByName('EMAIL_').AsString;
    FieldByName('DTADOC').AsString := FormatDateTime('dd/mm/yyyy hh:mm:ss', objImpDadosDelLama.dtaDtaDoc);
    FieldByName('NOMCLI').AsString := objImpDadosDelLama.strNomCli;
    FieldByName('CONCLI').AsString := objImpDadosDelLama.strConCli;
    FieldByName('CPFCGC').AsString := fFormataCpfCgc(objImpDadosDelLama.strCpfCgc, opcBrasil);
    FieldByName('RG_IE_').AsString := objImpDadosDelLama.strRg_Ie_;
    FieldByName('ENDCLI').AsString := objImpDadosDelLama.strEndCli;
    FieldByName('BAICLI').AsString := objImpDadosDelLama.strBaiCli;
    FieldByName('CIDCLI').AsString := objImpDadosDelLama.strCidCli;
    FieldByName('CEPCLI').AsString := fFormataCEP(objImpDadosDelLama.strCepCli);
    FieldByName('FONCLI').AsString := fFormataFone(objImpDadosDelLama.strFonCli);
    FieldByName('FAXCLI').AsString := fFormataFone(objImpDadosDelLama.strFaxCli);
    Post;
  End;

  If Assigned(qryEmpTmp) Then
    FreeAndNil(qryEmpTmp);
end;

procedure TImpressaoDelLamaBussines.pPreencheItens(qryItens: TDataset; blnImpDescSimp: Boolean);
  Var
    strEntRet,
    strCliBus: String;
begin
  inherited;

  With qryItens Do            
  Begin
    First;

    strEntMsg:='';

    While Not Eof Do
    Begin
      cdsItens.Append;

      strEntRet := IIF(FieldByName('ENTFUT').AsString = 'S',
                       'F' + IIF(Not fEmptyStr(FieldByName('MOTFUT').AsString), '-' + FieldByName('MOTFUT').AsString, ''),
                       IIF(FieldByName('ENTRET').AsString = 'R', 'R', 'I'));

      If FieldByName('ENTFUT').AsString = 'S' Then
      Begin
        strCliBus := FieldByName('CLIBUS').AsString;
        strEntMsg := strEntMsg + 'F'+strCliBus+'_';
      End
      Else
      Begin
        strCliBus := IIF(strEntRet = 'R', 'S', 'N');
        strEntMsg := strEntMsg + strEntRet+'_';
      End;

      cdsItens.FieldByName('CLIBUS').AsString := strCliBus;
      cdsItens.FieldByName('ENTRET').AsString := strEntRet;
      cdsItens.FieldByName('COMPLE').AsString := FieldByName('COMPLE').AsString;
      cdsItens.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;

      If blnImpDescSimp Then
        cdsItens.FieldByName('DESITE').AsString := FieldByName('DESSIM').AsString
      Else
        cdsItens.FieldByName('DESITE').AsString :=  FieldByName('DESITE2').AsString;

      cdsItens.FieldByName('DESMAR').AsString := Copy(FieldByName('DESMAR').AsString, 5, Length(FieldByName('DESMAR').AsString));
      cdsItens.FieldByName('UNIDAD').AsString := FieldByName('UNIDAD').AsString;
      cdsItens.FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat;
      cdsItens.FieldByName('VALITE').AsFloat  := FieldByName('VALUNI').AsFloat;
      cdsItens.FieldByName('DESESP').AsFloat  := FieldByName('DESESP').AsFloat;
      cdsItens.FieldByName('TOTITE').AsFloat  := FieldByName('VALITE').AsFloat;
      cdsItens.Post;

      Next;
    End;
  End;
end;

procedure TImpressaoDelLamaBussines.pPreencheRodape(objImpDadosDelLama: IImpressaoDelLamaIntf);
begin
  inherited;

  With cdsRodape Do
  Begin
    Append;
    FieldByName('DTAVAL').AsString := FormatDateTime('dd/mm/yyyy', objImpDadosDelLama.dtaDtaPro);
    FieldByName('DESFPG').AsString := fRetDesFpg(objImpDadosDelLama.strCodFpg)+'  '+fRetDesConPag(objImpDadosDelLama.strCodCnd);
    FieldByName('DTAPRE').AsString := FormatDateTime('dd/mm/yyyy', objImpDadosDelLama.dtaDtaPre);
    FieldByName('ENDENT').AsString := objImpDadosDelLama.strEndEnt;
    FieldByName('MEN001').AsString := objImpDadosDelLama.strMen001;
    FieldByName('MEN002').AsString := objImpDadosDelLama.strMen002;
    FieldByName('NOMPRO').AsString := objImpDadosDelLama.strNomPro;
    FieldByName('TOTFRE').AsFloat  := objImpDadosDelLama.fltTotFre;

    {****************************************************************************}
    {* MENSAGEM FOI FIXADA DIRETO FONTE. AVAL DO RONALDO 08/05/2014 REQ.: 17945 *}
    {**************************************************************************VA}

    //MSG RETIRA
    If (Pos('R_' ,strEntMsg) > 0) Or
       (Pos('FS_',strEntMsg) > 0) Then
       FieldByName('MENDOC').AsString := 'EXPEDIÇÃO RETIRA: Segunda a Sexta das 8:00hs as 11:30hs e das 13:00hs as 17:30hs, sábado das 09:00hs as 13:00hs.' +#13+
                                         'Caso queira agilizar a retirada de seus produtos, por favor comunicar com 1 dia de antecedência.'                 +#13+
                                         'Ligue (16)3627-3700! Assim poderemos deixar os produtos separados e agilizaremos a sua entrega.'                  +#13#13;

    //MSG ENTREGA
    If (Pos('I_' ,strEntMsg) > 0) Or
       (Pos('FN_',strEntMsg) > 0) Then
       FieldByName('MENDOC').AsString := FieldByName('MENDOC').AsString +
                                         'EXPEDIÇÃO ENTREGA: Por favor, agende sua entrega pelo telefone (16)3627-3700 com, no minimo, 7 dias de antecedência. '+
                                         'Sua satisfação é nosso principal retorno.';
    Post;
  End;
end;

end.
