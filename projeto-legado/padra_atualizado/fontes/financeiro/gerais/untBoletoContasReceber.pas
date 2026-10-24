unit untBoletoContasReceber;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint, System.Variants, XMLIntf, XMLDoc, untCfgRel;

Type

  TBoletoContasReceber = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FcdsAgrupamento : TUniClientDataSet;
      FListaFuncoes   : TStringList;
      FDataSetAgrupamento  : TfrxDBDataset;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      FArrDBDataSet: TArrFrxDBDataSet;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      function fGetIsEmpty: Boolean;
    protected
      function  fGetDBDataSets: TArrFrxDBDataSet;
      function  fGetFastType: TFastFileType;
      function  fGetFunctionsList: TStringList;
      function  fGetKey: String;
      function  fGetName: String;
      function  fGetNodeXML(ANodeName : String; ANode: IXMLNode; var ANodePaginaReport : IXMLNode) : Boolean;
      function  fGetPrinterName: String;
      function  fGetUserDataSets: TArrFrxUserDataSet;
      function  fGetUserFunction: TfrxUserFunctionEvent;
      function  fGetVariables: TDictionary<String,Variant>;
      function  fPrepareDataSetsAndVariables: Boolean;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create;
      destructor Destroy; override;
      property  NomImp: string read FNomImp write FNomImp;
      property  IsEmpty: Boolean read fGetIsEmpty;
      function  fValidaLayoutImpressao(AReport : TfrxReport; var AMensagemValidacao : string) : Boolean;
  end;

  function fCriaClientDatasetAgrupamento: TUniClientDataSet;

Const
  FILA_IMPRESSAO_BOLETO_CONTAS_RECEBER = 'impressao_boleto_contas_receber';

implementation

uses untValorPorExtenso, untQckBancos ;

{ TBoletoContasReceber }

constructor TBoletoContasReceber.Create;
begin
  FModoDesigner := True;

  FPais := fSetaPais;

  FcdsAgrupamento := fCriaClientDatasetAgrupamento;

  With FcdsAgrupamento Do
  Begin
    Append;
    FieldByName('CTR_NUMDUP').AsString   := 'REFENTE A RECEBIMENTO';
    FieldByName('CTR_PARCEL').AsString   := 'A';
    FieldByName('CTR_ESPDOC').AsString   := 'NF';
    FieldByName('CTR_CODEMP').AsString   := VS_strCodEmp;
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_VALORI').AsFloat    := 1;
    FieldByName('CTR_VALCOR').AsFloat    := 1;
    Post;
  End;

  pIniciaObjetos;
end;

procedure TBoletoContasReceber.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetAgrupamento         := TfrxDBDataset.Create(nil);
  FDataSetAgrupamento.Name    := 'frxAgrupamento';
  FDataSetAgrupamento.DataSet := FcdsAgrupamento;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDataSetAgrupamento;

  pDefineFilaImpressao(False);
end;

destructor TBoletoContasReceber.Destroy;
begin
  FreeAndNil(FcdsAgrupamento);
  FreeAndNil(FDataSetAgrupamento);
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TBoletoContasReceber.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
end;

procedure TBoletoContasReceber.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TBoletoContasReceber.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_BOLETO_CONTAS_RECEBER);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_BOLETO_CONTAS_RECEBER);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TBoletoContasReceber.fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
begin

end;

function TBoletoContasReceber.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TBoletoContasReceber.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TBoletoContasReceber.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TBoletoContasReceber.fGetIsEmpty: Boolean;
begin
  Result := FcdsAgrupamento.IsEmpty;
end;

function TBoletoContasReceber.fGetKey: String;
begin
  Result := 'BOLCTR';
end;

function TBoletoContasReceber.fGetName: String;
begin
  Result := 'BOLETO CONTAS A RECEBER';
end;

function TBoletoContasReceber.fGetNodeXML(ANodeName: String; ANode: IXMLNode; var ANodePaginaReport: IXMLNode): Boolean;
var
  SIdx       : integer;
  SNodeTmp   : IXMLNode;
begin
  Result := False;

  if ANode.NodeName = ANodeName then
    begin
      ANodePaginaReport := ANode;
      Exit(True);
    end;

  for SIdx := 0 to ANode.ChildNodes.Count - 1 do
  begin
    SNodeTmp := ANode.ChildNodes[SIdx];

    if SNodeTmp.NodeName = ANodeName then
    begin
      ANodePaginaReport := SNodeTmp;
      Exit(True);
    end
    else if SNodeTmp.ChildNodes.Count > 0 then
    begin
      if fGetNodeXML(ANodeName, SNodeTmp, ANodePaginaReport) then
        Exit(True);
    end;
  end;
end;

function TBoletoContasReceber.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TBoletoContasReceber.fGetUserDataSets: TArrFrxUserDataSet;
begin

end;

function TBoletoContasReceber.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TBoletoContasReceber.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TBoletoContasReceber.fPrepareDataSetsAndVariables: Boolean;
  Var
    fltTotalRecebido: Double;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
    FDicVar.AddOrSetValue('fltTotalRecebido', fltTotalRecebido);

    FDicVar.AddOrSetValue('CODEMP', '001');
    FDicVar.AddOrSetValue('CODBCO', '341');
    FDicVar.AddOrSetValue('LINDIG', 'LINHA DIGITÁVEL');
    FDicVar.AddOrSetValue('LOCEXT', 'LOCAL');
    FDicVar.AddOrSetValue('LOCPAG', 'LOCAL DE PAGAMENTO');
    FDicVar.AddOrSetValue('DTAVEN', '01/01/2000');
    FDicVar.AddOrSetValue('AGECED', '2222');
    FDicVar.AddOrSetValue('NOSNUM', '12345');
    FDicVar.AddOrSetValue('VALDOC', 'R$5000,00');
    FDicVar.AddOrSetValue('OUTACR', 'R$0,00');
    FDicVar.AddOrSetValue('NOMCED', 'NOME GENERICO');
    FDicVar.AddOrSetValue('ENDCED', 'ENDEREÇO GENERICO');
    FDicVar.AddOrSetValue('DTADOC', '01/01/2000');
    FDicVar.AddOrSetValue('NUMDOC', '12345');
    FDicVar.AddOrSetValue('ESPDOC', 'NF');
    FDicVar.AddOrSetValue('NUMPARC','1');
    FDicVar.AddOrSetValue('TOTPARC','1');
    FDicVar.AddOrSetValue('ACEITE', 'S');
    FDicVar.AddOrSetValue('DTAPRO', '01/01/2000');
    FDicVar.AddOrSetValue('CARTEI', '001');
    FDicVar.AddOrSetValue('NOMSAC', 'PAGADOR GENERICO');
    FDicVar.AddOrSetValue('ENDSAC', 'ENDEREÇO PAGADOR GENERICO');
    FDicVar.AddOrSetValue('CIDSAC', 'CIDADE PAGADOR GENERICA');
    FDicVar.AddOrSetValue('INSSAC', 'INSCRIÇÃO PAGADOR GENERICA');
    FDicVar.AddOrSetValue('MAILCLI','E-MAIL@GENERICO.COM');
    FDicVar.AddOrSetValue('SACAVA', 'AVALISTA GENERICO');
    FDicVar.AddOrSetValue('ENDAVA', 'ENDEREÇO AVALISTA GENERICO');
  end;

begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;

function TBoletoContasReceber.fValidaLayoutImpressao(AReport: TfrxReport; var AMensagemValidacao: string): Boolean;
var SStreamLayImp     : TStringStream;
    SXmlLayImp        : IXMLDocument;
    SNodePaginaReport : IXMLNode;
    SNomesComponentes : String;
    SbolEncontrouComponentesMesmoNome : Boolean;

    frmQckBancos: TfrmQckBancos;

  function fBuscarComponentesMesmoNome(ANode : IXMLNode) : Boolean;
  var SIdx        : Integer;
      SNode       : IXMLNode;
      SComponente : TfrxComponent;
  begin
    Result := False;

    if (ANode.Attributes['Name'] <> null) and
       (ANode.NodeName <> 'TfrxReportPage') then
    begin
      SComponente := frmQckBancos.frxBanco.FindObject(ANode.Attributes['Name']);
      if Assigned(SComponente) then
      begin
        If Length(SNomesComponentes) = 0 then
          SNomesComponentes := ANode.Attributes['Name']
        else
          SNomesComponentes := SNomesComponentes + ', '+ANode.Attributes['Name'];
        SbolEncontrouComponentesMesmoNome := True;
      end;
    end;

    for SIdx := 0 to ANode.ChildNodes.Count - 1 do
    begin
      SNode := ANode.ChildNodes[SIdx];

      if (SNode.Attributes['Name'] <> null) and
         (SNode.NodeName <> 'TfrxReportPage') then
      begin
        SComponente := frmQckBancos.frxBanco.FindObject(SNode.Attributes['Name']);
        if Assigned(SComponente) then
        begin
          If Length(SNomesComponentes) = 0 then
            SNomesComponentes := SNode.Attributes['Name']
          else
            SNomesComponentes := SNomesComponentes + ', '+SNode.Attributes['Name'];
          SbolEncontrouComponentesMesmoNome := True;
        end;
      end;

      if SNode.ChildNodes.Count > 0 then
        fBuscarComponentesMesmoNome(SNode);
    end;
  end;

begin
  Result := True;

  pCriarFormularios(TfrmQckBancos, frmQckBancos);
  SStreamLayImp     := TStringStream.Create;
  try
    AReport.SaveToStream(SStreamLayImp);
    SXmlLayImp := LoadXMLData(SStreamLayImp.DataString);
    SXmlLayImp.Active := True;

    if not fGetNodeXML('TfrxReportPage', SXmlLayImp.DocumentElement, SNodePaginaReport) then
    begin
      AMensagemValidacao := 'Objeto TfrxReportPage não encontrado no layout criado. Favor revisar.';
      Exit(False);
    end;

    SbolEncontrouComponentesMesmoNome := False;
    fBuscarComponentesMesmoNome(SNodePaginaReport);
    if SbolEncontrouComponentesMesmoNome then
    begin
      AMensagemValidacao := 'Componente cujo nome é "'+SNomesComponentes+'" '+
        'já encotra-se presente no layout padrão do boleto. É necessário renomear o mesmo';
      Exit(False);
    end

  Finally
    FreeAndNil(SStreamLayImp);
    FreeAndNil(frmQckBancos);
  end;
end;

function fCriaClientDatasetAgrupamento: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMDUP';
    DataType := ftString;
    Size     := 200;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PARCEL';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALORI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALCOR';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;

end;

end.
