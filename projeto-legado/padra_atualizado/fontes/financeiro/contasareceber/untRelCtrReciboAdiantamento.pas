unit untRelCtrReciboAdiantamento;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint, System.StrUtils;

Type
  TRelCtrReciboAdiantamento = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadRec: TUniClientDataSet;
      FCadChqVis : TUniClientDataSet;
      FCadChqPre : TUniClientDataSet;
      FCadChq : TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadRec: TfrxDBDataset;
      FDataSetCadChqVis: TfrxDBDataset;
      FDataSetCadChqPre: TfrxDBDataset;
      FDataSetCadChq: TfrxDBDataset;
      FDataSetRelatorio: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      fltValorRecebido : Double;
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
      function fRemoveAcento(Str:String): String;
      procedure pBuscaDescricaoFormaPagamento(cdsImpRec : TUniClientDataset);
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
      constructor CreateInstance(cdsRecibo: TUniClientDataSet;
                                 cdsChqVis: TUniClientDataSet = Nil;
                                 cdsChqPre: TUniClientDataSet = Nil;
                                 cdsChq: TUniClientDataSet = Nil;
                                 fltValorRecebido : Double = 0;
                                 FNomImp : String = '';
                                 FTipImp : String = '');
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      procedure pFiltraCds( strFiltro : String );
      procedure pCarregaVariaveis;
  end;

  function fCriaClientDatasetReciboAd: TUniClientDataSet;
  function fCriaCdsChequesAd : TUniClientDataSet;


Const
  FILA_IMPRESSAO_RECIBO_AD = 'frmSelPedidoAdiantamento';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCtrReciboAdiantamento }

constructor TRelCtrReciboAdiantamento.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadRec := fCriaClientDatasetReciboAd;
  FCadChqVis := fCriaCdsChequesAd;
  FCadChqPre := fCriaCdsChequesAd;
  FCadChq    := fCriaCdsChequesAd;


  FCadRec.Append;
  FCadRec.FieldByName('DESCRI').AsString   := 'REFERENTE A RECEBIMENTO';
  FCadRec.FieldByName('NUMDOC').AsString   := '000000000456';
  FCadRec.FieldByName('ESPDOC').AsString   := 'NF';
  FCadRec.FieldByName('PARCEL').AsString   := 'A';
  FCadRec.FieldByName('CODEMP').AsString   := VS_strCodEmp;
  FCadRec.FieldByName('DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
  FCadRec.FieldByName('VALJUR').AsFloat    := 1;
  FCadRec.FieldByName('VALCOB').AsFloat    := 1;
  FCadRec.FieldByName('VALDES').AsFloat    := 1;
  FCadRec.FieldByName('DESCOB').AsFloat    := 1;
  FCadRec.FieldByName('VALDOC').AsFloat    := 256;
  FCadRec.FieldByName('VALREC').AsFloat    := 256;
  FCadRec.FieldByName('VALORI').AsFloat    := 256;
  FCadRec.FieldByName('CODCLI').AsString   := '000000456';
  FCadRec.FieldByName('NOMCLI').AsString   := 'MARIA APARECIDA';
  FCadRec.FieldByName('NOMCON').AsString   := 'CONSUMIDOR FINAL';
  FCadRec.FieldByName('CODCTA').AsString   := '02002002';
  FCadRec.FieldByName('CODVEN').AsString   := '999';
  FCadRec.FieldByName('DTAREC').AsDateTime := StrToDateTime('01/01/2000');
  FCadRec.FieldByName('HORREC').AsDateTime := fTime();
  FCadRec.FieldByName('DTACAD').AsDateTime := StrToDateTime('01/01/2000');
  FCadRec.FieldByName('DESCTA').AsString   := 'PLANO DE CONTAS';
  FCadRec.FieldByName('ENDERE').AsString   := 'RUA TAMOIOS';
  FCadRec.FieldByName('ENDNUM').AsString   := '45';
  FCadRec.FieldByName('ENDCMP').AsString   := 'AP. 21';
  FCadRec.FieldByName('BAIRRO').AsString   := 'CENTRO';
  FCadRec.FieldByName('CIDADE').AsString   := 'RIBEIRAO PRETO';
  FCadRec.FieldByName('ESTADO').AsString   := 'SP';
  FCadRec.FieldByName('C_E_P_').AsString   := '14000000';
  FCadRec.FieldByName('C_G_C_').AsString   := '11111111111';
  FCadRec.FieldByName('FONE01').AsString   := '02139363636';
  FCadRec.FieldByName('CTR_CREDITO').AsFloat    := 1;
  FCadRec.FieldByName('CTR_ABERTO').AsFloat     := 1;
  FCadRec.FieldByName('CTR_TOTBLT').AsFloat     := 1000;
  FCadRec.FieldByName('CTR_TOTCRD').AsFloat     := 250;
  FCadRec.FieldByName('CTR_TOTCHD').AsFloat     := 120;
  FCadRec.FieldByName('HIST01').AsString   := '';
  FCadRec.FieldByName('HIST02').AsString   := '';
  FCadRec.FieldByName('RCX_DESCRI').AsString   := 'DESCRICAO DO LANCAMENTO';
  FCadRec.FieldByName('RCX_CAIXA').AsString := 'TESTE CAIXA';
  FCadRec.FieldByName('TOTCLI').AsFloat        := 256;
  FCadRec.FieldByName('NOMCTA').AsString   := '01.01.001 - Plano de Contas';
  FCadRec.FieldByName('NOMEVE').AsString   := '00001 - Evento';
  FCadRec.FieldByName('CTR_VALCRE').AsFloat := 356.00;
  FCadRec.FieldByName('DESCPORBAI').AsString   := '00005 - PORTADOR DA BAIXA';
  FCadRec.FieldByName('DESCOPEBAI').AsString   := '998 - OPERADOR DA BAIXA';
  FCadRec.FieldByName('DESCHISBAI').AsString  := 'HIST”RICO DA BAIXA';
  FCadRec.FieldByName('SEQCON').asString := '20833650';
  FCadRec.FieldByName('DESFPG').asString := 'DINHEIRO: R$ 00,00';
  FCadRec.Post;

  FCadChqVis.Append;
  FCadChqVis.FieldByName('CHQ_CODBCO').asString := '001';
  FCadChqVis.FieldByName('CHQ_NUMAGE').asString := '1';
  FCadChqVis.FieldByName('CHQ_CONCOR').asString := '1';
  FCadChqVis.FieldByName('CHQ_NUMCHQ').asString := '2701202002';
  FCadChqVis.FieldByName('CHQ_CODCLI').asString := '00000001';
  FCadChqVis.FieldByName('CHQ_NOMEMI').asString := 'CONSUMIDOR SP';
  FCadChqVis.FieldByName('CHQ_ENDERE').asString := 'RUA COMANDANTE MARCONDES SALGADO';
  FCadChqVis.FieldByName('CHQ_TELEMI').asString := '11111111111';
  FCadChqVis.FieldByName('CHQ_CGCCPF').asString := '2';
  FCadChqVis.FieldByName('CHQ_C_G_C_').asString := '99999999999';
  FCadChqVis.FieldByName('CHQ_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_VALCHQ').AsFloat := 123.45;
  FCadChqVis.FieldByName('CHQ_HIST01').asString := 'TESTE1';
  FCadChqVis.FieldByName('CHQ_HIST02').asString := 'TESTE2';
  FCadChqVis.FieldByName('CHQ_CTADEP').asString := '11111';
  FCadChqVis.FieldByName('CHQ_DTADEP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_DOCDEP').asString := '1111111111';
  FCadChqVis.FieldByName('CHQ_CODPOR').asString := '00995';
  FCadChqVis.FieldByName('CHQ_CODCTA').asString := '0103003';
  FCadChqVis.FieldByName('CHQ_DTADEV').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_MOTDEV').asString := 'TESTE';
  FCadChqVis.FieldByName('CHQ_DTARDP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_FORREP').asString := '90690600';
  FCadChqVis.FieldByName('CHQ_OBSREP').asString := 'TESTE';
  FCadChqVis.FieldByName('CHQ_DTAREP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_RESCAI').asString := '1';
  FCadChqVis.FieldByName('CHQ_CODEMP').asString := '001';
  FCadChqVis.FieldByName('CHQ_NUMNOT').asString := '12345';
  FCadChqVis.FieldByName('CHQ_DTACUS').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqVis.FieldByName('CHQ_PORCUS').asString := 'TESTE';
  FCadChqVis.FieldByName('CHQ_DOCUME').asString := '1111111111';
  FCadChqVis.FieldByName('CHQ_INCCTR').asString := 'N';
  FCadChqVis.FieldByName('CHQ_SEQCOM').asString := '1';
  FCadChqVis.FieldByName('CHQ_SEQCON').asString := '1';
  FCadChqVis.FieldByName('CHQ_EMPRCX').asString := '999';
  FCadChqVis.FieldByName('CHQ_TELCHE').asString := 'N';
  FCadChqVis.FieldByName('CHQ_TELNUM').asString := '9999999';
  FCadChqVis.FieldByName('CHQ_CODOPE').asString := '789';
  FCadChqVis.FieldByName('CHQ_CODCMC').asString := '999';
  FCadChqVis.FieldByName('CHQ_VALIPI').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VALRET').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VALACE').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VALFRE').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VALCBS').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VALIBS').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_VAL_IS').AsFloat := 0.00;
  FCadChqVis.FieldByName('CHQ_PORCHQ').asString := '00004';
  FCadChqVis.FieldByName('CHQ_NOMFRM').asString := 'untFuncFat';
  FCadChqVis.FieldByName('CHQ_NAODEP').asString := 'N';
  FCadChqVis.FieldByName('CHQ_CODCID').asString := '999';
  FCadChqVis.FieldByName('CHQ_CODCAX').asString := '999';
  FCadChqVis.FieldByName('CHQ_SEQANT').asString := '999';
  FCadChqVis.Post;



  FCadChqPre.Append;
  FCadChqPre.FieldByName('CHQ_CODBCO').asString := '001';
  FCadChqPre.FieldByName('CHQ_NUMAGE').asString := '1';
  FCadChqPre.FieldByName('CHQ_CONCOR').asString := '1';
  FCadChqPre.FieldByName('CHQ_NUMCHQ').asString := '2701202002';
  FCadChqPre.FieldByName('CHQ_CODCLI').asString := '00000001';
  FCadChqPre.FieldByName('CHQ_NOMEMI').asString := 'CONSUMIDOR SP';
  FCadChqPre.FieldByName('CHQ_ENDERE').asString := 'RUA COMANDANTE MARCONDES SALGADO';
  FCadChqPre.FieldByName('CHQ_TELEMI').asString := '11111111111';
  FCadChqPre.FieldByName('CHQ_CGCCPF').asString := '2';
  FCadChqPre.FieldByName('CHQ_C_G_C_').asString := '99999999999';
  FCadChqPre.FieldByName('CHQ_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_VALCHQ').AsFloat := 123.45;
  FCadChqPre.FieldByName('CHQ_HIST01').asString := 'TESTE1';
  FCadChqPre.FieldByName('CHQ_HIST02').asString := 'TESTE2';
  FCadChqPre.FieldByName('CHQ_CTADEP').asString := '11111';
  FCadChqPre.FieldByName('CHQ_DTADEP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_DOCDEP').asString := '1111111111';
  FCadChqPre.FieldByName('CHQ_CODPOR').asString := '00995';
  FCadChqPre.FieldByName('CHQ_CODCTA').asString := '0103003';
  FCadChqPre.FieldByName('CHQ_DTADEV').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_MOTDEV').asString := 'TESTE';
  FCadChqPre.FieldByName('CHQ_DTARDP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_FORREP').asString := '90690600';
  FCadChqPre.FieldByName('CHQ_OBSREP').asString := 'TESTE';
  FCadChqPre.FieldByName('CHQ_DTAREP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_RESCAI').asString := '1';
  FCadChqPre.FieldByName('CHQ_CODEMP').asString := '001';
  FCadChqPre.FieldByName('CHQ_NUMNOT').asString := '12345';
  FCadChqPre.FieldByName('CHQ_DTACUS').AsDateTime := StrToDateTime('01/01/2000');
  FCadChqPre.FieldByName('CHQ_PORCUS').asString := 'TESTE';
  FCadChqPre.FieldByName('CHQ_DOCUME').asString := '1111111111';
  FCadChqPre.FieldByName('CHQ_INCCTR').asString := 'N';
  FCadChqPre.FieldByName('CHQ_SEQCOM').asString := '1';
  FCadChqPre.FieldByName('CHQ_SEQCON').asString := '1';
  FCadChqPre.FieldByName('CHQ_EMPRCX').asString := '999';
  FCadChqPre.FieldByName('CHQ_TELCHE').asString := 'N';
  FCadChqPre.FieldByName('CHQ_TELNUM').asString := '9999999';
  FCadChqPre.FieldByName('CHQ_CODOPE').asString := '789';
  FCadChqPre.FieldByName('CHQ_CODCMC').asString := '999';
  FCadChqPre.FieldByName('CHQ_VALIPI').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VALRET').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VALACE').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VALFRE').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VALCBS').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VALIBS').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_VAL_IS').AsFloat := 0.00;
  FCadChqPre.FieldByName('CHQ_PORCHQ').asString := '00004';
  FCadChqPre.FieldByName('CHQ_NOMFRM').asString := 'untFuncFat';
  FCadChqPre.FieldByName('CHQ_NAODEP').asString := 'N';
  FCadChqPre.FieldByName('CHQ_CODCID').asString := '999';
  FCadChqPre.FieldByName('CHQ_CODCAX').asString := '999';
  FCadChqPre.FieldByName('CHQ_SEQANT').asString := '999';
  FCadChqPre.Post;

  FCadChq.Append;
  FCadChq.FieldByName('CHQ_CODBCO').asString := '001';
  FCadChq.FieldByName('CHQ_NUMAGE').asString := '1';
  FCadChq.FieldByName('CHQ_CONCOR').asString := '1';
  FCadChq.FieldByName('CHQ_NUMCHQ').asString := '2701202002';
  FCadChq.FieldByName('CHQ_CODCLI').asString := '00000001';
  FCadChq.FieldByName('CHQ_NOMEMI').asString := 'CONSUMIDOR SP';
  FCadChq.FieldByName('CHQ_ENDERE').asString := 'RUA COMANDANTE MARCONDES SALGADO';
  FCadChq.FieldByName('CHQ_TELEMI').asString := '11111111111';
  FCadChq.FieldByName('CHQ_CGCCPF').asString := '2';
  FCadChq.FieldByName('CHQ_C_G_C_').asString := '99999999999';
  FCadChq.FieldByName('CHQ_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_VALCHQ').AsFloat := 123.45;
  FCadChq.FieldByName('CHQ_HIST01').asString := 'TESTE1';
  FCadChq.FieldByName('CHQ_HIST02').asString := 'TESTE2';
  FCadChq.FieldByName('CHQ_CTADEP').asString := '11111';
  FCadChq.FieldByName('CHQ_DTADEP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_DOCDEP').asString := '1111111111';
  FCadChq.FieldByName('CHQ_CODPOR').asString := '00995';
  FCadChq.FieldByName('CHQ_CODCTA').asString := '0103003';
  FCadChq.FieldByName('CHQ_DTADEV').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_MOTDEV').asString := 'TESTE';
  FCadChq.FieldByName('CHQ_DTARDP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_FORREP').asString := '90690600';
  FCadChq.FieldByName('CHQ_OBSREP').asString := 'TESTE';
  FCadChq.FieldByName('CHQ_DTAREP').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_RESCAI').asString := '1';
  FCadChq.FieldByName('CHQ_CODEMP').asString := '001';
  FCadChq.FieldByName('CHQ_NUMNOT').asString := '12345';
  FCadChq.FieldByName('CHQ_DTACUS').AsDateTime := StrToDateTime('01/01/2000');
  FCadChq.FieldByName('CHQ_PORCUS').asString := 'TESTE';
  FCadChq.FieldByName('CHQ_DOCUME').asString := '1111111111';
  FCadChq.FieldByName('CHQ_INCCTR').asString := 'N';
  FCadChq.FieldByName('CHQ_SEQCOM').asString := '1';
  FCadChq.FieldByName('CHQ_SEQCON').asString := '1';
  FCadChq.FieldByName('CHQ_EMPRCX').asString := '999';
  FCadChq.FieldByName('CHQ_TELCHE').asString := 'N';
  FCadChq.FieldByName('CHQ_TELNUM').asString := '9999999';
  FCadChq.FieldByName('CHQ_CODOPE').asString := '789';
  FCadChq.FieldByName('CHQ_CODCMC').asString := '999';
  FCadChq.FieldByName('CHQ_VALIPI').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VALRET').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VALACE').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VALFRE').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VALCBS').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VALIBS').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_VAL_IS').AsFloat := 0.00;
  FCadChq.FieldByName('CHQ_PORCHQ').asString := '00004';
  FCadChq.FieldByName('CHQ_NOMFRM').asString := 'untFuncFat';
  FCadChq.FieldByName('CHQ_NAODEP').asString := 'N';
  FCadChq.FieldByName('CHQ_CODCID').asString := '999';
  FCadChq.FieldByName('CHQ_CODCAX').asString := '999';
  FCadChq.FieldByName('CHQ_SEQANT').asString := '999';
  FCadChq.Post;
  fltValorRecebido := 10.00;

  pIniciaObjetos;
end;

constructor TRelCtrReciboAdiantamento.CreateInstance(cdsRecibo: TUniClientDataSet;
                                      cdsChqVis: TUniClientDataSet = Nil;
                                      cdsChqPre: TUniClientDataSet = Nil;
                                      cdsChq: TUniClientDataSet = Nil;
                                      fltValorRecebido : Double = 0;
                                      FNomImp : String = '';
                                      FTipImp : String = '');
begin
  FModoDesigner  := False;

  FCadRec        := TUniClientDataSet.Create(Nil);
  FCadRec.Data   := cdsRecibo.Data;


  If Assigned(cdsChqVis) Then
  Begin
    FCadChqVis        := TUniClientDataSet.Create(Nil);
    FCadChqVis.Data   := cdsChqVis.Data;
  End
  Else
    FCadChqVis := fCriaCdsChequesAd;

  If Assigned(cdsChqPre) Then
  Begin
    FCadChqPre        := TUniClientDataSet.Create(Nil);
    FCadChqPre.Data   := cdsChqPre.Data;
  End
  Else
    FCadChqPre := fCriaCdsChequesAd;

  If Assigned(cdsChq) Then
  Begin
    FCadChq        := TUniClientDataSet.Create(Nil);
    FCadChq.Data   := cdsChq.Data;
  End
  Else
    FCadChq := fCriaCdsChequesAd;

  Self.fltValorRecebido := fltValorRecebido;

  Self.FNomImp := FNomImp;
  Self.FTipImp := FTipImp;

  pIniciaObjetos;
end;

procedure TRelCtrReciboAdiantamento.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetRelatorio := TfrxDBDataset.Create(nil);
  FDataSetRelatorio.Name := 'frxRelatorio';
  FDataSetRelatorio.DataSet := FCadRec;

  FDataSetCadRec := TfrxDBDataset.Create(nil);
  FDataSetCadRec.Name := 'frxDataSetContasReceber';
  FDataSetCadRec.DataSet := FCadRec;

  FDataSetCadChqPre := TfrxDBDataset.Create(nil);
  FDataSetCadChqPre.Name := 'frxDataSetContasChequePre';
  FDataSetCadChqPre.DataSet := FCadChqPre;

  FDataSetCadChqVis := TfrxDBDataset.Create(nil);
  FDataSetCadChqVis.Name := 'frxDataSetContasChequeVis';
  FDataSetCadChqVis.DataSet := FCadChqVis;

  FDataSetCadChq := TfrxDBDataset.Create(nil);
  FDataSetCadChq.Name := 'frxDataSetContasCheque';
  FDataSetCadChq.DataSet := FCadChq;

  FCadEmp_   := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;


  SetLength(FArrDBDataSet, 6);
  FArrDBDataSet[0] := FDataSetRelatorio;
  FArrDBDataSet[1] := FDataSetCadRec;
  FArrDBDataSet[2] := FDataSetCadChqPre;
  FArrDBDataSet[3] := FDataSetCadChqVis;
  FArrDBDataSet[4] := FDataSetCadChq;
  FArrDBDataSet[5] := FDataSetEmp;

  pDefineFilaImpressao(False);
end;

destructor TRelCtrReciboAdiantamento.Destroy;
begin
  FreeAndNil(FCadRec);
  FreeAndNil(FDataSetCadRec);
  FreeAndNil(FCadChqVis);
  FreeAndNil(FDataSetCadChqVis);
  FreeAndNil(FCadChqPre);
  FreeAndNil(FCadChq);
  FreeAndNil(FDataSetCadChq);
  FreeAndNil(FDataSetCadChqPre);
  FreeAndNil(FDataSetRelatorio);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtrReciboAdiantamento.pCarregaListaFuncoes;
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
  FListaFuncoes.Add('function fRemoveAcento(Str:String): String;');
  FListaFuncoes.Add('function fRetNomVendRep(strCodVen: String): String;');
end;

procedure TRelCtrReciboAdiantamento.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtrReciboAdiantamento.pFiltraCds( strFiltro : String );
Begin
   FCadRec.Filtered := False;
   FCadRec.Filter   := strFiltro;
   FCadRec.Filtered := True;
End;

procedure TRelCtrReciboAdiantamento.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  if (blnConfigurar = False) then
  Begin
   {SE HOUVER CONFIGURA«√O PR…VIA, N√O BUSCAR DA FILA}
    if (fEmptyStr(FNomImp) = False) and (fEmptyStr(FTipImp) = False) then
      Exit;
  End;
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_RECIBO_AD);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_RECIBO_AD);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
 end;

function TRelCtrReciboAdiantamento.fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fFormataCpfCgcInterna',MethodName) Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText('fFormataCEP', MethodName) Then
    Result := fFormataCEP(Params[0]);

  If SameText( 'fFormataFone', MethodName) Then
    Result := fFormataFone(Params[0]);

  If SameText('fRetExtensoNumero', MethodName ) Then
    Result := fRetExtensoNumero(Params[0]);

  If SameText('fGetTotalRecebido', MethodName ) Then
    Result := fGetTotalRecebido(Params[0]);

  If SameText('fGetDescricao', MethodName ) Then
    Result := fGetDescricao(Params[0]);

  If SameText( 'fRetNomOpe', MethodName) Then
    Result := fRetNomOpe(Params[0]);

  If SameText('fRetornaReceberAbertoInterna', MethodName ) Then
    Result := fRetornaReceberAbertoInterna(Params[0]);

  If SameText('fRemoveAcento', MethodName ) Then
    Result := fRemoveAcento(Params[0]);

  If SameText('fRetNomVendRep', MethodName) Then
    Result := fRetNomVendRep(Params[0]);
end;

function TRelCtrReciboAdiantamento.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TRelCtrReciboAdiantamento.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelCtrReciboAdiantamento.fGetDescricao(strSeqCon: String): String;
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

  qryRcxDes.Close;
  qryRcxDes.SQL.Clear;
  qryRcxDes.SQL.Add(strSQL);
  qryRcxDes.ParamByName('SEQCON').AsString := strSeqCon;
  qryRcxDes.Open;

  Result := IIF(strSeqCon <> '0', 'a ' + qryRcxDes.FieldByName('RCX_DESCRI').AsString + ', conforme os', 'aos');

  FreeAndNil(qryRcxDes);
end;

function TRelCtrReciboAdiantamento.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtrReciboAdiantamento.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCtrReciboAdiantamento.fGetIsEmpty: Boolean;
begin
  Result := FCadRec.IsEmpty;
end;

function TRelCtrReciboAdiantamento.fGetKey: String;
begin
  If fCfgSis('RECRCX') = 'C' Then
  Begin
  begin
    If FTipImp = 'M' Then
      Result := 'ADCTR1'
    else
    begin
      If (fCfgSis('LAYREC') = '1') Then {MEIA FOLHA - SEM CHEQUES}
        Result := 'ADCTR3'
      else
        Result := 'ADCTR2' {FOLHA INTEIRA - COM CHEQUES}
    end;
  end
  End
  Else If fCfgSis('RECRCX') = 'L' Then
  Begin
    Result := 'ADCTR4'
  End
  Else If fCfgSis('RECRCX') = 'B' Then
  Begin
    Result := 'ADCTR5';
  End;
end;

function TRelCtrReciboAdiantamento.fGetName: String;
begin
  If fCfgSis('RECRCX') = 'C' Then
  Begin
    If FTipImp = 'M' Then
      Result := 'RECIBO ADIANTAMENTOS CONTAS A RECEBER - COLUNA'
    else
    begin
      If (fCfgSis('LAYREC') = '1') Then {MEIA FOLHA - SEM CHEQUES}
        Result := 'RECIBO ADIANTAMENTOS CONTAS A RECEBER - COLUNA - MEIA FOLHA'
      else
        Result := 'RECIBO ADIANTAMENTOS CONTAS A RECEBER - COLUNA - FOLHA INTEIRA'
    End;
  End
  Else If fCfgSis('RECRCX') = 'L' Then
  Begin
    Result := 'RECIBO ADIANTAMENTOS CONTAS A RECEBER - LINHA';
  End
  Else If fCfgSis('RECRCX') = 'B' Then
  Begin
    Result := 'RECIBO ADIANTAMENTOS CONTAS A RECEBER - BOBINA';
  End;
end;

function TRelCtrReciboAdiantamento.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtrReciboAdiantamento.fGetTotalRecebido(intSeqCon: Integer): Double;
begin
  Result := IfNull(FDicTot[IntToStr(intSeqCon)], 0);
end;

function TRelCtrReciboAdiantamento.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtrReciboAdiantamento.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtrReciboAdiantamento.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;


function TRelCtrReciboAdiantamento.fPrepareDataSetsAndVariables: Boolean;
begin
  FDicTot.Limpar;

  fCadEmp('NOMEMP', FCadEmp_);
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;


procedure TRelCtrReciboAdiantamento.pCarregaVariaveis;
 Var strTotalRecebidoExt, strLocalData : String;
begin
  {GERAIS E COMUNS A TODOS}
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strDescriUsuarioLogado',IfThen(strTipFil = 'M',fRemoveAcento(strDescriUsuarioLogado),strDescriUsuarioLogado));
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  FDicVar.AddOrSetValue('strSIGPAI',fCfgSis('SIGPAI', varString));
  FDicVar.AddOrSetValue('strINFREC',IIF(fCfgSis('INFREC', varBoolean),'S','N'));
  FDicVar.AddOrSetValue('fltTotalRecebido', fltValorRecebido);
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    strTotalRecebidoExt := FGet_Extens(FormatFloat('#,##0.00', fltValorRecebido), 'E')
  Else
    strTotalRecebidoExt := fRetExtensoNumero(FormatFloat('#,##0.00', fltValorRecebido));
  FDicVar.AddOrSetValue('fltTotalRecebidoExt',strTotalRecebidoExt);
  If fCfgSis('SIGPAI', varString) = 'PAR' Then
    strLocalData := fRetDataExtEsp(VS_Date, True)
  Else
    strLocalData := fRetDataExtenso(VS_Date, True);
  FDicVar.AddOrSetValue('strLocalData',strLocalData);

  {EMPRESA}
  FDicVar.AddOrSetValue('strCGCEMP',fFormataCpfCgc(FCadEmp_.FieldByName('EMP_C_G_C_').AsString, fSetaPais));
  {CLIENTE}
  FDicVar.AddOrSetValue('strCEP',fFormataCEP(FCadRec.FieldByName('C_E_P_').AsString));
  if  FCadRec.FindField('RCX_CAIXA') <> nil then
    FDicVar.AddOrSetValue('CAIXA',FCadRec.FieldByName('RCX_CAIXA').AsString)
  else
    FDicVar.AddOrSetValue('CAIXA','');
  {DADOS DO PAGAMETNO}
  pBuscaDescricaoFormaPagamento(FCadRec);

  If fCfgSis('RECRCX') = 'C' Then
  Begin
    If FTipImp <> 'M' Then
    begin
      FDicVar.AddOrSetValue('NOMCLI',FCadRec.FieldByName('CODCLI').asString + ' - ' + FCadRec.FieldByName('NOMCLI').asString);
      FDicVar.AddOrSetValue('ENDCLI',FCadRec.FieldByName('ENDERE').asString + ' - ' + FCadRec.FieldByName('ENDNUM').asString + ' - ' +  FCadRec.FieldByName('BAIRRO').asString);
      FDicVar.AddOrSetValue('CEPCLI',fFormataCEP(FCadRec.FieldByName('C_E_P_').AsString));
      FDicVar.AddOrSetValue('CIDCLI',FCadRec.FieldByName('CIDADE').asString + ' - ' + FCadRec.FieldByName('ESTADO').asString);
      FDicVar.AddOrSetValue('ESTCLI','');
      FDicVar.AddOrSetValue('VALREC',fltValorRecebido);
      FDicVar.AddOrSetValue('VALEXT',strTotalRecebidoExt);
      FDicVar.AddOrSetValue('NOMEMP',FCadEmp_.FieldByName('EMP_NOMEMP').AsString);
      FDicVar.AddOrSetValue('ENDERE',FCadEmp_.FieldByName('EMP_ENDERE').AsString+', '+
                                     FCadEmp_.fieldbyname('EMP_ENDNUM').AsString);
      FDicVar.AddOrSetValue('C_E_P_',FCadEmp_.FieldByName('EMP_C_E_P_').AsString);
      FDicVar.AddOrSetValue('CIDADE',fRetNomCidade(FCadEmp_.FieldByName('EMP_CODCID').AsString));
      FDicVar.AddOrSetValue('ESTADO',fRetNomCidade(FCadEmp_.FieldByName('EMP_CODCID').AsString, 1));
      FDicVar.AddOrSetValue('CNPJ','CNPJ: ' + FCadEmp_.FieldByName('EMP_C_G_C_').AsString);
      FDicVar.AddOrSetValue('INSEST','INSCRICAO ESTADUAL: ' + FCadEmp_.FieldByName('EMP_I_E_S_').AsString);
      FDicVar.AddOrSetValue('SEQCON','SEQ. BAIXA: ' + FCadRec.FieldByName('SEQCON').asString);
      FDicVar.AddOrSetValue('DTAREC',FormatDateTime('dd/mm/yyyy', VS_Date));
      FDicVar.AddOrSetValue('CODOPE',IIF(strTipFil = 'M',fRemoveAcento(strDescriUsuarioLogado),strDescriUsuarioLogado));
      FDicVar.AddOrSetValue('CODEMP',FCadEmp_.FieldByName('EMP_CODEMP').AsString);
    end;
  End
  Else If fCfgSis('RECRCX') = 'L' Then
  Begin
    If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Begin
      FDicVar.AddOrSetValue('strSeqBaixa',IfThen(fEmptyStr(FCadRec.FieldByName('SEQCON').asString), '', 'SEQ.BAJA: ' + FCadRec.FieldByName('SEQCON').asString));
      FDicVar.AddOrSetValue('RELACAO','LISTA DE LOS DOCUMENTOS DESCARGADOS');
      FDicVar.AddOrSetValue('RECEBIDO','RECEBIDO');
      FDicVar.AddOrSetValue('DESCRICAO','CLIENTE/DESCRIPCION');
      FDicVar.AddOrSetValue('EMP','NEG');
      FDicVar.AddOrSetValue('VENC','MADUREZ');
      FDicVar.AddOrSetValue('JUROS','INTERES');
      FDicVar.AddOrSetValue('PLANO','PL.CUENTAS:');
      FDicVar.AddOrSetValue('ORDEM','GIRO POSTAL:');
      FDicVar.AddOrSetValue('CHQPRE','CHQ. ADEL:');
      FDicVar.AddOrSetValue('CARTAO','TARJETA:');
      FDicVar.AddOrSetValue('DINHEIRO','DINERO:');
      FDicVar.AddOrSetValue('CNPJ','RUC');
      FDicVar.AddOrSetValue('COMPENSACAO','ESTO SOLO ES VALIDO EN LA RECEPCION DE COMPENSACION CHEQUE');
      FDicVar.AddOrSetValue('NOSSONUMER','NUESTRO NUMER.');
      FDicVar.AddOrSetValue('TOTALGERAL','GENERAL DE LO CLIENTE TOTAL:');
      FDicVar.AddOrSetValue('CREDITO','CREDITO UTILIZADO:');
    End
    Else
    Begin
      FDicVar.AddOrSetValue('strSeqBaixa',IfThen(fEmptyStr(FCadRec.FieldByName('SEQCON').asString), '', 'SEQ.BAIXA: ' + FCadRec.FieldByName('SEQCON').asString));
      FDicVar.AddOrSetValue('RELACAO',IfThen(strTipFil = 'M', 'RELACAO DE DOCUMENTOS BAIXADOS', 'RELA«√O DE DOCUMENTOS BAIXADOS'));
      FDicVar.AddOrSetValue('RECEBIDO','RECEBIDO EM ');
      FDicVar.AddOrSetValue('DESCRICAO',IfThen(strTipFil = 'M', 'CLIENTE/DESCRICAO', 'CLIENTE/DESCRI«√O'));
      FDicVar.AddOrSetValue('EMP','EMP');
      FDicVar.AddOrSetValue('VENC','DT.VCTO.');
      FDicVar.AddOrSetValue('JUROS','VL. JUROS');
      FDicVar.AddOrSetValue('PLANO','PL.CONTAS:');
      FDicVar.AddOrSetValue('ORDEM','ORDEM PGTO.:');
      FDicVar.AddOrSetValue('CHQPRE',IfThen(strTipFil = 'M', 'CHQ. PRE:', 'CHQ. PR…:'));
      FDicVar.AddOrSetValue('CARTAO',IfThen(strTipFil = 'M', 'CARTAO:', 'CART√O:'));
      FDicVar.AddOrSetValue('DINHEIRO','DINHEIRO:');
      FDicVar.AddOrSetValue('CNPJ','CNPJ/CPF');
      FDicVar.AddOrSetValue('COMPENSACAO',IfThen(strTipFil = 'M', 'ESTE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE', 'ESTE RECIBO SOMENTE SER¡ V¡LIDO NA COMPENSA«√O DO CHEQUE'));
      FDicVar.AddOrSetValue('NOSSONUMER',IfThen(strTipFil = 'M', 'NOSSO NUMER.', 'NOSSO N⁄MER.'));
      FDicVar.AddOrSetValue('TOTALGERAL','TOTAL GERAL DO CLIENTE:');
      FDicVar.AddOrSetValue('CREDITO',IfThen(strTipFil = 'M','CREDITO UTILIZADO:','CR…DITO UTILIZADO:'));
      FDicVar.AddOrSetValue('DTAREC','DT.REC.');
      FDicVar.AddOrSetValue('DTEMISSAO',VS_Date );
    End;
    If FCadRec.FieldByName('ESPDOC').AsString = 'PG' Then
    Begin
      FDicVar.AddOrSetValue('strOperad','Recebi');
      FDicVar.AddOrSetValue('OPERADOR1','Operador: ' + IfThen(strTipFil = 'M',fRemoveAcento(strDescriUsuarioLogado),strDescriUsuarioLogado));
      FDicVar.AddOrSetValue('NOMECLI','');
    End
    Else
    Begin
      FDicVar.AddOrSetValue('NOMECLI','');
      FDicVar.AddOrSetValue('strOperad',IfThen(strTipFil = 'M',fRemoveAcento(strDescriUsuarioLogado),strDescriUsuarioLogado));
      FDicVar.AddOrSetValue('OPERADOR1','');
    End;
    FDicVar.AddOrSetValue('NOMEMP',fRetNomeEmpresa);
  End
  Else if fCfgSis('RECRCX') = 'B' Then {BOBINA}
  Begin
    FDicVar.AddOrSetValue('EMPRESA',FCadEmp_.fieldbyname('EMP_NOMFAN').AsString);
    FDicVar.AddOrSetValue('TELEFONE',FCadEmp_.fieldbyname('EMP_FONE01').AsString);
    FDicVar.AddOrSetValue('ENDERECO',FCadEmp_.fieldbyname('EMP_ENDERE').AsString +
                                    ','  + FCadEmp_.fieldbyname('EMP_ENDNUM').AsString +
                                    '  ' + FCadEmp_.fieldbyname('EMP_ENDCMP').AsString +
                                    '-' + FCadEmp_.fieldbyname('EMP_BAIRRO').AsString);
    FDicVar.AddOrSetValue('CIDADE',fRetNomCidade(FCadEmp_.FieldByName('EMP_CODCID').AsString));
    FDicVar.AddOrSetValue('DATA',fRetNomCidade(FCadEmp_.FieldByName('EMP_CODCID').AsString) + ', ' + FormatDateTime('dd/MM/yyyy',VS_Date));

    If fCfgSis('SIGPAI', varString) = 'PAR' Then
    Begin
      FDicVar.AddOrSetValue('RELACAO','LISTA DE LOS DOCUMENTOS DESCARGADOS');
      FDicVar.AddOrSetValue('EMP','NEG');
      FDicVar.AddOrSetValue('DESCRICAO','DESCRIPCION');
      FDicVar.AddOrSetValue('VENC','MADUREZ');
      FDicVar.AddOrSetValue('CNPJ','RUC');
      FDicVar.AddOrSetValue('COMPENSACAO','ESTO SOLO ES VALIDO EN LA RECEPCION DE COMPENSACION CHEQUE');
    End
    Else
    Begin
      FDicVar.AddOrSetValue('RELACAO','RELACAO DE DOCUMENTOS BAIXADOS');
      FDicVar.AddOrSetValue('EMP','EMP');
      FDicVar.AddOrSetValue('DESCRICAO','DESCRICAO');
      FDicVar.AddOrSetValue('VENC','DTA. VENC.');
      FDicVar.AddOrSetValue('CNPJ','CNPJ/CPF');
      FDicVar.AddOrSetValue('COMPENSACAO','ESTE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE');
    End;
  End;
end;


function TRelCtrReciboAdiantamento.fRetNomOpe(strCodOpe: String): String;
begin
  Result := fRetNomVendRep(strCodOpe);
end;

function TRelCtrReciboAdiantamento.fRetornaReceberAbertoInterna(strCodCli: String): String;
begin
  Result := FormatFloat('R$ ###,###,##0.00', fRetornaReceberAberto(strCodCli));
end;

function fCriaClientDatasetReciboAd: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('DESCRI',ftString,200);
  Result.FieldDefs.Add('NUMDOC',ftString,12);
  Result.FieldDefs.Add('ESPDOC',ftString,2);
  Result.FieldDefs.Add('PARCEL',ftString,3);
  Result.FieldDefs.Add('CODEMP',ftString,3);
  Result.FieldDefs.Add('DTAVEN',ftDateTime);
  Result.FieldDefs.Add('VALJUR',ftFloat);
  Result.FieldDefs.Add('VALCOB',ftFloat);
  Result.FieldDefs.Add('VALDES',ftFloat);
  Result.FieldDefs.Add('DESCOB',ftFloat);
  Result.FieldDefs.Add('VALDOC',ftFloat);
  Result.FieldDefs.Add('VALREC',ftFloat);
  Result.FieldDefs.Add('VALORI',ftFloat);
  Result.FieldDefs.Add('CODCLI',ftString,8);
  Result.FieldDefs.Add('NOMCLI',ftString,100);
  Result.FieldDefs.Add('NOMCON',ftString,100);
  Result.FieldDefs.Add('CODCTA',ftString,7);
  Result.FieldDefs.Add('CODVEN',ftString,3);
  Result.FieldDefs.Add('DTAREC',ftDateTime);
  Result.FieldDefs.Add('HORREC',ftDateTime);
  Result.FieldDefs.Add('DTACAD',ftDateTime);
  Result.FieldDefs.Add('DESCTA',ftString,100);
  Result.FieldDefs.Add('HIST01',ftString,300);
  Result.FieldDefs.Add('HIST02',ftString,150);
  Result.FieldDefs.Add('NOSNUM',ftString,12);
  Result.FieldDefs.Add('FONE01',ftString,15);
  Result.FieldDefs.Add('F_A_X_',ftString,15);
  Result.FieldDefs.Add('ENDERE',ftString,100);
  Result.FieldDefs.Add('ENDNUM',ftString,10);
  Result.FieldDefs.Add('ENDCMP',ftString,100);
  Result.FieldDefs.Add('BAIRRO',ftString,100);
  Result.FieldDefs.Add('CIDADE',ftString,100);
  Result.FieldDefs.Add('C_E_P_',ftString,20);
  Result.FieldDefs.Add('C_G_C_',ftString,20);
  Result.FieldDefs.Add('ESTADO',ftString,2);
  Result.FieldDefs.Add('SEQBAI',ftInteger);
  Result.FieldDefs.Add('OPEBAI',ftString,3);
  Result.FieldDefs.Add('SEQCON',ftInteger);
  Result.FieldDefs.Add('CTR_DINHEI',ftFloat);
  Result.FieldDefs.Add('CTR_CHQAVI',ftFloat);
  Result.FieldDefs.Add('CTR_CHQPRE',ftFloat);
  Result.FieldDefs.Add('CTR_CARTAO',ftFloat);
  Result.FieldDefs.Add('CTR_ORDPAG',ftFloat);
  Result.FieldDefs.Add('CTR_CREDITO',ftFloat);
  Result.FieldDefs.Add('CTR_ABERTO',ftFloat);
  Result.FieldDefs.Add('RCX_DESCRI',ftString,100);
  Result.FieldDefs.Add('RCX_CAIXA',ftString,100);
  Result.FieldDefs.Add('PORBAI',ftString,005);
  Result.FieldDefs.Add('DESCPORBAI',ftString,100);
  Result.FieldDefs.Add('DESCOPEBAI',ftString,100);
  Result.FieldDefs.Add('DESCHISBAI',ftString,100);
  Result.FieldDefs.Add('TOTCLI',ftFloat);
  Result.FieldDefs.Add('NOMCTA',ftString,100);
  Result.FieldDefs.Add('NOMEVE',ftString,100);
  Result.FieldDefs.Add('CTR_VALCRE',ftFloat);
  Result.FieldDefs.Add('CTR_TOTBLT',ftFloat);
  Result.FieldDefs.Add('CTR_TOTCRD',ftFloat);
  Result.FieldDefs.Add('CTR_TOTCHD',ftFloat);
  Result.FieldDefs.Add('DESFPG', ftString, 500);

  Result.CreateDataSet;

end;

function fCriaCdsChequesAd : TUniClientDataSet;
  Var
    qryCadChq: TUniQuery;
    intCont  : Integer;
    flTotal: TAggregateField;
begin
  qryCadChq := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', Nil);

  Result := TUniClientDataSet.Create(Nil);
  Result.AggregatesActive := True;

  For intCont := 0 To qryCadChq.Fields.Count -1 Do
  Begin
    Result.FieldDefs.Add(qryCadChq.Fields[intCont].FieldName,qryCadChq.Fields[intCont].DataType,qryCadChq.Fields[intCont].Size, False);
  End;


  {For intCont := 0 To qryCadChq.Fields.Count -1 Do
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryCadChq.Fields[intCont].FieldName;
      DataType := qryCadChq.Fields[intCont].DataType;
      Size     := qryCadChq.Fields[intCont].Size;
      Required := False;
    End;   }

  flTotal :=  TAggregateField.Create(Result);
  flTotal.FieldName     := 'TOT_VALCHQ';
  flTotal.DataSet       := Result;
  flTotal.DisplayFormat := '#,##0.00';
  flTotal.Alignment     := Classes.taRightJustify;
  flTotal.Expression    := 'SUM(CHQ_VALCHQ)';
  flTotal.Active := True;

  Result.CreateDataSet;
  FreeAndNil(qryCadChq);
end;

function TRelCtrReciboAdiantamento.fRemoveAcento(Str:String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

procedure TRelCtrReciboAdiantamento.pBuscaDescricaoFormaPagamento(cdsImpRec : TUniClientDataset);
var
  qryFormaPagto: TUniQuery;
  strrllValDin, strrllValCar, strrllValChv, strrllValOrd, strrllValChp,  strrllValCre,  strrllBaiEmp,  strrllBaiPor,  strrllBaiOp, strrllBaiHis : String;
  LFormaPagamento: string;
  LDin, LCar, LChp, LChv, LOrd, LCre: Double;
begin
  qryFormaPagto := fCriaQuery();

  try
    qryFormaPagto.Close;
    qryFormaPagto.SQL.Clear;
    qryFormaPagto.SQL.Add('SELECT SUM(ADT_VALCAR) ADT_VALCAR, SUM(ADT_VALCHP) ADT_VALCHP, SUM(ADT_VALCHV) ADT_VALCHV, SUM(ADT_VALCRE) ADT_VALCRE, SUM(ADT_VALDIN) ADT_VALDIN, SUM(ADT_VALORD) ADT_VALORD,');
    qryFormaPagto.SQL.Add('       MAX(ADT_CODPOR) ADT_CODPOR, MAX(ADT_OPELAN) ADT_OPELAN, MAX(ADT_DESCRI) ADT_DESCRI ');
    qryFormaPagto.SQL.Add('FROM ADTCLI');
    qryFormaPagto.SQL.Add('WHERE ADT_SEQCON = :SEQCON');
    qryFormaPagto.ParamByName('SEQCON').AsString := cdsImpRec.FieldByName('SEQCON').asString;
    qryFormaPagto.Open;

    if not qryFormaPagto.IsEmpty then
    begin
      strrllValDin := 'DINHEIRO: '          + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALDIN').AsFloat);
      strrllValCar := 'CARTAO: '            + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCAR').AsFloat);
      strrllValChv := 'CHEQUE A VISTA: '    + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCHV').AsFloat);
      strrllValOrd := 'ORDEM DE PGTO: '     + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALORD').AsFloat);
      strrllValChp := 'CHEQUE-PRE: '        + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCHP').AsFloat);
      strrllValCre := 'CRED. UTILIZADO: '   + FormatFloat('#,##0.00', qryFormaPagto.FieldByName('ADT_VALCRE').AsFloat);
      strrllBaiEmp := VS_strCodEmp + ' - '  + fRetNomeEmpresa;
      strrllBaiPor := qryFormaPagto.FieldByName('ADT_CODPOR').asString  + ' - ' + fRetNomPortador(qryFormaPagto.FieldByName('ADT_CODPOR').asString);
      strrllBaiOp  := qryFormaPagto.FieldByName('ADT_OPELAN').asString  + ' - ' + fRetNomeOperador(qryFormaPagto.FieldByName('ADT_OPELAN').asString);
      strrllBaiHis := qryFormaPagto.FieldByName('ADT_DESCRI').asString;


      LDin := qryFormaPagto.FieldByName('ADT_VALDIN').AsFloat;
      LCar := qryFormaPagto.FieldByName('ADT_VALCAR').AsFloat;
      LChp := qryFormaPagto.FieldByName('ADT_VALCHP').AsFloat;
      LChv := qryFormaPagto.FieldByName('ADT_VALCHV').AsFloat;
      LOrd := qryFormaPagto.FieldByName('ADT_VALORD').AsFloat;
      LCre := qryFormaPagto.FieldByName('ADT_VALCRE').AsFloat;
    end
    else
    begin
      strrllValDin := 'DINHEIRO:'           + FormatFloat('#,##0.00', 0);
      strrllValCar := 'CARTAO:'             + FormatFloat('#,##0.00', 0);
      strrllValChv := 'CHEQUE A VISTA: '    + FormatFloat('#,##0.00', 0);
      strrllValOrd := 'ORDEM DE PGTO: '     + FormatFloat('#,##0.00', 0);
      strrllValChp := 'CHEQUE-PRE: '        + FormatFloat('#,##0.00', 0);
      strrllValCre := 'CREDITO UTILIZADO: ' + FormatFloat('#,##0.00', 0);
      strrllBaiEmp := '';
      strrllBaiPor := '';
      strrllBaiOp  := '';
      strrllBaiHis := '';

      LDin := 0;
      LCar := 0;
      LChp := 0;
      LChv := 0;
      LOrd := 0;
      LCre := 0;
    end;
  finally
    FreeAndNil(qryFormaPagto);
  end;
  {Adicionando as vari·veis}
  FDicVar.AddOrSetValue('rllValDin',strrllValDin);
  FDicVar.AddOrSetValue('rllValCar',strrllValCar);
  FDicVar.AddOrSetValue('rllValChv',strrllValChv);
  FDicVar.AddOrSetValue('rllValOrd',strrllValOrd);
  FDicVar.AddOrSetValue('rllValChp',strrllValChp);
  FDicVar.AddOrSetValue('rllValCre',strrllValCre);
  FDicVar.AddOrSetValue('rllBaiEmp',IIF(strTipFil = 'M',fRemoveAcento(strrllBaiEmp),strrllBaiEmp));
  FDicVar.AddOrSetValue('rllBaiPor',IIF(strTipFil = 'M',fRemoveAcento(strrllBaiPor),strrllBaiPor));
  FDicVar.AddOrSetValue('rllBaiOp',IIF(strTipFil  = 'M',fRemoveAcento(strrllBaiOp),strrllBaiOp));
  FDicVar.AddOrSetValue('rllBaiHis',IIF(strTipFil = 'M',fRemoveAcento(strrllBaiHis),strrllBaiHis));

  LFormaPagamento := '';

  if LDin <> 0 then
    LFormaPagamento := LFormaPagamento + 'Dinheiro: R$ ' + FormatFloat('#,##0.00', LDin) + sLineBreak;

  if LCar <> 0 then
    LFormaPagamento := LFormaPagamento + 'Cart„o: R$ ' + FormatFloat('#,##0.00', LCar) + sLineBreak;

  if LChp <> 0 then
    LFormaPagamento := LFormaPagamento + 'Cheque PrÈ: R$ ' + FormatFloat('#,##0.00', LChp) + sLineBreak;

  if LChv <> 0 then
    LFormaPagamento := LFormaPagamento + 'Cheque Vista: R$ ' + FormatFloat('#,##0.00', LChv) + sLineBreak;

  if LOrd <> 0 then
    LFormaPagamento := LFormaPagamento + 'Ordem Pagto: R$ ' + FormatFloat('#,##0.00', LOrd) + sLineBreak;

  if LCre <> 0 then
    LFormaPagamento := LFormaPagamento + 'CrÈdito: R$ ' + FormatFloat('#,##0.00', LCre) + sLineBreak;

  if LFormaPagamento.EndsWith(sLineBreak) then
    Delete(LFormaPagamento,
      Length(LFormaPagamento) - Length(sLineBreak) + 1,
      Length(sLineBreak));

  FDicVar.AddOrSetValue('DESFPG',
  IIF(strTipFil = 'M',
      fRemoveAcento(UpperCase(LFormaPagamento)),
      UpperCase(LFormaPagamento)));
end;





end.
