unit untHisPed;

interface

uses Uni, SysUtils, Variants, Classes;

Type
  THisPed = class(TComponent)
    private
      qryHisPed: TUniQuery;
    protected
    public
      Constructor Create(Owner: TComponent); override;
      Destructor Destroy; override;

      function fGravarHistorico(strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strNumRom: String;
                                dtaDtaRom,
                                dtaHorRom: TDateTime;
                                strCodMot,
                                strCodTra: String): Boolean;

      function fAtualizarHistorico(strNumDoc,
                                   strEspDoc,
                                   strCodEmp,
                                   strNumRom,
                                   strNomRec: String;
                                   dtaDtaBai,
                                   dtaHorBai: TDateTime;
                                   strEntreg,
                                   strObserv: String): Boolean;

      procedure pCarregaHistorico(strNumDoc, strEspDoc, strCodEmp: String;
        qryRetorno: TUniQuery); Overload;

  End;

implementation

uses untFuncoesSimples;

{ THisPed }

constructor THisPed.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  qryHisPed := fCriaQuery(Self);
end;

destructor THisPed.Destroy;
begin
  FreeAndNil(qryHisPed);
  inherited Destroy;
end;

function THisPed.fAtualizarHistorico(strNumDoc,
                                     strEspDoc,
                                     strCodEmp,
                                     strNumRom,
                                     strNomRec: String;
                                     dtaDtaBai,
                                     dtaHorBai: TDateTime;
                                     strEntreg,
                                     strObserv: String): Boolean;
begin
  Try

    qryHisPed.SQL.Clear;
    qryHisPed.SQL.Add('UPDATE ');
    qryHisPed.SQL.Add('  HISPED ');
    qryHisPed.SQL.Add('SET ');
    qryHisPed.SQL.Add('  HIS_DTABAI = :DTABAI, ');
    qryHisPed.SQL.Add('  HIS_HORBAI = :HORBAI, ');
    qryHisPed.SQL.Add('  HIS_ENTREG = :ENTREG, ');
    qryHisPed.SQL.Add('  HIS_OBSERV = :OBSERV, ');
    qryHisPed.SQL.Add('  HIS_NOMREC = :NOMREC  ');
    qryHisPed.SQL.Add('WHERE ');
    qryHisPed.SQL.Add('  HIS_NUMDOC = :NUMDOC AND ');
    qryHisPed.SQL.Add('  HIS_ESPDOC = :ESPDOC AND ');
    qryHisPed.SQL.Add('  HIS_CODEMP = :CODEMP AND ');
    qryHisPed.SQL.Add('  HIS_NUMROM = :NUMROM ');

    If (dtaDtaBai = 0) Then
      qryHisPed.ParamByName('DTABAI').Value := NULL
    Else
      qryHisPed.ParamByName('DTABAI').AsDateTime := dtaDtaBai;

    If (dtaHorBai = 0) Then
      qryHisPed.ParamByName('HORBAI').Value := NULL
    Else
      qryHisPed.ParamByName('HORBAI').AsDateTime := dtaHorBai;

    qryHisPed.ParamByName('ENTREG').AsInteger  := IIF(strEntreg = 'S', 1, 0);

    qryHisPed.ParamByName('OBSERV').AsString   := strObserv;

    qryHisPed.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryHisPed.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryHisPed.ParamByName('CODEMP').AsString   := strCodEmp;
    qryHisPed.ParamByName('NUMROM').AsString   := strNumRom;

    If (fEmptyStr(strNomRec)) Then
      qryHisPed.ParamByName('NOMREC').Value    := NULL
    Else
      qryHisPed.ParamByName('NOMREC').AsString := strNomRec;

    qryHisPed.ExecSQL;
    qryHisPed.Close;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[THisPed.fAtualizarHistorico]');
    End;
  End;
end;

function THisPed.fGravarHistorico(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strNumRom: String;
                                  dtaDtaRom,
                                  dtaHorRom: TDateTime;
                                  strCodMot,
                                  strCodTra: String): Boolean;
begin

  Try

    qryHisPed.SQL.Clear;
    qryHisPed.SQL.Add('INSERT INTO   ');
    qryHisPed.SQL.Add('  HISPED      ');
    qryHisPed.SQL.Add('(             ');
    qryHisPed.SQL.Add('  HIS_NUMDOC, ');
    qryHisPed.SQL.Add('  HIS_ESPDOC, ');
    qryHisPed.SQL.Add('  HIS_NUMROM, ');
    qryHisPed.SQL.Add('  HIS_DTAROM, ');
    qryHisPed.SQL.Add('  HIS_HORROM, ');
    qryHisPed.SQL.Add('  HIS_CODMOT, ');
    qryHisPed.SQL.Add('  HIS_CODTRA, ');
    qryHisPed.SQL.Add('  HIS_CODEMP, ');
    qryHisPed.SQL.Add('  HIS_ENTREG, ');
    qryHisPed.SQL.Add('  AUTOINCREM) ');
    qryHisPed.SQL.Add('VALUES (      ');
    qryHisPed.SQL.Add('  :NUMDOC,    ');
    qryHisPed.SQL.Add('  :ESPDOC,    ');
    qryHisPed.SQL.Add('  :NUMROM,    ');
    qryHisPed.SQL.Add('  :DTAROM,    ');
    qryHisPed.SQL.Add('  :HORROM,    ');
    qryHisPed.SQL.Add('  :CODMOT,    ');
    qryHisPed.SQL.Add('  :CODTRA,    ');
    qryHisPed.SQL.Add('  :CODEMP,    ');
    qryHisPed.SQL.Add('  :ENTREG,    ');
    qryHisPed.SQL.Add('  :AUTINC)    ');

    qryHisPed.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryHisPed.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryHisPed.ParamByName('NUMROM').AsString   := strNumRom;
    qryHisPed.ParamByName('DTAROM').AsDateTime := dtaDtaRom;
    qryHisPed.ParamByName('HORROM').AsDateTime := dtaHorRom;

    If fEmptyStr(strCodMot) Then
      qryHisPed.ParamByName('CODMOT').Value := Null
    Else
      qryHisPed.ParamByName('CODMOT').AsString   := strCodMot;

    If fEmptyStr(strCodTra) Then
      qryHisPed.ParamByName('CODTRA').Value := Null
    Else
      qryHisPed.ParamByName('CODTRA').AsString   := strCodTra;
      
    qryHisPed.ParamByName('CODEMP').AsString   := strCodEmp;
    qryHisPed.ParamByName('ENTREG').AsInteger  := 0;
    qryHisPed.ParamByName('AUTINC').AsString   := fRetAutoIncrem('HISPED', VS_strCodEmp);

    qryHisPed.ExecSQL;
    qryHisPed.Close;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[THisPed.fGravarHistorico]');
    End;
  End;

end;

procedure THisPed.pCarregaHistorico(strNumDoc, strEspDoc, strCodEmp: String;
  qryRetorno: TUniQuery);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HIS_NUMROM, ';
  strSQL := strSQL + '  CONCAT(DATE_FORMAT(HIS_DTAROM, "%d/%m/%Y"), " - ", TIME_FORMAT(HIS_HORROM, "%T")) HIS_DTAROM, ';
  strSQL := strSQL + '  CONCAT(HIS_CODMOT, " - ", MOT_NOMMOT) HIS_NOMMOT, ';
  strSQL := strSQL + '  CONCAT(HIS_CODTRA, " - ", TRA_NOMTRA) HIS_NOMTRA, ';

  If fCfgSis('OPCROM') = '1' Then
  Begin
    strSQL := strSQL + '  CONCAT(DATE_FORMAT(HIS_DTABAI, "%d/%m/%Y"), " - ", TIME_FORMAT(HIS_HORBAI, "%T")) HIS_DTABAI, ';
    strSQL := strSQL + '  IF(HIS_ENTREG, "SIM", "NÃO") HIS_ENTREG, ';
  End
  Else
  Begin
    strSQL := strSQL + '  (SELECT CONCAT(DATE_FORMAT(GER_DTABAI, "%d/%m/%Y"), " - ", TIME_FORMAT(GER_HORBAI, "%T")) ';
    strSQL := strSQL + '          FROM ROMGERX INNER JOIN FATDOR ON (FDO_NUMFAT=GER_NUMDOC AND FDO_TIPFAT=GER_ESPDOC AND FDO_EMPFAT=GER_CODEMP) ';
    strSQL := strSQL + '          WHERE ROMGERX.GER_NUMROM = HIS_NUMROM AND ROMGERX.GER_CODEMP = IFNULL(FDO_EMPFAT, FDO_CODEMP) AND ';
    strSQL := strSQL + '                FDO_NUMDOC=HIS_NUMDOC AND FDO_ESPDOC=HIS_ESPDOC AND FDO_CODEMP=HIS_CODEMP ';
    strSQL := strSQL + '          GROUP BY ROMGERX.GER_NUMDOC, ROMGERX.GER_ESPDOC, ROMGERX.GER_CODEMP LIMIT 1 ';
    strSQL := strSQL + '  ) AS HIS_DTABAI, ';
    strSQL := strSQL + '  (SELECT IF(GER_ENTREG, "SIM", "NÃO") ';
    strSQL := strSQL + '          FROM ROMGERX INNER JOIN FATDOR ON (FDO_NUMFAT=GER_NUMDOC AND FDO_TIPFAT=GER_ESPDOC AND FDO_EMPFAT=GER_CODEMP) ';
    strSQL := strSQL + '          WHERE ROMGERX.GER_NUMROM = HIS_NUMROM AND ROMGERX.GER_CODEMP = IFNULL(FDO_EMPFAT, FDO_CODEMP) AND ';
    strSQL := strSQL + '                FDO_NUMDOC=HIS_NUMDOC AND FDO_ESPDOC=HIS_ESPDOC AND FDO_CODEMP=HIS_CODEMP ';
    strSQL := strSQL + '          GROUP BY ROMGERX.GER_NUMDOC, ROMGERX.GER_ESPDOC, ROMGERX.GER_CODEMP LIMIT 1 ';
    strSQL := strSQL + '  ) AS HIS_ENTREG, ';
  End;

  If fCfgSis('OPCROM') = '1' Then
  Begin
    strSQL := strSQL + '  HIS_OBSERV '
  End
  Else
  Begin
    {*************************************************************************}
    {* CONCATENA HISTÓRICOS (SE HOUVER) REFERENTE À ROMANEIOS DO PEDIDO, COM *}
    {* HISTÓRICOS (SE HOUVER) REFERENTE À ROMANEIOS DE DOCUMENTOS DE         *}
    {* FATURAMENTO ORIGINADOS DE UM PEDIDO                                   *}
    {**********************************************************************VA*}
    strSQL := strSQL + ' CONCAT(IFNULL(HIS_OBSERV, ""), ';
    strSQL := strSQL + '        IF(IFNULL(HIS_OBSERV, "") <> "", "\n", ""), ';
    strSQL := strSQL + '        IFNULL((SELECT GROUP_CONCAT(DISTINCT "Vendedor: ", CONCAT(OPE_CODOPE,"-",OPE_NOMOPE), " Data/Hora: ", DATE_FORMAT(GER_DTAALT, "%d/%m/%Y"), " ", TIME_FORMAT(GER_HORALT, "%T"), "\n", GER_OBSERV, "\n") ';
    strSQL := strSQL + '                       FROM LOGROM INNER JOIN FATDOR ON (FDO_NUMFAT=GER_NUMDOC AND FDO_TIPFAT=GER_ESPDOC AND FDO_EMPFAT=GER_EMPDOC) ';
    strSQL := strSQL + '                                   INNER JOIN CADOPE ON (OPE_CODOPE=GER_OPEALT) ';
    strSQL := strSQL + '                       WHERE LOGROM.GER_NUMROM = HIS_NUMROM AND LOGROM.GER_CODEMP = IFNULL(FDO_EMPFAT, FDO_CODEMP) AND ';
    strSQL := strSQL + '                             FDO_NUMDOC=HIS_NUMDOC AND FDO_ESPDOC=HIS_ESPDOC AND FDO_CODEMP=HIS_CODEMP ';
    strSQL := strSQL + '                       GROUP BY LOGROM.GER_NUMDOC, LOGROM.GER_ESPDOC, LOGROM.GER_EMPDOC ';
    strSQL := strSQL + '                       ORDER BY GER_DTAALT DESC, GER_HORALT DESC),"")) AS HIS_OBSERV ';
  End;
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  HISPED ';
  strSQL := strSQL + '  LEFT JOIN CADMOT ON MOT_CODMOT = HIS_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = HIS_CODTRA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  HIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  HIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  HIS_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  HIS_NUMROM, HIS_DTAROM, HIS_HORROM, HIS_HORBAI, HIS_HORROM ';

  qryRetorno.SQL.Clear;
  qryRetorno.SQL.Add(strSQL);
  qryRetorno.ParamByName('NUMDOC').AsString := strNumDoc;
  qryRetorno.ParamByName('ESPDOC').AsString := strEspDoc;
  qryRetorno.ParamByName('CODEMP').AsString := strCodEmp;
  qryRetorno.Open;

end;

end.

