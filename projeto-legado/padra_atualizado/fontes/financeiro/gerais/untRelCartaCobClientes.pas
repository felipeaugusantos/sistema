unit untRelCartaCobClientes;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;



Type
  TRelCartaCobClientes = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FListaFuncoes: TStringList;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      FCdsDuplicatas: TUniClientDataSet;
      FDataSetDuplicatasExtCob: TfrxDBDataset;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      procedure pCarregaVariaveis;
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
      constructor Create;
      constructor CreateInstance;
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;


  function fCriaClientDataSetDuplicatas: TUniClientDataSet;

Const
  FILA_IMPRESSAO_AUTABA = 'frmRelCartaExtratoCobClientes';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCartaCobClientes }

constructor TRelCartaCobClientes.Create;
begin
  FModoDesigner := True;
  FPais   := fSetaPais;


  FCdsDuplicatas := fCriaClientDataSetDuplicatas;
  FCdsDuplicatas.Append;
  FCdsDuplicatas.FieldByName('CTR_NUMDUP').AsString    := '000000015767A-FF-007';
  FCdsDuplicatas.FieldByName('QTDTIT').AsInteger       := 1;
  FCdsDuplicatas.FieldByName('CTR_PARCEL').AsString    := 'A';
  FCdsDuplicatas.FieldByName('CTR_ESPDOC').AsString    := 'FF';
  FCdsDuplicatas.FieldByName('CTR_DTAVEN').AsDateTime  :=  StrToDateTime('06/09/2020');
  FCdsDuplicatas.FieldByName('CTR_DTACAD').AsDateTime  :=  StrToDateTime('06/08/2020');
  FCdsDuplicatas.FieldByName('CTR_VALORI').AsFloat     := 179.50;
  FCdsDuplicatas.FieldByName('CTR_VALDUP').AsFloat     := 179.50;
  FCdsDuplicatas.FieldByName('CTR_CORRIGIDO').AsFloat  := 190.53;
  FCdsDuplicatas.FieldByName('CTR_JUROS').AsFloat      := 10.01;
  FCdsDuplicatas.FieldByName('CTR_MULTA').AsFloat      := 1.03;
  FCdsDuplicatas.FieldByName('CLI_ENDERE').AsString    := 'Avenida Silvio Angelo Nigro';
  FCdsDuplicatas.FieldByName('CLI_BAIRRO').AsString    := '1º Distrito Industrial José Cutrale Junior';
  FCdsDuplicatas.FieldByName('CLI_C_E_P_').AsString    := '14811-340';
  FCdsDuplicatas.FieldByName('CLI_ENDNUM').AsString    := '340';
  FCdsDuplicatas.FieldByName('CLI_ENDCOM').AsString    := 'CLI_ENDCOM';
  FCdsDuplicatas.FieldByName('CID_NOMCID').AsString    := 'ARARAQUARA';
  FCdsDuplicatas.FieldByName('CID_CIDADE').AsString    := 'ARARAQUARA-SP';
  FCdsDuplicatas.FieldByName('CID_ESTADO').AsString    := 'SP';
  FCdsDuplicatas.FieldByName('CTR_CODCLI').AsString    := '00059920';
  FCdsDuplicatas.FieldByName('AUTINC').AsString        := '00100000000000101001';
  FCdsDuplicatas.FieldByName('CLI_NOMCLI').AsString    := 'CLIENTE FINANCEIRO';
  FCdsDuplicatas.FieldByName('CLI_C_G_C_').AsString    := '21573880876';
  FCdsDuplicatas.FieldByName('CLI_CGCCPF').AsString    := '2';
  FCdsDuplicatas.FieldByName('CLI_EMAIL_').AsString    := 'cli_email_@gmail.com';
  FCdsDuplicatas.FieldByName('CLI_EMCOB1').AsString    := 'cli_emcob1@gmail.com';
  FCdsDuplicatas.FieldByName('CLI_EMCOB2').AsString    := 'cli_emcob2@gmail.com';
  FCdsDuplicatas.FieldByName('CLI_EMAIL2').AsString    := 'cli_email2@gmail.com';
  FCdsDuplicatas.FieldByName('CLI_EMAIL2').AsString    := 'cli_email3@gmail.com';
  FCdsDuplicatas.FieldByName('DIAS_ATRASO').AsInteger  := 0;
  FCdsDuplicatas.Post;

  pIniciaObjetos;
end;

constructor TRelCartaCobClientes.CreateInstance;
begin
  FModoDesigner := False;
  FCdsDuplicatas := TUniClientDataSet.Create(Nil);
  pIniciaObjetos;
end;

procedure TRelCartaCobClientes.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;
  FListaFuncoes := TStringList.Create;

  FDataSetDuplicatasExtCob := TfrxDBDataset.Create(Nil);
  FDataSetDuplicatasExtCob.Name := 'frxDataSetDuplicatasExtCob';
  FDataSetDuplicatasExtCob.DataSet := FCdsDuplicatas;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDataSetDuplicatasExtCob;

  pDefineFilaImpressao(False);
end;

destructor TRelCartaCobClientes.Destroy;
begin
  FreeAndNil(FDataSetDuplicatasExtCob);
  FreeAndNil(FCdsDuplicatas);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCartaCobClientes.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRetornaDescricaoVeic(strPlaVei: String): String;');
  FListaFuncoes.Add('function fRetNomFornecedor(strCodFor: String): String;');
  FListaFuncoes.Add('function fRetNomeMotorista(strCodMot: String): String;');
  FListaFuncoes.Add('function fRetNomeEmpresaSelec(strCodEmp: String): String');
  FListaFuncoes.Add('function fTiraCaracEspeciaisPonto(strTexto: String): String;');
  FListaFuncoes.Add('function fRemoveAcento(Str:String): String;');
end;

procedure TRelCartaCobClientes.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCartaCobClientes.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_AUTABA);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_AUTABA);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCartaCobClientes.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fRetornaDescricaoVeic', MethodName) Then
    Result := fRetornaDescricaoVeic(Params[0]);

  If SameText('fRetNomFornecedor', MethodName) Then
    Result := fRetNomFornecedor(Params[0]);

  If SameText('fRetNomeMotorista', MethodName) Then
    Result := fRetNomeMotorista(Params[0]);

  If SameText('fRetNomeEmpresaSelec', MethodName) Then
    Result := fRetNomeEmpresaSelec(Params[0]);

  If SameText('fTiraCaracEspeciaisPonto', MethodName) Then
    Result := fTiraCaracEspeciaisPonto(Params[0]);

  If SameText('fRemoveAcento', MethodName) Then
    Result := fRemoveAcento(Params[0]);
end;

function TRelCartaCobClientes.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelCartaCobClientes.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCartaCobClientes.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCartaCobClientes.fGetIsEmpty: Boolean;
begin
  Result := FCdsDuplicatas.IsEmpty;;
end;

function TRelCartaCobClientes.fGetKey: String;
begin
  Result := 'CRTCOB';
end;

function TRelCartaCobClientes.fGetName: String;
begin
  Result := 'CARTA DE COBRANÇA DE CLIENTES';
end;

function TRelCartaCobClientes.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCartaCobClientes.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCartaCobClientes.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCartaCobClientes.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

procedure TRelCartaCobClientes.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('NOMCID','São Paulo');
  FDicVar.AddOrSetValue('NOMEMP','NOME EMPRESA');
  FDicVar.AddOrSetValue('EMPFAN','NOME FANTASIA EMPRESA');
  FDicVar.AddOrSetValue('CGCEMP','12.193.970/0001-30');
  FDicVar.AddOrSetValue('CEPEMP','14270-000');
  FDicVar.AddOrSetValue('ENDEMP','Av. Mauro Biagi, 800 - 2º Andar - Santa Cruz do Jose Jacques');
  FDicVar.AddOrSetValue('CIDEMP','Ribeirão Preto - SP');
  FDicVar.AddOrSetValue('FONEMP','(16) 4009-6000');
  FDicVar.AddOrSetValue('FAXEMP','(86) 2649-1274');
  FDicVar.AddOrSetValue('FANSOB','NOME FANTASIA CLIENTE');
end;

function TRelCartaCobClientes.fPrepareDataSetsAndVariables: Boolean;
begin
  Result := False;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

function fCriaClientDataSetDuplicatas: TUniClientDataSet;
  var
    intCnt: Integer;
    strSQL: String;
    qryGenerica: TUniQuery;
Begin
  qryGenerica := fCriaQuery;
  Result := TUniClientDataSet.Create(nil);

  strSQL := 'SELECT                                                     '+
            '  CONCAT(                                                  '+
            '  CTR_NUMDUP,                                              '+
            '  CTR_PARCEL,                                              '+
            '  "-",                                                     '+
            '  CTR_ESPDOC,                                              '+
            '  "-",                                                     '+
            '  CTR_CODEMP                                               '+
            '  ) AS CTR_NUMDUP,                                         '+
            '  1 AS QTDTIT,                                             '+
            '  CTR_PARCEL,                                              '+
            '  CTR_ESPDOC,                                              '+
            '  CTR_DTAVEN,                                              '+
            '  CTR_DTACAD,                                              '+
            '  CTR_VALORI,                                              '+
            '  (                                                        '+
            '  CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) +                     '+
            ' IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)             '+
            '  ) AS CTR_VALDUP,                                         '+
            '  0.00 AS CTR_CORRIGIDO,                                   '+
            '  0.00 AS CTR_JUROS,                                       '+
            '  0.00 AS CTR_MULTA,                                       '+
            '  CLI_ENDERE,                                              '+
            '  CLI_BAIRRO,                                              '+
            '  CLI_C_E_P_,                                              '+
            '  CLI_ENDNUM,                                              '+
            '  CLI_ENDCOM,                                              '+
            '  D1.CID_NOMCID AS CID_NOMCID,                             '+
            '  CONCAT(D1.CID_NOMCID, "-", D1.CID_ESTADO) AS CID_CIDADE, '+
            '  D1.CID_ESTADO AS CID_ESTADO,                             '+
            '  CTR_CODCLI,                                              '+
            '  CADCLI.AUTOINCREM AS AUTINC,                             '+
            '  CLI_CODCLI,                                              '+
            '  CLI_NOMCLI,                                              '+
            '  CLI_C_G_C_,                                              '+
            '  CLI_CGCCPF,                                              '+
            '  CLI_EMAIL_,                                              '+
            '  CLI_EMCOB1,                                              '+
            '  CLI_EMCOB2,                                              '+
            '  CLI_EMAIL2,                                              '+
            '  CLI_EMAIL3,                                              '+
            '  0 AS DIAS_ATRASO                                         '+
            'FROM                                                       '+
            '  CADREC                                                   '+
            '  INNER JOIN CADCLI                                        '+
            '    ON CLI_CODCLI = CTR_CODCLI                             '+
            '  LEFT JOIN CADCID D1                                      '+
            '    ON CLI_CODCID = D1.CID_CODCID                          '+
            '  LEFT JOIN CADCID D2                                      '+
            '    ON CLI_CIDCOB = D2.CID_CODCID                          '+
            'WHERE FALSE                                                ';

  Try
    qryGenerica.SQL.Text := strSQL;
    qryGenerica.Open;

    For intCnt := 0 To qryGenerica.FieldDefs.Count - 1 Do
      Result.FieldDefs.Add(qryGenerica.Fields[intCnt].FullName,
                           qryGenerica.Fields[intCnt].DataType,
                           qryGenerica.Fields[intCnt].Size);

  Finally
    FreeAndNil(qryGenerica);
  End;

  Result.CreateDataSet;
End;

end.
