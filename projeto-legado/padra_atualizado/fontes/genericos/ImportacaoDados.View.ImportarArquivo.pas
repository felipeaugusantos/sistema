unit ImportacaoDados.View.ImportarArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls,
  EditFocus, cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, cxProgressBar, ImportacaoDados.Interfaces,
  ImportacaoDados.Model.ModeloFactory,
  ImportacaoDados.Controller.ImportarCadastroProspecto,
  ImportacaoDados.Controller.ImportarItemFatVenda,
  ImportacaoDados.Controller.ImportarCadLocEqu;

type
  TfrmImportaArquivoCadastro = class(TfrmPaiConfirma)
    lblNomeArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    llModeloArquivo: TLabel;
    edtModeloImportacao: TEditFocus;
    btnSelecionarModelo: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSelecionarModeloClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    ObjImportaPlanilha: IImportaPlanilha;
    ObjModeloArquivo  : IModeloArquivoImportacao;
    FOperacaoCancelada : Boolean;
    function fConfirmar: Boolean;
    procedure pSelecionarModelo;
    function fAbrirTelaInconsistenciasProspecto: Boolean;
    function fAbrirTelaInconsistenciasItemFatVnd: Boolean;
    function fAbrirTelaInconsistenciasCadLocEqu: Boolean;
    procedure pCancelarImportacao(Sender: TObject; var Key: Word; Shift: TShiftState);
    function fCancelouOperacao : Boolean;
  public
    { Public declarations }
    TipoArquivo: TTipoImportacaoArquivo;
    class procedure pAbreTelaImportacaoArquivo(const aTipo: TTipoImportacaoArquivo);
    class function fAbreTelaImportacaoArquivo(Const aTipo: TTipoImportacaoArquivo; var ObjImportaPlanilhaExt : IImportaPlanilha) : Boolean;
    function fProcessarArquivo(pgbStatus: TcxProgressBar = Nil): Boolean;
  end;

var
  frmImportaArquivoCadastro: TfrmImportaArquivoCadastro;

implementation

uses
  untFuncoesSimples, ImportacaoDados.View.ModeloArquivo,  untGravando,
  ImportacaoDados.Model.CadastroProspecto, ImportacaoDados.View.InconsistenciasProspecto,
  ImportacaoDados.Model.ItemFatVenda, ImportacaoDados.View.InconsistenciasItemFatVenda,
  ImportacaoDados.Model.CadLocEqu, ImportacaoDados.View.InconsistenciasCadLocEqu;

{$R *.dfm}

procedure TfrmImportaArquivoCadastro.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FOperacaoCancelada := False;
  If Not (fConfirmar) then
    ModalResult := mrNone;      
end;

procedure TfrmImportaArquivoCadastro.btnHlpImpClick(Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportaArquivoCadastro.btnSelecionarModeloClick(Sender: TObject);
begin
  inherited;
  pSelecionarModelo;
end;

class procedure TfrmImportaArquivoCadastro.pAbreTelaImportacaoArquivo(Const aTipo: TTipoImportacaoArquivo);
var
  frmImportaArquivo: TfrmImportaArquivoCadastro;
begin
  pCriarFormularios(TfrmImportaArquivoCadastro, frmImportaArquivo);
  try
    frmImportaArquivo.TipoArquivo := aTipo;
    frmImportaArquivo.ShowModal;
  Finally
    pFreeAndNil(frmImportaArquivo);
  End;
end;

procedure TfrmImportaArquivoCadastro.pCancelarImportacao(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    FOperacaoCancelada := True;
end;

procedure TfrmImportaArquivoCadastro.pSelecionarModelo;
var
  frmSelecionarModeloArquivo: TfrmSelecionarModeloArquivo;
begin
  pCriarFormularios(TfrmSelecionarModeloArquivo, frmSelecionarModeloArquivo);
  try
    frmSelecionarModeloArquivo.TipoImportacaoArquivo := TipoArquivo;
    frmSelecionarModeloArquivo.ObjImportaPlanilha := ObjImportaPlanilha;
    frmSelecionarModeloArquivo.ObjModeloArquivo := ObjModeloArquivo;
    frmSelecionarModeloArquivo.ShowModal;
    If frmSelecionarModeloArquivo.ModalResult = mrOK Then
    Begin
      ObjModeloArquivo := frmSelecionarModeloArquivo.ObjModeloArquivo;
      ObjModeloArquivo.fAtualizarModeloAtual;
      edtModeloImportacao.Text := ObjModeloArquivo.Descricao;
    End;
  Finally
    pFreeAndNil(frmSelecionarModeloArquivo);
  End;
end;

function TfrmImportaArquivoCadastro.fCancelouOperacao: Boolean;
begin
  Result := FOperacaoCancelada;
end;

function TfrmImportaArquivoCadastro.fConfirmar: Boolean;
var
  frmAguarde: TfrmGravando;
begin
  Result := False;

  If fEmptyStr(edtPath.Text) Then
  Begin
    pMensagemOk('Precisa ser informado um arquivo para realizar a importação dos dados.');
    pSetFocus(edtPath);
    Exit;
  End;

  If fEmptyStr(edtModeloImportacao.Text) Then
  Begin
    pMensagemOk('Atenção! Defina um modelo para importação através do botão [F6] Visualizar/Alterar Modelo.');
    Exit;
  End;

  pCriarFormularios(TfrmGravando, frmAguarde);
  Try
    frmAguarde.lblEscCancelar.Visible := True;
    frmAguarde.lblGravando.Caption := 'Aguarde...Processando Arquivo.';
    frmAguarde.KeyPreview := True;
    frmAguarde.pgbStatus.Visible := True;
    frmAguarde.OnKeyDown := pCancelarImportacao;
    frmAguarde.fExecutarAcao := fProcessarArquivo;
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  Finally
    pFreeAndNil(frmAguarde);
  End;

  If (fCancelouOperacao) Then
    Exit;

  Case TipoArquivo Of
    tpCadastroProspecto : Result := fAbrirTelaInconsistenciasProspecto;
    tpItensFatVenda     : Result := fAbrirTelaInconsistenciasItemFatVnd;
    tpCadLocEqu         : Result := fAbrirTelaInconsistenciasCadLocEqu;
  End;
end;

procedure TfrmImportaArquivoCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  FOperacaoCancelada := False;
end;

procedure TfrmImportaArquivoCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F6 : pSelecionarModelo;
    VK_F10 : Begin
               btnConfirma.Click;
             End;
  end;

end;

procedure TfrmImportaArquivoCadastro.FormShow(Sender: TObject);
begin
  inherited;

  btnHlpImp.Visible := False;

  ObjModeloArquivo := TModelo.fSelecionarModelo(TipoArquivo);
  Case TipoArquivo Of
    tpCadastroProspecto : Begin
                            ObjImportaPlanilha := TImportaPlanilhaProspecto.Create(ObjModeloArquivo, Nil);
                          End;
    tpItensFatVenda     : Begin
                            ObjImportaPlanilha := TImportaPlanilhaItemFatVenda.Create(ObjModeloArquivo, Nil);
                          End;
    tpCadLocEqu         : Begin
                            Self.Caption := 'Importar Cadastro de Equipamento de Locação';
                            ObjImportaPlanilha := TImportaPlanilhaCadLocEqu.Create(ObjModeloArquivo, Nil);
                            ObjModeloArquivo.fCarregarCampos;
                            If ObjModeloArquivo.Campos.Count <= 0 Then
                            Begin
                              ObjModeloArquivo.fCarregarCamposPadrao;
                              ObjModeloArquivo.Descricao := 'PADRÃO';
                              ObjModeloArquivo.fInserir;
                              ObjModeloArquivo.fAtualizarModeloAtual;
                              edtModeloImportacao.Text := ObjModeloArquivo.Descricao;
                            End;

                            btnHlpImp.Visible := True;
                          End;
  End;

  edtModeloImportacao.Text :=  ObjModeloArquivo.Descricao;
end;

function TfrmImportaArquivoCadastro.fProcessarArquivo(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := ObjImportaPlanilha.fProcessarArquivo(edtPath.Text, pgbStatus, fCancelouOperacao);
end;

class function TfrmImportaArquivoCadastro.fAbreTelaImportacaoArquivo(Const aTipo: TTipoImportacaoArquivo; var ObjImportaPlanilhaExt : IImportaPlanilha) : Boolean;
var
  frmImportaArquivo: TfrmImportaArquivoCadastro;
begin
  pCriarFormularios(TfrmImportaArquivoCadastro, frmImportaArquivo);
  try
    frmImportaArquivo.TipoArquivo := aTipo;
    Result := (frmImportaArquivo.ShowModal = MrOK);
    If Result Then
      ObjImportaPlanilhaExt := frmImportaArquivo.ObjImportaPlanilha;
  Finally
    pFreeAndNil(frmImportaArquivo);
  End;
end;

function TfrmImportaArquivoCadastro.fAbrirTelaInconsistenciasCadLocEqu: Boolean;
var
  frmInconsistencias: TfrmInconsistenciasCadLocEqu;
begin
  pCriarFormularios(TfrmInconsistenciasCadLocEqu, frmInconsistencias);
  Try
    frmInconsistencias.ObjImportaPlanilha := ObjImportaPlanilha;
    frmInconsistencias.ObjModeloArquivo   := ObjModeloArquivo;
    frmInconsistencias.ShowModal;
    Result := frmInconsistencias.ModalResult = mrOk;
  Finally
    pFreeAndNil(frmInconsistencias);
  End;
end;

function TfrmImportaArquivoCadastro.fAbrirTelaInconsistenciasItemFatVnd: Boolean;
var
  frmInconsistenciasItemFatVenda: TfrmInconsistenciasItemFatVenda;
begin
  pCriarFormularios(TfrmInconsistenciasItemFatVenda, frmInconsistenciasItemFatVenda);
  Try
    frmInconsistenciasItemFatVenda.ObjInterfaceImportaPlanilha := ObjImportaPlanilha;
    frmInconsistenciasItemFatVenda.ObjInterfaceModeloArquivo   := ObjModeloArquivo;
    frmInconsistenciasItemFatVenda.tsInconsistencias.Caption   := 'Inconsistências';
    frmInconsistenciasItemFatVenda.tsCadastrosGerados.Caption  := 'Dados para importação';
    frmInconsistenciasItemFatVenda.ShowModal;
    Result := frmInconsistenciasItemFatVenda.ModalResult = mrOk;
  Finally
    pFreeAndNil(frmInconsistenciasItemFatVenda);
  End;
end;

function TfrmImportaArquivoCadastro.fAbrirTelaInconsistenciasProspecto: Boolean;
var
  frmInconsistencias: TfrmInconsistenciasProspecto;
begin
  pCriarFormularios(TfrmInconsistenciasProspecto, frmInconsistencias);
  Try
    frmInconsistencias.ObjImportaPlanilha := ObjImportaPlanilha;
    frmInconsistencias.ObjModeloArquivo   := ObjModeloArquivo;
    frmInconsistencias.ShowModal;
    Result := frmInconsistencias.ModalResult = mrOk;
  Finally
    pFreeAndNil(frmInconsistencias);
  End;
end;

end.
