unit Principal.View.FMXDashboard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Principal.View.Interfaces, Winapi.Windows,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMXTee.Engine, FMXTee.Series, FMX.Ani, FMXTee.Procs, FMXTee.Chart, FMX.Edit,
  System.Math, StrUtils, DateUtils, FMX.Filter.Effects, FMX.EditBox,
  FMX.SpinBox, FMX.ListBox, Shared.Functions.DataSet, Shared.Functions.Core,
  System.JSON, FMX.TabControl, FMX.Memo, IdComponent, IdHTTP, IdHashMessageDigest,
  System.NetEncoding, Principal.View.Frame.FMXDashDiasUteis,
  Principal.View.Frame.FMXDashTipoEmpresa, FMX.ComboEdit, FMX.TMSFNCTypes,
  FMX.TMSFNCUtils, FMX.TMSFNCGraphics, FMX.TMSFNCGraphicsTypes,
  FMX.TMSFNCCustomControl, FMX.TMSFNCWebBrowser, FMX.ScrollBox, TypInfo,
  System.ImageList, FMX.ImgList, FMX.MultiResBitmap, System.Actions,
  FMX.ActnList, FMX.Menus, IdException, IdExceptionCore, IdSSLOpenSSL, IdStack;

type
  TfmxDashboardPrincipal = class(TForm)
    layPrincipal: TLayout;
    recFundoCinza: TRectangle;
    btnFechar: TSpeedButton;
    imgFechar: TImage;
    scrBarraRolagem: TVertScrollBox;
    layPeriodo: TLayout;
    btnSetaEsquerda: TSpeedButton;
    patSetaEsquerda: TPath;
    btnSetaDireita: TSpeedButton;
    patSetaDireita: TPath;
    edtMesAno: TEdit;
    popMeses: TPopup;
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
    recFundoBrancoTopo: TRectangle;
    linRodape: TLine;
    btnAbaVendedores: TSpeedButton;
    recBotaoAbaVendedores: TRectangle;
    lblAbaVendedores: TLabel;
    layBotaoAbaVendedores: TLayout;
    imgAbaVendedores: TImage;
    fraDiasUteis: TframeDiasUteis;
    fraTipoEmpresa: TframeTipoEmpresa;
    layFiltros: TLayout;
    recBordasFiltros: TRectangle;
    lblEmpresa: TLabel;
    recEdtCodEmpresa: TRectangle;
    edtCodEmpresa: TEdit;
    linCodEmpresaCursor: TLine;
    btnFiltrar: TButton;
    layCentralizaFiltros: TLayout;
    recNomeEmpresa: TRectangle;
    lblNomeEmpresa: TLabel;
    tmrCursor: TTimer;
    lblCompCusto: TLabel;
    recComCusto: TRectangle;
    cbbCompCusto: TComboBox;
    btnAbaGerentes: TSpeedButton;
    recBotaoAbaGerentes: TRectangle;
    layBotaoAbaGerentes: TLayout;
    imgAbaGerentes: TImage;
    lblAbaGerentes: TLabel;
    layCentralizaTituloAbaGerentes: TLayout;
    btnAbaLoja: TSpeedButton;
    recBotaoAbaLoja: TRectangle;
    layBotaoAbaLoja: TLayout;
    layCentralizaTituloAbaLoja: TLayout;
    lblAbaLoja: TLabel;
    imgAbaLoja: TImage;
    btnAbaFiliais: TSpeedButton;
    recBotaoAbaFiliais: TRectangle;
    layBotaoAbaFiliais: TLayout;
    layCentralizaTituloAbaFiliais: TLayout;
    lblAbaFiliais: TLabel;
    imgAbaFiliais: TImage;
    webDash: TTMSFNCWebBrowser;
    btnAbaNova: TSpeedButton;
    recBotaoAbaNova: TRectangle;
    layBotaoAbaNova: TLayout;
    layCentralizaTituloAbaNova: TLayout;
    imgAbaNova: TImage;
    edtAbaNova: TEdit;
    linAbaNovaCursor: TLine;
    imglstAbas: TImageList;
    layAbas: TLayout;
    actAtalhos: TActionList;
    actNovaAba: TAction;
    popAbas: TPopupMenu;
    mnuEditar: TMenuItem;
    mnuDeletar: TMenuItem;
    btnAbaMeta: TSpeedButton;
    recBotaoAbaMeta: TRectangle;
    layBotaoAbaMeta: TLayout;
    layCentralizaTituloAbaMeta: TLayout;
    imgAbaMeta: TImage;
    lblAbaMeta: TLabel;
    recBloquear: TRectangle;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSetaEsquerdaClick(Sender: TObject);
    procedure btnSetaDireitaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtAnoChange(Sender: TObject);
    procedure edtMesAnoClick(Sender: TObject);
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
    procedure btnAbaFiliaisClick(Sender: TObject);
    procedure btnAbaNovaClick(Sender: TObject);
    procedure edtAbaNovaChangeTracking(Sender: TObject);
    procedure edtAbaNovaClick(Sender: TObject);
    procedure edtAbaNovaEnter(Sender: TObject);
    procedure edtAbaNovaExit(Sender: TObject);
    procedure edtAbaNovaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure actNovaAbaExecute(Sender: TObject);
    procedure btnAbaGerentesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure mnuDeletarClick(Sender: TObject);
    procedure mnuEditarClick(Sender: TObject);

  private
    { Private declarations }
    blnExecutarFormKeyDown : Boolean;
    strDestruirAbaNova : String;
    arrChaveDash : TArray<String>;

    procedure AtualizarGraficos(intAtalho, intChave: Integer; strTipVis: String);
    procedure BloquearMesesFuturos(Ano: Integer);

    function ExtrairUltimoDiaMesSelecionado: TDatetime;

    procedure EscondeCursor(Sender: TObject);
    procedure MoveCursor(Sender: TObject; Key: Word);
    procedure PiscaCursor(Sender: TObject);

    procedure ConsultaEmpresa;
    procedure CarregaCompCusto;

    function GetUTC(dt: TDateTime): TDateTime;
    function RetornaTimeStampEmMilisegundos: Int64;
    function RetornaChaveBasic(AClientID, AClientSecret: String): String;
    function GetMD5(const strTexto: string): string;
    function GetAuthorization: string;
    function GetJsonValue(AJson, APath: String): string;

    procedure GerarDashboardWeb(strJSONRel : String);
    procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);

    procedure WebBrowserNavigate(url: String);
    procedure WebBrowserLoading;

    function RetornaCursorDoEditFocado: TLine;

    function NovaAba(strTitulo, strNomeBotao: String): TSpeedButton;
    procedure ApagarAbaNova(Sender: TObject);
    procedure CarregaImagem(Imagem: TImage; Nome: String);

    function QtdeAbas: Integer;

    procedure HabilitarAbaSeNaoTiverNenhuma;
    procedure HabilitarAbaDefault(strTipOpe: String);
    procedure ClicarAbaDefault(strTipOpe: String);

    function ListaAbasNovas: TStringList;

    procedure CarregaAbas;

    function VerificaTrabalhaDiaFechamento: Boolean;

    function EmpresaValida:Boolean;

  public
    { Public declarations }
    objDash: IDashboard;
    blnUsuarioLogadoUtilizaModoClassico : boolean;

    procedure ModificaPeriodo(NumeroDeMeses:Integer);
    procedure ModificaPeriodoPorMesSelecionado(Mes, Ano: Integer);
    procedure IniciaVariaveis;
    procedure DesabilitarFuncoes(Aba: TTabItem = Nil);
    procedure HabilitarFuncoes;
    procedure AjustaDashboardPeloOperador;
    procedure HabilitarAbaNova(Botao: TSpeedButton);
    procedure DesabilitarAbaAtual(Botao: TSpeedButton);

    function MesAtualFoiSelecionado: Boolean;
    function MesAnoPorExtenso(Data:TDate; Abreviado: Boolean = False): String;
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

  ChaveAutorizacaoCitel = 'uLtr@-F!n&320147';

  URLDashboard = 'https://dashboard.citelsoftware.com.br';

var
  fmxDashboardPrincipal: TfmxDashboardPrincipal;

implementation

{$R *.fmx}

uses Principal.View.FMXConsultaEmpresa;

procedure TfmxDashboardPrincipal.BloquearMesesFuturos(Ano: Integer);
Var
  i, MesAtual: Integer;
  blnProximoMes: Boolean;
begin
  blnProximoMes := VerificaTrabalhaDiaFechamento;

  If (Ano >= edtAno.Max) Then
  Begin
    if (blnProximoMes) then
      MesAtual := MonthOf(IncMonth(Now, 1))
    else
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

procedure TfmxDashboardPrincipal.btnAbaFiliaisClick(Sender: TObject);
begin
  If (TSpeedButton(Sender).Tag = 0) Then
  Begin
    If Not EmpresaValida Then
      Exit;

    TSpeedButton(Sender).Tag := 1;

    webDash.Visible := True;

    DesabilitarFuncoes;

    HabilitarAbaNova(TSpeedButton(Sender));
    AtualizarGraficos(StrToInt(arrChaveDash[0]),
                      StrToInt(arrChaveDash[1]),
                      arrChaveDash[2]);

    HabilitarFuncoes;

    webDash.SetFocus;
  End;
end;

procedure TfmxDashboardPrincipal.btnAbaGerentesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  Posicao: TPoint;
begin
  If Button = TMouseButton.mbRight Then
    If (ContainsText(TSpeedButton(Sender).Name, 'AbaNova')) Then
    Begin
      GetCursorPos(Posicao);
      popAbas.TagString := TSpeedButton(Sender).Name;
      popAbas.Popup(Posicao.X, Posicao.Y);
    End;
end;

procedure TfmxDashboardPrincipal.btnAbaNovaClick(Sender: TObject);
Var
  newBtn : TSpeedButton;
begin
  btnAbaNova.Visible := False;
  newBtn := NovaAba('','');

  webDash.Visible := False;
  HabilitarAbaNova(newBtn);
  WebBrowserNavigate('about:blank');
end;

procedure TfmxDashboardPrincipal.btnAbaVendedoresMouseEnter(Sender: TObject);
Var
  LRecFundo : TRectangle;
begin
  LRecFundo := TRectangle(FindComponent('recBotao' + Copy(TSpeedButton(Sender).Name,4,30)));

  If LRecFundo.Visible Then
    TSpeedButton(Sender).Cursor := crDefault
  Else
    TSpeedButton(Sender).Cursor := crHandPoint;
end;

procedure TfmxDashboardPrincipal.btnAbaVendedoresMouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Cursor := crDefault;
end;

procedure TfmxDashboardPrincipal.btnFecharClick(Sender: TObject);
begin
  layPrincipal.Parent := Self;
  Self.Close;
end;

procedure TfmxDashboardPrincipal.btnFiltrarClick(Sender: TObject);
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  fraDiasUteis.Tag     := 1;

  AtualizarGraficos(StrToInt(arrChaveDash[0]),
                    StrToInt(arrChaveDash[1]),
                    arrChaveDash[2]);
  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipal.btnOkClick(Sender: TObject);
Var
  LNovaTagMesAno,
  LMes: Integer;
begin
  If Not EmpresaValida Then
    Exit;

  LMes := lstMeses.ItemIndex + 1;

  LNovaTagMesAno := StrToInt(edtAno.Text + FormatFloat('00',LMes));
  popMeses.IsOpen  := False;

  If (LNovaTagMesAno <> edtMesAno.Tag) Then
    ModificaPeriodoPorMesSelecionado(LMes, StrToInt(edtAno.Text));
end;

procedure TfmxDashboardPrincipal.btnSetaDireitaClick(Sender: TObject);
begin
  If btnSetaDireita.Visible Then
    ModificaPeriodo(+1);
end;

procedure TfmxDashboardPrincipal.btnSetaEsquerdaClick(Sender: TObject);
begin
  If btnSetaEsquerda.Visible Then
    ModificaPeriodo(-1);
end;

procedure TfmxDashboardPrincipal.CarregaAbas;
Var
  LAba : IAba;
  LButton : TSpeedButton;
begin
  If Assigned(objDash) Then
  Begin
    For LAba In objDash.Abas Do
    Begin
      If (LAba.Tipo = 'F') Then
      Begin
        LButton := TSpeedButton(FindComponent(LAba.NomeBotao));
        If Assigned(LButton) Then
          LButton.TagString := LAba.Atalho.ToString() + '_' +
                               LAba.Chave.ToString() + '_' +
                               LAba.TipoVisao;
    End;
//      Else
//        NovaAba(LAba.Titulo, LAba.NomeBotao);
  End;
  End;
end;

procedure TfmxDashboardPrincipal.CarregaCompCusto;
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

procedure TfmxDashboardPrincipal.CarregaImagem(Imagem: TImage; Nome: String);
Var
  LItemBMP: TCustomBitmapItem;
  LSize   : TSize;
begin
  if (imglstAbas.BitmapItemByName(Nome, LItemBMP, LSize)) Then
  Begin
    Imagem.Bitmap    := LItemBMP.MultiResBitmap.Bitmaps[1.0];
    Imagem.TagString := Nome;
  End;
end;

procedure TfmxDashboardPrincipal.cbbCompCustoEnter(Sender: TObject);
begin
  recComCusto.Stroke.Color := TAlphaColor($7F2A96FF);
end;

procedure TfmxDashboardPrincipal.cbbCompCustoExit(Sender: TObject);
begin
  recComCusto.Stroke.Color := TAlphaColor($FFCCCCCC);
end;

procedure TfmxDashboardPrincipal.cbbCompCustoKeyDown(Sender: TObject;
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

function TfmxDashboardPrincipal.NovaAba(strTitulo, strNomeBotao: String): TSpeedButton;
Var
  LButton      : TSpeedButton;
  LRectangle   : TRectangle;
  LLayoutBotao : TLayout;
  LImage       : TImage;
  LEdit        : TEdit;
  LLineCursor  : TLine;
  LNameNum     : Integer;
begin
  If strNomeBotao.IsEmpty Then
    LNameNum := QtdeAbas + 1
  Else
    LNameNum := StrToInt(Copy(strNomeBotao,11));

  LButton               := TSpeedButton.Create(Self);
  LButton.Name          := 'btnAbaNova' + IntToStr(LNameNum);
  LButton.GroupName     := 'Abas';
  LButton.StyleLookup   := 'btnAbaFiliaisStyle1';
  LButton.Parent        := layAbas;
  LButton.Text          := '';
  LButton.Height        := 38;
  LButton.Width         := 120;
  LButton.Margins.Right := 5;
  LButton.Tag           := 1;
  LButton.Position.X    := Screen.DesktopWidth;
  LButton.Align         := TAlignLayout.MostLeft;
  LButton.OnMouseEnter  := btnAbaVendedoresMouseEnter;
  LButton.OnMouseLeave  := btnAbaVendedoresMouseLeave;
  LButton.OnClick       := btnAbaFiliaisClick;
  LButton.OnMouseUp     := btnAbaGerentesMouseUp;

  LRectangle              := TRectangle.Create(Self);
  LRectangle.Name         := 'recBotaoAbaNova' + IntToStr(LNameNum);
  LRectangle.Align        := TAlignLayout.Contents;
  LRectangle.Parent       := LButton;
  LRectangle.Visible      := True;
  LRectangle.Stroke.Color := $FFD6D3D6;
  LRectangle.Fill.Color   := $FFE8E8E8;
  LRectangle.Corners      := [TCorner.TopLeft, TCorner.TopRight];
  LRectangle.XRadius      := 10;
  LRectangle.YRadius      := 10;
  LRectangle.Sides        := [TSide.Top, TSide.Left, TSide.Right];
  LRectangle.HitTest      := False;

  LLayoutBotao                := TLayout.Create(Self);
  LLayoutBotao.Name           := 'layBotaoAbaNova' + IntToStr(LNameNum);
  LLayoutBotao.Align          := TAlignLayout.Contents;
  LLayoutBotao.Parent         := LButton;
  LLayoutBotao.Margins.Bottom := 5;
  LLayoutBotao.Margins.Left   := 5;
  LLayoutBotao.Margins.Right  := 5;
  LLayoutBotao.Margins.Top    := 5;
  LLayoutBotao.Opacity        := 0.6;
  LLayoutBotao.HitTest        := False;

  LImage                := TImage.Create(Self);
  LImage.Name           := 'imgBotaoAbaNova' + IntToStr(LNameNum);
  LImage.Align          := TAlignLayout.MostLeft;
  LImage.HitTest        := False;
  LImage.Parent         := LLayoutBotao;
  LImage.Height         := 16;
  LImage.Width          := 16;
  LImage.Margins.Bottom := 6;
  LImage.Margins.Left   := 5;
  LImage.Margins.Right  := 5;
  LImage.Margins.Top    := 6;
  LImage.WrapMode       := TImageWrapMode.Center;
  LImage.HitTest        := False;

  if ((QtdeAbas mod 2) = 0) then
    CarregaImagem(LImage, 'GRAFICO')
  else
    CarregaImagem(LImage, 'GRAFICO2');

  LEdit                := TEdit.Create(Self);
  LEdit.Name           := 'edtBotaoAbaNova' + IntToStr(LNameNum);
  LEdit.Align          := TAlignLayout.Client;
  LEdit.HitTest        := False;
  LEdit.Parent         := LLayoutBotao;
  LEdit.Height         := 22;
  LEdit.Width          := 40;
  LEdit.Margins.Bottom := 3;
  LEdit.Margins.Left   := 0;
  LEdit.Margins.Right  := 5;
  LEdit.Margins.Top    := 3;
  LEdit.StyleLookup    := 'transparentedit';
  LEdit.StyledSettings := [];
  LEdit.Font.Family    := 'Segoe UI';
  LEdit.Font.Size      := 12;
  LEdit.Font.Style     := [TFontStyle.fsBold];

  LLineCursor            := TLine.Create(Self);
  LLineCursor.LineType   := TLineType.Left;
  LLineCursor.Name       := 'linBotaoAbaNova' + IntToStr(LNameNum) + 'Cursor';
  LLineCursor.Parent     := LEdit;
  LLineCursor.Height     := 16;
  LLineCursor.Position.X := 1;
  LLineCursor.Position.Y := 4;
  LLineCursor.Opacity    := 1;

  LEdit.OnChangeTracking := edtAbaNovaChangeTracking;
  LEdit.OnClick          := edtAbaNovaClick;
  LEdit.OnEnter          := edtAbaNovaEnter;
  LEdit.OnExit           := edtAbaNovaExit;
  LEdit.OnKeyDown        := edtAbaNovaKeyDown;

  If Not strTitulo.IsEmpty Then
  Begin
    LEdit.Text := strTitulo;
    edtAbaNovaChangeTracking(LEdit);
    edtAbaNovaExit(LEdit);
  End
  Else
    LEdit.SetFocus;

  Result := LButton;
end;

procedure TfmxDashboardPrincipal.ClicarAbaDefault(strTipOpe: String);
begin
  If btnAbaVendedores.Visible Then
    btnAbaFiliaisClick(btnAbaVendedores);

  If btnAbaGerentes.Visible Then
    btnAbaFiliaisClick(btnAbaGerentes);

  If btnAbaLoja.Visible And strTipOpe.Equals('A') Then
    btnAbaFiliaisClick(btnAbaLoja);
end;

procedure TfmxDashboardPrincipal.ConsultaEmpresa;
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

procedure TfmxDashboardPrincipal.DesabilitarAbaAtual(Botao: TSpeedButton);
Var
  LLayoutBotao : TLayout;
  LRectangle   : TRectangle;
  LContador    : Integer;
begin
  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TSpeedButton')) Then
      If (Self.Components[LContador].GetParentComponent.Name = 'layAbas') Then
        If (Self.Components[LContador] <> Botao) Then
          If (TSpeedButton(Self.Components[LContador]).Visible) Then
          Begin
            LLayoutBotao := TLayout(FindComponent('layBotao' + Copy(TSpeedButton(Self.Components[LContador]).Name,4,30)));
            LRectangle   := TRectangle(FindComponent('recBotao' + Copy(TSpeedButton(Self.Components[LContador]).Name, 4, 30)));

            LLayoutBotao.Opacity := 0.3;
            LRectangle.Visible   := False;

            TSpeedButton(Self.Components[LContador]).Tag := 0;
          End;
  End;

  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipal.DesabilitarFuncoes(Aba: TTabItem = Nil);
begin
  WebBrowserLoading;

  recBloquear.Visible     := True;
  layFiltros.Enabled      := False;

  btnFechar.Visible       := False;
  btnSetaEsquerda.Visible := False;
  btnSetaDireita.Visible  := False;

  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipal.edtAbaNovaChangeTracking(Sender: TObject);
Var
  LWidth : Single;
  LButton : TSpeedButton;
begin
  MoveCursor(Sender, vkRight);

  LWidth := 50 + TEdit(Sender).Canvas.TextWidth(TEdit(Sender).Text);
  LButton := TSpeedButton(FindComponent('btn' + Copy(TEdit(Sender).Name,9)));
  LButton.Width := LWidth;
end;

procedure TfmxDashboardPrincipal.edtAbaNovaClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxDashboardPrincipal.edtAbaNovaEnter(Sender: TObject);
begin
  PiscaCursor(Sender);
end;

procedure TfmxDashboardPrincipal.edtAbaNovaExit(Sender: TObject);
Var
  LButton : TSpeedButton;
begin
  EscondeCursor(Sender);
  TEdit(Sender).ReadOnly := True;
  btnAbaNova.Visible     := True;

  LButton           := TSpeedButton(FindComponent('btn' + Copy(TEdit(Sender).Name,9)));
//  LButton.Text      := TEdit(Sender).Text;
  LButton.TagString := RandomRange(100,999).ToString() + '_' +
                       RandomRange(10000,99999).ToString() + '_' +
                       'V';

  If TEdit(Sender).Text.IsEmpty Then
  Begin
    LButton.Visible    := False;
    strDestruirAbaNova := TEdit(Sender).Name;
  End;
end;

procedure TfmxDashboardPrincipal.edtAbaNovaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);

    vkReturn :
    Begin
      If TEdit(Sender).Text.IsEmpty Then
      Begin
        TEdit(Sender).SetFocus;
        Exit
      End
      Else
        webDash.SetFocus;
    End;

    vkEscape :
    Begin
      webDash.SetFocus;
      blnExecutarFormKeyDown := False;
    End;
  End;
end;

procedure TfmxDashboardPrincipal.edtAnoChange(Sender: TObject);
begin
  BloquearMesesFuturos(Round(edtAno.Value));
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaChange(Sender: TObject);
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
    MoveCursor(Sender, vkEnd);

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

procedure TfmxDashboardPrincipal.edtCodEmpresaChangeTracking(Sender: TObject);
begin
  MoveCursor(Sender, vkRight);
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaEnter(Sender: TObject);
begin
  MoveCursor(Sender, vkEnd);
  PiscaCursor(Sender);
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaExit(Sender: TObject);
begin
  If (TEdit(Sender).Text <> EmptyStr) Then
    TEdit(Sender).Text := FormatFloat('000',StrToInt(TEdit(Sender).Text));

  EscondeCursor(Sender);
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If (KeyChar = '/') Then
    ConsultaEmpresa;

  If (edtCodEmpresa.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);
    End;
  End;
end;

procedure TfmxDashboardPrincipal.edtCodEmpresaKeyUp(Sender: TObject;
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

procedure TfmxDashboardPrincipal.edtMesAnoClick(Sender: TObject);
begin
  edtAno.Text        := RightStr(edtMesAno.Text,4);
  edtAno.Max         := YearOf(Now);

  BloquearMesesFuturos(StrToInt(edtAno.Text));

  lstMeses.ItemIndex := StrToInt(Copy(IntToStr(edtMesAno.Tag),5,2))-1;

  popMeses.Width       := edtMesAno.Width;
  popMeses.IsOpen      := True;
end;

function TfmxDashboardPrincipal.EmpresaValida: Boolean;
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

procedure TfmxDashboardPrincipal.EscondeCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Visible := False;
  LCursor.Tag := 0;
end;

function TfmxDashboardPrincipal.ExtrairUltimoDiaMesSelecionado: TDatetime;
Var
  Mes, Ano,
  UltimoDiaMes: String;
begin
  Mes          := Copy(IntToStr(edtMesAno.Tag), 5, 2);
  Ano          := Copy(IntToStr(edtMesAno.Tag), 1, 4);
  UltimoDiaMes := IntToStr(DaysInAMonth(StrToInt(Ano), StrToInt(Mes)));

  Result := EncodeDate(Ano.ToInteger, Mes.ToInteger, UltimoDiaMes.ToInteger);
end;

procedure TfmxDashboardPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  lstAbasNovas : TStringList;
begin
  Action := TCloseAction.caFree;

  If Assigned(objDash) Then
  Begin
    lstAbasNovas := ListaAbasNovas;

    objDash.SalvarAbasNovas(lstAbasNovas);
    objDash.ApagaTemporarias;

    lstAbasNovas.Free;
  End;

  Self.Tag := 0;
end;

procedure TfmxDashboardPrincipal.FormCreate(Sender: TObject);
begin
  strDestruirAbaNova := '';

  tmrCursor.Enabled := True;
  EscondeCursor(edtCodEmpresa);
  EscondeCursor(edtAbaNova);

  btnAbaNova.Width := 50;

  fraDiasUteis.Tag   := 1;
  layFiltros.Visible := False;
  WebBrowserLoading;

  blnExecutarFormKeyDown := True;
  btnAbaNova.Visible := False;

  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape:
    Begin
      If blnExecutarFormKeyDown Then
        Self.Close
      Else
        blnExecutarFormKeyDown := True;
    End;
  End;
end;

procedure TfmxDashboardPrincipal.FormShow(Sender: TObject);
begin
  inherited;

  IniciaVariaveis;
  ModificaPeriodo(0);

  edtCodEmpresa.SetFocus;
end;

procedure TfmxDashboardPrincipal.fraTipoEmpresarecFaturamentoMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LTipoEmpAtual: String;
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  LTipoEmpAtual := fraTipoEmpresa.strTipoEmpresa;

  fraTipoEmpresa.recFaturamentoMouseUp(Sender, Button, Shift, X, Y);

  If (LTipoEmpAtual <> fraTipoEmpresa.strTipoEmpresa) Then
    AtualizarGraficos(StrToInt(arrChaveDash[0]),
                      StrToInt(arrChaveDash[1]),
                      arrChaveDash[2]);

  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipal.fraTipoEmpresarecOrigemMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LTipoEmpAtual: String;
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  LTipoEmpAtual := fraTipoEmpresa.strTipoEmpresa;

  fraTipoEmpresa.recOrigemMouseUp(Sender, Button, Shift, X, Y);

  If (LTipoEmpAtual <> fraTipoEmpresa.strTipoEmpresa) Then
    AtualizarGraficos(StrToInt(arrChaveDash[0]),
                      StrToInt(arrChaveDash[1]),
                      arrChaveDash[2]);

  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipal.GerarDashboardWeb(strJSONRel : String);
var
  LRequisicao: TIdHTTP;
  LParametros: TStringStream;
  LRespostaRequisicao: string;
  LURL: string;
begin
  LRequisicao := TIdHTTP.Create(nil);
  LParametros := nil;

  try
    LURL := URLDashboard + '/api/dashboard';

    LRequisicao.ConnectTimeout      := 15000; // 15 segundos para conectar
    LRequisicao.ReadTimeout         := 30000; // 30 segundos para aguardar resposta
    LRequisicao.Request.Connection  := 'close';
    LRequisicao.Request.ContentType := 'application/json';
    LRequisicao.OnWork              := OnWork;
    LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
    LRequisicao.HandleRedirects     := True;

    LRequisicao.Request.CustomHeaders.Clear;
    LRequisicao.Request.CustomHeaders.AddValue('Authorization', GetAuthorization);

    LParametros := TStringStream.Create(Trim(strJSONRel), TEncoding.UTF8);

    try
      LRespostaRequisicao := LRequisicao.Post(LURL, LParametros);
    except
      on E: EIdConnectTimeout do
        raise Exception.Create(
          'Não foi possível conectar ao servidor do dashboard dentro do tempo limite.' + sLineBreak +
          'Verifique internet, firewall, DNS ou se o servidor está online.' + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdReadTimeout do
        raise Exception.Create(
          'O servidor do dashboard demorou muito para responder.' + sLineBreak +
          'Tente novamente em alguns instantes.' + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdSocketError do
        raise Exception.Create(
          'Erro de conexão com o servidor do dashboard.' + sLineBreak +
          E.Message + sLineBreak + sLineBreak +
          'URL: ' + LURL);

      on E: EIdHTTPProtocolException do
        raise Exception.Create(
          'O servidor do dashboard retornou erro HTTP ' + IntToStr(E.ErrorCode) + '.' + sLineBreak +
          E.ErrorMessage);

      on E: Exception do
        raise;
    end;

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' + LRespostaRequisicao);

    WebBrowserNavigate(URLDashboard + GetJsonValue(LRespostaRequisicao, 'location'));

  finally
    FreeAndNil(LParametros);
    FreeAndNil(LRequisicao);
  end;
end;

function TfmxDashboardPrincipal.GetAuthorization: string;
var
  LTimeStampRequisicao: string;
begin
  LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;
  Result := RetornaChaveBasic(LTimeStampRequisicao, GetMD5(LTimeStampRequisicao + ChaveAutorizacaoCitel));
end;

function TfmxDashboardPrincipal.GetJsonValue(AJson, APath: String): string;
var
  LObj: TJSONValue;
begin
  LObj := TJSONObject.ParseJSONValue(AJson);
  if not Assigned(LObj) then
    raise Exception.Create('Resposta do servidor não é um JSON válido. Caminho esperado: "' + APath + '"');
  try
    Result := LObj.GetValue<string>(APath);
  finally
    FreeAndNil(LObj);  // libera em todos os caminhos (sucesso e exce?)
  end;
end;

function TfmxDashboardPrincipal.GetMD5(const strTexto: string): string;
  var
    idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

function TfmxDashboardPrincipal.GetUTC(dt: TDateTime): TDateTime;
begin
  Result := TTimeZone.Local.ToUniversalTime(dt);
end;

procedure TfmxDashboardPrincipal.HabilitarAbaSeNaoTiverNenhuma;
Var
  LContador : Integer;
  TemAbaHabilitada : Boolean;
begin
  TemAbaHabilitada := False;

  For LContador := 0 to Self.ComponentCount - 1 do
    If (Self.Components[LContador].ClassNameIs('TSpeedButton')) Then
      If (TSpeedButton(Self.Components[LContador]).GroupName = 'Abas') Then
        If (TSpeedButton(Self.Components[LContador]).Tag = 1) Then
        Begin
          TemAbaHabilitada := True;
          Break;
        End;

  If Not TemAbaHabilitada Then
    ClicarAbaDefault(objDash.fRetornaTipoOperador);
end;

procedure TfmxDashboardPrincipal.HabilitarAbaDefault(strTipOpe: String);
begin
  If btnAbaVendedores.Visible Then
    HabilitarAbaNova(btnAbaVendedores);

  If btnAbaGerentes.Visible Then
    HabilitarAbaNova(btnAbaGerentes);

  If btnAbaLoja.Visible And strTipOpe.Equals('A') Then
    HabilitarAbaNova(btnAbaLoja);
end;

procedure TfmxDashboardPrincipal.HabilitarAbaNova(Botao: TSpeedButton);
Var
  LLayoutBotao : TLayout;
  LRectangle : TRectangle;
begin
  DesabilitarAbaAtual(Botao);

  LLayoutBotao := TLayout(FindComponent('layBotao' + Copy(Botao.Name,4,30)));
  LRectangle   := TRectangle(FindComponent('recBotao' + Copy(Botao.Name,4,30)));

  LLayoutBotao.Opacity     := 0.6;
  LRectangle.Visible       := True;

  If Not Botao.TagString.IsEmpty Then
    arrChaveDash := Botao.TagString.Split(['_']);

  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipal.HabilitarFuncoes;
begin
  recBloquear.Visible     := False;
  layFiltros.Enabled      := True;

  btnFechar.Visible       := True;
  btnSetaEsquerda.Visible := True;
  btnSetaDireita.Visible  := Not MesAtualFoiSelecionado;

  edtCodEmpresa.SetFocus;

  Application.ProcessMessages;
end;

function TfmxDashboardPrincipal.MesAnoPorExtenso(Data: TDate;
  Abreviado: Boolean): String;
Var
  Mes, Ano: Integer;
begin
  Mes := MonthOf(Data);
  Ano := YearOf(Data);

  Case Mes Of
    1 : Result := 'Janeiro';
    2 : Result := 'Fevereiro';
    3 : Result := 'Março';
    4 : Result := 'Abril';
    5 : Result := 'Maio';
    6 : Result := 'Junho';
    7 : Result := 'Julho';
    8 : Result := 'Agosto';
    9 : Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  End;

  If Abreviado Then
    // Jan/20
    Result := Copy(Result,1,3) + '/' + Copy(IntToStr(Ano),3,2)
  Else
    // Janeiro de 2020
    Result := Result + ' de ' + IntToStr(Ano);
end;

function TfmxDashboardPrincipal.MesAtualFoiSelecionado: Boolean;
Var
  LMesAtual,
  LMesSelecionado: String;
  DataAtual: TDate;
begin
  DataAtual := Now;

  if VerificaTrabalhaDiaFechamento then
  Begin
    DataAtual := IncMonth(Now, 1);
  End;

  LMesAtual       := IntToStr(MonthOf(DataAtual)) + '/' + IntToStr(YearOf(DataAtual));
  LMesSelecionado := IntToStr(MonthOf(ExtrairUltimoDiaMesSelecionado)) + '/' + IntToStr(YearOf(ExtrairUltimoDiaMesSelecionado));

  Result := SameText(LMesAtual, LMesSelecionado);
end;

procedure TfmxDashboardPrincipal.mnuDeletarClick(Sender: TObject);
Var
  LButton : TSpeedButton;
begin
  LButton := TSpeedButton(FindComponent(popAbas.TagString));

  If Assigned(LButton) Then
    ApagarAbaNova(LButton);
end;

procedure TfmxDashboardPrincipal.mnuEditarClick(Sender: TObject);
Var
  LButton : TSpeedButton;
  LEdit : TEdit;
begin
  LButton := TSpeedButton(FindComponent(popAbas.TagString));
  LEdit   := TEdit(FindComponent('edtBotao' + Copy(popAbas.TagString,4,30)));

  If Assigned(LButton) And Assigned(LEdit) Then
  Begin
    if (LButton.Tag = 1) Then
    Begin
      LEdit.ReadOnly := False;
      LEdit.SelectAll;
      LEdit.SetFocus;
    End;
  End;
end;

procedure TfmxDashboardPrincipal.ModificaPeriodo(NumeroDeMeses:Integer);
Var
  Mes, Ano : String;
  DataAtual,NovaData: TDate;
  blnProximoMes : Boolean;
begin
  If Not EmpresaValida Then
    Exit;

  DesabilitarFuncoes;

  blnProximoMes := VerificaTrabalhaDiaFechamento;

  If (NumeroDeMeses = 0) Then
  Begin
    if (blnProximoMes) then
      NovaData     := IncMonth(Now, 1)
    else
    NovaData       := Now;
    edtMesAno.Tag  := StrToInt(IntToStr(YearOf(NovaData)) + FormatFloat('00',MonthOf(NovaData)));
    edtMesAno.Text := MesAnoPorExtenso(NovaData);

    btnSetaDireita.Visible := False;
  End
  Else
  Begin
    Mes := Copy(IntToStr(edtMesAno.Tag), 5, 2);
    Ano := Copy(IntToStr(edtMesAno.Tag), 1, 4);

    DataAtual := StrToDate('01/' + Mes + '/' + Ano);
    NovaData  := IncMonth(DataAtual, NumeroDeMeses);

    edtMesAno.Tag  := StrToInt(IntToStr(YearOf(NovaData)) + FormatFloat('00',MonthOf(NovaData)));
    edtMesAno.Text := MesAnoPorExtenso(NovaData);
  End;

  fraDiasUteis.Tag := 1;

  AtualizarGraficos(StrToInt(arrChaveDash[0]),
                    StrToInt(arrChaveDash[1]),
                    arrChaveDash[2]);
  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipal.ModificaPeriodoPorMesSelecionado(Mes, Ano: Integer);
Var
  NovaData: TDate;
begin
  DesabilitarFuncoes;

  NovaData := StrToDate('01/' + IntToStr(Mes) + '/' + IntToStr(Ano));

  edtMesAno.Tag  := StrToInt(IntToStr(Ano) + FormatFloat('00',Mes));
  edtMesAno.Text := MesAnoPorExtenso(NovaData);

  fraDiasUteis.Tag     := 1;

  AtualizarGraficos(StrToInt(arrChaveDash[0]),
                    StrToInt(arrChaveDash[1]),
                    arrChaveDash[2]);

  HabilitarFuncoes;
end;

procedure TfmxDashboardPrincipal.MoveCursor(Sender: TObject; Key: Word);
Var
  LText: String;
  LEdit: TEdit;
  LCursor: TLine;
  LFatorAjuste: Double;
begin
  LEdit   := TEdit(Sender);
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LFatorAjuste := 2.5;

  LEdit.Canvas.Font.Family := LEdit.Font.Family;
  LEdit.Canvas.Font.Size   := LEdit.Font.Size;
  LEdit.Canvas.Font.Style  := LEdit.Font.Style;

  PiscaCursor(LEdit);

  Case Key Of
    vkEnd  : LCursor.Position.X := LEdit.Canvas.TextWidth(LEdit.Text) + LFatorAjuste;
    vkHome : LCursor.Position.X := LFatorAjuste;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition + 1))
      Else
        LText := Copy(LEdit.Text, 1, (LEdit.CaretPosition));

      If (RightStr(LText, 1) = ' ') Then
        LText := Copy(LText, 1, LText.Length - 1) + '.';

      LCursor.Position.X := LEdit.Canvas.TextWidth(LText) + LFatorAjuste;
    End;
  End;
end;

procedure TfmxDashboardPrincipal.OnWork(Sender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

procedure TfmxDashboardPrincipal.PiscaCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Tag := 1;
end;

function TfmxDashboardPrincipal.QtdeAbas: Integer;
Var
  LContador, LBotoes : Integer;
begin
  LBotoes := 0;

  For LContador := 0 to Self.ComponentCount - 1 do
    If (Self.Components[LContador].ClassNameIs('TSpeedButton')) Then
      If (TSpeedButton(Self.Components[LContador]).GroupName = 'Abas') Then
        Inc(LBotoes);

  Result := LBotoes;
end;

function TfmxDashboardPrincipal.RetornaChaveBasic(AClientID,
  AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;
end;

function TfmxDashboardPrincipal.RetornaCursorDoEditFocado: TLine;
Var
  LContador: Integer;
begin
  Result := Nil;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TEdit')) Then
      If (TEdit(Self.Components[LContador]).IsFocused) Then
        Result := TLine(FindComponent('lin' + Copy(TEdit(Self.Components[LContador]).Name,4,20) + 'Cursor'));
  End;
end;

function TfmxDashboardPrincipal.RetornaTimeStampEmMilisegundos: Int64;
var
  LDateTime: TDateTime;

  LDataServidor,
  LHoraServidor: TDateTime;
begin
  Try
    raise Exception.Create('Se conexao com banco de dados ...');

    LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                 EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));
    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  Except
    Result := MilliSecondsBetween(GetUTC(System.SysUtils.Now), UnixDateDelta);
  End;
end;

procedure TfmxDashboardPrincipal.tmrCursorTimer(Sender: TObject);
Var
  LCursor: TLine;
  LEdit : TEdit;
begin
  LCursor := RetornaCursorDoEditFocado;

  If Assigned(LCursor) Then
  Begin
    If (LCursor.Tag = 0) Then
      LCursor.Visible := False

    Else If (LCursor.Tag = 1) Then
      LCursor.Visible := Not LCursor.Visible;
  End;

  If Not (strDestruirAbaNova.IsEmpty) Then
  Begin
    LEdit := TEdit(FindComponent(strDestruirAbaNova));

    strDestruirAbaNova := '';

    If Assigned(LEdit) Then
      ApagarAbaNova(LEdit);
  End;
end;

procedure TfmxDashboardPrincipal.WebBrowserLoading;
begin
  WebBrowserNavigate('https://dashboard.citelsoftware.com.br/loading.html');
end;

procedure TfmxDashboardPrincipal.WebBrowserNavigate(url: String);
begin
  webDash.BeginUpdate;
  webDash.URL := url;
  webDash.Navigate;
  webDash.EndUpdate;
end;

procedure TfmxDashboardPrincipal.actNovaAbaExecute(Sender: TObject);
begin
  If (btnAbaNova.Visible) Then
    btnAbaNovaClick(btnAbaNova);
end;

procedure TfmxDashboardPrincipal.AjustaDashboardPeloOperador;
Var
  LTipOpe : String;
begin
  LTipOpe := objDash.fRetornaTipoOperador;

  {* SUB-GERENTE *}
  {* GERENTE *}
  btnAbaGerentes.Visible := Pos(LTipOpe,'G_S_') > 0;

  {* ADMINISTRATIVO *}
  btnAbaFiliais.Visible := LTipOpe.Equals('A');

  {* ADMINISTRATIVO *}
  {* Aba Loja pode ser liberada para o GERENTE mediante direito de acesso *}
  If (btnAbaLoja.Tag = 1) Then
    btnAbaLoja.Visible := Pos(LTipOpe,'A_G_S_') > 0
  Else
    btnAbaLoja.Visible := LTipOpe.Equals('A');

  {* VENDEDOR INTERNO *}
  {* REPRES. EXTERNO LOJA *}
  {* REPRES. EXTERNO DISTRIBUIDOR *}
  btnAbaVendedores.Visible := Pos(LTipOpe,'A_G_S_') <= 0;

  btnAbaMeta.Visible := True;

  HabilitarAbaDefault(LTipOpe);
 end;

procedure TfmxDashboardPrincipal.ApagarAbaNova(Sender: TObject);
Var
  LButton      : TSpeedButton;
  LRectangle   : TRectangle;
  LLayoutBotao : TLayout;
  LImage       : TImage;
  LEdit        : TEdit;
  LLineCursor  : TLine;
begin
  LEdit        := TEdit(Sender);
  LButton      := TSpeedButton(FindComponent('btn' + Copy(LEdit.Name,9)));
  LRectangle   := TRectangle(FindComponent('recBotao' + Copy(LEdit.Name,4,30)));
  LLayoutBotao := TLayout(FindComponent('layBotao' + Copy(LEdit.Name,4,30)));
  LImage       := TImage(FindComponent('imgBotao' + Copy(LEdit.Name,4,30)));
  LLineCursor  := TLine(FindComponent('linBotao' + Copy(LEdit.Name,4,30)));

  Try
    LLineCursor.Free;
    LImage.Free;
    LEdit.Free;
    LLayoutBotao.Free;
    LRectangle.Free;
    LButton.Free;
  Except
//    On E: Exception Do
//      Showmessage(E.Message);
  End;

  HabilitarAbaSeNaoTiverNenhuma;
end;

procedure TfmxDashboardPrincipal.AtualizarGraficos(intAtalho, intChave: Integer; strTipVis: String);
Var
  LDataSelecionada: TDatetime;
  LTipoEmpresa,
  LJSONRel : String;
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

  LJSONRel := objDash.RetornaJsonEditorDashBoard(intAtalho, intChave,
                                                ['DTAFIN', 'CODOPE', 'CODEMP', 'RDGEMP', 'TIPVIS', 'VS_FLTPRECUS'],
                                                [DateToStr(LDataSelecionada), objDash.OperadorLogado, edtCodEmpresa.Text, LTipoEmpresa, strTipVis, cbbCompCusto.Selected.Text],
                                                False);

  GerarDashboardWeb(LJSONRel);
end;

procedure TfmxDashboardPrincipal.IniciaVariaveis;
begin
  CarregaAbas;
  layFiltros.Visible := objDash.MostrarFiltros;

  AjustaDashboardPeloOperador;

  fraDiasUteis.objDash   := objDash;
  fraTipoEmpresa.objDash := objDash;
  fraTipoEmpresa.CarregaDefault;
  fraTipoEmpresa.Visible := True;
  fraDiasUteis.Visible   := True;

  CarregaCompCusto;

  layAbas.Repaint;
end;

function TfmxDashboardPrincipal.ListaAbasNovas: TStringList;
Var
  LContador : Integer;
  LEdit : TEdit;
begin
  Result := TStringList.Create;
  Result.Clear;

  For LContador := 0 to Self.ComponentCount - 1 do
    If ((Self.Components[LContador].ClassNameIs('TSpeedButton')) And (TSpeedButton(Self.Components[LContador]).GroupName = 'Abas')) Then
      If (ContainsText(TSpeedButton(Self.Components[LContador]).Name, 'AbaNova')) Then
      Begin
        LEdit := TEdit(FindComponent('edtBotao' + Copy(TSpeedButton(Self.Components[LContador]).Name,4,30)));

        If Assigned(LEdit) Then
          Result.Add(LEdit.Text + '|' +
                     TSpeedButton(Self.Components[LContador]).Name + '|' +
                     Copy(TSpeedButton(Self.Components[LContador]).TagString,1,3) + '|' +
                     Copy(TSpeedButton(Self.Components[LContador]).TagString,5,5) + '|' +
                     'V');
      End;
end;

Function TfmxDashboardPrincipal.VerificaTrabalhaDiaFechamento: Boolean;
Var
  blnUsarUltimoDiaFechamento: Boolean;
  intUltimoDiaFechamento: Integer;
Begin
  Result := False;

  try
    blnUsarUltimoDiaFechamento := (objDash.CfgSis('USAUDF') = 'S');
    intUltimoDiaFechamento := objDash.CfgSis('UDFDAS');

    if (blnUsarUltimoDiaFechamento) and
       (intUltimoDiaFechamento > 0) and
       (DayOf(Now) > intUltimoDiaFechamento) then
    Begin
      Result := True;
    End;
  Except
    Result := False;
  end;

End;

end.
