{***************************************}
{* Importação de arquivos do PAGSEGURO *}
{************************************AJ*}
unit untPagSeguroPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCod_CV: String;
    strDtaTra: String;
    strDtaPag: String;
    strTipEve: String;
    strDtaAju: String;
    strTipTra: String;
    strCodAut: String;
    strCodTra: String;
    strCodVen: String;
    fltValBru: Double;
    fltValLiq: Double;
    fltValPar: Double;
    fltTaxAnt: Double;
    fltLiqAnt: Double;
    strTotPar: String;
    strNumPar: String;
    strStaPag: String;
    strMeiPag: String;
    strNumNSU: String;
    strNumCar: String;
    strNomArq: String;
    strDtaArq: String;

    PagamentoAPrazo,
    CanalDeEntrada,
    MeioDeCaptura,
    Plano: String;

    TaxaIntermediacao,
    TaxaParcelamento: Double;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroPagSeguroPgto  = Array Of TRegistroPgto;

  TArrEstruturaPagSeguroPgto  = Array Of TEstruturaPgto;

  TPagSeguroPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq: String;

    intPosicaoAtual: Integer;

    function RetornaTipoDoRegistro(ATipoEvento: String; ALiquidoAntecipacao: Double): String;

    function ImportaRegistro(ARegistro: TRegistroPgto): Boolean;

    function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaPagSeguroPgto): TStringList;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroPgto;
  End;

Const
  INICAM = 'PAG_';

Var
  strNomArq,
  strTipArq: String;

  ImportouPG: Boolean;

implementation

uses untFuncoes, untIDataSet;

{ TPagSeguroPgto }

constructor TPagSeguroPgto.Create;
Begin
  intPosicaoAtual := 0;

  ImportouPG := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* PAG_SEPGTO                                   *}
{*********************************************AJ*}
class function TPagSeguroPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroPgto;
Begin
  If strTabela = 'PAG_SEPGTO' Then
  Begin
    SetLength(Result, 31);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(2)'   ;
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := INICAM + 'TIPEVE'; Result[2].strTipCmp  := 'VARCHAR(2)'   ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'DTAPAG'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := INICAM + 'DTAAJU'; Result[5].strTipCmp  := 'DATE'         ;
    Result[6].strDescri  := INICAM + 'CODAUT'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := INICAM + 'TIPTRA'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'NUM_CV'; Result[8].strTipCmp  := 'VARCHAR(32)'  ;
    Result[9].strDescri  := INICAM + 'CODTRA'; Result[9].strTipCmp  := 'VARCHAR(32)'  ;
    Result[10].strDescri := INICAM + 'CODVEN'; Result[10].strTipCmp := 'VARCHAR(20)'  ;
    Result[11].strDescri := INICAM + 'VALBRU'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'VALPAR'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'TOTPAR'; Result[13].strTipCmp := 'VARCHAR(2)'   ;
    Result[14].strDescri := INICAM + 'NUMPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := INICAM + 'VALLIQ'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := INICAM + 'TAXANT'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := INICAM + 'LIQANT'; Result[17].strTipCmp := 'DECIMAL(15,2)';
    Result[18].strDescri := INICAM + 'STAPAG'; Result[18].strTipCmp := 'VARCHAR(2)'   ;
    Result[19].strDescri := INICAM + 'MEIPAG'; Result[19].strTipCmp := 'VARCHAR(2)'   ;
    Result[20].strDescri := INICAM + 'NUMNSU'; Result[20].strTipCmp := 'VARCHAR(12)'  ;
    Result[21].strDescri := INICAM + 'NUMCAR'; Result[21].strTipCmp := 'VARCHAR(19)'  ;
    Result[22].strDescri := INICAM + 'NOMARQ'; Result[22].strTipCmp := 'VARCHAR(255)' ;
    Result[23].strDescri := INICAM + 'DTAARQ'; Result[23].strTipCmp := 'DATE'         ;
    Result[24].strDescri := INICAM + 'CONCIL'; Result[24].strTipCmp := 'INT DEFAULT 0';
    Result[25].strDescri := INICAM + 'PAGPRA'; Result[25].strTipCmp := 'VARCHAR(1)'   ;
    Result[26].strDescri := INICAM + 'CANENT'; Result[26].strTipCmp := 'VARCHAR(2)'   ;
    Result[27].strDescri := INICAM + 'MEICAP'; Result[27].strTipCmp := 'VARCHAR(2)'   ;
    Result[28].strDescri := INICAM + 'TAXINT'; Result[28].strTipCmp := 'DECIMAL(15,2)';
    Result[29].strDescri := INICAM + 'TAXPAR'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri := INICAM + 'PLANO_'; Result[30].strTipCmp := 'VARCHAR(2)'   ;
  End;
End;

class function TPagSeguroPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaPagSeguroPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(PAG_CODEST,PAG_TIPREG,PAG_DTAPAG,PAG_TIPEVE,PAG_DTATRA,PAG_CODAUT,PAG_NUMPAR,PAG_NUMNSU)) ENGINE INNODB ' ;
end;

function TPagSeguroPgto.ImportaRegistro(ARegistro: TRegistroPgto): Boolean;
begin
  Result := True;

  If ARegistro.strTipEve = '04' Then
    Exit;

  If ARegistro.strTipReg = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strCodEst = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strTipTra <> '09' Then
  Begin
    If ARegistro.strMeiPag = '00' Then
    Begin
      Result := False;
      Exit;
    End;
    If ARegistro.strTipTra <> '01' Then
    Begin
      If ARegistro.strCodVen = '' Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;
end;

procedure TPagSeguroPgto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := fStrToFloat(rst) / 100;

    Result := rst;
  End;

begin
  If intPosicaoAtual >= Length(FRegPagSeguroPgto) - 1 Then
  Begin
    SetLength(FRegPagSeguroPgto, Length(FRegPagSeguroPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  Try
    If fGetDados(001,01) = '0' Then
    Begin
      dtaArq := fGetDados(012,08);
    End
    Else If (fGetDados(001,01) = '1') Then
    Begin
      Inc(intPosicaoAtual);

      FRegPagSeguroPgto[intPosicaoAtual-1].strTipEve := fGetDados(040,02);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltLiqAnt := fGetDados(269,13,True);

      FRegPagSeguroPgto[intPosicaoAtual-1].strTipReg := RetornaTipoDoRegistro(FRegPagSeguroPgto[intPosicaoAtual-1].strTipEve,
                                                                              FRegPagSeguroPgto[intPosicaoAtual-1].fltLiqAnt);

      FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,10);
      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaTra := fGetDados(012,08);
      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaAju := fGetDados(026,08);
      FRegPagSeguroPgto[intPosicaoAtual-1].strTipTra := fGetDados(042,02);
      FRegPagSeguroPgto[intPosicaoAtual-1].strCodTra := fGetDados(046,32);
      FRegPagSeguroPgto[intPosicaoAtual-1].strCodVen := fGetDados(078,20);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltValBru := fGetDados(098,13,True);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltValPar := fGetDados(111,13,True);

      FRegPagSeguroPgto[intPosicaoAtual-1].PagamentoAPrazo := 'M';

      FRegPagSeguroPgto[intPosicaoAtual-1].TaxaIntermediacao := 0.00;
      FRegPagSeguroPgto[intPosicaoAtual-1].TaxaParcelamento := 0.00;

      If strTipArq = '02' Then
      Begin
        FRegPagSeguroPgto[intPosicaoAtual-1].PagamentoAPrazo := fGetDados(124,1);
        FRegPagSeguroPgto[intPosicaoAtual-1].Plano := Trim(fGetDados(125,2));
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumPar := fGetDados(127,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strTotPar := fGetDados(129,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strDtaPag := fGetDados(131,08);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltValLiq := fGetDados(243,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltTaxAnt := fGetDados(256,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].strStaPag := fGetDados(282,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strMeiPag := fGetDados(286,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(387,14);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumCar := fGetDados(401,06) + '*********' + fGetDados(407,04);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCodAut := fGetDados(411,06);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCod_CV := fGetDados(417,32);

        FRegPagSeguroPgto[intPosicaoAtual-1].CanalDeEntrada := fGetDados(318,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].MeioDeCaptura := fGetDados(322,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].TaxaIntermediacao := fGetDados(191,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].TaxaParcelamento := fGetDados(178,13,True);

        If FRegPagSeguroPgto[intPosicaoAtual-1].strTipReg = 'TF' Then
          FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(046,32);
      End
      Else
      Begin
        FRegPagSeguroPgto[intPosicaoAtual-1].Plano := Trim(fGetDados(124,2));
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumPar := fGetDados(126,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strTotPar := fGetDados(128,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strDtaPag := fGetDados(138,08);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltValLiq := fGetDados(172,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltTaxAnt := fGetDados(159,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].strStaPag := fGetDados(185,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strMeiPag := '04';
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(219,14);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumCar := fGetDados(233,06) + '*********' + fGetDados(239,04);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCodAut := fGetDados(243,06);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCod_CV := fGetDados(249,32);

        FRegPagSeguroPgto[intPosicaoAtual-1].CanalDeEntrada := '';
        FRegPagSeguroPgto[intPosicaoAtual-1].MeioDeCaptura := '';
      End;

      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegPagSeguroPgto[intPosicaoAtual-1].strNomArq := strNomArq;

      If (FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst <> '') Then
      Begin
        If (lstEstabel.IndexOf(FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst) < 0) Then
          lstEstabel.Add(FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst);
      End;

    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TPagSeguroPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL := RetornaSQLReplace('PAG_SEPGTO',
                              RetornaListaDeCampos(fRetEstruturaPgto('PAG_SEPGTO')),
                              [INICAM + 'CONCIL']);

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  Try
    If Length(FRegPagSeguroPgto) > 0 Then
    Begin
      pgbProg.Max      := Length(FRegPagSeguroPgto) - 1;
      For intCont := 0 To Length(FRegPagSeguroPgto) - 1 Do
      Begin
        If ImportaRegistro(FRegPagSeguroPgto[intCont]) Then
        Begin
          Application.ProcessMessages;

          If MatchStr(FRegPagSeguroPgto[intCont].strTipReg, ['PG', 'AP', 'AJ', 'TF']) Then
            ImportouPG := True;

          qryDados.Close;
          qryDados.ParamByName(INICAM + 'TIPREG').Value   := fRetVal(FRegPagSeguroPgto[intCont].strTipReg);
          qryDados.ParamByName(INICAM + 'CODEST').Value   := fRetVal(FRegPagSeguroPgto[intCont].strCodEst);
          qryDados.ParamByName(INICAM + 'TIPEVE').Value   := fRetVal(FRegPagSeguroPgto[intCont].strTipEve);
          qryDados.ParamByName(INICAM + 'NUM_CV').Value   := fRetVal(FRegPagSeguroPgto[intCont].strCod_CV);
          qryDados.ParamByName(INICAM + 'DTATRA').Value   := fRetVal(FRegPagSeguroPgto[intCont].strDtaTra, True);
          qryDados.ParamByName(INICAM + 'DTAPAG').Value   := fRetVal(FRegPagSeguroPgto[intCont].strDtaPag, True);
          qryDados.ParamByName(INICAM + 'DTAAJU').Value   := fRetVal(FRegPagSeguroPgto[intCont].strDtaAju, True);
          qryDados.ParamByName(INICAM + 'TIPTRA').Value   := fRetVal(FRegPagSeguroPgto[intCont].strTipTra);
          qryDados.ParamByName(INICAM + 'TOTPAR').Value   := fRetVal(FRegPagSeguroPgto[intCont].strTotPar);
          qryDados.ParamByName(INICAM + 'NUMPAR').Value   := fRetVal(FRegPagSeguroPgto[intCont].strNumPar);
          qryDados.ParamByName(INICAM + 'VALPAR').Value   := fRetVal(FRegPagSeguroPgto[intCont].fltValPar);
          qryDados.ParamByName(INICAM + 'CODAUT').Value   := fRetVal(FRegPagSeguroPgto[intCont].strCodAut);
          qryDados.ParamByName(INICAM + 'NUMNSU').Value   := fRetVal(FRegPagSeguroPgto[intCont].strNumNSU);

          If (Not MatchStr(fRetVal(FRegPagSeguroPgto[intCont].strMeiPag), ['03', '08', '11'])) Then
          Begin
            If (FRegPagSeguroPgto[intCont].strCodAut = '') Then
              qryDados.ParamByName(INICAM + 'CODAUT').Value   := LeftStr(FRegPagSeguroPgto[intCont].strCodVen, 6);

            If FRegPagSeguroPgto[intCont].strNumNsu = '' Then
            Begin
              If (FRegPagSeguroPgto[intCont].strTipTra <> '09') And (FRegPagSeguroPgto[intCont].strCodVen <> '') Then
                qryDados.ParamByName(INICAM + 'NUMNSU').Value   := LeftStr(FRegPagSeguroPgto[intCont].strCodVen, 11)
              Else
                qryDados.ParamByName(INICAM + 'NUMNSU').Value   := LeftStr(FRegPagSeguroPgto[intCont].strCodTra, 11);
            End;

            If fEmptyStr(qryDados.ParamByName(INICAM + 'CODAUT').AsString) Then
              qryDados.ParamByName(INICAM + 'CODAUT').AsString := qryDados.ParamByName(INICAM + 'NUMNSU').AsString;
          End
          Else If FRegPagSeguroPgto[intCont].strMeiPag = '11' Then
          Begin
            qryDados.ParamByName(INICAM + 'CODAUT').Value := RightStr(fRetVal(FRegPagSeguroPgto[intCont].strCodTra), 6);
            qryDados.ParamByName(INICAM + 'NUMNSU').Value := RightStr(fRetVal(FRegPagSeguroPgto[intCont].strCodTra), 11);
          End;

          If qryDados.ParamByName(INICAM + 'NUMNSU').AsString = '' Then
            Continue;

          qryDados.ParamByName(INICAM + 'NUMCAR').Value   := fRetVal(FRegPagSeguroPgto[intCont].strNumCar);
          qryDados.ParamByName(INICAM + 'CODTRA').Value   := fRetVal(FRegPagSeguroPgto[intCont].strCodTra);
          qryDados.ParamByName(INICAM + 'CODVEN').Value   := fRetVal(FRegPagSeguroPgto[intCont].strCodVen);
          qryDados.ParamByName(INICAM + 'VALBRU').Value   := fRetVal(FRegPagSeguroPgto[intCont].fltValBru);
          qryDados.ParamByName(INICAM + 'VALLIQ').Value   := fRetVal(FRegPagSeguroPgto[intCont].fltValLiq);
          qryDados.ParamByName(INICAM + 'LIQANT').Value   := fRetVal(FRegPagSeguroPgto[intCont].fltLiqAnt);
          qryDados.ParamByName(INICAM + 'TAXANT').Value   := fRetVal(FRegPagSeguroPgto[intCont].fltTaxAnt);
          qryDados.ParamByName(INICAM + 'STAPAG').Value   := fRetVal(FRegPagSeguroPgto[intCont].strStaPag);
          qryDados.ParamByName(INICAM + 'MEIPAG').Value   := fRetVal(FRegPagSeguroPgto[intCont].strMeiPag);
          qryDados.ParamByName(INICAM + 'NOMARQ').Value   := fRetVal(FRegPagSeguroPgto[intCont].strNomArq);
          qryDados.ParamByName(INICAM + 'DTAARQ').Value   := fRetVal(FRegPagSeguroPgto[intCont].strDtaArq, True);

          qryDados.ParamByName(INICAM + 'PAGPRA').Value   := fRetVal(FRegPagSeguroPgto[intCont].PagamentoAPrazo);
          qryDados.ParamByName(INICAM + 'CANENT').Value   := fRetVal(FRegPagSeguroPgto[intCont].CanalDeEntrada);
          qryDados.ParamByName(INICAM + 'MEICAP').Value   := fRetVal(FRegPagSeguroPgto[intCont].MeioDeCaptura);

          qryDados.ParamByName(INICAM + 'TAXINT').Value   := fRetVal(FRegPagSeguroPgto[intCont].TaxaIntermediacao);
          qryDados.ParamByName(INICAM + 'TAXPAR').Value   := fRetVal(FRegPagSeguroPgto[intCont].TaxaParcelamento);

          If qryDados.ParamByName(INICAM + 'PLANO_') <> Nil Then
            qryDados.ParamByName(INICAM + 'PLANO_').Value := fRetVal(FRegPagSeguroPgto[intCont].Plano);

          qryDados.ExecSQL;
        End;
        pgbProg.Position := pgbProg.Position + 1;
      End;

      Try
        qryDados.Close;
        qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "PAGSEGURO")';
        For intCont := 0 To lstEstabel.Count - 1 Do
        Begin
          qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
          qryDados.ExecSQL;
        End;

        FreeAndNil(lstEstabel);
      Except
        Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
      End;

      pgbProg.Position := Length(FRegPagSeguroPgto) - 1;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TPagSeguroPgto.RetornaTipoDoRegistro(ATipoEvento: String;
  ALiquidoAntecipacao: Double): String;
begin
  Result := 'PG';

  If strTipArq = '03' Then
    Result := 'AP'
  Else If (ATipoEvento = '04') Then
    Result := 'TF'
  Else If (ATipoEvento <> '01') Then
    Result := 'AJ'
  Else If (ALiquidoAntecipacao <> 0) Then
    Result := 'AT';
end;

function TPagSeguroPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaPagSeguroPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

end.
