unit ImportacaoDados.Model.ModeloArquivo;

interface

uses
  ImportacaoDados.Interfaces, Uni, untTValidaExcel, cxProgressBar, System.Generics.Collections,
  DB;

Type
  TCamposModeloArquivo = Class;

  TModeloArquivoImportacao = Class(TInterfacedObject, IModeloArquivoImportacao)
  private
    FAutInc: String;
    FCodigo: String;
    FDescricao: String;
    FTipo: TTipoImportacaoArquivo;
    FSQLInsert: String;
    FSQLUpdate: String;
    FSQLDelete,
    FSQLDeleteItens: String;
    FSQLSelectCampos: String;
    FQry: TUniQuery;
    FListaCampos: TList<ICamposModeloArquivo>;
    FCampo: ICamposModeloArquivo;
    FEstadoTela : TTipoEstadoTela;
    FCamposPadrao: TList<TCampoPlanilha>;
    FNomTabela: String;
    FListaModeloTabelas: TList<IModeloArquivoImportacao>;
    FblnEditavel: Boolean;

    function GetCodigo: String;
    function GetDescricao: String;
    function GetAutoIncrem: String;
    function GetTipoImportacaoArquivo: TTipoImportacaoArquivo;
    procedure SetCodigo(Const AValue: String);
    procedure SetDescricao(Const AValue: String);
    procedure SetAutoIncrem(Const AValue: String);
    procedure SetTipoImportacaoArquivo(Const AValue: TTipoImportacaoArquivo);
    procedure SetCampos(const aValue: TList<ICamposModeloArquivo>);
    function GetCampos:  TList<ICamposModeloArquivo>;
    function GetEstadoTela : TTipoEstadoTela;
    procedure SetEstadoTela(Const AValue: TTipoEstadoTela);
    function GetCamposPadrao: TList<TCampoPlanilha>;
    procedure SetCamposPadrao(const AValue: TList<TCampoPlanilha>);
    function GetNomTab: String;
    procedure SetNomTab(const AValue: String);
    function GetListaModeloTabelas: TList<IModeloArquivoImportacao>; virtual;
    function GetBlnEdt: Boolean;
    procedure SetBlnEdt(const AValue: Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function ModeloArquivoImportacao: IModeloArquivoImportacao;
    function Campo: ICamposModeloArquivo;
    function AddCampo: ICamposModeloArquivo;
    function fInserir: IModeloArquivoImportacao;
    function fAlterar: IModeloArquivoImportacao;
    function fExcluir: IModeloArquivoImportacao;
    function fCarregarCampos: Boolean; virtual;
    function fAtualizarModeloAtual: Boolean;
    function fAdicionarCampo(Const aNomeCampo, aTituloCampo, aColuna, aObrigatorio: String;
      Const aTipoCampo: TFieldType; Const aTamanhoCampo: Integer;
      Const ablnTabela: Boolean = False; ablnCmpLig: Boolean = False;
      ablnPreAut: Boolean = False) : TCampoPlanilha;
    procedure pLimparCampos;
    function fCarregarCamposPadrao: Boolean; virtual;
    procedure pDefineCamposPadrao; virtual;
    function fAddModeloTabela(aModelo: IModeloArquivoImportacao): IModeloArquivoImportacao;

    property Campos: TList<ICamposModeloArquivo> read GetCampos write SetCampos;
    property AutoIncrem: String read GetAutoIncrem write SetAutoIncrem;
    property Codigo: String read GetCodigo write SetCodigo;
    property Descricao: String read GetDescricao write SetDescricao;
    property Tipo: TTipoImportacaoArquivo read GetTipoImportacaoArquivo write SetTipoImportacaoArquivo;
    property EstadoTela: TTipoEstadoTela read GetEstadoTela write SetEstadoTela;
    property CamposPadrao: TList<TCampoPlanilha> read GetCamposPadrao write SetCamposPadrao;
    property strNomeTabela: String read GetNomTab write SetNomTab;
    property ListaModeloTabelas: TList<IModeloArquivoImportacao> read GetListaModeloTabelas;
    property Editavel: Boolean read GetBlnEdt write SetBlnEdt;
  End;

  TCamposModeloArquivo = Class(TInterfacedObject, ICamposModeloArquivo)
  private
    [weak]
    FModeloArquivo: IModeloArquivoImportacao;
    FCodigo: String;
    FDescricao: String;
    FObrigatorio: String;
    FSQLInsert: String;
    FSQLUpdate: String;
    FSQLDelete: String;
    FQry: TUniQuery;
    FAutInc: String;
    FColuna: String;
    FPosicaoCampo: Integer;
    FFieldType: TFieldType;
    FNomeCampo: String;
    FTamanhoCampo: Integer;
    FCodModelo: String;
    FBlnTabela: Boolean;
    FblnCmpLig: Boolean;
    FBlnPreAut: Boolean;
    FBlnExibirTextoPuro : Boolean;

    function GetCodigo: String;
    function GetDescricao: String;
    function GetObrigatorio: String;
    procedure SetCodigo(const aValue: String);
    procedure SetDescricao(const aValue: String);
    procedure SetObrigatorio(const aValue: String);
    function GetColuna: String;
    procedure SetColuna(Const aValue: String);
    function GetPosicao: Integer;
    procedure SetPosicao(Const aValue: Integer);
    function GetNomeCampo: String;
    procedure SetNomeCampo(Const aValue: String);
    function GetFieldType: TFieldType;
    procedure SetFieldType(const aValue: TFieldType);
    function GetTamanho: Integer;
    procedure SetTamanho(Const aValue: Integer);
    function GetCodModelo: String;
    procedure SetCodModelo(Const aValue: String);
    function GetAutInc: String;
    procedure SetAutInc(Const aValue: String);
    function GetBlnTab: Boolean;
    procedure SetBlnTab(Const aValue: Boolean);
    function GetCmpLig: Boolean;
    procedure SetCmpLig(Const aValue: Boolean);
    function GetBlnAut: Boolean;
    procedure SetBlnAut(Const aValue: Boolean);
    function GetBlnPuro: Boolean;
    procedure SetBlnPuro(Const aValue: Boolean);
  public
    constructor Create(aModeloArquivo: IModeloArquivoImportacao);
    destructor Destroy; override;

    property Codigo: String read GetCodigo write SetCodigo;
    property NomeCampo: String read GetNomeCampo write SetNomeCampo;
    property Descricao: String read GetDescricao write SetDescricao;
    property Obrigatorio: String read GetObrigatorio write SetObrigatorio;
    property Coluna: String read GetColuna write SetColuna;
    property Posicao: Integer read GetPosicao write SetPosicao;
    property TipoCampo: TFieldType read GetFieldType write SetFieldType;
    property Tamanho: Integer read GetTamanho write SetTamanho;
    property blnTabela: Boolean read GetBlnTab write SetBlnTab;
    property blnCmpLig: Boolean read GetCmpLig write SetCmpLig;
    property blnCampoPreenchimentoAutomatico: Boolean read GetBlnAut write SetBlnAut;
    property blnExibirTextoPuro : Boolean read GetBlnPuro write SetBlnPuro;
    function ModeloArquivo : IModeloArquivoImportacao;
    function fInserir: ICamposModeloArquivo;
    function fAlterar: ICamposModeloArquivo;
    function fExcluir: ICamposModeloArquivo;
    function Campos: ICamposModeloArquivo;
    function fRetPosColuna(Const aColuna: String): Integer;

    class function New(Const aModeloArquivo: IModeloArquivoImportacao): ICamposModeloArquivo;
  End;


implementation

{ TModeloArquivoImportacao }

uses
  untFuncoesSimples, SysUtils;


function TModeloArquivoImportacao.Campo: ICamposModeloArquivo;
begin
  Result := FCampo;
end;

constructor TModeloArquivoImportacao.Create;
begin
  inherited;

  FSQLInsert := 'INSERT INTO MDLARQ(AUTOINCREM, MDL_CODARQ, MDL_DESARQ, MDL_TIPARQ) '+
                'VALUES(:AUTOINCREM, :MDL_CODARQ, :MDL_DESARQ, :MDL_TIPARQ)';

  FSQLUpdate := 'UPDATE MDLARQ SET MDL_DESARQ = :DESCRICAO, MDL_TIPARQ = :TIPO '+
                'WHERE AUTOINCREM = :AUTOINCREM';

  FSQLDelete := 'DELETE FROM MDLARQ ' +
                'WHERE AUTOINCREM = :AUTOINCREM';

  FSQLDeleteItens := 'DELETE FROM CMPARQ '+
                     'WHERE CMP_SEQARQ = :CMP_SEQARQ';

  FSQLSelectCampos := 'SELECT * FROM CMPARQ WHERE CMP_SEQARQ = :AUTINC ' +
                      'ORDER BY CHAR_LENGTH(CMP_COLCAM), CMP_COLCAM';

  FQry := fCriaQuery(nil);
  FQry.DisableControls;
  FListaCampos := TList<ICamposModeloArquivo>.Create;
  FCamposPadrao := TList<TCampoPlanilha>.Create;
  FNomTabela := EmptyStr;
  FListaModeloTabelas := TList<IModeloArquivoImportacao>.Create;
  FblnEditavel := True;
end;

destructor TModeloArquivoImportacao.Destroy;
begin

  inherited;

  FreeAndNil(FQry);
  FreeAndNil(FListaCampos);
  FreeAndNil(FCamposPadrao);
  FreeAndNil(FListaModeloTabelas);
end;

function TModeloArquivoImportacao.fInserir: IModeloArquivoImportacao;
var
  intCnt: Integer;
begin
  Result := Self;
  fStartTransaction;
  Try
    FAutInc := fRetAutoIncrem('MDLARQ', VS_strCodEmp);
    FCodigo := fAtualizaProCod('MDLARQ', 'MDL_CODARQ');

    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(FSQLInsert);
    FQry.ParamByName('AUTOINCREM').AsString := FAutInc;
    FQry.ParamByName('MDL_CODARQ').AsString := FCodigo;
    FQry.ParamByName('MDL_DESARQ').AsString := FDescricao;
    FQry.ParamByName('MDL_TIPARQ').AsString := strTipoImportacaoArquivo[FTipo];
    FQry.ExecSQL;

    For intCnt := 0 to FListaCampos.Count-1 Do
    Begin
      FListaCampos.Items[intCnt].fInserir;
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TModeloArquivoImportacao.fInserir]');
    End;
  End;
end;

function TModeloArquivoImportacao.AddCampo: ICamposModeloArquivo;
var
  intCont: Integer;
begin
  FListaCampos.Add(TCamposModeloArquivo.Create(Self));
  intCont := FListaCampos.Count -1;
  FListaCampos[intCont].Posicao := intCont;
  Result := FListaCampos[intCont];
end;

function TModeloArquivoImportacao.fAlterar: IModeloArquivoImportacao;
var
  intCnt: Integer;
begin
  fStartTransaction;
  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(FSQLUpdate);
    FQry.ParamByName('AUTOINCREM').AsString := FAutInc;
    FQry.ParamByName('DESCRICAO').AsString := FDescricao;
    FQry.ParamByName('TIPO').AsString := strTipoImportacaoArquivo[FTipo];
    FQry.ExecSQL;

    For intCnt := 0 to FListaCampos.Count-1 Do
    Begin
      FListaCampos.Items[intCnt].fAlterar;
    End;

    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TModeloArquivoImportacao.fAlterar]');
    End;
  End;

  Result := Self;
end;

function TModeloArquivoImportacao.fExcluir: IModeloArquivoImportacao;
begin
  Result := Self;
  fStartTransaction;

  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(FSQLDeleteItens);
    FQry.ParamByName('CMP_SEQARQ').AsString := FAutInc;
    FQry.ExecSQL;

    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(FSQLDelete);
    FQry.ParamByName('AUTOINCREM').AsString :=FAutInc;
    FQry.ExecSQL;
    fCommit;

    Self.pLimparCampos;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TModeloArquivoImportacao.Excluir]');
    End;
  End;
end;

function TModeloArquivoImportacao.fAddModeloTabela(
  aModelo: IModeloArquivoImportacao): IModeloArquivoImportacao;
var
  intIndice: Integer;
begin
  FListaModeloTabelas.Add(aModelo);
  intIndice := FListaModeloTabelas.Count-1;
  Result := FListaModeloTabelas[intIndice];
end;

function TModeloArquivoImportacao.fAdicionarCampo(const aNomeCampo, aTituloCampo,
  aColuna, aObrigatorio: String; const aTipoCampo: TFieldType; Const aTamanhoCampo: Integer;
  const ablnTabela: Boolean = False; ablnCmpLig: Boolean = False; ablnPreAut: Boolean = False): TCampoPlanilha;
var
  aCampo: TCampoPlanilha;
begin
  aCampo.NomeCampo := aNomeCampo;
  aCampo.DescricaoCampo := aTituloCampo;
  aCampo.Coluna := aColuna;
  aCampo.Obrigatorio := aObrigatorio;
  aCampo.TipoCampo := aTipoCampo;
  aCampo.Tamanho := aTamanhoCampo;
  aCampo.blnTabela := ablnTabela;
  aCampo.blnCmpLig := ablnCmpLig;
  aCampo.blnPreAut := ablnPreAut;
  Result := aCampo;
end;

function TModeloArquivoImportacao.fAtualizarModeloAtual: Boolean;
begin
  Result := False;

  If fEmptyStr(FAutInc) Then
    Exit;

  fStartTransaction;
  Try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add('UPDATE MDLARQ SET MDL_MDLATU = "N"  ' +
                 'WHERE MDL_MDLATU = "S"');
    FQry.ExecSQL;
    FQry.SQL.Clear;
    FQry.SQL.Add('UPDATE MDLARQ SET MDL_MDLATU = "S"  ' +
                 'WHERE AUTOINCREM = :AUTINC');
    FQry.ParamByName('AUTINC').AsString := FAutInc;
    FQry.ExecSQL;

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TModeloArquivoImportacao.fAtualizaModeloAtual]');
    End;
  End;

end;

function TModeloArquivoImportacao.fCarregarCampos: Boolean;
var
  aCampo: ICamposModeloArquivo;
begin
  FListaCampos.Clear;

  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add(FSQLSelectCampos);
  FQry.ParamByName('AUTINC').AsString := FAutInc;
  FQry.Open;
  While Not(FQry.Eof) Do
  Begin
    If (Not fEmptyStr(FQry.FieldByName('CMP_COLCAM').AsString)) Or (EstadoTela = tpEdicao) Then
    Begin
      aCampo := Self.AddCampo;
      aCampo.AutInc := FQry.FieldByName('AUTOINCREM').AsString;
      aCampo.Codigo := FQry.FieldByName('CMP_CODCAM').AsString;
      aCampo.CodModelo := FQry.FieldByName('CMP_SEQARQ').AsString;
      aCampo.NomeCampo := FQry.FieldByName('CMP_NOMCAM').AsString;
      aCampo.Descricao := FQry.FieldByName('CMP_DESCAM').AsString;
      aCampo.Coluna := FQry.FieldByName('CMP_COLCAM').AsString;
      aCampo.Posicao := FQry.FieldByName('CMP_POSCAM').AsInteger;
      aCampo.Obrigatorio := FQry.FieldByName('CMP_OBRCAM').AsString;
      aCampo.TipoCampo := StrToFieldType(FQry.FieldByName('CMP_TIPCAM').AsString);
      aCampo.Tamanho  := FQry.FieldByName('CMP_TAMCAM').AsInteger;
      aCampo.blnTabela  := IIF(FQry.FieldByName('CMP_TABCAM').AsString = 'S', True, False);
      aCampo.blnCmpLig  := IIF(FQry.FieldByName('CMP_CMPLIG').AsString = 'S', True, False);
      aCampo.blnPreAut  := IIF(FQry.FieldByName('CMP_PREAUT').AsString = 'S', True, False);
    End;

    FQry.Next;
  End;

  Result := True;

end;

function TModeloArquivoImportacao.fCarregarCamposPadrao: Boolean;
var
  aCampo: ICamposModeloArquivo;
  intCnt: Integer;
begin
  inherited;

  pLimparCampos;
  Try
    For intCnt := 0 to FCamposPadrao.Count-1 Do
    Begin
      aCampo := Self.AddCampo;
      aCampo.NomeCampo   := FCamposPadrao[intCnt].NomeCampo;
      aCampo.Descricao   := FCamposPadrao[intCnt].DescricaoCampo;
      aCampo.Coluna      := FCamposPadrao[intCnt].Coluna;
      aCampo.Obrigatorio := FCamposPadrao[intCnt].Obrigatorio;
      aCampo.TipoCampo   := FCamposPadrao[intCnt].TipoCampo;
      aCampo.Tamanho     := FCamposPadrao[intCnt].Tamanho;
      aCampo.blnTabela   := FCamposPadrao[intCnt].blnTabela;
      aCampo.blnCmpLig   := FCamposPadrao[intCnt].blnCmpLig;
      aCampo.blnPreAut   := FCamposPadrao[intCnt].blnPreAut;
      aCampo.Posicao     := intCnt;
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function TModeloArquivoImportacao.GetAutoIncrem: String;
begin
  Result := FAutInc;
end;

function TModeloArquivoImportacao.GetBlnEdt: Boolean;
begin
  Result := FblnEditavel;
end;

function TModeloArquivoImportacao.GetCampos: TList<ICamposModeloArquivo>;
begin
  Result := FListaCampos;
end;

function TModeloArquivoImportacao.GetCamposPadrao: TList<TCampoPlanilha>;
begin
  Result := FCamposPadrao;
end;

function TModeloArquivoImportacao.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TModeloArquivoImportacao.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TModeloArquivoImportacao.GetTipoImportacaoArquivo: TTipoImportacaoArquivo;
begin
  Result := FTipo;
end;

function TModeloArquivoImportacao.ModeloArquivoImportacao: IModeloArquivoImportacao;
begin
  Result := Self;
end;

procedure TModeloArquivoImportacao.pDefineCamposPadrao;
begin
  { Implementar na classe derivada }
end;

procedure TModeloArquivoImportacao.pLimparCampos;
begin
  FListaCampos.Clear;
  FAutInc := EmptyStr;
  FCodigo := EmptyStr;
  FDescricao := EmptyStr;
end;

procedure TModeloArquivoImportacao.SetAutoIncrem(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TModeloArquivoImportacao.SetBlnEdt(const AValue: Boolean);
begin
  FblnEditavel := AValue;
end;

procedure TModeloArquivoImportacao.SetCampos(
  const aValue: TList<ICamposModeloArquivo>);
begin
  FListaCampos := aValue;
end;

procedure TModeloArquivoImportacao.SetCamposPadrao(
  const AValue: TList<TCampoPlanilha>);
begin
  FCamposPadrao := AValue;
end;

procedure TModeloArquivoImportacao.SetCodigo(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TModeloArquivoImportacao.SetDescricao(const AValue: String);
begin
  FDescricao := AValue;
end;

procedure TModeloArquivoImportacao.SetTipoImportacaoArquivo(
  const AValue: TTipoImportacaoArquivo);
begin
  FTipo := AValue;
end;

function TModeloArquivoImportacao.GetEstadoTela: TTipoEstadoTela;
begin
  Result := FEstadoTela;
end;

function TModeloArquivoImportacao.GetListaModeloTabelas: TList<IModeloArquivoImportacao>;
begin
  Result := FListaModeloTabelas;
end;

function TModeloArquivoImportacao.GetNomTab: String;
begin
  Result := FNomTabela;
end;

procedure TModeloArquivoImportacao.SetEstadoTela( const AValue: TTipoEstadoTela);
begin
  FEstadoTela := AValue;
end;


procedure TModeloArquivoImportacao.SetNomTab(const AValue: String);
begin
  FNomTabela := aValue;
end;

{ TCamposModeloArquivo }

function TCamposModeloArquivo.Campos: ICamposModeloArquivo;
begin
  Result := Self;
end;

constructor TCamposModeloArquivo.Create(
  aModeloArquivo: IModeloArquivoImportacao);
begin
  FModeloArquivo := TModeloArquivoImportacao.Create;
  FModeloArquivo := aModeloArquivo;

  FSQLInsert := 'INSERT INTO CMPARQ(AUTOINCREM, CMP_SEQARQ, CMP_CODCAM, CMP_DESCAM, ' +
                                   'CMP_POSCAM, CMP_OBRCAM, CMP_NOMCAM, CMP_TIPCAM, ' +
                                   'CMP_TAMCAM, CMP_COLCAM, CMP_TABCAM, CMP_CMPLIG, ' +
                                   'CMP_PREAUT) '+
                'VALUES(:AUTOINCREM, :CMP_SEQARQ, :CMP_CODCAM, :CMP_DESCAM, ' +
                       ':CMP_POSCAM, :CMP_OBRCAM, :CMP_NOMCAM, :CMP_TIPCAM, ' +
                       ':CMP_TAMCAM, :CMP_COLCAM, :CMP_TABCAM, :CMP_CMPLIG, ' +
                       ':CMP_PREAUT)';

  FSQLUpdate := 'UPDATE CMPARQ SET CMP_POSCAM = :CMP_POSCAM, CMP_COLCAM = :CMP_COLCAM  ' +
                'WHERE AUTOINCREM = :AUTOINCREM ';

  FSQLDelete := 'DELETE FROM CMPARQ ' +
                'WHERE AUTOINCREM = :AUTOINCREM';

  FQry := fCriaQuery(nil);
  FQry.DisableControls;

  FBlnTabela := False;
  FblnCmpLig := False;
  FBlnPreAut := False;
end;

destructor TCamposModeloArquivo.Destroy;
begin
  FreeAndNil(FQry);
  inherited;
end;

function TCamposModeloArquivo.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TCamposModeloArquivo.GetCmpLig: Boolean;
begin
  Result := FblnCmpLig;
end;

function TCamposModeloArquivo.GetBlnAut: Boolean;
begin
  Result := FBlnPreAut;
end;

function TCamposModeloArquivo.GetBlnPuro: Boolean;
begin
  Result := FBlnExibirTextoPuro;
end;

function TCamposModeloArquivo.GetBlnTab: Boolean;
begin
  Result := FBlnTabela;
end;

function TCamposModeloArquivo.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TCamposModeloArquivo.GetCodModelo: String;
begin
  Result := FCodModelo;
end;

function TCamposModeloArquivo.GetColuna: String;
begin
  Result := FColuna;
end;

function TCamposModeloArquivo.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TCamposModeloArquivo.GetFieldType: TFieldType;
begin
  Result := FFieldType;
end;

function TCamposModeloArquivo.GetNomeCampo: String;
begin
  Result := FNomeCampo;
end;

function TCamposModeloArquivo.GetObrigatorio: String;
begin
  Result := FObrigatorio;
end;

function TCamposModeloArquivo.GetPosicao: Integer;
begin
  Result := FPosicaoCampo;
end;

function TCamposModeloArquivo.GetTamanho: Integer;
begin
  Result := FTamanhoCampo;
end;

function TCamposModeloArquivo.fInserir: ICamposModeloArquivo;
begin
  FAutInc := fRetAutoIncrem('CMPARQ', VS_strCodEmp);
  FCodigo := fAtualizaProCod('CMPARQ', 'CMP_CODCAM');
  FPosicaoCampo := fRetPosColuna(FColuna);

  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add(FSQLInsert);
  FQry.ParamByName('AUTOINCREM').AsString := FAutInc;
  FQry.ParamByName('CMP_SEQARQ').AsString := FModeloArquivo.AutoIncrem;
  FQry.ParamByName('CMP_CODCAM').AsString := FCodigo;
  FQry.ParamByName('CMP_DESCAM').AsString := FDescricao;
  FQry.ParamByName('CMP_POSCAM').AsInteger := FPosicaoCampo;
  FQry.ParamByName('CMP_OBRCAM').AsString := FObrigatorio;
  FQry.ParamByName('CMP_NOMCAM').AsString := FNomeCampo;
  FQry.ParamByName('CMP_TIPCAM').AsString := FieldTypeToStr(FFieldType);
  FQry.ParamByName('CMP_TAMCAM').AsInteger := FTamanhoCampo;
  FQry.ParamByName('CMP_COLCAM').AsString := FColuna;
  FQry.ParamByName('CMP_TABCAM').AsString := IIF(FBlnTabela, 'S', 'N');
  FQry.ParamByName('CMP_CMPLIG').AsString := IIF(FblnCmpLig, 'S', 'N');
  FQry.ParamByName('CMP_PREAUT').AsString := IIF(FBlnPreAut, 'S', 'N');

  FQry.ExecSQL;

  Result := Self;
end;

class function TCamposModeloArquivo.New(
  const aModeloArquivo: IModeloArquivoImportacao): ICamposModeloArquivo;
begin
  Result := Self.Create(aModeloArquivo);
end;

function TCamposModeloArquivo.fAlterar: ICamposModeloArquivo;
begin
  FPosicaoCampo := fRetPosColuna(FColuna);
  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add(FSQLUpdate);
  FQry.ParamByName('AUTOINCREM').AsString := FAutInc;
  FQry.ParamByName('CMP_POSCAM').AsInteger := FPosicaoCampo;
  FQry.ParamByName('CMP_COLCAM').AsString := FColuna;
  FQry.ExecSQL;

  Result := Self;
end;

function TCamposModeloArquivo.fExcluir: ICamposModeloArquivo;
begin
  FQry.Close;
  FQry.SQL.Clear;
  FQry.SQL.Add(FSQLDelete);
  FQry.ParamByName('AUTOINCREM').AsString := FAutInc;
  FQry.ExecSQL;
end;

function TCamposModeloArquivo.fRetPosColuna(const aColuna: String): Integer;
var
  intCnt: Integer;
begin
  Result := 0;
  For intCnt := 0 To Self.FModeloArquivo.Campos.Count -1 Do
  Begin
    If Self.FModeloArquivo.Campos[intCnt].Coluna = aColuna Then
    Begin
      Result := Self.FModeloArquivo.Campos[intCnt].Posicao;
      Break;
    End;
  End;
end;

function TCamposModeloArquivo.ModeloArquivo: IModeloArquivoImportacao;
begin
  Result := FModeloArquivo;
end;

procedure TCamposModeloArquivo.SetAutInc(const aValue: String);
begin
  FAutInc := aValue;
end;

procedure TCamposModeloArquivo.SetCmpLig(const aValue: Boolean);
begin
  FblnCmpLig := aValue;
end;

procedure TCamposModeloArquivo.SetBlnAut(const aValue: Boolean);
begin
  FBlnPreAut := aValue;
end;

procedure TCamposModeloArquivo.SetBlnPuro(const aValue: Boolean);
begin
  FBlnExibirTextoPuro := aValue;
end;

procedure TCamposModeloArquivo.SetBlnTab(const aValue: Boolean);
begin
  FBlnTabela := aValue;
end;

procedure TCamposModeloArquivo.SetCodigo(const aValue: String);
begin
  FCodigo := aValue;
end;

procedure TCamposModeloArquivo.SetCodModelo(const aValue: String);
begin
  FCodModelo := aValue;
end;

procedure TCamposModeloArquivo.SetColuna(const aValue: String);
begin
  FColuna := aValue;
end;

procedure TCamposModeloArquivo.SetDescricao(const aValue: String);
begin
  FDescricao := aValue;
end;

procedure TCamposModeloArquivo.SetFieldType(const aValue: TFieldType);
begin
  FFieldType := aValue;
end;

procedure TCamposModeloArquivo.SetNomeCampo(const aValue: String);
begin
  FNomeCampo := aValue;
end;

procedure TCamposModeloArquivo.SetObrigatorio(const aValue: String);
begin
  FObrigatorio := aValue;
end;

procedure TCamposModeloArquivo.SetPosicao(const aValue: Integer);
begin
  FPosicaoCampo := aValue;
end;

procedure TCamposModeloArquivo.SetTamanho(const aValue: Integer);
begin
  FTamanhoCampo := aValue;
end;

end.
