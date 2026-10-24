unit Principal.View.FMXDashboardOld;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Principal.View.Interfaces,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMXTee.Engine, FMXTee.Series, FMX.Ani, FMXTee.Procs, FMXTee.Chart, FMX.Edit,
  System.Math, StrUtils, DateUtils, FMX.Filter.Effects, FMX.EditBox,
  FMX.SpinBox, FMX.ListBox, Shared.Functions.DataSet, Shared.Functions.Core,
  Principal.View.Frame.FMXGraficoBase,
  Principal.View.Frame.FMXDashProjecaoMargem,
  Principal.View.Frame.FMXDashTotalVendas,
  Principal.View.Frame.FMXDashProjecaoVendas,
  FMX.TabControl,
  Principal.View.Frame.FMXDashDiasUteis,
  Principal.View.Frame.FMXDashFaturamentoXMetasCabecalho,
  Principal.View.Frame.FMXDashMargemXMetasCabecalho,
  Principal.View.Frame.FMXDashTipoEmpresa, FMX.ComboEdit,
  Principal.View.Frame.FMXDashVendasXMetasDiarias,
  Principal.View.Frame.FMXDashTotalVendedoresCabecalho,
  Principal.View.Frame.FMXDashPedidosNaoFaturados,
  Principal.View.Frame.FMXDashTotalFormaPagamento,
  Principal.View.Frame.FMXDashTopClientesCabecalho,
  Principal.View.Frame.FMXDashConstrucaoMetaCabecalho;

type
  TfmxDashboardPrincipalOld = class(TForm)
    layProjecoes: TLayout;
    layPrincipal: TLayout;
    recFundoCinza: TRectangle;
    btnFechar: TSpeedButton;
    imgFechar: TImage;
    scrBarraRolagem: TVertScrollBox;
    layRodape: TLayout;
    layAbaVendedores: TLayout;
    layPeriodo: TLayout;
    btnSetaEsquerda: TSpeedButton;
    patSetaEsquerda: TPath;
    btnSetaDireita: TSpeedButton;
    patSetaDireita: TPath;
    edtMesAno: TEdit;
    Popup1: TPopup;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    edtAno: TSpinBox;
    Layout1: TLayout;
    Rectangle3: TRectangle;
    btnOk: TButton;
    StyleBook1: TStyleBook;
    lstMeses: TListBox;
    lstiteJaneiro: TListBoxItem;
    lstiteFevereiro: TListBoxItem;
    lstiteMarco: TListBoxItem;
    lstiteAbril: TListBoxItem;
    lstiteMaio: TListBoxItem;
    lstiteJunho: TListBoxItem;
    lstiteJulho: TListBoxItem;
    lstiteAgosto: TListBoxItem;
    lstiteSetembro: TListBoxItem;
    lstiteOutubro: TListBoxItem;
    lstiteNovembro: TListBoxItem;
    lstiteDezembro: TListBoxItem;
    Line1: TLine;
    layPeriodoCentro: TLayout;
    layCabecalhoCentralizar: TLayout;
    fraTotalVendedores: TframeTotalVendedores;
    tabDashboard: TTabControl;
    tabAbaVendedores: TTabItem;
    tabAbaFiliais: TTabItem;
    Rectangle2: TRectangle;
    linRodape: TLine;
    btnAbaVendedores: TSpeedButton;
    recBotaoAbaVendedores: TRectangle;
    lblAbaVendedores: TLabel;
    linAbaVendedores: TLine;
    layBotaoAbaVendedores: TLayout;
    imgAbaVendedores: TImage;
    fraDiasUteis: TframeDiasUteis;
    layAbaFiliais: TLayout;
    fraFaturamentoXMetas: TframeFaturamentoXMetas;
    layAbas: TFlowLayout;
    fraMargemXMetas: TframeMargemXMetas;
    fraTipoEmpresa: TframeTipoEmpresa;
    layFiltros: TLayout;
    recBordasFiltros: TRectangle;
    lblEmpresa: TLabel;
    recEdtCodEmpresa: TRectangle;
    edtCodEmpresa: TEdit;
    linEmpresaCursor: TLine;
    btnFiltrar: TButton;
    layCentralizaFiltros: TLayout;
    recNomeEmpresa: TRectangle;
    lblNomeEmpresa: TLabel;
    tmrCursor: TTimer;
    lblCompCusto: TLabel;
    recComCusto: TRectangle;
    cbbCompCusto: TComboBox;
    gridProjecoes: TGridPanelLayout;
    layVendasXMetas: TLayout;
    fraVendasXMetasDiarias: TframeVendasXMetasDiarias;
    layFormasClientes: TLayout;
    layTop5Clientes: TLayout;
    fraTopClientes: TframeTopClientesCabecalho;
    btnAbaGerentes: TSpeedButton;
    recBotaoAbaGerentes: TRectangle;
    linAbaGerentes: TLine;
    layBotaoAbaGerentes: TLayout;
    imgAbaGerentes: TImage;
    lblAbaGerentes: TLabel;
    tabAbaGerentes: TTabItem;
    layAbaGerentes: TLayout;
    layCentralizaTituloAbaVendedores: TLayout;
    layCentralizaTituloAbaGerentes: TLayout;
    btnAbaLoja: TSpeedButton;
    recBotaoAbaLoja: TRectangle;
    linAbaLoja: TLine;
    layBotaoAbaLoja: TLayout;
    layCentralizaTituloAbaLoja: TLayout;
    lblAbaLoja: TLabel;
    imgAbaLoja: TImage;
    tabAbaLoja: TTabItem;
    layAbaLoja: TLayout;
    layProjecoesGerente: TLayout;
    fraProjecaoVendas: TframeProjecaoVendas;
    fraProjecaoMargem: TframeProjecaoMargem;
    fraTotalVendas: TframeTotalVendas;
    fraPedidosNaoFaturados: TframePedidosNaoFaturados;
    gridProjecoesGer: TGridPanelLayout;
    fraProjecaoVendasGer: TframeProjecaoVendas;
    fraProjecaoMargemGer: TframeProjecaoMargem;
    fraTotalVendasGer: TframeTotalVendas;
    fraPedidosNaoFaturadosGer: TframePedidosNaoFaturados;
    layProjecoesLoja: TLayout;
    grdProjecoesLoja: TGridPanelLayout;
    fraProjecaoVendasLoj: TframeProjecaoVendas;
    fraProjecaoMargemLoj: TframeProjecaoMargem;
    fraTotalVendasLoj: TframeTotalVendas;
    fraPedidosNaoFaturadosLoj: TframePedidosNaoFaturados;
    fraVendasXMetasDiariasLoj: TframeVendasXMetasDiarias;
    btnAbaFiliais: TSpeedButton;
    recBotaoAbaFiliais: TRectangle;
    linAbaFiliais: TLine;
    layBotaoAbaFiliais: TLayout;
    layCentralizaTituloAbaFiliais: TLayout;
    lblAbaFiliais: TLabel;
    imgAbaFiliais: TImage;
    fraTotalFormaPagamento: TframeTotalFormaPagamento;
    fraConstrucaoMetaLoj: TframeConstrucaoMeta;
    fraTotalVendedoresGer: TframeTotalVendedores;
    fraVendasXMetasDiariasGer: TframeVendasXMetasDiarias;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSetaEsquerdaClick(Sender: TObject);
    procedure btnSetaDireitaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtAnoChange(Sender: TObject);
    procedure edtMesAnoClick(Sender: TObject);
    procedure btnAbaFiliaisClick(Sender: TObject);
    procedure btnAbaVendedoresClick(Sender: TObject);
    procedure btnAbaVendedoresMouseEnter(Sender: TObject);
    procedure btnAbaVendedoresMouseLeave(Sender: TObject);
    procedure fraTipoEmpresarecOrigemMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure fraTipoEmpresarecFaturamentoMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaChangeTracking(Sender: TObject);
    procedure edtCodEmpresaClick(Sender: TObject);
    procedure edtCodEmpresaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCodEmpresaEnter(Sender: TObject);
    procedure tmrCursorTimer(Sender: TObject);
    procedure edtCodEmpresaChange(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtCodEmpresaKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure cbbCompCustoEnter(Sender: TObject);
    procedure cbbCompCustoExit(Sender: TObject);
    procedure cbbCompCustoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btnAbaGerentesClick(Sender: TObject);
    procedure btnAbaLojaClick(Sender: TObject);

  private
    { Private declarations }

    procedure AtualizarGraficos;
    procedure EsconderGraficos(Aba: TTabItem = Nil);
    procedure BloquearMesesFuturos(Ano: Integer);

    function ExtrairUltimoDiaMesSelecionado: TDatetime;
    function AbaVendedoresOuNenhumaAba(Aba: TTabItem): Boolean;
    function AbaFiliasOuNenhumaAba(Aba: TTabItem): Boolean;
    function AbaGerenteOuNenhumaAba(Aba: TTabItem): Boolean;
    function AbaLojaOuNenhumaAba(Aba: TTabItem): Boolean;

    procedure HabilitarAbaNova(Tab: TTabItem);
    procedure DesabilitarAbaAtual;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
    procedure ConsultaEmpresa;
    procedure CarregaCompCusto;

    function EmpresaValida:Boolean;

  public
    { Public declarations }
    objDash: IDashboard;
    objPrincipal: IPrincipalAutcom;
    blnUsuarioLogadoUtilizaModoClassico : boolean;

    procedure ModificaPeriodo(NumeroDeMeses:Integer);
    procedure ModificaPeriodoPorMesSelecionado(Mes, Ano: Integer);
    procedure IniciaVariaveis;
    procedure DesabilitarFuncoes(Aba: TTabItem = Nil);
    procedure HabilitarFuncoes;
    procedure AjustaAlturaDashboard(Aba: TTabItem = Nil);
    procedure AjustaDashboardPeloOperador;
    procedure HabilitarAbaDefault(strTipOpe: String);

    Function MesAtualFoiSelecionado: Boolean;
  end;

Const
  EspacoEntreGraficos: Single = 20;
  PercentagemMargemBarras: Single = 35;

  Vermelho   = TAlphaColor($FFE1211E);
  Laranja    = TAlphaColor($FFF87200);
  Amarelo    = TAlphaColor($FFF5B700);
  VerdeClaro = TAlphaColor($FFC4D803);
  Verde      = TAlphaColor($FF79BE27);

  CorBarra1  = TAlphaColor($FF485868);
  CorBarra2  = TAlphaColor($FFF3C766);
  CorBarra3  = TAlphaColor($FFF27360);
  CorBarra4  = TAlphaColor($FF9FC2BB);

var
  fmxDashboardPrincipalOld: TfmxDashboardPrincipalOld;

implementation

{$R *.fmx}

uses Principal.View.FMXConsultaEmpresa;

procedure TfmxDashboardPrincipalOld.BloquearMesesFuturos(Ano: Integer);
Var
  i, MesAtual: Integer;
begin
  If (Ano >= edtAno.Max) Then
  Begin
    MesAtual := MonthOf(Now);

    For i := 1 To 12 Do
      If i > MesAtual Then
        lstMeses.ItemByIndex(i-1).Visible := False
      Else
        lstMeses.ItemByIndex(i-1).Visible := True;
  End
  Else
  Begin
    For i := 1 To 12 Do
      lstMeses.ItemByIndex(i-1).Visible := True;
  End;
end;

procedure TfmxDashboardPrincipalOld.btnAbaFiliaisClick(Sender: TObject);
Var
  LHabilitarFuncoes: Boolean;
begin
  If Not EmpresaValida Then
    Exit;

  LHabilitarFuncoes := False;
  If (tabDashboard.ActiveTab <> tabAbaFiliais) Then
  Begin
    If (tabAbaFiliais.Tag = 1) Then
    Begin
      DesabilitarFuncoes(tabAbaFiliais);
      LHabilitarFuncoes := True;
    End;

    layFiltros.Visible := False;
    HabilitarAbaNova(tabAbaFiliais);
    AtualizarGraficos;

    If (LHabilitarFuncoes) Then
      HabilitarFuncoes;
  End;
end;

procedure TfmxDashboardPrincipalOld.btnAbaGerentesClick(Sender: TObject);
Var
  LHabilitarFuncoes: Boolean;
begin
  If Not EmpresaValida Then
    Exit;

  LHabilitarFuncoes := False;
  If (tabDashboard.ActiveTab <> tabAbaGerentes) Then
  Begin
    If (tabAbaGerentes.Tag = 1) Then
    Begin
      DesabilitarFuncoes(tabAbaGerentes);
      LHabilitarFuncoes := True;
    End;

    HabilitarAbaNova(tabAbaGerentes);
    AtualizarGraficos;

    If (LHabilitarFuncoes) Then
      HabilitarFuncoes;
  End;
end;

procedure TfmxDashboardPrincipalOld.btnAbaLojaClick(Sender: TObject);
Var
  LHabilitarFuncoes: Boolean;
begin
  If Not EmpresaValida Then
    Exit;

  LHabilitarFuncoes := False;
  If (tabDashboard.ActiveTab <> tabAbaLoja) Then
  Begin
    If (tabAbaLoja.Tag = 1) Then
    Begin
      DesabilitarFuncoes(tabAbaLoja);
      LHabilitarFuncoes := True;
    End;

    layFiltros.Visible := objDash.MostrarFiltros;
    HabilitarAbaNova(tabAbaLoja);
    AtualizarGraficos;

    If (LHabilitarFuncoes) Then
      HabilitarFuncoes;
  End;
end;

procedure TfmxDashboardPrincipalOld.btnAbaVendedoresClick(Sender: TObject);
Var
  LHabilitarFuncoes: Boolean;
begin
  If Not EmpresaValida Then
    Exit;

  LHabilitarFuncoes := False;
  If (tabDashboard.ActiveTab <> tabAbaVendedores) Then
  Begin
    If (tabAbaVendedores.Tag = 1) Then
    Begin
      DesabilitarFuncoes(tabAbaVendedores);
      LHabilitarFuncoes := True;
    End;

    HabilitarAbaNova(tabAbaVendedores);
    AtualizarGraficos;

    If (LHabilitarFuncoes) Then
      HabilitarFuncoes;

    edtCodEmpresa.SetFocus;
  End;
end;

procedure TfmxDashboardPrincipalOld.btnAbaVendedoresMouseEnter(Sender: TObject);
Var
  LRecFundo : TRectangle;
begin
  LRecFundo := TRectangle(FindComponent('recBotao' + Copy(TSpeedButton(Sender).Name,4,30)));

  If LRecFundo.Visible Then
    TSpeedButton(Sender).Cursor := crDefault
  Else
    TSpeedButton(Sender).Cursor := crHandPoint;
end;

procedure TfmxDashboardPrincipalOld.btnAbaVendedoresMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Cursor := crDefault;
end;

procedure TfmxDashboardPrincipalOld.btnFecharClick(Sender: TObject);
begin
  layPrincipal.Parent := Self;
  Self.Close;
end;

procedure TfmxDashboardPrincipalOld.btnFiltrarClick(Sender: TObject);
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  tabAbaVendedores.Tag := 1;
  tabAbaFiliais.Tag    := 1;
  tabAbaGerentes.Tag   := 1;
  tabAbaLoja.Tag       := 1;
  fraDiasUteis.Tag     := 1;

  AtualizarGraficos;
  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipalOld.btnOkClick(Sender: TObject);
Var
  LNovaTagMesAno,
  LMes: Integer;
begin
  If Not EmpresaValida Then
    Exit;

  LMes := lstMeses.ItemIndex + 1;

  LNovaTagMesAno := StrToInt(edtAno.Text + FormatFloat('00',LMes));
  Popup1.IsOpen  := False;

  If (LNovaTagMesAno <> edtMesAno.Tag) Then
    ModificaPeriodoPorMesSelecionado(LMes, StrToInt(edtAno.Text));
end;

procedure TfmxDashboardPrincipalOld.btnSetaDireitaClick(Sender: TObject);
begin
  If btnSetaDireita.Visible Then
    ModificaPeriodo(+1);
end;

procedure TfmxDashboardPrincipalOld.btnSetaEsquerdaClick(Sender: TObject);
begin
  If btnSetaEsquerda.Visible Then
    ModificaPeriodo(-1);
end;

procedure TfmxDashboardPrincipalOld.CarregaCompCusto;
Var
  LCusto : String;
  LIndex : Integer;
  LCustos: TArray<String>;
begin
  LIndex := -1;
  cbbCompCusto.Items.Clear;
  LCustos := objDash.ListaCompCusto;

  For LCusto in LCustos do
  Begin
    If (LeftStr(LCusto, 1) = '*') Then
      LIndex := cbbCompCusto.Items.Count;

    cbbCompCusto.Items.Add(LCusto.Replace('*',''));
  End;

  cbbCompCusto.ItemIndex := LIndex;
end;

procedure TfmxDashboardPrincipalOld.cbbCompCustoEnter(Sender: TObject);
begin
  recComCusto.Stroke.Color := TAlphaColor($7F2A96FF);
end;

procedure TfmxDashboardPrincipalOld.cbbCompCustoExit(Sender: TObject);
begin
  recComCusto.Stroke.Color := TAlphaColor($FFCCCCCC);
end;

procedure TfmxDashboardPrincipalOld.cbbCompCustoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkDown:
    Begin
      If Not cbbCompCusto.DroppedDown Then
        cbbCompCusto.DropDown;
    End;

    vkReturn:
    Begin
      btnFiltrar.SetFocus;
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.ConsultaEmpresa;
Var
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  LEmpresas := objDash.ListaEmpresas(True);

  fmxConsultaEmpresa := TfmxConsultaEmpresa.Create(Self);

  For LEmpresa in LEmpresas do
    fmxConsultaEmpresa.lstEmpresas.Add(LEmpresa + '|' + objDash.NomeEmpresa(LEmpresa));

  fmxConsultaEmpresa.ShowModal;

  If (fmxConsultaEmpresa.ModalResult = mrOk) Then
    edtCodEmpresa.Text := fmxConsultaEmpresa.strCodEmp;

  FreeAndNil(fmxConsultaEmpresa);
end;

procedure TfmxDashboardPrincipalOld.DesabilitarAbaAtual;
Var
  LLayoutBotao,
  LLayoutPrincipal : TLayout;
  LRectangle       : TRectangle;
  LTab             : TTabItem;
begin
  If Assigned(tabDashboard.ActiveTab) Then
  Begin
    LTab       := tabDashboard.ActiveTab;

    LLayoutPrincipal := TLayout(FindComponent('lay' + Copy(LTab.Name,4,30)));
    LLayoutPrincipal.Visible := False;

    LLayoutBotao := TLayout(FindComponent('layBotao' + Copy(LTab.Name,4,30)));
    LRectangle   := TRectangle(FindComponent('recBotao' + Copy(LTab.Name, 4, 30)));

    LLayoutBotao.Opacity := 0.3;
    LRectangle.Visible   := False;

    tabDashboard.TabIndex := -1;
    Application.ProcessMessages;
  End;
end;

procedure TfmxDashboardPrincipalOld.DesabilitarFuncoes(Aba: TTabItem = Nil);
begin
  EsconderGraficos(Aba);

  btnFechar.Visible       := False;
  btnSetaEsquerda.Visible := False;
  btnSetaDireita.Visible  := False;

  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipalOld.edtAnoChange(Sender: TObject);
begin
  BloquearMesesFuturos(Round(edtAno.Value));
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaChange(Sender: TObject);
Var
  LNomeEmpresa : String;
begin
  If (edtCodEmpresa.Text.IsEmpty) Then
  Begin
    lblNomeEmpresa.FontColor := TAlphaColorRec.Black;
    lblNomeEmpresa.Opacity   := 0.6;
    lblNomeEmpresa.Text      := 'TODAS';
    btnFiltrar.Enabled       := True;
    btnFiltrar.SetFocus;
  End
  Else
  Begin
    LNomeEmpresa := objDash.NomeEmpresa(FormatFloat('000',StrToInt(edtCodEmpresa.Text)));

    lblNomeEmpresa.FontColor := TAlphaColorRec.Red;
    lblNomeEmpresa.Opacity   := 1;

    edtCodEmpresa.SelectAll;
    MoveCursor(vkEnd);

    If (LNomeEmpresa.IsEmpty) Then
    Begin
      lblNomeEmpresa.Text  := 'EMPRESA NÃO ENCONTRADA. POR FAVOR, INFORME UM CÓDIGO VÁLIDO';
      btnFiltrar.Enabled   := False;
      edtCodEmpresa.SetFocus;
    End

    Else If Not objDash.UsuarioTemAcessoAEmpresa(FormatFloat('000',StrToInt(edtCodEmpresa.Text))) Then
    Begin
      lblNomeEmpresa.Text  := 'VOCÊ NÃO TEM ACESSO A ESSA EMPRESA. POR FAVOR, INFORME UM CÓDIGO VÁLIDO';
      btnFiltrar.Enabled   := False;
      edtCodEmpresa.SetFocus;
    End

    Else
    Begin
      lblNomeEmpresa.FontColor := TAlphaColorRec.Black;
      lblNomeEmpresa.Opacity   := 0.6;
      lblNomeEmpresa.Text      := LNomeEmpresa;
      btnFiltrar.Enabled       := True;
      btnFiltrar.SetFocus;
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaChangeTracking(Sender: TObject);
begin
  MoveCursor(vkRight);
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaEnter(Sender: TObject);
begin
  MoveCursor(vkEnd);
  PiscaCursor;
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaExit(Sender: TObject);
begin
  If (TEdit(Sender).Text <> EmptyStr) Then
    TEdit(Sender).Text := FormatFloat('000',StrToInt(TEdit(Sender).Text));

  EscondeCursor;
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If (KeyChar = '/') Then
    ConsultaEmpresa;

  If (edtCodEmpresa.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.edtCodEmpresaKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkReturn:
    Begin
      if (lblNomeEmpresa.FontColor <> TAlphaColorRec.Red) Then
        cbbCompCusto.SetFocus;
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.edtMesAnoClick(Sender: TObject);
begin
  edtAno.Text        := RightStr(edtMesAno.Text,4);
  edtAno.Max         := YearOf(Now);

  BloquearMesesFuturos(StrToInt(edtAno.Text));

  lstMeses.ItemIndex := StrToInt(Copy(IntToStr(edtMesAno.Tag),5,2))-1;

  Popup1.Width       := edtMesAno.Width;
  Popup1.IsOpen      := True;
end;

function TfmxDashboardPrincipalOld.EmpresaValida: Boolean;
begin
  Result := True;

  If Not edtCodEmpresa.Text.IsEmpty Then
  Begin
    If Not objDash.UsuarioTemAcessoAEmpresa(FormatFloat('000',StrToInt(edtCodEmpresa.Text))) Then
    Begin
      objDash.pMensagemOk('Você não tem acesso a essa empresa. Por favor, informe um código válido');
      edtCodEmpresa.SetFocus;
      Result := False;
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.EscondeCursor;
begin
  linEmpresaCursor.Tag := 0;
  linEmpresaCursor.Visible := False;
end;

procedure TfmxDashboardPrincipalOld.EsconderGraficos(Aba: TTabItem = Nil);
begin
  If AbaVendedoresOuNenhumaAba(Aba) Then
  Begin
    fraProjecaoMargem.layProjecaoMargem.Visible              := False;
    fraProjecaoVendas.layProjecaoFaturamento.Visible         := False;
    fraTotalVendas.layTotalVendas.Visible                    := False;
    fraTotalVendedores.layCentralizarTotalVendedores.Visible := False;
    fraPedidosNaoFaturados.layPedidosNaoFaturados.Visible    := False;
    fraVendasXMetasDiarias.layProjecaoVendasXMetas.Visible   := False;
    fraTotalFormaPagamento.layTotalFormaPagamento.Visible    := False;
    fraTopClientes.layTopClientes.Visible                    := False;
  End;

  If AbaFiliasOuNenhumaAba(Aba) Then
  Begin
    fraFaturamentoXMetas.layFaturamentoXMetas.Visible      := False;
    fraMargemXMetas.layMargemXMetas.Visible                := False;
  End;

  If AbaGerenteOuNenhumaAba(Aba) Then
  Begin
    fraProjecaoMargemGer.layProjecaoMargem.Visible              := False;
    fraProjecaoVendasGer.layProjecaoFaturamento.Visible         := False;
    fraTotalVendasGer.layTotalVendas.Visible                    := False;
    fraTotalVendedoresGer.layCentralizarTotalVendedores.Visible := False;
    fraPedidosNaoFaturadosGer.layPedidosNaoFaturados.Visible    := False;
    fraVendasXMetasDiariasGer.layProjecaoVendasXMetas.Visible   := False;
  End;

  If AbaLojaOuNenhumaAba(Aba) Then
  Begin
    fraProjecaoMargemLoj.layProjecaoMargem.Visible              := False;
    fraProjecaoVendasLoj.layProjecaoFaturamento.Visible         := False;
    fraTotalVendasLoj.layTotalVendas.Visible                    := False;
    fraPedidosNaoFaturadosLoj.layPedidosNaoFaturados.Visible    := False;
    fraVendasXMetasDiariasLoj.layProjecaoVendasXMetas.Visible   := False;
    fraConstrucaoMetaLoj.layCentralizarConstrucaoMeta.Visible   := False;
  End;
end;

function TfmxDashboardPrincipalOld.ExtrairUltimoDiaMesSelecionado: TDatetime;
Var
  Mes, Ano,
  UltimoDiaMes: String;
begin
  Mes          := Copy(IntToStr(edtMesAno.Tag), 5, 2);
  Ano          := Copy(IntToStr(edtMesAno.Tag), 1, 4);
  UltimoDiaMes := IntToStr(DaysInAMonth(StrToInt(Ano), StrToInt(Mes)));

  Result := EncodeDate(Ano.ToInteger, Mes.ToInteger, UltimoDiaMes.ToInteger);
end;

procedure TfmxDashboardPrincipalOld.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(objDash) Then
    objDash.pApagaTemporarias;

  Self.Tag := 0;
end;

procedure TfmxDashboardPrincipalOld.FormCreate(Sender: TObject);
Var
  LContador : Integer;
begin
  tmrCursor.Enabled := True;
  EscondeCursor;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassParent.ClassNameIs('TfraGraficoBase')) Then
      TfraGraficoBase(Self.Components[LContador]).calValorGrafico.Visible := False;
  End;

  tabAbaVendedores.Tag  := 1;
  tabAbaFiliais.Tag     := 1;
  tabAbaGerentes.Tag    := 1;
  tabAbaLoja.Tag        := 1;
  fraDiasUteis.Tag      := 1;

  tabAbaVendedores.Visible := False;
  tabAbaFiliais.Visible    := False;
  tabAbaGerentes.Visible   := False;
  tabAbaLoja.Visible       := False;

  layFiltros.Visible := False;

  tabDashboard.TabIndex := 0;
  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipalOld.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape: Self.Close;
  End;
end;

procedure TfmxDashboardPrincipalOld.FormShow(Sender: TObject);
begin
  IniciaVariaveis;
  ModificaPeriodo(0);

  edtCodEmpresa.SetFocus;
end;

procedure TfmxDashboardPrincipalOld.fraTipoEmpresarecFaturamentoMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LTipoEmpAtual: String;
begin
  If Not EmpresaValida Then
    Exit;

  LTipoEmpAtual := fraTipoEmpresa.strTipoEmpresa;

  fraTipoEmpresa.recFaturamentoMouseUp(Sender, Button, Shift, X, Y);

  If (LTipoEmpAtual <> fraTipoEmpresa.strTipoEmpresa) Then
  Begin
    tabAbaVendedores.Tag  := 1;
    tabAbaFiliais.Tag     := 1;
    tabAbaGerentes.Tag    := 1;
    tabAbaLoja.Tag        := 1;

    DesabilitarFuncoes(tabDashboard.ActiveTab);
    AtualizarGraficos;
    HabilitarFuncoes;
  End;
end;

procedure TfmxDashboardPrincipalOld.fraTipoEmpresarecOrigemMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LTipoEmpAtual: String;
begin
  If Not EmpresaValida Then
    Exit;

  LTipoEmpAtual := fraTipoEmpresa.strTipoEmpresa;

  fraTipoEmpresa.recOrigemMouseUp(Sender, Button, Shift, X, Y);

  If (LTipoEmpAtual <> fraTipoEmpresa.strTipoEmpresa) Then
  Begin
    tabAbaVendedores.Tag  := 1;
    tabAbaFiliais.Tag     := 1;
    tabAbaGerentes.Tag    := 1;
    tabAbaLoja.Tag        := 1;

    DesabilitarFuncoes(tabDashboard.ActiveTab);
    AtualizarGraficos;
    HabilitarFuncoes;
  End;
end;

procedure TfmxDashboardPrincipalOld.HabilitarAbaDefault(strTipOpe: String);
begin
  If btnAbaVendedores.Visible Then
    HabilitarAbaNova(tabAbaVendedores);

  If btnAbaGerentes.Visible Then
    HabilitarAbaNova(tabAbaGerentes);

  If btnAbaLoja.Visible And strTipOpe.Equals('A') Then
    HabilitarAbaNova(tabAbaLoja);
end;

procedure TfmxDashboardPrincipalOld.HabilitarAbaNova(Tab: TTabItem);
Var
  LLayoutBotao,
  LLayoutPrincipal : TLayout;
  LRectangle       : TRectangle;
begin
  DesabilitarAbaAtual;

  LLayoutBotao     := TLayout(FindComponent('layBotao' + Copy(tab.Name,4,30)));
  LLayoutPrincipal := TLayout(FindComponent('lay' + Copy(tab.Name,4,30)));
  LRectangle       := TRectangle(FindComponent('recBotao' + Copy(tab.Name,4,30)));

  LLayoutBotao.Opacity     := 0.6;
  LRectangle.Visible       := True;

  tabDashboard.ActiveTab   := tab;
  LLayoutPrincipal.Visible := True;
  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipalOld.HabilitarFuncoes;
begin
  btnFechar.Visible       := True;
  btnSetaEsquerda.Visible := True;
  btnSetaDireita.Visible  := Not MesAtualFoiSelecionado;

  edtCodEmpresa.SetFocus;

  Application.ProcessMessages;
end;

function TfmxDashboardPrincipalOld.MesAtualFoiSelecionado: Boolean;
Var
  LMesAtual,
  LMesSelecionado: String;
begin
  LMesAtual       := IntToStr(MonthOf(Now)) + '/' + IntToStr(YearOf(Now));
  LMesSelecionado := IntToStr(MonthOf(ExtrairUltimoDiaMesSelecionado)) + '/' + IntToStr(YearOf(ExtrairUltimoDiaMesSelecionado));

  Result := SameText(LMesAtual, LMesSelecionado);
end;

procedure TfmxDashboardPrincipalOld.ModificaPeriodo(NumeroDeMeses:Integer);
Var
  Mes, Ano : sTRING;
  DataAtual,NovaData: TDate;
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  If (NumeroDeMeses = 0) Then
  Begin
    NovaData       := Now;
    edtMesAno.Tag  := StrToInt(IntToStr(YearOf(NovaData)) + FormatFloat('00',MonthOf(NovaData)));
    edtMesAno.Text := fraProjecaoMargem.MesAnoPorExtenso(NovaData);

    btnSetaDireita.Visible := False;
  End
  Else
  Begin
    Mes := Copy(IntToStr(edtMesAno.Tag), 5, 2);
    Ano := Copy(IntToStr(edtMesAno.Tag), 1, 4);

    DataAtual := StrToDate('01/' + Mes + '/' + Ano);
    NovaData  := IncMonth(DataAtual, NumeroDeMeses);

    edtMesAno.Tag  := StrToInt(IntToStr(YearOf(NovaData)) + FormatFloat('00',MonthOf(NovaData)));
    edtMesAno.Text := fraProjecaoMargem.MesAnoPorExtenso(NovaData);
  End;

  tabAbaVendedores.Tag := 1;
  tabAbaFiliais.Tag    := 1;
  tabAbaGerentes.Tag   := 1;
  tabAbaLoja.Tag       := 1;
  fraDiasUteis.Tag     := 1;

  AtualizarGraficos;
  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipalOld.ModificaPeriodoPorMesSelecionado(Mes, Ano: Integer);
Var
  NovaData: TDate;
begin
  DesabilitarFuncoes;

  NovaData := StrToDate('01/' + IntToStr(Mes) + '/' + IntToStr(Ano));

  edtMesAno.Tag  := StrToInt(IntToStr(Ano) + FormatFloat('00',Mes));
  edtMesAno.Text := fraProjecaoMargem.MesAnoPorExtenso(NovaData);

  tabAbaVendedores.Tag := 1;
  tabAbaFiliais.Tag    := 1;
  tabAbaGerentes.Tag   := 1;
  tabAbaLoja.Tag       := 1;
  fraDiasUteis.Tag     := 1;

  AtualizarGraficos;
  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipalOld.MoveCursor(Key: Word);
Var
  LText: String;
begin
  PiscaCursor;

  edtCodEmpresa.Canvas.Font.Family := edtCodEmpresa.Font.Family;
  edtCodEmpresa.Canvas.Font.Size   := edtCodEmpresa.Font.Size;

  Case Key Of
    vkEnd  : linEmpresaCursor.Position.X := edtCodEmpresa.Canvas.TextWidth(String(edtCodEmpresa.Text).Replace(' ', '.')) + 2.5;
    vkHome : linEmpresaCursor.Position.X := 2.5;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(edtCodEmpresa.Text).Replace(' ', '.'), 1, (edtCodEmpresa.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(edtCodEmpresa.Text).Replace(' ', '.'), 1, (edtCodEmpresa.CaretPosition + 1))
      Else
        LText := Copy(String(edtCodEmpresa.Text).Replace(' ', '.'), 1, (edtCodEmpresa.CaretPosition));

      linEmpresaCursor.Position.X := edtCodEmpresa.Canvas.TextWidth(LText) + 2.5;
    End;
  End;
end;

procedure TfmxDashboardPrincipalOld.PiscaCursor;
begin
  linEmpresaCursor.Tag := 1;
end;

procedure TfmxDashboardPrincipalOld.tmrCursorTimer(Sender: TObject);
begin
  If (linEmpresaCursor.Tag = 0) Then
    linEmpresaCursor.Visible := False

  Else If (linEmpresaCursor.Tag = 1) Then
    linEmpresaCursor.Visible := Not linEmpresaCursor.Visible;
end;

function TfmxDashboardPrincipalOld.AbaFiliasOuNenhumaAba(Aba: TTabItem): Boolean;
begin
  Result := (Not Assigned(Aba));

  If (Not Result) Then
    Result := Aba = tabAbaFiliais;
end;

function TfmxDashboardPrincipalOld.AbaGerenteOuNenhumaAba(Aba: TTabItem): Boolean;
begin
  Result := (Not Assigned(Aba));

  If (Not Result) Then
    Result := Aba = tabAbaGerentes;
end;

function TfmxDashboardPrincipalOld.AbaLojaOuNenhumaAba(Aba: TTabItem): Boolean;
begin
  Result := (Not Assigned(Aba));

  If (Not Result) Then
    Result := Aba = tabAbaLoja;
end;

function TfmxDashboardPrincipalOld.AbaVendedoresOuNenhumaAba(
  Aba: TTabItem): Boolean;
begin
  Result := (Not Assigned(Aba));

  If (Not Result) Then
    Result := Aba = tabAbaVendedores;
end;

procedure TfmxDashboardPrincipalOld.AjustaAlturaDashboard(Aba: TTabItem = Nil);
Var
  Index : Integer;
begin
  If Aba = Nil Then
    Index := 0
  Else
    Index := Aba.Index;

  Case Index Of
    0: {ABA VENDEDOR}
    Begin
      tabDashboard.Height := layProjecoes.Height +
                             layProjecoes.Margins.Top +
                             layProjecoes.Margins.Bottom +
                             fraTotalVendedores.Height +
                             fraTotalVendedores.Margins.Top +
                             fraTotalVendedores.Margins.Bottom +
                             layVendasXMetas.Height +
                             layVendasXMetas.Margins.Top +
                             layVendasXMetas.Margins.Bottom +
                             layFormasClientes.Height +
                             layFormasClientes.Margins.Top +
                             layFormasClientes.Margins.Bottom +
                             layRodape.Height;

      layAbaVendedores.Height := tabDashboard.Height;
    End;

    1: {ABA GERENTE}
    Begin
      tabDashboard.Height := layProjecoesGerente.Height +
                             layProjecoesGerente.Margins.Top +
                             layProjecoesGerente.Margins.Bottom +
                             fraTotalVendedoresGer.Height +
                             fraTotalVendedoresGer.Margins.Top +
                             fraTotalVendedoresGer.Margins.Bottom +
                             fraVendasXMetasDiariasGer.Height +
                             fraVendasXMetasDiariasGer.Margins.Top +
                             fraVendasXMetasDiariasGer.Margins.Bottom;

      layAbaGerentes.Height := tabDashboard.Height;
    End;

    2: {ABA LOJA}
    Begin
      tabDashboard.Height := layProjecoesLoja.Height +
                             layProjecoesLoja.Margins.Top +
                             layProjecoesLoja.Margins.Bottom +
                             fraVendasXMetasDiariasLoj.Height +
                             fraVendasXMetasDiariasLoj.Margins.Top +
                             fraVendasXMetasDiariasLoj.Margins.Bottom +
                             fraConstrucaoMetaLoj.Height +
                             fraConstrucaoMetaLoj.Margins.Top +
                             fraConstrucaoMetaLoj.Margins.Bottom;

      layAbaLoja.Height := tabDashboard.Height;
    End;

    3: {ABA TODAS AS LOJAS}
    Begin
      tabDashboard.Height := fraFaturamentoXMetas.Height +
                             fraFaturamentoXMetas.Margins.Top +
                             fraFaturamentoXMetas.Margins.Bottom +
                             fraMargemXMetas.Height +
                             fraMargemXMetas.Margins.Top +
                             fraMargemXMetas.Margins.Bottom;

      layAbaFiliais.Height := tabDashboard.Height;
    End;

  End;
end;

procedure TfmxDashboardPrincipalOld.AjustaDashboardPeloOperador;
Var
  LTipOpe : String;
begin
  LTipOpe := objDash.fRetornaTipoOperador;

  {* VENDEDOR INTERNO *}
  {* REPRES. EXTERNO LOJA *}
  {* REPRES. EXTERNO DISTRIBUIDOR *}
  btnAbaVendedores.Visible := Pos(LTipOpe,'I_E_D_') > 0;
  tabAbaVendedores.Visible := Pos(LTipOpe,'I_E_D_') > 0;

  {* SUB-GERENTE *}
  {* GERENTE *}
  btnAbaGerentes.Visible   := Pos(LTipOpe,'G_S_') > 0;
  tabAbaGerentes.Visible   := Pos(LTipOpe,'G_S_') > 0;

  {* ADMINISTRATIVO *}
  btnAbaFiliais.Visible    := LTipOpe.Equals('A');
  tabAbaFiliais.Visible    := LTipOpe.Equals('A');

  {* ADMINISTRATIVO *}
  {* Aba Loja pode ser liberada para o GERENTE mediante direito de acesso *}
  If (btnAbaLoja.Tag = 1) Then
  Begin
    btnAbaLoja.Visible     := Pos(LTipOpe,'A_G_S_') > 0;
    tabAbaLoja.Visible     := Pos(LTipOpe,'A_G_S_') > 0;
  End
  Else
  Begin
    btnAbaLoja.Visible     := LTipOpe.Equals('A');
    tabAbaLoja.Visible     := LTipOpe.Equals('A');
  End;

  HabilitarAbaDefault(LTipOpe);
end;

procedure TfmxDashboardPrincipalOld.AtualizarGraficos;
Var
  LDataSelecionada: TDatetime;
  LTipoEmpresa    : String;
begin
  LDataSelecionada := EncodeDate(StrToInt(Copy(edtMesAno.Tag.ToString,1,4)),
                                 StrToInt(Copy(edtMesAno.Tag.ToString,5,2)),
                                 1);

  LTipoEmpresa := fraTipoEmpresa.strTipoEmpresa;

  objDash.pApagaTemporarias;

  If (fraDiasUteis.Tag = 1) Then
  Begin
    fraDiasUteis.AtualizaControleDiario(LDataSelecionada);
    fraDiasUteis.Tag := 0;
  End;

  {****************}
  {* ABA VENDEDOR *}
  {****************}
  If (tabDashboard.ActiveTab = tabAbaVendedores) And
     (tabAbaVendedores.Tag = 1) Then
  Begin
    layAbaVendedores.Visible := True;

    fraProjecaoVendas.AtualizaProjecaoDeFaturamento   (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'V');                             {* PROJEÇÃO DE VENDAS *}
    fraProjecaoMargem.AtualizaProjecaoDeMargem        (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, cbbCompCusto.Selected.Text, 'V'); {* PROJEÇÃO DE MARGEM *}
    fraTotalVendas.AtualizaTotalVendas                (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'V');                             {* TOTAL DE VENDAS *}
    fraPedidosNaoFaturados.AtualizaPedidosNaoFaturados(LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'V');                             {* PEDIDOS NÃO FATURADOS *}
    fraTotalVendedores.AtualizaTotalVendedores        (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'V');                             {* RESUMO VENDEDOR *}
    fraVendasXMetasDiarias.AtualizaVendasXMetas       (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'V');                             {* VENDAS X METAS (DIÁRIAS) *}
    fraTotalFormaPagamento.AtualizaTotalFormaPagamento(LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text);                                  {* FORMAS DE PAGAMENTO *}
    fraTopClientes.AtualizaTopClientes                (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text);                                  {* TOP 5 CLIENTES *}

    tabAbaVendedores.Tag := 0;
  End;

  {***************}
  {* ABA FILIAIS *}
  {***************}
  If (tabDashboard.ActiveTab = tabAbaFiliais) And
     (tabAbaFiliais.Tag = 1) Then
  Begin
    fraFaturamentoXMetas.layFaturamentoXMetas.Visible := False;
    fraMargemXMetas.layMargemXMetas.Visible           := False;
    layAbaFiliais.Visible := True;

    fraFaturamentoXMetas.AtualizaFaturamentoXMetas(LDataSelecionada, LTipoEmpresa);                                                    {* FATURAMENTO X METAS *}
    fraMargemXMetas.AtualizaMargemXMetas          (LDataSelecionada, LTipoEmpresa, cbbCompCusto.Selected.Text);                                  {* MARGEM X METAS *}

    tabAbaFiliais.Tag := 0;
  End;

  {****************}
  {* ABA GERENTES *}
  {****************}
  If (tabDashboard.ActiveTab = tabAbaGerentes) And
     (tabAbaGerentes.Tag = 1) Then
  Begin
    layAbaGerentes.Visible := True;

    fraProjecaoVendasGer.AtualizaProjecaoDeFaturamento   (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'G');                             {* PROJEÇÃO DE VENDAS *}
    fraProjecaoMargemGer.AtualizaProjecaoDeMargem        (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, cbbCompCusto.Selected.Text, 'G'); {* PROJEÇÃO DE MARGEM *}
    fraTotalVendasGer.AtualizaTotalVendas                (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'G');                             {* TOTAL DE VENDAS *}
    fraPedidosNaoFaturadosGer.AtualizaPedidosNaoFaturados(LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'G');                             {* PEDIDOS NÃO FATURADOS *}
    fraTotalVendedoresGer.AtualizaTotalVendedores        (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'G');                             {* RESUMO VENDEDOR *}
    fraVendasXMetasDiariasGer.AtualizaVendasXMetas       (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'G');                             {* VENDAS X METAS (DIÁRIAS) *}

    tabAbaGerentes.Tag := 0;
  End;

  {************}
  {* ABA LOJA *}
  {************}
  If (tabDashboard.ActiveTab = tabAbaLoja) And
     (tabAbaLoja.Tag = 1) Then
  Begin
    layAbaLoja.Visible := True;

    fraProjecaoVendasLoj.AtualizaProjecaoDeFaturamento   (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'L');                             {* PROJEÇÃO DE VENDAS *}
    fraProjecaoMargemLoj.AtualizaProjecaoDeMargem        (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, cbbCompCusto.Selected.Text, 'L'); {* PROJEÇÃO DE MARGEM *}
    fraTotalVendasLoj.AtualizaTotalVendas                (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'L');                             {* TOTAL DE VENDAS *}
    fraPedidosNaoFaturadosLoj.AtualizaPedidosNaoFaturados(LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'L');                             {* PEDIDOS NÃO FATURADOS *}
    fraVendasXMetasDiariasLoj.AtualizaVendasXMetas       (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text, 'L');                             {* VENDAS X METAS (DIÁRIAS) *}
    fraConstrucaoMetaLoj.AtualizaConstrucaoMeta          (LDataSelecionada, LTipoEmpresa, edtCodEmpresa.Text);                                  {* CONSTRUÇÃO DA META *}

    tabAbaLoja.Tag := 0;
  End;

  AjustaAlturaDashboard(tabDashboard.ActiveTab);
end;

procedure TfmxDashboardPrincipalOld.IniciaVariaveis;
Var
  LContador : Integer;
begin
  EsconderGraficos;

  layFiltros.Visible := objDash.MostrarFiltros;

  IF Assigned(objPrincipal) Then
    recComCusto.Enabled := objPrincipal.VerificaAcessoSistema('mnuFiltroComCus');

  AjustaDashboardPeloOperador;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassParent.ClassNameIs('TfraGraficoBase')) Then
      TfraGraficoBase(Self.Components[LContador]).objDash := objDash;
  End;

  fraDiasUteis.objDash   := objDash;
  fraTipoEmpresa.objDash := objDash;
  fraTipoEmpresa.CarregaDefault;
  fraTipoEmpresa.Visible := True;
  fraDiasUteis.Visible   := True;

  CarregaCompCusto;

  layAbas.Repaint;
end;

end.
