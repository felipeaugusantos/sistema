{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{***********************************************JU*}

unit untReciboCtr;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint, Variants;

Type
  TReciboCtr = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadRec: TUniClientDataSet;
      FCadRecCreditoGerado: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FChePre: TUniClientDataSet;
      FCheAvi: TUniClientDataSet;
      FDataSetChePre: TfrxDBDataset;
      FDataSetCheAvi: TfrxDBDataset;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadRec: TfrxDBDataset;
      FDataSetCadRecCreditoGerado: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      FCreditoTroco: String;
      FRecebidoBruto: String;
      FReimpressao: Boolean;
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
      function fMostraTrocoCredito: Boolean;
      function fMostraRecebidoBruto: Boolean;
      function fRetNomPort(strCodPor: String): String;
      function fRetNomeEmp(strCodEmp: String): String;
      function fRetCfgSis(strCamCfg: String): Variant;
      function RetornaDestino(ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;
      function RetornaDataRecebimento(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;
      function RetornaDataRecebimentoReal(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;
      function RetornaDataRecebimentoInterna(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String; ACmpDta: String = 'CTR_DTALOG'): String;
      function RetornaValorMulta(ANumDup, AEspDoc, ACodCli, ACodEmp: String; dtaDtaVen, dtaDtaPag: TDateTime; ASeqCon: Integer): Double;
      function RetornaRestanteDuplicata(ANumDup, AEspDoc, ACodCli, ACodEmp: String; AParcel: String = ''): Double;
      function RetornaValorOriginalBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp: String; ASeqCon: Integer): Double;
      function VerificaSeEhBaixaParcial(ANumDup, AEspDoc, ACodCli, ACodEmp: String): Boolean;
      Function RetornaEspeciesdePagtoDaBaixa(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
      Function RetornaEspeciesdePagtoDaBaixaSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
      Function RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
      function RetornaEspeciesdePagtoDaBaixaQuebraLinha(ASeqCon: Integer; ANumDup, AEspDoc, ACodCli, ACodEmp: String; ASeqBai: Integer): String;
      procedure pCarregaCheques( ATipo, ASeqcon, ACodEmp : String; AcdsChq: TUniClientDataSet );
      Function fVerificaJaIncluido( ACodEmp, ASeqCon : String; AcdsChq: TUniClientDataSet ) : Boolean;
      Function RetornaModalidadesBaixaSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
      Function RetornaCodigoEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, AParcela : String; ASeqBai : Integer): String;
      Function RetornaModalidadesBaixaExibicaoSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp, AParcel : String; ASeqBai : Integer): String;
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
                                 vltCreditoTroco: Double = 0;
                                 vltRecebidoBruto: Double = 0;
                                 cdsReciboCG: TUniClientDataSet = Nil;
                                 AReimpressao: Boolean = False);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      procedure pFiltraCds( strFiltro : String );
      procedure pSetFastType(AType: String);
  end;

  function fCriaClientDatasetReciboCTR: TUniClientDataSet;


  function DuplicataCreditoReferenteATroco(ADuplicata: TDataset): String;

Const
  FILA_IMPRESSAO_RECIBO_CTR = 'impressao_recibo_ctr';

implementation

uses untCfgRel, untValorPorExtenso;

{ TReciboCtr }

constructor TReciboCtr.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadRec := fCriaClientDatasetReciboCTR;
  FCadRecCreditoGerado := fCriaClientDatasetReciboCTR;
  FCreditoTroco := '9,99';
  FRecebidoBruto := '10,99';
  
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
    FieldByName('NOMCON').AsString   := 'CONSUMIDOR FINAL';
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
    FieldByName('RCX_CAIXA').AsString := '';
    FieldByName('TOTCLI').AsFloat        := 256;
    FieldByName('NOMCTA').AsString   := '01.01.001 - Plano de Contas';
    FieldByName('NOMEVE').AsString   := '00001 - Evento';
    FieldByName('CTR_VALCRE').AsFloat := 356.00;
    FieldByName('DESCPORBAI').AsString   := '00005 - PORTADOR DA BAIXA';
    FieldByName('DESCOPEBAI').AsString   := '998 - OPERADOR DA BAIXA';
    FieldByName('DESCHISBAI').AsString  := 'HISTÓRICO DA BAIXA';
    FieldByName('RECPIX').AsString := 'N';
    FieldByName('CTR_SALDO').AsFloat     := 10;
    FieldByName('CTR_TOTBLT').AsFloat  := 1000;
    FieldByName('CTR_TOTCRD').AsFloat  := 250;
    FieldByName('CTR_TOTCHD').AsFloat  := 120;
    FieldByName('DINHEIRO_SEM_BOLETO').AsFloat  := 0;
    FieldByName('VALOR_BOLETO').AsFloat  := 0;
    FieldByName('OPEBAI').AsString  := '998';
    FieldByName('DTABAI').AsDateTime := StrToDateTime('01/10/2023');
    FieldByName('VALRES').AsFloat    := 256;
    FieldByName('GRVORI').AsFloat    := 256;
    FieldByName('DUPLICATA_TROCO').AsString := 'S';
    FieldByName('VALOR_TROCO').AsFloat  := 0;
    FieldByName('EMPBAI').AsString      := VS_strCodEmp;
    FieldByName('PORBAI').AsString      :=  '00005';


    Post;
  End;

  With FCadRecCreditoGerado Do
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
    FieldByName('NOMCON').AsString   := 'CONSUMIDOR FINAL';
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
    FieldByName('TOTCLI').AsFloat        := 256;
    FieldByName('NOMCTA').AsString   := '01.01.001 - Plano de Contas';
    FieldByName('NOMEVE').AsString   := '00001 - Evento';
    FieldByName('CTR_VALCRE').AsFloat := 356.00;
    FieldByName('DESCPORBAI').AsString   := '00005 - PORTADOR DA BAIXA';
    FieldByName('DESCOPEBAI').AsString   := '998 - OPERADOR DA BAIXA';
    FieldByName('DESCHISBAI').AsString  := 'HISTÓRICO DA BAIXA';
    FieldByName('RECPIX').AsString := 'N';
    FieldByName('CTR_SALDO').AsFloat     := 10;
    FieldByName('CTR_TOTBLT').AsFloat  := 1000;
    FieldByName('CTR_TOTCRD').AsFloat  := 250;
    FieldByName('CTR_TOTCHD').AsFloat  := 120;
    FieldByName('DINHEIRO_SEM_BOLETO').AsFloat  := 0;
    FieldByName('VALOR_BOLETO').AsFloat  := 0;
    FieldByName('OPEBAI').AsString  := '998';
    FieldByName('DTABAI').AsDateTime := StrToDateTime('01/10/2023');
    FieldByName('DUPLICATA_TROCO').AsString := 'S';
    FieldByName('VALOR_TROCO').AsFloat  := 0;

    Post;
  End;

  pIniciaObjetos;
end;

constructor TReciboCtr.CreateInstance(cdsRecibo: TUniClientDataSet;
                                      vltCreditoTroco: Double = 0;
                                      vltRecebidoBruto: Double = 0;
                                      cdsReciboCG: TUniClientDataSet = Nil;
                                      AReimpressao: Boolean = False);
begin
  FModoDesigner := False;
  FCadRec        := TUniClientDataSet.Create(Nil);
  FCadRec.Data   := cdsRecibo.Data;

  If Assigned(cdsReciboCG) Then
  Begin
    FCadRecCreditoGerado        := TUniClientDataSet.Create(Nil);
    FCadRecCreditoGerado.Data   := cdsReciboCG.Data;
  End
  Else
    FCadRecCreditoGerado := fCriaClientDatasetReciboCTR;

  FCreditoTroco  := FormatFloat(fMskDigitos(2), vltCreditoTroco);
  FRecebidoBruto := FormatFloat(fMskDigitos(2), vltRecebidoBruto);
  FReimpressao   := AReimpressao;

  pIniciaObjetos;
end;

procedure TReciboCtr.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadRec := TfrxDBDataset.Create(nil);
  FDataSetCadRec.Name := 'frxDataSetContasReceber';
  FDataSetCadRec.DataSet := FCadRec;

  FDataSetCadRecCreditoGerado := TfrxDBDataset.Create(nil);
  FDataSetCadRecCreditoGerado.Name := 'frxDataSetContasReceberCreditoGerado';
  FDataSetCadRecCreditoGerado.DataSet := FCadRecCreditoGerado;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  FChePre := fCriaCdsCheques(nil);
  FDataSetChePre := TfrxDBDataset.Create(nil);
  FDataSetChePre.Name := 'frxDataSetChePre';
  FDataSetChePre.DataSet := FChePre;

  FCheAvi := fCriaCdsCheques(nil);
  FDataSetCheAvi := TfrxDBDataSet.Create(nil);
  FDataSetCheAvi.Name := 'frxDataSetCheAvi';
  FDataSetCheAvi.DataSet := FCheAvi;
  FDataSetCheAvi.First;

  SetLength(FArrDBDataSet, 5);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadRec;
  FArrDBDataSet[2] := FDataSetCadRecCreditoGerado;
  FArrDBDataSet[3] := FDataSetChePre;
  FArrDBDataSet[4] := FDataSetCheAvi;

  pDefineFilaImpressao(False);
end;

procedure TReciboCtr.pSetFastType(AType: String);
begin
  FTipImp := AType;
end;

function TReciboCtr.RetornaDataRecebimentoInterna(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String; ACmpDta: String = 'CTR_DTALOG'): String;
  Var
    LCadRec : TUniQuery;
    LSql: String;
begin
  Result := '';

  Try
    LSql := 'SELECT                                         '+
            '  CONCAT(                                      '+
            '    DATE_FORMAT(' + ACmpDta + ', "%d/%m/%Y"),  '+
            '    " - ",                                     '+
            '    CTR_HORLOG                                 '+
            '  ) AS DATA_RECEBIMENTO                        '+
            'FROM                                           '+
            '  CADREC R                                     '+
            '  LEFT JOIN LOGCTR HROBAI                      '+
            '     ON HROBAI.CTR_NUMDUP = R.CTR_NUMDUP       '+
            '    AND HROBAI.CTR_PARCEL = R.CTR_PARCEL       '+
            '    AND HROBAI.CTR_ESPDOC = R.CTR_ESPDOC       '+
            '    AND HROBAI.CTR_CODEMP = R.CTR_CODEMP       '+
            '    AND HROBAI.CTR_SEQBAI = R.CTR_SEQBAI       '+
            '    AND HROBAI.CTR_SEQCON = R.CTR_SEQCON       '+
            '    AND HROBAI.CTR_EMPBAI = R.CTR_EMPBAI       '+
            '    AND HROBAI.CTR_SEQCON = R.CTR_SEQCON       '+
            'WHERE R.CTR_SEQCON = :SEQCON                   '+
            '  AND R.CTR_NUMDUP = :NUMDUP                   '+
            '  AND R.CTR_ESPDOC = :ESPDOC                   '+
            '  AND R.CTR_CODCLI = :CODCLI                   '+
            '  AND CTR_DESCRI LIKE "%BAIXA%"                ';

    Try
      LCadRec := fCriaQuery(Nil);
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);

      LCadRec.ParamByName('SEQCON').AsInteger := ASeqCon;
      LCadRec.ParamByName('NUMDUP').AsString  := ANumDup;
      LCadRec.ParamByName('ESPDOC').AsString  := AEspDoc;
      LCadRec.ParamByName('CODCLI').AsString  := ACodCli;

      LCadRec.Open;
      Result:= LCadRec.FieldByName('DATA_RECEBIMENTO').AsString;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LCadRec);
  End;

end;

function TReciboCtr.RetornaDataRecebimento(ASeqCon: Integer; ANumDup,
  AEspDoc, ACodCli, ACodEmp: String): String;
begin
  Result := RetornaDataRecebimentoInterna(ASeqCon,
                                          ANumDup,
                                          AEspDoc,
                                          ACodCli,
                                          ACodEmp,
                                          'CTR_DTALOG');
end;

function TReciboCtr.RetornaDataRecebimentoReal(ASeqCon: Integer; ANumDup,
  AEspDoc, ACodCli, ACodEmp: String): String;
begin
  Result := RetornaDataRecebimentoInterna(ASeqCon,
                                          ANumDup,
                                          AEspDoc,
                                          ACodCli,
                                          ACodEmp,
                                          'HROBAI.CTR_DTAREC');
end;

function TReciboCtr.RetornaDestino(ANumDup, AEspDoc, ACodCli,
  ACodEmp: String): String;
  Var
    AFatGor : TUniQuery;
    LSql: String;
begin


  Try
    LSql := 'SELECT                                                              '+
            '  GROUP_CONCAT(DISTINCT CONCAT(EXTDOR.FDO_ENTRET,                   '+
            '  IF(IFNULL(EXTDOR.FDO_LOCRET, "") = ""                             '+
            '        AND EXTDOR.FDO_ENTRET = "R","",                             '+
            '        CONCAT( ".",                                                '+
            '          IF(EXTDOR.FDO_ENTRET = "R",                               '+
            '             EXTDOR.FDO_LOCRET,                                     '+
            '          IF(FATDOR.FDO_ENTFUT = "S", "F", "I")))))) DESTINO        '+
            'FROM                                                                '+
            '  FATDOR                                                            '+
            '  JOIN EXTDOR                                                       '+
            '    ON AUTOINCREM = FDO_SEQFDO                                      '+
            'WHERE FDO_NUMFAT = :NUMDUP                                          '+
            '  AND FDO_TIPFAT = :ESPDOC                                          '+
            '  AND FDO_CODCLI = :CODCLI                                          '+
            '  AND FDO_EMPFAT = :CODEMP                                          '+
            'GROUP BY FDO_SEQGER                                                 ';

    Try
      AFatGor := fCriaQuery(Nil);
      AFatGor.Close;
      AFatGor.Sql.Clear;
      AFatGor.Sql.Add(LSql);

      AFatGor.ParamByName('NUMDUP').AsString := ANumDup;
      AFatGor.ParamByName('ESPDOC').AsString := AEspDoc;
      AFatGor.ParamByName('CODCLI').AsString := ACodCli;
      AFatGor.ParamByName('CODEMP').AsString := ACodEmp;

      AFatGor.Open;
      Result:= AFatGor.FieldByName('DESTINO').AsString;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AFatGor);
  End;

end;

function TReciboCtr.RetornaModalidadesBaixaSemTroco(ASeqCon: Integer;
  ANumDup, AEspDoc, ACodCli, ACodEmp: String; ASeqBai: Integer): String;
Var
  LConsulta : TUniQuery;
  LModalidade,
  LEmpBai : String;
Begin
  Result := '';
  LModalidade := '';
  LEmpBai := RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, ASeqBai);
  LConsulta := fCriaQuery(Nil);
  Try
    LConsulta.Sql.Text :=
      'SELECT                                                                      '+
      '  CTR_SEQCON,                                                               '+
      '  SUM(                                                                      '+
      '  IF(                                                                       '+
      '    (SELECT                                                                 '+
      '      AUTOINCREM                                                            '+
      '    FROM                                                                    '+
      '      LOGCTR                                                                '+
      '    WHERE LOGCTR.CTR_NUMDUP = CADREC.CTR_NUMDUP                             '+
      '      AND LOGCTR.CTR_PARCEL = CADREC.CTR_PARCEL                             '+
      '      AND LOGCTR.CTR_ESPDOC = CADREC.CTR_ESPDOC                             '+
      '      AND LOGCTR.CTR_CODEMP = CADREC.CTR_CODEMP                             '+
      '      AND LOGCTR.CTR_CODCLI = CADREC.CTR_CODCLI                             '+
      '      AND LOGCTR.CTR_SEQBAI = 0                                             '+
      '      AND LOGCTR.CTR_DTAREC IS NOT NULL                                     '+
      '      AND LOGCTR.CTR_SEQCON = CADREC.CTR_SEQCON                             '+
      '      AND LOGCTR.CTR_DTABAI = CADREC.CTR_DTABAI                             '+
      '      AND LOGCTR.CTR_EMPBAI = CADREC.CTR_EMPBAI                             '+
      '      AND LOGCTR.CTR_VALREC < 0                                             '+
      '      AND LOGCTR.CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD")) IS NULL,        '+
      '    CTR_DINHEI,                                                             '+
      '    0                                                                       '+
      '  )                                                                         '+
      ') DINHEIRO,                                                                 '+
      '  SUM(CTR_CHQAVI) CHQAVI,                                                   '+
      '  SUM(CTR_CHQPRE) CHQPRE,                                                   '+
      '  SUM(CTR_CARTAO) CARTAO,                                                   '+
      '  SUM(CTR_ORDPAG) ORDPAG                                                    '+
      '  FROM                        '+
      '    CADREC                    '+
      ' WHERE CTR_SEQCON = :SEQCON   '+
      '   AND CTR_EMPBAI = :EMPBAI   '+
      ' GROUP BY CTR_SEQCON          ';

    LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
    LConsulta.ParamByName('EMPBAI').AsString  := LEmpBai;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If LConsulta.FieldByName('DINHEIRO').AsFloat > 0.00 Then
        LModalidade := 'Dinheiro: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('DINHEIRO').AsFloat);
      If LConsulta.FieldByName('CHQAVI').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Chq. Vista: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQAVI').AsFloat);
      If LConsulta.FieldByName('CHQPRE').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Chq. Prazo: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQPRE').AsFloat);
      If LConsulta.FieldByName('CARTAO').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Cartão: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CARTAO').AsFloat);
      If LConsulta.FieldByName('ORDPAG').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Ordem Pagto.: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('ORDPAG').AsFloat);
    End;

    Result:= LModalidade;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

Function TReciboCtr.RetornaCodigoEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, AParcela : String; ASeqBai : Integer): string;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
Begin

  Try
    LSql := 'SELECT CTR_EMPBAI             '+
            '  FROM CADREC                 '+
            ' WHERE CTR_NUMDUP = :NUMDUP   '+
            '   AND CTR_ESPDOC = :ESPDOC   '+
            '   AND CTR_CODCLI = :CODCLI   '+
            '   AND CTR_CODEMP = :CODEMP   '+
            '   AND CTR_PARCEL = :PARCEL   '+
            '   AND CTR_SEQBAI = :SEQBAI   ';
    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);

      AQryCtr.ParamByName('NUMDUP').AsString := ANumDup;
      AQryCtr.ParamByName('ESPDOC').AsString := AEspDoc;
      AQryCtr.ParamByName('CODCLI').AsString := ACodCli;
      AQryCtr.ParamByName('CODEMP').AsString := ACodEmp;
      AQryCtr.ParamByName('PARCEL').AsString := AParcela;
      AQryCtr.ParamByName('SEQBAI').AsInteger := ASeqBai;

      AQryCtr.Open;
      If Not AQryCtr.IsEmpty Then
         Result := AQryCtr.FieldByName('CTR_EMPBAI').AsString;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

function TReciboCtr.RetornaModalidadesBaixaExibicaoSemTroco(ASeqCon: Integer;
  ANumDup, AEspDoc, ACodCli, ACodEmp, AParcel: String; ASeqBai: Integer): String;
Var
  LConsulta : TUniQuery;
  LModalidade,
  LEmpBai : String;
Begin
  Result := '';
  LModalidade := '';
  LEmpBai := RetornaCodigoEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, AParcel, ASeqBai);
  LConsulta := fCriaQuery(Nil);
  Try
    LConsulta.Sql.Text :=
      'SELECT '+
      '  CADREC.CTR_SEQCON, LOGCTR.AUTOINCREM, '+
      '  SUM(IF(LOGCTR.AUTOINCREM IS NULL,CADREC.CTR_DINHEI, 0)) DINHEIRO, '+
      '  SUM(IF(LOGCTR.AUTOINCREM IS NULL,CADREC.CTR_CHQAVI, 0)) CHQAVI, '+
      '  SUM(IF(LOGCTR.AUTOINCREM IS NULL,CADREC.CTR_CHQPRE, 0)) CHQPRE, '+
      '  SUM(IF(LOGCTR.AUTOINCREM IS NULL,CADREC.CTR_CARTAO, 0)) CARTAO, '+
      '  SUM(IF(LOGCTR.AUTOINCREM IS NULL,CADREC.CTR_ORDPAG, 0)) ORDPAG '+
      'FROM     '+
      '  CADREC '+
      '  LEFT JOIN LOGCTR '+
      '    ON LOGCTR.CTR_NUMDUP = CADREC.CTR_NUMDUP  '+
      '    AND LOGCTR.CTR_PARCEL = CADREC.CTR_PARCEL '+
      '    AND LOGCTR.CTR_ESPDOC = CADREC.CTR_ESPDOC '+
      '    AND LOGCTR.CTR_CODEMP = CADREC.CTR_CODEMP '+
      '    AND LOGCTR.CTR_CODCLI = CADREC.CTR_CODCLI '+
      '    AND LOGCTR.CTR_SEQBAI = 0                 '+
      '    AND LOGCTR.CTR_DTAREC IS NOT NULL         '+
      '    AND LOGCTR.CTR_SEQCON = CADREC.CTR_SEQCON '+
      '    AND LOGCTR.CTR_DTABAI = CADREC.CTR_DTABAI '+
      '    AND LOGCTR.CTR_EMPBAI = CADREC.CTR_EMPBAI '+
      '    AND LOGCTR.CTR_VALREC < 0                 '+
      '    AND LOGCTR.CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD") '+
      'WHERE CADREC.CTR_SEQCON = :SEQCON                        '+
      '  AND CADREC.CTR_EMPBAI = :EMPBAI                        '+
      'GROUP BY CADREC.CTR_SEQCON                               ';

      LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
      LConsulta.ParamByName('EMPBAI').AsString  := LEmpBai;
      LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If LConsulta.FieldByName('DINHEIRO').AsFloat > 0.00 Then
        LModalidade := 'Dinheiro: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('DINHEIRO').AsFloat);
      If LConsulta.FieldByName('CHQAVI').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Chq. Vista: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQAVI').AsFloat);
      If LConsulta.FieldByName('CHQPRE').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Chq. Prazo: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQPRE').AsFloat);
      If LConsulta.FieldByName('CARTAO').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Cartão: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CARTAO').AsFloat);
      If LConsulta.FieldByName('ORDPAG').AsFloat > 0.00 Then
        LModalidade := IIF(LModalidade <> '', LModalidade + #13, LModalidade) + 'Ordem Pagto.: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('ORDPAG').AsFloat);
    End;

    Result:= LModalidade;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

destructor TReciboCtr.Destroy;
begin
  FreeAndNil(FCadRec);
  FreeAndNil(FDataSetCadRec);
  FreeAndNil(FCadRecCreditoGerado);
  FreeAndNil(FDataSetCadRecCreditoGerado);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  FreeAndNil(FDataSetChePre);
  FreeAndNil(FDataSetCheAvi);
  FreeAndNil(FChePre);
  FreeAndNil(FCheAvi);
  inherited;
end;

procedure TReciboCtr.pCarregaListaFuncoes;
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
  FListaFuncoes.Add('function fMostraTrocoCredito: Boolean;');
  FListaFuncoes.Add('function fMostraRecebidoBruto: Boolean;');

  FListaFuncoes.Add('function fRetNomPort(strCodPor: String): String;');
  FListaFuncoes.Add('function fRetNomeEmp(strCodEmp: String): String;');
  FListaFuncoes.Add('function fRetCfgSis(strCamCfg: String): Variant;');
  FListaFuncoes.Add('function RetornaDestino(ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;');
  FListaFuncoes.Add('function RetornaDataRecebimento(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;');
  FListaFuncoes.Add('function RetornaDataRecebimentoReal(ASeqCon:Integer;ANumDup,AEspDoc,ACodCli,ACodEmp: String): String;');
  FListaFuncoes.Add('function RetornaValorMulta(ANumDup,AEspDoc,ACodCli,ACodEmp: String; dtaDtaVen, dtaDtaPag: TDateTime; ASeqCon: Integer): Double;');
  FListaFuncoes.Add('function RetornaRestanteDuplicata(ANumDup,AEspDoc,ACodCli,ACodEmp: String; AParcel: String = ''''): Double;');
  FListaFuncoes.Add('function RetornaValorOriginalBaixa(ANumDup,AEspDoc,ACodCli,ACodEmp: String; ASeqCon: Integer): Double;');
  FListaFuncoes.Add('Function RetornaEspeciesdePagtoDaBaixa(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;');
  FListaFuncoes.Add('Function RetornaEspeciesdePagtoDaBaixaQuebraLinha(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;');
  FListaFuncoes.Add('Function RetornaEspeciesdePagtoDaBaixaSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;');
  FListaFuncoes.Add('Function RetornaModalidadesBaixaSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;');
  FListaFuncoes.Add('Function RetornaModalidadesBaixaExibicaoSemTroco(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp, AParcel : String; ASeqBai : Integer): String;');
end;

procedure TReciboCtr.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TReciboCtr.pFiltraCds( strFiltro : String );
Begin

   With FCadRec Do
   Begin
     Filtered := False;
     Filter   := strFiltro;
     Filtered := True;
   End;

End;

procedure TReciboCtr.pDefineFilaImpressao(blnConfigurar: Boolean);
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

function TReciboCtr.fOnUserFunctionEvent(
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

  If SameText(MethodName, 'fMostraTrocoCredito') Then
    Result := fMostraTrocoCredito;

  If SameText(MethodName, 'fMostraRecebidoBruto') Then
    Result := fMostraRecebidoBruto;

  If SameText(MethodName, 'fRetNomPort') Then
    Result := fRetNomPort(Params[0]);

  If SameText(MethodName, 'fRetNomeEmp') Then
    Result := fRetNomeEmp(Params[0]);

  If SameText(MethodName, 'fRetCfgSis') Then
    Result := fCfgSis(Params[0]);

  If SameText(MethodName, 'RetornaDestino') Then
    Result := RetornaDestino(Params[0],Params[1],Params[2],Params[3]);

  If SameText(MethodName, 'RetornaDataRecebimento') Then
    Result := RetornaDataRecebimento(Params[0],Params[1],Params[2],Params[3],Params[4]);

  If SameText(MethodName, 'RetornaDataRecebimentoReal') Then
    Result := RetornaDataRecebimentoReal(Params[0],Params[1],Params[2],Params[3],Params[4]);

  If SameText(MethodName, 'RetornaValorMulta') Then
    Result := RetornaValorMulta(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5], Params[6]);

  If SameText(MethodName, 'RetornaRestanteDuplicata') Then
    Result := RetornaRestanteDuplicata(Params[0],Params[1],Params[2],Params[3], Params[4]);

  If SameText(MethodName, 'RetornaValorOriginalBaixa') Then
    Result := RetornaValorOriginalBaixa(Params[0],Params[1],Params[2],Params[3],Params[4]);

  If SameText(MethodName, 'RetornaEspeciesdePagtoDaBaixa') Then
    Result := RetornaEspeciesdePagtoDaBaixa(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5]);

  If SameText(MethodName, 'RetornaEspeciesdePagtoDaBaixaQuebraLinha') Then
    Result := RetornaEspeciesdePagtoDaBaixaQuebraLinha(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5]);

  If SameText(MethodName, 'RetornaEspeciesdePagtoDaBaixaSemTroco') Then
    Result := RetornaEspeciesdePagtoDaBaixaSemTroco(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5]);

  If SameText(MethodName, 'RetornaModalidadesBaixaSemTroco') Then
    Result := RetornaModalidadesBaixaSemTroco(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5]);

  If SameText(MethodName, 'RetornaModalidadesBaixaExibicaoSemTroco') Then
    Result := RetornaModalidadesBaixaExibicaoSemTroco(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5],Params[6]);
end;

function TReciboCtr.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TReciboCtr.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TReciboCtr.fGetDescricao(strSeqCon: String): String;
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

function TReciboCtr.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TReciboCtr.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TReciboCtr.fGetIsEmpty: Boolean;
begin
  Result := FCadRec.IsEmpty;
end;

function TReciboCtr.fGetKey: String;
begin
  Result := 'RECCTR';
end;

function TReciboCtr.fGetName: String;
begin
  Result := 'RECIBO CONTAS A RECEBER';
end;

function TReciboCtr.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TReciboCtr.fGetTotalRecebido(intSeqCon: Integer): Double;
begin
  Result := IfNull(FDicTot[IntToStr(intSeqCon)], 0);
end;

function TReciboCtr.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TReciboCtr.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TReciboCtr.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TReciboCtr.fMostraTrocoCredito: Boolean;
begin
  if FModoDesigner then
    result := True
  else
  begin
    if StrToFloatDef(FCreditoTroco, 0) = 0 then
      result := False
    else
      result := True;
  end;
end;

function TReciboCtr.fMostraRecebidoBruto: Boolean;
begin
  { Atualmente mostrar credito e troco devem ser
    mostrados/ocultados juntos req 166845}
  result := fMostraTrocoCredito;
end;

function TReciboCtr.fPrepareDataSetsAndVariables: Boolean;
  Var
    fltTotalRecebido,
    fltValorTotal,
    LValorTrocoCC,
    LValorRecebidoSemTrocoCC: Double;
    strCfg_INFREC : string;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
    FDicVar.AddOrSetValue('fltTotalRecebido', fltTotalRecebido);
    FDicVar.AddOrSetValue('fltCreditoTroco', FCreditoTroco);
    FDicVar.AddOrSetValue('fltRecebidoBruto', FRecebidoBruto);
    FDicVar.AddOrSetValue('fltValorTrocoCC', LValorTrocoCC);
    FDicVar.AddOrSetValue('fltTotalRecebidoSemTrocoCC', LValorRecebidoSemTrocoCC);
    FDicVar.AddOrSetValue('REIMPRESSAO', FReimpressao);
    FDicVar.AddOrSetValue('fltValorTotal', fltValorTotal);
    FDicVar.AddOrSetValue('strCfg_INFREC', strCfg_INFREC );
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

    If Not fVerificaJaIncluido(FCadRec.FieldByName('CODEMP').AsString,
                               FCadRec.FieldByName('SEQCON').AsString, FChePre ) Then
    begin
      pCarregaCheques('P', FCadRec.FieldByName('SEQCON').AsString, FCadRec.FieldByName('CODEMP').AsString, FChePre);
      FChePre.First;
    end;

    If Not fVerificaJaIncluido(FCadRec.FieldByName('CODEMP').AsString,
                               FCadRec.FieldByName('SEQCON').AsString, FCheAvi ) Then
    begin
      pCarregaCheques('V', FCadRec.FieldByName('SEQCON').AsString, FCadRec.FieldByName('CODEMP').AsString, FCheAvi);
      FCheAvi.First;
    end;

    fltTotalRecebido := fltTotalRecebido + FCadRec.FieldByName('VALREC').AsFloat;
    fltValorTotal    := fltValorTotal    + FCadRec.FieldByName('VALDOC').AsFloat;
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

  strCfg_INFREC := fCfgSis('INFREC');
  Result := Not FCadRec.IsEmpty;

  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;

end;

function TReciboCtr.fRetNomOpe(strCodOpe: String): String;
begin
  Result := fRetNomVendRep(strCodOpe);
end;

function TReciboCtr.fRetNomPort(strCodPor: String): String;
begin
  Result := fRetNomPortador(strCodPor);
end;

function TReciboCtr.fRetNomeEmp(strCodEmp: String): String;
begin
  Result := fRetNomeEmpresa(strCodEmp);
end;

function TReciboCtr.fRetCfgSis(strCamCfg: String): Variant;
begin
  Result := fRetCfgSis(strCamCfg);
end;

function TReciboCtr.fRetornaReceberAbertoInterna(strCodCli: String): String;
begin
  Result := FormatFloat('R$ ###,###,##0.00', fRetornaReceberAberto(strCodCli));
end;

function fCriaClientDatasetReciboCTR: TUniClientDataSet;
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
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMCON';
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
    Name     := 'PORBAI';
    DataType := ftString;
    Size     := 005;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCPORBAI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCOPEBAI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCHISBAI';
    DataType := ftString;
    Size     := 100;
  end;


  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'TOTCLI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMCTA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMEVE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALCRE';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMPBAI';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RESCAI';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RECPIX';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_SALDO';
    DataType := ftFloat;
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

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DINHEIRO_SEM_BOLETO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALOR_BOLETO';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTABAI';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALRES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'GRVORI';
    DataType := ftFloat;
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

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESFPG';
    DataType := ftString;
    Size     := 500;
  end;

  Result.CreateDataSet;

end;

function TReciboCtr.RetornaValorMulta(ANumDup, AEspDoc, ACodCli, ACodEmp: String; dtaDtaVen, dtaDtaPag : TDateTime; ASeqCon : Integer): Double;
  Var
    fValDup :Double;
    fltDiaAtraso: Double;
    intTolerancia : Integer;
    fltPerMul : Double;
begin

  Result    := 0.0;

  fValDup := RetornaValorOriginalBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, ASeqCon);

  If fValDup > 0 Then
  Begin

    intTolerancia := fCfgSis('TOLATR', varInteger);
    fltPerMul     := fCfgSis('MULATR', varDouble);

    fltDiaAtraso := dtaDtaPag - dtaDtaVen;

    If (dtaDtaVen < dtaDtaPag) And (fltDiaAtraso > intTolerancia) Then
    Begin
      Result := 0;

      If fltPerMul > 0 Then
         Result := Result + fValDup * (fltPerMul / 100);

      Result := fFormataFloat(Result, 2);
    End;

  End;

end;

Function TReciboCtr.RetornaRestanteDuplicata(ANumDup, AEspDoc, ACodCli, ACodEmp: String; AParcel: String): Double;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
Begin

  Result := 0.0;

  Try
    LSql := 'SELECT                      '+
            '  CTR_VALDUP                '+
            ' FROM                       '+
            '  CADREC                    '+
            ' WHERE CTR_NUMDUP = :NUMDUP '+
            '   AND CTR_ESPDOC = :ESPDOC '+
            '   AND CTR_CODCLI = :CODCLI '+
            '   AND CTR_CODEMP = :CODEMP '+
            '   AND CTR_SEQBAI = 0       ';

    If (Not fEmptyStr(AParcel)) Then
      LSql := LSql + '   AND CTR_PARCEL = :PARCEL ';

    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);

      AQryCtr.ParamByName('NUMDUP').AsString := ANumDup;
      AQryCtr.ParamByName('ESPDOC').AsString := AEspDoc;
      AQryCtr.ParamByName('CODCLI').AsString := ACodCli;
      AQryCtr.ParamByName('CODEMP').AsString := ACodEmp;

      If (Not fEmptyStr(AParcel)) Then
        AQryCtr.ParamByName('PARCEL').AsString := AParcel;

      AQryCtr.Open;
      Result:= AQryCtr.FieldByName('CTR_VALDUP').AsFloat;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

Function TReciboCtr.VerificaSeEhBaixaParcial(ANumDup, AEspDoc, ACodCli, ACodEmp: String): Boolean;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
Begin

  Result := False;

  Try
    LSql := 'SELECT                      '+
            '  CTR_SEQBAI                '+
            ' FROM                       '+
            '  CADREC                    '+
            ' WHERE CTR_NUMDUP = :NUMDUP '+
            '   AND CTR_ESPDOC = :ESPDOC '+
            '   AND CTR_CODCLI = :CODCLI '+
            '   AND CTR_CODEMP = :CODEMP '+
            '   AND CTR_SEQBAI > 0       ';
    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);

      AQryCtr.ParamByName('NUMDUP').AsString := ANumDup;
      AQryCtr.ParamByName('ESPDOC').AsString := AEspDoc;
      AQryCtr.ParamByName('CODCLI').AsString := ACodCli;
      AQryCtr.ParamByName('CODEMP').AsString := ACodEmp;

      AQryCtr.Open;
      Result:= Not AQryCtr.IsEmpty;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

Function TReciboCtr.RetornaValorOriginalBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp: String; ASeqCon: Integer): Double;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
    blnEhBxParcial : Boolean;
Begin

  Result := 0.0;

  blnEhBxParcial := VerificaSeEhBaixaParcial(ANumDup, AEspDoc, ACodCli, ACodEmp);

  Try

    If Not blnEhBxParcial Then
    Begin
      LSql := 'SELECT '+
              ' (CTR_VALORI - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_VALCOB, 0)) AS VALDUP '+
              '  FROM CADREC                 '+
              ' WHERE CTR_NUMDUP = :NUMDUP   '+
              '   AND CTR_ESPDOC = :ESPDOC   '+
              '   AND CTR_CODCLI = :CODCLI   '+
              '   AND CTR_CODEMP = :CODEMP   '+
              '   AND CTR_SEQBAI = 0 ';
    End
    Else
    Begin
      LSql := 'SELECT '+
              ' CTR_VALREC AS VALDUP '+
              '  FROM CADREC                 '+
              ' WHERE CTR_NUMDUP = :NUMDUP   '+
              '   AND CTR_ESPDOC = :ESPDOC   '+
              '   AND CTR_CODCLI = :CODCLI   '+
              '   AND CTR_CODEMP = :CODEMP   '+
              '   AND CTR_SEQCON = :SEQCON   ';
    End;

    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);

      AQryCtr.ParamByName('NUMDUP').AsString := ANumDup;
      AQryCtr.ParamByName('ESPDOC').AsString := AEspDoc;
      AQryCtr.ParamByName('CODCLI').AsString := ACodCli;
      AQryCtr.ParamByName('CODEMP').AsString := ACodEmp;

      If blnEhBxParcial Then
         AQryCtr.ParamByName('SEQCON').AsInteger := ASeqCon;

      AQryCtr.Open;
      Result:= AQryCtr.FieldByName('VALDUP').AsFloat;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

Function TReciboCtr.RetornaEspeciesdePagtoDaBaixa(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
  Var
    LConsulta : TUniQuery;
    LSql: String;
    LEspeciesPagto,
    LEmpresaBaixa : String;
Begin

  Result := '';
  LEspeciesPagto := '';

  LEmpresaBaixa := RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, ASeqBai);

  Try

    LSql := 'SELECT'+
            '  CTR_SEQCON,'+
            '  SUM(CTR_DINHEI) DINHEIRO,'+
            '  SUM(CTR_CHQAVI) CHQAVI,'+
            '  SUM(CTR_CHQPRE) CHQPRE,'+
            '  SUM(CTR_CARTAO) CARTAO,'+
            '  SUM(CTR_ORDPAG) ORDPAG '+
            ' FROM'+
            '  CADREC '+
            ' WHERE CTR_SEQCON = :SEQCON '+
            '  AND CTR_EMPBAI = :EMPBAI '+
            ' GROUP BY CTR_SEQCON;';

    Try
      LConsulta := fCriaQuery(Nil);
      LConsulta.Close;
      LConsulta.Sql.Clear;
      LConsulta.Sql.Add(LSql);
      LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
      LConsulta.ParamByName('EMPBAI').AsString  := LEmpresaBaixa;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
         If LConsulta.FieldByName('DINHEIRO').AsFloat > 0.00 Then
            LEspeciesPagto := 'Dinheiro: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('DINHEIRO').AsFloat);
         If LConsulta.FieldByName('CHQAVI').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + 'Chq. Vista: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQAVI').AsFloat);
         If LConsulta.FieldByName('CHQPRE').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + 'Chq. Prazo: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQPRE').AsFloat);
         If LConsulta.FieldByName('CARTAO').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + 'Cartão: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CARTAO').AsFloat);
         If LConsulta.FieldByName('ORDPAG').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + 'Ordem Pagto.: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('ORDPAG').AsFloat);
      End;

      Result:= LEspeciesPagto;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;

End;

function TReciboCtr.RetornaEspeciesdePagtoDaBaixaSemTroco(ASeqCon: Integer;
  ANumDup, AEspDoc, ACodCli, ACodEmp: String; ASeqBai: Integer): String;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
    strEsp,
    strEmpBai : String;
Begin

  Result := '';
  strEsp := '';

  strEmpBai := RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, ASeqBai);

  Try

    LSql := 'SELECT                                                                      '+
            '  CTR_SEQCON,                                                               '+
            '  SUM(                                                                      '+
            '  IF(                                                                       '+
            '    (SELECT                                                                 '+
            '      AUTOINCREM                                                            '+
            '    FROM                                                                    '+
            '      LOGCTR                                                                '+
            '    WHERE LOGCTR.CTR_NUMDUP = CADREC.CTR_NUMDUP                             '+
            '      AND LOGCTR.CTR_PARCEL = CADREC.CTR_PARCEL                             '+
            '      AND LOGCTR.CTR_ESPDOC = CADREC.CTR_ESPDOC                             '+
            '      AND LOGCTR.CTR_CODEMP = CADREC.CTR_CODEMP                             '+
            '      AND LOGCTR.CTR_CODCLI = CADREC.CTR_CODCLI                             '+
            '      AND LOGCTR.CTR_SEQBAI = 0                                             '+
            '      AND LOGCTR.CTR_DTAREC IS NOT NULL                                     '+
            '      AND LOGCTR.CTR_SEQCON = CADREC.CTR_SEQCON                             '+
            '      AND LOGCTR.CTR_DTABAI = CADREC.CTR_DTABAI                             '+
            '      AND LOGCTR.CTR_EMPBAI = CADREC.CTR_EMPBAI                             '+
            '      AND LOGCTR.CTR_VALREC < 0                                             '+
            '      AND LOGCTR.CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD")) IS NOT NULL,    '+
            '    CTR_DINHEI * - 1,                                                       '+
            '    CTR_DINHEI                                                              '+
            '  )                                                                         '+
            ') DINHEIRO,                                                                 '+
            '  SUM(CTR_CHQAVI) CHQAVI,                                                   '+
            '  SUM(CTR_CHQPRE) CHQPRE,                                                   '+
            '  SUM(CTR_CARTAO) CARTAO,                                                   '+
            '  SUM(CTR_ORDPAG) ORDPAG                                                    '+
            '  FROM                        '+
            '    CADREC                    '+
            ' WHERE CTR_SEQCON = :SEQCON   '+
            '   AND CTR_EMPBAI = :EMPBAI   '+
            ' GROUP BY CTR_SEQCON          ';

    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);
      AQryCtr.ParamByName('SEQCON').AsInteger := ASeqCon;
      AQryCtr.ParamByName('EMPBAI').AsString  := strEmpBai;
      AQryCtr.Open;

      If Not Aqryctr.IsEmpty Then
      Begin
         If AQryCtr.FieldByName('DINHEIRO').AsFloat > 0.00 Then
            strEsp := 'Dinheiro: ' + FormatFloat('###,###,##0.00', AQryCtr.FieldByName('DINHEIRO').AsFloat);
         If AQryCtr.FieldByName('CHQAVI').AsFloat > 0.00 Then
            strEsp := IIF(strEsp <> '', strEsp + '  ', strEsp) + 'Chq. Vista: ' + FormatFloat('###,###,##0.00', AQryCtr.FieldByName('CHQAVI').AsFloat);
         If AQryCtr.FieldByName('CHQPRE').AsFloat > 0.00 Then
            strEsp := IIF(strEsp <> '', strEsp + '  ', strEsp) + 'Chq. Prazo: ' + FormatFloat('###,###,##0.00', AQryCtr.FieldByName('CHQPRE').AsFloat);
         If AQryCtr.FieldByName('CARTAO').AsFloat > 0.00 Then
            strEsp := IIF(strEsp <> '', strEsp + '  ', strEsp) + 'Cartão: ' + FormatFloat('###,###,##0.00', AQryCtr.FieldByName('CARTAO').AsFloat);
         If AQryCtr.FieldByName('ORDPAG').AsFloat > 0.00 Then
            strEsp := IIF(strEsp <> '', strEsp + '  ', strEsp) + 'Ordem Pagto.: ' + FormatFloat('###,###,##0.00', AQryCtr.FieldByName('ORDPAG').AsFloat);
      End;

      Result:= strEsp;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

Function TReciboCtr.RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): string;
  Var
    AQryCtr : TUniQuery;
    LSql: String;
Begin

  Try
    LSql := 'SELECT CTR_EMPBAI             '+
            '  FROM CADREC                 '+
            ' WHERE CTR_NUMDUP = :NUMDUP   '+
            '   AND CTR_ESPDOC = :ESPDOC   '+
            '   AND CTR_CODCLI = :CODCLI   '+
            '   AND CTR_CODEMP = :CODEMP   '+
            '   AND CTR_SEQBAI = :SEQBAI   ';
    Try
      AQryCtr := fCriaQuery(Nil);
      AQryCtr.Close;
      AQryCtr.Sql.Clear;
      AQryCtr.Sql.Add(LSql);

      AQryCtr.ParamByName('NUMDUP').AsString := ANumDup;
      AQryCtr.ParamByName('ESPDOC').AsString := AEspDoc;
      AQryCtr.ParamByName('CODCLI').AsString := ACodCli;
      AQryCtr.ParamByName('CODEMP').AsString := ACodEmp;
      AQryCtr.ParamByName('SEQBAI').AsInteger := ASeqBai;

      AQryCtr.Open;
      If Not AQryCtr.IsEmpty Then
         Result := AQryCtr.FieldByName('CTR_EMPBAI').AsString;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(AQryCtr);
  End;

End;

Function TReciboCtr.RetornaEspeciesdePagtoDaBaixaQuebraLinha(ASeqCon : Integer; ANumDup, AEspDoc, ACodCli, ACodEmp : String; ASeqBai : Integer): String;
  Var
    LConsulta : TUniQuery;
    LSql: String;
    LEspeciesPagto,
    LEmpresaBaixa : String;
Begin

  Result := '';
  LEspeciesPagto := '';

  LEmpresaBaixa := RetornaEmpresadeBaixa(ANumDup, AEspDoc, ACodCli, ACodEmp, ASeqBai);

  Try

    LSql := 'SELECT'+
            '  CTR_SEQCON,'+
            '  SUM(CTR_DINHEI) DINHEIRO,'+
            '  SUM(CTR_CHQAVI) CHQAVI,'+
            '  SUM(CTR_CHQPRE) CHQPRE,'+
            '  SUM(CTR_CARTAO) CARTAO,'+
            '  SUM(CTR_ORDPAG) ORDPAG '+
            ' FROM'+
            '  CADREC '+
            ' WHERE CTR_SEQCON = :SEQCON '+
            '  AND CTR_EMPBAI = :EMPBAI '+
            ' GROUP BY CTR_SEQCON;';

    Try
      LConsulta := fCriaQuery(Nil);
      LConsulta.Close;
      LConsulta.Sql.Clear;
      LConsulta.Sql.Add(LSql);
      LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
      LConsulta.ParamByName('EMPBAI').AsString  := LEmpresaBaixa;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
         If LConsulta.FieldByName('DINHEIRO').AsFloat > 0.00 Then
            LEspeciesPagto := 'Dinheiro: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('DINHEIRO').AsFloat);
         If LConsulta.FieldByName('CHQAVI').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + sLineBreak + 'Chq. Vista: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQAVI').AsFloat);
         If LConsulta.FieldByName('CHQPRE').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + sLineBreak + 'Chq. Prazo: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CHQPRE').AsFloat);
         If LConsulta.FieldByName('CARTAO').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + sLineBreak + 'Cartão: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('CARTAO').AsFloat);
         If LConsulta.FieldByName('ORDPAG').AsFloat > 0.00 Then
            LEspeciesPagto := IIF(LEspeciesPagto <> '', LEspeciesPagto + '  ', LEspeciesPagto) + sLineBreak + 'Ordem Pagto.: ' + FormatFloat('###,###,##0.00', LConsulta.FieldByName('ORDPAG').AsFloat);
      End;

      Result:= LEspeciesPagto;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;

End;

Procedure TReciboCtr.pCarregaCheques( ATipo, ASeqcon, ACodEmp : String; AcdsChq: TUniClientDataSet );
  Var
     LConsulta: TUniQuery;
     LSQL: String;
Begin

    Try
      LConsulta := fCriaQuery();

      LSQL := 'SELECT'+
              '  CHQ_NUMAGE,'+
              '  CHQ_CONCOR,'+
              '  CHQ_NUMCHQ,'+
              '  CHQ_NOMEMI,'+
              '  CHQ_C_G_C_,'+
              '  CHQ_DTAVEN,'+
              '  CHQ_VALCHQ,'+
              '  CHQ_SEQCON,'+
              '  CHQ_CODEMP '+
              'FROM'+
              '  CADCHQ '+
              'WHERE CHQ_SEQCON = :SEQCON'+
              '  AND CHQ_CODEMP = :CODEMP';

      LSQL := LSQL + IIF( ATipo = 'V', ' AND CHQ_DTACAD = CHQ_DTAVEN ', ' AND CHQ_DTACAD <> CHQ_DTAVEN ' );

      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Add(LSQL);
      LConsulta.ParamByName('SEQCON').AsString := ASeqcon;
      LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        LConsulta.First;
        While Not LConsulta.Eof Do
        Begin
          AcdsChq.Insert;
          AcdsChq.FieldByName('CHQ_NUMAGE').AsString   := LConsulta.FieldByName('CHQ_NUMAGE').AsString;
          AcdsChq.FieldByName('CHQ_CONCOR').AsString   := LConsulta.FieldByName('CHQ_CONCOR').AsString;
          AcdsChq.FieldByName('CHQ_NUMCHQ').AsString   := LConsulta.FieldByName('CHQ_NUMCHQ').AsString;
          AcdsChq.FieldByName('CHQ_NOMEMI').AsString   := LConsulta.FieldByName('CHQ_NOMEMI').AsString;
          AcdsChq.FieldByName('CHQ_C_G_C_').AsString   := LConsulta.FieldByName('CHQ_C_G_C_').AsString;
          AcdsChq.FieldByName('CHQ_DTAVEN').AsDateTime := LConsulta.FieldByName('CHQ_DTAVEN').AsDateTime;
          AcdsChq.FieldByName('CHQ_VALCHQ').AsFloat    := LConsulta.FieldByName('CHQ_VALCHQ').AsFloat;

          AcdsChq.FieldByName('CHQ_SEQCON').AsString   := LConsulta.FieldByName('CHQ_SEQCON').AsString;
          AcdsChq.FieldByName('CHQ_CODEMP').AsString   := LConsulta.FieldByName('CHQ_CODEMP').AsString;
          AcdsChq.Post;

          LConsulta.Next;
        End;
      End;

      AcdsChq.First;

    Except
      On E: Exception Do
      Begin
        FreeAndNil(LConsulta);
      End;
    End;
    FreeAndNil(LConsulta);

End;

Function TReciboCtr.fVerificaJaIncluido( ACodEmp, ASeqCon : String; AcdsChq: TUniClientDataSet ) : Boolean;
Begin
  if (ACodEmp <> '') and (ASeqCon <> '') then
    Result := AcdsChq.Locate('CHQ_SEQCON; CHQ_CODEMP',VarArrayOf([ASeqCon, ACodEmp]), [])
  else
    Result := false;
End;

function DuplicataCreditoReferenteATroco(ADuplicata: TDataset): String;
  Var
    LConsulta: TUniQuery;
Begin
  Result := 'N';

  If ADuplicata.IsEmpty Then
    Exit;

  If ADuplicata.FieldByName('VALREC').AsFloat >= 0 Then
    Exit;

  If ADuplicata.FieldByName('SEQCON').AsInteger = 0 Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM LOGCTR ' +
                          'WHERE CTR_NUMDUP=:NUMDUP ' +
                          '  AND CTR_PARCEL=:PARCEL ' +
                          '  AND CTR_ESPDOC=:ESPDOC ' +
                          '  AND CTR_CODEMP=:CODEMP ' +
                          '  AND CTR_CODCLI=:CODCLI ' +
                          '  AND CTR_SEQBAI=0 ' +
                          '  AND CTR_DTAREC IS NOT NULL ' +
                          '  AND CTR_SEQCON=:SEQCON ' +
                          '  AND CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD") ';

    LConsulta.ParamByName('NUMDUP').AsString := ADuplicata.FieldByName('NUMDOC').AsString;
    LConsulta.ParamByName('PARCEL').AsString := ADuplicata.FieldByName('PARCEL').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := ADuplicata.FieldByName('ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := ADuplicata.FieldByName('CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := ADuplicata.FieldByName('CODCLI').AsString;
    LConsulta.ParamByName('SEQCON').AsInteger := ADuplicata.FieldByName('SEQCON').AsInteger;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
      Result := 'S';
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

end.
