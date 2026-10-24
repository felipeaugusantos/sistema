unit untRelCtrMercantil;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,untZClient,untFuncoesBoleto;

Type
  TRelCtrMercantil = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadRec: TUniClientDataSet;
      FCadRecDups: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FItensMercantil: TUniClientDataSet;
      FListaFuncoes: TStringList;
      FDataSetCadRec: TfrxDBDataset;
      FDataSetEmpMercantil: TfrxDBDataset;
      FDataSetItensMercantil: TfrxDBDataset;
      FDataSetCadRecAgrup: TfrxDBDataset;
      FDataSetCadRecDups: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      qryDupAgrupadas: TZClient;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function fFormataCpfCgcInterna(strValor: String): String;
      function fGetTotalRecebido(intSeqCon: Integer): Double;
      function fRetornaReceberAbertoInterna(strCodCli: String): String;
      function fGetDescricao(strSeqCon: String): String;
      function fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp, AParcel: String): String;
      procedure pIniciaObjetos;
      function fRetNomOpe(strCodOpe: String): String;
      function fCarregaDupAgrupadasNaoImpressas(strNumDup,
                                                strEspecie,
                                                strCodEmp: String;
                                                intJaImpressas: Integer;
                                                strCodCli: String = ''): Boolean;
    function fCarregaInfoLayoutMercantil(strNumDup,
                                           strCodEmp,
                                           strEspdoc,
                                           strCodCli,
                                           strPrccid,
                                           strPrcest,
                                           strNomCid,
                                           strEstado,
                                           strParcel: String;
                                           intPerDpo: Double = 0 ): Boolean ;
      Function fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
      Function fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
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
      constructor CreateInstance(cdsMercantil: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;

  function fCriaClientDatasetMercantilCTR: TUniClientDataSet;
  function fCriaClientDatasetMercantilAgrupCTR: TZClient;
  function CriaClientDataSetItensMercantil: TUniClientDataSet;

Const
  FILA_IMPRESSAO_MERCANTIL_CTR = 'frmDigBoleto';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCtrMercantil }

constructor TRelCtrMercantil.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadRec := fCriaClientDatasetMercantilCTR;
  FCadRecDups := fCriaClientDatasetMercantilCTR;
  qryDupAgrupadas := fCriaClientDatasetMercantilAgrupCTR;
  FItensMercantil := CriaClientDataSetItensMercantil;

  With FCadRec Do
  Begin
    Append;
    FieldByName('C_G_C_').AsString   := '12345678912345678912';
    FieldByName('EMP_NOMEMP').AsString   := 'Citel Software';
    FieldByName('EMP_ENDERE').AsString   := 'Av. Antonio Lerco';
    FieldByName('EMP_ENDNUM').AsString   := '314';
    FieldByName('EMP_C_E_P_').AsString   := '14270000';
    FieldByName('EMP_BAIRRO').AsString   := 'Jardim Planalto';
    FieldByName('EMP_C_G_C_').AsString   := '123456789123456';
    FieldByName('EMP_I_E_S_').AsString   := '987654319876543';
    FieldByName('EMP_FONE01').AsString   := '39545692';
    FieldByName('CTR_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('EMP_EMAIL_').AsString   := 'CitelTeste@gmail.com';
    FieldByName('EMAIL_').AsString   := 'ClienteTeste@gmail.com';
    FieldByName('CTR_PARCEL').AsString   := 'NF';
    FieldByName('CID_NOMCID').AsString   := 'Ribeirão Preto';
    FieldByName('I_E_S_').AsString   := '6549873216547891';
    FieldByName('TEXTOR').AsString   := 'Reconheço(emos) a exatidão desta DUPLICATA DE VENDA MERCANTIL, na importância acima,que pagarei(emos) à ", EMP_NOMEMP, " ou a sua ordem na praça e vencimentos acima indicados.';
    FieldByName('NRODUP').AsString   := '100620198989';
    FieldByName('CTR_VALDUP').AsFloat    := 189;
    FieldByName('CTR_JURSUJ').AsFloat := 11;
    FieldByName('CTR_NUMDUP').AsString   := 'Preview';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CODCLI').AsString   := '00059920';
    FieldByName('NOMCLI').AsString   := 'Matheus Alacrino Teste';
    FieldByName('ENDERE').AsString   := 'Rua dos Anjos';
    FieldByName('BAIRRO').AsString   := 'Nosso ceú';
    FieldByName('CIDADE').AsString   := 'Santa Rosa de Viterbo';
    FieldByName('C_E_P_').AsString   := '14270000';
    FieldByName('ESTADO').AsString   := 'SP';
    FieldByName('CID_ESTADO').AsString   := 'SP';
    FieldByName('CTR_ESPDOC').AsString   := 'AG';
    FieldByName('CTR_CODEMP').AsString   := '123';
    FieldByName('CTR_CODCLI').AsString   := '123456789*';
    FieldByName('PRCCID').AsString   := 'Cidade e estado';
    FieldByName('PRCEST').AsString   := 'Cidade e estado';
    FieldByName('CTR_PERDPO').AsFloat    := 1;
    FieldByName('CTR_NOSNUM').AsString   := '123456789012';

    Post;
  End;

  With FCadRecDups Do
  Begin
    Append;
    FieldByName('NRODUP').AsString   := '100620198989';
    FieldByName('CTR_VALDUP').AsFloat    := 179;
    FieldByName('CTR_NUMDUP').AsString   := '100620198985A';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    Post;

    Append;
    FieldByName('NRODUP').AsString   := '100620198990';
    FieldByName('CTR_VALDUP').AsFloat    := 10;
    FieldByName('CTR_NUMDUP').AsString   := '100620198985B';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/02/2000');
    Post;
  End;

  With qryDupAgrupadas Do
  Begin
    Append;
    FieldByName('CTR_NUMDUP').AsString   := 'Preview';
    FieldByName('CTR_ESPDOC').AsString   := 'AG';
    FieldByName('CTR_PARCEL').AsString   := 'A';
    FieldByName('CTR_CODEMP').AsString   := '001';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_VALCOR').AsFloat    := 100;
    FieldByName('CTR_VALDUP').AsFloat    := 200;
    FieldByName('CTR_VALORI').AsFloat    := 300;
    Post;
  End;


  FItensMercantil.Append;
  FItensMercantil.FieldByName('QUANTIDADE_VIAS').asInteger := 1;
  FItensMercantil.FieldByName('DATA_CADASTRO').AsDateTime := Date;
  FItensMercantil.FieldByName('DATA_VENCIMENTO').AsDateTime := (Date + 1);
  FItensMercantil.FieldByName('QTDITENSPEDIDO').AsString := '0';
  FItensMercantil.FieldByName('ENDERECO_CLIENTE').AsString := 'ENDEREÇO CLIENTE' ;
  FItensMercantil.FieldByName('CODCLIENTE').AsString := '00059920';
  FItensMercantil.FieldByName('NOMECLIENTE').AsString := 'NOME CLIENTE';
  FItensMercantil.FieldByName('FORMAPAGAMENTO').AsString        := 'BOLETO'  ;
  FItensMercantil.FieldByName('SERIE').AsString        := '1'            ;
  FItensMercantil.FieldByName('NUMPEDIDO').AsString    := '000000000001' ;
  FItensMercantil.FieldByName('CODVENDEDOR').AsString  := '998'          ;
  FItensMercantil.FieldByName('NOMVENDEDOR').AsString  := 'PROGRAMAÇÃO'  ;
  FItensMercantil.FieldByName('NUMDOCUMENTO').AsString  :='000000059920' ;
  FItensMercantil.FieldByName('CODITEM').AsString       := '123456';
  FItensMercantil.FieldByName('DESCRICAOITEM').AsString := 'VERDE ESMERALD POLIESTER LAZZURIL 0,9L AZUL MARINHO BALDE 5/9 COM TAMPA 4,85MM';
  FItensMercantil.FieldByName('UNIDADE').AsString       := 'QT';
  FItensMercantil.FieldByName('QTDEITEM').AsFloat       := 4;
  FItensMercantil.FieldByName('UNITARIOITEM').AsFloat   := 71.83;
  FItensMercantil.FieldByName('UNIORIITEM').AsFloat     := 71.83;
  FItensMercantil.FieldByName('TOTALITEM').AsFloat      := 287.32;
  FItensMercantil.FieldByName('TOTALDESESP').AsFloat    := 43.08;
  FItensMercantil.FieldByName('DESCONTOITEM').AsFloat   := 43.08;
  FItensMercantil.FieldByName('TOTALFRETE').AsFloat     := 13.54;
  FItensMercantil.FieldByName('TOTALBRUTO').AsFloat     := 287.32;
  FItensMercantil.FieldByName('TOTALDESCONTO').AsFloat  := 43.08;
  FItensMercantil.Post;

  pIniciaObjetos;
end;

constructor TRelCtrMercantil.CreateInstance(cdsMercantil: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadRec      := TUniClientDataSet.Create(Nil);
  FCadRec.Data := cdsMercantil.Data;

  FCadRecDups      := TUniClientDataSet.Create(Nil);
  FCadRecDups.Data := cdsMercantil.Data;

  qryDupAgrupadas := TZClient.Create(nil);

  pIniciaObjetos;
end;

procedure TRelCtrMercantil.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadRec := TfrxDBDataset.Create(nil);
  FDataSetCadRec.Name := 'frxRelatorio';
  FDataSetCadRec.DataSet := FCadRec;

  FDataSetCadRecAgrup := TfrxDBDataset.Create(nil);
  FDataSetCadRecAgrup.Name := 'frxDupAgrupadas';
  FDataSetCadRecAgrup.DataSet := qryDupAgrupadas;

  FDataSetItensMercantil := TfrxDBDataset.Create(nil);
  FDataSetItensMercantil.Name := 'frxItensMercantil';
  FDataSetItensMercantil.DataSet := FItensMercantil;

  FDataSetCadRecDups := TfrxDBDataset.Create(nil);
  FDataSetCadRecDups.Name := 'frxRelatorioDups';
  FDataSetCadRecDups.DataSet := FCadRecDups;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmpMercantil := TfrxDBDataset.Create(nil);
  FDataSetEmpMercantil.Name := 'frxEmpresaMercantil';
  FDataSetEmpMercantil.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 5);
  FArrDBDataSet[0] := FDataSetCadRec;
  FArrDBDataSet[1] := FDataSetCadRecAgrup;
  FArrDBDataSet[2] := FDataSetItensMercantil;
  FArrDBDataSet[3] := FDataSetEmpMercantil;
  FArrDBDataSet[4] := FDataSetCadRecDups;

  pDefineFilaImpressao(False);
end;

destructor TRelCtrMercantil.Destroy;
begin
  FreeAndNil(FCadRec);
  FreeAndNil(FItensMercantil);
  FreeAndNil(qryDupAgrupadas);
  FreeAndNil(FCadRecDups);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmpMercantil);
  FreeAndNil(FDataSetCadRec);
  FreeAndNil(FDataSetItensMercantil);
  FreeAndNil(FDataSetCadRecAgrup);
  FreeAndNil(FDataSetCadRecDups);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtrMercantil.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcInterna(strValor: String): String;');
  FListaFuncoes.Add('function fFormataCEP(strCEP: String): String;');
  FListaFuncoes.Add('function fFormataFone(strFone: String): String;');
  FListaFuncoes.Add('function fRetExtensoNumero(Value : String):String;');
  FListaFuncoes.Add('function fGetTotalRecebido(intSeqCon: Integer): Double');
  FListaFuncoes.Add('function fGetDescricao(strSeqCon: String): String;');
  FListaFuncoes.Add('function fRetNomOpe(strCodOpe: String): String;');
  FListaFuncoes.Add('function fRetornaReceberAbertoInterna(strCodCli: String): String;');
  FListaFuncoes.Add('function fCarregaDupAgrupadasNaoImpressas(strNumDup, strEspecie, strCodEmp: String; intJaImpressas: Integer; strCodCli: String = ''): Boolean');
  FListaFuncoes.Add('function fCarregaInfoLayoutMercantil(strNumDup,strCodEmp,strEspdoc,strCodCli,strPrccid,strPrcest,strNomCid,strEstado,strParcel: String; intPerDpo: Float = 0): Boolean ;');
  FListaFuncoes.Add('function fRetNumParcela(strNumDoc: String): String;');
  FListaFuncoes.Add('function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;');
  FListaFuncoes.Add('function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;');

  FListaFuncoes.Add('function fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;');
  FListaFuncoes.Add('function fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;');
  FListaFuncoes.Add('function fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp, AParcel: String): String;');
end;

procedure TRelCtrMercantil.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtrMercantil.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_MERCANTIL_CTR);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_MERCANTIL_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCtrMercantil.fOnUserFunctionEvent(
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

  If SameText(MethodName, 'fGetTotalRecebido') Then
    Result := fGetTotalRecebido(Params[0]);

  If SameText(MethodName, 'fGetDescricao') Then
    Result := fGetDescricao(Params[0]);

  If SameText(MethodName, 'fRetNomOpe') Then
    Result := fRetNomOpe(Params[0]);

  If SameText(MethodName, 'fRetornaReceberAbertoInterna') Then
    Result := fRetornaReceberAbertoInterna(Params[0]);

  If SameText(MethodName, 'fCarregaDupAgrupadasNaoImpressas') Then
    Result := fCarregaDupAgrupadasNaoImpressas(Params[0], Params[1], Params[2], Params[3], Params[4]);

  If SameText(MethodName, 'fCarregaInfoLayoutMercantil') Then
    Result := fCarregaInfoLayoutMercantil(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5],Params[6],Params[7],Params[8],Params[9]) ;

  If SameText(MethodName, 'fRetNumParcela') Then
    Result := fRetNumParcela(Params[0]);

  If SameText(MethodName, 'fQtdParcelas') Then
    Result := fQtdParcelas(Params[0], Params[1], Params[2], Params[3]);

  If SameText(MethodName, 'fCfgSis') Then
    Result := fCfgSis(Params[0], Params[1], Params[2]);

  If SameText(MethodName, 'fCarregaItensMercantilImp') Then
    Result := fCarregaItensMercantilImp(Params[0], Params[1], Params[2], Params[3]);

  If SameText(MethodName, 'fCarregaParcelasReferentesADocumento') Then
    Result := fCarregaParcelasReferentesADocumento(Params[0],Params[1],Params[2],Params[3]);

  If SameText(MethodName, 'fGetMensagensMOVGER') Then
    Result := fGetMensagensMOVGER(Params[0],Params[1],Params[2],Params[3],Params[4]);
end;

function TRelCtrMercantil.fCarregaDupAgrupadasNaoImpressas(strNumDup,
                                                          strEspecie,
                                                          strCodEmp: String;
                                                          intJaImpressas: Integer;
                                                          strCodCli: String): Boolean;

begin
 Result := True;
end;


function TRelCtrMercantil.fCarregaInfoLayoutMercantil(strNumDup, strCodEmp,
  strEspdoc, strCodCli, strPrccid, strPrcest, strNomCid, strEstado,
  strParcel: String; intPerDpo: Double): Boolean;
begin
  Result:= True;
end;

function TRelCtrMercantil.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TRelCtrMercantil.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelCtrMercantil.fGetDescricao(strSeqCon: String): String;
  Var
    qryRcxDes: TUniQuery;
    strSQL   : String;

begin
  qryRcxDes := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
  strSQL := strSQL + '   RCX_DESCRI           ';
  strSQL := strSQL + ' FROM                   ';
  strSQL := strSQL + '   CADRCXX              ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   RCX_SEQCON = :SEQCON ';

  With qryRcxDes Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('SEQCON').AsString := strSeqCon;
    Open;
  End;

  Result := IIF(strSeqCon <> '0', 'a ' + qryRcxDes.FieldByName('RCX_DESCRI').AsString + ', conforme os', 'aos');

  FreeAndNil(qryRcxDes);
end;

function TRelCtrMercantil.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtrMercantil.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCtrMercantil.fGetIsEmpty: Boolean;
begin
  Result := FCadRec.IsEmpty;
end;

function TRelCtrMercantil.fGetKey: String;
begin
  Result := 'MERCTR';
end;

function TRelCtrMercantil.fGetMensagensMOVGER(ANumDoc, AEspDoc, ACodCli, ACodEmp, AParcel: String): String;
var
  LMensagens: TUniQuery;
  LSQL : String;
  LMsgRetorno : String;
begin
  Try
    LMsgRetorno := '';
    Result := LMsgRetorno;
    LSQL := '';
    LSQL := LSQL + ' SELECT                                 ';
    LSQL := LSQL + '   MG.GER_MEN001, MG.GER_MEN002         ';
    LSQL := LSQL + ' FROM                                   ';
    LSQL := LSQL + '   CADREC AS CR                         ';
    LSQL := LSQL + '   JOIN MOVGER AS MG                    ';
    LSQL := LSQL + '     ON CR.CTR_NUMDUP = MG.GER_NUMDOC   ';
    LSQL := LSQL + '     AND CR.CTR_ESPDOC = MG.GER_ESPDOC  ';
    LSQL := LSQL + '     AND CR.CTR_CODEMP = MG.GER_CODEMP  ';
    LSQL := LSQL + ' WHERE CR.CTR_CODCLI = :CODCLI          ';
    LSQL := LSQL + '   AND CR.CTR_ESPDOC = :ESPDOC          ';
    LSQL := LSQL + '   AND CR.CTR_NUMDUP = :NUMDOC          ';
    LSQL := LSQL + '   AND CR.CTR_PARCEL = :PARCEL          ';

    try
      LMensagens := fCriaQuery(Nil);
      With LMensagens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(LSQL);
        ParamByName('CODCLI').AsString := ACodCli;
        ParamByName('ESPDOC').AsString := AEspDoc;
        ParamByName('NUMDOC').AsString := ANumDoc;
        ParamByName('PARCEL').AsString := AParcel;
        Open;
      End;

      if LMensagens.FieldByName('GER_MEN001').AsString <> '' then
        LMsgRetorno := LMensagens.FieldByName('GER_MEN001').AsString;

      if LMensagens.FieldByName('GER_MEN002').AsString <> '' then
      begin
        if LMsgRetorno <> '' then
          LMsgRetorno := LMsgRetorno + ' | ';
        LMsgRetorno := LMsgRetorno + LMensagens.FieldByName('GER_MEN002').AsString;
      end;

    finally
      Result :=  LMsgRetorno;
      FreeAndNil(LMensagens);
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelCtrMercantil.fGetMensagensMOVGER]');
    End;
  End;
end;

function TRelCtrMercantil.fGetName: String;
begin
  Result := 'IMPRESSÃO DE DUPLICATA MERCANTIL';
end;

function TRelCtrMercantil.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtrMercantil.fGetTotalRecebido(intSeqCon: Integer): Double;
begin
  Result := IfNull(FDicTot[IntToStr(intSeqCon)], 0);
end;

function TRelCtrMercantil.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtrMercantil.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtrMercantil.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelCtrMercantil.fPrepareDataSetsAndVariables: Boolean;
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
    FDicVar.AddOrSetValue('PRACAPAGAMENTO',  fCfgSis('PRAPAG', varString, VS_strCodEmp));
    FDicVar.AddOrSetValue('PONTUALIDADE', fCfgSis('DESPON', varString, VS_strCodEmp));
    FDicVar.AddOrSetValue('MORA', '1,00');
    FDicVar.AddOrSetValue('DUPLIC', '160320210000-A');
    FDicVar.AddOrSetValue('TEMITENS', 'S');
    FDicVar.AddOrSetValue('QVIAS', '1');
  end;


begin

  FDicTot.Limpar;
  fltTotalRecebido := 0;

  With FCadRec Do
  Begin
    First;
    While Not Eof Do
    Begin

      Next;

    End;
    First;
    Result := Not IsEmpty;
  End;

  pCarregaVariaveis;
  fCadEmp('NOMEMP', FCadEmp_);
  pCarregaListaFuncoes;

end;

function TRelCtrMercantil.fRetNomOpe(strCodOpe: String): String;
begin
  Result := fRetNomVendRep(strCodOpe);
end;

function TRelCtrMercantil.fRetornaReceberAbertoInterna(strCodCli: String): String;
begin
  Result := FormatFloat('R$ ###,###,##0.00', fRetornaReceberAberto(strCodCli));
end;

function fCriaClientDatasetMercantilCTR: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PERDPO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PRCCID';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PRCEST';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PARCEL';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODCLI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_NOMEMP';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_ENDERE';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_ENDNUM';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_C_E_P_';
    DataType := ftString;
    Size     := 9;
  end;

    With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_BAIRRO';
    DataType := ftString;
    Size     := 25;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_C_G_C_';
    DataType := ftString;
    Size     := 18;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_I_E_S_';
    DataType := ftString;
    Size     := 18;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_FONE01';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_EMAIL_';
    DataType := ftString;
    Size     := 50;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMAIL_';
    DataType := ftString;
    Size     := 50;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CID_NOMCID';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'I_E_S_';
    DataType := ftString;
    Size     := 18;
  end;


  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'TEXTOR';
    DataType := ftString;
    Size     := 200;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NRODUP';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALDUP';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_JURSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMDUP';
    DataType := ftString;
    Size     := 13;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODCLI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMCLI';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ENDERE';
    DataType := ftString;
    Size     := 150;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'BAIRRO';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CIDADE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'C_E_P_';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ESTADO';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CID_ESTADO';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'C_G_C_';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NOSNUM';
    DataType := ftString;
    Size     := 12;
  end;

  Result.CreateDataSet;

end;

function fCriaClientDatasetMercantilAgrupCTR: TZClient;
begin
  Result := TZClient.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PARCEL';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALCOR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMDUP';
    DataType := ftString;
    Size     := 13;
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
    Name     := 'CTR_VALDUP';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;

end;


function CriaClientDataSetItensMercantil: TUniClientDataSet;
var
  i1: integer;
  SqlItens: String;
  qryGenerica : TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);
  SqlItens := '';

  SqlItens := ' SELECT                                                                       '+
              '    1  AS QUANTIDADE_VIAS,                                                    '+
              '    CTR_DTACAD AS DATA_CADASTRO,                                              '+
              '    CTR_DTAVEN AS DATA_VENCIMENTO,                                            '+
              '    CTR_NOSNUM,                                                               '+
              '    COUNT(DET_CODITE) AS QTDITENSPEDIDO,                                      '+
              '    UPPER(CONCAT(IFNULL(CLI_ENDERE,""), ", ", IFNULL(CLI_ENDNUM,""), ", ",    '+
              '           IFNULL(CLI_BAIRRO,""), " - " , IFNULL(CID_NOMCID,""), "/",         '+
              '           IFNULL(CID_ESTADO,""))) AS ENDERECO_CLIENTE,                       '+
              '    CLI_CODCLI AS CODCLIENTE,                                                 '+
              '    CLI_NOMCLI AS NOMECLIENTE,                                                '+
              '    IFNULL(FPG_DESCRI,"OUTRAS") AS FORMAPAGAMENTO,                            '+
              '    IFNULL(DET_SERIE_,CTR_PARCEL) AS SERIE,                                   '+
              '    IFNULL(IFNULL(DET_NUM_PD,DET_NUMDOC),CTR_NUMDUP) AS NUMPEDIDO,            '+
              '    IFNULL(DET_CODVEN,CTR_CODVEN) AS CODVENDEDOR,                             '+
              '    OPE_NOMOPE AS NOMVENDEDOR,                                                '+
              '    IFNULL(DET_NUMDOC,CTR_NUMDUP) AS NUMDOCUMENTO,                            '+
              '    DET_CODITE AS CODITEM,                                                    '+
              '    DET_DESCRI AS DESCRICAOITEM,                                              '+
              '    UNI_DESUNI AS UNIDADE,                                                    '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) AS QTDEITEM,           '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNITAR,DET_UNITAR) AS UNITARIOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI) AS UNIORIITEM,         '+
              '    IFNULL(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                '+
              '    (CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB)) AS TOTALITEM,        '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESESP,DET_DESESP) AS TOTALDESESP,        '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESCON,DET_DESCON) AS DESCONTOITEM,       '+
              '    IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTFRE,DET_TOTFRE) AS TOTALFRETE,         '+
              '    IFNULL(IF(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) >            '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)),                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE),                    '+
              '      (IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                   '+
              '       IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI))                    '+
              '    ),CTR_VALDUP) AS TOTALBRUTO,                                              '+
              '    IFNULL(IF(((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *          '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                '+
              '         IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                 '+
              '    < 0,0.0,                                                                  '+
              '   ((IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE,DET_QTDITE) *                     '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI,DET_UNIORI)) -                    '+
              '     IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE,DET_TOTITE) )                     '+
              '   ),IF((CTR_VALDUP - CTR_DESSUJ + CTR_JURSUJ + CTR_DESCOB < CTR_VALDUP),     '+
              '     CTR_DESSUJ,0.0)) AS TOTALDESCONTO                                        '+
              ' FROM                                                                         '+
              '   CADREC                                                                     '+
              ' LEFT JOIN MOVDET                                                             '+
              '   ON CTR_NUMDUP = DET_NUMDOC                                                 '+
              '   AND CTR_ESPDOC = DET_ESPDOC                                                '+
              '   AND CTR_CODCLI = DET_CODCLI                                                '+
              '   AND CTR_CODEMP = DET_CODEMP                                                '+
              'LEFT JOIN CADFPG ON FPG_CODIGO = DET_CODFPG                                   '+
              'LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD                                   '+
              'LEFT JOIN CADOPE ON OPE_CODOPE = IFNULL(DET_CODVEN,CTR_CODVEN)                '+
              'LEFT JOIN CADCLI ON CLI_CODCLI = IFNULL(DET_CODCLI,CTR_CODCLI)                '+
              'LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID                                   '+
              'WHERE  FALSE                                                                  '+
              ' GROUP BY MOVDET.AUTOINCREM                                                   ';

  qryGenerica := fCriaQuery;
  try
    qryGenerica.SQL.Text := SqlItens;
    qryGenerica.Open;
    for i1 := 0 to qryGenerica.FieldDefs.Count - 1 do
    begin
      Result.FieldDefs.Add(qryGenerica.Fields[i1].FullName,qryGenerica.Fields[i1].DataType,qryGenerica.Fields[i1].Size);
    end;
  finally
    FreeAndNil(qryGenerica);
  end;

  Result.CreateDataSet;
end;

function TRelCtrMercantil.fCarregaItensMercantilImp(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
begin
 Result := True;
end;

function TRelCtrMercantil.fCarregaParcelasReferentesADocumento(ANumDoc,AEspDoc,ACodCli,ACodEmp:String) : Boolean;
begin
 Result := True;
end;

end.
