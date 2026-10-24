unit untControleVolumesBipados;

interface

uses
  UniClientDataSet, Data.DB, System.Variants, SysUtils;

type
  TControleVolumesBipados = class
  private
    FVolumes : TUniClientDataSet;
  public

    procedure pAddVolume(strNumDoc,
                         strEspDoc,
                         strCodEmp : String;
                         intVolume : Integer);

    function fJahBipouVolume(strNumDoc,
                             strEspDoc,
                             strCodEmp : String;
                             intVolume : Integer) : Boolean;

    function fRetornaQtdVolumesBipados(strNumDoc,
                                       strEspDoc,
                                       strCodEmp : String) : Integer;

    function fRetornaVolumesBipados(strNumDoc,
                                    strEspDoc,
                                    strCodEmp : String) : TUniClientDataSet;

    procedure pLimparVolumes;
    procedure pCriaClientVolumes(var AClient : TUniClientDataSet);

    constructor Create;

  end;

implementation

uses
  untFuncoesSimples;

{ TControleVolumesBipados }

constructor TControleVolumesBipados.Create;
begin
  pCriaClientVolumes(FVolumes);
end;

function TControleVolumesBipados.fJahBipouVolume(strNumDoc,
                                                 strEspDoc,
                                                 strCodEmp : String;
                                                 intVolume : Integer): Boolean;
begin
  Result := FVolumes.Locate('NUMDOC;ESPDOC;CODEMP;NUMVOL',
                            VarArrayOf([strNumDoc, strEspDoc, strCodEmp, intVolume]), []);
end;

function TControleVolumesBipados.fRetornaVolumesBipados(strNumDoc, strEspDoc, strCodEmp: String): TUniClientDataSet;
begin

  pCriaClientVolumes(Result);

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  FVolumes.Filtered := False;

  Try

    FVolumes.Filter   := 'NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ' +
                         'ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ' +
                         'CODEMP = ' + QuotedStr(strCodEmp);

    FVolumes.Filtered := True;

    FVolumes.First;
    While Not FVolumes.Eof Do
    Begin
      pCopiaRegistroDataSet(FVolumes, Result);
      FVolumes.Next;
    End;

  Finally
    FVolumes.Filtered := False;
    FVolumes.Filter   := '';
  End;

end;

function TControleVolumesBipados.fRetornaQtdVolumesBipados(strNumDoc,
                                                           strEspDoc,
                                                           strCodEmp : String): Integer;
begin

  Result := 0;

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  FVolumes.Filtered := False;

  Try

    FVolumes.Filter   := 'NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ' +
                         'ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ' +
                         'CODEMP = ' + QuotedStr(strCodEmp);

    FVolumes.Filtered := True;

    Result := FVolumes.RecordCount;

  Finally
    FVolumes.Filtered := False;
    FVolumes.Filter   := '';
  End;

end;

procedure TControleVolumesBipados.pAddVolume(strNumDoc,
                                             strEspDoc,
                                             strCodEmp : String;
                                             intVolume : Integer);
begin

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  If (intVolume <= 0) Then
    Exit;

  FVolumes.Append;
  FVolumes.FieldByName('NUMDOC').AsString  := strNumDoc;
  FVolumes.FieldByName('ESPDOC').AsString  := strEspDoc;
  FVolumes.FieldByName('CODEMP').AsString  := strCodEmp;
  FVolumes.FieldByName('NUMVOL').AsInteger := intVolume;
  FVolumes.Post;

end;

procedure TControleVolumesBipados.pCriaClientVolumes(var AClient: TUniClientDataSet);
begin
  AClient := TUniClientDataSet.Create(Nil);
  AClient.FieldDefs.Add('NUMDOC', ftString, 12);
  AClient.FieldDefs.Add('ESPDOC', ftString,  2);
  AClient.FieldDefs.Add('CODEMP', ftString,  3);
  AClient.FieldDefs.Add('NUMVOL', ftInteger, 0);
  AClient.CreateDataSet;
  AClient.IndexFieldNames := 'NUMVOL';
end;

procedure TControleVolumesBipados.pLimparVolumes;
begin
  FVolumes.EmptyDataSet;
end;

end.
