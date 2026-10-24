unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dxGDIPlusClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.Menus, cxButtons,
  Vcl.Samples.Gauges, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  untFuncoesTintaDeMaquinaBpl, untTipoTinta, untFuncoesDicionarios,
  dxSkinXmas2008Blue,untISetarParametros;

Type
  TDicionario = class(untFuncoesDicionarios.TDicionario)

  end;


type
  TPrincipal = class(TForm)
    pgcPrincipal: TPageControl;
    TabSheet1: TTabSheet;
    PnlPrincipal: TPanel;
    gpbImpostos: TGroupBox;
    ChkIpi: TCheckBox;
    chkICMS: TCheckBox;
    chkIcmsEfetivo: TCheckBox;
    chkFcp: TCheckBox;
    gpbConexao: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtEmpresa: TEdit;
    edtIP: TEdit;
    edtPorta: TEdit;
    edtbanco: TEdit;
    PnlProgresso: TPanel;
    pnlBotton: TPanel;
    btnExecutar: TcxButton;
    btnCancelar: TcxButton;
    btnSair: TcxButton;
    gProcesso: TGauge;
    CheckBox1: TCheckBox;
    TabSheet2: TTabSheet;
    memResumo: TRichEdit;
    Panel1: TPanel;
    gpbPeriodo: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtDtInicio: TcxDateEdit;
    edtDtFim: TcxDateEdit;
    GroupBox1: TGroupBox;
    lblProcessados: TLabel;
    lblProcessadosErros: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblProcessadosAcertos: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblProcessadosIgnorados: TLabel;
    lblProcessadosDuplicados: TLabel;
    Label12: TLabel;
    lblRegistros: TLabel;
    pnlMarDes: TPanel;
    chkMarDes: TCheckBox;
    Label13: TLabel;
    lblProcessamentoAtual: TLabel;
    ChkPrecoCusto: TCheckBox;
    chkMargemVenda: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure chkMarDesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function fValidarCampos(Var AMensagem : String) : Boolean;
    function fCarregarOpcoes : TStringList;
    function fValidarOpcoes : Boolean;

    procedure LimparResumoProcesso;
    procedure MostrarResumoProcesso;
    procedure SalvarResumoProcesso;
    procedure SaltarParaProximoCampo;
    function ValidarSeDeveSaltarProximoCampo: boolean;
    procedure SetarInformacoesIniciais;
    procedure MarcarDesmarcarTodosImpostosRegras;
    procedure PrepararTelaChamadaPeloJenkins;
    function RetornarDiretorioResumos: string;
    procedure CriarDiretorioResumos;
    procedure SalvarResumo;
    function ValidarCodigoEmpresaPreenchido: boolean;
    function ValidarChaveLogLigada: boolean;
    procedure FinalizarProcessoPorFaltaDeConexaoBanco;
    procedure InserirMensagemErroConexaoNoResumo;
    function RetornarNomeArquivoResumoEmpresa: string;
    function RetornarNomeArquivoResumoTXT: string;
    function RetornarDiretorioResumosEmpresas: string;
    procedure CriarDiretorioResumosEmpresa;
    procedure CriarDiretorioResumosComum;
    procedure SetarParametrosTelaChamadaPeloJenkins;

  public
    { Public declarations }
  Var
    fTipoTinta: function(strIdePro: String): TTipoTinta; stdcall;

    pSetaParametros: procedure (dicParametros    : TDicionario;
                                fGrvMovGer       : TfGravaMovGer;
                                fGrvMovDet       : TfGravaMovDet;
                                recModulos       : TRecModulosAutcom;
                                objTransf        : ITransferencias = nil;
                                objOrdPro        : IFatOrdProTintaMaquina = nil; intDebugH: Byte = 0;
                                objLibera        : ILiberacao = nil;
                                objExecSQL       : IExecutaSQLReplicacaoTinta = nil;
                                objLotePedWMS    : IFatDefineLotesPedidoWMS = nil;
                                objFuncoesCRM    : IFuncoesCRM = nil;
                                objFuncoesSaldos : IFuncoesSaldos = nil); stdcall;

  end;

var
  Principal: TPrincipal;

implementation

uses
  untModulo, untFuncoes, IdRexecServer, untGerarTesteUnitario;

{$R *.dfm}

function TPrincipal.fValidarCampos(Var AMensagem : String): Boolean;
begin
  Result := True;

  If ((FormatDateTime('dd/mm/yyyy', edtDtInicio.Date) = '00/00/0000') Or (edtDtInicio.Date = 0)) Or
   ((FormatDateTime('dd/mm/yyyy', edtDtFim.Date) = '00/00/0000') Or (edtDtFim.Date = 0)) Then
  Begin
    AMensagem := 'Por favor, preencher corretamente o período!';
    Result    := false;
  End
  else
  If (edtDtInicio.Date > edtDtFim.Date) Then
  begin
    AMensagem := 'Período inválido, a data inicial não pode ser maior que a data final!';
    Result    := false;
  end
  Else
  If Not fValidarOpcoes Then
  begin
    AMensagem := 'É necessário selecionar algum "Imposto/Regra" para continuar com o processo!';
    Result    := false;
  end;

end;

function TPrincipal.fValidarOpcoes: Boolean;
Var
  LCont : Integer;
begin
  Result := false;

  For LCont := 0 To Self.ComponentCount -1 Do
  begin
    If Self.Components[LCont] Is TCheckBox Then
    begin
      If (Self.Components[LCont] As TCheckBox).Checked Then
      begin
        Result := true;
      end;
    end;
  end;

end;

procedure TPrincipal.LimparResumoProcesso;
begin
  pgcPrincipal.ActivePageIndex := 0;
  memResumo.Clear;
  frmModulo.FResumo.Clear;
end;

procedure TPrincipal.MarcarDesmarcarTodosImpostosRegras;
var
  LContador: integer;
  LMarcar: boolean;
begin
  LMarcar := chkMarDes.Checked;

  for LContador := 0 to ComponentCount - 1 do
  Begin
    if not (Components[LContador] Is TCheckBox) then
      Continue;

    if (TCheckBox(Components[LContador]).parent <> gpbImpostos) then
      Continue;

    TCheckBox(Components[LContador]).Checked := LMarcar;
  End;
end;

procedure TPrincipal.MostrarResumoProcesso;
var
  i: integer;
begin
  for i := 0 to frmModulo.FResumo.Count - 1 do
    memResumo.Lines.Add(frmModulo.FResumo[i]);

  pgcPrincipal.ActivePageIndex := 1;
  memResumo.SelStart := 0;
end;

procedure TPrincipal.InserirMensagemErroConexaoNoResumo;
begin
  memResumo.Clear;
  memResumo.Lines.Add('*************************************************************');
  memResumo.Lines.Add('* NÃO FOI POSSÍVEL CONECTAR COM O BANCO DE DADOS DO CLIENTE *');
  memResumo.Lines.Add('*************************************************************');
end;

procedure TPrincipal.FinalizarProcessoPorFaltaDeConexaoBanco;
begin
  InserirMensagemErroConexaoNoResumo;
  SalvarResumoProcesso;
  Application.Terminate;
end;

procedure TPrincipal.SetarParametrosTelaChamadaPeloJenkins;
begin
  frmModulo.FChaveLogLigada := True;
  frmModulo.FCodEmp      := ParamStr(5);
  frmModulo.FNomeEmpresa := fRetornarNomeEmpresa(frmModulo.FCodEmp);
  edtDtInicio.Text       := ParamStr(6);
  edtDtFim.Text          := edtDtInicio.Text;
  //ChkIpi.Checked         := True;
  //chkICMS.Checked        := True;
  //chkIcmsEfetivo.Checked := True;
  chkFcp.Checked         := True;
  ChkPrecoCusto.Checked  := True;
  ExitCode := 0;
end;

procedure TPrincipal.PrepararTelaChamadaPeloJenkins;
begin
  if (not frmModulo.ExecutandoPeloJenkins) Then
    Exit;

  SetarParametrosTelaChamadaPeloJenkins;

  if (Not frmModulo.Database.Connected) then
  Begin
    FinalizarProcessoPorFaltaDeConexaoBanco;
    Exit;
  End;

  btnExecutar.Click;
  Application.Terminate;
end;

function TPrincipal.RetornarDiretorioResumos: string;
begin
  result := ExtractFilePath(Application.ExeName) + PATH + 'RESUMOS\';
end;

function TPrincipal.RetornarDiretorioResumosEmpresas: string;
begin
  result := ExtractFilePath(Application.ExeName) + PATH + 'RESUMOS\' + FormatDateTime('yyyy-mm-dd', strToDate(edtDtFim.Text)) + '\';
end;

function TPrincipal.RetornarNomeArquivoResumoTXT: string;
begin
  result := 'Resumo.txt';
end;

function TPrincipal.RetornarNomeArquivoResumoEmpresa: string;
begin
  result := 'Resumo_' + frmModulo.FNomeEmpresa + '_' + frmModulo.FCodEmp + '_' + FormatDateTime('ddmmyyyyhhmmss', Now) + '.txt';
end;

procedure TPrincipal.btnCancelarClick(Sender: TObject);
begin
  frmModulo.FPararProcessamento := True;
end;

procedure TPrincipal.SetarInformacoesIniciais;
begin
  frmModulo.FPararProcessamento := False;
  frmModulo.LabelRegistros(lblRegistros);
  frmModulo.LabelRegistrosProcessados(lblProcessados);
  frmModulo.LabelRegistrosProcessadosAcertos(lblProcessadosAcertos);
  frmModulo.LabelRegistrosProcessadosErros(lblProcessadosErros);
  frmModulo.LabelRegistrosProcessadosIgnorados(lblProcessadosIgnorados);
  frmModulo.LabelRegistrosProcessadosDuplicados(lblProcessadosDuplicados);
  frmModulo.LabelProcessamentoAtual(lblProcessamentoAtual);
end;

procedure TPrincipal.btnExecutarClick(Sender: TObject);
Var
  LMensagem           : String;
  GerarTesteUnitario  : TGerarTesteUnitario;
  LOpcoesTesteUnitario: TStringList;
  HandleDllTinta      : THandle;
  recModulos          : TRecModulosAutcom;
  dicParametros       : TDicionario;
begin

  untFuncoes.dicConfiguracoes.Limpar;

  If (chkIcmsEfetivo.Checked) Then
  begin
     Try
       HandleDllTinta    := untFuncoesTintaDeMaquinaBpl.RetornarAutcomTintaDll;

       fTipoTinta        := GetProcAddress(HandleDllTinta, PChar('fTipoTinta'));
       pSetaParametros   := GetProcAddress(HandleDllTinta, PChar('pSetaParametros'));

       recModulos.Banco := frmModulo.Database;

       dicParametros := TDicionario.Create;
       dicParametros['codemp'] := frmModulo.FCodEmp;
       dicParametros['usuariologado'] := 998;
       dicParametros['strHabilitarCRM'] := false;

       {$WARN SYMBOL_PLATFORM OFF}
       pSetaParametros(dicParametros,
                       Nil,
                       Nil,
                       recModulos,
                       Nil,
                       Nil,
                       0,
                       Nil,
                       Nil,
                       Nil,
                       Nil,
                       Nil);
       {$WARN SYMBOL_PLATFORM ON}

     except
       ShowMessage('Erro ao tentar carregar o AutcomTinta.DLL!!!');
     end;
  end;

  If Not fValidarCampos(LMensagem) Then
  Begin
    ShowMessage(LMensagem);
    Exit;
  End;

  LOpcoesTesteUnitario := fCarregarOpcoes;

  Try
    SetarInformacoesIniciais;
    LimparResumoProcesso;
    GerarTesteUnitario := TGerarTesteUnitario.Create;
    GerarTesteUnitario.pExecutarTesteUnitario(LOpcoesTesteUnitario, edtDtInicio.Date, edtDtFim.Date);

    if (Not frmModulo.Database.Connected) then
      FinalizarProcessoPorFaltaDeConexaoBanco;

    MostrarResumoProcesso;
    SalvarResumoProcesso;
  Finally
    FreeAndNil(GerarTesteUnitario);
    FreeAndNil(LOpcoesTesteUnitario);
  End;

end;

procedure TPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TPrincipal.chkMarDesClick(Sender: TObject);
begin
  MarcarDesmarcarTodosImpostosRegras;
end;

procedure TPrincipal.CriarDiretorioResumos;
begin
  CriarDiretorioResumosComum;
  CriarDiretorioResumosEmpresa;
end;

procedure TPrincipal.CriarDiretorioResumosComum;
var
  LDiretorio: string;
begin
  LDiretorio := RetornarDiretorioResumos;
  if (DirectoryExists(LDiretorio)) then
    Exit;

  ForceDirectories(LDiretorio);
end;

procedure TPrincipal.CriarDiretorioResumosEmpresa;
var
  LDiretorio: string;
begin
  LDiretorio := RetornarDiretorioResumosEmpresas;
  if (DirectoryExists(LDiretorio)) then
    Exit;

  ForceDirectories(LDiretorio);
end;

procedure TPrincipal.FormActivate(Sender: TObject);
begin
  PrepararTelaChamadaPeloJenkins;
end;

procedure TPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmModulo.FResumo);
end;

function TPrincipal.ValidarChaveLogLigada: boolean;
begin
  result := True;

  if (frmModulo.ExecutandoPeloJenkins) then
    Exit;

  If frmModulo.FChaveLogLigada Then
    Exit;

  ShowMessage('A Chave "EXEC_LOG_TESTE_UNITARIO_BPL" não está ligada no "opcoes.Ini"!');
  Result := False;
end;

function TPrincipal.ValidarCodigoEmpresaPreenchido: boolean;
begin
  result := True;

  if (frmModulo.ExecutandoPeloJenkins) then
    Exit;

  If not fEmptyStr(frmModulo.FCodEmp) Then
    Exit;

  ShowMessage('Informe o código da empresa no arquivo "opcoes.Ini"!');
  Result := False;
end;

function TPrincipal.ValidarSeDeveSaltarProximoCampo: boolean;
begin
  result := True;

  if (ActiveControl is TEdit) then
    Exit;

  if (ActiveControl is TcxCustomDropDownInnerEdit) then
    Exit;

  if (ActiveControl is TCheckBox) then
    Exit;

  result := False;
end;

procedure TPrincipal.SaltarParaProximoCampo;
begin
  if not ValidarSeDeveSaltarProximoCampo then
    Exit;

  SelectNext(ActiveControl, True, True);
end;

procedure TPrincipal.SalvarResumo;
var
  LDadosResumo: TStringList;
begin
  LDadosResumo := TStringList.Create;

  try
    Application.ProcessMessages;
    LDadosResumo.Add(memResumo.Text);
    LDadosResumo.SaveToFile(RetornarDiretorioResumosEmpresas + RetornarNomeArquivoResumoEmpresa);

    // salvar resumo.txt
    LDadosResumo.Clear;
    LDadosResumo.Add(memResumo.Text);
    LDadosResumo.SaveToFile(RetornarDiretorioResumos + RetornarNomeArquivoResumoTXT);
  finally
    FreeAndNil(LDadosResumo);
  end;
end;

procedure TPrincipal.SalvarResumoProcesso;
begin
  CriarDiretorioResumos;
  SalvarResumo;
end;

procedure TPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    SaltarParaProximoCampo;
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  frmModulo.FResumo      := TStringList.Create;
  LimparResumoProcesso;

  If not ValidarCodigoEmpresaPreenchido Then
  begin
    Application.Terminate;
    Exit;
  end;

  If not ValidarChaveLogLigada Then
  begin
    Application.Terminate;
    Exit;
  end;

  edtbanco.Text   := frmModulo.Database.Database;
  edtPorta.Text   := IntToStr(frmModulo.Database.Port);

  edtIP.Text             := frmModulo.Database.Server;
  frmModulo.FNomeEmpresa := fRetornarNomeEmpresa(frmModulo.FCodEmp);
  edtEmpresa.Text        := frmModulo.FNomeEmpresa;
  edtDtInicio.Text       := FormatDateTime('DD/MM/YYYY', Date);
  edtDtFim.Text          := edtDtInicio.Text;

  edtDtInicio.SetFocus;
end;

function TPrincipal.fCarregarOpcoes : TStringList;
Var
  LCont : Integer;
begin
  Result := TStringList.Create;

  For LCont := 0 To Self.ComponentCount -1 Do
  begin
    If Self.Components[LCont] Is TCheckBox Then
    begin
      If (Self.Components[LCont] As TCheckBox).Checked Then
      begin
        Result.Add(UpperCase(fTiraEspacos(fTiraCaracEspeciais((Self.Components[LCont] As TCheckBox).Caption))));
      end;

    end;

  end;

end;

end.
