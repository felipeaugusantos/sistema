unit untCadLimiteComprasFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxMaskEdit, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  EditFocus, Vcl.Mask, MaskEditFocus,
  untLimiteComprasFornecedor, cxButtons;

type
  TfrmCadLimiteComprasFornecedor = class(TfrmPaiConfirma)
    cxgLimitePedidos: TcxGrid;
    cxvLimitePedidos: TcxGridDBTableView;
    cxvLimitePedidosANOMES: TcxGridDBColumn;
    cxvLimitePedidosVALLIM: TcxGridDBColumn;
    cxgLimitePedidosLevel1: TcxGridLevel;
    cxvLimitePedidosCODFOR: TcxGridDBColumn;
    cxvLimitePedidosNOMFOR: TcxGridDBColumn;
    pnlInclusao: TPanel;
    cxvLimitePedidosColumn1: TcxGridDBColumn;
    Panel2: TPanel;
    btnExcluir: TBitBtnLocked;
    btnImpArq: TBitBtnLocked;
    Label2: TLabel;
    mskMesAno: TMaskEditFocus;
    Label16: TLabel;
    edtValMes: TEditFocus;
    pnlFornecedor: TPanel;
    Label1: TLabel;
    edtCodForConsulta: TEditFocus;
    edtDesForConsulta: TEditFocus;
    btnIncluir: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxAjudaImpCSV: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvLimitePedidosColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxvLimitePedidosVALLIMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpArqClick(Sender: TObject);
  private
    { Private declarations }
    objLimite: TLimiteComprasFornecedor;

    Procedure pLimpaTela(blnLimpaFornecedor: Boolean);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

Uses
  StrUtils,
  untFuncoesSimples,
  untTypesSistema,
  untConsultas,
  untImportaLimiteComprasFornecedor;

procedure TfrmCadLimiteComprasFornecedor.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If objLimite.fExcluiRegistro Then
    pLimpaTela(False);
end;

procedure TfrmCadLimiteComprasFornecedor.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxAjudaImpCSV.ShowReport();

end;

procedure TfrmCadLimiteComprasFornecedor.btnImpArqClick(Sender: TObject);
begin
  inherited;

  If objLimite.fSalvaDados Then
  Begin
    pLimpaTela(True);
    objLimite.Close;
  End;

  objLimite.pImportaArqCSV;

end;

procedure TfrmCadLimiteComprasFornecedor.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(mskMesAno, True) And
     fValidaCampos(edtValMes, True) And
     objLimite.fIncluiRegistro(edtCodForConsulta.Text,
                               edtDesForConsulta.Text,
                               StrToIntDef(RightStr(mskMesAno.Text, 4), 0),
                               StrToIntDef(LeftStr(mskMesAno.Text, 2), 0),
                               fStrToFloat(edtValMes.Text)) Then
  Begin
    pLimpaTela(False);
    pSetFocus(mskMesAno);
  End;
end;

procedure TfrmCadLimiteComprasFornecedor.cxvLimitePedidosColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  AText := RightStr('0' + AText, 2);
end;

procedure TfrmCadLimiteComprasFornecedor.cxvLimitePedidosVALLIMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltValor: Double;
begin
  inherited;

  fltValor := fStrToFloat(DisplayValue);

  If fltValor < 0 Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('Informe um valor maior ou igual a zero!');
  End;
end;

procedure TfrmCadLimiteComprasFornecedor.edtCodForConsultaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodForConsulta, edtDesForConsulta, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodForConsulta, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadLimiteComprasFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If objLimite.State In dsEditModes Then
      objLimite.Post;

    If objLimite.ChangeCount > 0 Then
    Begin

      If objLimite.fSalvaDados Then
      Begin
        pLimpaTela(True);
        objLimite.Close;
      End;

      Action := caNone;
      Exit;

    End

    Else If Not objLimite.Active Then
    Begin
      Action := caNone;
      Exit;
    End;

  End Else
  Begin

    If objLimite.ChangeCount > 0 Then
    Begin

      If (Not fPergunta('Há alterações realizadas que não foram salvas.' + #13#10 +
                        'Deseja sair sem salvar as modificações?', False)) Then
      Begin
        Action := caNone;
        Exit;
      End;

    End;

    If Not pnlFornecedor.Enabled Then
    Begin
      objLimite.Close;
      pLimpaTela(True);

      Action := caNone;
      Exit;
    End;

  End;
end;

procedure TfrmCadLimiteComprasFornecedor.FormCreate(Sender: TObject);
begin
  inherited;

  objLimite := TLimiteComprasFornecedor.Create(Self);

  cxvLimitePedidos.DataController.DataSource := objLimite.dtsSource;
end;

procedure TfrmCadLimiteComprasFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

Procedure TfrmCadLimiteComprasFornecedor.pLimpaTela(blnLimpaFornecedor: Boolean);
Begin
  If blnLimpaFornecedor Then
  Begin
    edtCodForConsulta.Clear;
    edtDesForConsulta.Clear;

    pnlFornecedor.Enabled := True;
    pnlInclusao.Enabled    := False;

    pSetFocus(edtCodForConsulta);
  End;

  mskMesAno.Clear;
  edtValMes.Clear;
End;

function TfrmCadLimiteComprasFornecedor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodForConsulta) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fEmptyStr(edtCodForConsulta.Text) Then
        Begin

          Result := False;
          pMensagemOk('Informe o código do Fornecedor!');

        End Else
        Begin

          edtDesForConsulta.Text := fRetNomFornecedor(edtCodForConsulta.Text);

          If fEmptyStr(edtDesForConsulta.Text) Then
          Begin

            Result := False;
            pMensagemOk('Fornecedor não encontrado!');

          End;

        End;

        If Result Then
        Begin

          If objLimite.fCarregaDados(edtCodForConsulta.Text) Then
          Begin
            pnlFornecedor.Enabled := False;
            pnlInclusao.Enabled   := True;
          End;

        End;

      End;

    End

    Else If (Sender = mskMesAno) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fEmptyDate(mskMesAno.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe o mês para cadastramento!');
        End

        Else If StrToDateDef('01/' + mskMesAno.Text,0) <= 0 Then
        Begin
          mskMesAno.Clear;
          Result := False;
          pMensagemOk('Mês/Ano inválido!');
        End

        Else mskMesAno.Text := FormatDateTime('MM/YYYY', StrToDate( '01/' + mskMesAno.Text));

      End;

    End

    Else If (Sender = edtValMes) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fEmptyStr(edtValMes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor mensal deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(edtValMes.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor mensal deve ser maior ou igual zero!', ['&O k']);
          Result := False;
        End

        Else edtValMes.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtValMes.Text));

      End;

    End

  End;

  If (Not Result) Then
  Begin
    pSetFocus(Sender);
  End;
end;

end.
