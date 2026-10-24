unit untGeraDuplicataReceberLayoutMod1;

interface

Uses untRTTILayout, Uni, Dialogs, SysUtils, Classes;

Type
  [TDelimitador(';')]
  TSMSModelo1 = Class(TLayout)
  private
    FNomCli: String;
    FCelula: String;
    FValDup: Double;
    FDtaVen: TDateTime;

    strDocume : String;
  Public
    function fGetSql : String; override;
    function fGetArquivoNome : String; override;
    procedure pSetParams(DataSet : TUniQuery); override;

    procedure pSetDocumentos(stlNumAgr : TStringList);
  published
    [TNomeCampo('CLI_CELULA')]
    [TCampoString]
    property strCelula : String     Read FCelula Write FCelula;

    [TNomeCampo('CLI_NOMCLI')]
    [TCampoString]
    property strNomCli : String     Read FNomCli Write FNomCli;

    [TNomeCampo('CTR_VALDUP')]
    [TCampoDouble]
    property fltValDup : Double     Read FValDup Write FValDup;

    [TNomeCampo('CTR_DTAVEN')]
    [TCampoDateTime('dd/mm/yyyy')]
    property dtaDtaVen : TDateTime  Read FDtaVen Write FDtaVen;

  End;

implementation

{ TSMSModelo1 }

function TSMSModelo1.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                             ';
  Result := Result + '        SUBSTRING(CLI_NOMCLI, 1, LOCATE(" ", TRIM(CLI_NOMCLI))) AS CLI_NOMCLI, ';
  Result := Result + '        CLI_CELULA,                              ';
  Result := Result + '        CTR_VALDUP,                              ';
  Result := Result + '        CTR_DTAVEN                               ';
  Result := Result + ' FROM CADREC                                     ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI  ';
  Result := Result + ' WHERE CTR_NUMDUP IN ('+ strDocume +')           ';
  Result := Result + '   AND CTR_ESPDOC = "AG"                         ';
end;

procedure TSMSModelo1.pSetDocumentos(stlNumAgr: TStringList);
  Var
    intIndex : Integer;
begin
  strDocume := '';
  For intIndex := 0 To stlNumAgr.Count -1 Do
  Begin
    strDocume := strDocume + QuotedStr(stlNumAgr[intIndex]);
    If intIndex < stlNumAgr.Count -1 Then
      strDocume := strDocume + ', ';
  End;

end;

function TSMSModelo1.fGetArquivoNome: String;
  Var
    objSaveFile : TSaveDialog;
begin
  Result := '';
  Try
    objSaveFile := TSaveDialog.Create(Nil);
    If objSaveFile.Execute Then
      Result := ChangeFileExt(objSaveFile.FileName, '.csv');
  Finally
    FreeAndNil(objSaveFile);
  End;
end;

procedure TSMSModelo1.pSetParams(DataSet: TUniQuery);
begin
end;

end.
