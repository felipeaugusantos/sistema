unit untLimparDanfes;

interface

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses
{$IFDEF LINUX}
  NFe.Utils,
{$ELSE}
  untUtil,
  Windows,
  Forms,
{$ENDIF}
  SysUtils,
  Classes,
  DateUtils,
  StrUtils,
  untRegistrarTarefa;

  type
    TLimparDanfes = class
  private
    { Private declarations }
    FTarefa: TRegistrarTarefa;
    procedure pLimparDiretorioDanfe;
    procedure pApagarArquivo(strPath: String; fileRec: TSearchRec);
    procedure pApagar(strArquivo: String);
  public
    intLimiarApagarArquivo: Integer;
    constructor Create(ATarefa: TRegistrarTarefa);
    procedure Executar;
  end;

implementation

uses
  untDicSis;

{ TLimparDanfes }

constructor TLimparDanfes.Create(ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  intLimiarApagarArquivo := 300;
end;

procedure TLimparDanfes.Executar;
begin
  Try
    pLimparDiretorioDanfe;
  Except
    On E: Exception Do
      pLogarErro(FTarefa.strTarefa, E);
  End;
end;

procedure TLimparDanfes.pLimparDiretorioDanfe;
  Var
    fileRec: TSearchRec;
    strPath: String;
begin
  strPath := fRetornaCaminhoLimparDiretorioDanfe;

  If FindFirst(strPath + '*.*', faAnyFile, fileRec) = 0 Then
  Begin
    Repeat
      If Not AnsiStartsText('.', fileRec.Name) Then
      Begin
        pApagarArquivo(strPath, fileRec);
      End;
    Until (FindNext(fileRec) <> 0);
  End;

  SysUtils.FindClose(fileRec);
end;

procedure TLimparDanfes.pApagarArquivo(strPath: String; fileRec: TSearchRec);
  Var
    dtaArquivo: TDateTime;
begin
  FTarefa.pSinalizarExecutando;

  If FTarefa.blnBloquear Then
    Exit;

  dtaArquivo := FileDateToDateTime(fileRec.Time);
  If MinutesBetween(Now, dtaArquivo) > intLimiarApagarArquivo Then
  Begin
    pApagar(strPath + PATH_SEPARATOR + fileRec.Name);
  End;
end;

procedure TLimparDanfes.pApagar(strArquivo: String);
  Var
    intCont: Integer;
begin
  For intCont := 1 To 5 Do
  Begin
    If DeleteFile(PChar(strArquivo)) Then
    Begin
      Break;
    End;
  End;
end;

end.
