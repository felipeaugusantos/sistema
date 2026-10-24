unit untAlpeBillReceivablesCessions;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, untFuncoes, untMovCar,
  {$ENDIF LINUX}
  untTypesSistema,
  untGravaMovCar,
  Data.DB, MemDS, DBAccess, Uni;

type

{***********************************BEGIN******************************************
******************************OBJETOS DE ENVIO*************************************
********************************************************************************BL*}
  TInvoiceClass = class
  private
    FNumber: String;
  public
    property number: String read FNumber write FNumber;
  end;

  TOrderClass = class
  private
    FNumber: String;
  public
    property number: String read FNumber write FNumber;
  end;

  TItemClass = class
  private
    FAmount: Extended;
    FInvoice: TInvoiceClass;
    FOrder: TOrderClass;
  public
    property amount: Extended read FAmount write FAmount;
    property invoice: TInvoiceClass read FInvoice write FInvoice;
    property order: TOrderClass read FOrder write FOrder;
    constructor Create;
    destructor Destroy; override;
    class function ToJsonString(Item: TItemClass): string;
  end;

  TAlpeBillReceivablesCessions = class
  private
    FItems: TArray<TItemClass>;
  public
    property Items: TArray<TItemClass> read FItems write FItems;
    constructor Create(length: Integer); reintroduce;
    destructor Destroy; override;
  end;
  {***********************************END********************************************
  ******************************OBJETOS DE ENVIO*************************************
  ********************************************************************************BL*}



  {***********************************BEGIN******************************************
  ******************************OBJETOS DE RETORNO***********************************
  ********************************************************************************BL*}
  TContentClass = class
  private
    FAmount: Extended;
    FInvoice: TInvoiceClass;
    FOrder: TOrderClass;
    FId: Extended;
  public
    property amount: Extended read FAmount write FAmount;
    property invoice: TInvoiceClass read FInvoice write FInvoice;
    property order: TOrderClass read FOrder write FOrder;
    property id: Extended read FId write FId;
    constructor Create;
    destructor Destroy; override;
  end;

  TAlpeRetornoBillReceivablesCessions = class
  private
    FContent: TArray<TContentClass>;
    FDuration: Extended;
    FId: String;
    FInstant: String;
    FResource: String;
    FStatus: Extended;
  public
    property content: TArray<TContentClass> read FContent write FContent;
    property duration: Extended read FDuration write FDuration;
    property id: String read FId write FId;
    property instant: String read FInstant write FInstant;
    property resource: String read FResource write FResource;
    property status: Extended read FStatus write FStatus;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TAlpeRetornoBillReceivablesCessions;
  end;
  {***********************************END********************************************
  ******************************OBJETOS DE RETORNO***********************************
  ********************************************************************************BL*}



  {**********************************BEGIN*******************************************
  *********************************CONTROLLER****************************************
  ********************************************************************************BL*}
  TControllerBillReceivablesCessions = class
  private
    function fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray; recDadAdCar: TDadosAdicCartao): Boolean;
    function fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
    strEspDoc: String; intCnt2: Integer): Boolean;

    function fBillReceivablesCessions(BillReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoBillReceivablesCessions;
    function fRetTotalFaturado(strSeqGer: String): Double;
  public
    procedure pProcessarBillReceivablesCessions;
  end;
  {************************************END*******************************************
  *********************************CONTROLLER****************************************
  ********************************************************************************BL*}

implementation

uses
  untRestApi, untAlpeRestApi, untArredondaParcelaImpl;

{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}
{TItemClass}

constructor TItemClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
  FInvoice := TInvoiceClass.Create();
end;

destructor TItemClass.Destroy;
begin
  FOrder.free;
  FInvoice.free;
  inherited;
end;

class function TItemClass.ToJsonString(Item: TItemClass): string;
begin
  result := '['+TJson.ObjectToJsonString(Item)+']';
end;

{TAlpeBillReceivablesCessions}

constructor TAlpeBillReceivablesCessions.Create(length: Integer);
var
  i: Integer;
begin
  SetLength(FItems, length);

  for i := 0 to length -1 do
    Items[i] := TItemClass.Create();
end;

destructor TAlpeBillReceivablesCessions.Destroy;
var
  LItemsItem: TItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;
{***********************************END********************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}



{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}
{TContentClass}

constructor TContentClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
  FInvoice := TInvoiceClass.Create();
end;

destructor TContentClass.Destroy;
begin
  FOrder.free;
  FInvoice.free;
  inherited;
end;

{TAlpeRetornoBillReceivablesCessions}

destructor TAlpeRetornoBillReceivablesCessions.Destroy;
var
  LcontentItem: TContentClass;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TAlpeRetornoBillReceivablesCessions.FromJsonString(AJsonString: string): TAlpeRetornoBillReceivablesCessions;
begin
  Result := TJson.JsonToObject<TAlpeRetornoBillReceivablesCessions>(AJsonString)
end;
{************************************END*******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}



{***********************************BEGIN******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}
{ TControllerReceivablesCessions }

function TControllerBillReceivablesCessions.fRetTotalFaturado(strSeqGer: String): Double;
var
  qryTotFat: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryTotFat := fCriaQuery;
  try
    qryTotFat.Close;
    qryTotFat.SQL.Clear;
    qryTotFat.SQL.Text :=
    ' SELECT '+
    '   IFNULL(SUM((F.FDO_VLRCON / F.FDO_QTDITE) * F.FDO_QTDBAI),0) AS TOTFAT '+
    ' FROM '+
    '   FATDOR F '+
    ' INNER JOIN EXTDOR E '+
    '   ON F.AUTOINCREM = E.FDO_SEQFDO '+
    ' WHERE '+
    '   E.FDO_TIPREC = "ALPEF" AND '+
    '   F.FDO_SEQGER = :AUTOIN     ';

    qryTotFat.ParamByName('AUTOIN').AsString := strSeqGer;
    qryTotFat.Open;

    Result := qryTotFat.FieldByName('TOTFAT').AsFloat;
  finally
   {$IFNDEF LINUX}
    qryTotFat.Free;
   {$ENDIF LINUX}
  end;
end;

function TControllerBillReceivablesCessions.fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
  strEspDoc: String; intCnt2: Integer): Boolean;
var
  qryMovCar: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryMovCar := fCriaQuery;

  Try
    With qryMovCar Do
    Begin
      SQL.Add('SELECT AUTOINCREM ');
      SQL.Add('FROM MOVCAR ');
      SQL.Add('WHERE MCA_CODCLI = :CODCLI AND ');
      SQL.Add('      MCA_PARCEL = :PARCEL AND ');
      SQL.Add('      MCA_CODEMP = :CODEMP AND ');
      SQL.Add('      MCA_DOCUME = :DOCUME AND ');
      SQL.Add('      MCA_HIST01 = "FULFILLMENT" ');

      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strSequen;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('DOCUME').AsString := fDocumeCar(strNumDoc, strEspDoc, strCodEmp, intCnt2);
      Open;

      Result := Not IsEmpty;
    End;

  Finally
    qryMovCar.Close;
   {$IFNDEF LINUX}
    FreeAndNil(qryMovCar);
   {$ENDIF LINUX}
  End;
end;

function TControllerBillReceivablesCessions.fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao): Boolean;
  Var
    intCnt  : Integer;
    intCnt2 : Integer;
    intCnt3 : Integer;
    strNumDupCartao : String;
    strHisCar : String;
    arrDigDup: TArrDigDuplic;
    arrDigFat: TArrDigDuplic;
    arrDuplicata,
    arrDuplicFat : TArrDigDuplicArray;
    fltTotDig : Double;
    fltVlTxGe : Double;
    fltVlTxPc : Double;
    objArredondaParcela: IArredondaParcela;
begin
  Result := True;

  Try

    For intCnt := 0 To Length(arrCartoes) -1 Do
    Begin
      If (Not Result) Then
        Break;

      objArredondaParcela := fArredondamentoParcelas(arrCartoes[intCnt].strCodCar);

      fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDig, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
      SetLength(arrDuplicFat, Length(arrDuplicata));

      For intCnt3 := 0 To Length(arrDuplicata) - 1 Do
        arrDuplicFat[intCnt3] := arrDuplicata[intCnt3];

      {**********************************************************************}
      {* HIERARQUIA: CASO MANDOU TAXA NA FSCARTOES, IGNORA A CALCULADA NA   *}
      {* TELA: frmRcxDigCartoes                                             *}
      {*******************************************************************RN*}
      fltVlTxGe := 0;
      fltVlTxPc := 0;
      If (fFormataFloat(recDadAdCar.fltTxDsGe + recDadAdCar.fltTxDsPa, 2) > 0) Then
      Begin
        fltTotDig := arrCartoes[intCnt].fltValDig;

        If (fFormataFloat(recDadAdCar.fltTxDsGe, 2) > 0) Then
        Begin
          If (recDadAdCar.strTxDsGe = 'V') Then
            fltVlTxGe := recDadAdCar.fltTxDsGe
          Else If (recDadAdCar.strTxDsGe = 'P') Then
            fltVlTxGe := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsGe / 100 ) ), 2);

          fltTotDig := fltTotDig - fltVlTxGe;
          fltVlTxGe := fFormataFloat(fltVlTxGe / recDadAdCar.intQtdPar, 2);
        End;

        If (fFormataFloat(recDadAdCar.fltTxDsPa, 2) > 0) Then
        Begin
          If (recDadAdCar.strTxDsPa = 'V') Then
            fltVlTxPc := (recDadAdCar.fltTxDsPa * recDadAdCar.intQtdPar)
          Else If (recDadAdCar.strTxDsPa = 'P') Then
            fltVlTxPc := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsPa / 100 ) ), 2);

          fltTotDig := fltTotDig - fltVlTxPc;
          fltVlTxPc := fFormataFloat(fltVlTxPc / recDadAdCar.intQtdPar, 2);
        End;

        arrCartoes[intCnt].fltValDes := fltTotDig;
      End;

      fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDig, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

      strNumDupCartao := fRetSequencialMovCar('MOVCAR', VS_strCodEmp);

      intCnt2 := 0;

      While (fEmptyStr(arrCartoes[intCnt].strCodFin) And (intCnt2 < Length(arrDuplicata)) And
             (Not fEmptyStr(arrDuplicata[intCnt2].strSequen))) Do
      Begin
        arrDigDup := arrDuplicata[intCnt2];
        arrDigFat := arrDuplicFat[intCnt2];

        strHisCar := 'REF. AO DOC. ALPE: ' + recDadAdCar.strNumDoc;

        If fMovCarJaExiste(recDadAdCar.strCodCli,
                           arrDigDup.strSequen,
                           recDadAdCar.strCodEmp,
                           recDadAdCar.strNumDoc,
                           recDadAdCar.strEspDoc,
                           intCnt2) Then
          Raise Exception.Create('Documento já foi importado na MOVCAR');

        Result := Result And fGravaMovCar('',
                                          'INCLUSÃO',
                                          strNumDupCartao,
                                          recDadAdCar.strCodCli,
                                          arrDigDup.strSequen,
                                          recDadAdCar.strCodEmp,
                                          arrCartoes[intCnt].strCodCar,
                                          recDadAdCar.dtaDtaCar,
                                          StrToDate(arrDigDup.dtaDtaVen),
                                          arrDigDup.curValor, // fltValOri
                                          arrDigDup.curValor, // fltValDup
                                          arrCartoes[intCnt].strObsCar,
                                          strHisCar,
                                          arrCartoes[intCnt].strCndPag,
                                          0,
                                          0.0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          arrCartoes[intCnt].fltPerDes,
                                          arrDigFat.curValor,
                                          arrDigFat.curValor - arrDigDup.curValor,
                                          arrCartoes[intCnt].strNumCcd,
                                          fDocumeCar(recDadAdCar.strNumDoc, recDadAdCar.strEspDoc, recDadAdCar.strCodEmp, intCnt2),
                                          '',
                                          StrToInt(fRetRcxCon(recDadAdCar.strCodEmp)),
                                          VS_strCodEmp,
                                          strLoginUsuarioLogado,
                                          False,
                                          '',
                                          'F',
                                          arrCartoes[intCnt].strCodFin,
                                          arrCartoes[intCnt].strTipCar,
                                          0,
                                          0,
                                          0,
                                          0,
                                          arrCartoes[intCnt].strNumNsu,
                                          recDadAdCar.strNumPok,
                                          recDadAdCar.dtaDtaCup,
                                          fltVlTxGe,
                                          fltVlTxPc,
                                          recDadAdCar.dtaDtaCar);

        Inc(intCnt2);

        If (Not Result) Then
          Break;
      End;

      If (Not Result) Then
        Break;
    End;


  Except
    On E: Exception Do
    Begin

      raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TControllerBillReceivablesCessions.pProcessarBillReceivablesCessions;
var
  qryBill,
  qryUpdate,
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  BillReceivablesCessions: TAlpeBillReceivablesCessions;
  RetornoBillReceivablesCessions: TAlpeRetornoBillReceivablesCessions;

  arrCartoes: TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao;
  intPosCar : Integer;

  i: Integer;
begin

  try
    qryBill                   := fCriaQuery;
    qryUpdate                 := fCriaQuery;
    qryAux                    := fCriaQuery;
    BillReceivablesCessions   := nil;
    RetornoBillReceivablesCessions := nil;

    try
      qryBill.Close;
      qryBill.SQL.Clear;
      qryBill.SQL.Text :=
      ' SELECT '+
      '   F.AUTOINCREM,  '+
      '   F.FGO_VLRCON,  '+
      '   L.EMP_C_G_C_,  '+
      '   D.FDO_NUMDOC,  '+
      '   D.FDO_CODEMP,  '+
      '   D.FDO_NUMFAT,  '+
      '   D.FDO_CODCLI,  '+
      '   D.FDO_DTAENT,  '+
      '   SUM((D.FDO_VLRCON / D.FDO_QTDITE) * D.FDO_QTDBAI) AS TOTFAT, '+
      '   D.FDO_CONPAG,  '+
      '   CT.CAR_CODCAR, '+
      '   CT.CAR_DESCAR, '+
      '   CT.CAR_TIPTAX, '+
      '   CT.CAR_PERDES  '+
      ' FROM '+
      '   FATDOR D '+
      ' INNER JOIN EXTDOR ED '+
      '   ON D.AUTOINCREM = ED.FDO_SEQFDO '+
      ' INNER JOIN FATGOR F '+
      '   ON D.FDO_SEQGER = F.AUTOINCREM '+
      ' INNER JOIN CADEMP L '+
      '   ON L.EMP_CODEMP = :CODEMP '+
      ' INNER JOIN CADCAR CT '+
      '   ON (SELECT '+
      '         SIS_VALCFG '+
      '       FROM '+
      '         CFGSIS '+
      '       WHERE '+
      '         SIS_CODCFG = "CFG_CARALP" AND '+
      '         D.FDO_CODEMP = SIS_CODEMP) = CT.CAR_CODCAR '+
      ' WHERE '+
      '   D.FDO_ESPDOC = "PD"       AND  '+
      '  ED.FDO_TIPREC = "ALPE"     AND  '+
      '   D.FDO_CODEMP = :CODEMP    AND  '+
      '   D.FDO_JAFATU = 1          AND  '+
      '   IFNULL(D.FDO_NUMFAT, "") <> "" '+
      ' GROUP BY '+
      '   F.AUTOINCREM,  '+
      '   F.FGO_VLRCON,  '+
      '   L.EMP_C_G_C_,  '+
      '   D.FDO_NUMDOC,  '+
      '   D.FDO_CODEMP,  '+
      '   D.FDO_NUMFAT,  '+
      '   D.FDO_CODCLI,  '+
      '   D.FDO_DTAENT,  '+
      '   D.FDO_CONPAG,  '+
      '   CT.CAR_CODCAR, '+
      '   CT.CAR_DESCAR, '+
      '   CT.CAR_TIPTAX, '+
      '   CT.CAR_PERDES  ';

      qryBill.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryBill.Open;

      if not qryBill.IsEmpty then
      begin
        BillReceivablesCessions   := TAlpeBillReceivablesCessions.Create(qryBill.RecordCount);

        for i := 0 to Length(BillReceivablesCessions.Items)-1 do
        begin
          BillReceivablesCessions.Items[i].amount         := qryBill.FieldByName('TOTFAT').AsFloat;
          BillReceivablesCessions.Items[i].order.number   := qryBill.FieldByName('EMP_C_G_C_').AsString+':'+
                                                             qryBill.FieldByName('FDO_NUMDOC').AsString+
                                                             qryBill.FieldByName('FDO_CODEMP').AsString;
          BillReceivablesCessions.Items[i].invoice.number := 'urn:nf:'+RightStr(qryBill.FieldByName('FDO_NUMFAT').AsString, 9);

          RetornoBillReceivablesCessions := fBillReceivablesCessions(
                                              BillReceivablesCessions.Items[i],
                                              qryBill.FieldByName('AUTOINCREM').AsString
                                            );

          if RetornoBillReceivablesCessions <> nil then
          begin
            fStartTransaction;
            try
              qryAux.Close;
              qryAux.SQL.Text :=
              ' SELECT '+
              '   AUTOINCREM '+
              ' FROM '+
              '   FATDOR F '+
              ' INNER JOIN EXTDOR E '+
              '   ON F.AUTOINCREM = E.FDO_SEQFDO '+
              ' WHERE '+
              '   E.FDO_TIPREC = "ALPE"   AND '+
              '   F.FDO_SEQGER = :AUTOIN  AND '+
              '   F.FDO_JAFATU = 1        AND '+
              '   IFNULL(F.FDO_NUMFAT, "") <> "" ';

              qryAux.ParamByName('AUTOIN').AsString := qryBill.FieldByName('AUTOINCREM').AsString;
              qryAux.Open;

              while not qryAux.Eof do
              begin
                qryUpdate.Close;
                qryUpdate.SQL.Text :=
                ' UPDATE '+
                '   EXTDOR '+
                ' SET '+
                '   FDO_TIPREC = "ALPEF"'+
                ' WHERE '+
                '   FDO_SEQFDO = :SEQFDO ';

                qryUpdate.ParamByName('SEQFDO').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
                qryUpdate.ExecSQL;

                qryAux.Next;
              end;

              qryUpdate.Close;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   EXTGOR '+
              ' SET '+
              '   FGO_TIPREC = :TIPREC '+
              ' WHERE '+
              '   FGO_SEQFGO = :AUTOIN';

              qryUpdate.ParamByName('TIPREC').AsString := IIF(fRetTotalFaturado(qryBill.FieldByName('AUTOINCREM').AsString) <> qryBill.FieldByName('FGO_VLRCON').AsFloat,
                                                              'ALPEP',
                                                              'ALPEF');
              qryUpdate.ParamByName('AUTOIN').AsString := qryBill.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ExecSQL;

              SetLength(arrCartoes, 1);
              intPosCar := 0;

              FillChar(arrCartoes[intPosCar], SizeOf(arrCartoes[intPosCar]), #0);

              arrCartoes[intPosCar].intCodSeq := intPosCar;
              arrCartoes[intPosCar].strCodCar := qryBill.FieldByName('CAR_CODCAR').AsString;
              arrCartoes[intPosCar].strDesCar := qryBill.FieldByName('CAR_DESCAR').AsString;
              arrCartoes[intPosCar].fltValDig := qryBill.FieldByName('TOTFAT').AsFloat;
              arrCartoes[intPosCar].strCndPag := qryBill.FieldByName('FDO_CONPAG').AsString;
              arrCartoes[intPosCar].strObsCar := 'INTEGRAÇÃO ALPE';
              arrCartoes[intPosCar].strNumCcd := FloatToStr(RetornoBillReceivablesCessions.content[0].id);

              arrCartoes[intPosCar].fltPerDes := IIF(qryBill.FieldByName('CAR_TIPTAX').AsString = 'P',
                                                       qryBill.FieldByName('CAR_PERDES').AsFloat,
                                                       (qryBill.FieldByName('CAR_PERDES').AsFloat /
                                                       (arrCartoes[intPosCar].fltValDig/StrToIntDef(Copy(qryBill.FieldByName('FDO_CONPAG').AsString,0,2),1)) * 100)
                                                     );

              arrCartoes[intPosCar].fltValDes := fCalculaValDocCartao(arrCartoes[intPosCar].fltValDig,
                                                                      arrCartoes[intPosCar].fltPerDes);

              arrCartoes[intPosCar].strCodFin := '';
              arrCartoes[intPosCar].strTipCar := 'ALP';
              arrCartoes[intPosCar].strNumNsu := '';
              arrCartoes[intPosCar].strConteudoArquivo := '';

              FillChar(recDadAdCar, SizeOf(recDadAdCar), #0);

              recDadAdCar.strNumDoc := qryBill.FieldByName('FDO_NUMDOC').AsString;
              recDadAdCar.strEspDoc := 'PD';
              recDadAdCar.strCodEmp := qryBill.FieldByName('FDO_CODEMP').AsString;
              recDadAdCar.strCodCli := qryBill.FieldByName('FDO_CODCLI').AsString;
              recDadAdCar.dtaDtaCar := qryBill.FieldByName('FDO_DTAENT').AsDateTime;
              recDadAdCar.dtaDtaCup := qryBill.FieldByName('FDO_DTAENT').AsDateTime;
              recDadAdCar.fltTotVen := qryBill.FieldByName('TOTFAT').AsFloat;
              recDadAdCar.strNumPok := FloatToStr(RetornoBillReceivablesCessions.content[0].id);
              recDadAdCar.fltTxDsGe := 0;
              recDadAdCar.fltTxDsPa := 0;
              recDadAdCar.strTxDsGe := '';
              recDadAdCar.strTxDsPa := '';
              recDadAdCar.intQtdPar := StrToInt(Copy(qryBill.FieldByName('FDO_CONPAG').AsString,0,2));

              if fGravarCartoes(arrCartoes, recDadAdCar) then
                fCommit
              else
                fRollback;
            except
              On E: Exception Do
              Begin
                fRollback;
              End;
            end;
          end;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(spIdRecebiveisAlpe, [VS_strCodEmp]));
          {$ENDIF LINUX}

          qryBill.Next;
          Sleep(1000);
        end;
      end;

    finally
     {$IFNDEF LINUX}
      qryBill.Free;
      qryUpdate.Free;
      qryAux.Free;
     {$ENDIF LINUX}
     if Assigned(BillReceivablesCessions) then
       BillReceivablesCessions.Free;
     if Assigned(RetornoBillReceivablesCessions) then
       RetornoBillReceivablesCessions.Free;

    end;
  except
    on E: Exception do
      pGravarErro(True, E.Message);
  end;
end;

function TControllerBillReceivablesCessions.fBillReceivablesCessions(
  BillReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoBillReceivablesCessions;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', TControllerAlpe.fConfigurarAlpe);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'accounting/api/v1/receivables-cessions/bill';
    RestRequest.Method := rmPUT;

    RESTRequest
    .Params
    .AddItem(  '',
               TItemClass.ToJsonString(BillReceivablesCessions),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200','201'], strSeqFgo) then
      Result := TAlpeRetornoBillReceivablesCessions.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;
{************************************END*******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}

end.

