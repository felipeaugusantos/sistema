unit untRecAvulso;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,StrUtils;

Type
  TRecAvulso = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FcdsCTPDET: TUniClientDataSet;
      FcdsCADPAG: TUniClientDataSet;
      FDBDatasetCTPDET: TfrxDBDataset;
      FListaFuncoes: TStringList;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      function fCriaClientDatasetCTPDET: TUniClientDataSet;
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
      procedure pCarregaVariaveis;
    public
      constructor Create;
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String) : Boolean;
      function fFormataCpfCgcLOCAL(pCPFCGC : String): String;
      function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String;
  end;



Const
  FILA_IMPRESSAO_REC_AVULSO = 'frmRelFatReciboAvulso';

implementation

uses untCfgRel, untValorPorExtenso, UniDataSetProvider;

{ TRecAvulso }

constructor TRecAvulso.Create;
begin
  FModoDesigner := True;
  FPais   := fSetaPais;

  FcdsCTPDET := fCriaClientDatasetCTPDET;

  FcdsCTPDET.Append;
  FcdsCTPDET.FieldByName('NOMEMP').AsString   := '001';
  FcdsCTPDET.FieldByName('NUMTEL').AsString   := '1699999999';
  FcdsCTPDET.FieldByName('NOMCID').AsString   := 'RIBEIRÃO PRETO';
  FcdsCTPDET.FieldByName('NOMEND').AsString   := 'RUA TESTE';
  FcdsCTPDET.FieldByName('NOMBAI').AsString   := 'BAIRRO TESTE';
  FcdsCTPDET.FieldByName('NUMCEP').AsString   := '14444-44';
  FcdsCTPDET.FieldByName('VALREC').AsFloat    := 30.00;
  FcdsCTPDET.FieldByName('NOMREC').AsString   := 'FULANO DE TAL';
  FcdsCTPDET.FieldByName('VLREXT').AsString   := '(TRINTA REAIS)';
  FcdsCTPDET.FieldByName('HISREC').AsString   := 'REFERENTE AO TESTE';
  FcdsCTPDET.FieldByName('DTAREC').AsString   := '25/01/2000';
  FcdsCTPDET.FieldByName('NOMASS').AsString   := 'BELTRANO DE TAL';
  FcdsCTPDET.FieldByName('NROVIA').AsString   := '1';
  FcdsCTPDET.FieldByName('CGCCPF').AsString   := '111.111.111-11';
  FcdsCTPDET.FieldByName('CLICPF').AsString   := '111.111.111-11';
  FcdsCTPDET.FieldByName('ENDCLI').AsString   := 'Rua Antonio Lerco';
  FcdsCTPDET.FieldByName('ENDNRO').AsString   := '150';
  FcdsCTPDET.FieldByName('ENDCID').AsString   := 'RIBEIRÃO PRETO';
  FcdsCTPDET.FieldByName('NUMCNPJ').AsString  := '52.688.892.0001/69';
  FcdsCTPDET.FieldByName('NUMEND').AsString   := '475';

  FcdsCTPDET.Post;

  pIniciaObjetos;
end;

procedure TRecAvulso.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDBDatasetCTPDET := TfrxDBDataset.Create(nil);
  FDBDatasetCTPDET.Name := 'frxDBDatasetCTPDET';
  //FDBDatasetCTPDET.Name := 'frxUser';
  FDBDatasetCTPDET.DataSet := FcdsCTPDET;

   SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDBDatasetCTPDET;

  pDefineFilaImpressao(False);
end;

destructor TRecAvulso.Destroy;
begin
  FreeAndNil(FDBDatasetCTPDET);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRecAvulso.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRecAvulso.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_REC_AVULSO);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_REC_AVULSO);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRecAvulso.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fFormataCpfCgcLOCAL', MethodName) Then
    Result := fFormataCpfCgcLOCAL(Params[0]);

  If SameText('fReplaceStrLOCAL', MethodName) Then
    Result := fReplaceStrLOCAL(Params[0], Params[1], Params[2]);

  If SameText('fVerificaComponenteRelExiste', MethodName) Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);
end;



function TRecAvulso.fFormataCpfCgcLOCAL(pCPFCGC: String): String;
begin
  Result := fFormataCpfCgc(pCPFCGC, fSetaPais);
end;

function TRecAvulso.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRecAvulso.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRecAvulso.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRecAvulso.fGetIsEmpty: Boolean;
begin
  Result := FcdsCADPAG.IsEmpty;
end;

function TRecAvulso.fGetKey: String;
begin

  If fCfgSis('COLRAV', varInteger) = 1 Then
  Begin
    Result := 'RECAV1'; // 40 COLUNAS;
  End
  Else If fCfgSis('COLRAV', varInteger) = 2 Then
  Begin
    Result := 'RECAVU'; // 80 COLUNAS;
  End;

end;

function TRecAvulso.fGetName: String;
begin

  If fCfgSis('COLRAV', varInteger) = 1 Then
  Begin
    Result := 'RECIBO AVULSO - 40 COLUNAS';
  End
  Else If fCfgSis('COLRAV', varInteger) = 2 Then
  Begin
    Result := 'RECIBO AVULSO - 80 COLUNAS';
  End;

end;

function TRecAvulso.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRecAvulso.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRecAvulso.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRecAvulso.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRecAvulso.fPrepareDataSetsAndVariables: Boolean;
begin
  Result := True;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

function TRecAvulso.fReplaceStrLOCAL(strTexto, strOLD,
  strNew: String): String;
begin
  Result := ReplaceStr(strTexto, strOLD, strNew);
end;

function TRecAvulso.fVerificaComponenteRelExiste(strComponente,
                                                     strInformacao : String ): Boolean;
begin
  Result := False;
end;

function TRecAvulso.fCriaClientDatasetCTPDET: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('NOMEMP',ftString,100);
  Result.FieldDefs.Add('NUMTEL',ftString,15);
  Result.FieldDefs.Add('NOMCID',ftString,40);
  Result.FieldDefs.Add('NOMEND',ftString,40);
  Result.FieldDefs.Add('NOMBAI',ftString,25);
  Result.FieldDefs.Add('NUMCEP',ftString,9);
  Result.FieldDefs.Add('VALREC',ftString,20);
  Result.FieldDefs.Add('NOMREC',ftString,80);
  Result.FieldDefs.Add('VLREXT',ftString,80);
  Result.FieldDefs.Add('CGCCPF',ftString,80);
  Result.FieldDefs.Add('HISREC',ftString,80);
  Result.FieldDefs.Add('DTAREC',ftString,100);
  Result.FieldDefs.Add('NOMASS',ftString,60);
  Result.FieldDefs.Add('NROVIA',ftString,20);
  Result.FieldDefs.Add('CLICPF',ftString,80);
  Result.FieldDefs.Add('ENDCLI',ftString,100);
  Result.FieldDefs.Add('ENDNRO',ftString,10);
  Result.FieldDefs.Add('ENDCID',ftString,60);
  Result.FieldDefs.Add('NUMCNPJ',ftString,60);
  Result.FieldDefs.Add('NUMEND' ,ftString,5);

  Result.CreateDataSet;
end;

procedure TRecAvulso.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  FDicVar.AddOrSetValue('strNOMREC', FcdsCTPDET.FieldByName('NOMREC').AsString);
  FDicVar.AddOrSetValue('strVALREC', FcdsCTPDET.FieldByName('VALREC').AsString);
  FDicVar.AddOrSetValue('strVLREXT', FcdsCTPDET.FieldByName('VLREXT').AsString);
  FDicVar.AddOrSetValue('strHISREC', FcdsCTPDET.FieldByName('HISREC').AsString);
  FDicVar.AddOrSetValue('strCGCCPF', IIF(fEmptyStr(FcdsCTPDET.FieldByName('CGCCPF').AsString),FcdsCTPDET.FieldByName('CLICPF').AsString,FcdsCTPDET.FieldByName('CGCCPF').AsString));
  FDicVar.AddOrSetValue('strCLICPF', IIF(fEmptyStr(FcdsCTPDET.FieldByName('CGCCPF').AsString),FcdsCTPDET.FieldByName('CLICPF').AsString,FcdsCTPDET.FieldByName('CGCCPF').AsString));
  FDicVar.AddOrSetValue('strENDCLI', IIF(fEmptyStr(FcdsCTPDET.FieldByName('ENDCLI').AsString),'', FcdsCTPDET.FieldByName('ENDCLI').AsString + ', ') );
  FDicVar.AddOrSetValue('strENDNRO', IIF(fEmptyStr(FcdsCTPDET.FieldByName('ENDNRO').AsString),'', FcdsCTPDET.FieldByName('ENDNRO').AsString + ', ') );
  FDicVar.AddOrSetValue('strENDCID', IIF(fEmptyStr(FcdsCTPDET.FieldByName('ENDCID').AsString),'', FcdsCTPDET.FieldByName('ENDCID').AsString + ', ') );
end;

procedure TRecAvulso.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcLOCAL(pCPFCGC : String): String');
  FListaFuncoes.Add('function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente, strInformacao : String) : Boolean');
end;

end.
