unit untRelFichaCadCliente;

interface

uses
  Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, System.Variants,
  Uni, UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TFichaCadCliente = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FListaFuncoes: TStringList;
      FUniClientDataset: TUniClientDataSet;
      frxResumoFinanceiro: TUniClientDataSet;
      frxRelatorioContatos: TUniClientDataSet;
      frxRelatorioAutorizacaoCompra: TUniClientDataSet;
      frxSocios: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FDataSetCadCliente: TfrxDBDataset;
      FDataSetResumoFinanceiro: TfrxDBDataset;
      FDataSetRelatorioContatos: TfrxDBDataset;
      FDataSetRelatorioAutorizacao: TfrxDBDataset;
      FDataSetSocios: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      procedure pIniciaObjetos;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function fFormataFoneInterna(strFone: String): String;
      function fFormataCGCInterna(strC_G_C_: String): String;
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

  function fCriaClientDataSetFichaCTR: TUniClientDataSet;
  function fCriaClientDataSetfrxGen: TUniClientDataSet;
  function fCriaClientDataSetfrxResumoFinanceiro: TUniClientDataSet;
  function fCriaClientDataSetfrxRelatorioContatos: TUniClientDataSet;
  function fCriaClientDataSetfrxRelatorioAutorizacaoCompra: TUniClientDataSet;
  function fCriaClientDataSetfrxSocios: TUniClientDataSet;

Const
  FILA_IMPRESSAO_CTR = 'impressao_ficha_cad_cliente';

implementation

uses
  untCfgRel, untValorPorExtenso;

{ TFichaCadCliente }

constructor TFichaCadCliente.Create;
begin
  FModoDesigner := True;
  FPais := fSetaPais;

  FUniClientDataset := fCriaClientDatasetFichaCTR;
  FUniClientDataset.Append;
  FUniClientDataset.FieldByName('CLI_CODCLI').AsString   := '000000000001';
  FUniClientDataset.FieldByName('CLI_DTACAD').AsDateTime := StrToDateTime('01/01/2020');
  FUniClientDataset.FieldByName('CLI_DTAALT').AsDateTime := StrToDateTime('01/01/2020');
  FUniClientDataset.FieldByName('CLI_CODVEN').AsString   := '000000000001';
  FUniClientDataset.FieldByName('CLI_NOMCLI').AsString   := 'NOME/RAZÃO CLIENTE';
  FUniClientDataset.FieldByName('CLI_FANSOB').AsString   := 'FANTASIA/SOBRENOME';
  FUniClientDataset.FieldByName('CLI_CODEMP').AsString   := VS_strCodEmp;
  FUniClientDataset.FieldByName('CLI_CODATI').AsString   := '00000000001';
  FUniClientDataset.FieldByName('CLI_ENDERE').AsString   := 'RUA A';
  FUniClientDataset.FieldByName('CLI_BAIRRO').AsString   := 'BAIRRO CENTRO';
  FUniClientDataset.FieldByName('CLI_C_E_P_').AsString   := '00000-000';
  FUniClientDataset.FieldByName('CLI_NUMR_G').AsString   := '1234567890';
  FUniClientDataset.FieldByName('CLI_C_G_C_').AsString   := '00.000.000.0000-00';
  FUniClientDataset.FieldByName('CLI_I_E_S_').AsString   := '0000000001';
  FUniClientDataset.FieldByName('CLI_NASCIM').AsDateTime := StrToDateTime('01/01/2020');
  FUniClientDataset.FieldByName('CLI_FONE01').AsString   := '(11)99999-9999';
  FUniClientDataset.FieldByName('CLI_RAMAL1').AsString   := '001';
  FUniClientDataset.FieldByName('CLI_FONE02').AsString   := '(22)99999-9999';
  FUniClientDataset.FieldByName('CLI_RAMAL2').AsString   := '002';
  FUniClientDataset.FieldByName('CLI_F_A_X_').AsString   := '(33)99999-9999';
  FUniClientDataset.FieldByName('CLI_RAMAL3').AsString   := '003';
  FUniClientDataset.FieldByName('CLI_CELULA').AsString   := '(99)99999-9999';
  FUniClientDataset.FieldByName('CLI_CONTAT').AsString   := '(88)99999-9999';
  FUniClientDataset.FieldByName('CLI_EMAIL_').AsString   := 'EMAILCLIENTE@EMAIL.COM';
  FUniClientDataset.FieldByName('CLI_STATUS').AsString   := 'ATIVO';
  FUniClientDataset.FieldByName('CLI_CONSUM').AsString   := 'SIM';
  FUniClientDataset.Post;

  frxResumoFinanceiro := fCriaClientDataSetfrxResumoFinanceiro;
  frxResumoFinanceiro.Append;
  frxResumoFinanceiro.FieldByName('TOT_DUP_ABE_QTD').AsInteger  := 1;
  frxResumoFinanceiro.FieldByName('TOT_DUP_ABE_VAL').AsFloat    := 1000;
  frxResumoFinanceiro.FieldByName('TOT_DUP_LIQ_QTD').AsInteger  := 1;
  frxResumoFinanceiro.FieldByName('TOT_DUP_LIQ_VAL').AsFloat    := 999;
  frxResumoFinanceiro.FieldByName('TOT_DUP_ATR_QTD').AsInteger  := 1;
  frxResumoFinanceiro.FieldByName('TOT_DUP_ATR_VAL').AsFloat    := 888;
  frxResumoFinanceiro.FieldByName('TOT_DUP_LTR_QTD').AsInteger  := 1;
  frxResumoFinanceiro.FieldByName('TOT_DUP_LTR_VAL').AsFloat    := 777;
  frxResumoFinanceiro.FieldByName('LIM_CRE_DISPONI').AsFloat    := 9999;
  frxResumoFinanceiro.FieldByName('ULT_COMPRA_DATA').AsDateTime := StrToDateTime('01/01/2020');
  frxResumoFinanceiro.FieldByName('ULT_COMPRA_NOTA').AsString   := 'NOTA01';
  frxResumoFinanceiro.FieldByName('ULT_COMPRA_VAL_').AsFloat    := 250;
  frxResumoFinanceiro.FieldByName('MAI_COMPRA_DATA').AsDateTime := StrToDateTime('01/01/2020');;
  frxResumoFinanceiro.FieldByName('MAI_COMPRA_NOTA').AsString   := '00000001-FF';
  frxResumoFinanceiro.FieldByName('MAI_COMPRA_VAL_').AsFloat    := 150;
  frxResumoFinanceiro.FieldByName('ATRASADOS_MEDIA').AsFloat    := 50;
  frxResumoFinanceiro.FieldByName('ATRASADOS_MAIOR').AsFloat    := 100;
  frxResumoFinanceiro.FieldByName('ATRASADOS_ATUAL').AsFloat    := 1;
  frxResumoFinanceiro.Post;

  frxRelatorioContatos := fCriaClientDataSetfrxRelatorioContatos;
  frxRelatorioContatos.Append;
  frxRelatorioContatos.FieldByName('CLI_NOMCTT').AsString   := 'NOME DO CONTATO';
  frxRelatorioContatos.FieldByName('CLI_NASCTT').AsDateTime := StrToDateTime('01/01/2020');
  frxRelatorioContatos.FieldByName('CLI_ENDCTT').AsString   := 'ENDEREÇO CONTATO';
  frxRelatorioContatos.FieldByName('CLI_BAICTT').AsString   := 'BAIRRO CONTATO';
  frxRelatorioContatos.FieldByName('CLI_EMACTT').AsString   := 'CONTATO@EMAIL.COM';
  frxRelatorioContatos.FieldByName('CLI_DEPCTT').AsString   := 'DEPARTAMENTO CONTATO';
  frxRelatorioContatos.FieldByName('CLI_TELCTT').AsString   := '(99)99999-9999';
  frxRelatorioContatos.FieldByName('CLI_CELCTT').AsString   := '(99)99999-9999';
  frxRelatorioContatos.FieldByName('CLI_FAXCTT').AsString   := '(99)99999-9999';
  frxRelatorioContatos.FieldByName('CLI_OBSERV').AsString   := 'OBSERVAÇÃO DO CONTATO';
  frxRelatorioContatos.FieldByName('CID_NOMCID').AsString   := 'NOME CIDADE DO CONTATO';
  frxRelatorioContatos.FieldByName('CID_ESTADO').AsString   := 'ESTADO DO CONTATO';
  frxRelatorioContatos.Post;

  frxRelatorioAutorizacaoCompra := fCriaClientDataSetfrxRelatorioAutorizacaoCompra;
  frxRelatorioAutorizacaoCompra.Append;
  frxRelatorioAutorizacaoCompra.FieldByName('CLI_NOMCTT').AsString := 'NOME CONTATO AUTORIZADO DE COMPRA';
  frxRelatorioAutorizacaoCompra.FieldByName('CLI_NUMR_G').AsString := '1234567890';
  frxRelatorioAutorizacaoCompra.FieldByName('CLI_NUMCPF').AsString := '123.456.789-00';
  frxRelatorioAutorizacaoCompra.FieldByName('CLI_ASSCTT').AsString := 'ASSINATURA AUTORIZADO';
  frxRelatorioAutorizacaoCompra.Post;

  frxSocios := fCriaClientDataSetfrxSocios;
  frxSocios.Append;
  frxSocios.FieldByName('SCO_NOMSCO').AsString   := 'NOME DO SÓCIO';
  frxSocios.FieldByName('SCO_CPFCNP').AsString   := '123.456.789-00';
  frxSocios.FieldByName('SCO_DTANAS').AsDateTime := StrToDateTime('01/01/2020');
  frxSocios.FieldByName('SCO_PER_PS').AsString   := '15%';
  frxSocios.FieldByName('SCO_ESTCIV').AsString   := 'SOLTEIRO/CASADO/MARITAL/OUTROS';
  frxSocios.Post;

  pIniciaObjetos;
end;

constructor TFichaCadCliente.CreateInstance;
begin
  FModoDesigner := False;

  FUniClientDataset := TUniClientDataSet.Create(Nil);

  pIniciaObjetos;
end;

procedure TFichaCadCliente.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadCliente := TfrxDBDataset.Create(Nil);
  FDataSetCadCliente.Name := 'frxRelatorio';
  FDataSetCadCliente.DataSet := FUniClientDataset;

  FDataSetResumoFinanceiro := TfrxDBDataset.Create(Nil);
  FDataSetResumoFinanceiro.Name := 'frxResumoFinanceiro';
  FDataSetResumoFinanceiro.DataSet := frxResumoFinanceiro;

  FDataSetRelatorioContatos := TfrxDBDataset.Create(Nil);
  FDataSetRelatorioContatos.Name := 'frxRelatorioContatos';
  FDataSetRelatorioContatos.DataSet := frxRelatorioContatos;

  FDataSetRelatorioAutorizacao := TfrxDBDataSet.Create(Nil);
  FDataSetRelatorioAutorizacao.Name := 'frxRelatorioAutorizacaoCompra';
  FDataSetRelatorioAutorizacao.DataSet := frxRelatorioAutorizacaoCompra;

  FDataSetSocios := TfrxDBDataSet.Create(Nil);
  FDataSetSocios.Name := 'frxSocios';
  FDataSetSocios.DataSet := frxSocios;

  SetLength(FArrDBDataSet, 5);
  FArrDBDataSet[0] := FDataSetCadCliente;
  FArrDBDataSet[1] := FDataSetResumoFinanceiro;
  FArrDBDataSet[2] := FDataSetRelatorioContatos;
  FArrDBDataSet[3] := FDataSetRelatorioAutorizacao;
  FArrDBDataSet[4] := FDataSetSocios;

  pDefineFilaImpressao(False);
end;

destructor TFichaCadCliente.Destroy;
begin
  FreeAndNil(FUniClientDataset);
  FreeAndNil(FDataSetCadCliente);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetResumoFinanceiro);
  FreeAndNil(FDataSetRelatorioContatos);
  FreeAndNil(FDataSetRelatorioAutorizacao);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);

  inherited;
end;

procedure TFichaCadCliente.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TFichaCadCliente.pDefineFilaImpressao(blnConfigurar: Boolean);
var
  qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  Try
    pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_CTR);

    If blnConfigurar Then
      pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_CTR);

    FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If fEmptyStr(FTipImp) Then
      FTipImp := 'J';
  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

procedure TFichaCadCliente.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCondPag(strCond : String): String');
  FListaFuncoes.Add('function fFormataCGCInterna(strC_G_C_: String): String');
  FListaFuncoes.Add('function fFormataFoneInterna(strFone: String): String;');
end;

function TFichaCadCliente.fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]))
  Else If SameText(MethodName, 'fFormataFoneInterna') Then
    Result := fFormataFoneInterna(Params[0])
  Else If SameText(MethodName, 'fFormataCGCInterna') Then
    Result := fFormataCGCInterna(Params[0]);
end;

function TFichaCadCliente.fFormataCGCInterna(strC_G_C_: String): String;
begin
  Result := fFormataCpfCgc(strC_G_C_, FPais);
end;

function TFichaCadCliente.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

function TFichaCadCliente.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TFichaCadCliente.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TFichaCadCliente.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TFichaCadCliente.fGetIsEmpty: Boolean;
begin
  Result := FUniClientDataset.IsEmpty;
end;

function TFichaCadCliente.fGetKey: String;
begin
  Result := 'FICCLI';
end;

function TFichaCadCliente.fGetName: String;
begin
  Result := 'FICHA CADASTRAL - CLIENTE';
end;

function TFichaCadCliente.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TFichaCadCliente.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TFichaCadCliente.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TFichaCadCliente.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

procedure TFichaCadCliente.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  FDicVar.AddOrSetValue('NOMREL', 'FICHA CADASTRAL - CLIENTE');
  FDicVar.AddOrSetValue('REL_NOMREL', 'FICHA CADASTRAL');
  FDicVar.AddOrSetValue('NOMEMP', fRetNomeEmpresa);
  FDicVar.AddOrSetValue('R.G.', IIF(FPais = opcParaguai, 'CI', 'R.G.'));
  FDicVar.AddOrSetValue('CNPJ/CPF', IIF(FPais = opcParaguai, 'RUC', 'CNPJ/CPF'));
  FDicVar.AddOrSetValue('OBSCAD', fCfgSis('OBSCAD'));
  FDicVar.AddOrSetValue('MSGROD', fCfgSis('MSGROD'));
end;

function TFichaCadCliente.fPrepareDataSetsAndVariables: Boolean;
begin
  Result := True;

  FDicTot.Limpar;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

function fCriaClientDatasetFichaCTR: TUniClientDataSet;
var
  intCnt: Integer;
  strSQL: String;
  qryGenerica: TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);

  qryGenerica := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE';
  strSQL := strSQL + '   CADCLI.CLI_CODCLI, CLI_DTACAD, CLI_DTAALT, CADCLI.CLI_CODVEN, ';
  strSQL := strSQL + '   CLI_HOMEPA, CLI_NOMCLI, CLI_FANSOB, CADCLI.CLI_CODEMP, CADCLI.CLI_CODATI,';
  strSQL := strSQL + '   CLI_ENDERE, CLI_BAIRRO, CLI_C_E_P_, ';
  strSQL := strSQL + '   CLI_CAIPOS, CLI_NUMR_G, CLI_C_G_C_, CLI_I_E_S_, CLI_I_M_P_, CLI_NASCIM, ';
  strSQL := strSQL + '   CLI_FONE01, CLI_RAMAL1, CLI_FONE02, CLI_RAMAL2, CLI_F_A_X_, CLI_RAMAL3, ';
  strSQL := strSQL + '   CLI_CELULA, CLI_CONTAT, CLI_EMAIL_, CLI_STATUS, CLI_CONSUM, CLI_ORGPUB, ';
  strSQL := strSQL + '   CLI_ZONFRA, CLI_RETPCO, CLI_RETIRF, CLI_RETISS, CLI_SEGSOC, CLI_CALICM, ';
  strSQL := strSQL + '   IC.CLI_CASAPR AS CLI_CASAPR, CLI_ORPURD, CLI_CODCON, CLI_LIMCRE, ';
  strSQL := strSQL + '   CLI_OBS_01, CLI_OBS_02, CLI_OBS_03, CLI_OBS_04, CLI_DOUCOM, CLI_ULTCOM, ';
  strSQL := strSQL + '   CLI_VRUCOM, CLI_DOMCOM, CLI_DTMCOM, CLI_VRMCOM, CLI_ENDCOB, CLI_BAICOB, ';
  strSQL := strSQL + '   CLI_CIDCOB, CLI_CEPCOB, CLI_TELCOB, CLI_CONCOB, CLI_CNDPAG, CND_CNDPAG, ';

  strSQL := strSQL + '   ETC_ENDENT AS CLI_ENDENT, ';
  strSQL := strSQL + '   ETC_BAIENT AS CLI_BAIENT, ';
  strSQL := strSQL + '   ETC_CIDENT AS CLI_CIDENT, ';
  strSQL := strSQL + '   ETC_CEPENT AS CLI_CEPENT, ';
  strSQL := strSQL + '   ETC_TELENT AS CLI_TELENT, ';
  strSQL := strSQL + '   ETC_CONENT AS CLI_CONENT, ';

  strSQL := strSQL + '   IC.CLI_VISA__, IC.CLI_MASTER, IC.CLI_HIPERC, IC.CLI_AMERIC, IC.CLI_DINERS, ';
  strSQL := strSQL + '   IC.CLI_NOMPAI, IC.CLI_NOMMAE, IC.CLI_CONJUG, IC.CLI_NASCON, ';
  strSQL := strSQL + '   CLI_ALQISS, CLI_CODRED, CLI_OBSERV, CLI_DTACON, ';
  strSQL := strSQL + '   CLI_QTDPRO, CLI_CHEDEV, CLI_OBSCON, FIC_NOMBC1, ';
  strSQL := strSQL + '   FIC_AGEBC1, FIC_TELBC1, FIC_CONBC1, FIC_NOMBC2, ';
  strSQL := strSQL + '   FIC_AGEBC2, FIC_TELBC2, FIC_CONBC2, FIC_NOMBC3, ';
  strSQL := strSQL + '   FIC_AGEBC3, FIC_TELBC3, FIC_CONBC3, ';

  strSQL := strSQL + '   REFCO1.EMPRCO AS FIC_NOMEM1, REFCO1.CGCEMP AS FIC_CGCEM1, ';
  strSQL := strSQL + '   REFCO1.TELEMP AS FIC_TELEM1, REFCO1.CONEMP AS FIC_CONEM1, ';
  strSQL := strSQL + '   REFCO1.DTACON AS FIC_DTACO1, REFCO1.DTAPCO AS FIC_DTAPC1, ';
  strSQL := strSQL + '   REFCO1.VALPCO AS FIC_VALPC1, REFCO1.DTAMCO AS FIC_DTAMC1, ';
  strSQL := strSQL + '   REFCO1.VALMCO AS FIC_VALMC1, REFCO1.DTAUCO AS FIC_DTAUC1, ';
  strSQL := strSQL + '   REFCO1.VALUCO AS FIC_VALUC1, ';

  strSQL := strSQL + '   REFCO2.EMPRCO AS FIC_NOMEM2, REFCO2.CGCEMP AS FIC_CGCEM2, ';
  strSQL := strSQL + '   REFCO2.TELEMP AS FIC_TELEM2, REFCO2.CONEMP AS FIC_CONEM2, ';
  strSQL := strSQL + '   REFCO2.DTACON AS FIC_DTACO2, REFCO2.DTAPCO AS FIC_DTAPC2, ';
  strSQL := strSQL + '   REFCO2.VALPCO AS FIC_VALPC2, REFCO2.DTAMCO AS FIC_DTAMC2, ';
  strSQL := strSQL + '   REFCO2.VALMCO AS FIC_VALMC2, REFCO2.DTAUCO AS FIC_DTAUC2, ';
  strSQL := strSQL + '   REFCO2.VALUCO AS FIC_VALUC2, ';

  strSQL := strSQL + '   REFCO3.EMPRCO AS FIC_NOMEM3, REFCO3.CGCEMP AS FIC_CGCEM3, ';
  strSQL := strSQL + '   REFCO3.TELEMP AS FIC_TELEM3, REFCO3.CONEMP AS FIC_CONEM3, ';
  strSQL := strSQL + '   REFCO3.DTACON AS FIC_DTACO3, REFCO3.DTAPCO AS FIC_DTAPC3, ';
  strSQL := strSQL + '   REFCO3.VALPCO AS FIC_VALPC3, REFCO3.DTAMCO AS FIC_DTAMC3, ';
  strSQL := strSQL + '   REFCO3.VALMCO AS FIC_VALMC3, REFCO3.DTAUCO AS FIC_DTAUC3, ';
  strSQL := strSQL + '   REFCO3.VALUCO AS FIC_VALUC3, ';

  strSQL := strSQL + '   CLI_CGCCPF, IC.CLI_ESTCIV AS CLI_ESTCIV, ';
  strSQL := strSQL + '   IC.CLI_ESCOLA AS CLI_ESCOLA, ';
  strSQL := strSQL + '   IC.CLI_SEXO__ AS CLI_SEXO__, ';

  strSQL := strSQL + '   IC.CLI_NACION, IC.CLI_NATURA, IC.CLI_AVALIS, IC.CLI_OUTROS, IC.CLI_RESIDE, ';
  strSQL := strSQL + '   IC.CLI_MOTOUT, IC.CLI_PROFIS, IC.CLI_C_PROF, IC.CLI_TRABAL, IC.CLI_ENDSER, ';
  strSQL := strSQL + '   IC.CLI_TELSER, IC.CLI_TEMSER, IC.CLI_SALARI, IC.CLI_OUTREN, IC.CLI_VRALUG, ';
  strSQL := strSQL + '   IC.CLI_ENDIM1, IC.CLI_ENDIM2, (IC.CLI_SALARI + IC.CLI_OUTREN) AS CLI_TOTREN, ';
  strSQL := strSQL + '   IC.CLI_VALIM1, IC.CLI_VALIM2, IC.CLI_VEICUL, IC.CLI_VALVEI, IC.CLI_OBS_FC, ';
  strSQL := strSQL + '   CIDCLI.CID_NOMCID AS CIDCLI, CIDCLI.CID_ESTADO AS ESTCLI, ';
  strSQL := strSQL + '   CIDCOB.CID_NOMCID AS CIDCOB, CIDCOB.CID_ESTADO AS ESTCOB, ';
  strSQL := strSQL + '   CIDENT.CID_NOMCID AS CIDENT, CIDENT.CID_ESTADO AS ESTENT, ';
  strSQL := strSQL + '   CADVEN.OPE_NOMOPE AS NOMVEN, CADREP.OPE_NOMOPE AS NOMREP, ';
  strSQL := strSQL + '   ATI_DESATI, FPG_DESCRI, POR_NOMPOR, CLI_EMCOB1, CLI_EMCOB2, CLI_DTCOCB, CLI_CAPSOC ';
  strSQL := strSQL + ' FROM CADCLI ';
  strSQL := strSQL + ' INNER JOIN CADOPE AS CADVEN ON CADCLI.CLI_CODVEN = CADVEN.OPE_CODOPE ';
  strSQL := strSQL + ' INNER JOIN CADCID AS CIDCLI ON CADCLI.CLI_CODCID = CIDCLI.CID_CODCID ';
  strSQL := strSQL + ' INNER JOIN CADATI           ON CADCLI.CLI_CODATI = CADATI.ATI_CODATI ';
  strSQL := strSQL + ' LEFT JOIN CLICND            ON CADCLI.CLI_CODCLI = CLICND.CND_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CADFIC            ON CADCLI.CLI_CODCLI = FIC_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CLI_INFCRE IC     ON CADCLI.CLI_CODCLI = IC.CLI_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CADCID AS CIDCOB  ON CADCLI.CLI_CIDCOB = CIDCOB.CID_CODCID ';
  strSQL := strSQL + ' LEFT JOIN CADFPG            ON CADCLI.CLI_CODFPG = CADFPG.FPG_CODIGO ';
  strSQL := strSQL + ' LEFT JOIN CADPOR            ON CADCLI.CLI_CODPOR = CADPOR.POR_CODPOR ';
  strSQL := strSQL + ' LEFT JOIN CADOPE AS CADREP  ON CADCLI.CLI_CODREP = CADREP.OPE_CODOPE ';
  strSQL := strSQL + ' LEFT JOIN ENTCLI            ON CADCLI.CLI_CODCLI = ETC_CODCLI ';
  strSQL := strSQL + ' LEFT JOIN CADCID AS CIDENT  ON ENTCLI.ETC_CIDENT = CIDENT.CID_CODCID ';
  strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
  strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
  strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
  strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
  strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
  strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
  strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
  strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
  strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
  strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
  strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
  strSQL := strSQL + '            FROM CLIRCO                                           ';
  strSQL := strSQL + '            LIMIT 0,1) AS REFCO1 ON TRUE                          ';

  strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
  strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
  strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
  strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
  strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
  strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
  strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
  strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
  strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
  strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
  strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
  strSQL := strSQL + '            FROM CLIRCO                                           ';
  strSQL := strSQL + '            LIMIT 1,1) AS REFCO2 ON TRUE                          ';

  strSQL := strSQL + ' LEFT JOIN (SELECT CLI_EMPRCO AS EMPRCO,                          ';
  strSQL := strSQL + '                   CLI_CGCEMP AS CGCEMP,                          ';
  strSQL := strSQL + '                   CLI_TELEMP AS TELEMP,                          ';
  strSQL := strSQL + '                   CLI_CONEMP AS CONEMP,                          ';
  strSQL := strSQL + '                   CLI_DTACON AS DTACON,                          ';
  strSQL := strSQL + '                   CLI_DTAPCO AS DTAPCO,                          ';
  strSQL := strSQL + '                   CLI_VALPCO AS VALPCO,                          ';
  strSQL := strSQL + '                   CLI_DTAMCO AS DTAMCO,                          ';
  strSQL := strSQL + '                   CLI_VALMCO AS VALMCO,                          ';
  strSQL := strSQL + '                   CLI_DTAUCO AS DTAUCO,                          ';
  strSQL := strSQL + '                   CLI_VALUCO AS VALUCO                           ';
  strSQL := strSQL + '            FROM CLIRCO                                           ';
  strSQL := strSQL + '            LIMIT 2,1) AS REFCO3 ON TRUE                          ';

  strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = CADCLI.CLI_CODEMP               ';
  strSQL := strSQL + ' WHERE FALSE ';

  Try
    qryGenerica.SQL.Text := strSQL;
    qryGenerica.Open;

    For intCnt := 0 To qryGenerica.FieldDefs.Count - 1 Do
      Result.FieldDefs.Add(qryGenerica.Fields[intCnt].FullName, qryGenerica.Fields[intCnt].DataType, qryGenerica.Fields[intCnt].Size);
  Finally
    FreeAndNil(qryGenerica);
  End;

  Result.CreateDataSet;
end;

function fCriaClientDatasetfrxGen: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.Name := 'frxGen';

  Result.FieldDefs.Add('EMP_NOMEMP', ftString, 200);
  Result.FieldDefs.Add('REL_NOMREL', ftString, 100);

  Result.CreateDataSet;
end;

function fCriaClientDataSetfrxResumoFinanceiro: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.Name := 'frxResumoFinanceiro';

  Result.FieldDefs.Add('TOT_DUP_ABE_QTD', ftInteger);
  Result.FieldDefs.Add('TOT_DUP_ABE_VAL', ftFloat);
  Result.FieldDefs.Add('TOT_DUP_LIQ_QTD', ftInteger);
  Result.FieldDefs.Add('TOT_DUP_LIQ_VAL', ftFloat);
  Result.FieldDefs.Add('TOT_DUP_ATR_QTD', ftInteger);
  Result.FieldDefs.Add('TOT_DUP_ATR_VAL', ftFloat);
  Result.FieldDefs.Add('TOT_DUP_LTR_QTD', ftInteger);
  Result.FieldDefs.Add('TOT_DUP_LTR_VAL', ftFloat);
  Result.FieldDefs.Add('LIM_CRE_DISPONI', ftFloat);
  Result.FieldDefs.Add('DIAS_SEM_VENDA_', ftInteger);
  Result.FieldDefs.Add('ULT_COMPRA_DATA', ftDateTime);
  Result.FieldDefs.Add('ULT_COMPRA_NOTA', ftString, 100);
  Result.FieldDefs.Add('ULT_COMPRA_VAL_', ftFloat);
  Result.FieldDefs.Add('MAI_COMPRA_DATA', ftDateTime);
  Result.FieldDefs.Add('MAI_COMPRA_NOTA', ftString, 100);
  Result.FieldDefs.Add('MAI_COMPRA_VAL_', ftFloat);
  Result.FieldDefs.Add('ATRASADOS_MEDIA', ftFloat);
  Result.FieldDefs.Add('ATRASADOS_MAIOR', ftFloat);
  Result.FieldDefs.Add('ATRASADOS_ATUAL', ftFloat);

  Result.CreateDataSet;
end;

function fCriaClientDataSetfrxRelatorioContatos: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.Name := 'frxRelatorioContatos';

  Result.FieldDefs.Add('CLI_NOMCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_NASCTT', ftDate);
  Result.FieldDefs.Add('CLI_ENDCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_BAICTT', ftString, 100);
  Result.FieldDefs.Add('CLI_EMACTT', ftString, 100);
  Result.FieldDefs.Add('CLI_DEPCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_TELCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_CELCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_FAXCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_OBSERV', ftString, 100);
  Result.FieldDefs.Add('CID_NOMCID', ftString, 100);
  Result.FieldDefs.Add('CID_ESTADO', ftString, 100);

  Result.CreateDataSet;
end;

function fCriaClientDataSetfrxRelatorioAutorizacaoCompra: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.Name := 'frxRelatorioAutorizacaoCompra';

  Result.FieldDefs.Add('CLI_NOMCTT', ftString, 100);
  Result.FieldDefs.Add('CLI_NUMR_G', ftString, 20);
  Result.FieldDefs.Add('CLI_NUMCPF', ftString, 20);
  Result.FieldDefs.Add('CLI_ASSCTT', ftString, 100);

  Result.CreateDataSet;
end;

function fCriaClientDataSetfrxSocios: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.Name := 'frxSocios';

  Result.FieldDefs.Add('SCO_NOMSCO', ftString, 100);
  Result.FieldDefs.Add('SCO_CPFCNP', ftString, 20);
  Result.FieldDefs.Add('SCO_DTANAS', ftDate);
  Result.FieldDefs.Add('SCO_PER_PS', ftString, 10);
  Result.FieldDefs.Add('SCO_ESTCIV', ftString, 20);

  Result.CreateDataSet;
end;

end.
