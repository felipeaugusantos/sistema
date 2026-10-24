unit untTProrrogacaoDeTitulos;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni, Forms,
     StrUtils, Math, frxClass, untFuncoesEditorFast, untFuncoesSimples,
     untLiberacao,untMsgLiberacao,Variants, untLogAltCadCli;


Type
  TDupSel = Record
    strNumDoc: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    dtaDtaCad: TDate;
    dtaDtaVen: TDate;
    fltVlrRec: Double;
    strSeqBai: String;
    strCodCli: String;
    dtaVenBkp: TDate;
    dtaDtaRec: TDate;
    fltValOri: Double;
    fltValRec: Double;
  End;

  TArrDupSelPro = Array Of TDupSel;

  TChqSel = Record
    strCodBco: String;
    strNumAge: String;
    strNumChq: String;
    dtaDtaVen: TDate;
    fltVlrChq: Double;
  End;

  TArrChqSel = Array Of TChqSel;

  typTipPro = (ttAltVen, ttChqPre);

  TProrrogacaoDeTitulos = Class(TComponent)
  Private
    arrDupSelPro : TArrDupSelPro;
    arrChqSelPro : TArrChqSel;
    FTipPro : typTipPro;
    FLogAltCadCli: TLogAltCadCli;

    function fInativarCliente(strCodCli : String): Boolean;
    function fGravarObservacao(strCodCli : String) : Boolean;
    function fMontaObservacao(strCodCli : String): String;
    function fGravarCTRPRO(intCont : Integer = 0): Boolean;
    function fGravarCHQPRO(intCont : Integer = 0;strCTRPRO : String = ''): Boolean;
    function fTemChequePre: Boolean;
    procedure GravaLogCliInativacao(ACodigoCliente: String);
  public
    procedure pInativarClientePorProrrogacao;
    procedure pAdicionarDuplicataNoArrayProrrogacao(cdsAux: TUniClientDataSet;intRecNo: Integer = 0; blnRcx: Boolean = False; dtaDtaRec:TDate = 0);Overload;
    procedure pAdicionarDuplicataNoArrayProrrogacao(qryAux: TUniQuery; intRecNo: Integer = 0; dtaVenOld:TDate = 0);Overload;
    procedure pAdicionarChequeNoArrayProrrogacao(cdsAux: TUniClientDataSet;intRecNo: Integer = 0);
    procedure pLimparArrays;
    Constructor Create(typTipPro : typTipPro); reintroduce;
    destructor Destroy; override;

  End;

implementation

{ TProrrogacaoDeTitulos }

uses
  untCadClientes;

constructor TProrrogacaoDeTitulos.Create(typTipPro : typTipPro);
begin
  FTipPro := typTipPro;
  FLogAltCadCli := TLogAltCadCli.Create(Self);

  arrDupSelPro := Nil;
  FillChar(arrDupSelPro, SizeOf(arrDupSelPro), #0);

  arrChqSelPro := Nil;
  FillChar(arrChqSelPro, SizeOf(arrChqSelPro), #0);
end;

destructor TProrrogacaoDeTitulos.Destroy;
begin
  FLogAltCadCli.Free;
  inherited;
end;

function TProrrogacaoDeTitulos.fGravarCHQPRO(intCont: Integer;strCTRPRO : String): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO CHQPRO ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  CHQ_CODBCO, ';
    strSQL := strSQL + '  CHQ_NUMAGE, ';
    strSQL := strSQL + '  CHQ_NUMCHQ, ';
    strSQL := strSQL + '  CHQ_DTAVEN, ';
    strSQL := strSQL + '  CHQ_VALCHQ, ';
    strSQL := strSQL + '  CHQ_CTRPRO, ';
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  :CODBCO, ';
    strSQL := strSQL + '  :NUMAGE, ';
    strSQL := strSQL + '  :NUMCHQ, ';
    strSQL := strSQL + '  :DTAVEN, ';
    strSQL := strSQL + '  :VALCHQ, ';
    strSQL := strSQL + '  :CTRPRO, ';
    strSQL := strSQL + '  :INCREM) ';
    Try
      qryGen := fCriaQuery;

      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODBCO').AsString     := arrChqSelPro[intCont].strCodBco;
      qryGen.ParamByName('NUMAGE').AsString     := arrChqSelPro[intCont].strNumAge;
      qryGen.ParamByName('NUMCHQ').AsString     := arrChqSelPro[intCont].strNumChq;
      qryGen.ParamByName('DTAVEN').AsDateTime   := arrChqSelPro[intCont].dtaDtaVen;
      qryGen.ParamByName('VALCHQ').AsFloat      := arrChqSelPro[intCont].fltVlrChq;
      qryGen.ParamByName('CTRPRO').AsString     := strCTRPRO;
      qryGen.ParamByName('INCREM').AsString     := fRetAutoIncrem('CTRPRO', VS_strCodEmp);
      qryGen.ExecSQL;
      Result := True;

    Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
        Result := False;
      end;

    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TProrrogacaoDeTitulos.fGravarCTRPRO(intCont : Integer = 0): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    arrChqs   : TarrChqSel;
    intCnt : Integer;
    strCTRPRO : String;
Begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO CTRPRO ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  PRO_CODCLI, ';
    strSQL := strSQL + '  PRO_CODOPE, ';
    strSQL := strSQL + '  PRO_DTAPRO, ';
    strSQL := strSQL + '  PRO_HORPRO, ';
    strSQL := strSQL + '  PRO_STATUS, ';
    strSQL := strSQL + '  PRO_NUMDUP, ';
    strSQL := strSQL + '  PRO_ESPDOC, ';
    strSQL := strSQL + '  PRO_PARCEL, ';
    strSQL := strSQL + '  PRO_CODEMP, ';
    strSQL := strSQL + '  PRO_DTACAD, ';
    strSQL := strSQL + '  PRO_VENATU, ';
    strSQL := strSQL + '  PRO_VENNOV, ';
    strSQL := strSQL + '  PRO_DTAREC, ';
    strSQL := strSQL + '  PRO_VALORI, ';
    strSQL := strSQL + '  PRO_VALREC, ';
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :CODOPE, ';
    strSQL := strSQL + '  :DTAPRO, ';
    strSQL := strSQL + '  :HORPRO, ';
    strSQL := strSQL + '  :STATUS, ';
    strSQL := strSQL + '  :NUMDUP, ';
    strSQL := strSQL + '  :ESPDOC, ';
    strSQL := strSQL + '  :PARCEL, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :DTACAD, ';
    strSQL := strSQL + '  :VENATU, ';
    strSQL := strSQL + '  :VENNOV, ';
    strSQL := strSQL + '  :DTAREC, ';
    strSQL := strSQL + '  :VALORI, ';
    strSQL := strSQL + '  :VALREC, ';
    strSQL := strSQL + '  :INCREM) ';
    Try
      qryGen := fCriaQuery;

      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      strCTRPRO := fRetAutoIncrem('CTRPRO', VS_strCodEmp);
      qryGen.ParamByName('CODCLI').AsString     := arrDupSelPro[intCont].strCodCli;
      qryGen.ParamByName('CODOPE').AsString     := strLoginUsuarioLogado;
      qryGen.ParamByName('DTAPRO').AsDateTime   := Vs_Date;
      qryGen.ParamByName('HORPRO').AsDateTime   := fTime();
      qryGen.ParamByName('STATUS').AsString     := IIF((FTipPro = ttAltVen),'1','2');
      qryGen.ParamByName('NUMDUP').AsString     := arrDupSelPro[intCont].strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString     := arrDupSelPro[intCont].strEspDoc;
      qryGen.ParamByName('PARCEL').AsString     := arrDupSelPro[intCont].strParcel;
      qryGen.ParamByName('CODEMP').AsString     := arrDupSelPro[intCont].strCodEmp;
      qryGen.ParamByName('DTACAD').AsDateTime   := arrDupSelPro[intCont].dtaDtaCad;
      qryGen.ParamByName('VENNOV').AsDateTime   := arrDupSelPro[intCont].dtaDtaVen;
      qryGen.ParamByName('VALORI').AsFloat      := arrDupSelPro[intCont].fltValOri;
      qryGen.ParamByName('INCREM').AsString     := strCTRPRO;
      If(FTipPro = ttChqPre) Then
      Begin
        qryGen.ParamByName('VENATU').Value := Null;
        qryGen.ParamByName('DTAREC').AsDateTime := arrDupSelPro[intCont].dtaDtaRec;
        qryGen.ParamByName('VALREC').AsFloat := arrDupSelPro[intCont].fltValRec;
      End
      Else
      Begin
        qryGen.ParamByName('VENATU').AsDateTime := arrDupSelPro[intCont].dtaVenBkp;
        qryGen.ParamByName('DTAREC').Value := Null;
        qryGen.ParamByName('VALREC').Value := Null;
      End;
      qryGen.ExecSQL;

      arrChqs := arrChqSelPro;
      For intCnt := Low(arrChqs) To High(arrChqs) Do
      Begin
        If Not fGravarCHQPRO(intCnt,strCTRPRO)  Then
          Result := False;
      End;

      Result := True;

    Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
        Result := False;
      end;

    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TProrrogacaoDeTitulos.fGravarObservacao(strCodCli : String): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + ' UPDATE  ';
    strSQL := strSQL + '   CADCLI     ';
    strSQL := strSQL + ' SET CLI_OBSCON = CONCAT(:OBSCON,CLI_OBSCON) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';
    Try
      qryGen := fCriaQuery;

      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('OBSCON').AsString := fMontaObservacao(strCodCli);
      qryGen.ParamByName('CODCLI').AsString := strCodCli;
      qryGen.ExecSQL;
      Result := True;

    Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
        Result := False;
      end;

    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;


function TProrrogacaoDeTitulos.fInativarCliente(strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + ' UPDATE  ';
    strSQL := strSQL + '   CADCLI     ';
    strSQL := strSQL + ' SET CLI_STATUS = "I" ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI AND';
    strSQL := strSQL + '   CLI_STATUS <> "I"';
    Try
      qryGen := fCriaQuery;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODCLI').AsString := strCodCli;
      qryGen.ExecSQL;
      GravaLogCliInativacao(strCodCli);
      Result := True;
    Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
        Result := False;
      end;

    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

Procedure TProrrogacaoDeTitulos.pInativarClientePorProrrogacao;
  Var
    arrDups: TArrDupSelPro;
    intCnt : Integer;
    sltListaCliente : TStringList;
begin
  sltListaCliente := TStringList.Create;
  arrDups := arrDupSelPro;
  Try
    If Not fTemChequePre Then
      Exit;
    try
      For intCnt := Low(arrDups) To High(arrDups) Do
      Begin
        If (Pos(arrDups[intCnt].strCodCli,sltListaCliente.Text) <= 0 )Then
        Begin
          FLogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(arrDupSelPro[intCnt].strCodCli));
          If fInativarCliente(arrDupSelPro[intCnt].strCodCli) Then
          Begin
            If fGravarObservacao(arrDups[intCnt].strCodCli) Then
            begin
              sltListaCliente.Add(arrDups[intCnt].strCodCli);
              FLogAltCadCli.pProcessarLogs;
            end;
          End;
        End;
      End;
    except
      On E:Exception do
      begin
        raise Exception.Create('Problemas o inativar clientes por prorrogação. ' + E.Message);
      end;
    end;
  Finally
    FreeAndNil(sltListaCliente);
  End;
end;

procedure TProrrogacaoDeTitulos.pLimparArrays;
begin
  arrDupSelPro := Nil;
  FillChar(arrDupSelPro, SizeOf(arrDupSelPro), #0);

  arrChqSelPro := Nil;
  FillChar(arrChqSelPro, SizeOf(arrChqSelPro), #0);
end;

function TProrrogacaoDeTitulos.fMontaObservacao(strCodCli : String): String;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    arrDups   : TArrDupSelPro;
    arrChqs   : TarrChqSel;
    objLiberacao : TLiberacao;
    intCnt : Integer;
    sl: TStrings;
begin
  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('EM: '+ DateToStr(Date) +' '+ TimeToSTr(fTime())+' Operador: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), alEsquerda, teAmbos, '', 70);

    objLiberacao.objMsgLibera.pAddTexto('STATUS INATIVO POR' +IIF((FTipPro = ttAltVen),' PRORROGAÇÃO DE TÍTULO.',' RECEBIMENTO DE TÍTULO ATRASADO EM CHEQUE.'), alEsquerda, teAmbos, '', 50);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    arrDups := arrDupSelPro ;

    //TITULOS PRORROGADOS
    For intCnt := Low(arrDups) To High(arrDups) Do
    Begin
      If intCnt = Low(arrDupSelPro) Then
      Begin
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , ' DOCUMENTO'  , 22 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , ' DT.CAD', 11 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , ' DT.VENCTO'  , 11 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , IIF(FTipPro = ttAltVen, ' NOVO VENCTO.',' DT.RECTO'),11 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , ' VR.TÍTULO'      , 12 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;
      If arrDups[intCnt].strCodCli = strCodCli Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna(' DOCUMENTO'  ,' '+arrDups[intCnt].strNumDoc +
                                           arrDups[intCnt].strParcel + '-' +
                                           arrDups[intCnt].strEspDoc + '-' +
                                           arrDups[intCnt].strCodEmp                                                   , 22 , alEsquerda );
        objLinha.pAddColuna(' DT.CAD',' '+FormatDateTime('dd/mm/yyyy', arrDups[intCnt].dtaDtaCad)                     , 11 , alCentro   );
        objLinha.pAddColuna(' DT.VENCTO'  ,' '+FormatDateTime('dd/mm/yyyy', IIF(FTipPro = ttAltVen, arrDups[intCnt].dtaVenBkp,arrDups[intCnt].dtaDtaVen)), 11 , alCentro   );
        objLinha.pAddColuna(IIF(FTipPro = ttAltVen, ' NOVO VENCTO.',' DT.RECTO'),' '+FormatDateTime('dd/mm/yyyy', IIF(FTipPro = ttAltVen, arrDups[intCnt].dtaDtaVen,arrDups[intCnt].dtaDtaRec)), 11 , alCentro );
        objLinha.pAddColuna(' VR.TÍTULO'      , FloatToStrF(arrDups[intCnt].fltVlrRec, ffFixed, 10, 2)                      , 12 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);
        fGravarCTRPRO(intCnt);
      End;
    End;
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    //CHEQUES PRÉ
    arrChqs := arrChqSelPro;
    For intCnt := Low(arrChqs) To High(arrChqs) Do
    Begin
      If intCnt = Low(arrChqSelPro) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , ' BANCO'       , 10 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , ' AGÊNCIA'     , 10 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , ' CHEQUE'      , 11 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , ' DT. VENCTO.' , 11 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , ' VR. CHEQUE'  , 25 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      Insert('-',arrChqs[intCnt].strNumAge,5);
      objLinha.pAddColuna(' BANCO'  , ' '+arrChqs[intCnt].strCodBco                                                   , 10 , alEsquerda );
      objLinha.pAddColuna(' AGÊNCIA', ' '+arrChqs[intCnt].strNumAge                                                   , 10 , alCentro   );
      objLinha.pAddColuna(' CHEQUE',  ' '+arrChqs[intCnt].strNumChq                                                   , 11 , alCentro   );
      objLinha.pAddColuna(' DT. VENCTO.', ' '+FormatDateTime('dd/mm/yyyy', arrChqs[intCnt].dtaDtaVen)                 , 11 , alCentro   );
      objLinha.pAddColuna(' VR. CHEQUE'      , FloatToStrF(arrChqs[intCnt].fltVlrChq, ffFixed, 11, 2)                 , 25 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);
    End;

    Result := #13#10 + objLiberacao.objMsgLibera.fGetMensagem;
    Result := AnsiReplaceStr(Result,'------------------------------------------------------------------------------',
                                    '|----------------------------------------------------------------------------|');
    sl := TStringList.Create;
    try
      sl.text := Result;
      sl[3] := '.----------------------------------------------------------------------------.';
      sl[sl.count - 1] := Chr(39)+ '----------------------------------------------------------------------------'+Chr(39);
    finally
      Result := sl.text;
      FreeAndNil(sl);
    end;

  Finally
    FreeAndNil(objLiberacao);
  End
end;


function TProrrogacaoDeTitulos.fTemChequePre: Boolean;
begin
  Result := True;
  If (FTipPro = ttChqPre) Then
    Result := Not (Length(arrChqSelPro) <= 0);
end;

procedure TProrrogacaoDeTitulos.GravaLogCliInativacao(ACodigoCliente: String);
begin
  TfrmCadClientes.fGeraLogLimiteStatusCliente(ACodigoCliente,
                                              VS_Date,
                                              fTime(),
                                              strLoginUsuarioLogado,
                                              'CLI_STATUS',
                                              'A',
                                              'I',
                                              0,
                                              0,
                                              False,
                                              True);
end;

procedure TProrrogacaoDeTitulos.pAdicionarChequeNoArrayProrrogacao(cdsAux: TUniClientDataSet; intRecNo: Integer);
begin
  cdsAux.RecNo := intRecNo;
  SetLength(arrChqSelPro, Length(arrChqSelPro) + 1);
  arrChqSelPro[Length(arrChqSelPro) - 1].strCodBco := cdsAux.FieldByName('CHQ_CODBCO').AsString;
  arrChqSelPro[Length(arrChqSelPro) - 1].strNumAge := cdsAux.FieldByName('CHQ_NUMAGE').AsString;
  arrChqSelPro[Length(arrChqSelPro) - 1].strNumChq := cdsAux.FieldByName('CHQ_NUMCHQ').AsString;
  arrChqSelPro[Length(arrChqSelPro) - 1].dtaDtaVen := cdsAux.FieldByName('CHQ_DTAVEN').AsDateTime;
  arrChqSelPro[Length(arrChqSelPro) - 1].fltVlrChq := cdsAux.FieldByName('CHQ_VALCHQ').AsFloat;
end;

procedure TProrrogacaoDeTitulos.pAdicionarDuplicataNoArrayProrrogacao(qryAux: TUniQuery; intRecNo: Integer; dtaVenOld:TDate);
begin
  qryAux.RecNO := IntRecNo;
  SetLength(arrDupSelPro, Length(arrDupSelPro) + 1);
  arrDupSelPro[Length(arrDupSelPro) - 1].strNumDoc := qryAux.FieldByName('CTR_NUMDUP').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strEspDoc := qryAux.FieldByName('CTR_ESPDOC').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strCodEmp := qryAux.FieldByName('CTR_CODEMP').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strCodCli := qryAux.FieldByName('CTR_CODCLI').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaCad := qryAux.FieldByName('CTR_DTACAD').AsDateTime;
  arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaVen := qryAux.FieldByName('CTR_DTAVEN').AsDateTime;
  arrDupSelPro[Length(arrDupSelPro) - 1].fltVlrRec := qryAux.FieldByName('CTR_VALDUP').AsFloat;
  arrDupSelPro[Length(arrDupSelPro) - 1].strParcel := qryAux.FieldByName('CTR_PARCEL').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].fltValOri := qryAux.FieldByName('CTR_VALORI').AsFloat;;
  arrDupSelPro[Length(arrDupSelPro) - 1].dtaVenBkp := dtaVenOld;
end;

procedure TProrrogacaoDeTitulos.pAdicionarDuplicataNoArrayProrrogacao(cdsAux: TUniClientDataSet;intRecNo: Integer = 0; blnRcx: Boolean = false; dtaDtaRec:TDate = 0);
begin
  cdsAux.RecNO := IntRecNo;
  SetLength(arrDupSelPro, Length(arrDupSelPro) + 1);
  arrDupSelPro[Length(arrDupSelPro) - 1].strNumDoc := cdsAux.FieldByName(IIF(blnRcx,'CTR_NUMDUP','NRODUP')).AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strEspDoc := cdsAux.FieldByName('CTR_ESPDOC').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strCodEmp := cdsAux.FieldByName('CTR_CODEMP').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].strCodCli := cdsAux.FieldByName('CTR_CODCLI').AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaCad := cdsAux.FieldByName('CTR_DTACAD').AsDateTime;
  arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaVen := cdsAux.FieldByName('CTR_DTAVEN').AsDateTime;
  arrDupSelPro[Length(arrDupSelPro) - 1].fltVlrRec := cdsAux.FieldByName('CTR_VALDUP').AsFloat;
  arrDupSelPro[Length(arrDupSelPro) - 1].strParcel := cdsAux.FieldByName(IIF(blnRcx,'CTR_PARCEL','PARDUP')).AsString;
  arrDupSelPro[Length(arrDupSelPro) - 1].fltValOri := cdsAux.FieldByName('CTR_VALORI').AsFloat;
  If (FTipPro = ttAltVen) Then
    arrDupSelPro[Length(arrDupSelPro) - 1].dtaVenBkp := cdsAux.FieldByName('CTR_DTVBKP').AsDateTime
  Else
  Begin
    If blnRcx Then
      arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaRec := dtaDtaRec
    Else
      arrDupSelPro[Length(arrDupSelPro) - 1].dtaDtaRec := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;
    arrDupSelPro[Length(arrDupSelPro) - 1].fltValRec := cdsAux.FieldByName('CTR_VALREC').AsFloat;
  End;
End;
end.
