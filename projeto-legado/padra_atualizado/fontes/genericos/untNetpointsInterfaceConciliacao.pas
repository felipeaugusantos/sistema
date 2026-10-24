unit untNetpointsInterfaceConciliacao;

interface

uses Classes, Uni, Data.Db, UniClientDataSet, Forms, Windows;

const
  PATH_SFTP_INT_CONCILIACAO_OUT : String = 'Conciliacao/out';
  PATH_SFTP_INT_CONCILIACAO_OUT_BKP : String = 'Conciliacao/out/bkp';

type
  INetpointsInterfaceImportacao = Interface
    procedure pImportar(strPath: String);
  End;

type
  TNetpointsInterfaceImportacao = Class
  private
    FStrategy: INetpointsInterfaceImportacao;
  public
    procedure pImportar(strPath: String);
    constructor Create(Strategy: INetpointsInterfaceImportacao);
    class procedure pInicializaDiretorios;
    class var strPathConciliacaoOut : String;
    class var strPathConciliacaoOutBkp : String;
  end;

type
  TNetpointsInterfaceConciliacao = Class(TInterfacedObject, INetpointsInterfaceImportacao)
  private
    procedure pImportar(strPath: String);
    function fConNpsExiste(strCodIte, strNumNot, strCnpjMatr, strCpfAss: String): Boolean;
  End;

type
  TNetpointsInterfaceResgate = Class(TInterfacedObject, INetpointsInterfaceImportacao)
  private
    procedure pImportar(strPath: String);
  End;

function fLeituraDoArquivo(strArquiv : String; ArrCampos: Array Of String; qryDados: TUniQuery; var cdsDados: TUniClientDataSet): Boolean;
procedure pSetaValor(strValor: String; intIndice: Integer; ArrCampos: Array Of String; DataSet: TDataSet);
function fGetDateTimeFromString(strValue: String): TDateTime;

implementation

uses untFuncoesSimples, SysUtils, DateUtils, Variants, StrUtils, untNetpoints, untlibSFTP;

function fLeituraDoArquivo(strArquiv : String; ArrCampos: Array Of String; qryDados: TUniQuery; var cdsDados: TUniClientDataSet): Boolean;
  Var
    stlArquivo : TStringList;
    stlCampos : TStringList;
    intCnt1 : Integer;
    intCnt2 : Integer;
    dtaDtaArq : TDateTime;
    strNomArq : String;
begin
  stlArquivo := TStringList.Create;
  stlCampos := TStringList.Create;
  cdsDados := fCriaClientDatset(qryDados, True, Nil);
  Try
    stlArquivo.LoadFromFile(strArquiv);
    Try
      dtaDtaArq := 0;
      strNomArq := '';

      For intCnt1 := 0 To stlArquivo.Count-1 Do
      Begin
        If (Not fEmptyStr(stlArquivo.Strings[intCnt1])) Then
        Begin
          stlCampos.Clear;
          ExtractStrings([';'], [' '], PChar(ReplaceStr(stlArquivo[intCnt1], ';;', ';(VAZIO);')), stlCampos);

          If (intCnt1 = 0) Then
          Begin
            If (stlCampos.Count <> 3) Or
               (stlCampos.Strings[0] <> '1') Then
            Begin
              // Não é o arquivo esperado!!
              Break;
            End
            Else
            Begin
              dtaDtaArq := fGetDateTimeFromString(stlCampos.Strings[1]);
              strNomArq := stlCampos.Strings[2];
            End;
            Continue;
          End
          Else
          Begin
            If (Not ((stlCampos.Count-1) = intCnt1)) And (stlCampos.Count <> Length(ArrCampos)) Then
            Begin
              // Não é o arquivo esperado!!
              Break;
            End;

            cdsDados.Append;

            For intCnt2 := 0 To stlCampos.Count-1 Do
              pSetaValor(stlCampos[intCnt2], intCnt2, ArrCampos, cdsDados);

            If (cdsDados.FindField('NPS_DTAARQ') <> Nil) Then
              cdsDados.FieldByName('NPS_DTAARQ').AsDateTime := dtaDtaArq;

            If (cdsDados.FindField('NPS_NOMARQ') <> Nil) Then
              cdsDados.FieldByName('NPS_NOMARQ').AsString := strNomArq;

            cdsDados.Post;
          End;
        End;
      End;

      Result := (Not cdsDados.IsEmpty);
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(stlArquivo);
    FreeAndNil(stlCampos);
  End;
end;

procedure pSetaValor(strValor: String; intIndice: Integer; ArrCampos: Array Of String; DataSet: TDataSet);
  Var
    Field : TField;
begin
  Field := DataSet.FindField( ArrCampos[intIndice] );
  If (Field <> Nil) Then
  Begin
    Case Field.DataType Of
      ftDateTime:
      Begin
        // '2016-12-01 12:00:00'
        If (strValor = '(VAZIO)') Then
          Field.Value := Null
        Else
        // 20161013
        If (Length(strValor) = 19) Then
        Begin
          Field.AsDateTime := EncodeDateTime(StrToInt(Copy(strValor, 1, 4)),
                                             StrToInt(Copy(strValor, 6, 2)),
                                             StrToInt(Copy(strValor, 9, 2)),
                                             StrToInt(Copy(strValor, 12, 2)),
                                             StrToInt(Copy(strValor, 15, 2)),
                                             StrToInt(Copy(strValor, 18, 2)),
                                             0);
        End
        Else
          Field.Value := Null;
      End;
      ftDate :
      Begin
        If (strValor = '(VAZIO)') Then
          Field.Value := Null
        Else

        // 20161013
        If (Length(strValor) = 8) Then
        Begin
          Field.AsDateTime := EncodeDate(StrToInt(Copy(strValor, 1, 4)),
                                         StrToInt(Copy(strValor, 5, 2)),
                                         StrToInt(Copy(strValor, 7, 2)));
        End
        Else
          Field.Value := Null;
      End;
      ftFloat :
      Begin
        If (strValor = '(VAZIO)') Then
          Field.AsFloat := 0
        Else
          Field.AsFloat := fStrToFloat(Trim(AnsiReplaceStr(strValor,'.',',')));
        //Field.AsFloat := fValNumForm(strValor, Length(strValor), 2);
      End
      Else
      Begin
        If (strValor = '(VAZIO)') Then
          Field.AsString := ''
        Else
          Field.AsString := Trim(strValor);
      End;
    End;
  End;
end;

function fGetDateTimeFromString(strValue: String): TDateTime;
  Var
    wrdAno,
    wrdMes,
    wrdDia,
    wrdHora,
    wrdMinuto,
    wrdSegundo : Word;
begin
  // 2016-05-01 hh:nn:ss
  If fEmptyStr(strValue) Or (Length(strValue) <> 19) Then
    Result := 0
  Else
  Begin
    wrdAno := Copy(strValue, 1, 4).ToInteger;
    wrdMes := Copy(strValue, 6, 2).ToInteger;
    wrdDia := Copy(strValue, 9, 2).ToInteger;
    wrdHora := Copy(strValue, 12, 2).ToInteger;
    wrdMinuto := Copy(strValue, 15, 2).ToInteger;
    wrdSegundo := Copy(strValue, 18, 2).ToInteger;
    Result := EncodeDateTime(wrdAno, wrdMes, wrdDia, wrdHora, wrdMinuto, wrdSegundo, 0);
  End;
end;

{ TNetpointsInterfaceImportacao }

constructor TNetpointsInterfaceImportacao.Create(
  Strategy: INetpointsInterfaceImportacao);
begin
  FStrategy := Strategy;
end;

procedure TNetpointsInterfaceImportacao.pImportar(strPath: String);
begin
  FStrategy.pImportar(strPath);
end;

class procedure TNetpointsInterfaceImportacao.pInicializaDiretorios;
begin
  strPathConciliacaoOutBkp := ExtractFilePath(Application.ExeName) + 'Netpoints\' + ReplaceStr(PATH_SFTP_INT_CONCILIACAO_OUT_BKP, '/', '\') + '\';
  If Not DirectoryExists(strPathConciliacaoOutBkp) Then
    ForceDirectories(strPathConciliacaoOutBkp);

  If Not DirectoryExists(strPathConciliacaoOutBkp) Then
  Begin
    strPathConciliacaoOut := '';
    strPathConciliacaoOutBkp := '';
  End
  Else
    strPathConciliacaoOut := ExtractFilePath(Application.ExeName) + 'Netpoints\' + ReplaceStr(PATH_SFTP_INT_CONCILIACAO_OUT, '/', '\');
end;

{ TNetpointsInterfaceConciliacao }

function TNetpointsInterfaceConciliacao.fConNpsExiste(strCodIte, strNumNot,
  strCnpjMatr, strCpfAss: String): Boolean;
  Var
    qryConNps : TUniQuery;
begin
  qryConNps := fCriaQuery(Nil);
  Try
    With qryConNps Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) CNT ');
      SQL.Add('   FROM CONNPS ');
      SQL.Add('  WHERE NPS_CNPMAT = :CNPMAT ');
      SQL.Add('    AND NPS_CPFCLI = :CPFCLI ');
      SQL.Add('    AND NPS_NUMDOC = :NUMDOC ');
      SQL.Add('    AND NPS_CODITE = :CODITE ');
      ParamByName('CNPMAT').AsString := strCnpjMatr;
      ParamByName('CPFCLI').AsString := strCpfAss;
      ParamByName('NUMDOC').AsString := strNumNot;
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryConNps);
  End;
end;

procedure TNetpointsInterfaceConciliacao.pImportar(strPath: String);

  const
    ArrLayCon : Array[0..16] Of String = ('NPS_TIPREG', 'NPS_CNPMAT', 'NPS_CPFCLI',
                                          'NPS_TIPTRA', 'NPS_CNPFIL', 'NPS_NUMDOC',
                                          'NPS_PEDCMP', 'NPS_CODITE', 'NPS_DESITE',
                                          'NPS_VALPRO', 'NPS_DTACMP', 'NPS_DTAPRO',
                                          'NPS_QTDNPS', 'NPS_REGVAR', 'NPS_REGCAR',
                                          'NPS_CODCON', 'NPS_FATNPS');

  Var
    qryConNps : TUniQuery;
    cdsDados : TUniClientDataSet;
    intCnt : Integer;
    intAchou : Integer;
    srcArquivo : TSearchRec;
    blnGravou : Boolean;
    strHost : String;
    strUser : String;
    strPass : String;
    intPort : Integer;
begin
  If (fEmptyStr(strPath)) Or (Not DirectoryExists(strPath)) Then
    Exit;

  If RightStr(strPath, 1) <> '\' Then
    strPath := strPath + '\';

  qryConNps := fCriarQuery('SELECT * FROM CONNPS WHERE FALSE', Nil);
  Try
    blnGravou := False;
    qryConNps.Open;
    intAchou := FindFirst(strPath + '*.csv', faArchive, srcArquivo);

    If (intAchou = 0) Then
    Begin
      Repeat
        If (Pos('retorno_acumulo_', srcArquivo.Name) > 0) Then
        Begin
          If fLeituraDoArquivo(strPath + srcArquivo.Name, ArrLayCon, qryConNps, cdsDados) Then
          Begin
            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              If Not fConNpsExiste(cdsDados.FieldByName('NPS_CODITE').AsString,
                                   cdsDados.FieldByName('NPS_NUMDOC').AsString,
                                   cdsDados.FieldByName('NPS_CNPMAT').AsString,
                                   cdsDados.FieldByName('NPS_CPFCLI').AsString) Then
              Begin
                qryConNps.Append;
                qryConNps.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CONNPS', VS_strCodEmp);

                For intCnt := Low(ArrLayCon) To High(ArrLayCon) Do
                  qryConNps.FieldByName(ArrLayCon[intCnt]).Value := cdsDados.FieldByName(ArrLayCon[intCnt]).Value;

                qryConNps.FieldByName('NPS_DTAARQ').AsDateTime := cdsDados.FieldByName('NPS_DTAARQ').AsDateTime;
                qryConNps.FieldByName('NPS_NOMARQ').AsString := cdsDados.FieldByName('NPS_NOMARQ').AsString;
                qryConNps.Post;

                blnGravou := True;
              End;

              cdsDados.Next;
            End;

            If (blnGravou) Then
            Begin
              DeleteFile(strPath + srcArquivo.Name);
              If (TNetpoints.fValidaDadosDoSFTP(strHost, strUser, strPass, intPort)) Then
                TlibSFTP.fRename(strHost, strUser, strPass, intPort, PATH_SFTP_INT_CONCILIACAO_OUT + '/' + srcArquivo.Name, PATH_SFTP_INT_CONCILIACAO_OUT_BKP + '/' + srcArquivo.Name);
            End;
          End;
        End;
      Until FindNext(srcArquivo) <> 0;
    End;
  Finally
    System.SysUtils.FindClose(srcArquivo);
    FreeAndNil(qryConNps);
    If Assigned(cdsDados) Then
      FreeAndNil(cdsDados);
  End;
end;

{ TNetpointsInterfaceResgate }

procedure TNetpointsInterfaceResgate.pImportar(strPath: String);
  Const
    ArrLayRes : Array[0..14] Of String = ('NPS_TIPREG', 'NPS_CNPARC', 'NPS_CPFCLI',
                                          'NPS_PROTOC', 'NPS_CODITE', 'NPS_DESITE',
                                          'NPS_CODBAR', 'NPS_DTRESG', 'NPS_DTAPRO',
                                          'NPS_DTBXPD', 'NPS_VALRES', 'NPS_QTDNPS',
                                          'NPS_FATPAR', 'NPS_CODCON', 'NPS_IDRESG');

  Var
    qryResNps : TUniQuery;
    cdsDados : TUniClientDataSet;
    intCnt : Integer;
    intAchou : Integer;
    srcArquivo : TSearchRec;
    blnGravou : Boolean;
    strHost : String;
    strUser : String;
    strPass : String;
    intPort : Integer;
begin
  If (fEmptyStr(strPath)) Or (Not DirectoryExists(strPath)) Then
    Exit;

  If RightStr(strPath, 1) <> '\' Then
    strPath := strPath + '\';

  qryResNps := fCriarQuery('SELECT * FROM RESNPS WHERE FALSE', Nil);
  Try
    blnGravou := False;
    qryResNps.Open;
    intAchou := FindFirst(strPath + '*.csv', faArchive, srcArquivo);

    If (intAchou = 0) Then
    Begin
      Repeat
        If (Pos('retorno_conciliacao_troca_', srcArquivo.Name) > 0) Then
        Begin
          If fLeituraDoArquivo(strPath + srcArquivo.Name, ArrLayRes, qryResNps, cdsDados) Then
          Begin
            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              qryResNps.Append;
              qryResNps.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RESNPS', VS_strCodEmp);

              For intCnt := Low(ArrLayRes) To High(ArrLayRes) Do
                qryResNps.FieldByName(ArrLayRes[intCnt]).Value := cdsDados.FieldByName(ArrLayRes[intCnt]).Value;

              qryResNps.FieldByName('NPS_DTAARQ').AsDateTime := cdsDados.FieldByName('NPS_DTAARQ').AsDateTime;
              qryResNps.FieldByName('NPS_NOMARQ').AsString := cdsDados.FieldByName('NPS_NOMARQ').AsString;

              qryResNps.Post;

              blnGravou := True;

              cdsDados.Next;
            End;

            If (blnGravou) Then
            Begin
              DeleteFile(strPath + srcArquivo.Name);
              If (TNetpoints.fValidaDadosDoSFTP(strHost, strUser, strPass, intPort)) Then
                TlibSFTP.fRename(strHost, strUser, strPass, intPort, PATH_SFTP_INT_CONCILIACAO_OUT + '/' + srcArquivo.Name, PATH_SFTP_INT_CONCILIACAO_OUT_BKP + '/' + srcArquivo.Name);
            End;
          End;
        End;
      Until FindNext(srcArquivo) <> 0;
    End;
  Finally
    System.SysUtils.FindClose(srcArquivo);
    FreeAndNil(qryResNps);
    If Assigned(cdsDados) Then
      FreeAndNil(cdsDados);
  End;
end;

initialization
  TNetpointsInterfaceImportacao.pInicializaDiretorios;

end.

