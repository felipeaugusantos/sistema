unit untComprovantePontosProfissional;

interface

uses
  Classes, untIFastPrint, untTypesSistema, System.Generics.Collections, frxClass,
  frxDBSet, Uni, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica;

Type
  TComprovantePontosProfissional = class(TInterfacedObject, IFastPrintFile)
    private
      FCodDiv: String;
      FNumDoc: String;
      FEspDoc: String;
      FDicVar: TDictionary<String,Variant>;
      FComPro: TUniQuery;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetComPro: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;

      FPais: TPais;

      blnValor: boolean;

      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;      
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
    protected
      function fGetKey: String;
      function fGetName: String;
      function fGetDBDataSets: TArrFrxDBDataSet;
      function fGetUserDataSets: TArrFrxUserDataSet;
      function fGetFunctionsList: TStringList;
      function fGetVariables: TDictionary<String,Variant>;
      function fGetUserFunction: TfrxUserFunctionEvent;
      function fPrepareDataSetsAndVariables: Boolean;
      function fGetPrinterName: String;
      function fGetFastType: TFastFileType;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create(strCodLay: string);
      constructor CreateInstance(strCodDiv, strNumDoc, strEspDoc: String; strCodLay : String = '');
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
  end;

Const
  FILA_IMPRESSAO_COMPROVANTE = 'impressao_comprovante_pontos';

implementation

uses SysUtils, untCfgRel, Data.DB;

{ TComprovantePontosProfissional }

constructor TComprovantePontosProfissional.Create(strCodLay: string);
begin
  blnValor := (strCodLay = 'CPVVPF');
  FModoDesigner := True;
  pIniciaObjetos;
end;

constructor TComprovantePontosProfissional.CreateInstance(strCodDiv, strNumDoc,
  strEspDoc: String; strCodLay : String = '');
begin
  FModoDesigner := False;

  FCodDiv := strCodDiv;
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;

  blnValor := (strCodLay = 'CPVVPF');

  FPais := fSetaPais;
  pIniciaObjetos;
end;

procedure TComprovantePontosProfissional.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;

  FListaFuncoes := TStringList.Create;

  FComPro := fCriaQuery(nil);
  FDataSetComPro := TfrxDBDataset.Create(nil);
  FDataSetComPro.Name := 'frxDataSetComissaoProfissional';
  FDataSetComPro.DataSet := FComPro;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetComPro;

  pDefineFilaImpressao(False);
end;

destructor TComprovantePontosProfissional.Destroy;
begin
  FreeAndNil(FComPro);
  FreeAndNil(FDataSetComPro);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TComprovantePontosProfissional.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgc(strValor: String; strEstado: String = ''): String;');
  FListaFuncoes.Add('function fFormataCEP(strCEP: String): String;');
  FListaFuncoes.Add('function fFormataFone(strFone: String): String;');
end;

procedure TComprovantePontosProfissional.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TComprovantePontosProfissional.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_COMPROVANTE);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_COMPROVANTE);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);    
end;

function TComprovantePontosProfissional.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataCpfCgc') Then
    Result := fFormataCpfCgc(Params[0], FPais);

  If SameText(MethodName, 'fFormataCEP') Then
    Result := fFormataCEP(Params[0]);

  If SameText(MethodName, 'fFormataFone') Then
    Result := fFormataFone(Params[0]);
end;

function TComprovantePontosProfissional.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TComprovantePontosProfissional.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TComprovantePontosProfissional.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TComprovantePontosProfissional.fGetIsEmpty: Boolean;
begin
  Result := FComPro.IsEmpty;
end;

function TComprovantePontosProfissional.fGetKey: String;
begin
  If blnValor then
    Result := 'CPVVPF'
  Else
    Result := 'CPVPPF';
end;

function TComprovantePontosProfissional.fGetName: String;
begin
  If blnValor then
    Result := 'COMPROVANTE DO VALOR DE COMISSÃO DO PROFISSIONAL'
  Else
    Result := 'COMPROVANTE DA QUANTIDADE DE PONTOS DO PROFISSIONAL';
end;

function TComprovantePontosProfissional.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TComprovantePontosProfissional.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TComprovantePontosProfissional.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TComprovantePontosProfissional.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TComprovantePontosProfissional.fPrepareDataSetsAndVariables: Boolean;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  end;

  procedure pCarregaDadosEmpresa;
  begin
    fCadEmp('NOMEMP', FCadEmp_);
  end;

begin
  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;

  With FComPro, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE ');
    Add('  COM_CODCOM, ');
    Add('  COM_DTACAD, ');
    Add('  COM_CREDEB, ');
    Add('  COM_NUMDOC, ');
    Add('  COM_ESPDOC, ');
    Add('  COM_CODEMP, ');
    Add('  COM_VRVEND, ');
    Add('  COM_VRCOMI, '); //Qtd.Pontos
    Add('  COM_CODCLI,  ');
    Add('  CLI_NOMCLI, ');
    Add('  COM_CODPRO,  ');
    Add('  DIV_NOMDIV  ');
    Add('FROM      ');
    Add('  COMPRO  ');
    Add('  LEFT JOIN CADCLI ON (CLI_CODCLI = COM_CODCLI) ');
    Add('  LEFT JOIN CADDIV ON (DIV_CODDIV = COM_CODPRO) ');
    Add('WHERE     ');
    Add('  COM_CREDEB = "C" AND ');

    If Not FModoDesigner Then
    Begin
      Add('  COM_NUMDOC = :NUMDOC AND ');
      Add('  COM_ESPDOC = :ESPDOC AND ');
      Add('  COM_CODEMP = :CODEMP AND ');
      Add('  COM_CODPRO = :CODPRO     ');

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODPRO').AsString := FCodDiv;
    End
    Else
    Begin
      Add('  COM_VRCOMI > 0 AND   ');
      Add('  COM_CODEMP = :CODEMP ');
      Add('LIMIT 1');
    End;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := Not IsEmpty;

  End;
end;

end.
