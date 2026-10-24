{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{***********************************************JU*}

unit untReciboCtrMeiaFolha;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint, untReciboCtr;

Type
  TReciboCtrMeiaFolha = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadRec: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadRec: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function fFormataCpfCgcInterna(strValor: String): String;
      function fGetTotalRecebido(intSeqCon: Integer): Double;
      function fRetornaReceberAbertoInterna(strCodCli: String): String;
      function fGetDescricao(strSeqCon: String): String;
      procedure pIniciaObjetos;
      function fRetNomOpe(strCodOpe: String): String;
    function fFormataFonePaisInterna(strValor: String): String;
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
      constructor CreateInstance(cdsRecibo: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;

  function fCriaClientDatasetReciboCtrMeiaFolha: TUniClientDataSet;

  function DuplicataCreditoReferenteATroco(ADuplicata: TDataset): String;

Const
  FILA_IMPRESSAO_RECIBO_CTR = 'impressao_recibo_ctr';

implementation

uses untCfgRel, untValorPorExtenso;

{ TReciboCtrMeiaFolha }

constructor TReciboCtrMeiaFolha.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadRec := fCriaClientDatasetReciboCtrMeiaFolha;

  With FCadRec Do
  Begin
    Append;
    FieldByName('DESCRI').AsString   := 'REFENTE A RECEBIMENTO';
    FieldByName('NUMDOC').AsString   := '000000000456';
    FieldByName('ESPDOC').AsString   := 'NF';
    FieldByName('PARCEL').AsString   := 'A';
    FieldByName('CODEMP').AsString   := VS_strCodEmp;
    FieldByName('DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('VALJUR').AsFloat    := 1;
    FieldByName('VALCOB').AsFloat    := 1;
    FieldByName('VALDES').AsFloat    := 1;
    FieldByName('DESCOB').AsFloat    := 1;
    FieldByName('COBANT').AsFloat    := 1;
    FieldByName('VALDOC').AsFloat    := 256;
    FieldByName('VALREC').AsFloat    := 256;
    FieldByName('VALORI').AsFloat    := 256;
    FieldByName('VALOR2').AsFloat    := 256;
    FieldByName('CODCLI').AsString   := '000000456';
    FieldByName('NOMCLI').AsString   := 'MARIA APARECIDA';
    FieldByName('FANSOB').AsString   := 'TEM DE TUDO MARIA APARECIDA';
    FieldByName('CODCTA').AsString   := '02002002';
    FieldByName('CODVEN').AsString   := '999';
    FieldByName('DTAREC').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('HORREC').AsDateTime := fTime();
    FieldByName('DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('DESCTA').AsString   := 'PLANO DE CONTAS';
    FieldByName('ENDERE').AsString   := 'RUA TAMOIOS';
    FieldByName('ENDNUM').AsString   := '45';
    FieldByName('ENDCMP').AsString   := 'AP. 21';
    FieldByName('BAIRRO').AsString   := 'CENTRO';
    FieldByName('CIDADE').AsString   := 'RIBEIRAO PRETO';
    FieldByName('ESTADO').AsString   := 'SP';
    FieldByName('C_E_P_').AsString   := '14000000';
    FieldByName('C_G_C_').AsString   := '11111111111';
    FieldByName('FONE01').AsString   := '02139363636';
    FieldByName('CTR_CREDITO').AsFloat    := 1;
    FieldByName('CTR_ABERTO').AsFloat     := 1;
    FieldByName('HIST01').AsString   := '';
    FieldByName('HIST02').AsString   := '';
    FieldByName('RCX_DESCRI').AsString   := 'DESCRICAO DO LANCAMENTO';
    FieldByName('RCX_CAIXA').AsString    := '';
    FieldByName('RECPIX').AsString := 'N';
    FieldByName('CTR_TOTBLT').AsFloat  := 1000;
    FieldByName('CTR_TOTCRD').AsFloat  := 250;
    FieldByName('CTR_TOTCHD').AsFloat  := 120;
    FieldByName('RESCAI').AsString     := '';//MF: 290584 - 12/06/2023
    FieldByName('DESCOPEBAI').AsString := '000 - NOME DO OPERADOR';//MF: 290584 - 12/06/2023
    FieldByName('DUPLICATA_TROCO').AsString := 'N';
    FieldByName('VALOR_TROCO').AsFloat  := 0;

    Post;
  End;

  pIniciaObjetos;
end;

constructor TReciboCtrMeiaFolha.CreateInstance(cdsRecibo: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadRec      := TUniClientDataSet.Create(Nil);
  FCadRec.Data := cdsRecibo.Data;

  pIniciaObjetos;
end;

procedure TReciboCtrMeiaFolha.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadRec := TfrxDBDataset.Create(nil);
  FDataSetCadRec.Name := 'frxDataSetContasReceber';
  FDataSetCadRec.DataSet := FCadRec;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadRec;

  pDefineFilaImpressao(False);
end;

destructor TReciboCtrMeiaFolha.Destroy;
begin
  FreeAndNil(FCadRec);
  FreeAndNil(FDataSetCadRec);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TReciboCtrMeiaFolha.pCarregaListaFuncoes;
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
  FListaFuncoes.Add('function fFormataFonePaisInterna(strFone: String): String;'); //MF: 290584 - 09/06/2023
end;

procedure TReciboCtrMeiaFolha.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TReciboCtrMeiaFolha.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTR);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TReciboCtrMeiaFolha.fOnUserFunctionEvent(
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

  If SameText(MethodName, 'fFormataFonePaisInterna') Then //MF: 290584 - 09/06/2023
    Result := fFormataFonePaisInterna(Params[0]);
end;

//MF: 290584 - 12/06/2023
function TReciboCtrMeiaFolha.fFormataFonePaisInterna(strValor: String): String;
begin
  Result := fFormataFonePais(strValor, FPais);
end;

function TReciboCtrMeiaFolha.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TReciboCtrMeiaFolha.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TReciboCtrMeiaFolha.fGetDescricao(strSeqCon: String): String;
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

function TReciboCtrMeiaFolha.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TReciboCtrMeiaFolha.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TReciboCtrMeiaFolha.fGetIsEmpty: Boolean;
begin
  Result := FCadRec.IsEmpty;
end;

function TReciboCtrMeiaFolha.fGetKey: String;
begin
  Result := 'RECCRR';
end;

function TReciboCtrMeiaFolha.fGetName: String;
begin
  Result := 'RECIBO CONTAS A RECEBER - MEIA FOLHA'
end;

function TReciboCtrMeiaFolha.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TReciboCtrMeiaFolha.fGetTotalRecebido(intSeqCon: Integer): Double;
begin
  Result := IfNull(FDicTot[IntToStr(intSeqCon)], 0);
end;

function TReciboCtrMeiaFolha.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TReciboCtrMeiaFolha.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TReciboCtrMeiaFolha.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TReciboCtrMeiaFolha.fPrepareDataSetsAndVariables: Boolean;
  Var
    fltTotalRecebido,
    LValorTrocoCC,
    LValorRecebidoSemTrocoCC: Double;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
    FDicVar.AddOrSetValue('fltTotalRecebido', fltTotalRecebido);
    FDicVar.AddOrSetValue('fltValorTrocoCC', LValorTrocoCC);
    FDicVar.AddOrSetValue('fltTotalRecebidoSemTrocoCC', LValorRecebidoSemTrocoCC);
  end;

  procedure pCarregaDadosEmpresa;
  begin
    fCadEmp('NOMEMP', FCadEmp_);
  end;

begin

  FDicTot.Limpar;
  fltTotalRecebido := 0;
   LValorTrocoCC := 0;
  LValorRecebidoSemTrocoCC := 0;

  FCadRec.First;
  While Not FCadRec.Eof Do
  Begin
    fltTotalRecebido := fltTotalRecebido + FCadRec.FieldByName('VALREC').AsFloat;
    LValorRecebidoSemTrocoCC := LValorRecebidoSemTrocoCC + FCadRec.FieldByName('VALREC').AsFloat;

    If FCadRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('S') Then
    Begin
      LValorTrocoCC := LValorTrocoCC + Abs(FCadRec.FieldByName('VALREC').AsFloat);
      fltTotalRecebido := fltTotalRecebido + Abs(FCadRec.FieldByName('VALREC').AsFloat);
    End;

    FDicTot[FCadRec.FieldByName('SEQCON').AsString] := IfNull(FDicTot[FCadRec.FieldByName('SEQCON').AsString], 0) +
                                                              FCadRec.FieldByName('VALREC').AsFloat;

    FCadRec.Next;
  End;
  FCadRec.First;
 
  Result := Not FCadRec.IsEmpty;

  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;



end;

function TReciboCtrMeiaFolha.fRetNomOpe(strCodOpe: String): String;
begin
  Result := fRetNomVendRep(strCodOpe);
end;

function TReciboCtrMeiaFolha.fRetornaReceberAbertoInterna(strCodCli: String): String;
begin
  Result := FormatFloat('R$ ###,###,##0.00', fRetornaReceberAberto(strCodCli));
end;

function fCriaClientDatasetReciboCtrMeiaFolha: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCRI';
    DataType := ftString;
    Size     := 200;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NUMDOC';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PARCEL';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALCOB';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALDES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCOB';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'COBANT';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALDOC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALREC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALORI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALOR2';
    DataType := ftFloat;
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
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FANSOB';
    DataType := ftString;
    Size     := 100;
  end;


  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODCTA';
    DataType := ftString;
    Size     := 7;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODVEN';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTAREC';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'HORREC';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCTA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'HIST01';
    DataType := ftString;
    Size     := 300;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'HIST02';
    DataType := ftString;
    Size     := 150;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOSNUM';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FONE01';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'F_A_X_';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ENDERE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ENDNUM';
    DataType := ftString;
    Size     := 10;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ENDCMP';
    DataType := ftString;
    Size     := 100;
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
    Name     := 'C_G_C_';
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
    Name     := 'SEQBAI';
    DataType := ftInteger;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'OPEBAI';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'SEQCON';
    DataType := ftInteger;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DINHEI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CHQAVI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CHQPRE';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CARTAO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ORDPAG';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CREDITO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ABERTO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DESCRI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CAIXA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RECPIX';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_TOTBLT';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_TOTCRD';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_TOTCHD';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do //MF: 290584 - 12/06/2023
  begin
    Name     := 'RESCAI';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do //MF: 290584 - 12/06/2023
  begin
    Name     := 'DESCOPEBAI';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DUPLICATA_TROCO';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALOR_TROCO';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;

end;

function DuplicataCreditoReferenteATroco(ADuplicata: TDataset): String;
Begin
  untReciboCtr.DuplicataCreditoReferenteATroco(ADuplicata);
End;

end.
