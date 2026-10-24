unit untCadImpressaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, EditFocus, untConfiguraImpressaoPedidoCompra;

type
  TfrmCadImpressaoPedido = class(TfrmPaiCad)
    Panel1: TPanel;
    cxgRelatorios: TcxGrid;
    cxvRelatorios: TcxGridDBTableView;
    cxvRelatoriosRPC_HABILI: TcxGridDBColumn;
    cxvRelatoriosColumn2: TcxGridDBColumn;
    cxvRelatoriosColumn3: TcxGridDBColumn;
    cxvRelatoriosColumn4: TcxGridDBColumn;
    cxgRelatoriosLevel1: TcxGridLevel;
    Panel2: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label148: TLabel;
    dbeCodRel: TDBEditFocus;
    edtDesRel: TEditFocus;
    dbeHabili: TDBCheckBox;
    dtsTabela: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    DBCheckBox1: TDBCheckBox;
    cxvRelatoriosRPC_EXEDIR: TcxGridDBColumn;
    procedure dbeCodRelKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxvRelatoriosCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxvRelatoriosRPC_HABILIPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    objOpcoes: TConfiguraImpressaoPedidoCompra;

    procedure pCarregaRegistro;

  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadImpressaoPedido: TfrmCadImpressaoPedido;

implementation

{$R *.dfm}

Uses
  untTypesSistema,
  untFuncoesSimples,
  untConsultas;

procedure TfrmCadImpressaoPedido.pCarregaRegistro;
Begin
  qryTabela.SQL.Text := Concat('SELECT * FROM CADRPC WHERE RPC_CODIGO = ', objOpcoes.FieldByName('RPC_CODIGO').AsString);
  qryTabela.Open;
End;

procedure TfrmCadImpressaoPedido.btnAlterarClick(Sender: TObject);
begin
  If Not btnAlterar.Enabled Then
    Exit;

  If objOpcoes.RecordCount > 0 Then
  Begin
    pCarregaRegistro;

    inherited;

    pHabilitaCodigo(dbeCodigo, dbeCodRel, False);
  End;

end;

procedure TfrmCadImpressaoPedido.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If objOpcoes.RecordCount > 0 Then
  Begin
    pCarregaRegistro;
    inherited;

    objOpcoes.fCarregaOpcoes;
    objOpcoes.Locate('RPC_CODIGO', dbeCodigo.Text, []);
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadImpressaoPedido.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadImpressaoPedido.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  objOpcoes.fCarregaOpcoes;
  objOpcoes.Locate('RPC_CODIGO', dbeCodigo.Text, []);
end;

procedure TfrmCadImpressaoPedido.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeCodRel, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('RPC_HABILI').AsString := 'S';
  qryTabela.FieldByName('RPC_EXEDIR').AsString := 'S';
end;

procedure TfrmCadImpressaoPedido.cxvRelatoriosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnAlterar.Click;
end;

procedure TfrmCadImpressaoPedido.cxvRelatoriosRPC_HABILIPropertiesChange(
  Sender: TObject);
begin
  inherited;

  objOpcoes.fSalva;
end;

procedure TfrmCadImpressaoPedido.dbeCodRelKeyPress(Sender: TObject;
  var Key: Char);
  Var arrSel: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self,
                    dbeCodRel,
                    edtDesRel,
                    Nil,
                    False, //    blnBackup: Boolean;
                    '',    //    strTipImp: String;
                    Key,
                    arrSel) And
     fValidaCampos(dbeCodRel, True) Then
   SelectNext(ActiveControl, True, True);
end;


procedure TfrmCadImpressaoPedido.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'CADRPC';
  strNomeCampo          := 'RPC_CODIGO';

  qryTabela             := fCriaQuery(Self);
  dtsTabela.DataSet     := qryTabela;

  objOpcoes := TConfiguraImpressaoPedidoCompra.Create(Self);
  objOpcoes.fCarregaOpcoes;

  cxvRelatorios.DataController.DataSource := objOpcoes.dtsSource;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;
 end;

procedure TfrmCadImpressaoPedido.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);

end;

function TfrmCadImpressaoPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Opção deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeCodRel) Then
    Begin

      If fEmptyStr(dbeCodRel.Text) Then
      Begin
        fMensagem('','O Código do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End Else
      Begin

        edtDesRel.Text := fRetNomeRelatorio(dbeCodRel.Text);

        If fEmptyStr(edtDesRel.Text) Then
        Begin
          fMensagem('','Relatório não encontrado!', ['&Ok']);
          Result := False;
        End

        Else If Not objOpcoes.fValidaDestino(dbeCodRel.Text) Then
        Begin
          Result := False;
          pMensagemOk('A saída do relatório dever ser TXT ou CSV!');
        End

        Else If fEmptyStr(dbeDescri.Text) And (qryTabela.State In dsEditModes) Then
        Begin

          If (qryTabela.State = dsInsert) And objOpcoes.Locate('RPC_CODREL', dbeCodRel.Text, []) Then
          Begin
            Result := False;
            pMensagemOk('Esse relatório já está incluido!');
          End Else
          Begin
            qryTabela.FieldByName('RPC_DESCRI').AsString := edtDesRel.Text;
          End;

        End;

      End;

    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da opção deve ser preenchida!', ['&Ok']);
        Result := False;
      End Else
      Begin
        blnMudarFoco := False;
        pSetFocus(btnGravar);
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadImpressaoPedido.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

end.
