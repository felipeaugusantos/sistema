unit untRomGer;

interface

function fBaixarDocumento(strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          strNumRom,
                          strNomRec: String;
                          dtaDtaBai,
                          dtaHorBai: TDateTime;
                          strEntreg: String;
                          strBaiApp: String = 'N';
                          strKMIni: String = '';
                          strKMFim: String = ''): Boolean;

function fRemoverDocumento(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strNumRom,
                           strCodOpe,
                           strCodMot:String;
                           dtaDtarom,
                           dtaHorRom: TDateTime;
                           strObserv: String): Boolean;

function fRemoverDocumentoOX(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strNumRom,
                             strCodOpe,
                             strCodMot:String;
                             dtaDtarom,
                             dtaHorRom: TDateTime;
                             strObserv: String): Boolean;

Function fGravaRomDel(strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strNumRom,
                      strCodOpe,
                      strCodMot,
                      strCodCid,
                      strCodReg,
                      strCodAj1,
                      strCodAj2,
                      strCodTra,
                      strPlaVei:String;
                      dtaDtarom,
                      dtaHorRom:TDateTime;
                      strObserv:String): Boolean;

function fGetSeqDigOutDigX(strNumRom: String): String;

procedure pDeletaRomOutX(strNumRom: String; strSeqDig: String = '');



implementation

uses
{$IFDEF LINUX}
  Services.Core.Connection.Interfaces,
  Services.Core.Connection.Manager,
  Services.Core.Task.Monitor,
{$ELSE }
  Uni,
  Forms,
  untUtilMonitor,
{$ENDIF LINUX}
  untFuncoesSimples,
  System.Variants,
  System.SysUtils,
  System.StrUtils;

function fBaixarDocumento(strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          strNumRom,
                          strNomRec: String;
                          dtaDtaBai,
                          dtaHorBai: TDateTime;
                          strEntreg: String;
                          strBaiApp: String = 'N';
                          strKMIni: String = '';
                          strKMFim: String = ''): Boolean;
  Var
    strCodOpe: String;
    strSQL   : String;
    qryGenGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin

  if (dtaHorBai <> 0) And (dtaDtaBai <> 0) then
    strCodOpe := strLoginUsuarioLogado
  else
    strCodOpe := '';

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  GER_DTABAI = :DTABAI, ';
    strSQL := strSQL + '  GER_HORBAI = :HORBAI, ';
    strSQL := strSQL + '  GER_NOMREC = :NOMREC, ';
    strSQL := strSQL + '  GER_ENTREG = :ENTREG, ';
    strSQL := strSQL + '  GER_BAIAPP = :BAIAPP,  ';
    strSQL := strSQL + '  GER_KMINI = :KMINI,  ';
    strSQL := strSQL + '  GER_KMFIM = :KMFIM,  ';
    strSQL := strSQL + '  GER_OPEBAI = :OPEBAI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

    If (strEspDoc <> 'OX') Then
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;
    try
      qryGenGer.SQL.Add(strSQL);

      qryGenGer.ParamByName('ENTREG').AsInteger  := IIF(strEntreg = 'S', 1, 0);

      If (dtaDtaBai = 0) Then
        qryGenGer.ParamByName('DTABAI').Value := NULL
      Else
        qryGenGer.ParamByName('DTABAI').AsDateTime := dtaDtaBai;

      If (dtaHorBai = 0) Then
        qryGenGer.ParamByName('HORBAI').Value := NULL
      Else
        qryGenGer.ParamByName('HORBAI').AsDateTime := dtaHorBai;

      If (dtaHorBai <> 0) And (dtaDtaBai <> 0) and (not fEmptyStr(strCodOpe)) Then
        qryGenGer.ParamByName('OPEBAI').AsString := strCodOpe
      Else
        qryGenGer.ParamByName('OPEBAI').Value := NULL;

      qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;

      If (strEspDoc <> 'OX') Then
        qryGenGer.ParamByName('CODCLI').AsString := strCodCli;

      qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
      qryGenGer.ParamByName('EMPROM').AsString := VS_strCodEmp;

      If (fEmptyStr(strNomRec)) Then
        qryGenGer.ParamByName('NOMREC').Value := NULL
      Else
        qryGenGer.ParamByName('NOMREC').AsString := strNomRec;

      qryGenGer.ParamByName('BAIAPP').AsString := strBaiApp;

      qryGenGer.ParamByName('KMINI').AsString := strKMIni;
      qryGenGer.ParamByName('KMFIM').AsString := strKMFim;

      qryGenGer.ExecSQL;
    finally
      {$IFNDEF LINUX}
        FreeAndNil(qryGenGer);
      {$ENDIF LINUX}
    end;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fBaixarDocumento]');
    End;
  End;
end;

function fRemoverDocumento(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strNumRom,
                           strCodOpe,
                           strCodMot:String;
                           dtaDtarom,
                           dtaHorRom:TDateTime;
                           strObserv:String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    blnNotGer: Boolean;
    strSeqGer: String;
    fltVlrCon: Double;
    qryGenIte: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    strAbrGer: String;
    strAbrDet: String;
    strOpcRom: String;
    blnPedido: Boolean;
    strCodCid,
    strCodReg,
    strCodAj1,
    strCodAj2,
    strCodTra,
    strPlaVei: String;
begin
  If (strEspDoc = 'OX') Then
  Begin
    Result := fRemoverDocumentoOX(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strNumRom,
                                  strCodOpe,
                                  strCodMot,
                                  dtaDtarom,
                                  dtaHorRom,
                                  strObserv);
    Exit;
  End;

  qryGenGer := fCriaQuery;
  qryGenIte := fCriaQuery;
  try

    Try
      strOpcRom := fCfgSis('OPCROM');

      {*******************************************}
      {* CONFIGURADO PARA ROMANEIO DE PEDIDOS OU *}
      {* FOR PEDIDO DE RETIRADA.                 *}
      {****************************************PZ*}
      blnPedido := ((strOpcRom = '1') Or (strEspDoc = 'PR'));

      {*******************************************}
      {* VERIFICA QUAIS TABELAS TEM (MOV/NOT)GER *}
      {****************************************MV*}
      blnNotGer := (Pos(strOpcRom, '34') > 0);

      If (blnPedido) Then
      Begin
        strAbrGer := 'FGO_';
        strAbrDet := 'FDO_';
      End
      Else
      Begin
        strAbrGer := 'GER_';
        strAbrDet := 'DET_';
      End;

      With qryGenGer Do
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  AUTOINCREM, ';
        strSQL := strSQL + '  GER_VLRCON, ';
        strSQL := strSQL + '  GER_CIDCON, ';
        strSQL := strSQL + '  GER_CODREG, ';
        strSQL := strSQL + '  GER_CODAJ1, ';
        strSQL := strSQL + '  GER_CODAJ2, ';
        strSQL := strSQL + '  GER_CODTRA, ';
        strSQL := strSQL + '  GER_PLAVEI  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ROMGERX ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
        strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        Open;

        strSeqGer := FieldByName('AUTOINCREM').AsString;
        fltVlrCon := FieldByName('GER_VLRCON').AsFloat;
        strCodCid := FieldByName('GER_CIDCON').AsString;
        strCodReg := FieldByName('GER_CODREG').AsString;
        strCodAj1 := FieldByName('GER_CODAJ1').AsString;
        strCodAj2 := FieldByName('GER_CODAJ2').AsString;
        strCodTra := FieldByName('GER_CODTRA').AsString;
        strPlaVei := FieldByName('GER_PLAVEI').AsString;

        Close;

        strSQL := '';
        strSQL := strSQL + 'UPDATE  ';

        If (blnPedido) Then
          strSQL := strSQL + '  FATGOR '
        Else
          strSQL := strSQL + '  MOVGER ';

        strSQL := strSQL + 'SET ';
        strSQL := strSQL + ' ' + strAbrGer + 'NUMROM = NULL, ';
        strSQL := strSQL + ' ' + strAbrGer + 'DTAROM = NULL, ';
        strSQL := strSQL + ' ' + strAbrGer + 'HORROM = NULL, ';
        strSQL := strSQL + ' ' + strAbrGer + 'OPEROM = NULL, ';
        strSQL := strSQL + ' ' + strAbrGer + 'VALROM = (' + strAbrGer + 'VALROM - :VALREM) ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + ' ' + strAbrGer + 'NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + ' ' + strAbrGer + 'ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + ' ' + strAbrGer + 'CODEMP = :CODEMP AND ';
        strSQL := strSQL + ' ' + strAbrGer + 'CODCLI = :CODCLI     ';

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('VALREM').AsFloat  := fltVlrCon;
        ExecSQL;

        If (blnNotGer) Then
        Begin
          strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('VALREM').AsFloat  := fltVlrCon;
          ExecSQL;
          Close;
        End;

        qryGenIte.Close;
        qryGenIte.SQL.Clear;
        qryGenIte.SQL.Add(' SELECT SQL_NO_CACHE ');
        qryGenIte.SQL.Add('        DET_AUTINC,  ');
        qryGenIte.SQL.Add('        DET_QTDBAI   ');
        qryGenIte.SQL.Add('   FROM ROMDETX      ');
        qryGenIte.SQL.Add('  WHERE DET_SEQGER = :SEQGER ');
        qryGenIte.ParamByName('SEQGER').AsString := strSeqGer;
        qryGenIte.Open;

        strSQL := '';
        strSQL := strSQL + 'UPDATE  ';

        If (blnPedido) Then
          strSQL := strSQL + '  FATDOR '
        Else
          strSQL := strSQL + '  MOVDET ';

        strSQL := strSQL + 'SET ';
        strSQL := strSQL + ' ' + strAbrDet + 'QTDROM = (' + strAbrDet + 'QTDROM - :QTDREM) ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + ' ' + strAbrDet + 'NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + ' ' + strAbrDet + 'ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + ' ' + strAbrDet + 'CODCLI = :CODCLI AND ';
        strSQL := strSQL + ' ' + strAbrDet + 'CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

        qryGenIte.First;
        While Not qryGenIte.Eof Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('AUTINC').AsString := qryGenIte.FieldByName('DET_AUTINC').AsString;
          ParamByName('QTDREM').AsFloat  := qryGenIte.FieldByName('DET_QTDBAI').AsFloat;
          ExecSQL;
          qryGenIte.Next;
        End;

        If (blnNotGer) Then
        Begin
          qryGenIte.First;
          While Not qryGenIte.Eof Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'));
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODCLI').AsString := strCodCli;
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('AUTINC').AsString := qryGenIte.FieldByName('DET_AUTINC').AsString;
            ParamByName('QTDREM').AsFloat  := qryGenIte.FieldByName('DET_QTDBAI').AsFloat;
            ExecSQL;
            qryGenIte.Next;
          End;
        End;

        qryGenIte.Close;

        strSQL := '';
        strSQL := strSQL + 'DELETE FROM ';
        strSQL := strSQL + '  ROMGERX ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
        strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        ExecSQL;

      End;

      fGravaRomDel(strNumDoc,
                   strEspDoc,
                   strCodEmp,
                   strCodCli,
                   strNumRom,
                   strCodOpe,
                   strCodMot,
                   strCodCid,
                   strCodReg,
                   strCodAj1,
                   strCodAj2,
                   strCodTra,
                   strPlaVei,
                   dtaDtarom,
                   dtaHorRom,
                   strObserv);

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fBaixarDocumento]');
      End;
    End;
  finally
    {$IFNDEF LINUX}
      FreeAndNil(qryGenGer);
      FreeAndNil(qryGenIte);
    {$ENDIF LINUX}
  end;
end;

function fRemoverDocumentoOX(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strNumRom,
                             strCodOpe,
                             strCodMot:String;
                             dtaDtarom,
                             dtaHorRom: TDateTime;
                             strObserv: String): Boolean;

  Var
    strSQL : String;
    qryGenGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    strSeqDig: String;
begin
  Try
    strSeqDig := fGetSeqDigOutDigX(strNumRom);

    qryGenGer := fCriaQuery;
    try
      strSQL := '';
      strSQL := strSQL + 'UPDATE OUTDIGX ';
      strSQL := strSQL + '   SET DIG_NUMROM = NULL, ';
      strSQL := strSQL + '       DIG_EMPROM = NULL, ';
      strSQL := strSQL + '       DIG_DTAROM = NULL, ';
      strSQL := strSQL + '       DIG_HORROM = NULL, ';
      strSQL := strSQL + '       DIG_OPEROM = NULL  ';
      strSQL := strSQL + 'WHERE DIG_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND DIG_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '  AND DIG_CODEMP = :CODEMP ';

      With qryGenGer Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE ';
      strSQL := strSQL + '   FROM ROMGERX ';
      strSQL := strSQL + '  WHERE GER_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '    AND GER_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '    AND GER_CODEMP = :CODEMP ';
      strSQL := strSQL + '    AND GER_NUMROM = :NUMROM ';
      strSQL := strSQL + '    AND GER_EMPROM = :EMPROM ';

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        ExecSQL;
      End;

      pDeletaRomOutX(strNumRom, strSeqDig);

      Result := True;
    finally
      {$IFNDEF LINUX}
        FreeAndNil(qryGenGer);
      {$ENDIF LINUX}
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRemoverDocumentoOX]');
    End;
  End;
end;

Function fGravaRomDel(strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strNumRom,
                      strCodOpe,
                      strCodMot,
                      strCodCid,
                      strCodReg,
                      strCodAj1,
                      strCodAj2,
                      strCodTra,
                      strPlaVei:String;
                      dtaDtarom,
                      dtaHorRom:TDateTime;
                      strObserv:String): Boolean;
  Var
    strSQL : String;
    qryGenGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ROMDELX ( ';
    strSQL := strSQL + '         AUTOINCREM,  ';
    strSQL := strSQL + '         DEL_NUMDOC,  ';
    strSQL := strSQL + '         DEL_ESPDOC,  ';
    strSQL := strSQL + '         DEL_CODEMP,  ';
    strSQL := strSQL + '         DEL_CODCLI,  ';
    strSQL := strSQL + '         DEL_NUMROM,  ';
    strSQL := strSQL + '         DEL_EMPROM,  ';
    strSQL := strSQL + '         DEL_DTAROM,  ';
    strSQL := strSQL + '         DEL_HORROM,  ';
    strSQL := strSQL + '         DEL_CODVEN,  ';
    strSQL := strSQL + '         DEL_CODMOT,  ';
    strSQL := strSQL + '         DEL_CIDCON,  ';
    strSQL := strSQL + '         DEL_CODREG,  ';
    strSQL := strSQL + '         DEL_CODAJ1,  ';
    strSQL := strSQL + '         DEL_CODAJ2,  ';
    strSQL := strSQL + '         DEL_CODTRA,  ';
    strSQL := strSQL + '         DEL_OBSERV,  ';
    strSQL := strSQL + '         DEL_DTABAI,  ';
    strSQL := strSQL + '         DEL_HORBAI,  ';
    strSQL := strSQL + '         DEL_PLAVEI ) ';
    strSQL := strSQL + 'VALUES( :AUTOIN,      ';
    strSQL := strSQL + '        :NUMDOC,      ';
    strSQL := strSQL + '        :ESPDOC,      ';
    strSQL := strSQL + '        :CODEMP,      ';
    strSQL := strSQL + '        :CODCLI,      ';
    strSQL := strSQL + '        :NUMROM,      ';
    strSQL := strSQL + '        :EMPROM,      ';
    strSQL := strSQL + '        :DTAROM,      ';
    strSQL := strSQL + '        :HORROM,      ';
    strSQL := strSQL + '        :CODVEN,      ';
    strSQL := strSQL + '        :CODMOT,      ';
    strSQL := strSQL + '        :CIDCON,      ';
    strSQL := strSQL + '        :CODREG,      ';
    strSQL := strSQL + '        :CODAJ1,      ';
    strSQL := strSQL + '        :CODAJ2,      ';
    strSQL := strSQL + '        :CODTRA,      ';
    strSQL := strSQL + '        :OBSERV,      ';
    strSQL := strSQL + '        :DTABAI,      ';
    strSQL := strSQL + '        :HORBAI,      ';
    strSQL := strSQL + '        :PLAVEI )     ';

    qryGenGer := fCriaQuery;
    try
      qryGenGer.SQL.Add(strSQL);

      qryGenGer.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('ROMDELX', VS_strCodEmp);
      qryGenGer.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryGenGer.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryGenGer.ParamByName('CODEMP').AsString   := strCodEmp;
      qryGenGer.ParamByName('CODCLI').AsString   := strCodCli;
      qryGenGer.ParamByName('NUMROM').AsString   := strNumRom;
      qryGenGer.ParamByName('EMPROM').AsString   := VS_strCodEmp;
      qryGenGer.ParamByName('DTAROM').AsDateTime := dtaDtarom;
      qryGenGer.ParamByName('HORROM').AsDateTime := dtaHorRom;
      qryGenGer.ParamByName('CODVEN').AsString   := strCodOpe;
      qryGenGer.ParamByName('CODMOT').AsString   := strCodMot;
      qryGenGer.ParamByName('CIDCON').AsString   := strCodCid;
      qryGenGer.ParamByName('CODREG').AsString   := strCodReg;
      qryGenGer.ParamByName('CODAJ1').AsString   := strCodAj1;
      qryGenGer.ParamByName('CODAJ2').AsString   := strCodAj2;
      qryGenGer.ParamByName('CODTRA').AsString   := strCodTra;
      qryGenGer.ParamByName('PLAVEI').AsString   := strPlaVei;
      qryGenGer.ParamByName('OBSERV').AsString   := strObserv;
      qryGenGer.ParamByName('DTABAI').AsDateTime := VS_Date;
      qryGenGer.ParamByName('HORBAI').AsDateTime := Time;

      qryGenGer.ExecSQL;
      Result := True;
    finally
      {$IFNDEF LINUX}
        FreeAndNil(qryGenGer);
      {$ENDIF LINUX}
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaRomDel]');
    End;
  End;
end;

function fGetSeqDigOutDigX(strNumRom: String): String;
  Var
    qryOutDig : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryOutDig := fCriaQuery;
  try
    With qryOutDig Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT AUTOINCREM ');
      SQL.Add('   FROM OUTDIGX ');
      SQL.Add('  WHERE DIG_NUMROM = :NUMROM ');
      SQL.Add('    AND DIG_EMPROM = :ROMEMP ');
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('ROMEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('AUTOINCREM').AsString;
      Close;
    End;
  finally
    {$IFNDEF LINUX}
      FreeAndNil(qryOutDig);
    {$ENDIF LINUX}
  end;
end;

procedure pDeletaRomOutX(strNumRom: String; strSeqDig: String = '');
  Var
    qryRomOutX : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryRomOutX := fCriaQuery(Nil);
  try
    With qryRomOutX Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE ');
      SQL.Add('   FROM ROMOUTX ');
      SQL.Add('  WHERE OUT_NUMROM = :NUMROM ');
      SQL.Add('    AND OUT_ROMEMP = :CODEMP ');

      If Not fEmptyStr(strSeqDig) Then
        SQL.Add('  AND OUT_SEQDIG = :SEQDIG ');

      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(strSeqDig) Then
        ParamByName('SEQDIG').AsString := strSeqDig;

      ExecSQL;
    End;
  finally
    {$IFNDEF LINUX}
      FreeAndNil(qryRomOutX);
    {$ENDIF LINUX}
  end;
end;

end.
