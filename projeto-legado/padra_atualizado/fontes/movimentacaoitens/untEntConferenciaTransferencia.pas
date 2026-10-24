unit untEntConferenciaTransferencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.Mask, MaskEditFocus, Vcl.StdCtrls, EditFocus,
  QColorLabel, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  untConsultas,
  untFuncoesSimples,
  untFuncoesConsulta,
  untTypesSistema,
  untTransferenciaArmazensConferencia, Uni, System.UITypes;

type
  TfrmEntConferenciaTransferencia = class(TfrmPaiConfirma)
    pnlHeader: TPanel;
    Label1: TLabel;
    clbSubProdPermiteVendaSeparado: TColorLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodTip: TEditFocus;
    edtDesAmz: TEditFocus;
    edtDataInicial: TMaskEditFocus;
    edtDataFinal: TMaskEditFocus;
    btnPesquisar: TBitBtnLocked;
    dbgConsulta: TDBGridCitel;
    pnlTail: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    Label6: TLabel;
    btnReniciarContagem: TBitBtnLocked;
    dbgConsultaArmazem: TDBGridCitel;
    Splitter1: TSplitter;
    edtCodAmz: TEditFocus;
    btnExcluir: TBitBtnLocked;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnReniciarContagemClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodAmzExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgConsultaArmazemDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgConsultaArmazemDblClick(Sender: TObject);
  private
    { Private declarations }
    arrCodAmz: TConsultasArray;
    qryCodbar : TUniQuery;
    fltFatorEmb: Double;
    FObjTransferencia: TTransferenciaArmazensConferenciaConferencia;
    procedure pRegistraItemConferido;
    procedure pValidarQuantidade;
    procedure pLimparItem;
    procedure pSelecionar;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmEntConferenciaTransferencia: TfrmEntConferenciaTransferencia;

implementation

{$R *.dfm}

uses untPesqAux;

procedure TfrmEntConferenciaTransferencia.btnConfirmaClick(Sender: TObject);
begin
  Try
    If Not fPergunta('Confirma a conferência de transferência entre armazéns?') Then
     Exit;

    FObjTransferencia
      .fValidarConferencia
      .fConfirmarConferencia;

    pnlHeader.Enabled := true;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmEntConferenciaTransferencia.btnConfirmaClick]');
  End;
end;

procedure TfrmEntConferenciaTransferencia.btnExcluirClick(Sender: TObject);
var
  LobjDataset: TDataSet;
begin
  inherited;

  if not btnExcluir.Enabled then
    Exit;

  If (not Assigned(dbgConsulta.DataSource)) or
     (not Assigned(dbgConsulta.DataSource.DataSet)) or
     dbgConsulta.DataSource.DataSet.IsEmpty Then
  Begin
    pMensagemOk('Sem dados para serem processados!');
    Exit;
  End;

  LobjDataset := dbgConsulta.DataSource.DataSet;
  if not fPergunta('Confirma a exclusão do produto ' + LobjDataset.FieldByName('DET_CODITE').AsString + ' da conferência?') then
    Exit;

  if FObjTransferencia.fExcluiItemConferencia then
    pMensagemOk('Item excluído com sucesso!');
end;

procedure TfrmEntConferenciaTransferencia.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Try
    If Not fVerificaCampos Then
      Exit;

    dbgConsultaArmazem.DataSource :=
      FObjTransferencia
        .fTipoConferencia(edtCodTip.Text)
        .fArmazem(edtCodAmz.Text)
        .fDataInicial(StrToDateDef(edtDataInicial.Text, 0))
        .fDataFinal(StrToDateDef(edtDataFinal.Text, 0))
        .fCarregarDocumentosConferenciaItens
        .fCarregarDocumentosConferencia
        .fDataSource;

    dbgConsulta.DataSource :=
      FObjTransferencia
      .fDataSourceItens;

    dbgConsulta.Columns[7].FieldName := 'DET_QTDCFE';
    If edtCodTip.Text <> 'E' Then
      dbgConsulta.Columns[7].FieldName := 'DET_QTDCFS';

    dbgConsultaArmazem.Columns[3].Visible := edtCodTip.Text = 'S';
    dbgConsultaArmazem.Columns[4].Visible := edtCodTip.Text = 'E';
    pnlHeader.Enabled := False;
    pSetFocus(edtCodIte);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmEntConferenciaTransferencia.btnPesquisar]');
  End;
end;

procedure TfrmEntConferenciaTransferencia.btnReniciarContagemClick(
  Sender: TObject);
begin
  inherited;
  case fMensagem('Aviso!', 'Confirmar a renicialização da conferência?', ['&Divergente', '&Todos','&Não']) of
    1: FobjTransferencia.fReiniciarContagem(scEmConferencia);
    2: FobjTransferencia.fReiniciarContagem(scTodos);
  End;
end;

procedure TfrmEntConferenciaTransferencia.btnSairClick(Sender: TObject);
begin
  If Not pnlHeader.Enabled Then
  Begin
    If fMensagem('Aviso!', 'Cancelar a conferência?', ['&Sim', '&Não']) = 1 Then
    Begin
      pnlHeader.Enabled := True;
      FObjTransferencia.pFechar;
      pLimparItem;
    End
  End
  Else
    Close;
end;

procedure TfrmEntConferenciaTransferencia.pValidarQuantidade;
begin
  If (fEmptyStr(edtQtdIte.Text)) Then
    raise Exception.Create('A quantidade deve ser preenchida!');
  If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
    raise Exception.Create('A quantidade deve ser maior que zero!');
end;

procedure TfrmEntConferenciaTransferencia.dbgConsultaArmazemDblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionar;
End;

procedure TfrmEntConferenciaTransferencia.pSelecionar;
Begin
  FObjTransferencia
    .fAdicionarRemoverLista
    .fFiltrarItens;
  dbgConsultaArmazem.Invalidate;
end;

procedure TfrmEntConferenciaTransferencia.dbgConsultaArmazemDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (gdSelected in State) And (Not FObjTransferencia.fSelecionado) then
  begin
    dbgConsultaArmazem.Canvas.Brush.Color := clHighlight;
    dbgConsultaArmazem.Canvas.Font.Color  := clHighlightText;
  end
  else if FObjTransferencia.fSelecionado then
  begin
    dbgConsultaArmazem.Canvas.Brush.Color := clYellow;
    dbgConsultaArmazem.Canvas.Font.Color  := clBlack;
  end
  else
  begin
    dbgConsultaArmazem.Canvas.Brush.Color := clWhite;
    dbgConsultaArmazem.Canvas.Font.Color  := clBlack;
  end;
  dbgConsultaArmazem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEntConferenciaTransferencia.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not Assigned(dbgConsulta.DataSource) Then
    Exit;
  If dbgConsulta.DataSource.DataSet.IsEmpty Then
    Exit;

  If FObjTransferencia.fStatusQuantidadeConferida <> scNaoConferido Then
  Begin
    dbgConsulta.Canvas.Font.Color := clBlack;
    case FObjTransferencia.fStatusQuantidadeConferida Of
      scEmConferencia: dbgConsulta.Canvas.Brush.Color := clYellow;
      scConferido: dbgConsulta.Canvas.Brush.Color := $000CA310;
    End;
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmEntConferenciaTransferencia.edtCodAmzExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAmz, edtDesAmz, arrCodAmz, Nil, fRetNomeArmazem, 'do armazém');
end;

procedure TfrmEntConferenciaTransferencia.edtCodAmzKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrCodAmz) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmEntConferenciaTransferencia.FormCreate(Sender: TObject);
begin
  inherited;
  fltFatorEmb := 1;
  FObjTransferencia := TTransferenciaArmazensConferenciaConferencia.Create;
  qryCodbar := fCriaQuery;
end;

procedure TfrmEntConferenciaTransferencia.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FObjTransferencia);
  FreeAndNil(qryCodbar);
end;

procedure TfrmEntConferenciaTransferencia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F5: btnPesquisar.Click;
    VK_F10: btnConfirma.Click;
    VK_RETURN:
      If dbgConsultaArmazem.Focused Then
        pSelecionar
      Else If (edtQtdIte.Focused) Then
      Begin
        pRegistraItemConferido;
        pLimparItem;
      End
      Else
        Inherited;
  End;
end;

procedure TfrmEntConferenciaTransferencia.FormShow(Sender: TObject);
begin
  inherited;
  btnExcluir.Enabled := fVerificaAcessoSistema('EXCLUIITEMCONFARM');
end;

function TfrmEntConferenciaTransferencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Not Result Then
    Exit;

  If (Sender = edtCodTip) then
  Begin
    if fEmptyStr(edtCodTip.Text) then
    Begin
      pMensagemOk('O Tipo da conferência não foi informado!');
      Result := False;
    End
    Else If not ((edtCodTip.Text = 'E') or (edtCodTip.Text = 'S')) Then
    begin
      pMensagemOk('O Tipo da conferência deve ser E ou S!');
      Result := False;
    end;
  End
  Else If (Sender = edtCodIte) and blnBuscaPorChave Then
  Begin
    fltFatorEmb := 1;
    If fEmptyStr(edtCodIte.Text) Then
    begin
      pMensagemOk('O Código do Item precisa ser informado!');
      Result := False;
    End
    Else
    begin
      If Length(edtCodIte.Text) < fTamCodIte then
        edtCodIte.Text := fStrZero(edtCodIte.Text,fTamCodIte);

       pPesquisaCadIteSemSemelhante(nil,
                                    qryCodbar,
                                    edtCodIte.Text,
                                    (Length(edtCodIte.Text) > fTamCodIte),
                                    False,
                                    '',
                                    False,
                                    False);
      If qryCodbar.IsEmpty Then
      begin
        pMensagemOk('Não foi possível encotrar o item do código informado!');
        edtCodIte.Text := '';
        Result := False;
      End
      Else
      begin
        If (Length(edtCodIte.Text) > fTamCodIte) then
          fltFatorEmb := qryCodbar.FieldByName('BAR_EMBALA').AsFloat
        Else
          fltFatorEmb := 1;
        edtCodIte.Text := qryCodbar.FieldByName('ITE_CODITE').AsString;
      end;
    end;
  End

  Else If (Sender = edtCodAmz) then
  Begin
    if fEmptyStr(edtCodAmz.Text) then
    Begin
      pMensagemOk('O armazém não foi informado!');
      Result := False;
    End;
  End;
end;

procedure TfrmEntConferenciaTransferencia.pRegistraItemConferido;
Var
  LValido: Boolean;
Begin
  LValido := True;
  If (not Assigned(dbgConsulta.DataSource)) or
     (not Assigned(dbgConsulta.DataSource.DataSet)) or
     dbgConsulta.DataSource.DataSet.IsEmpty Then
  Begin
    pMensagemOk('Sem dados para serem processados!');
    Exit;
  End;
  If Length(edtCodIte.Text) > fTamCodIte then
    LValido := fValidaCampos(edtCodIte, true);
  If LValido Then
  Begin
    Try
      pValidarQuantidade;
      FObjTransferencia
        .fAtualizarQuantidadeConferida(edtCodIte.Text, StrToCurrDef(edtQtdIte.Text,0) * fltFatorEmb);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmEntConferenciaTransferencia.fRegistraItemConferido]');
    End;
  End;
End;

procedure TfrmEntConferenciaTransferencia.pLimparItem;
Begin
  edtCodIte.Text := '';
  edtQtdIte.Text := '1,00';
  fltFatorEmb := 1;
End;


end.


