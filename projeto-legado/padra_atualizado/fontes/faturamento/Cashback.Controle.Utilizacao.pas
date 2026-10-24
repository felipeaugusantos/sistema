{******************************************************************************}
{* OS MÉTODOS DESSA CLASSE DEVEM SER EXECUTADOS PELA CLASSE TControleCashback *}
{* DA UNIT Cashback.Controle                                                  *}
{**************************************************************************WL**}

unit Cashback.Controle.Utilizacao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, UniClientDataSet,
{$ENDIF}
  untFuncoesGenerica, System.Classes, System.SysUtils, System.StrUtils, Uni,
  Cashback.Classes, Data.DB, System.Generics.Collections;

type
  TControleUtilizacaoCashback = class sealed
  private
    FstrNumDoc,
    FstrEspDoc,
    FstrCodEmp,
    FstrCodCli,
    FstrOrigem,
    FstrFonCli,
    FstrCpfCli               : String;
    FListaCashbackUtilizados : TList<TUtilizacaoCashback>;

    procedure SetCodEmp(const Value: String);
    procedure SetEspDoc(const Value: String);
    procedure SetNumDoc(const Value: String);
    procedure SetCodCli(const Value: String);
    procedure SetOrigem(const Value: String);
    procedure SetCpfCli(const Value: String);
    procedure SetFonCli(const Value: String);

  private
    function fPermitirProcessar: Boolean;
    procedure pCarregarListaCashbackDisponivelVenda;
    function fValorReferenciaItensVenda(const strCodCsh: String;
      const cdsItensVenda: TUniClientDataSet): Double;
    function fCalcularValorTotalVenda(const cdsItensVenda: TUniClientDataSet): Double;

  public
    constructor Create;
    destructor Destroy; override;

    procedure pLimparObjeto;

    function fPossuiSaldoCashbackCliente(const dtaDtaVen: TDateTime;
      out strMensagem: String): Boolean;

    function fCashbackDisponivelCliente(const dtaDtaVen: TDateTime;
      const cdsItensVenda: TUniClientDataSet; out strMensagem: String): Double;

    function fProcessar: Boolean;
    procedure pAtualizaUtilizacaoCashbackVenda;
    function fCalcularSaldoCashbackDevolver: Boolean;
    function fValorDescontoCashbackDocumento: Double;

    property strNumDoc               : String                     write SetNumDoc;
    property strEspDoc               : String                     write SetEspDoc;
    property strCodEmp               : String                     write SetCodEmp;
    property strCodCli               : String                     write SetCodCli;
    property strOrigem               : String                     write SetOrigem;
    property strFonCli               : String                     write SetFonCli;
    property strCpfCli               : String                     write SetCpfCli;

    property ListaCashbackUtilizados : TList<TUtilizacaoCashback> read FListaCashbackUtilizados;

  end;

implementation

{ TControleUtilizacaoCashback }

constructor TControleUtilizacaoCashback.Create;
begin
  FListaCashbackUtilizados := TList<TUtilizacaoCashback>.Create;

  pLimparObjeto;
end;

function TControleUtilizacaoCashback.fPermitirProcessar: Boolean;
begin
  Result := (Not fEmptyStr(FstrNumDoc)) And
            (Not fEmptyStr(FstrEspDoc)) And
            (Not fEmptyStr(FstrCodEmp)) And
            (MatchStr(FstrEspDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK));
end;

function TControleUtilizacaoCashback.fPossuiSaldoCashbackCliente(
  const dtaDtaVen: TDateTime; out strMensagem: String): Boolean;
var
  qryConsulta            : TUniQuery;
  fltSaldoCashback       : Double;
  blnEhClienteConsumidor : Boolean;
begin
  If (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK)) Then
    Exit(False);

  qryConsulta := nil;
  Try
    blnEhClienteConsumidor := fClienteConsumidor(fRetNomCliente(FstrCodCli), True, True);

    qryConsulta := fCriaQuery;
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       SUM(V.VCB_VLRDSP) AS TOTAL_CASHBACK '
                          + '  FROM VENCSH V '
                          + ' WHERE IFNULL(V.VCB_VLRDSP,0) > 0 '
                          + '   AND V.VCB_STATUS = "A" '
                          + '   AND :DTAVEN BETWEEN IFNULL(V.VCB_INIVAL, V.VCB_DTAENT) AND V.VCB_DTAVAL ';

    If blnEhClienteConsumidor Then
    Begin
      If (fCfgSis('CLCCSH') = '1') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_TELCON = :TELCON ';
      End
      Else If (fCfgSis('CLCCSH') = '2') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_CGCCON = :CGCCON ';
      End
      Else If (fCfgSis('CLCCSH') = '3') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_CODCLI = :CODCLI ';
      End;
    End
    Else
    Begin
      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + '   AND V.VCB_CODCLI = :CODCLI ';
    End;

    If (Not blnEhClienteConsumidor) Or
       (blnEhClienteConsumidor And
       (fCfgSis('CLCCSH') = '3')) Then
    Begin
      qryConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
    End;

    If blnEhClienteConsumidor Then
    Begin
      If (fCfgSis('CLCCSH') = '1') Then
        qryConsulta.ParamByName('TELCON').AsString := FstrFonCli
      Else If (fCfgSis('CLCCSH') = '2') Then
        qryConsulta.ParamByName('CGCCON').AsString := FstrCpfCli;
    End;

    qryConsulta.ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
    qryConsulta.Open;

    fltSaldoCashback := qryConsulta.FieldByName('TOTAL_CASHBACK').AsFloat;

    If (Not fEmptyStr(FstrNumDoc)) Then
    Begin
      qryConsulta.Close;
      qryConsulta.SQL.Text := 'SELECT '
                            + '       IFNULL(SUM(U.UCB_VLRUTI),0) AS VALOR_CASHBACK_VENDA '
                            + '  FROM UTICSH U '
                            + ' WHERE U.UCB_NUMPED = :NUMDOC '
                            + '   AND U.UCB_ESPPED = :ESPDOC '
                            + '   AND U.UCB_EMPPED = :CODEMP ';

      qryConsulta.ParamByName('NUMDOC').AsString := FstrNumDoc;
      qryConsulta.ParamByName('ESPDOC').AsString := FstrEspDoc;
      qryConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
      qryConsulta.Open;

      fltSaldoCashback := fltSaldoCashback
                        + qryConsulta.FieldByName('VALOR_CASHBACK_VENDA').AsFloat;
    End;

    Result := fltSaldoCashback > 0;

    If Result Then
      strMensagem := 'O cliente possui cashback de R$ ' + FormatFloat(',0.00', fltSaldoCashback);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TControleUtilizacaoCashback.fProcessar: Boolean;
begin
  If (Not fPermitirProcessar) Then
    Exit(False);

  pAtualizaUtilizacaoCashbackVenda;
  pCarregarListaCashbackDisponivelVenda;

  Result := FListaCashbackUtilizados.Count > 0;
end;

function TControleUtilizacaoCashback.fValorDescontoCashbackDocumento: Double;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT '
                       + '       SUM(UCB_VLRUTI) AS TOTAL_CASHBACK '
                       + '  FROM UTICSH '
                       + ' WHERE UCB_NUMPED = :NUMDOC '
                       + '   AND UCB_ESPPED = :ESPDOC '
                       + '   AND UCB_EMPPED = :CODEMP ';

    qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryDados.Open;

    Result := qryDados.FieldByName('TOTAL_CASHBACK').AsFloat;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleUtilizacaoCashback.fValorReferenciaItensVenda(
  const strCodCsh: String; const cdsItensVenda: TUniClientDataSet): Double;
var
  qryConsulta : TUniQuery;
begin
  Result := 0;

  If (Not cdsItensVenda.Active) And
     (cdsItensVenda.RecordCount = 0) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT I.CSH_CODITE '
                          + '  FROM ITUCSH I '
                          + ' INNER JOIN CADCSH C ON C.AUTOINCREM = I.CSH_SEQCSH '
                          + ' WHERE C.CSH_CODIGO = :CODCSH ';
    qryConsulta.ParamByName('CODCSH').AsString := strCodCsh;
    qryConsulta.Open;

    cdsItensVenda.First;
    While Not cdsItensVenda.Eof Do
    Begin
      If (cdsItensVenda.FieldByName('ITE_PROMOC').AsString = 'S') And
         (fCfgSis('PROMCB') = 'N')  Then
      Begin
        cdsItensVenda.Next;
        Continue;
      End;

      If qryConsulta.Locate('CSH_CODITE', cdsItensVenda.FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        Result := Result
                + cdsItensVenda.FieldByName('ITE_TOTITE').AsFloat;
      End;

      cdsItensVenda.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TControleUtilizacaoCashback.pCarregarListaCashbackDisponivelVenda;
var
  strSQL        : String;
  objUtilizacao : TUtilizacaoCashback;
  qryConsulta   : TUniQuery;
begin
  If (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK)) Then
    Exit;

  If (FListaCashbackUtilizados.Count = 0) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    If FstrEspDoc = 'PD' Then
    Begin
      strSQL := 'SELECT '
              + '       FGO_DTAENT AS DTAENT '
              + '     , FGO_NUMDOC AS NUMDOC '
              + '     , FGO_ESPDOC AS ESPDOC '
              + '     , FGO_CODEMP AS CODEMP '
              + '  FROM FATGOR '
              + ' WHERE FGO_NUMDOC = :NUMDOC '
              + '   AND FGO_ESPDOC = :ESPDOC '
              + '   AND FGO_CODEMP = :CODEMP ';
    End
    Else
    Begin
      strSQL := 'SELECT '
              + '       GER_DTAENT AS DTAENT '
              + '     , GER_NUMDOC AS NUMDOC '
              + '     , GER_ESPDOC AS ESPDOC '
              + '     , GER_CODEMP AS CODEMP '
              + '  FROM MOVGER '
              + ' WHERE GER_NUMDOC = :NUMDOC '
              + '   AND GER_ESPDOC = :ESPDOC '
              + '   AND GER_CODEMP = :CODEMP ';
    End;

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSQL;

    qryConsulta.ParamByName('NUMDOC').AsString   := FstrNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString   := FstrEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString   := FstrCodEmp;
    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Exit;

    For objUtilizacao In FListaCashbackUtilizados Do
    Begin
      objUtilizacao.dtaDtaUti := qryConsulta.FieldByName('DTAENT').AsDateTime;
      objUtilizacao.strNumPed := qryConsulta.FieldByName('NUMDOC').AsString;
      objUtilizacao.strEspPed := qryConsulta.FieldByName('ESPDOC').AsString;
      objUtilizacao.strEmpPed := qryConsulta.FieldByName('CODEMP').AsString;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TControleUtilizacaoCashback.pLimparObjeto;
begin
  FstrNumDoc := EmptyStr;
  FstrEspDoc := EmptyStr;
  FstrCodEmp := EmptyStr;
  FstrCodCli := EmptyStr;
  FstrOrigem := EmptyStr;
  FstrFonCli := EmptyStr;
  FstrCpfCli := EmptyStr;
end;

procedure TControleUtilizacaoCashback.pAtualizaUtilizacaoCashbackVenda;
var
  qryDeletar      : TUniQuery;
  qryRetornaSaldo : TUniQuery;
begin
  qryDeletar      := fCriaQuery;
  qryRetornaSaldo := fCriaQuery;
  Try
    qryRetornaSaldo.Close;
    qryRetornaSaldo.SQL.Text := 'UPDATE VENCSH V '
                              + '   SET VCB_VLRDSP = VCB_VLRDSP '
                              + '                  + (SELECT IFNULL(SUM(U.UCB_VLRUTI),0) '
                              + '                       FROM UTICSH U '
                              + '                      WHERE U.UCB_NUMCSH = V.VCB_NUMCSH '
                              + '                        AND U.UCB_NUMPED = :NUMDOC '
                              + '                        AND U.UCB_ESPPED = :ESPDOC '
                              + '                        AND U.UCB_EMPPED = :CODEMP) '
                              + ' WHERE EXISTS (SELECT U.AUTOINCREM '
                              + '                 FROM UTICSH U '
                              + '                WHERE U.UCB_NUMCSH = V.VCB_NUMCSH '
                              + '                  AND U.UCB_NUMPED = :NUMDOC '
                              + '                  AND U.UCB_ESPPED = :ESPDOC '
                              + '                  AND U.UCB_EMPPED = :CODEMP) ';

    qryRetornaSaldo.Close;
    qryRetornaSaldo.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryRetornaSaldo.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryRetornaSaldo.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryRetornaSaldo.ExecSQL;

    qryDeletar.Close;
    qryDeletar.SQL.Text := 'DELETE FROM UTICSH '
                         + ' WHERE UCB_NUMPED = :NUMDOC '
                         + '   AND UCB_ESPPED = :ESPDOC '
                         + '   AND UCB_EMPPED = :CODEMP ';

    qryDeletar.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryDeletar.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryDeletar.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryDeletar.ExecSQL;
  Finally
    FreeAndNil(qryRetornaSaldo);
    FreeAndNil(qryDeletar);
  End;
end;

destructor TControleUtilizacaoCashback.Destroy;
begin
  FreeAndNil(FListaCashbackUtilizados);
  inherited;
end;

function TControleUtilizacaoCashback.fCalcularSaldoCashbackDevolver: Boolean;
var
  qryDados              : TUniQuery;
  objUtilizacaoCashback : TUtilizacaoCashback;
  fltValorUtilizado     : Double;
begin
  Result := False;

  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT '
                       + '       X.DET_DESCSH AS TOTAL_CASHBACK_ITEM '
                       + '     , M.DET_TOTITE AS TOTAL_VENDA_ITEM '
                       + '     , M.DET_QTDITE AS QTDE_VENDA_ITEM '
                       + '     , D.DET_QTDITE AS QTDE_DEV_ITEM '
                       + '     , G.GER_DTAENT '
                       + '     , V.VCB_NUMCSH '
                       + '     , V.VCB_VLRCSH '
                       + '     , V.VCB_VLRDSP '
                       + '  FROM MOVGER G '
                       + ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '
                       + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM '
                       + ' INNER JOIN VENCSH V ON V.VCB_NUMDOC = D.DET_DOCDEV '
                       + '                    AND V.VCB_ESPDOC = D.DET_ESPDEV '
                       + '                    AND V.VCB_CODEMP = D.DET_EMPDEV '
                       + ' INNER JOIN MOVDET M ON M.AUTOINCREM = T.DET_INCDEV '
                       + ' INNER JOIN MOVAUX X ON X.DET_SEQGER = M.AUTOINCREM '
                       + ' WHERE G.GER_NUMDOC = :NUMDOC '
                       + '   AND G.GER_ESPDOC = :ESPDOC '
                       + '   AND G.GER_CODEMP = :CODEMP ';

    qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;
      qryDados.SQL.Text := 'SELECT '
                         + '       X.DET_DESCSH AS TOTAL_CASHBACK_ITEM '
                         + '     , P.DET_TOTITE AS TOTAL_VENDA_ITEM '
                         + '     , P.DET_QTDITE AS QTDE_VENDA_ITEM '
                         + '     , D.DET_QTDITE AS QTDE_DEV_ITEM '
                         + '     , G.GER_DTAENT '
                         + '     , V.VCB_NUMCSH '
                         + '     , V.VCB_VLRCSH '
                         + '     , V.VCB_VLRDSP '
                         + '  FROM MOVGER G '
                         + ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '
                         + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM '
                         + ' INNER JOIN MOVDET B ON B.AUTOINCREM = T.DET_INCDEV '
                         + ' INNER JOIN MOVTRI R ON R.DET_SEQGER = B.AUTOINCREM '
                         + ' INNER JOIN MOVDET P ON P.AUTOINCREM = R.DET_INCFUT '
                         + ' INNER JOIN MOVAUX X ON X.DET_SEQGER = P.AUTOINCREM '
                         + ' INNER JOIN VENCSH V ON V.VCB_NUMDOC = P.DET_NUMDOC '
                         + '                    AND V.VCB_ESPDOC = P.DET_ESPDOC '
                         + '                    AND V.VCB_CODEMP = P.DET_CODEMP '
                         + ' WHERE G.GER_NUMDOC = :NUMDOC '
                         + '   AND G.GER_ESPDOC = :ESPDOC '
                         + '   AND G.GER_CODEMP = :CODEMP ';

      qryDados.ParamByName('NUMDOC').AsString := FstrNumDoc;
      qryDados.ParamByName('ESPDOC').AsString := FstrEspDoc;
      qryDados.ParamByName('CODEMP').AsString := FstrCodEmp;
      qryDados.Open;
    End;

    fltValorUtilizado := 0;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      fltValorUtilizado := fFormataFloat(fltValorUtilizado
                                       + (qryDados.FieldByName('TOTAL_CASHBACK_ITEM').AsFloat
                                       /  qryDados.FieldByName('QTDE_VENDA_ITEM').AsFloat
                                       *  qryDados.FieldByName('QTDE_DEV_ITEM').AsFloat), 2);

      qryDados.Next;
    End;

    If fltValorUtilizado > 0 Then
    Begin
      objUtilizacaoCashback := TUtilizacaoCashback.Create;
      objUtilizacaoCashback.strNumCsh := qryDados.FieldByName('VCB_NUMCSH').AsString;
      objUtilizacaoCashback.fltVlrUti := fltValorUtilizado;
      objUtilizacaoCashback.dtaDtaUti := qryDados.FieldByName('GER_DTAENT').AsDateTime;
      objUtilizacaoCashback.strNumPed := FstrNumDoc;
      objUtilizacaoCashback.strEspPed := FstrEspDoc;
      objUtilizacaoCashback.strEmpPed := FstrCodEmp;
      FListaCashbackUtilizados.Add(objUtilizacaoCashback);

      Result := True;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TControleUtilizacaoCashback.fCalcularValorTotalVenda(
  const cdsItensVenda: TUniClientDataSet): Double;
begin
  Result := 0;

  If (Not cdsItensVenda.Active) And
     (cdsItensVenda.RecordCount = 0) Then
    Exit;

  cdsItensVenda.First;
  While Not cdsItensVenda.Eof Do
  Begin
    If (cdsItensVenda.FieldByName('ITE_PROMOC').AsString = 'S') And
       (fCfgSis('PROMCB') = 'N')  Then
    Begin
      cdsItensVenda.Next;
      Continue;
    End;

    Result := Result
            + cdsItensVenda.FieldByName('ITE_TOTITE').AsFloat;

    cdsItensVenda.Next;
  End;
end;

function TControleUtilizacaoCashback.fCashbackDisponivelCliente(
  const dtaDtaVen: TDateTime; const cdsItensVenda: TUniClientDataSet;
  out strMensagem: String): Double;
var
  qryConsulta                 : TUniQuery;
  fltValorVenda,
  fltValorReferencia,
  fltValorUtilizavel,
  fltTotalCashback,
  fltTotalDescontoCashback,
  fltValorSobrePercMaximo,
  fltValorMaximoDesconto,
  fltSaldoValorMaximoDesconto : Double;
  blnEhClienteConsumidor      : Boolean;
  objUtilizacao               : TUtilizacaoCashback;
begin
  Result := 0;
  FListaCashbackUtilizados.Clear;
  blnEhClienteConsumidor := fClienteConsumidor(fRetNomCliente(FstrCodCli), True, True);

  If blnEhClienteConsumidor Then
  Begin
    If (fCfgSis('CLCCSH') = '1') And (fEmptyStr(FstrFonCli)) Then
      Exit;

    If (fCfgSis('CLCCSH') = '2') And (fEmptyStr(FstrCpfCli)) Then
      Exit;

    If (fCfgSis('CLCCSH') = '3') And (fEmptyStr(FstrCodCli)) Then
      Exit;
  End
  Else
  Begin
    If (fEmptyStr(FstrCodCli)) Then
      Exit;
  End;

  If FstrOrigem = 'V' Then
  Begin
    If (Not MatchStr(FstrEspDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK)) Then
      Exit;

    fltValorVenda := fCalcularValorTotalVenda(cdsItensVenda);
    If fltValorVenda = 0 Then
      Exit;
  End
  Else
    fltValorVenda := 0;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       V.AUTOINCREM '
                          + '     , V.VCB_NUMCSH '
                          + '     , V.VCB_SEQGER '
                          + '     , V.VCB_DTAENT '
                          + '     , V.VCB_CODCLI '
                          + '     , V.VCB_NUMDOC '
                          + '     , V.VCB_ESPDOC '
                          + '     , V.VCB_CODEMP '
                          + '     , V.VCB_CODCSH '
                          + '     , V.VCB_RESCAL '
                          + '     , V.VCB_INIVAL '
                          + '     , V.VCB_DTAVAL '
                          + '     , V.VCB_VLRDOC '
                          + '     , V.VCB_VLRCSH '
                          + '     , V.VCB_VLRDSP '
                          + '     + (SELECT IFNULL(SUM(U.UCB_VLRUTI),0) FROM UTICSH U '
                          + '         WHERE U.UCB_NUMCSH = V.VCB_NUMCSH '
                          + '           AND U.UCB_NUMPED = :NUMDOC '
                          + '           AND U.UCB_ESPPED = :ESPDOC '
                          + '           AND U.UCB_EMPPED = :CODEMP) AS VCB_VLRDSP '
                          + '     , V.VCB_MINPRX '
                          + '     , V.VCB_PERMAX '
                          + '     , V.VCB_STATUS '
                          + '     , C.CSH_UTIITE '
                          + '  FROM VENCSH V '
                          + ' INNER JOIN CADCSH C ON C.CSH_CODIGO = V.VCB_CODCSH '
                          + ' WHERE TRUE ';

    If blnEhClienteConsumidor Then
    Begin
      If (fCfgSis('CLCCSH') = '1') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_TELCON = :TELCON ';
      End
      Else If (fCfgSis('CLCCSH') = '2') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_CGCCON = :CGCCON ';
      End
      Else If (fCfgSis('CLCCSH') = '3') Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND V.VCB_CODCLI = :CODCLI ';
      End;
    End
    Else
    Begin
      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + '   AND V.VCB_CODCLI = :CODCLI ';
    End;

    qryConsulta.SQL.Text := qryConsulta.SQL.Text
                          + '   AND (IFNULL(V.VCB_VLRDSP,0) + '
                          + '     +  (SELECT IFNULL(SUM(U.UCB_VLRUTI),0) FROM UTICSH U '
                          + '          WHERE U.UCB_NUMCSH = V.VCB_NUMCSH '
                          + '            AND U.UCB_NUMPED = :NUMDOC '
                          + '            AND U.UCB_ESPPED = :ESPDOC '
                          + '            AND U.UCB_EMPPED = :CODEMP) > 0) '
                          + '   AND V.VCB_STATUS = "A" '
                          + '   AND :DTAVEN BETWEEN IFNULL(V.VCB_INIVAL, V.VCB_DTAENT) AND V.VCB_DTAVAL '
                          + ' ORDER BY '
                          + '       V.VCB_DTAVAL '
                          + '     , V.VCB_DTAENT ';

    If (Not blnEhClienteConsumidor) Or
       (blnEhClienteConsumidor And
       (fCfgSis('CLCCSH') = '3')) Then
    Begin
      qryConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
    End;

    qryConsulta.ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
    qryConsulta.ParamByName('NUMDOC').AsString   := FstrNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString   := FstrEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString   := FstrCodEmp;

    If blnEhClienteConsumidor Then
    Begin
      If (fCfgSis('CLCCSH') = '1') Then
        qryConsulta.ParamByName('TELCON').AsString := FstrFonCli
      Else If (fCfgSis('CLCCSH') = '2') Then
        qryConsulta.ParamByName('CGCCON').AsString := FstrCpfCli;
    End;

    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Exit;

    fltTotalCashback            := 0;
    fltTotalDescontoCashback    := 0;
    fltValorMaximoDesconto      := fltValorVenda *
                                   (fStrToFloat(fCfgSis('PMVCSH')) / 100);
    fltSaldoValorMaximoDesconto := fltValorMaximoDesconto;

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      fltValorUtilizavel := 0;
      fltTotalCashback   := fltTotalCashback
                          + qryConsulta.FieldByName('VCB_VLRDSP').AsFloat;

      If FstrOrigem = 'V' Then
      Begin
        If FormatFloat(',0.00', fltTotalDescontoCashback) =
           FormatFloat(',0.00', fltValorMaximoDesconto) Then
        Begin
          qryConsulta.Next;
          Continue;
        End;

        If (qryConsulta.FieldByName('CSH_UTIITE').AsString = 'S') Then
        Begin
          fltValorReferencia := fValorReferenciaItensVenda(
                                   qryConsulta.FieldByName('VCB_CODCSH').AsString,
                                   cdsItensVenda);
        End
        Else
          fltValorReferencia := fltValorVenda;

        If fltValorReferencia >= qryConsulta.FieldByName('VCB_MINPRX').AsFloat Then
        Begin
          fltValorSobrePercMaximo := fltValorReferencia
                                   * (qryConsulta.FieldByName('VCB_PERMAX').AsFloat/100);

          If qryConsulta.FieldByName('VCB_VLRDSP').AsFloat > fltValorSobrePercMaximo Then
            fltValorUtilizavel := fltValorSobrePercMaximo
          Else
            fltValorUtilizavel := qryConsulta.FieldByName('VCB_VLRDSP').AsFloat;
        End;

        If fltValorUtilizavel > 0 Then
        Begin
          fltTotalDescontoCashback := fltTotalDescontoCashback
                                    + fltValorUtilizavel;

          If fltTotalDescontoCashback > fltValorMaximoDesconto Then
          Begin
            fltValorUtilizavel       := fltSaldoValorMaximoDesconto;
            fltTotalDescontoCashback := fltValorMaximoDesconto;
          End;

          objUtilizacao := TUtilizacaoCashback.Create;
          objUtilizacao.strNumCsh := qryConsulta.FieldByName('VCB_NUMCSH').AsString;
          objUtilizacao.fltVlrUti := fltValorUtilizavel;
          FListaCashbackUtilizados.Add(objUtilizacao);

          fltSaldoValorMaximoDesconto := fltSaldoValorMaximoDesconto
                                       - fltValorUtilizavel;
        End;
      End;

      qryConsulta.Next;
    End;

    If FstrOrigem = 'V' Then
    Begin
      Result := fltTotalDescontoCashback;

      If Result > 0 Then
        strMensagem := 'O cliente possui cashback de R$ '
                     + FormatFloat(',0.00', fltTotalCashback)
                     + ' no total e pode utilizar R$ '
                     + FormatFloat(',0.00', fltTotalDescontoCashback)
                     + ' nesta venda.';
    End
    Else
      Result := fltTotalCashback;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TControleUtilizacaoCashback.SetCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TControleUtilizacaoCashback.SetCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TControleUtilizacaoCashback.SetCpfCli(const Value: String);
begin
  FstrCpfCli := Value;
end;

procedure TControleUtilizacaoCashback.SetEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TControleUtilizacaoCashback.SetFonCli(const Value: String);
begin
  FstrFonCli := Value;
end;

procedure TControleUtilizacaoCashback.SetNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TControleUtilizacaoCashback.SetOrigem(const Value: String);
begin
  FstrOrigem := Value;
end;

end.
