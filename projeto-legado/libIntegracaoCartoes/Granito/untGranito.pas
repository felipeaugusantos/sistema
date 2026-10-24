unit untGranito;

interface

uses
  Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untGranitoPgto, ComCtrls, untTImportacaoCartao;

type
  TGranito = class(TImportacaoCartao)
  private
    FGranitoPgto: TGranitoPgto;

    function ArquivoEhValido(ALinha: string): Boolean;
  published
    procedure pAdicionaLinhas;  override;
    procedure pGravarRegistros; override;
    procedure pProcessaArquivos(strPath: string); override;

    function fCarregaArquivos(strExt: string; APath: string): Boolean;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoes, untIDataSet, DateUtils;

constructor TGranito.Create(Owner: TComponent);
begin
  inherited;
  FGranitoPgto := TGranitoPgto.Create;
  lstEstabel := TStringList.Create;
  strNomCon := 'Granito';
  strMenCon := 'Layout de arquivo de lançamentos - versão 1.0.14';
end;

destructor TGranito.Destroy;
begin
  if Assigned(FGranitoPgto) Then
    FreeAndNil(FGranitoPgto);
  if Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

function TGranito.fCarregaArquivos(strExt: string; APath: string): Boolean;
var
  arqArquivo: TSearchRec;
  txtArquivo: TextFile;
  strLinha : string;
begin
  Result := True;
  if (FindFirst(APath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) then
  begin
    repeat
      try
        Application.ProcessMessages;
        AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        strLinha := fConverteParaAcento(strLinha);

        if ArquivoEhValido(strLinha) Then
          stlPgto.Add(APath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);
      except
        on E: Exception do
        begin
          if (UpperCase(E.Message) = 'I/O ERROR 32') then
            raise Exception.Create('O arquivo '+arqArquivo.Name+' está em uso por outro processo!')
          else
            raise Exception.Create(E.Message);
        end;
      end;
    until (FindNext(arqArquivo) <> 0);
  end;
  FindClose(arqArquivo);
end;

function TGranito.ArquivoEhValido(ALinha: string): Boolean;
const
  TIPO_REGISTRO = '0';
  NOME_OPERADORA = 'GRANITO SOLUCOES EM PAGAMENTOS';
  CNPJ_OPERADORA = '22177858000169';
var
  sNumSequencia,
  sCodDestinatario: string;
  iDia,
  iMes,
  iAno,
  iHor,
  iMin,
  iSeg: Word;
  dDataHoraArquivo: TDateTime;
begin
  Result := False;
  ALinha := AnsiUpperCase(ALinha);
  if ALinha.StartsWith('0') then { Cabecalho }
  begin
    iAno := StrToIntDef(Copy(ALinha, 46, 4), 0);
    iMes := StrToIntDef(Copy(ALinha, 50, 2), 0);
    iDia := StrToIntDef(Copy(ALinha, 52, 2), 0);
    iHor := StrToIntDef(Copy(ALinha, 54, 2), 0);
    iMin := StrToIntDef(Copy(ALinha, 56, 2), 0);
    iSeg := StrToIntDef(Copy(ALinha, 58, 2), 0);

    if not TryEncodeDateTime(iAno, iMes, iDia, iHor, iMin, iSeg, 0, dDataHoraArquivo) then
      Exit;

    sNumSequencia := Copy(ALinha, 60, 10);
    sCodDestinatario := Copy(ALinha, 70, 12);

    Result := ALinha.StartsWith(
      TIPO_REGISTRO +
      NOME_OPERADORA +
      CNPJ_OPERADORA +
      FormatDatetime('yyyymmddhhnnss', dDataHoraArquivo) +
      sNumSequencia +
      sCodDestinatario);
  end
  else
  begin
    Result := True;
  end;
end;

procedure TGranito.pProcessaArquivos(strPath: string);
begin
  try
    if not fCarregaArquivos('txt', strPath) then
      Exit;

    if (stlPgto.Count = 0) then
    begin
      objFunctions.fIMensagem('AVISO', 'Nenhum arquivo na pasta para importar!', ['&OK']);
      Exit;
    end;

    pAdicionaLinhas;
    pGravarRegistros;

    objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  except
    on E: Exception do
    begin
      objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);
      stlPgto.Clear;
    end;
  end;
end;

procedure TGranito.pAdicionaLinhas;
var
  sFileName, sLinha: string;
  stlAux: TStringList;
begin
  SetLength(FRegistroGranitoMovimentoFinanceiro , 0);
  stlAux := TStringList.Create;
  try
    for sFileName in stlPgto do
    begin
      Application.ProcessMessages;

      try
        stlAux.LoadFromFile(sFileName, TEncoding.UTF8);
      except
        stlAux.LoadFromFile(sFileName, TEncoding.ANSI);
      end;

      FGranitoPgto.NomeArquivoImportado := ExtractFileName(sFileName);
      pgbProg.Position := 0;
      pgbProg.Max := (stlAux.Count -1);

      for sLinha in stlAux do
      begin
        FGranitoPgto.pAdicionaLinha(sLinha);
        pgbProg.Position := (pgbProg.Position + 1);
      end;

      stlAux.Clear;
    end;

    pgbProg.Position := 0;
  finally
    stlAux.Free;
  end;
end;

procedure TGranito.pGravarRegistros;
var
  sFileName: string;
begin
  FGranitoPgto.pGravarRegistros(pgbProg);

  for sFileName in stlPgto do
  begin
    if (FileExists(AnsiReplaceStr(sFileName, ExtractFileExt(sFileName), '.imp'))) then
      DeleteFile(AnsiReplaceStr(sFileName, ExtractFileExt(sFileName), '.imp'));
    pRenomeiaAquivo(sFileName, AnsiReplaceStr(sFileName, ExtractFileExt(sFileName), '.imp'));
  end;
end;

end.
