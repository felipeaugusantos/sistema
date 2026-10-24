unit untNetpointsInterfaceAnalitica;

interface

uses Classes, Uni, DateUtils, SysUtils, Vcl.ComCtrls;

const
  PATH_SFTP_INT_ANALITICA : String = 'Interface Analitica';

type
  TNetpointsInterfaceAnalitica = class(TComponent)
  private
    function fGetSQL: String;
    function fRetFormaPagto(strCodMod: String): String;
    procedure pDadosCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; dtaDtaEnt: TDateTime; var strFpg, strBandeira: String);
    function fExportar(strPath: String; dtaDtaMov: TDateTime): String;
    procedure pCarregaMovimento(dtaDtaIni, dtaDtaFin: TDateTime; qryEnvNps: TUniQuery);
  public
    function fEnviar(dtaDtaIni, dtaDtaFin: TDateTime; dtaDtaEnv: TDateTime = 0; qryEnvNps: TUniQuery = Nil; pgbProgresso: TProgressBar = Nil): Boolean;
    class procedure pInicializaDiretorios;
    class var strPathIntAnalit : String;
  end;

implementation

{ TNetpointsInterfaceAnalitica }

uses untFuncoesSimples, Data.DB, StrUtils, Forms, Windows, untlibSFTP, untNetpoints;

procedure TNetpointsInterfaceAnalitica.pDadosCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; dtaDtaEnt: TDateTime; var strFpg, strBandeira: String);
  Var
    strSQL : String;
    qryCartao : TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT CAR_DESCAR, CAR_TIPCAR, BAN_NOMBAN ';
  strSQL := strSQL + '   FROM MOVCAR ';
  strSQL := strSQL + '   JOIN CADCAR ON MCA_CODCAR = CAR_CODCAR ';
  strSQL := strSQL + '   JOIN CADBAN ON CAR_CODBAN = BAN_CODBAN ';
  strSQL := strSQL + '  WHERE MCA_CODCLI = :CODCLI ';
  strSQL := strSQL + '    AND MCA_CODEMP = :CODEMP ';
  strSQL := strSQL + '    AND MCA_DTACAD = :DTACAD ';
  strSQL := strSQL + '    AND MCA_PARCEL = "A" ';
  strSQL := strSQL + '    AND MCA_DOCUME LIKE :DOCUME ';
  strSQL := strSQL + '  LIMIT 1 ';

  qryCartao := fCriaQuery(Nil);
  strBandeira := '';
  strFpg := '';
  Try
    With qryCartao Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('DTACAD').AsDateTime := dtaDtaEnt;
      ParamByName('DOCUME').AsString := strNumDoc + '-A-' + strEspDoc + '-' + strCodEmp + '-%';
      Open;

      If Not IsEmpty Then
      Begin
        First;

        If AnsiUpperCase(FieldByName('CAR_DESCAR').AsString).Contains(UpperCase('Marisa PL')) Then
          strFpg := '04'
        Else If AnsiUpperCase(FieldByName('CAR_DESCAR').AsString).Contains(UpperCase('Netpoints')) Then
          strFpg := '05'
        Else If AnsiUpperCase(FieldByName('CAR_DESCAR').AsString).Contains(UpperCase('Marisa')) Then
          strFpg := '06'
        Else If AnsiUpperCase(FieldByName('CAR_DESCAR').AsString).Contains(UpperCase('Semar')) Then
          strFpg := '06'
        Else If FieldByName('CAR_TIPCAR').AsString = 'C' Then
          strFpg := '02'
        Else If FieldByName('CAR_TIPCAR').AsString = 'D' Then
          strFpg := '03';

        If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Master')) Then
          strBandeira := '01'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Visa')) Then
          strBandeira := '02'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Aura')) Then
          strBandeira := '03'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Elo')) Then
          strBandeira := '04'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Hipercard')) Then
          strBandeira := '05'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Sorocred')) Then
          strBandeira := '06'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Diners')) Then
          strBandeira := '07'
        Else If AnsiUpperCase(FieldByName('BAN_NOMBAN').AsString).Contains(UpperCase('Dmcard')) Then
          strBandeira := '09'
        Else
          strBandeira := '08'; // Outros
      End;
    End;
  Finally
    FreeAndNil(qryCartao);
  End;
end;

class procedure TNetpointsInterfaceAnalitica.pInicializaDiretorios;
begin
  strPathIntAnalit := ExtractFilePath(Application.ExeName) + 'Netpoints\' + PATH_SFTP_INT_ANALITICA + '\';
  If Not DirectoryExists(strPathIntAnalit) Then
    ForceDirectories(strPathIntAnalit);

  If Not DirectoryExists(strPathIntAnalit) Then
    strPathIntAnalit := '';
end;

function TNetpointsInterfaceAnalitica.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT IFNULL(NPS_CPFCLI, IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_CGCCON, CLI_C_G_C_)) AS DET_CPFCLI, ';
  Result := Result + '        DET_NUMDOC, DET_ESPDOC, DET_CODEMP, ';
  Result := Result + '        DET_CODCLI, DET_DTAENT, NPS_CNPARC, DET_CODVEN, ';
  Result := Result + '        I.ITE_CODBAR, ';
  Result := Result + '        DET_DTAENT, DET_HORENT, DET_QTDITE, DET_DESCRI, ';
  Result := Result + '        DET_TOTITE-DET_DESESP AS DET_TOTPRO, ';
  Result := Result + '        GER_DESESP, DET_CODITE, ';

  Result := Result + '       (SELECT MOD_CODMOD ';
  Result := Result + '          FROM MOVMOD ';
  Result := Result + '         WHERE MOD_CODMOD <> "" ';
  Result := Result + '           AND MOD_NUMDOC = DET_NUMDOC ';
  Result := Result + '           AND MOD_ESPDOC = DET_ESPDOC ';
  Result := Result + '           AND MOD_CODEMP = DET_CODEMP ';
  Result := Result + '           AND MOD_CODCLI = DET_CODCLI ';
  Result := Result + '         ORDER BY MOD_VALMOD DESC ';
  Result := Result + '         LIMIT 1) AS FORMA_PAGTO, ';

  Result := Result + '        DEP_DESCRI AS DEPARTAMENTO, ';
  Result := Result + '        GRU_DESGRU AS GRUPO, ';
  Result := Result + '        G.ITE_SALDOS, ';
  Result := Result + '        MAR_DESMAR AS MARCA, ';
  Result := Result + '        DET_DESESP ';
  Result := Result + '   FROM MOVDET ';
  Result := Result + '   JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  Result := Result + '   JOIN MOVGER ON MOVGER.AUTOINCREM = DET_SEQGER ';
  Result := Result + '   JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';
  Result := Result + '   JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE ';
  Result := Result + '                AND G.ITE_CODEMP = DET_CODEMP ';
  Result := Result + '   LEFT JOIN CADNPS ON NPS_NUMDOC = DET_NUMDOC ';
  Result := Result + '                   AND NPS_ESPDOC = DET_ESPDOC ';
  Result := Result + '                   AND NPS_CODEMP = DET_CODEMP ';
  Result := Result + '                   AND NPS_CODCLI = DET_CODCLI ';
  Result := Result + '   LEFT JOIN CADMAR ON I.ITE_CODMAR = MAR_CODMAR ';
  Result := Result + '   LEFT JOIN CADDEP ON I.ITE_CODDEP = DEP_CODIGO ';
  Result := Result + '   LEFT JOIN CADGRU ON I.ITE_CODGRU = GRU_CODGRU ';
  Result := Result + '  WHERE DET_DTAENT = :DTAENT ';
  Result := Result + '    AND ((LOCATE(GER_CLAFIS, :CLAVEN) > 0) OR ';
  Result := Result + '         (LOCATE(GER_CLAFIS, :CLADEV) > 0))   ';
end;

function TNetpointsInterfaceAnalitica.fRetFormaPagto(strCodMod: String): String;
begin
  // 1 - Dinheiro
  If (strCodMod = '001') Then
    Result := '01'
  // 7 - Outros
  Else
    Result := '07';
end;

procedure TNetpointsInterfaceAnalitica.pCarregaMovimento(dtaDtaIni, dtaDtaFin: TDateTime;
  qryEnvNps: TUniQuery);
begin
  With qryEnvNps Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * ');
    SQL.Add('   FROM ENVNPS ');
    SQL.Add('  WHERE NPS_DTAMOV BETWEEN :DTAINI AND :DTAFIN ');
    SQL.Add('  ORDER BY NPS_DTAMOV ');
    ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
    Open;
  End;
end;

function TNetpointsInterfaceAnalitica.fEnviar(dtaDtaIni, dtaDtaFin: TDateTime; dtaDtaEnv: TDateTime = 0; qryEnvNps: TUniQuery = Nil; pgbProgresso: TProgressBar = Nil): Boolean;
  Var
    strFileExp : String;
    strHost : String;
    strUser : String;
    strPass : String;
    intPort : Integer;
    blnLibQry : Boolean;
begin
  Result := False;

  If (TNetpoints.fValidaDadosDoSFTP(strHost, strUser, strPass, intPort)) And
     (Not fEmptyStr(strPathIntAnalit)) And (DirectoryExists(strPathIntAnalit)) Then
  Begin
    blnLibQry := False;

    If (qryEnvNps = Nil) Then
    Begin
      qryEnvNps := fCriaQuery(Nil);
      blnLibQry := True;
    End;

    If dtaDtaEnv = 0 Then
      dtaDtaEnv := fnOw();

    If Assigned(pgbProgresso) Then
    Begin
      pgbProgresso.Visible := True;
      pgbProgresso.Max := DaysBetween(dtaDtaFin, dtaDtaIni);
    End;

    Try
      pCarregaMovimento(dtaDtaIni, dtaDtaFin, qryEnvNps);
      Repeat
        If Assigned(pgbProgresso) Then
        Begin
          pgbProgresso.StepBy(1);
          Application.ProcessMessages;
        End;

        If (Not qryEnvNps.Locate('NPS_DTAMOV', dtaDtaIni, [])) Then
        Begin
          strFileExp := fExportar(strPathIntAnalit, dtaDtaIni);

          If (Not fEmptyStr(strFileExp)) And
             (FileExists(strFileExp)) And
             (TlibSFTP.fPutFile(strHost, strUser, strPass, PATH_SFTP_INT_ANALITICA, strFileExp, intPort, True)) Then
          Begin
            qryEnvNps.Append;
            qryEnvNps.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ENVNPS', VS_strCodEmp);
            qryEnvNps.FieldByName('NPS_DTAMOV').AsDateTime := dtaDtaIni;
            qryEnvNps.FieldByName('NPS_INTANA').AsDateTime := dtaDtaEnv;
            qryEnvNps.Post;
          End;
        End;

        dtaDtaIni := IncDay(dtaDtaIni, 1);

      Until dtaDtaIni > dtaDtaFin;
    Finally
      If (blnLibQry) Then
        FreeAndNil(qryEnvNps);

      If Assigned(pgbProgresso) Then
        pgbProgresso.Visible := False;
    End;
  End;
end;

function TNetpointsInterfaceAnalitica.fExportar(strPath: String; dtaDtaMov: TDateTime): String;
  Var
    qryDados : TUniQuery;
    stlArquivo : TStringList;
    strArquivo : String;
    strSepCol : String;
    strNomParc : String;
    strCnpParc : String;
    strFpg : String;
    strBandeira: String;
begin
  qryDados := fCriaQuery(Self);
  stlArquivo := TStringList.Create;
  strSepCol := ';';
  strNomParc := fTiraCaracEspeciaisPonto(fCampoTabela('EMP_NOMFAN', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]));
  Result := '';
  Try
    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQL);
      ParamByName('DTAENT').AsDateTime := dtaDtaMov;
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
      Open;

      If (Not IsEmpty) Then
      Begin
        First;
        While Not Eof Do
        Begin

          strFpg := '';
          strBandeira := '';

          If (FieldByName('FORMA_PAGTO').AsString  = '007') Then
          Begin
            pDadosCartao(FieldByName('DET_NUMDOC').AsString,
                         FieldByName('DET_ESPDOC').AsString,
                         FieldByName('DET_CODEMP').AsString,
                         FieldByName('DET_CODCLI').AsString,
                         FieldByName('DET_DTAENT').AsDateTime,
                         strFpg,
                         strBandeira);

            If fEmptyStr(strFpg) Then
              strBandeira := '';
          End
          Else
            strFpg := fRetFormaPagto(FieldByName('FORMA_PAGTO').AsString);

          strCnpParc := FieldByName('NPS_CNPARC').AsString;

          If fEmptyStr(strCnpParc) Then
            strCnpParc := fTiraCaracEspeciaisPonto(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [FieldByName('DET_CODEMP').AsString]));

          strArquivo := '';
          strArquivo := strArquivo + FieldByName('DET_CPFCLI').AsString + strSepCol;                               // cd_cpf_socio
          strArquivo := strArquivo + RightStr(FieldByName('DET_NUMDOC').AsString, 8) + strSepCol;                  // nu_cupom
          strArquivo := strArquivo + '' + strSepCol;                                                               // nu_ecf
          strArquivo := strArquivo + '1' + strSepCol;                                                              // nu_pdv
          strArquivo := strArquivo + FieldByName('DET_CODVEN').AsString + strSepCol;                               // ind_caixa
          strArquivo := strArquivo + LeftStr(FieldByName('ITE_CODBAR').AsString, 13) + strSepCol;                  // nu_ean
          strArquivo := strArquivo + strCnpParc + strSepCol;                                                       // cd_cnpj_parceiro
          strArquivo := strArquivo + FormatDateTime('ddmmyyyy', FieldByName('DET_DTAENT').AsDateTime) + strSepCol; // dt_compra
          strArquivo := strArquivo + FormatDateTime('hhnnss', FieldByName('DET_HORENT').AsDateTime) + strSepCol;   // hr_compra
          strArquivo := strArquivo + fGetFloatStrF(FieldByName('DET_QTDITE').AsFloat, 11, 3) + strSepCol;          // qt_produto
          strArquivo := strArquivo + LeftStr(FieldByName('DET_DESCRI').AsString, 120) + strSepCol;                 // ds_produto
          strArquivo := strArquivo + fGetFloatStrF(FieldByName('DET_TOTPRO').AsFloat, 11, 3) + strSepCol;          // vr_produto
          strArquivo := strArquivo + FieldByName('DET_CODITE').AsString + strSepCol;                               // cd_inter_produto
          strArquivo := strArquivo + strFpg + strSepCol;                                                           // forma_pag
          strArquivo := strArquivo + strBandeira + strSepCol;                                                      // bandeira_cartao
          strArquivo := strArquivo + LeftStr(FieldByName('DEPARTAMENTO').AsString, 50) + strSepCol;                // ds_departamento
          strArquivo := strArquivo + '' + strSepCol;                                                               // ds_secao
          strArquivo := strArquivo + LeftStr(FieldByName('GRUPO').AsString, 50) + strSepCol;                       // ds_grupo
          strArquivo := strArquivo + '' + strSepCol;                                                               // ds_subgrupo
          strArquivo := strArquivo + '' + strSepCol;                                                               // ds_atributo
          strArquivo := strArquivo + fGetFloatStrF(FieldByName('ITE_SALDOS').AsFloat, 9, 0) + strSepCol;           // qt_estoque
          strArquivo := strArquivo + LeftStr(FieldByName('MARCA').AsString, 50) + strSepCol;                       // ds_marca
          strArquivo := strArquivo + '' + strSepCol;                                                               // ds_fabricante
          strArquivo := strArquivo + fGetFloatStrF(FieldByName('DET_DESESP').AsFloat, 11, 2) + strSepCol;          // desconto

          stlArquivo.Add(strArquivo);

          Next;
        End;

        Result := strPath + 'int_analitica_' + strNomParc + '_' + FormatDateTime('ddmmyyyy', dtaDtaMov) + '.txt';

        stlArquivo.SaveToFile(Result);
      End;
    End;
  Finally
    FreeAndNil(qryDados);
    FreeAndNil(stlArquivo);
  End;
end;

initialization
  TNetpointsInterfaceAnalitica.pInicializaDiretorios;

end.

