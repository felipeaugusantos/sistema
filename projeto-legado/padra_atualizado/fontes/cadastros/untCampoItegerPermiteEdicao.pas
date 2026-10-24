unit untCampoItegerPermiteEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, untTGerenciaItegerPermiteEdicao,
  cxContainer, cxProgressBar;

type
  TfrmCampoItegerPermiteEdicao = class(TfrmPai)
    cxvDados: TcxGridDBTableView;
    cxlDados: TcxGridLevel;
    cxgDados: TcxGrid;
    dtsDados: TDataSource;
    cxvDadosColumn1: TcxGridDBColumn;
    cxvDadosColumn2: TcxGridDBColumn;
    pnlOpcaoMarcacao: TPanel;
    lblDesmarcaTodos: TLabel;
    lblMarcaTodos: TLabel;
    lblInverte: TLabel;
    lblEmpresa: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSelecionaEmpresa: TBitBtnLocked;
    procedure lblMarcaTodosClick(Sender: TObject);
    procedure lblDesmarcaTodosClick(Sender: TObject);
    procedure lblInverteClick(Sender: TObject);
    procedure btnSelecionaEmpresaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    GerenciaItegerPermiteEdicao: TGerenciaItegerPermiteEdicao;
    { Public declarations }

  end;

var
  frmCampoItegerPermiteEdicao: TfrmCampoItegerPermiteEdicao;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCampoItegerPermiteEdicao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Enabled Then
    Exit;
  If Assigned(dtsDados.DataSet) Then
  Begin
    GerenciaItegerPermiteEdicao.pPersisteDados;
    Close;
  End
  Else
    pMensagemOk('Sem dados para gravar, selecione a empresa!');

end;

procedure TfrmCampoItegerPermiteEdicao.btnSelecionaEmpresaClick(Sender: TObject);
begin
  inherited;
  If GerenciaItegerPermiteEdicao.fSelecionaEmpresa(Self) Then
  begin
    dtsDados.DataSet := GerenciaItegerPermiteEdicao.cdsDados;
    lblEmpresa.Caption := 'Empresa Selecionada : ' + GerenciaItegerPermiteEdicao.EmpresaSelecionada + '-' + GerenciaItegerPermiteEdicao.NomeEmpresa;
    pnlOpcaoMarcacao.Visible := True;
    btnConfirma.Enabled := True;
  End;
end;

procedure TfrmCampoItegerPermiteEdicao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Assigned(dtsDados.DataSet) Then
    If Not dtsDados.DataSet.IsEmpty Then
      If fPergunta('Iniciar novo processo?') Then
      Begin
        lblEmpresa.Caption := 'Empresa Selecionada : ';
        GerenciaItegerPermiteEdicao.cdsDados.Close;
        CanClose := False;
        pnlOpcaoMarcacao.Visible := False;
        btnConfirma.Enabled := False;
      End;
end;

procedure TfrmCampoItegerPermiteEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_f10 Then
    btnConfirma.Click;

  If Key = VK_f9 Then
    btnSelecionaEmpresa.Click;
end;

procedure TfrmCampoItegerPermiteEdicao.lblDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  GerenciaItegerPermiteEdicao.pGerenciaMarcacao(giptmDesmarcaTodos);
end;

procedure TfrmCampoItegerPermiteEdicao.lblInverteClick(Sender: TObject);
begin
  inherited;
  GerenciaItegerPermiteEdicao.pGerenciaMarcacao(giptmInverte);
end;

procedure TfrmCampoItegerPermiteEdicao.lblMarcaTodosClick(Sender: TObject);
begin
  inherited;
  GerenciaItegerPermiteEdicao.pGerenciaMarcacao(giptmMarcaTodos);
end;

end.

