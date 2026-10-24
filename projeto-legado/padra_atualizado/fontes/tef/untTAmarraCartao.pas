unit untTAmarraCartao;

interface

uses Uni;

type
  TAmarraCartao = class
  private
    strNomRed: String;
    strNomBan: String;
    strTipTra: String;
    intQtdPar: Integer;
    FstrCardSe: String ;
    FstrTipDeb: Char ;
    FstrTipoCartao: String ;
    procedure pAtualizaDadosCartao(strCodCar: String);
    procedure pSelecionaPosCCDNSU(strArqImp: String; Var strCCD: String; Var strNSU: String);
    procedure pCarrega(qryAux: TUniQuery; strCodCar: String);

    function fCarregaCartaoGenericoPagueFacil(var strCodCar : String) : Boolean;
    function fPrecisaAmarrarInfoCartao(const AstrCodCar, AstrCodEmp: String; const AblnConsultaVazia: Boolean): Boolean;
  public
    constructor Create(strNomRed, strNomBan, strTipTra: String; intQtdPar: Integer; const AstrCardSe: string; const AstrTipDeb: Char; const AstrTipoCartao: String);
    procedure pPosNumerosSeq(strArqImp: String; Var strCCD: String; Var strNSU: String; Var strCodCar: string);
  end;

implementation

uses untFuncoesSimples, Classes, untTypesSistema, untFunTef, SysUtils, Data.DB, StrUtils, untRegrasCadastroCartaoTef;

{ TAmarraCartao }

constructor TAmarraCartao.Create(strNomRed, strNomBan, strTipTra: String; intQtdPar: Integer; const AstrCardSe: string; const AstrTipDeb: Char; const AstrTipoCartao: String);
begin
  Self.strNomRed := strNomRed;
  Self.strNomBan := strNomBan;
  Self.strTipTra := strTipTra;
  Self.intQtdPar := intQtdPar;
  Self.FstrCardSe := AstrCardSe ;
  Self.FstrTipDeb := AstrTipDeb ;
  Self.FstrTipoCartao := AstrTipoCartao ;
end;

procedure TAmarraCartao.pCarrega(qryAux: TUniQuery; strCodCar: String);
Begin
  qryAux.SQL.Add(' SELECT CAR_CODCAR, CAR_CODEMP ');
  qryAux.SQL.Add('   FROM CADCAR     ');
  qryAux.SQL.Add('  WHERE CAR_CODCAR = :CODCAR ');
  qryAux.ParamByName('CODCAR').AsString := strCodCar;
  qryAux.Open;
  pGravaLogCadCar(qryAux) ;
End;

function TAmarraCartao.fCarregaCartaoGenericoPagueFacil(var strCodCar : String) : Boolean;
begin
  if not VS_AutoatendimentoPagueFacil then
    Exit(False);

  if not fEmptyStr(strCodCar) then
    Exit(False);

  if not VS_blnTefCitel then
    Exit(False);

  if fEmptyStr(fCfgSis('CARGEN')) then
    Exit(False);

  strCodCar := fCfgSis('CARGEN');
  Result := True;
end;

function TAmarraCartao.fPrecisaAmarrarInfoCartao(const AstrCodCar,
  AstrCodEmp: String; const AblnConsultaVazia: Boolean): Boolean;
begin
  Result := True ;

  if fEmptyStr(AstrCodCar) then
    Exit ;

  if AblnConsultaVazia then
    Exit ;

  if (not fEmptyStr(AstrCodEmp)) and (AstrCodEmp <> VS_strCodEmp) then
    Exit ;

  Result := False ;
end;

procedure TAmarraCartao.pPosNumerosSeq(strArqImp: String; var strCCD, strNSU: String; Var strCodCar: string);
Var
  qryAux   : TUniQuery;
  arrSel   : TConsultasArray;
  blnUtilizouCarGen : Boolean;
  LstrCodEmp: String ;
  LblnConsultaVazia: boolean ;
begin

  qryAux := fCriaQuery(Nil);

  Try

    Try

      pLog('Entrou na posição onde deverá amarrar o cartão...');

      pRetDadosCartao(strNomRed, strNomBan, strTipTra, intQtdPar, strCodCar, FstrCardSe, LstrCodEmp, FstrTipDeb, FstrTipoCartao);

      blnUtilizouCarGen := fCarregaCartaoGenericoPagueFacil(strCodCar);

      LblnConsultaVazia := False ;
      if not fEmptyStr(strCodCar) then
      begin
        pCarrega(qryAux, strCodCar);
        LstrCodEmp := qryAux.FieldByName('CAR_CODEMP').AsString ;
        LblnConsultaVazia := qryAux.IsEmpty ;
      end ;

      If fPrecisaAmarrarInfoCartao(strCodCar, LstrCodEmp, LblnConsultaVazia)  Then
      Begin
        If (TUtilCadastroCartaoTef.fInformaOperadorCartaoEncontrado) or
           (fMensagem('', 'O cartão utilizado neste TEF não foi localizado no Cadastro de Cartões. ' +
                         'Deseja associá-lo ao cadastro para que o sistema consiga identificá-lo e ' +
                         'carregar seus dados automaticamente da próxima vez?', ['','']) = 1) Then
        Begin

          If fSelecionaCartao(qryAux, IntToStr(intQtdPar), arrSel, strCodCar) Then
          Begin
            pSelecionaPosCCDNSU(strArqImp, strCCD, strNSU);
            pAtualizaDadosCartao(strCodCar);
          End;

        End;

      End
      Else
      Begin
        pSelecionaPosCCDNSU(strArqImp, strCCD, strNSU);

        if blnUtilizouCarGen then
          pAtualizaDadosCartao(strCodCar);
      End;

      qryAux.Close;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TAmarraCartao.pAtualizaDadosCartao(strCodCar: String);
  Var
    qryUpd: TUniQuery;
    LstrTefCit: String ;
Begin
  if fCadastroCartaoParamAutTef then
    Exit ;

  qryUpd := fCriaQuery;
  Try
    qryUpd.SQL.Add(' UPDATE CADCAR ');
    if VS_blnTefCitel then
    begin
      LstrTefCit := fCfgSis('TEFCIT', varString) ;
      qryUpd.SQL.Add('  SET ' + IfThen(LstrTefCit=OPCAO_CLISITEF, 'CAR_TFTRED', 'CAR_TFRED2') + ' = :NOMRED, ');
      qryUpd.SQL.Add('      ' + IfThen(LstrTefCit=OPCAO_CLISITEF, 'CAR_TFTBAN', 'CAR_TFBAN2') + ' = :NOMBAN, ');
      qryUpd.SQL.Add('      CAR_CARDSE = :CARDSE, ');
      qryUpd.SQL.Add('      CAR_TIPDEB = :TIPDEB ');
      qryUpd.ParamByName('CARDSE').AsString := FstrCardSe;
      qryUpd.ParamByName('TIPDEB').AsString := FstrTipDeb;
    end
    else
    begin
      qryUpd.SQL.Add('  SET CAR_NOMRED = :NOMRED, ');
      qryUpd.SQL.Add('      CAR_NOMBAN = :NOMBAN, ');
      qryUpd.SQL.Add('      CAR_TIPTRA = :TIPTRA  ');
    end;
    qryUpd.SQL.Add('  WHERE CAR_CODCAR = :CODCAR  ');
    qryUpd.ParamByName('NOMRED').AsString := strNomRed;
    qryUpd.ParamByName('NOMBAN').AsString := strNomBan;
    if not VS_blnTefCitel then
      qryUpd.ParamByName('TIPTRA').AsString := strTipTra;
    qryUpd.ParamByName('CODCAR').AsString := strCodCar;
    qryUpd.ExecSQL;
    pGravaLogCadCar(qryUpd) ;
  Finally
    FreeAndNil(qryUpd);
  End;
End;

procedure TAmarraCartao.pSelecionaPosCCDNSU(strArqImp: String; Var strCCD: String; Var strNSU: String);
  Var
    stlDados: TStringList;
    intCount: Integer;
    blnTabPosDoc : Boolean;
    blnTabPosAut : Boolean;
    qryPosDoc : TUniQuery;
    qryPosAut : TUniQuery;

  function fAchaPosDoc(i: Integer): Integer;
  Begin
    Result := Pos('DOC= ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 5;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('DOC=', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 4;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('DOC:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 4;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('CV:               ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 18;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('CV:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 3;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('NSU BERGS:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 10;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('COMPROV: ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 9;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('NSU HOST ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 9;
      Exit;
    End;
  End;

  function fAchaPosDocTab(Var intLinha: Integer): Integer;
  Var intCont: Integer;
  Begin
    Result := 0;

    For intCont := 0 To stlDados.Count -1 Do
    Begin
      Result := Pos(qryPosDoc.FieldByName('DOC_DESCRI').AsString, stlDados[intCont]);
      If Result > 0 Then
      Begin
        Result := Result + Length(qryPosDoc.FieldByName('DOC_DESCRI').AsString);
        intLinha := intCont;
        Exit;
      End;
    End;
  End;

  function fAchaPosAut(i: Integer): Integer;
  Begin
    Result := Pos('AUT= ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 5;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUT=', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 4;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUT:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 4;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUTORIZ.=', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 9;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUTO: ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 6;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUTO:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 5;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('NSU BANDEIRA:', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 13;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUTORIZACAO:      ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 18;
      Exit;
    End;

    If Result <= 0 Then Result := Pos('AUTORIZACAO: ', stlDados[i]);
    If Result > 0 Then
    Begin
      Result := Result + 13;
      Exit;
    End;
  End;

  function fAchaPosAutTab(Var intLinha: Integer): Integer;
  Var intCont: Integer;
  Begin
    Result := 0;

    For intCont := 0 To stlDados.Count -1 Do
    Begin
      Result := Pos(qryPosAut.FieldByName('AUT_DESCRI').AsString, stlDados[intCont]);
      If Result > 0 Then
      Begin
        Result := Result + Length(qryPosAut.FieldByName('AUT_DESCRI').AsString);
        intLinha := intCont;
        Exit;
      End;
    End;
  End;

  function fRetornaValor(str: String): String;
    Var
      i: Integer;
  Begin

    Result := '';
    For i := 1 To Length(str) Do
    Begin

      If (Not fEmptyStr(str[i])) And (str[i] <> '"') Then
        Result := Result + str[i]
      Else
        Break;

    End;
  End;

Begin
  If (fEmptyStr(strArqImp)) Or (Not FileExists(strArqImp)) Then
    Exit;

  stlDados := TStringList.Create;
  qryPosDoc := fCriaQuery;
  qryPosAut := fCriaQuery;
  Try
    blnTabPosDoc := fPopularTabelaPOSDOC(qryPosDoc) And (Assigned(qryPosDoc)) And (qryPosDoc.Active) And (Not qryPosDoc.IsEmpty);
    blnTabPosAut := fPopularTabelaPOSAUT(qryPosAut) And (Assigned(qryPosAut)) And (qryPosAut.Active) And (Not qryPosAut.IsEmpty);

    stlDados.LoadFromFile(strArqImp);

    If (blnTabPosAut) Then
    Begin
      qryPosAut.First;
      While Not qryPosAut.Eof Do
      Begin
        If fEmptyStr(strCCD) And (fAchaPosAutTab(intCount) > 0) Then
          strCCD := fRetornaValor( Copy( stlDados[intCount], fAchaPosAutTab(intCount), Length(stlDados[intCount]) ) );

        If Not fEmptyStr(strCCD) Then
          Break;

        qryPosAut.Next;
      End;
    End;

    If (blnTabPosDoc) Then
    Begin
      qryPosDoc.First;
      While Not qryPosDoc.Eof Do
      Begin
        If fEmptyStr(strNSU) And (fAchaPosDocTab(intCount) > 0) Then
          strNSU := fRetornaValor( Copy( stlDados[intCount], fAchaPosDocTab(intCount), Length(stlDados[intCount]) ) );

        If Not fEmptyStr(strNSU) Then
          Break;

        qryPosDoc.Next;
      End;
    End;

    If fEmptyStr(strCCD) Then
    Begin
      For intCount := 0 To stlDados.Count -1 Do
      Begin

        If (fAchaPosAut(intCount) > 0) Then
        Begin
          strCCD := fRetornaValor( Copy( stlDados[intCount], fAchaPosAut(intCount), Length(stlDados[intCount]) ) );
          Break;
        End;

      End;
    End;

    If fEmptyStr(strNSU) Then
    Begin
      For intCount := 0 To stlDados.Count -1 Do
      Begin

        If (fAchaPosDoc(intCount) > 0) Then
        Begin
          strNSU := fRetornaValor( Copy( stlDados[intCount], fAchaPosDoc(intCount), Length(stlDados[intCount]) ) );
          Break;
        End;

      End;
    End;
  Finally
    FreeAndNil(stlDados);
    FreeAndNil(qryPosDoc);
    FreeAndNil(qryPosAut);
  End;
End;

end.
