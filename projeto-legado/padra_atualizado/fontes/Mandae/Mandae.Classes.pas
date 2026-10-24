unit Mandae.Classes;

interface

uses UniClientDataSet;

  Type

  TMandae = class
    FstrNumeroDocumento,
    FstrEspecieDocumento,
    FstrCodigoEmpresa     : String;
    FintNumeroVolumes     : integer;
    FdtaDocumento         : TDateTime;
  public
    property strNumeroDocumento   : String    read FstrNumeroDocumento  write FstrNumeroDocumento;
    property strEspecieDocumento  : String    read FstrEspecieDocumento write FstrEspecieDocumento;
    property strCodigoEmpresa     : String    read FstrCodigoEmpresa    write FstrCodigoEmpresa;
    property intNumeroVolumes     : integer   read FintNumeroVolumes    write FintNumeroVolumes;
    property dtaDocumento         : TDateTime read FdtaDocumento        write FdtaDocumento;
  end;

  TMandaeFiltro = class
    FstrNumeroDocumento,
    FstrEspecieDocumento,
    FstrCodigoEmpresa     : String;
    FdtaDocumento         : TDateTime;
    FdtaEnvio             : TDateTime;
  public
    property strNumeroDocumento   : String    read FstrNumeroDocumento  write FstrNumeroDocumento;
    property strEspecieDocumento  : String    read FstrEspecieDocumento write FstrEspecieDocumento;
    property strCodigoEmpresa     : String    read FstrCodigoEmpresa    write FstrCodigoEmpresa;
    property dtaDocumento         : TDateTime read FdtaDocumento        write FdtaDocumento;
    property dtaEnvio             : TDateTime read FdtaEnvio            write FdtaEnvio;
  end;

  TMandaeRepositorio = class
  private
    function fGravarEtiqueta(AobjMandae : TMandae) : Boolean;
    procedure pAlinharConteudoNoClienteDataSet(var Acds : TUniClientDataSet);
  public
    function fDocumentoJaPossuiEtiqueta(AstrNumeroDocumento, AstrEspecieDocumento, AstrCodigoEmpresa : String) : Boolean;
    function fListarDocumentosPendentes(AstrCodigoEmpresa : String) : TUniClientDataSet; overload;
    function fListarDocumentosPendentes(AstrDocumentosFgo, AstrDocumentosGer: String) : TUniClientDataSet; overload;
    procedure pAtualizaRetornoDaIntegracao(AstrAutoincremento : String; AintCodigoIntegracao : Integer; AMensagemIntegracao : String);
    function fTransportadoraIntegraComMandae(ACodigoTransportadora : String) : Boolean;
    function fDocumentoJaIntegradoComMandae(AstrNumeroDocumento, AstrEspecieDocumento, AstrCodigoEmpresa : String) : Boolean;
    function fNumeroDeVolumesIntegradoComMandae(AstrNumeroDocumento, AstrEspecieDocumento, AstrCodigoEmpresa : String) : Integer;
    function fListarDocumentosIntegrados(AObjMandaeFiltro : TMandaeFiltro) : TUniClientDataSet;
  end;

  TMandaeBuilder = class
    FObjMandaeRepositorio : TMandaeRepositorio;
    FstrNumeroDocumento,
    FstrEspecieDocumento,
    FstrCodigoEmpresa     : String;
    FintNumeroVolumes     : integer;
    FdtaDocumento         : TDateTime;
  public
    constructor Create;
    destructor Destroy; override;
    function fGerarEtiquetas(Amensagem : String) : Boolean;

    property strNumeroDocumento   : String    read FstrNumeroDocumento  write FstrNumeroDocumento;
    property strEspecieDocumento  : String    read FstrEspecieDocumento write FstrEspecieDocumento;
    property strCodigoEmpresa     : String    read FstrCodigoEmpresa    write FstrCodigoEmpresa;
    property intNumeroVolumes     : integer   read FintNumeroVolumes    write FintNumeroVolumes;
    property dtaDocumento         : TDateTime read FdtaDocumento        write FdtaDocumento;
  end;



implementation

uses untFuncoesSimples, Uni, System.SysUtils, Data.DB, System.Classes;

{ TMandaeRepositorio }

constructor TMandaeBuilder.Create;
begin
  FObjMandaeRepositorio := TMandaeRepositorio.Create;
end;

destructor TMandaeBuilder.Destroy;
begin
  FreeAndNil(FObjMandaeRepositorio);
  inherited;
end;

function TMandaeBuilder.fGerarEtiquetas(Amensagem : String) : Boolean;
  var
    LobjMandae : TMandae;
Begin
  if fEmptyStr(self.FstrNumeroDocumento) Or
     fEmptyStr(self.FstrEspecieDocumento) Or
     fEmptyStr(self.FstrCodigoEmpresa) Or
     (self.FintNumeroVolumes = 0) Or
     (self.FdtaDocumento = 0) then
  Begin
    Amensagem := 'Favor revisar os parâmetros para criação das etiquetas';
    Exit(False);
  End;

  Try
    if FObjMandaeRepositorio.fDocumentoJaPossuiEtiqueta(self.FstrNumeroDocumento,
                                                        self.FstrEspecieDocumento,
                                                        self.FstrCodigoEmpresa) then
      Exit(True);

    LobjMandae := TMandae.Create;
    LobjMandae.strNumeroDocumento  := self.FstrNumeroDocumento;
    LobjMandae.strEspecieDocumento := self.FstrEspecieDocumento;
    LobjMandae.strCodigoEmpresa    := self.FstrCodigoEmpresa;
    LobjMandae.intNumeroVolumes    := self.FintNumeroVolumes;
    LobjMandae.dtaDocumento        := self.FdtaDocumento;

    Result := FObjMandaeRepositorio.fGravarEtiqueta(LobjMandae);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
      Result := False;
    End;
  End;
end;

{ TMandaeRepositorio }

function TMandaeRepositorio.fGravarEtiqueta(AobjMandae : TMandae): Boolean;
  Var
    LQuery : TUniQuery;
    LIdx : Integer;
Begin
  Try
    fStartTransaction;

    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := ' INSERT INTO MANDOC (AUTOINCREM, MAN_NUMDOC, MAN_ESPDOC, MAN_CODEMP, MAN_VOLUME, MAN_DTADOC, MAN_CODRAS, MAN_MENINT) '+
                         ' VALUES (:AUTINC, :NUMDOC, :ESPDOC, :CODEMP, :VOLUME, :DTADOC, :CODRAS, :MENINT) ';

      For LIdx := 1 To AobjMandae.intNumeroVolumes Do
      Begin
        LQuery.ParamByName('AUTINC').AsString  := fRetAutoIncrem('MANDOC', VS_strCodEmp);
        LQuery.ParamByName('NUMDOC').AsString  := AobjMandae.strNumeroDocumento;
        LQuery.ParamByName('ESPDOC').AsString  := AobjMandae.strEspecieDocumento;
        LQuery.ParamByName('CODEMP').AsString  := AobjMandae.strCodigoEmpresa;
        LQuery.ParamByName('VOLUME').AsInteger := LIdx;
        LQuery.ParamByName('DTADOC').AsDateTime:= AobjMandae.dtaDocumento;
        LQuery.ParamByName('CODRAS').AsString  := fCfgSis('MANCRP', varString)+ fRetSequencial('MANCRS', AobjMandae.strCodigoEmpresa, 12);
        LQuery.ParamByName('MENINT').AsString  := 'A ENVIAR';
        LQuery.ExecSQL
      End;

    Finally
      FreeAndNil(LQuery);
    End;

    Result := fCommit;

  Except
    On E : Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TMandaeRepositorio.fListarDocumentosIntegrados(AObjMandaeFiltro: TMandaeFiltro): TUniClientDataSet;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'SELECT * FROM MANDOC WHERE (MAN_DTAENV IS NOT NULL OR MAN_DTAENV <> '''') ';

    if not fEmptyStr(AObjMandaeFiltro.strNumeroDocumento) then
    Begin
      LQuery.SQL.Text := LQuery.SQL.Text + ' AND MAN_NUMDOC = :NUMDOC ';
      LQuery.ParamByName('NUMDOC').AsString := AObjMandaeFiltro.strNumeroDocumento;
    End;

    if not fEmptyStr(AObjMandaeFiltro.strEspecieDocumento) then
    Begin
      LQuery.SQL.Text := LQuery.SQL.Text + ' AND MAN_ESPDOC = :ESPDOC ';
      LQuery.ParamByName('ESPDOC').AsString := AObjMandaeFiltro.strEspecieDocumento;
    End;

    if not fEmptyStr(AObjMandaeFiltro.strCodigoEmpresa) then
    Begin
      LQuery.SQL.Text := LQuery.SQL.Text + ' AND MAN_CODEMP = :CODEMP ';
      LQuery.ParamByName('CODEMP').AsString := AObjMandaeFiltro.strCodigoEmpresa;
    End;

    if AObjMandaeFiltro.dtaDocumento <> 0 then
    Begin
      LQuery.SQL.Text := LQuery.SQL.Text + ' AND DATE(MAN_DTADOC) = :DTADOC ';
      LQuery.ParamByName('DTADOC').AsDateTime := AObjMandaeFiltro.dtaDocumento;
    End;

    if AObjMandaeFiltro.dtaEnvio <> 0 then
    Begin
      LQuery.SQL.Text := LQuery.SQL.Text + ' AND DATE(MAN_DTAENV) = :DTAENV ';
      LQuery.ParamByName('DTAENV').AsDateTime := AObjMandaeFiltro.dtaEnvio;
    End;

    LQuery.Open;
    Result := fCriaClientDatset(LQuery);
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

  if Assigned(Result) then
    pAlinharConteudoNoClienteDataSet(Result);
end;

function TMandaeRepositorio.fListarDocumentosPendentes(AstrDocumentosFgo, AstrDocumentosGer: String): TUniClientDataSet;
  Var
    LQuery  : TUniQuery;
    LstrSQLGer,
    LstrSQLFGO : String;
Begin
  LQuery := fCriaQuery;
  Try
    if not fEmptyStr(AstrDocumentosGer) then
      LstrSQLGer := ' SELECT D.* '+
                    '   FROM MOVGER G '+
                    AstrDocumentosGer +
                    '   LEFT JOIN MANDOC D ON G.GER_NUMDOC = D.MAN_NUMDOC '+
                    '                     AND G.GER_ESPDOC = D.MAN_ESPDOC '+
                    '                     AND G.GER_CODEMP = D.MAN_CODEMP '+
                    '  WHERE D.MAN_DTAENV IS NULL '+
                    '    AND D.AUTOINCREM IS NOT NULL ';

    if not fEmptyStr(AstrDocumentosFgo) then
      LstrSQLFGO := ' SELECT D.* '+
                    '   FROM FATGOR G '+
                    AstrDocumentosFgo +
                    '   LEFT JOIN MANDOC D ON G.FGO_NUMDOC = D.MAN_NUMDOC '+
                    '                     AND G.FGO_ESPDOC = D.MAN_ESPDOC '+
                    '                     AND G.FGO_CODEMP = D.MAN_CODEMP '+
                    '  WHERE D.MAN_DTAENV IS NULL '+
                    '    AND D.AUTOINCREM IS NOT NULL ';


    if not fEmptyStr(AstrDocumentosGer) then
      LQuery.Sql.Text := LstrSQLGer;

    if not fEmptyStr(AstrDocumentosGer) and not fEmptyStr(AstrDocumentosFgo) then
      LQuery.Sql.Text := LQuery.Sql.Text  + ' UNION ';

    if not fEmptyStr(AstrDocumentosFgo) then
      LQuery.Sql.Text := LQuery.Sql.Text + LstrSQLFGO;

    LQuery.Open;
    Result := fCriaClientDatset(LQuery);
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

  if Assigned(Result) then
    pAlinharConteudoNoClienteDataSet(Result);

end;

function TMandaeRepositorio.fNumeroDeVolumesIntegradoComMandae(AstrNumeroDocumento, AstrEspecieDocumento,
  AstrCodigoEmpresa: String): Integer;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'SELECT MAN_DTAENV '+
                       '  FROM MANDOC     '+
                       ' WHERE MAN_NUMDOC = :NUMDOC '+
                       '   AND MAN_ESPDOC = :ESPDOC '+
                       '   AND MAN_CODEMP = :CODEMP ';
    LQuery.ParamByname('NUMDOC').AsString := AstrNumeroDocumento;
    LQuery.ParamByname('ESPDOC').AsString := AstrEspecieDocumento;
    LQuery.ParamByname('CODEMP').AsString := AstrCodigoEmpresa;
    LQuery.Open;
    Result := LQuery.RecordCount;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

end;

function TMandaeRepositorio.fListarDocumentosPendentes(AstrCodigoEmpresa : String): TUniClientDataSet;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'SELECT * FROM MANDOC WHERE MAN_CODEMP = :CODEMP AND MAN_DTAENV IS NULL ';
    LQuery.ParamByname('CODEMP').AsString := AstrCodigoEmpresa;
    LQuery.Open;
    Result := fCriaClientDatset(LQuery);
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;

  if Assigned(Result) then
    pAlinharConteudoNoClienteDataSet(Result);
end;

function TMandaeRepositorio.fTransportadoraIntegraComMandae(ACodigoTransportadora: String): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := ' SELECT C.TRA_ETIDES FROM CADTRA C WHERE C.TRA_CODTRA = :CODTRA ';
    LQuery.ParamByName('CODTRA').AsString := ACodigoTransportadora;
    LQuery.Open;
    Result := LQuery.FieldByName('TRA_ETIDES').AsString = 'MANDAE';
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TMandaeRepositorio.pAlinharConteudoNoClienteDataSet(var Acds : TUniClientDataSet);
begin
  Acds.FieldByName('MAN_NUMDOC').Alignment := taCenter;
  Acds.FieldByName('MAN_ESPDOC').Alignment := taCenter;
  Acds.FieldByName('MAN_CODRAS').Alignment := taCenter;
  Acds.FieldByName('MAN_VOLUME').Alignment := taCenter;
  Acds.FieldByName('MAN_CODINT').Alignment := taCenter;
  Acds.FieldByName('MAN_MENINT').Alignment := taCenter;
  Acds.FieldByName('MAN_DTADOC').Alignment := taCenter;
  Acds.FieldByName('MAN_DTAENV').Alignment := taCenter;
end;

procedure TMandaeRepositorio.pAtualizaRetornoDaIntegracao(AstrAutoincremento: String; AintCodigoIntegracao: Integer;
  AMensagemIntegracao: String);
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'UPDATE MANDOC SET  '+
                       ' MAN_CODINT = :CODINT, '+
                       ' MAN_MENINT = :MENINT ';

    {************************************}
    {Codigo de integracao < 400 significa
     integração realizada com sucesso
    {**********************************GD}
    if AintCodigoIntegracao < 400 then
      LQuery.SQL.Text := LQuery.SQL.Text + ' ,MAN_DTAENV = :DTAENV ';

    LQuery.SQL.Text := LQuery.SQL.Text + ' WHERE AUTOINCREM = :AUTINC';

    LQuery.ParamByname('CODINT').AsString := IntToStr(AintCodigoIntegracao);
    LQuery.ParamByname('MENINT').AsString := AMensagemIntegracao;

    if AintCodigoIntegracao < 400 then
      LQuery.ParamByname('DTAENV').AsDateTime := fNow();

    LQuery.ParamByname('AUTINC').AsString := AstrAutoincremento;
    LQuery.ExecSql;
  Finally
    FreeAndNil(LQuery);
  End;

end;

function TMandaeRepositorio.fDocumentoJaIntegradoComMandae(AstrNumeroDocumento, AstrEspecieDocumento, AstrCodigoEmpresa: String): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Result := False;

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'SELECT MAN_DTAENV '+
                       '  FROM MANDOC     '+
                       ' WHERE MAN_NUMDOC = :NUMDOC '+
                       '   AND MAN_ESPDOC = :ESPDOC '+
                       '   AND MAN_CODEMP = :CODEMP ';
    LQuery.ParamByname('NUMDOC').AsString := AstrNumeroDocumento;
    LQuery.ParamByname('ESPDOC').AsString := AstrEspecieDocumento;
    LQuery.ParamByname('CODEMP').AsString := AstrCodigoEmpresa;
    LQuery.Open;
    while not LQuery.Eof  do
    Begin
      Result := LQuery.FieldByName('MAN_DTAENV').AsDateTime <> 0;

      if Result then
        Break;

      LQuery.next;
    End;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TMandaeRepositorio.fDocumentoJaPossuiEtiqueta(AstrNumeroDocumento, AstrEspecieDocumento, AstrCodigoEmpresa : String): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := 'SELECT AUTOINCREM '+
                       '  FROM MANDOC     '+
                       ' WHERE MAN_NUMDOC = :NUMDOC '+
                       '   AND MAN_ESPDOC = :ESPDOC '+
                       '   AND MAN_CODEMP = :CODEMP ';
    LQuery.ParamByname('NUMDOC').AsString := AstrNumeroDocumento;
    LQuery.ParamByname('ESPDOC').AsString := AstrEspecieDocumento;
    LQuery.ParamByname('CODEMP').AsString := AstrCodigoEmpresa;
    LQuery.Open;
    Result := not LQuery.IsEmpty;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
