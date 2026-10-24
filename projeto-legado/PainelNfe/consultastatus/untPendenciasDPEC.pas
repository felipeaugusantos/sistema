unit untPendenciasDPEC;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
  ActiveX,
{$ENDIF}
  SysUtils,
  Classes,
  Variants,
  StrUtils,
  DB,
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ,untRegistrarTarefa;

  type
    TPendenciasDPEC = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa: TRegistrarTarefa;
  public
    constructor Create(ATarefa: TRegistrarTarefa);
    procedure Executar;
  end;

implementation

{ TPendenciasDPEC }

uses untInterfaces, untLibNfe, untDicSis;

constructor TPendenciasDPEC.Create(ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  Banco := frmModulo.Database;
end;

procedure TPendenciasDPEC.Executar;
Var
  qryPendentes: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  libNfe: TLibNfe;
  strCnpj: String;
  strIes:  String;
  strUF: String;
  retorno: TRetornoStatusNFE;
  blnRecusadaRejeitada: Boolean;
  blnContingenciaAutorizada: Boolean;
  strMensagemErro : String;

  procedure pGravaDocumentoImpresso;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strIncFis: String;
  begin
    If (Not fTabelaExiste('LOGPRT', Banco)) Then
      Exit;

    qryGen := Nil;
    Try
      qryGen := fCriaQuery(Nil, Banco);
      Try
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Text :=
            'SELECT CADFIS.AUTOINCREM, LOGPRT.PRT_SEQFIS FROM CADFIS LEFT JOIN LOGPRT ON LOGPRT.PRT_SEQFIS = CADFIS.AUTOINCREM '+
            ' WHERE FIS_NUMDOC = :NUMDOC '+
            '   AND FIS_ESPDOC = :ESPDOC '+
            '   AND FIS_CODEMP = :CODEMP '+
            '   AND FIS_FORCLI = :FORCLI '+
            '   AND FIS_SERIE_ = :SERIE_ '+
            '   AND FIS_TIP_FC = :TIP_FC ';

        qryGen.ParamByName('NUMDOC').AsString := qryPendentes.FieldByName('NFE_NUMDOC').AsString;
        qryGen.ParamByName('ESPDOC').AsString := qryPendentes.FieldByName('NFE_ESPDOC').AsString;
        qryGen.ParamByName('CODEMP').AsString := qryPendentes.FieldByName('NFE_CODEMP').AsString;
        qryGen.ParamByName('FORCLI').AsString := qryPendentes.FieldByName('NFE_CODCLI').AsString;
        qryGen.ParamByName('SERIE_').AsString := qryPendentes.FieldByName('NFE_SERIE_').AsString;
        qryGen.ParamByName('TIP_FC').AsString := qryPendentes.FieldByName('NFE_TIP_FC').AsString;
        qryGen.Open;

        If (Not qryGen.IsEmpty) Then
        Begin
          If (Not fEmptyStr(qryGen.FieldByName('AUTOINCREM').AsString)) And fEmptyStr(qryGen.FieldByName('PRT_SEQFIS').AsString) Then
          Begin
            strIncFis := qryGen.FieldByName('AUTOINCREM').AsString;

            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Text :=
                'REPLACE INTO LOGPRT (PRT_SEQFIS, PRT_NUMDOC, PRT_ESPDOC, PRT_CODEMP, PRT_FORCLI, PRT_SERIE_, PRT_TIP_FC) '+
                '             VALUES (:SEQFIS,    :NUMDOC,    :ESPDOC,    :CODEMP,    :FORCLI,    :SERIE_,    :TIP_FC) ';

            qryGen.ParamByName('SEQFIS').AsString := strIncFis;
            qryGen.ParamByName('NUMDOC').AsString := qryPendentes.FieldByName('NFE_NUMDOC').AsString;
            qryGen.ParamByName('ESPDOC').AsString := qryPendentes.FieldByName('NFE_ESPDOC').AsString;
            qryGen.ParamByName('CODEMP').AsString := qryPendentes.FieldByName('NFE_CODEMP').AsString;
            qryGen.ParamByName('FORCLI').AsString := qryPendentes.FieldByName('NFE_CODCLI').AsString;
            qryGen.ParamByName('SERIE_').AsString := qryPendentes.FieldByName('NFE_SERIE_').AsString;
            qryGen.ParamByName('TIP_FC').AsString := qryPendentes.FieldByName('NFE_TIP_FC').AsString;
            qryGen.ExecSQL;
          End;
        End;
        qryGen.Close;
      Except
        On E: Exception Do
          pLogImp(E.Message + ' [TPendenciasDPEC.pGravaDocumentoImpresso]');
      End;
    Finally
      If Assigned(qryGen) Then
        FreeAndNil(qryGen);
    End;
  end;

begin
  qryAux       := Nil;
  qryPendentes := Nil;
  libNfe       := Nil;
  Try
    Try
      If Not fDadosEmitenteStatusServico(strCnpj, strIes, strUF, Banco) Then
        Exit;

      qryAux := fCriaQuery(nil, Banco);
      qryPendentes := fCriaQuery(nil, Banco);

      libNfe := TLibNfe.Create(Banco);
      If (strUF <> '') Then
        retorno := libNfe.fVerificarStatusServicoPelaUF(strUF)
      Else
        retorno := libNfe.fVerificarStatusServico(strCnpj, strIes);

      If retorno = rsOperacional Then
      Begin
        qryPendentes.SQL.Add('SELECT ');
        qryPendentes.SQL.Add('  * ');
        qryPendentes.SQL.Add('FROM ');
        qryPendentes.SQL.Add('  LOGNFE ');
        qryPendentes.SQL.Add('  INNER JOIN CADFIS ON FIS_NUMDOC  = NFE_NUMDOC AND ');
        qryPendentes.SQL.Add('                       FIS_ESPDOC  = NFE_ESPDOC AND ');
        qryPendentes.SQL.Add('                       FIS_CODEMP  = NFE_CODEMP AND ');
        qryPendentes.SQL.Add('                       FIS_FORCLI  = NFE_CODCLI AND ');
        qryPendentes.SQL.Add('                       IFNULL(FIS_SERIE_, "") = IFNULL(NFE_SERIE_, "") ');
        qryPendentes.SQL.Add('WHERE ');
        qryPendentes.SQL.Add('  FIS_DTAENT >= ' + fCurrentDate(Date - 60) + ' AND ');
        qryPendentes.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
        qryPendentes.SQL.Add('  FIS_ESPDOC <> "ME" AND ');

        If fCfgSisPainel('USASAT') = 'S' Then
          qryPendentes.SQL.Add('  FIS_ESPDOC <> "IF" AND ');//SAT nao deveria estar como pendencia DPEC

        qryPendentes.SQL.Add('  NFE_STATUS NOT IN ("CN", "IN") AND ');
        qryPendentes.SQL.Add('  NFE_PNDPEC = 1 ');
        qryPendentes.SQL.Add('ORDER BY NFE_HORINI ASC ');
        qryPendentes.SQL.Add('LIMIT 10 ');

        qryPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryPendentes.Open;

        FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

        While (Not qryPendentes.Eof) Do
        Begin
          FTarefa.pSinalizarExecutando;

          If FTarefa.blnBloquear Then
            Break;

          FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(qryPendentes.FieldByName('NFE_NUMDOC').AsString, '-',
                                                                         qryPendentes.FieldByName('NFE_ESPDOC').AsString, '-',
                                                                         qryPendentes.FieldByName('NFE_CODEMP').AsString));

          If libNfe.fAcertaChaveAcessoNotaFiscal(qryPendentes.FieldByName('NFE_NUMDOC').AsString,
                                                 qryPendentes.FieldByName('NFE_ESPDOC').AsString,
                                                 qryPendentes.FieldByName('NFE_CODEMP').AsString,
                                                 qryPendentes.FieldByName('NFE_SERIE_').AsString,
                                                 qryPendentes.FieldByName('NFE_CODCLI').AsString,
                                                 qryPendentes.FieldByName('NFE_TIP_FC').AsString,
                                                 blnRecusadaRejeitada,
                                                 strMensagemErro,
                                                 blnContingenciaAutorizada) then
          begin
            If (qryPendentes.FieldByName('NFE_ESPDOC').AsString = 'IF') And (blnContingenciaAutorizada) Then
            Begin
              pGravaDocumentoImpresso;

              qryAux.SQL.Clear;
              qryAux.SQL.Add('UPDATE LOGNFE SET NFE_STATUS = "AE" WHERE');
              qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
              qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
              qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
              qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
              qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
              qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC ');

              qryAux.ParamByName('NUMDOC').AsString := qryPendentes.FieldByName('NFE_NUMDOC').AsString;
              qryAux.ParamByName('ESPDOC').AsString := qryPendentes.FieldByName('NFE_ESPDOC').AsString;
              qryAux.ParamByName('CODEMP').AsString := qryPendentes.FieldByName('NFE_CODEMP').AsString;
              qryAux.ParamByName('SERIE_').AsString := qryPendentes.FieldByName('NFE_SERIE_').AsString;
              qryAux.ParamByName('CODCLI').AsString := qryPendentes.FieldByName('NFE_CODCLI').AsString;
              qryAux.ParamByName('TIP_FC').AsString := qryPendentes.FieldByName('NFE_TIP_FC').AsString;
              qryAux.ExecSQL;
            end;
          End
          Else If (blnRecusadaRejeitada) then
          begin
            qryAux.SQL.Clear;
            qryAux.SQL.Add(' UPDATE LOGNFE ');
            qryAux.SQL.Add('    SET NFE_STATUS = "EE", ');
            qryAux.SQL.Add('        NFE_OBSERV = :OBSERV ');
            qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
            qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
            qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
            qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
            qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
            qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
            qryAux.ParamByName('NUMDOC').AsString := qryPendentes.FieldByName('NFE_NUMDOC').AsString;
            qryAux.ParamByName('ESPDOC').AsString := qryPendentes.FieldByName('NFE_ESPDOC').AsString;
            qryAux.ParamByName('CODEMP').AsString := qryPendentes.FieldByName('NFE_CODEMP').AsString;
            qryAux.ParamByName('SERIE_').AsString := qryPendentes.FieldByName('NFE_SERIE_').AsString;
            qryAux.ParamByName('CODCLI').AsString := qryPendentes.FieldByName('NFE_CODCLI').AsString;
            qryAux.ParamByName('TIP_FC').AsString := qryPendentes.FieldByName('NFE_TIP_FC').AsString;
            qryAux.ParamByName('OBSERV').AsString := strMensagemErro;
            qryAux.ExecSQL;
          End;

          qryPendentes.Next;
        End;
      End;

    Except
      On E: Exception Do
        pLogarErro(FTarefa.strTarefa, E);
    End;

  Finally
    If Assigned(qryAux) Then
      FreeAndNil(qryAux);

    If Assigned(qryPendentes) Then
      FreeAndNil(qryPendentes);

    If Assigned(libNfe) Then
      FreeAndNil(libNfe);
  End;
end;

end.
