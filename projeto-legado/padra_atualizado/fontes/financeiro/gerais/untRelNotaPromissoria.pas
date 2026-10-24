unit untRelNotaPromissoria;

interface

uses
  untIFastPrint, SysUtils, Classes, untTypesSistema, System.Generics.Collections,
  frxClass, frxDBSet, Uni, UniClientDataSet, DB, untFuncoesGenerica;

type
  TRelNotaPromissoria = class(TInterfacedObject, IFastPrintFile)
  private
    FPais: TPais;
    FArrDBDataSet: TArrFrxDBDataSet;
    FListaFuncoes: TStringList;
    FDicVar: TDictionary<String,Variant>;
    FTipImp: String;
    FNomImp: String;

    FcdsDataSet: TUniClientDataSet;
    FfrxDataSet: TfrxDBDataset;

    procedure pIniciaObjetos;
    procedure pDefineFilaImpressao(blnConfigurar: Boolean);
    procedure pCarregaListaFuncoes;

    function fCriaClientDataset: TUniClientDataSet;
    function fOnUserFunctionEvent(const MethodName: String;
      var Params: Variant): Variant;
    function fFormataCpfCgcInterna(strValor: String): String;
    function fVerificaComponenteRelExiste(strComponente,
      strInformacao: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function fGetIsEmpty: Boolean;
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
  end;

Const
  FILA_IMPRESSAO_PROMIS = 'ImpNotaPromissoria';

implementation

uses
  untFuncoesSimples, untValorPorExtenso;

{ TRelNotaPromissoria }

constructor TRelNotaPromissoria.Create;
begin
  FPais   := fSetaPais;
  FcdsDataSet := fCriaClientDataset;

  With FcdsDataSet Do
  Begin
    Append;
    FieldByName('NUMPAR').AsString       := '99';
    FieldByName('CTR_CODCLI').AsString   := '123456789*';
    FieldByName('CTR_CODEMP').AsString   := '123';
    FieldByName('CTR_NUMDUP').AsString   := '000000000216';
    FieldByName('CTR_PARCEL').AsString   := 'A';
    FieldByName('CTR_ESPDOC').AsString   := 'AG';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_VALDUP').AsFloat    := 189;
    FieldByName('CTR_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CLI_NOMCLI').AsString   := 'Nome do Cliente Teste';
    FieldByName('CLI_CGCCPF').AsInteger  := 1;
    FieldByName('CLI_C_G_C_').AsString   := '00000000000';
    FieldByName('CLI_NUMR_G').AsString   := '47.587.896';
    FieldByName('CLI_ENDERE').AsString   := 'Rua dos Anjos';
    FieldByName('CLI_ENDNUM').AsString   := '666';
    FieldByName('CLI_BAIRRO').AsString   := 'Nosso ceú';
    FieldByName('CLI_C_E_P_').AsString   := '14270000';
    FieldByName('CLI_FONE01').AsString   := '16 99999-9999';
    FieldByName('CID_NOMCID').AsString   := 'Santa Rosa de Viterbo';
    FieldByName('CID_ESTADO').AsString   := 'SP';
    FieldByName('CLI_I_E_S_').AsString   := '123456';
    FieldByName('CTR_CODVEN').AsString   := '001';
    FieldByName('OPE_NOMOPE').AsString   := 'Operador 1';
    FieldByName('EMP_NOMFAN').AsString   := 'Citel Software - Nome Fantasia';
    FieldByName('EMP_NOMEMP').AsString   := 'Citel Software - Razão Social';
    FieldByName('EMP_C_G_C_').AsString   := '12345678912345';
    FieldByName('EMP_FONE01').AsString   := '16 3333-3333';
    FieldByName('EMP_ENDERE').AsString   := 'Av. Maurilio Biagi';
    FieldByName('EMP_ENDNUM').AsString   := '800';
    FieldByName('EMP_BAIRRO').AsString   := 'Santa Cruz';
    FieldByName('EMP_I_E_S_').AsString   := '15.660.294-6';
    FieldByName('CID_NOMCID_EMP').AsString := 'Ribeirão Preto';
    FieldByName('CID_ESTADO_EMP').AsString := 'SP';
    FieldByName('MemoVencimento').AsString := 'Vencimento: 01 DE JANEIRO DE 2000';
    FieldByName('MemoValor').AsString := 'R$ 189,00';
    FieldByName('MemoTexto').AsString :=
      '               Aos 01 DE JANEIRO DE 2000***** pagarei por esta única via de NOTA' +
      ' PROMISSORIA a ' + fPadR(FieldByName('EMP_NOMFAN').AsString, 40, '*') + ', CNPJ: 12.345.678/9123-45' +
      ' ou a sua ordem, a quantia de ' + Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(FieldByName('CTR_VALDUP').AsFloat))), 101, '*'),1, 51) + ' ' +
      Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(FieldByName('CTR_VALDUP').AsFloat))), 101, '*'),52, 101) +
      ' em moeda corrente deste país.';
    FieldByName('MemoTextoComRazaoSocial').AsString :=
      '               Aos 01 DE JANEIRO DE 2000***** pagarei por esta única via de NOTA' +
      ' PROMISSORIA a ' + fPadR(FieldByName('EMP_NOMEMP').AsString, 40, '*') + ', CNPJ: 12.345.678/9123-45' +
      ' ou a sua ordem, a quantia de ' + Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(FieldByName('CTR_VALDUP').AsFloat))), 101, '*'),1, 51) + ' ' +
      Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(FieldByName('CTR_VALDUP').AsFloat))), 101, '*'),52, 101) +
      ' em moeda corrente deste país.';
    FieldByName('MemoObs').AsString := 'Observação: Cobrar juros de mora: R$ 0,25 ao dia.';
    FieldByName('TOTPAR').AsString  := '99';
    FieldByName('NUMPED').AsString  := '000000000013';

    Post;
  End;

  pIniciaObjetos;
end;

destructor TRelNotaPromissoria.Destroy;
begin
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  FreeAndNil(FcdsDataSet);
  FreeAndNil(FfrxDataSet);
  inherited;
end;

function TRelNotaPromissoria.fCriaClientDataset: TUniClientDataSet;
  procedure AddField(FieldName: String; FieldType: TFieldType; FieldSize: Integer = 0);
  begin
    With Result.FieldDefs.AddFieldDef Do
    begin
      Name     := FieldName;
      DataType := FieldType;
      if FieldSize <> 0 then
        Size     := FieldSize;
    end;
  end;

begin
  Result := TUniClientDataSet.Create(Nil);

  AddField('NUMPAR', ftString, 2);
  AddField('CTR_CODCLI', ftString, 8);
  AddField('CTR_CODEMP', ftString, 3);
  AddField('CTR_NUMDUP', ftString, 200);
  AddField('CTR_PARCEL', ftString, 3);
  AddField('CTR_ESPDOC', ftString, 2);
  AddField('CTR_DTAVEN', ftDateTime);
  AddField('CTR_VALDUP', ftFloat);
  AddField('CTR_DTACAD', ftDateTime);
  AddField('CLI_NOMCLI', ftString, 60);
  AddField('CLI_CGCCPF', ftInteger);
  AddField('CLI_C_G_C_', ftString, 20);
  AddField('CLI_ENDERE', ftString, 60);
  AddField('CLI_ENDNUM', ftString, 10);
  AddField('CLI_BAIRRO', ftString, 60);
  AddField('CLI_C_E_P_', ftString, 9);
  AddField('CLI_FONE01', ftString, 15);
  AddField('CLI_I_E_S_', ftString, 18);
  AddField('CLI_NUMR_G', ftString, 15);
  AddField('CID_NOMCID', ftString, 40);
  AddField('CID_ESTADO', ftString, 2);
  AddField('CTR_CODVEN', ftString, 3);
  AddField('OPE_NOMOPE', ftString, 30);
  AddField('EMP_NOMFAN', ftString, 60);
  AddField('EMP_NOMEMP', ftString, 60);
  AddField('EMP_C_G_C_', ftString, 18);
  AddField('EMP_FONE01', ftString, 15);
  AddField('EMP_ENDERE', ftString, 40);
  AddField('EMP_ENDNUM', ftString, 5);
  AddField('EMP_BAIRRO', ftString, 25);
  AddField('EMP_I_E_S_', ftString, 18);
  AddField('CID_NOMCID_EMP', ftString, 40);
  AddField('CID_ESTADO_EMP', ftString, 2);
  AddField('MemoVencimento', ftString, 50);
  AddField('MemoValor', ftString, 50);
  AddField('MemoTexto', ftString, 5000);
  AddField('MemoTextoComRazaoSocial', ftString, 5000);
  AddField('MemoObs', ftString, 5000);
  AddField('TOTPAR', ftString, 2);
  AddField('NUMPED', ftString, 200);
  Result.CreateDataSet;
end;

function TRelNotaPromissoria.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelNotaPromissoria.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelNotaPromissoria.fGetFunctionsList: TStringList;
begin
  Result := FListaFuncoes;
end;

function TRelNotaPromissoria.fGetIsEmpty: Boolean;
begin
  Result := False;
end;

function TRelNotaPromissoria.fGetKey: String;
begin
  If (fCfgSis('NOTPMD') = '1') Then
    Result := 'PROM80'
  Else
    Result := 'PROM40';
end;

function TRelNotaPromissoria.fGetName: String;
begin
  If (fCfgSis('NOTPMD') = '1') Then
    Result := 'NOTA PROMISSÓRIA - 80 COLUNAS'
  else
    Result := 'NOTA PROMISSÓRIA - 40 COLUNAS';
end;

function TRelNotaPromissoria.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelNotaPromissoria.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelNotaPromissoria.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelNotaPromissoria.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

function TRelNotaPromissoria.fPrepareDataSetsAndVariables: Boolean;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('CFG_COMAGR', fCfgSis('COMAGR', varString));
    FDicVar.AddOrSetValue('NOMEMP','EMPRESSA 001');
    FDicVar.AddOrSetValue('ENDEMP','RUA DAS FLORES');
    FDicVar.AddOrSetValue('CIDEMP','RIBEIRÃO PRETO');
    FDicVar.AddOrSetValue('BAIEMP','NOVA ROMA');
    FDicVar.AddOrSetValue('ESTEMP','SP');
    FDicVar.AddOrSetValue('TELEMP','1639545998');
    FDicVar.AddOrSetValue('CEPEMP','14270000');
    FDicVar.AddOrSetValue('IESEMP','562039002114');
    FDicVar.AddOrSetValue('CGCEMP','52688892000169' );

    FDicVar.AddOrSetValue('NOMCLI','JULIANO HIROSHI ENDO' );
    FDicVar.AddOrSetValue('NOMFAN','JULIANO HIROSHI ENDO' );
    FDicVar.AddOrSetValue('ENDCLI','RUA DAS FLORES' );
    FDicVar.AddOrSetValue('CIDCLI','SÃO SIMÃO' );
    FDicVar.AddOrSetValue('BAICLI','HOPE' );
    FDicVar.AddOrSetValue('ESTCLI','SP' );

    FDicVar.AddOrSetValue('TELCLI','16993335992' );
    FDicVar.AddOrSetValue('CEPCLI','14270000' );
    FDicVar.AddOrSetValue('IESCLI','582034600111' );
    FDicVar.AddOrSetValue('CGCCLI','08346159000174' );
    FDicVar.AddOrSetValue('DTAEMI','01/01/2019' );

    FDicVar.AddOrSetValue('TOTGER',12.54 );
    FDicVar.AddOrSetValue('NUMAGR','4569823571258' );
    FDicVar.AddOrSetValue('VALEXT',152.54 );

    FDicVar.AddOrSetValue('MSGAGR','MENSAGEM AGRUPAMENTO');
    FDicVar.AddOrSetValue('QTDREG','1' );
    FDicVar.AddOrSetValue('DTAEXT','01/01/2001' );
  end;

begin
  Result := True;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

procedure TRelNotaPromissoria.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelNotaPromissoria.pIniciaObjetos;
begin

  FDicVar := TDictionary<String,Variant>.Create;
  FListaFuncoes := TStringList.Create;

  FfrxDataSet:= TfrxDBDataset.Create(nil);
  FfrxDataSet.Name := 'frxDatasetDup';
  FfrxDataSet.DataSet := FcdsDataSet;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FfrxDataSet;

  pDefineFilaImpressao(False);
end;

procedure TRelNotaPromissoria.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_PROMIS);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_PROMIS);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

procedure TRelNotaPromissoria.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcInterna(strValor: String): String;');
  FListaFuncoes.Add('function fFormataCEP(strCEP: String): String;');
  FListaFuncoes.Add('function fFormataFone(strFone: String): String;');
  FListaFuncoes.Add('function fRetExtensoNumero(Value : String):String;');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente, strInformacao : String):Boolean');

end;

function TRelNotaPromissoria.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataCpfCgcInterna') Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText(MethodName, 'fFormataCEP') Then
    Result := fFormataCEP(Params[0]);

  If SameText(MethodName, 'fFormataFone') Then
    Result := fFormataFone(Params[0]);

  If SameText(MethodName, 'fRetExtensoNumero') Then
    Result := fRetExtensoNumero(Params[0]);

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);
end;

function TRelNotaPromissoria.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TRelNotaPromissoria.fVerificaComponenteRelExiste(strComponente,
                                                        strInformacao: String) : Boolean;
begin
  Result := False;
end;

end.
