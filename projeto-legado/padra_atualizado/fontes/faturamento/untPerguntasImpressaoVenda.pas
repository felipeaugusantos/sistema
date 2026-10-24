unit untPerguntasImpressaoVenda;

interface

uses Vcl.ExtCtrls, cxVGrid, Vcl.Controls, untFuncFatTypes, cxStyles,
  System.Classes, System.Generics.Collections, untTypesSistema;

type
  TcxVerticalGridAccess = class(TcxVerticalGrid);
  TcxvgControllerAccess = class(TcxvgController);
  TcxvgCellNavigatorAccess = class(TcxvgCellNavigator);
  TGenericProcedure = reference to procedure();

  TPerguntasImpressaoVenda = class
  private
    FPanel: TPanel;
    FVerticalGrid: TcxVerticalGrid;
    FStyleVGrid: TcxStyle;
    FFocoPosteriorUltimaLinha : TGenericProcedure;
    FExibePerguntaSeparacaoPedido : Boolean;
    dicRelacaoPerguntas : TDictionary<String, String>;
    procedure AddImprimirPedido;
    procedure AddImprimirSeparacaoPedido;
    procedure AddQtdViasSeparacaoPedido;
    procedure AddImprimirOrcamento;
    procedure AddComSemPrecoOrcamento;
    procedure AddExibirTotalOrcamento;
    procedure AddQtdViasPedido;
    procedure AddQtdViasOrcamento;
    procedure MontarPerguntasPedido;
    procedure MontarPerguntasSeparacaoPedido;
    procedure MontarPerguntasOrcamento;
    procedure AddDesejaEnviarEmail(const strDocumento: String);
    procedure SetarResultadoPerguntasPedido(var APerguntasImpressao: TDadosImprimePdOrSep);
    procedure SetarResultadoPerguntasSeparacaoPedido(var APerguntasImpressao: TDadosImprimePdOrSep);
    procedure SetarResultadoPerguntasOrcamento(var APerguntasImpressao: TDadosImprimePdOrSep);
    procedure VerticalGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditValueChanged(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties);
    procedure PermiteEdicaoDasLinhasFilhas(const ALinhaPai: String; const APermiteEdicao: Boolean);
    procedure AtualizarEdicaoDasLinhasFilhas(const ARowProperties: TcxCustomEditorRowProperties);
    procedure AdicionaPergunta(const AName, ACaption: String; const ADefault: Boolean; const AStyle: TcxStyle; const APai: String; const AEditavel: Boolean); overload;
    procedure AdicionaPergunta(const AName, ACaption: String; const AMin, AMax, ADefault: Integer; const AStyle: TcxStyle; const APai: String; const AEditavel: Boolean); overload;
    procedure AdicionaPergunta(const AName, ACaption: String; const AOpcoes: TArrString; const ADefault: Integer; const AStyle: TcxStyle; const APai: String); overload;
    procedure AdicionaRelacaoPerguntas(const APai, AFilho: String);
    function EhLinhaMandatoria(const AName: String): Boolean;
    function EhLinhaFilha(const APai, ALinha: String): Boolean;
    procedure DesabilitaLinhaFilhaQueNaoPodeSerEditada(const AName: String; const ACondition : Boolean);
  public
    procedure MontarPerguntas(const AOpcDoc : String);
    function GetQuantidadePerguntas: Integer;
    procedure SetarTamanhoHeaderVGrid(const ATamanho: Integer);
    procedure SetarResultadoPerguntas(const AOpcDoc: String; var APerguntasImpressaoDocumento: TDadosImprimePdOrSep; var APerguntasImpressaoSeparacao: TDadosImprimePdOrSep);
    constructor Create(const AStyleVGrid: TcxStyle; const AFocoPosteriorUltimaLinha : TGenericProcedure);
    destructor Destroy; override;
    property Panel: TPanel read FPanel write FPanel;
    property ExibePerguntaSeparacaoPedido : Boolean read FExibePerguntaSeparacaoPedido write FExibePerguntaSeparacaoPedido;
  End;

implementation

uses SysUtils, untFuncoesSimples, untHelperCxVerticalGrid, Winapi.Messages,
  Winapi.Windows, Math;

{ TQuestionarioEmissaoVenda }

procedure TPerguntasImpressaoVenda.AddComSemPrecoOrcamento;
  Var
    ArrOpcoesOrc : TArrString;
begin
  If (Not fPerguntaComSemPrecoEmissaoOrcamento) Then
    Exit;

  If (fCfgSis('ORSPSM', varBoolean)) Then
  Begin
    SetLength(ArrOpcoesOrc, 4);
    ArrOpcoesOrc[0] := 'Com Preço e Com Marca';
    ArrOpcoesOrc[1] := 'Com Preço e Sem Marca';
    ArrOpcoesOrc[2] := 'Sem Preço e Com Marca';
    ArrOpcoesOrc[3] := 'Sem Preço e Sem Marca';
  End
  Else
  Begin
    SetLength(ArrOpcoesOrc, 3);
    ArrOpcoesOrc[0] := 'Com Preço';
    ArrOpcoesOrc[1] := 'Sem Preço';
    ArrOpcoesOrc[2] := 'Sem Preço Simplificado';
  End;

  AdicionaPergunta('OrcamentoComSemPreco', 'Opções do Orçamento', ArrOpcoesOrc, 0, FStyleVGrid, 'ImprimirOrcamento');
end;

procedure TPerguntasImpressaoVenda.AddDesejaEnviarEmail(const strDocumento: String);
begin
  If (Not fCfgSis('FATEMA', varBoolean)) Then
    Exit;

  AdicionaPergunta('DesejaEnviarEmail', Format('Deseja enviar e-mail do %s gerado?', [strDocumento]), False, FStyleVGrid, EmptyStr, True);
end;

procedure TPerguntasImpressaoVenda.AddExibirTotalOrcamento;
begin
  If (fCfgSis('UTIDEF', varBoolean)) Then
    Exit;

  If (Not fPerguntaComSemPrecoEmissaoOrcamento) Then
    Exit;

  AdicionaPergunta('ExibirTotalOrcamento', 'Exibir Valor Total do Documento?', True, FStyleVGrid, 'ImprimirOrcamento', True);
end;

procedure TPerguntasImpressaoVenda.AddImprimirOrcamento;
begin
  AdicionaPergunta('ImprimirOrcamento', 'Imprimir Orçamento?', (fCfgSis('SUGIOR', varString) = 'M'), FStyleVGrid, EmptyStr, (fCfgSis('IMPORC', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AddImprimirPedido;
begin
  AdicionaPergunta('ImprimirPedido', 'Imprimir Pedido?', (fCfgSis('SUGIPD', varString) = 'M'), FStyleVGrid, EmptyStr, (fCfgSis('PRGIPD', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AddImprimirSeparacaoPedido;
begin
  AdicionaPergunta('ImprimirSeparacaoPedido', 'Imprimir Separação do Pedido?', (fCfgSis('SUGISP', varString) = 'M'), FStyleVGrid, EmptyStr, (fCfgSis('PEIMSE', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AddQtdViasOrcamento;
  Const
    MaxVias : Integer = 4;
    MinVias : Integer = 1;
    Default : Integer = 1;
begin
  AdicionaPergunta('QtdViasOrcamento', 'Quantidade vias do orçamento?', MinVias, MaxVias, Default, FStyleVGrid, 'ImprimirOrcamento', (fCfgSis('VIA_OR', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AddQtdViasPedido;
  Const
    MaxVias : Integer = 4;
    MinVias : Integer = 1;
  Var
    LDefault : Integer;
begin
  LDefault := fCfgSis('VIA_PD', varInteger);
  If (LDefault <= 0) Then
    LDefault := 1;
  AdicionaPergunta('QtdViasPedido', 'Quantidade vias do pedido?', MinVias, MaxVias, LDefault, FStyleVGrid, 'ImprimirPedido', (fCfgSis('QTVIPE', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AddQtdViasSeparacaoPedido;
  Const
    MaxVias : Integer = 4;
    MinVias : Integer = 1;
  Var
    LDefault : Integer;
begin
  LDefault := fCfgSis('QTDVSE', varInteger);
  If (LDefault <= 0) Then
    LDefault := 1;
  AdicionaPergunta('QtdViasSeparacaoPedido', 'Quantidade vias separação do pedido?', MinVias, MaxVias, LDefault, FStyleVGrid, 'ImprimirSeparacaoPedido', (fCfgSis('VIA_SE', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.AdicionaPergunta(const AName, ACaption: String; const ADefault: Boolean; const AStyle: TcxStyle; const APai: String; const AEditavel: Boolean);
begin
  FVerticalGrid.AddRowBoolean(AName, ACaption, ADefault, AStyle, AEditavel);
  AdicionaRelacaoPerguntas(APai, AName);
end;

procedure TPerguntasImpressaoVenda.AdicionaPergunta(const AName, ACaption: String; const AMin, AMax, ADefault: Integer; const AStyle: TcxStyle; const APai: String; const AEditavel: Boolean);
begin
  FVerticalGrid.AddRowInteger(AName, ACaption, AMin, AMax, ADefault, AStyle, AEditavel);
  AdicionaRelacaoPerguntas(APai, AName);
end;

procedure TPerguntasImpressaoVenda.AdicionaPergunta(const AName, ACaption: String; const AOpcoes: TArrString; const ADefault: Integer; const AStyle: TcxStyle; const APai: String);
begin
  FVerticalGrid.AddRowComboBox(AName, ACaption, AOpcoes, ADefault, AStyle);
  AdicionaRelacaoPerguntas(APai, AName);
end;

procedure TPerguntasImpressaoVenda.AdicionaRelacaoPerguntas(const APai, AFilho: String);
begin
  If (fEmptyStr(APai)) Then
    Exit;
  dicRelacaoPerguntas.Add(AFilho, APai);
end;

constructor TPerguntasImpressaoVenda.Create(const AStyleVGrid: TcxStyle; const AFocoPosteriorUltimaLinha : TGenericProcedure);
begin
  FPanel := TPanel.Create(Nil);
  FPanel.BevelOuter := bvNone;
  FVerticalGrid := TcxVerticalGrid.Create(FPanel);
  FVerticalGrid.Parent := FPanel;
  FVerticalGrid.Align := alClient;
  FVerticalGrid.TabStop := False;
  FVerticalGrid.OptionsBehavior.GoToNextCellOnEnter := True;
  FVerticalGrid.OptionsBehavior.GoToNextCellOnTab := True;
  FVerticalGrid.OnKeyDown := VerticalGridKeyDown;
  FVerticalGrid.OnEditValueChanged := EditValueChanged;
  FStyleVGrid := AStyleVGrid;
  FFocoPosteriorUltimaLinha := AFocoPosteriorUltimaLinha;
  FExibePerguntaSeparacaoPedido := False;
  dicRelacaoPerguntas := TDictionary<String, String>.Create;
end;

procedure TPerguntasImpressaoVenda.DesabilitaLinhaFilhaQueNaoPodeSerEditada(
  const AName: String; const ACondition: Boolean);
  Var
    LCount : Integer;
begin
  For LCount := 0 To Pred(FVerticalGrid.Rows.Count) Do
  Begin
    If (TcxEditorRow(FVerticalGrid.Rows[LCount]).Name <> AName) Then
      Continue;
    If (Not TcxEditorRow(FVerticalGrid.Rows[LCount]).Properties.Options.Editing) Then
      Exit;
    TcxEditorRow(FVerticalGrid.Rows[LCount]).Properties.Options.Editing := ACondition;
  End;
end;

destructor TPerguntasImpressaoVenda.Destroy;
begin
  FreeAndNil(FVerticalGrid);
  FPanel.Parent := Nil;
  FreeAndNil(FPanel);
  FreeAndNil(dicRelacaoPerguntas);
  inherited;
end;

procedure TPerguntasImpressaoVenda.AtualizarEdicaoDasLinhasFilhas(const ARowProperties: TcxCustomEditorRowProperties);
  Var
    LPropertieValue : Boolean;
    LRowName : String;
begin
  LRowName := ARowProperties.Row.Name;

  If (Not EhLinhaMandatoria(LRowName)) Then
    Exit;

  LPropertieValue := TcxEditorRow(ARowProperties.Row).Properties.Value;
  PermiteEdicaoDasLinhasFilhas(LRowName, LPropertieValue);
  DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasPedido', (fCfgSis('QTVIPE', varString) = 'S'));
  DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasOrcamento', (fCfgSis('VIA_OR', varString) = 'S'));
  DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasSeparacaoPedido', (fCfgSis('VIA_SE', varString) = 'S'));
end;

procedure TPerguntasImpressaoVenda.EditValueChanged(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties);
begin
  AtualizarEdicaoDasLinhasFilhas(ARowProperties);
end;

function TPerguntasImpressaoVenda.EhLinhaFilha(const APai, ALinha: String): Boolean;
  Var
    LPai : String;
begin
  LPai := EmptyStr;
  dicRelacaoPerguntas.TryGetValue(ALinha, LPai);
  Result := APai = LPai;
end;

function TPerguntasImpressaoVenda.EhLinhaMandatoria(
  const AName: String): Boolean;
begin
  Result := (Not dicRelacaoPerguntas.ContainsKey(AName));
end;

procedure TPerguntasImpressaoVenda.PermiteEdicaoDasLinhasFilhas(const ALinhaPai: String; const APermiteEdicao: Boolean);
  Var
    LCount : Integer;
begin
  For LCount := 0 To Pred(FVerticalGrid.Rows.Count) Do
  Begin
    If (EhLinhaMandatoria(TcxEditorRow(FVerticalGrid.Rows[LCount]).Name)) Then
      Continue;
    If (Not EhLinhaFilha(ALinhaPai, TcxEditorRow(FVerticalGrid.Rows[LCount]).Name)) Then
      Continue;
    TcxEditorRow(FVerticalGrid.Rows[LCount]).Properties.Options.Editing := APermiteEdicao;
  End;
end;

function TPerguntasImpressaoVenda.GetQuantidadePerguntas: Integer;
begin
  Result := FVerticalGrid.Rows.Count;
end;

procedure TPerguntasImpressaoVenda.MontarPerguntas(const AOpcDoc : String);
begin
  If (AOpcDoc = 'PD') Then
  Begin
    FVerticalGrid.ClearRows;
    MontarPerguntasPedido;
    MontarPerguntasSeparacaoPedido;
    PermiteEdicaoDasLinhasFilhas('ImprimirPedido', FVerticalGrid.GetValueRowBoolean('ImprimirPedido'));
    DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasPedido', (fCfgSis('QTVIPE', varString) = 'S'));
    PermiteEdicaoDasLinhasFilhas('ImprimirSeparacaoPedido', FVerticalGrid.GetValueRowBoolean('ImprimirSeparacaoPedido'));
    DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasSeparacaoPedido', (fCfgSis('VIA_SE', varString) = 'S'));
    Exit;
  End;

  If (AOpcDoc = 'OR') Then
  Begin
    MontarPerguntasOrcamento;
    PermiteEdicaoDasLinhasFilhas('ImprimirOrcamento', FVerticalGrid.GetValueRowBoolean('ImprimirOrcamento'));
    DesabilitaLinhaFilhaQueNaoPodeSerEditada('QtdViasOrcamento', (fCfgSis('VIA_OR', varString) = 'S'));
    Exit;
  End;
end;

procedure TPerguntasImpressaoVenda.MontarPerguntasOrcamento;
begin
  FVerticalGrid.ClearRows;
  AddImprimirOrcamento;
  AddQtdViasOrcamento;
  AddComSemPrecoOrcamento;
  AddExibirTotalOrcamento;
  AddDesejaEnviarEmail('orçamento');
end;

procedure TPerguntasImpressaoVenda.MontarPerguntasPedido;
begin
  AddImprimirPedido;
  AddQtdViasPedido;
  AddDesejaEnviarEmail('pedido');
end;

procedure TPerguntasImpressaoVenda.MontarPerguntasSeparacaoPedido;
begin
  If (Not FExibePerguntaSeparacaoPedido) Then
    Exit;
  AddImprimirSeparacaoPedido;
  AddQtdViasSeparacaoPedido;
end;

procedure TPerguntasImpressaoVenda.SetarResultadoPerguntas(const AOpcDoc: String; var APerguntasImpressaoDocumento: TDadosImprimePdOrSep; var APerguntasImpressaoSeparacao: TDadosImprimePdOrSep);
begin
  If (GetQuantidadePerguntas <= 0) Then
    Exit;

  If Assigned(APerguntasImpressaoDocumento) Then
    FreeAndNil(APerguntasImpressaoDocumento);

  If Assigned(APerguntasImpressaoSeparacao) Then
    FreeAndNil(APerguntasImpressaoSeparacao);

  If (AOpcDoc = 'PD') Then
  Begin
    SetarResultadoPerguntasPedido(APerguntasImpressaoDocumento);
    SetarResultadoPerguntasSeparacaoPedido(APerguntasImpressaoSeparacao);
    Exit;
  End;

  If (AOpcDoc = 'OR') Then
  Begin
    SetarResultadoPerguntasOrcamento(APerguntasImpressaoDocumento);
    Exit;
  End;
end;

procedure TPerguntasImpressaoVenda.SetarResultadoPerguntasOrcamento(
  var APerguntasImpressao: TDadosImprimePdOrSep);
  Var
    LQtdVias : Integer;
begin
  APerguntasImpressao := TDadosImprimePdOrSep.Create;
  If (FVerticalGrid.GetValueRowBoolean('ImprimirOrcamento')) Then
  Begin
    APerguntasImpressao.imImpDoc := imImprimeSemPergutar;
    LQtdVias := FVerticalGrid.GetValueRowInteger('QtdViasOrcamento');
    APerguntasImpressao.opcComSemPreco := StrToComSemPreco(FVerticalGrid.GetValueRowString('OrcamentoComSemPreco'));
    APerguntasImpressao.blnExibirTotalOrcamento := FVerticalGrid.GetValueRowBoolean('ExibirTotalOrcamento');
    If (LQtdVias <= 0) Then
      LQtdVias := 1;
  End
  Else
  Begin
    LQtdVias := 0;
    APerguntasImpressao.imImpDoc := imNaoImprime;
  End;
  APerguntasImpressao.intQtdVia := LQtdVias;
  APerguntasImpressao.blnEnviarEmail := FVerticalGrid.GetValueRowBoolean('DesejaEnviarEmail');
end;

procedure TPerguntasImpressaoVenda.SetarResultadoPerguntasPedido(var APerguntasImpressao: TDadosImprimePdOrSep);
  Var
    LQtdVias : Integer;
begin
  APerguntasImpressao := TDadosImprimePdOrSep.Create;
  If (FVerticalGrid.GetValueRowBoolean('ImprimirPedido')) Then
  Begin
    APerguntasImpressao.imImpDoc := imImprimeSemPergutar;
    LQtdVias := FVerticalGrid.GetValueRowInteger('QtdViasPedido');
    If (LQtdVias <= 0) Then
      LQtdVias := Max(1, fCfgSis('VIA_PD', varInteger));
  End
  Else
  Begin
    LQtdVias := 0;
    APerguntasImpressao.imImpDoc := imNaoImprime;
  End;
  APerguntasImpressao.intQtdVia := LQtdVias;
  APerguntasImpressao.blnEnviarEmail := FVerticalGrid.GetValueRowBoolean('DesejaEnviarEmail');
end;

procedure TPerguntasImpressaoVenda.SetarResultadoPerguntasSeparacaoPedido(
  var APerguntasImpressao: TDadosImprimePdOrSep);
  Var
    LQtdVias : Integer;
begin
  APerguntasImpressao := TDadosImprimePdOrSep.Create;
  If (FVerticalGrid.GetValueRowBoolean('ImprimirSeparacaoPedido')) Then
  Begin
    APerguntasImpressao.imImpDoc := imImprimeSemPergutar;
    LQtdVias := FVerticalGrid.GetValueRowInteger('QtdViasSeparacaoPedido');
    If (LQtdVias <= 0) Then
      LQtdVias := Max(1, fCfgSis('QTDVSE', varInteger));
  End
  Else
  Begin
    LQtdVias := 0;
    APerguntasImpressao.imImpDoc := imNaoImprime;
  End;
  APerguntasImpressao.intQtdVia := LQtdVias;
end;

procedure TPerguntasImpressaoVenda.SetarTamanhoHeaderVGrid(const ATamanho: Integer);
begin
  FVerticalGrid.OptionsView.RowHeaderWidth := ATamanho;
end;

procedure TPerguntasImpressaoVenda.VerticalGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    LVerticalGrid: TcxVerticalGridAccess absolute Sender;
    LController: TcxvgControllerAccess;
    LNavigator: TcxvgCellNavigatorAccess;
    LRow: TcxCustomRow;
    LCellIndex: Integer;
begin
  LController := TcxvgControllerAccess(LVerticalGrid.Controller);
  LNavigator  := TcxvgCellNavigatorAccess(LController.Navigator);
  LRow := LVerticalGrid.FocusedRow;
  LNavigator.RowCount := LController.ViewInfo.VisibleRowCount;
  If (Not LNavigator.FindNextRow(LRow, LCellIndex, Not (ssShift in Shift))) Then
  begin
    If (Not ((Key = VK_Return) or (Key = VK_Tab))) Then
      Exit;
    Key := 0;
    FFocoPosteriorUltimaLinha();
  end;
end;

end.
