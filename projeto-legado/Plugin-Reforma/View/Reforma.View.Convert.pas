unit Reforma.View.Convert;

// Tela do Convert (REFTRI-02, RF04 a RF07 e RF12): "Ativar Precos Reforma Tributaria". A DLL nao tem o TfrmPai do exe:
// o layout imita o TfrmPaiConfirma (Confirma e Cancela no rodape). Os eventos so delegam para TProcessoConversao.
//
// Conversao por grupo de preco (usuario, 2026-10-06): uma linha por grupo (Reforma.Convert.Grupos), com as empresas do
// grupo no nivel de detalhe. O usuario marca os grupos na primeira coluna; cada um e convertido logado na empresa do
// grupo (troca interna do host, sem senha) e, no fim, a empresa original volta. Grupo que falha nao para os outros: o
// resultado de cada um sai numa lista.

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, UniClientDataSet, BitBtnLockedIncrem,
  Reforma.Contrato.Convert, Reforma.Convert.Processo;

type
  TfrmReformaConvert = class(TForm)
    pnlTopo: TPanel;
    lblAviso: TLabel;
    lblSituacao: TLabel;
    pnlOpcoes: TPanel;
    rdgOrigemImpostos: TRadioGroup;
    rdgSomenteAtivos: TRadioGroup;
    splEmpresas: TSplitter;
    cxgDivergencias: TcxGrid;
    tbvDivergencias: TcxGridDBTableView;
    colDivEmpresa: TcxGridDBColumn;
    colDivTipo: TcxGridDBColumn;
    colDivItem: TcxGridDBColumn;
    colDivCampo: TcxGridDBColumn;
    colDivEsperado: TcxGridDBColumn;
    colDivEncontrado: TcxGridDBColumn;
    lvlDivergencias: TcxGridLevel;
    pnlBotoes: TPanel;
    FlwBotoes: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnConferir: TBitBtnLocked;
    btnReverter: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    dtsEmpresas: TDataSource;
    dtsEmpresasGrupo: TDataSource;
    dtsDivergencias: TDataSource;
    rdgOpcao: TRadioGroup;
    pnlGrupos: TPanel;
    cxgEmpresas: TcxGrid;
    tbvEmpresas: TcxGridDBTableView;
    colEmpSelecao: TcxGridDBColumn;
    colEmpCodigo: TcxGridDBColumn;
    colEmpPreco: TcxGridDBColumn;
    colEmpNome: TcxGridDBColumn;
    colEmpConvertida: TcxGridDBColumn;
    colEmpSituacao: TcxGridDBColumn;
    colEmpInicio: TcxGridDBColumn;
    colEmpFim: TcxGridDBColumn;
    colEmpOperador: TcxGridDBColumn;
    colEmpOpcao: TcxGridDBColumn;
    colEmpItens: TcxGridDBColumn;
    colEmpAplicados: TcxGridDBColumn;
    colEmpDivergencias: TcxGridDBColumn;
    colEmpObservacao: TcxGridDBColumn;
    colEmpOrdem: TcxGridDBColumn;
    colEmpPode: TcxGridDBColumn;
    tbvEmpresasGrupo: TcxGridDBTableView;
    colGruCodigo: TcxGridDBColumn;
    colGruNome: TcxGridDBColumn;
    colGruOrigem: TcxGridDBColumn;
    colGruConvertida: TcxGridDBColumn;
    colGruSituacao: TcxGridDBColumn;
    lvlEmpresas: TcxGridLevel;
    lvlEmpresasGrupo: TcxGridLevel;
    pnlMarcar: TPanel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnConferirClick(Sender: TObject);
    procedure btnReverterClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
  strict private
    FHost: IReformaConvertHost;
    // Empresa em que o usuario entrou: volta para ela ao fim de cada execucao.
    FEmpresaOriginal: string;
    FGrupos: TUniClientDataSet;
    FEmpresas: TUniClientDataSet;
    FDivergencias: TUniClientDataSet;
    FCarregando: Boolean;
    // Filtro de itens: so existe para o operador 998 (pCriarFiltroItens).
    FFiltroItens: TMemo;
    procedure pCriarDados;
    procedure pCriarFiltroItens;
    procedure pMostrarParametrosPadrao;
    procedure pCarregar;
    procedure pCarregarGrupos(const TemRefcon, TemRefconEmpresa: Boolean);
    procedure pCarregarDivergencias;
    procedure pAtualizarBotoes;
    procedure pGrupoMudou(DataSet: TDataSet);
    procedure pDesenharGrupo(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pDesenharEmpresa(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pClicarGrupo(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure pMarcarGrupo;
    procedure pMarcarTodos(const Marcar: Boolean);
    function fGruposMarcados: TArray<string>;
    function fEmpresasPrecoDoGrupo(const Empresa: string): string;
    function fParametrosEscolhidos: TParametrosConversao;
    procedure pMostrarParametros(const Parametros: TParametrosConversao; const Habilitar: Boolean);
    function fTextoConfirmacao(const Grupos: TArray<string>): string;
    procedure pMostrarResultado(const Mensagem: string; const Linhas: TArray<string>);
    function fEntrarNaEmpresa(const Empresa: string; out Mensagem: string): Boolean;
    procedure pVoltarEmpresaOriginal;
    procedure pFocarGrade;
    procedure WMFocarGrade(var Mensagem: TMessage); message WM_USER + 702;
  protected
    procedure DoShow; override;
  public
    class function Criar(const Host: IReformaConvertHost): TfrmReformaConvert; static;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.Variants,
  System.Math,
  System.Generics.Collections,
  Vcl.Graphics,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Host,
  Reforma.View.Estilo,
  Reforma.Convert.Estrutura,
  Reforma.Convert.Grupos;

const
  // Linha do grupo da logada (BGR).
  COR_LOGADA = $00F0D2A8;
  // Mesma linha quando selecionada (o realce padrao esconderia a cor).
  COR_LOGADA_SELECIONADA = $00E0B070;
  // Grupo que nao pode ser convertido (a coluna Observacao diz por que).
  COR_BLOQUEADO = clRed;
  // Grupo ja convertido: fundo verde claro com fonte preta (usuario, 2026-10-07), e o mesmo mais escuro quando selecionado.
  COR_GRUPO_CONVERTIDO = $00D0F0D0;
  COR_GRUPO_CONVERTIDO_SELECIONADO = $00A0DCA0;
  // Bolinha da coluna Convertida: verde se a empresa ja foi convertida (EMP_REFCON ou a ultima conversao concluida),
  // vermelha se nao (inclusive a ativa sem conversao, com CFG_REFCIS ligada por fora do Convert).
  COR_CONVERTIDA = $0050B000;
  COR_NAO_CONVERTIDA = $003030E0;
  TAMANHO_BOLINHA = 10;

  NOME_SITUACAO: array[TFaseConversao] of string = ('Não convertida', 'Preparando', 'Aplicando', 'Convertida',
    'Divergente');

type
  // Uma empresa do CADEMP com a situacao dela: a ultima conversao em que entrou (qualquer origem) e a ultima que ela
  // mesma fez como logada (a do grupo).
  TInfoEmpresa = record
    Nome: string;
    Refcis: string;
    Refcon: string;
    Fase: string;
    FaseLogada: string;
    Revertida: Boolean;
    Opcao: string;
    Operador: string;
    Inicio: string;
    Fim: string;
    Itens: Integer;
    Aplicados: Integer;
    Divergencias: Integer;
    Chave: string;
  end;

function fTextoOpcao(const Codigo: string): string;
begin
  if Codigo = 'M' then
    Result := 'Margem'
  else if Codigo = 'P' then
    Result := 'Preço de Venda'
  else
    Result := '';
end;

function fTextoFase(const Codigo, Refcis: string): string;
begin
  if Codigo = 'R' then
    Result := 'Revertida'
  else if Codigo = 'P' then
    Result := NOME_SITUACAO[fcPreparando]
  else if Codigo = 'A' then
    Result := NOME_SITUACAO[fcAplicando]
  else if Codigo = 'C' then
    Result := NOME_SITUACAO[fcConcluida]
  else if Codigo = 'D' then
    Result := NOME_SITUACAO[fcDivergente]
  else if UpperCase(Refcis) = 'S' then
    Result := 'Ativa sem conversão'
  else
    Result := NOME_SITUACAO[fcNova];
end;

function fDataHoraTexto(const Data, Hora: Variant): string;
begin
  Result := '';
  if VarIsNull(Data) or VarIsEmpty(Data) then
    Exit;
  Result := FormatDateTime('dd/mm/yyyy', VarToDateTime(Data));
  if not (VarIsNull(Hora) or VarIsEmpty(Hora)) then
    Result := Result + ' ' + Copy(VarToStr(Hora), 1, 8);
end;

function fTemColuna(const Host: IReformaConvertHost; const Tabela, Coluna: string): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Consulta := Host.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :TABELA AND COLUMN_NAME = :COLUNA');
  Consulta.DefinirParametro('TABELA', Tabela);
  Consulta.DefinirParametro('COLUNA', Coluna);
  Consulta.Abrir;
  Result := fNumeroConvert(Consulta.ValorCampo('QTD')) > 0;
end;

// Mensagem de varias linhas numa linha so (a lista de resultado tem uma linha por grupo).
function fUmaLinha(const Texto: string): string;
begin
  Result := Trim(ReplaceStr(ReplaceStr(Texto, sLineBreak + sLineBreak, ' '), sLineBreak, ' '));
end;

{ TfrmReformaConvert }

class function TfrmReformaConvert.Criar(const Host: IReformaConvertHost): TfrmReformaConvert;
begin
  Result := TfrmReformaConvert.Create(nil);
  try
    Result.FHost := Host;
    Result.FEmpresaOriginal := Host.CodigoEmpresa;
    Result.pCriarDados;
    Result.pCriarFiltroItens;
    pAjustarTema(Result);
    Result.pMostrarParametrosPadrao;
    Result.pCarregar;
  except
    Result.Free;
    raise;
  end;
end;

destructor TfrmReformaConvert.Destroy;
begin
  dtsEmpresas.DataSet := nil;
  dtsEmpresasGrupo.DataSet := nil;
  dtsDivergencias.DataSet := nil;
  FreeAndNil(FDivergencias);
  FreeAndNil(FEmpresas);
  FreeAndNil(FGrupos);
  inherited Destroy;
end;

// Operador 998 (usuario, 2026-10-06): converter so os itens informados, para validar com poucos itens. Fica ao lado dos
// radios; vazio converte todos.
procedure TfrmReformaConvert.pCriarFiltroItens;
var
  Grupo: TGroupBox;
begin
  if Trim(FHost.Operador) <> '998' then
    Exit;

  Grupo := TGroupBox.Create(Self);
  Grupo.Parent := pnlOpcoes;
  Grupo.AlignWithMargins := True;
  Grupo.Margins.Left := 6;
  Grupo.Margins.Right := 6;
  Grupo.Align := alClient;
  Grupo.Caption := ' Somente os itens (998), ex.: 90401, 90402 ';

  FFiltroItens := TMemo.Create(Self);
  FFiltroItens.Parent := Grupo;
  FFiltroItens.AlignWithMargins := True;
  FFiltroItens.Align := alClient;
  FFiltroItens.ScrollBars := ssVertical;
  FFiltroItens.WantReturns := True;
end;

// A API do Windows com outro nome: o metodo SetFocus do form ganharia da funcao, e a chamada qualificada cairia na trava
// do pre-commit (mesmo motivo de Reforma.View.FuturaGrid).
function fFocarJanela(const AJanela: HWND): HWND; stdcall; external 'user32.dll' name 'SetFocus';

// Foco na grade dos grupos, na linha corrente (a do grupo da logada, posicionada em pCarregar), com a linha
// selecionada e visivel (usuario, 2026-10-06). O ActiveControl do DFM nao bastava: a tela modal da DLL abre sobre a
// janela do autcom e o foco ficava fora da grade.
procedure TfrmReformaConvert.pFocarGrade;
begin
  if FGrupos.IsEmpty or not cxgEmpresas.CanFocus then
    Exit;
  fFocarJanela(cxgEmpresas.Handle);
  tbvEmpresas.Focused := True;
  if Assigned(tbvEmpresas.Controller.FocusedRecord) then
  begin
    tbvEmpresas.Controller.FocusedRecord.Selected := True;
    tbvEmpresas.Controller.MakeFocusedRecordVisible;
  end;
end;

// Depois de a janela aparecer e ser ativada: so entao o foco fica.
procedure TfrmReformaConvert.DoShow;
begin
  inherited DoShow;
  PostMessage(Handle, WM_USER + 702, 0, 0);
end;

procedure TfrmReformaConvert.WMFocarGrade(var Mensagem: TMessage);
begin
  pFocarGrade;
end;

// Os dados da tela so existem em memoria (mesmo padrao de TSimulacaoReforma.pCriarCampos).
procedure TfrmReformaConvert.pCriarDados;
begin
  FGrupos := TUniClientDataSet.Create(nil);
  FGrupos.FieldDefs.Add('SEL', ftBoolean);
  FGrupos.FieldDefs.Add('EMP_CODEMP', ftString, 10);
  FGrupos.FieldDefs.Add('EMPRESAS_PRECO', ftString, 250);
  FGrupos.FieldDefs.Add('EMP_NOMEMP', ftString, 80);
  FGrupos.FieldDefs.Add('SITUACAO', ftString, 40);
  FGrupos.FieldDefs.Add('INICIO', ftString, 20);
  FGrupos.FieldDefs.Add('FIM', ftString, 20);
  FGrupos.FieldDefs.Add('OPERADOR', ftString, 20);
  FGrupos.FieldDefs.Add('OPCAO', ftString, 20);
  FGrupos.FieldDefs.Add('ITENS', ftInteger);
  FGrupos.FieldDefs.Add('APLICADOS', ftInteger);
  FGrupos.FieldDefs.Add('DIVERGENCIAS', ftInteger);
  FGrupos.FieldDefs.Add('CHAVE', ftString, 38);
  // Fase da ultima conversao do grupo (REFCON da empresa do grupo como logada).
  FGrupos.FieldDefs.Add('FASE', ftString, 1);
  // 0 o grupo da logada, 1 os demais: a ordem do grid.
  FGrupos.FieldDefs.Add('ORDEM', ftInteger);
  // 'S' se a empresa do grupo ja foi convertida.
  FGrupos.FieldDefs.Add('CONVERTIDA', ftString, 1);
  // Pode ser marcado; senao OBSERVACAO diz por que.
  FGrupos.FieldDefs.Add('PODE', ftBoolean);
  FGrupos.FieldDefs.Add('OBSERVACAO', ftString, 250);
  FGrupos.CreateDataSet;
  FGrupos.IndexFieldNames := 'ORDEM;EMP_CODEMP';
  FGrupos.AfterScroll := pGrupoMudou;
  dtsEmpresas.DataSet := FGrupos;

  FEmpresas := TUniClientDataSet.Create(nil);
  FEmpresas.FieldDefs.Add('GRUPO', ftString, 10);
  FEmpresas.FieldDefs.Add('EMP_CODEMP', ftString, 10);
  FEmpresas.FieldDefs.Add('EMP_NOMEMP', ftString, 80);
  FEmpresas.FieldDefs.Add('ORIGEM', ftString, 20);
  FEmpresas.FieldDefs.Add('CONVERTIDA', ftString, 1);
  FEmpresas.FieldDefs.Add('SITUACAO', ftString, 40);
  FEmpresas.CreateDataSet;
  FEmpresas.IndexFieldNames := 'GRUPO;EMP_CODEMP';
  dtsEmpresasGrupo.DataSet := FEmpresas;

  FDivergencias := TUniClientDataSet.Create(nil);
  FDivergencias.FieldDefs.Add('DIV_CODEMP', ftString, 10);
  FDivergencias.FieldDefs.Add('DIV_TIPO', ftString, 10);
  FDivergencias.FieldDefs.Add('DIV_CODITE', ftString, 20);
  FDivergencias.FieldDefs.Add('DIV_CAMPO', ftString, 20);
  FDivergencias.FieldDefs.Add('DIV_ESPERA', ftString, 40);
  FDivergencias.FieldDefs.Add('DIV_ENCONT', ftString, 40);
  FDivergencias.CreateDataSet;
  dtsDivergencias.DataSet := FDivergencias;

  tbvEmpresas.DataController.DataSource := dtsEmpresas;
  tbvEmpresasGrupo.DataController.DataSource := dtsEmpresasGrupo;
  tbvDivergencias.DataController.DataSource := dtsDivergencias;
  tbvEmpresas.OnCustomDrawCell := pDesenharGrupo;
  tbvEmpresasGrupo.OnCustomDrawCell := pDesenharEmpresa;
  tbvEmpresas.OnCellClick := pClicarGrupo;
end;

procedure pDesenharBolinha(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  Bolinha: TRect;
  Cor: TColor;
begin
  ACanvas.FillRect(AViewInfo.Bounds);
  Bolinha.Left := (AViewInfo.Bounds.Left + AViewInfo.Bounds.Right - TAMANHO_BOLINHA) div 2;
  Bolinha.Top := (AViewInfo.Bounds.Top + AViewInfo.Bounds.Bottom - TAMANHO_BOLINHA) div 2;
  Bolinha.Right := Bolinha.Left + TAMANHO_BOLINHA;
  Bolinha.Bottom := Bolinha.Top + TAMANHO_BOLINHA;
  if VarToStr(AViewInfo.Value) = 'S' then
    Cor := COR_CONVERTIDA
  else
    Cor := COR_NAO_CONVERTIDA;
  ACanvas.Canvas.Brush.Color := Cor;
  ACanvas.Canvas.Pen.Color := Cor;
  ACanvas.Canvas.Ellipse(Bolinha);
  ADone := True;
end;

// Cor da linha do grupo da logada, fonte vermelha no grupo bloqueado, verde claro no ja convertido e a bolinha da coluna
// Convertida.
procedure TfrmReformaConvert.pDesenharGrupo(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  Ordem: Variant;
  Pode: Variant;
  Convertida: Variant;
begin
  Ordem := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colEmpOrdem.Index];
  Pode := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colEmpPode.Index];
  if (not VarIsNull(Ordem)) and (Ordem = 0) then
  begin
    if AViewInfo.Selected then
      ACanvas.Brush.Color := COR_LOGADA_SELECIONADA
    else
      ACanvas.Brush.Color := COR_LOGADA;
    ACanvas.Font.Color := clBlack;
    if AViewInfo.Selected then
      ACanvas.Font.Style := [fsBold];
  end;
  if VarIsNull(Pode) or not Boolean(Pode) then
    ACanvas.Font.Color := COR_BLOQUEADO;
  Convertida := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colEmpConvertida.Index];
  if VarToStr(Convertida) = 'S' then
  begin
    if AViewInfo.Selected then
      ACanvas.Brush.Color := COR_GRUPO_CONVERTIDO_SELECIONADO
    else
      ACanvas.Brush.Color := COR_GRUPO_CONVERTIDO;
    ACanvas.Font.Color := clBlack;
  end;

  if AViewInfo.Item = colEmpConvertida then
    pDesenharBolinha(ACanvas, AViewInfo, ADone);
end;

// O detalhe e desenhado por uma copia da view (uma por grupo expandido): a coluna e comparada pela posicao, nao pela
// instancia.
procedure TfrmReformaConvert.pDesenharEmpresa(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Item.Index = colGruConvertida.Index then
    pDesenharBolinha(ACanvas, AViewInfo, ADone);
end;

// Clique na primeira coluna marca ou desmarca o grupo (o grid e so leitura).
procedure TfrmReformaConvert.pClicarGrupo(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (ACellViewInfo.Item = colEmpSelecao) then
  begin
    pMarcarGrupo;
    AHandled := True;
  end;
end;

procedure TfrmReformaConvert.pMarcarGrupo;
begin
  if FGrupos.IsEmpty then
    Exit;
  if not FGrupos.FieldByName('PODE').AsBoolean then
  begin
    FHost.Mensagem(TITULO_CONVERT, 'O grupo da empresa ' + FGrupos.FieldByName('EMP_CODEMP').AsString +
      ' não pode ser convertido: ' + FGrupos.FieldByName('OBSERVACAO').AsString);
    Exit;
  end;
  FGrupos.Edit;
  FGrupos.FieldByName('SEL').AsBoolean := not FGrupos.FieldByName('SEL').AsBoolean;
  FGrupos.Post;
end;

// Marca todos os grupos que podem ser convertidos, ou desmarca todos.
procedure TfrmReformaConvert.pMarcarTodos(const Marcar: Boolean);
var
  Atual: string;
begin
  if FGrupos.IsEmpty then
    Exit;
  Atual := FGrupos.FieldByName('EMP_CODEMP').AsString;
  FCarregando := True;
  FGrupos.DisableControls;
  try
    FGrupos.First;
    while not FGrupos.Eof do
    begin
      FGrupos.Edit;
      FGrupos.FieldByName('SEL').AsBoolean := Marcar and FGrupos.FieldByName('PODE').AsBoolean;
      FGrupos.Post;
      FGrupos.Next;
    end;
    FGrupos.Locate('EMP_CODEMP', Atual, []);
  finally
    FGrupos.EnableControls;
    FCarregando := False;
  end;
end;

procedure TfrmReformaConvert.btnMarcarTodosClick(Sender: TObject);
begin
  pMarcarTodos(True);
end;

procedure TfrmReformaConvert.btnDesmarcarTodosClick(Sender: TObject);
begin
  pMarcarTodos(False);
end;

// Grupos marcados, na ordem do grid: o da logada primeiro, depois por codigo.
function TfrmReformaConvert.fGruposMarcados: TArray<string>;
var
  Atual: string;
begin
  Result := nil;
  Atual := FGrupos.FieldByName('EMP_CODEMP').AsString;
  FCarregando := True;
  FGrupos.DisableControls;
  try
    FGrupos.First;
    while not FGrupos.Eof do
    begin
      if FGrupos.FieldByName('SEL').AsBoolean and FGrupos.FieldByName('PODE').AsBoolean then
        Result := Result + [FGrupos.FieldByName('EMP_CODEMP').AsString];
      FGrupos.Next;
    end;
    FGrupos.Locate('EMP_CODEMP', Atual, []);
  finally
    FGrupos.EnableControls;
    FCarregando := False;
  end;
end;

function TfrmReformaConvert.fEmpresasPrecoDoGrupo(const Empresa: string): string;
var
  Atual: string;
begin
  Result := Empresa;
  Atual := FGrupos.FieldByName('EMP_CODEMP').AsString;
  FCarregando := True;
  FGrupos.DisableControls;
  try
    if FGrupos.Locate('EMP_CODEMP', Empresa, []) then
      Result := FGrupos.FieldByName('EMPRESAS_PRECO').AsString;
    FGrupos.Locate('EMP_CODEMP', Atual, []);
  finally
    FGrupos.EnableControls;
    FCarregando := False;
  end;
end;

// Uma linha por grupo (Reforma.Convert.Grupos) e, no detalhe, as empresas do grupo. A situacao vem do CADEMP
// (EMP_REFCON), da CFG_REFCIS e da REFCON.
procedure TfrmReformaConvert.pCarregarGrupos(const TemRefcon, TemRefconEmpresa: Boolean);
var
  Consulta: IReformaConsulta;
  Sql: string;
  Infos: TDictionary<string, TInfoEmpresa>;
  Info: TInfoEmpresa;
  Grupos: TGruposPreco;
  Grupo: TGrupoPreco;
  NoServidor: TArray<string>;
  Empresa: string;
  Convertida: Boolean;
  Observacao: string;
begin
  Sql := 'SELECT E.EMP_CODEMP, E.EMP_NOMEMP, C.SIS_VALCFG AS REFCIS';
  if TemRefconEmpresa then
    Sql := Sql + ', E.EMP_REFCON';
  if TemRefcon then
    Sql := Sql + ', R.CON_FASE, L.CON_FASE AS FASE_LOGADA, L.CON_OPCAO, L.CON_CODOPE, L.CON_DTAINI, L.CON_HORINI, ' +
      'L.CON_DTAFIM, L.CON_HORFIM, L.CON_QTDITE, L.CON_QTDAPL, L.CON_QTDDIV, L.CON_CHAVE';
  Sql := Sql + ' FROM CADEMP E' +
    ' LEFT JOIN CFGSIS C ON C.SIS_CODEMP = E.EMP_CODEMP AND C.SIS_CODCFG = ''CFG_REFCIS''';
  if TemRefcon then
    Sql := Sql +
      ' LEFT JOIN REFCON R ON R.CON_ID = (SELECT MAX(X.CON_ID) FROM REFCON X WHERE X.CON_CODEMP = E.EMP_CODEMP)' +
      ' LEFT JOIN REFCON L ON L.CON_ID = (SELECT MAX(Y.CON_ID) FROM REFCON Y WHERE Y.CON_CODEMP = E.EMP_CODEMP' +
      '                                    AND Y.CON_ORIGEM = ''L'')';

  Infos := TDictionary<string, TInfoEmpresa>.Create;
  try
    Consulta := FHost.AbrirConsulta(Sql);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Info.Nome := fTextoConvert(Consulta.ValorCampo('EMP_NOMEMP'));
      Info.Refcis := fTextoConvert(Consulta.ValorCampo('REFCIS'));
      Info.Refcon := '';
      if TemRefconEmpresa then
        Info.Refcon := UpperCase(fTextoConvert(Consulta.ValorCampo('EMP_REFCON')));
      Info.Fase := '';
      Info.FaseLogada := '';
      Info.Revertida := False;
      Info.Opcao := '';
      Info.Operador := '';
      Info.Inicio := '';
      Info.Fim := '';
      Info.Itens := 0;
      Info.Aplicados := 0;
      Info.Divergencias := 0;
      Info.Chave := '';
      if TemRefcon then
      begin
        Info.Fase := fTextoConvert(Consulta.ValorCampo('CON_FASE'));
        Info.FaseLogada := fTextoConvert(Consulta.ValorCampo('FASE_LOGADA'));
        Info.Opcao := fTextoOpcao(fTextoConvert(Consulta.ValorCampo('CON_OPCAO')));
        Info.Operador := fTextoConvert(Consulta.ValorCampo('CON_CODOPE'));
        Info.Inicio := fDataHoraTexto(Consulta.ValorCampo('CON_DTAINI'), Consulta.ValorCampo('CON_HORINI'));
        Info.Fim := fDataHoraTexto(Consulta.ValorCampo('CON_DTAFIM'), Consulta.ValorCampo('CON_HORFIM'));
        Info.Itens := Round(fNumeroConvert(Consulta.ValorCampo('CON_QTDITE')));
        Info.Aplicados := Round(fNumeroConvert(Consulta.ValorCampo('CON_QTDAPL')));
        Info.Divergencias := Round(fNumeroConvert(Consulta.ValorCampo('CON_QTDDIV')));
        Info.Chave := fTextoConvert(Consulta.ValorCampo('CON_CHAVE'));
      end;
      // Revertida (botao Reverter): EMP_REFCON 'R' e a REFCON apagada; so a Situacao diz que foi revertida. Uma conversao
      // nova em andamento (REFCON da logada) manda.
      Info.Revertida := (Info.Refcon = 'R') and (Info.FaseLogada = '');
      Infos.AddOrSetValue(Trim(fTextoConvert(Consulta.ValorCampo('EMP_CODEMP'))), Info);
      Consulta.Proximo;
    end;
    Consulta := nil;

    Grupos := fMontarGruposPreco(FHost);
    NoServidor := fEmpresasNoServidor(FHost);
    for Grupo in Grupos do
    begin
      if not Infos.TryGetValue(Grupo.Empresa, Info) then
        Continue;

      Convertida := (Info.Refcon = 'S') or (Info.FaseLogada = 'C');
      // Ja convertido vem antes: nada mais a fazer no grupo, qualquer que seja a configuracao.
      Observacao := '';
      if Convertida then
        Observacao := 'Grupo já convertido.'
      else if Grupo.Bloqueio <> '' then
        Observacao := Grupo.Bloqueio
      else if not fNoServidor(NoServidor, Grupo.Empresa) then
        Observacao := 'A empresa não faz parte deste servidor.'
      else if (Info.FaseLogada = '') and (UpperCase(Info.Refcis) = 'S') then
        Observacao := 'Reforma já ativa nesta empresa, sem conversão.'
      else if Info.FaseLogada <> '' then
        Observacao := 'Conversão em andamento: marque para continuar.'
      else if Grupo.Compartilhadas <> '' then
        Observacao := 'Lojas também em outro grupo (' + Grupo.Compartilhadas + '): não pode converter.';

      FGrupos.Append;
      FGrupos.FieldByName('SEL').AsBoolean := False;
      FGrupos.FieldByName('EMP_CODEMP').AsString := Grupo.Empresa;
      FGrupos.FieldByName('EMPRESAS_PRECO').AsString := fTextoEmpresasPreco(Grupo);
      FGrupos.FieldByName('EMP_NOMEMP').AsString := Info.Nome;
      FGrupos.FieldByName('CONVERTIDA').AsString := IfThen(Convertida, 'S', 'N');
      if Convertida and (Info.FaseLogada <> 'C') then
        FGrupos.FieldByName('SITUACAO').AsString := NOME_SITUACAO[fcConcluida]
      else if Info.Revertida then
        FGrupos.FieldByName('SITUACAO').AsString := fTextoFase('R', Info.Refcis)
      else
        FGrupos.FieldByName('SITUACAO').AsString := fTextoFase(Info.FaseLogada, Info.Refcis);
      FGrupos.FieldByName('FASE').AsString := Info.FaseLogada;
      FGrupos.FieldByName('INICIO').AsString := Info.Inicio;
      FGrupos.FieldByName('FIM').AsString := Info.Fim;
      FGrupos.FieldByName('OPERADOR').AsString := Info.Operador;
      FGrupos.FieldByName('OPCAO').AsString := Info.Opcao;
      FGrupos.FieldByName('ITENS').AsInteger := Info.Itens;
      FGrupos.FieldByName('APLICADOS').AsInteger := Info.Aplicados;
      FGrupos.FieldByName('DIVERGENCIAS').AsInteger := Info.Divergencias;
      FGrupos.FieldByName('CHAVE').AsString := Info.Chave;
      FGrupos.FieldByName('ORDEM').AsInteger := IfThen(MatchText(FEmpresaOriginal, Grupo.Empresas), 0, 1);
      // Grupo que compartilha loja com outro aparece, mas nao converte (usuario, 2026-10-07).
      FGrupos.FieldByName('PODE').AsBoolean := (Grupo.Bloqueio = '') and (Grupo.Compartilhadas = '') and
        fNoServidor(NoServidor, Grupo.Empresa) and
        not Convertida and not ((Info.FaseLogada = '') and (UpperCase(Info.Refcis) = 'S'));
      FGrupos.FieldByName('OBSERVACAO').AsString := Observacao;
      FGrupos.Post;

      for Empresa in Grupo.Empresas do
      begin
        if not Infos.TryGetValue(Empresa, Info) then
          Continue;
        FEmpresas.Append;
        FEmpresas.FieldByName('GRUPO').AsString := Grupo.Empresa;
        FEmpresas.FieldByName('EMP_CODEMP').AsString := Empresa;
        FEmpresas.FieldByName('EMP_NOMEMP').AsString := Info.Nome;
        if Empresa = Grupo.Empresa then
          FEmpresas.FieldByName('ORIGEM').AsString := 'Matriz do grupo'
        else
          FEmpresas.FieldByName('ORIGEM').AsString := 'Preço da matriz';
        Convertida := (Info.Refcon = 'S') or (Info.Fase = 'C');
        FEmpresas.FieldByName('CONVERTIDA').AsString := IfThen(Convertida, 'S', 'N');
        if Convertida and (Info.Fase <> 'C') then
          FEmpresas.FieldByName('SITUACAO').AsString := NOME_SITUACAO[fcConcluida]
        else
          FEmpresas.FieldByName('SITUACAO').AsString := fTextoFase(Info.Fase, Info.Refcis);
        FEmpresas.Post;
      end;
    end;
  finally
    Infos.Free;
  end;
end;

// Padrao para as conversoes novas: preco ou margem pela CFG_VENMAR da logada, tabela estatica e so itens ativos. O
// grupo com conversao em andamento continua com as opcoes gravadas nele (RN16). So na abertura da tela: depois de
// Confirma, Conferir ou Reverter as opcoes ficam como o operador deixou (teste de 2026-10-15).
procedure TfrmReformaConvert.pMostrarParametrosPadrao;
var
  Parametros: TParametrosConversao;
begin
  if FHost.ConfiguracaoTexto('VENMAR') = '1' then
    Parametros.Opcao := ocvRecalcularPrecoVenda
  else
    Parametros.Opcao := ocvRecalcularMargem;
  Parametros.Origem := oicTabelaEstatica;
  Parametros.SomenteAtivos := True;
  Parametros.Itens := '';
  pMostrarParametros(Parametros, True);
end;

procedure TfrmReformaConvert.pCarregar;
var
  Consulta: IReformaConsulta;
  TemRefcon: Boolean;
  TemRefconEmpresa: Boolean;
  Pode: Boolean;
  Andamento: Integer;
  EmpresaSelecionada: string;
begin
  // Recarga com a tela aberta: a linha em que o operador estava (o grupo que ele acabou de converter, conferir ou
  // reverter) continua selecionada, e os botoes mostram a situacao nova dela.
  EmpresaSelecionada := '';
  if not FGrupos.IsEmpty then
    EmpresaSelecionada := FGrupos.FieldByName('EMP_CODEMP').AsString;

  Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.TABLES ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :TABELA');
  Consulta.DefinirParametro('TABELA', 'REFCON');
  Consulta.Abrir;
  TemRefcon := fNumeroConvert(Consulta.ValorCampo('QTD')) > 0;
  Consulta := nil;
  TemRefconEmpresa := fTemColuna(FHost, 'CADEMP', 'EMP_REFCON');

  FCarregando := True;
  FGrupos.DisableControls;
  FEmpresas.DisableControls;
  try
    FGrupos.EmptyDataSet;
    FEmpresas.EmptyDataSet;
    pCarregarGrupos(TemRefcon, TemRefconEmpresa);

    Pode := False;
    Andamento := 0;
    FGrupos.First;
    while not FGrupos.Eof do
    begin
      if FGrupos.FieldByName('PODE').AsBoolean then
      begin
        Pode := True;
        if FGrupos.FieldByName('FASE').AsString <> '' then
          Inc(Andamento);
      end;
      FGrupos.Next;
    end;
    // Abre na linha do grupo da empresa logada (ORDEM 0); sem ela na lista, na primeira.
    if (EmpresaSelecionada = '') or not FGrupos.Locate('EMP_CODEMP', EmpresaSelecionada, []) then
      if not FGrupos.Locate('ORDEM', 0, []) then
        FGrupos.First;
  finally
    FEmpresas.EnableControls;
    FGrupos.EnableControls;
    FCarregando := False;
  end;
  // Recarga com a tela aberta (depois de Confirma, Conferir ou Reverter): o foco volta para a grade.
  if Showing then
    pFocarGrade;

  btnConfirma.Enabled := Pode;
  if not Pode then
    lblSituacao.Caption := 'Nenhum grupo para converter.'
  else if Andamento > 0 then
    lblSituacao.Caption := 'Conversão em andamento em ' + IntToStr(Andamento) +
      ' grupo(s): marque e clique em Confirma para continuar (com as opções gravadas).'
  else
    lblSituacao.Caption := 'Marque na primeira coluna os grupos que vão ser convertidos.';
  pCarregarDivergencias;
  pAtualizarBotoes;
end;

// Divergencias da ultima conversao do grupo selecionado (todas as empresas da chave).
procedure TfrmReformaConvert.pCarregarDivergencias;
var
  Consulta: IReformaConsulta;
  Chave: string;
begin
  FDivergencias.DisableControls;
  try
    FDivergencias.EmptyDataSet;
    if FGrupos.IsEmpty then
      Exit;
    Chave := FGrupos.FieldByName('CHAVE').AsString;
    if Chave = '' then
      Exit;

    Consulta := FHost.AbrirConsulta('SELECT DIV_CODEMP, DIV_TIPO, DIV_CODITE, DIV_CAMPO, DIV_ESPERA, DIV_ENCONT ' +
      'FROM REFDIV WHERE DIV_CHAVE = :CHAVE ORDER BY DIV_CODEMP, DIV_TIPO, DIV_CODITE LIMIT 1000');
    Consulta.DefinirParametro('CHAVE', Chave);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      FDivergencias.Append;
      FDivergencias.FieldByName('DIV_CODEMP').AsString := fTextoConvert(Consulta.ValorCampo('DIV_CODEMP'));
      FDivergencias.FieldByName('DIV_TIPO').AsString := fTextoConvert(Consulta.ValorCampo('DIV_TIPO'));
      FDivergencias.FieldByName('DIV_CODITE').AsString := fTextoConvert(Consulta.ValorCampo('DIV_CODITE'));
      FDivergencias.FieldByName('DIV_CAMPO').AsString := fTextoConvert(Consulta.ValorCampo('DIV_CAMPO'));
      FDivergencias.FieldByName('DIV_ESPERA').AsString := fTextoConvert(Consulta.ValorCampo('DIV_ESPERA'));
      FDivergencias.FieldByName('DIV_ENCONT').AsString := fTextoConvert(Consulta.ValorCampo('DIV_ENCONT'));
      FDivergencias.Post;
      Consulta.Proximo;
    end;
    FDivergencias.First;
  finally
    FDivergencias.EnableControls;
  end;
end;

// Conferir: o grupo selecionado com a ultima conversao concluida ou divergente.
procedure TfrmReformaConvert.pAtualizarBotoes;
begin
  btnConferir.Enabled := (not FGrupos.IsEmpty) and (FGrupos.FieldByName('CHAVE').AsString <> '') and
    MatchText(FGrupos.FieldByName('FASE').AsString, ['C', 'D']) and
    (FGrupos.FieldByName('OBSERVACAO').AsString <> 'A empresa não faz parte deste servidor.');
  // Reverter: o grupo com conversao aplicada (em andamento, concluida ou divergente).
  btnReverter.Enabled := (not FGrupos.IsEmpty) and (FGrupos.FieldByName('CHAVE').AsString <> '') and
    MatchText(FGrupos.FieldByName('FASE').AsString, ['A', 'C', 'D']) and
    (FGrupos.FieldByName('OBSERVACAO').AsString <> 'A empresa não faz parte deste servidor.');
end;

procedure TfrmReformaConvert.pGrupoMudou(DataSet: TDataSet);
begin
  if FCarregando then
    Exit;
  pCarregarDivergencias;
  pAtualizarBotoes;
end;

procedure TfrmReformaConvert.pMostrarParametros(const Parametros: TParametrosConversao; const Habilitar: Boolean);
begin
  rdgOpcao.ItemIndex := Ord(Parametros.Opcao);
  rdgOrigemImpostos.ItemIndex := Ord(Parametros.Origem);
  if Parametros.SomenteAtivos then
    rdgSomenteAtivos.ItemIndex := 0
  else
    rdgSomenteAtivos.ItemIndex := 1;
  rdgOpcao.Enabled := Habilitar;
  rdgOrigemImpostos.Enabled := Habilitar;
  rdgSomenteAtivos.Enabled := Habilitar;
  if Assigned(FFiltroItens) then
  begin
    if Parametros.Itens <> '' then
      FFiltroItens.Text := StringReplace(Parametros.Itens, ';', ', ', [rfReplaceAll]);
    FFiltroItens.Enabled := Habilitar;
  end;
end;

function TfrmReformaConvert.fParametrosEscolhidos: TParametrosConversao;
begin
  if rdgOpcao.ItemIndex = 1 then
    Result.Opcao := ocvRecalcularMargem
  else
    Result.Opcao := ocvRecalcularPrecoVenda;
  if rdgOrigemImpostos.ItemIndex = 1 then
    Result.Origem := oicAbreviacaoItem
  else
    Result.Origem := oicTabelaEstatica;
  Result.SomenteAtivos := rdgSomenteAtivos.ItemIndex <> 1;
  Result.Itens := '';
  if Assigned(FFiltroItens) then
    Result.Itens := fNormalizarItensConvert(FFiltroItens.Text);
end;

function TfrmReformaConvert.fTextoConfirmacao(const Grupos: TArray<string>): string;
var
  Itens: string;
begin
  // So a pergunta (usuario, 2026-10-06): os grupos e as opcoes estao na tela.
  Result := 'Iniciar conversão?';
  Itens := fParametrosEscolhidos.Itens;
  if Itens <> '' then
    Result := 'Iniciar conversão de ' + IntToStr(Length(SplitString(Itens, ';'))) + ' item(ns)?';
end;

// Mais de um item: a lista vai para a tela de log do host; senao, a caixa de mensagem.
procedure TfrmReformaConvert.pMostrarResultado(const Mensagem: string; const Linhas: TArray<string>);
begin
  if Length(Linhas) > 0 then
    FHost.MostrarLista(TITULO_CONVERT, Mensagem, Linhas)
  else if Mensagem <> '' then
    FHost.Mensagem(TITULO_CONVERT, Mensagem);
end;

function TfrmReformaConvert.fEntrarNaEmpresa(const Empresa: string; out Mensagem: string): Boolean;
var
  Resultado: TResultadoGravacao;
begin
  Mensagem := '';
  if SameText(Empresa, FHost.CodigoEmpresa) then
    Exit(True);
  Resultado := FHost.TrocarEmpresa(Empresa);
  Result := Resultado.Sucesso;
  if not Result then
    Mensagem := 'Não foi possível entrar na empresa ' + Empresa + ': ' + Resultado.Mensagem;
end;

procedure TfrmReformaConvert.pVoltarEmpresaOriginal;
var
  Resultado: TResultadoGravacao;
begin
  if SameText(FHost.CodigoEmpresa, FEmpresaOriginal) then
    Exit;
  Resultado := FHost.TrocarEmpresa(FEmpresaOriginal);
  if not Resultado.Sucesso then
    FHost.Mensagem(TITULO_CONVERT, 'Não foi possível voltar para a empresa ' + FEmpresaOriginal + ': ' +
      Resultado.Mensagem + sLineBreak + 'Saia e entre de novo no autcom antes de continuar.');
end;

procedure TfrmReformaConvert.btnConfirmaClick(Sender: TObject);
var
  Grupos: TArray<string>;
  Empresa: string;
  Processo: TProcessoConversao;
  Mensagem: string;
  Detalhes: TArray<string>;
  Linhas: TArray<string>;
  Linha: string;
  Entrou: Boolean;
begin
  Grupos := fGruposMarcados;
  if Length(Grupos) = 0 then
  begin
    FHost.Mensagem(TITULO_CONVERT, 'Marque na primeira coluna os grupos que vão ser convertidos.');
    Exit;
  end;
  if not FHost.Confirmar(TITULO_CONVERT, fTextoConfirmacao(Grupos)) then
    Exit;

  Linhas := nil;
  Mensagem := '';
  Detalhes := nil;
  Entrou := False;
  try
    // Grupo que falha nao para os outros (usuario, 2026-10-06).
    for Empresa in Grupos do
    begin
      Detalhes := nil;
      Entrou := fEntrarNaEmpresa(Empresa, Mensagem);
      if Entrou then
      begin
        Processo := TProcessoConversao.Create(FHost);
        try
          Processo.Executar(fParametrosEscolhidos, Mensagem);
          Detalhes := Processo.Detalhes;
        finally
          Processo.Free;
        end;
      end;
      Linhas := Linhas + ['Grupo ' + Empresa + ' (' + fEmpresasPrecoDoGrupo(Empresa) + '): ' + fUmaLinha(Mensagem)];
      for Linha in Detalhes do
        Linhas := Linhas + ['    ' + Linha];
    end;
  finally
    pVoltarEmpresaOriginal;
  end;

  // Um grupo so: como antes (mensagem, ou a lista do tratamento que parou).
  if (Length(Grupos) = 1) and Entrou then
    pMostrarResultado(Mensagem, Detalhes)
  else
    pMostrarResultado('Resultado da conversão por grupo:', Linhas);
  pCarregar;
end;

// Reverter (usuario, 2026-10-06): o grupo selecionado, logado na empresa dele, como o Conferir.
procedure TfrmReformaConvert.btnReverterClick(Sender: TObject);
var
  Empresa: string;
  Processo: TProcessoConversao;
  Mensagem: string;
  Linhas: TArray<string>;
begin
  if FGrupos.IsEmpty then
    Exit;
  Empresa := FGrupos.FieldByName('EMP_CODEMP').AsString;
  if not FHost.Confirmar(TITULO_CONVERT, 'Reverter a conversão do grupo ' + Empresa + '?') then
    Exit;

  Linhas := nil;
  try
    if fEntrarNaEmpresa(Empresa, Mensagem) then
    begin
      Processo := TProcessoConversao.Create(FHost);
      try
        Processo.Reverter(Mensagem);
        Linhas := Processo.Detalhes;
      finally
        Processo.Free;
      end;
    end;
  finally
    pVoltarEmpresaOriginal;
  end;
  pMostrarResultado(Mensagem, Linhas);
  pCarregar;
end;

procedure TfrmReformaConvert.btnConferirClick(Sender: TObject);
var
  Empresa: string;
  Processo: TProcessoConversao;
  Mensagem: string;
  Linhas: TArray<string>;
begin
  if FGrupos.IsEmpty then
    Exit;
  Empresa := FGrupos.FieldByName('EMP_CODEMP').AsString;
  Linhas := nil;
  try
    if fEntrarNaEmpresa(Empresa, Mensagem) then
    begin
      Processo := TProcessoConversao.Create(FHost);
      try
        Processo.Conferir(Mensagem);
        Linhas := Processo.Detalhes;
      finally
        Processo.Free;
      end;
    end;
  finally
    pVoltarEmpresaOriginal;
  end;
  pMostrarResultado(Mensagem, Linhas);
  pCarregar;
end;

end.
