unit untCadCfopCst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, untCfgCfopCst,
  cxDropDownEdit, cxTextEdit;

type
  TfrmCadCfopCst = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Panel2: TPanel;
    cxvExcecoes: TcxGridDBTableView;
    cxgExcecoesLevel1: TcxGridLevel;
    cxgExcecoes: TcxGrid;
    cxvExcecoesColumn1: TcxGridDBColumn;
    cxvExcecoesColumn2: TcxGridDBColumn;
    cxvExcecoesOPCAO: TcxGridDBColumn;
    edtCFOP: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtCST: TEditFocus;
    btnExcluir: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    rdgOpcao: TRadioGroup;
    btnIncluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvExcecoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxvExcecoesCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    objExcecao: TCfgCfopCst;

     procedure pLimpaTela;
     procedure pCarregaTela;

  public
    { Public declarations }

    Class Procedure pCarregaDados(blnEntrada: Boolean);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmCadCfopCst: TfrmCadCfopCst;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmCadCfopCst.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pLimpaTela;
  pSetFocus(edtCFOP);
end;

procedure TfrmCadCfopCst.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objExcecao.fExcluiExcecao;
end;

procedure TfrmCadCfopCst.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos And
     objExcecao.fIncluiExcecao(edtCFOP.Text, edtCST.Text,
                               rdgOpcao.Items[rdgOpcao.ItemIndex]) Then
  Begin
    pLimpaTela;
    pSetFocus(edtCFOP);
  End;
end;

procedure TfrmCadCfopCst.cxvExcecoesCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pCarregaTela;
end;

procedure TfrmCadCfopCst.cxvExcecoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmCadCfopCst.pLimpaTela;
Begin
  edtCFOP.Clear;
  edtCST.Clear;
  rdgOpcao.ItemIndex := 0;
End;

procedure TfrmCadCfopCst.pCarregaTela;
Begin
  edtCFOP.Text := objExcecao.FieldByName('CFG_CODCFO').AsString;
  edtCST.Text  := objExcecao.FieldByName('CFG_CODCST').AsString;

  If objExcecao.FieldByName('CFG_ISEOUT').AsString  = 'I' Then
    rdgOpcao.ItemIndex := 0
  Else
    rdgOpcao.ItemIndex := 1;
End;

procedure TfrmCadCfopCst.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  If ModalResult = MrOk Then
  Begin

    If objExcecao.fSalvaDados Then
      pMensagemOk('Informações salvas com sucesso!')
    Else
      Action := caNone;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

end;

procedure TfrmCadCfopCst.FormCreate(Sender: TObject);
begin
  inherited;

  blnPassarRadioButtonComEnter := False;
end;

procedure TfrmCadCfopCst.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadCfopCst.FormShow(Sender: TObject);
begin
  inherited;

  objExcecao.fCarregaDados;

  cxvExcecoes.DataController.DataSource := objExcecao.dtsSource;

  pSetFocus(edtCFOP);
end;

Class Procedure TfrmCadCfopCst.pCarregaDados(blnEntrada: Boolean);
  Var
    frmCadCfopCst: TfrmCadCfopCst;
Begin
  pCriarFormularios(TfrmCadCfopCst, frmCadCfopCst);

  Try
    If blnEntrada Then
      frmCadCfopCst.Caption := 'Exceções de CFOP/CST - Documentos de Entrada'
    Else
      frmCadCfopCst.Caption := 'Exceções de CFOP/CST - Documentos de Saída';

    frmCadCfopCst.objExcecao := TCfgCfopCst.Create(frmCadCfopCst, blnEntrada);

    frmCadCfopCst.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadCfopCst.pCarregaDados]');
    End;
  End;

  pFreeAndNil(frmCadCfopCst);
End;

function TfrmCadCfopCst.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCFOP) Then
    Begin

      If Length(edtCFOP.Text) < 4 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da CFOP deve ter 4 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If objExcecao.blnEntrada And (edtCFOP.Text >= '5000') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da CFOP de Entrada deve ser < 5000!', ['&Ok']);
        Result := False;
      End
      Else If (Not objExcecao.blnEntrada) And (edtCFOP.Text < '5000') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da CFOP de Saída deve ser >= 5000!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCST) Then
    Begin

      If Length(edtCST.Text) < 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da CST deve ter 3 caracteres!', ['&Ok']);
        Result := False;
      End

    End

    Else If (Sender = rdgOpcao) Then
    Begin

      If rdgOpcao.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Escolha a opção de Isentas/Outras!', ['&Ok']);
        Result := False;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
