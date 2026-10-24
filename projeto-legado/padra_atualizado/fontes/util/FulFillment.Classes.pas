unit FulFillment.Classes;

interface

uses Windows, Classes, Forms, Buttons, Menus, frxClass, Uni, Data.DB,
     System.Generics.Collections, System.SysUtils, System.StrUtils,
     untFuncFatTypes, untFuncoesSimples;

Type

  TFulFillmentLog = class
  private
    FstrNumeroDocumento,
    FstrEspecieDocumento,
    FstrEmpresaDocumento,
    FstrSerie,
    FstrChave,
    FstrMensagem,
    FstrStatusRegistro    : String;
    FdtaDataDocumento     : TDateTime;
  public
    property strNumeroDocumento   : String    read FstrNumeroDocumento  write FstrNumeroDocumento;
    property strEspecieDocumento  : String    read FstrEspecieDocumento write FstrEspecieDocumento;
    property strEmpresaDocumento  : String    read FstrEmpresaDocumento write FstrEmpresaDocumento;
    property strSerie             : String    read FstrSerie            write FstrSerie;
    property strChave             : String    read FstrChave            write FstrChave;
    property strMensagem          : String    read FstrMensagem         write FstrMensagem;
    property strStatusRegistro    : String    read FstrStatusRegistro   write FstrStatusRegistro;
    property dtaDataDocumento     : TDateTime read FdtaDataDocumento    write FdtaDataDocumento;
  end;

  TFulFillmentLogRepositorio = class
  private
    procedure pSalvarLog(AFulFillmentLog : TFulFillmentLog);
    procedure pAtualizarRegistroParaErro(AFulFillmentLog : TFulFillmentLog);
  end;

  TFulFillmentLogBuilder = class
  private
    FstrNumeroDocumento,
    FstrEspecieDocumento,
    FstrEmpresaDocumento,
    FstrSerie,
    FstrChave,
    FstrStatusRegistro            : String;
    FdtaDataDocumento             : TDateTime;
    FblnLogTratadoEmRaise,
    FblnTemLog,
    FblnEhLogDeErro               : Boolean;
    FobjFulFillmentLogRepositorio : TFulFillmentLogRepositorio;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pSalvarLog(AstrMensagem : String; AblnEhLogDeErro : Boolean = False);

    property strNumeroDocumento   : String    read FstrNumeroDocumento   write FstrNumeroDocumento;
    property strEspecieDocumento  : String    read FstrEspecieDocumento  write FstrEspecieDocumento;
    property strEmpresaDocumento  : String    read FstrEmpresaDocumento  write FstrEmpresaDocumento;
    property strSerie             : String    read FstrSerie             write FstrSerie;
    property strChave             : String    read FstrChave             write FstrChave;
    property strStatusRegistro    : String    read FstrStatusRegistro    write FstrStatusRegistro;
    property dtaDataDocumento     : TDateTime read FdtaDataDocumento     write FdtaDataDocumento;
    property blnLogTratadoEmRaise : Boolean   read FblnLogTratadoEmRaise write FblnLogTratadoEmRaise;
    property blnTemLog            : Boolean   read FblnTemLog            write FblnTemLog;
    property blnEhLogDeErro       : Boolean   read FblnEhLogDeErro       write FblnEhLogDeErro;
  end;

implementation

{ TFulFillmentLogRepositorio }

procedure TFulFillmentLogRepositorio.pAtualizarRegistroParaErro(AFulFillmentLog: TFulFillmentLog);
  Var
    LQuery   : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add('UPDATE NFEIMP SET NFE_IMPORT = "E" WHERE NFE_ACESSO = :ACESSO  AND NFE_STATUS = :STATUS ');
    LQuery.ParamByName('STATUS').AsString := AFulFillmentLog.strStatusRegistro;
    LQuery.ParamByName('ACESSO').AsString := AFulFillmentLog.strChave;
    LQuery.ExecSql;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TFulFillmentLogRepositorio.pSalvarLog(AFulFillmentLog: TFulFillmentLog);
 Var
    LQuery   : TUniQuery;
    LstrNota : String;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add('SELECT * FROM FULL_LOGERR WHERE FALSE');
    LQuery.Open;
    LQuery.Insert;
    LQuery.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
    LQuery.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    LQuery.FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
    LQuery.FieldByName('LOG_HRAERR').AsDateTime := fTime();
    LQuery.FieldByName('LOG_NUMDOC').AsString   := AFulFillmentLog.strNumeroDocumento;
    LQuery.FieldByName('LOG_ESPDOC').AsString   := AFulFillmentLog.strEspecieDocumento;
    LQuery.FieldByName('LOG_SERIE_').AsString   := AFulFillmentLog.strSerie;
    LQuery.FieldByName('LOG_DTADOC').AsDateTime := AFulFillmentLog.dtaDataDocumento;
    LQuery.FieldByName('LOG_ACESSO').AsString   := AFulFillmentLog.strChave;

    If Not fEmptyStr(AFulFillmentLog.strNumeroDocumento) Then
    Begin
      LstrNota := 'Documento: ' +
                   AFulFillmentLog.strNumeroDocumento + '-' +
                   AFulFillmentLog.strEspecieDocumento + '-' +
                   AFulFillmentLog.strEmpresaDocumento + ' - ';
    End;

    LQuery.FieldByName('LOG_DESCRI').AsString := '[LOG ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', VS_Date + fTime()) + '] - ' +
                       LstrNota + AFulFillmentLog.strMensagem;
    LQuery.Post;
    LQuery.Close;

  Finally
    FreeAndNil(LQuery);
  End;
end;

{ TFulFillmentLogBuilder }

constructor TFulFillmentLogBuilder.Create;
begin
  FobjFulFillmentLogRepositorio := TFulFillmentLogRepositorio.Create;
  FstrNumeroDocumento           := '';
  FstrEspecieDocumento          := '';
  FstrEmpresaDocumento          := '';
  FstrSerie                     := '';
  FstrChave                     := '';
  FdtaDataDocumento             := 0;
  FstrStatusRegistro            := '';
  FblnLogTratadoEmRaise         := False;
  FblnTemLog                    := False;
  FblnEhLogDeErro               := False;
end;

destructor TFulFillmentLogBuilder.Destroy;
begin
  FreeAndNil(FobjFulFillmentLogRepositorio);
  inherited;
end;

procedure TFulFillmentLogBuilder.pSalvarLog(AstrMensagem : String; AblnEhLogDeErro : Boolean = False);
  var
    LobjFulFillmentLog : TFulFillmentLog;
begin
  LobjFulFillmentLog := TFulFillmentLog.Create;
  try
    LobjFulFillmentLog.strNumeroDocumento  := FstrNumeroDocumento;
    LobjFulFillmentLog.strEspecieDocumento := FstrEspecieDocumento;
    LobjFulFillmentLog.strEmpresaDocumento := FstrEmpresaDocumento;
    LobjFulFillmentLog.strSerie            := FstrSerie;
    LobjFulFillmentLog.strChave            := FstrChave;
    LobjFulFillmentLog.strMensagem         := AstrMensagem;
    LobjFulFillmentLog.dtaDataDocumento    := FdtaDataDocumento;
    LobjFulFillmentLog.strStatusRegistro   := FstrStatusRegistro;

    FobjFulFillmentLogRepositorio.pSalvarLog(LobjFulFillmentLog);

    if FblnLogTratadoEmRaise then
      FobjFulFillmentLogRepositorio.pAtualizarRegistroParaErro(LobjFulFillmentLog);

    FblnTemLog      := True;
    FblnEhLogDeErro := AblnEhLogDeErro;
  finally
    FreeAndNil(LobjFulFillmentLog);
  end;
end;

end.
