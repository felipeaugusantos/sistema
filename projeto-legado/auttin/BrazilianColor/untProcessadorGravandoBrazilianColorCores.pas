unit untProcessadorGravandoBrazilianColorCores;

interface

uses
  untAbstractProcessadorGravandoBrazilianColor, Classes, DB, SysUtils, untIGravando,
  Variants,  Uni, ADODB, Math,
  untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoBrazilianColorCores = class(TAbstractProcessadorGravandoBrazilianColor,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    qryComposicao: TADOQuery;
    intAuto: Integer;
    procedure ProcessarConcentrado(const qryOrigem: TDataSet; const qryDestino: TDataSet); 
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    constructor Create(); override;
    destructor Destroy; override;
    procedure LimparTabelas; override; 
  end;

implementation

uses untDDLFactory, untFuncoesSimples, untFuncTinta;


{ TProcessadorGravandoBrazilianColorCores }

constructor TProcessadorGravandoBrazilianColorCores.Create;
begin
  inherited Create();
  qryComposicao := nil;
  intAuto := 1;
end;

destructor TProcessadorGravandoBrazilianColorCores.Destroy;
begin
  if Assigned(qryComposicao) then FreeAndNil(qryComposicao);
  pAtualizaProCodAutInc('BZC_CADBZC', intAuto);
  inherited;
end;

function TProcessadorGravandoBrazilianColorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoBrazilianColorCores.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := inherited GetAdoQuery(strNomeArquivo);
  if Assigned(qryComposicao) then FreeAndNil(qryComposicao);
  qryComposicao := inherited GetAdoQuery(strNomeArquivo);
  qryComposicao.SQL.Text :=
    ' SELECT                             ' +
    '   *                                ' +
    ' FROM                               ' +
    '   MIX_COMPOSICAO AS C              ' +
    '   INNER JOIN MIX_BASES AS B        ' +
    '     ON C.ID_MIX_BASES = B.CODIGO   ' +
    ' WHERE ID_MIX_FOMULACOES = :ID      ' +
    ' ORDER BY QUANTIDADE                ';
end;

function TProcessadorGravandoBrazilianColorCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('BZC_CADBZC');
end;

function TProcessadorGravandoBrazilianColorCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM MIX_Formulacoes ORDER BY id_MIX_Formulacoes ';
end;

procedure TProcessadorGravandoBrazilianColorCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZC_CADBZC';
end;

procedure TProcessadorGravandoBrazilianColorCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryInsert: TUniQuery;
begin
  qryInsert := TUniQuery(qryDestino);
  qryInsert.Params.Clear;
  qryInsert.SQL.Clear;
  qryInsert.SQL.Text := GetSqlDestino;

  qryComposicao.Close;
  qryComposicao.Parameters.ParamByName('ID').Value := qryOrigem.FieldByName('id_MIX_Formulacoes').AsString;
  qryComposicao.Open;

  qryInsert.ParamByName('BZC_CODIGO').AsString := qryOrigem.FieldByName('Codigo').AsString;
  qryInsert.ParamByName('BZC_CODUNI').AsString := qryOrigem.FieldByName('CodigoUniversal').AsString;
  qryInsert.ParamByName('BZC_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Descricao').AsString)));
  qryInsert.ParamByName('BZC_A_N_O_').AsString := qryOrigem.FieldByName('Ano').AsString;
  qryInsert.ParamByName('BZC_CODMON').AsString :=
    fStrZero(Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('id_MIX_Montadora').AsString))), 5);
  qryInsert.ParamByName('BZC_REVISA').AsString := qryOrigem.FieldByName('Revisao').AsString;
  qryInsert.ParamByName('BZC_ESPECI').AsString := qryOrigem.FieldByName('Especificacao').AsString;
  qryInsert.ParamByName('BZC_TIPO__').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Tipo').AsString)));
  qryInsert.ParamByName('BZC_CODPRE').AsString := qryOrigem.FieldByName('CodPrefixo').AsString;
  qryInsert.ParamByName('BZC_CODPRO').AsString := qryOrigem.FieldByName('CodProduto').AsString;
  qryInsert.ParamByName('BZC_CODSUF').AsString := qryOrigem.FieldByName('CodSufixo').AsString;
  qryInsert.ParamByName('BZC_PUBLIC').AsString := qryOrigem.FieldByName('Publicado').AsString;
  qryInsert.ParamByName('BZC_LINHA_').AsString := qryOrigem.FieldByName('linha').AsString;

  if Trunc(qryOrigem.FieldByName('PublicadoData').AsDateTime) > 0 then
    qryInsert.ParamByName('BZC_PUBDTA').AsDate := Trunc(qryOrigem.FieldByName('PublicadoData').AsDateTime);
    
  qryInsert.ParamByName('BZC_AUTORI').AsString := qryOrigem.FieldByName('Autorizador').AsString;
  qryInsert.ParamByName('BZC_REVISD').AsString := qryOrigem.FieldByName('Revisado').AsString;

  qryInsert.ParamByName('BZC_CODEMP').AsString := VS_strCodEmp;
  qryInsert.ParamByName('AUTOINCREM').AsString := fFormataAutInc(fInc(intAuto), VS_strCodEmp);
  
  qryInsert.ParamByName('BZC_MD5KEY').AsString := GetMD5(qryInsert.ParamByName('BZC_CODIGO').AsString +
    qryInsert.ParamByName('BZC_CODUNI').AsString +
    qryInsert.ParamByName('BZC_DESCRI').AsString +
    qryInsert.ParamByName('BZC_A_N_O_').AsString +
    qryInsert.ParamByName('BZC_TIPO__').AsString);

  qryComposicao.First;
  while not qryComposicao.Eof do
  begin
    qryInsert.ParamByName('BZC_BASE' + fStrZero(qryComposicao.RecNo, 2)).AsString :=
      Trim(AnsiUpperCase(fRemoveAcento(qryComposicao.FieldByName('C.id_MIX_Bases').AsString)));
    qryInsert.ParamByName('BZC_QTDD' + fStrZero(qryComposicao.RecNo, 2)).AsFloat :=
      RoundTo(qryComposicao.FieldByName('Quantidade').AsFloat * 0.9, -1);
    qryInsert.ParamByName('BZC_QTDC' + fStrZero(qryComposicao.RecNo, 2)).AsFloat := 0;
    qryComposicao.Next;
  end;

  ProcessarConcentrado(qryOrigem, qryDestino);
  qryInsert.ExecSQL;
end;

function TProcessadorGravandoBrazilianColorCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoBrazilianColorCores.LimparTabelas;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'TRUNCATE BZC_CADBZC';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TProcessadorGravandoBrazilianColorCores.ProcessarConcentrado(const qryOrigem, qryDestino: TDataSet);
var
  qryInsert: TUniQuery;
  fltPesoConcentradoCheio: Double;
  fltPesoDiluente: Double;
  fltPesoConcentrado: Double;
  fltFatorConcentrado: Double;
  fltValorMultiplicante: Double;
begin
  if not qryComposicao.Locate('C.id_MIX_Bases', 'BP 8007', []) then
    Exit;

  qryInsert := TUniQuery(qryDestino);
  fltPesoConcentradoCheio := 0;
  fltPesoDiluente := 0;
  fltPesoConcentrado := 0;

  qryComposicao.First;
  while not qryComposicao.Eof do
  begin
    fltPesoConcentradoCheio := fltPesoConcentradoCheio + qryComposicao.FieldByName('Quantidade').AsFloat;

    if Trim(AnsiUpperCase(fRemoveAcento(qryComposicao.FieldByName('C.id_MIX_Bases').AsString))) = 'BP 8007' then
      fltPesoDiluente := qryComposicao.FieldByName('Quantidade').AsFloat
    else
      fltPesoConcentrado := fltPesoConcentrado + (qryComposicao.FieldByName('Quantidade').AsFloat *
        qryComposicao.FieldByName('PesoEspecifico').AsFloat);
    qryComposicao.Next;
  end;

  fltFatorConcentrado := 0.9 / ((fltPesoConcentradoCheio - fltPesoDiluente) * 1000);
  fltValorMultiplicante := (((fltPesoConcentrado * fltFatorConcentrado) * 1000) * 1000) / (fltPesoConcentradoCheio - fltPesoDiluente);

  qryComposicao.First;
  while not qryComposicao.Eof do
  begin
    if qryInsert.ParamByName('BZC_BASE' + fStrZero(qryComposicao.RecNo, 2)).AsString <> 'BP 8007' then
      qryInsert.ParamByName('BZC_QTDC' + fStrZero(qryComposicao.RecNo, 2)).AsFloat :=
        RoundTo(qryComposicao.FieldByName('Quantidade').AsFloat * fltValorMultiplicante, -1)
    else
      qryInsert.ParamByName('BZC_QTDC' + fStrZero(qryComposicao.RecNo, 2)).AsFloat := 0;
      
    qryComposicao.Next;
  end;
end;

procedure TProcessadorGravandoBrazilianColorCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a cor [%s - %s - %s - %s][%s: %s]',
    [qryOrigem.FieldByName('Codigo').AsString,
    qryOrigem.FieldByName('Descricao').AsString,
    qryOrigem.FieldByName('Ano').AsString,
    qryOrigem.FieldByName('Tipo').AsString,
    E.ClassName, E.Message]);
end;

end.
