unit untFatFaturaRemessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, cxProgressBar, untGravando,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  StrUtils, untFuncFat, untZClient;

type
  TfrmFatFaturaRemessa = class(TfrmPaiOrdena)
    pnlDocs: TPanel;
    Label2: TLabel;
    pnlPen: TPanel;
    pnlDev: TPanel;
    pnlEnv: TPanel;
    pnlFat: TPanel;
    pnlEnvTotSin: TPanel;
    pnlDevTotSin: TPanel;
    pnlPenTotSin: TPanel;
    pnlFatTotSin: TPanel;
    dbgAnalitico: TDBGridCitel;
    Label3: TLabel;
    pnlEnvTotAnl: TPanel;
    pnlDevTotAnl: TPanel;
    pnlPenTotAnl: TPanel;
    pnlFatTotAnl: TPanel;
    lbl1: TLabel;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    lbl3: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtDesCliente: TEditFocus;
    img1: TImage;
    lbl2: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure mskDtaIniEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure dbgAnaliticoColEnter(Sender: TObject);
    procedure dbgAnaliticoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaColEnter(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
    procedure dbgAnaliticoExit(Sender: TObject);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    cdsAnalitico: TZClient;

    blnMarcaTodos : Boolean;

    blnPostandoPai   : Boolean;
    blnPostandoFilho : Boolean;

    procedure pCalculaTotais(chrTip: Char='T');
    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    function fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;

    Function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    Function fGetCndPagto(fatVenda: TFatVenda): Boolean;
    Function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fSQLSintetico: String;
    function fSQLAnalitico: String;

    procedure pAfterPostAnalitico(DataSet: TDataSet);
    procedure pBeforePostAnalitico(DataSet: TDataSet);
    procedure pAfterInsertAnalitico(DataSet: TDataSet);
    function fValidaCliente(strCodCli: String): Boolean;
    function fPedeDadosFiscais: Boolean;

    function fMarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;
  end;

const
  COR_ENV = 13434828;
  COR_DEV = 16768959;
  COR_PEN = 10944511;
  COR_FAT = $00A8D3FF;

implementation

uses untFatTipoFaturamento,untFuncoesSimples, untDigCndPagamento, untTypesSistema,
     untConsultas, untPesqAux, untFuncoes, untFuncFatTypes, untFatDadosFiscais;

{$R *.dfm}

{ TfrmFatFaturaRemessa }

procedure TfrmFatFaturaRemessa.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  pCriarFormularios(TfrmGravando, frmAguarde);
  Try
    frmAguarde.fExecutarAcao       := fConfirma;
    frmAguarde.lblGravando.Caption := 'Aguarde, Faturando Remessa...';
    frmAguarde.ShowModal;

    If (frmAguarde.blnConfirma) Then
    Begin
      pMensagemOk('Operação realizada com sucesso!');
      pSetFocus(mskDtaIni);
    End;

  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatFaturaRemessa.btnDesmarcaTodosClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If Not btnDesmarcaTodos.Visible Then
    Exit;

  pCriarFormularios(TfrmGravando, frmAguarde);
  Try
    frmAguarde.fExecutarAcao       := fDesmarcaTodos;
    frmAguarde.lblGravando.Caption := 'Aguarde, Desmarcando Todos...';
    frmAguarde.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatFaturaRemessa.btnMarcaTodosClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If Not btnMarcaTodos.Visible Then
    Exit;

  pCriarFormularios(TfrmGravando, frmAguarde);
  Try
    frmAguarde.fExecutarAcao       := fMarcaTodos;
    frmAguarde.lblGravando.Caption := 'Aguarde, Marcando Todos...';
    frmAguarde.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatFaturaRemessa.cdsConsultaAfterPost(DataSet: TDataSet);
  Var
    fltQtdRes : Double;
begin
  inherited;

  //Pai
  If (Not blnPostandoFilho) Then
  Begin
    blnPostandoPai := True;
    Try
      fltQtdRes := cdsConsulta.FieldByName('DET_QTDFAT').AsFloat;

      Try
        With cdsAnalitico do
        Begin
          {**************************************************}
          {* LIMPA A QTDE FATURADA EM TODOS OS DOCUMENTOS   *}
          {* RELACIONADOS AO PRODUTO SELECIONADO.           *}
          {***********************************************MM*}
          First;
          While Not EOF Do
          Begin
            Edit;
            FieldByName('DET_QTDFAT').AsFloat := 0;
            Post;
            Next;
          End;

          {**********************************************}
          {* RATEIA A QUANTIDADE DE PRODUTOS FATURADOS  *}
          {* NOS DOCUMENTOS RELACIONADOS.               *}
          {*******************************************MM*}
          First;
          While Not EOF Do
          Begin
            If ((cdsAnalitico.FieldByName('DET_QTDPEN').AsFloat) > 0) Then
            Begin
              Edit;

              If (fltQtdRes > cdsAnalitico.FieldByName('DET_QTDPEN').AsFloat) Then
              Begin
                FieldByName('DET_QTDFAT').AsFloat := FieldByName('DET_QTDPEN').AsFloat;
                fltQtdRes                         := fltQtdRes - FieldByName('DET_QTDPEN').AsFloat;
              End
              Else
              Begin
                FieldByName('DET_QTDFAT').AsFloat := fltQtdRes;
                fltQtdRes                         := 0;
              End;

              Post;
            End;

            Next;
          End;
          First;
        End;

      Except
        On E: Exception Do
        Begin
          cdsConsulta.EnableControls;
          pMensagensErro(E.Message,'TfrmFatRetornoConsignacao.cdsConsultaAfterPost');
        End;
      End;

      pCalculaTotais;
    Finally
      blnPostandoPai := False;
    End;
  End;

End;

procedure TfrmFatFaturaRemessa.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If Not (cdsConsulta.IsEmpty) Then
  Begin
    With cdsAnalitico Do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := 'DET_CODITE = ' + QuotedStr(cdsConsulta.FieldByName('DET_CODITE').AsString) + ' AND ' +
                  'DET_UNITAR = ' + cdsConsulta.FieldByName('DET_UNITAR').AsString;
      Filtered := True;
      EnableControls;
    End;

    If Not (cdsAnalitico.IsEmpty) Then
      pnlDocs.Caption := '   ' + IntToStr(cdsAnalitico.RecordCount) +
                         IIF(cdsAnalitico.RecordCount <= 1,' DOCUMENTO ENVIADO',' DOCUMENTOS ENVIADOS');

    pCalculaTotais('A');
  End;
end;

procedure TfrmFatFaturaRemessa.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (FieldByName('DET_QTDFAT').AsFloat < 0) Then
    Begin
      cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('DET_QTDFAT').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else
      FieldByName('DET_VALFAT').AsFloat := FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNITAR').AsFloat;
  End;
end;

procedure TfrmFatFaturaRemessa.dbgAnaliticoColEnter(Sender: TObject);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  cdsAnalitico.FieldByName('DET_QTDFAT').FocusControl;
end;

procedure TfrmFatFaturaRemessa.dbgAnaliticoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsAnalitico.Active Then
    Exit;

  If Not (gdFocused in State) Then
  Begin

    If Pos(Column.FieldName, 'DET_QTDENV_DET_TOTITE_') > 0 Then
      dbgAnalitico.Canvas.Brush.Color := COR_ENV;

    If Pos(Column.FieldName, 'DET_QTFARE_DET_TOTFAT_') > 0 Then
      dbgAnalitico.Canvas.Brush.Color := COR_DEV;

    If Pos(Column.FieldName, 'DET_QTDPEN_DET_TOTPEN_') > 0 Then
      dbgAnalitico.Canvas.Brush.Color := COR_PEN;

    If Pos(Column.FieldName, 'DET_QTDFAT_DET_VALFAT_') > 0 Then
      dbgAnalitico.Canvas.Brush.Color := COR_FAT;

  End;

  dbgAnalitico.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatFaturaRemessa.dbgAnaliticoExit(Sender: TObject);
begin
  inherited;

  If (cdsAnalitico.State In [dsEdit]) Then
    cdsAnalitico.Post;
end;

procedure TfrmFatFaturaRemessa.dbgConsultaColEnter(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
end;

procedure TfrmFatFaturaRemessa.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If (Not cdsConsulta.Active) Then
    Exit;

  If Not (gdFocused in State) Then
  Begin

    If Pos(Column.FieldName, 'DET_QTDENV_DET_TOTITE_') > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_ENV;

    If Pos(Column.FieldName, 'DET_QTFARE_DET_TOTFAT_') > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_DEV;

    If Pos(Column.FieldName, 'DET_QTDPEN_DET_TOTPEN_') > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_PEN;

    If Pos(Column.FieldName, 'DET_QTDFAT_DET_VALFAT_') > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_FAT;

  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatFaturaRemessa.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  If (cdsConsulta.State In [dsEdit]) Then
    cdsConsulta.Post;
end;

procedure TfrmFatFaturaRemessa.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, True, Nil, False, EmptyStr, 'EM') Then
  Begin
    fValidaCampos(edtCodCliente, True);
  End;
end;

function TfrmFatFaturaRemessa.fAbreConsulta(blnLike: Boolean): Boolean;
Begin

  stlListSelecao.Clear;

  Result       := inherited fAbreConsulta(blnLike);

  If (Result) Then
  Begin
    (cdsConsulta.FieldByName('DET_QTDENV') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_QTFARE') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_QTDPEN') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_QTDFAT') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsConsulta.FieldByName('DET_VALFAT') As TFloatField).DisplayFormat := '#,##0.00';

    If Not (cdsConsulta.IsEmpty) Then
    Begin
      With cdsAnalitico Do
      Begin
        Close;
        qryQuery.Close;
        pSetProvider;
        qryQuery.Open;
        pSetaClient(qryQuery);
        Open;

        pnlDocs.Caption := '   ' + IntToStr(RecordCount) +
                           IIF(RecordCount <= 1,' DOCUMENTO ENVIADO',' DOCUMENTOS ENVIADOS');

        (FieldByName('DET_QTDENV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_QTFARE') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_QTDPEN') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_QTDFAT') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('DET_VALFAT') As TFloatField).DisplayFormat := '#,##0.00';
      End;
    End
    Else
    Begin
      cdsAnalitico.Close;
      pnlDocs.Caption := '';
    End;

    pCalculaTotais;
  End;

End;


function TfrmFatFaturaRemessa.fGetCndPagto(fatVenda: TFatVenda): Boolean;
  Var
    frmDigCndPagamento : TfrmDigCndPagamento;
begin
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.fraDigCndPagamento.blnCnfDoc         := False;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda          := fatVenda;

    frmDigCndPagamento.fraDigCndPagamento.strCodCli         := fatVenda.strCodCli;

    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text  := fatVenda.strCodCnd;
      frmDigCndPagamento.fraDigCndPagamento.strCcnAnt       := fatVenda.strCodCnd;
    End;

    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text    := fatVenda.strCodFpg;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := fRetDesFpg(fatVenda.strCodFpg);

    If Not fEmptyStr(fatVenda.strCodCnd) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.pCarregaCondicao;
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
    End;

    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := fatVenda.strConPag;

    {*********************************************}
    { CARREGA ESTES DADOS PARA SENHA DE LIBERACAO }
    { PARA ZERAR TAXA DE JUROS                    }
    {******************************************JB*}
    frmDigCndPagamento.fraDigCndPagamento.strCodVen      := fatVenda.strCodVen;
    frmDigCndPagamento.fraDigCndPagamento.strCodDig      := fatVenda.strCodDig;
    frmDigCndPagamento.fraDigCndPagamento.strNTrava      := fatVenda.strNTrava;
    frmDigCndPagamento.fraDigCndPagamento.stlNumLib      := fatVenda.stlNumLib;
    frmDigCndPagamento.fraDigCndPagamento.blnHabZta      := True;

    frmDigCndPagamento.Caption := frmDigCndPagamento.Caption;

    If (fCfgSis('CNDVEN') = 'F')      And
        fCfgSis('USACND', varBoolean) And
        fCfgSis('PFLCLI', varBoolean) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := fatVenda.fRetornaMargemDocumento;
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := fatVenda.fltTotGer;
    End
    Else
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := 0;
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := 0;
    End;

    frmDigCndPagamento.showModal;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;
    If Result Then
    Begin
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
      fatVenda.strCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
      fatVenda.strCodFpg := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;
      fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetCndPagto]');
    End;
  End;
end;

function TfrmFatFaturaRemessa.fGetItem(qryGenIte: TUniQuery;
  strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_DESOPE, ';
    strSQL := strSQL + '  G.ITE_ICMSAI, ';
    strSQL := strSQL + '  G.ITE_IMPFED, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF,  ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fGetItem]');
    End;

  End;

end;

function TfrmFatFaturaRemessa.fGetSql(blnLike: Boolean): String;
begin
  Result := fSQLSintetico;
end;

function TfrmFatFaturaRemessa.fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  arrOpcoes[1].strDesCri := 'Faturamento Futuro';
  arrOpcoes[1].strEspDoc := 'FF';
  arrOpcoes[1].strOpcLet := 'F';
  arrOpcoes[1].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

      If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
        Result := False
      Else
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatBaixaEntregaFutura.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

function TfrmFatFaturaRemessa.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strNumLot   : String;
    strLotAnt   : String;
    objConsig   : TConsignacoes;
    intPosicao  : Integer;
    impSubIteEst: TImpostosSubItensEstrutura;
    fltOutValIte,
    fltDesOpeIte,
    fltIcmSaiIte,
    fltImpFedIte,
    fltPreVe1Ite,
    fltPreVe2Ite,
    fltPreVe3Ite,
    fltPreVe4Ite,
    fltPreVe5Ite,
    fltPreVe6Ite,
    fltPreVe7Ite: Double;
Begin
  Try
    qryGenIte := fCriaQuery;

    With cdsConsulta Do
    Begin
      DisableControls;

      fatVenda.fltDesEsp := 0;

      intContador := 0;
      First;

      While Not Eof Do
      Begin
        If FieldByName('DET_QTDFAT').AsFloat > 0 Then
        Begin
          inc(intContador);

          {**********************************}
          {* Monta matriz com os documentos *}
          {* para salvar na tabela MOVCON   *}
          {**********************************}
          objConsig := TConsignacoes.Create;

          With cdsAnalitico Do
          Begin
            If Not IsEmpty Then
            Begin
              First;
              While Not EOF do
              Begin
                If FieldByName('DET_QTDFAT').AsFloat > 0 Then
                Begin
                  SetLength(objConsig.arrConsignacoes, Length(objConsig.arrConsignacoes) + 1);

                  intPosicao := Length(objConsig.arrConsignacoes) - 1;

                  objConsig.arrConsignacoes[intPosicao].strNumDoc := FieldByName('DET_NUMDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strEspDoc := FieldByName('DET_ESPDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodIte := FieldByName('DET_CODITE').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodEmp := FieldByName('DET_CODEMP').AsString;
                  objConsig.arrConsignacoes[intPosicao].fltQtdIte := FieldByName('DET_QTDFAT').AsFloat;
                  objConsig.arrConsignacoes[intPosicao].strAutInc := FieldByName('AUTOINCREM').AsString;

                  If (FieldByName('DET_QTDPEN').AsFloat = FieldByName('DET_QTDFAT').AsFloat) Then
                  Begin
                    objConsig.arrConsignacoes[intPosicao].fltDesEsp := FieldByName('DET_DESESP').AsFloat -
                                                                       FieldByName('CON_DESESP').AsFloat;

                    fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('DET_DESESP').AsFloat -
                                                               FieldByName('CON_DESESP').AsFloat;
                  End
                  Else
                  Begin
                    objConsig.arrConsignacoes[intPosicao].fltDesEsp := fFormataFloat(FieldByName('DET_DESESP').AsFloat /
                                                                                     FieldByName('DET_QTDENV').AsFloat *
                                                                                     FieldByName('DET_QTDFAT').AsFloat, 2);

                    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fFormataFloat(FieldByName('DET_DESESP').AsFloat /
                                                                             FieldByName('DET_QTDENV').AsFloat *
                                                                             FieldByName('DET_QTDFAT').AsFloat, 2);
                  End;

                End;

                Next;
              End;
            End;
          End;

          strNumLot := FieldByName('DET_NUMLOT').AsString;
          strLotAnt := '';

          fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

          If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenIte.FieldByName('ITE_DESITE').AsString) > 0,
                                                     FieldByName('DET_CODITE').AsString) Then
          Begin
            impSubIteEst.strCodIte := FieldByName('DET_CODITE').AsString;
            impSubIteEst.strEmpIte := '';
            impSubIteEst.fltUniPai := FieldByName('DET_UNITAR').AsFloat;
            impSubIteEst.fltQtdPai := FieldByName('DET_QTDFAT').AsFloat;

            fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

            fltOutValIte := impSubIteEst.fltOutVal;
            fltDesOpeIte := impSubIteEst.fltDesOpe;
            fltImpFedIte := impSubIteEst.fltImpFed;
            fltIcmSaiIte := impSubIteEst.fltIcmSai;
            fltPreVe1Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
            fltPreVe2Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
            fltPreVe3Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
            fltPreVe4Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
            fltPreVe5Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
            fltPreVe6Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
            fltPreVe7Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
          End
          Else
          Begin
            fltOutValIte := qryGenIte.FieldByName('ITE_OUTVAL').AsFloat;
            fltDesOpeIte := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;
            fltImpFedIte := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;
            fltIcmSaiIte := IIF(fCfgSis('IMPCF4') = 'S', fatVenda.fCalculaAliquota(FieldByName('DET_CODITE').AsString, VS_strCodEmp, qryGenIte.FieldByName('ITE_IMPDIR').AsString), qryGenIte.FieldByName('ITE_ICMSAI').AsFloat);
            fltPreVe1Ite := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
            fltPreVe2Ite := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
            fltPreVe3Ite := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
            fltPreVe4Ite := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
            fltPreVe5Ite := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
            fltPreVe6Ite := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
            fltPreVe7Ite := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
          End;

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               FieldByName('DET_IDEPRO').AsString,
                                               FieldByName('ITE_CODGRU').AsString,
                                               FieldByName('DET_CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               FieldByName('DET_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_CODMAR').AsString,
                                               FieldByName('DET_CODFOR').AsString,
                                               FieldByName('DET_REFERE').AsString,
                                               FieldByName('DET_UNIORI').AsFloat,
                                               FieldByName('DET_UNIVIS').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat,
                                               0.0,
                                               FieldByName('DET_DESCON').AsFloat,
                                               FieldByName('DET_QTDFAT').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat*FieldByName('DET_QTDFAT').AsFloat,
                                               'S',
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDFAT').AsFloat, 2),
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               fltPreVe1Ite,
                                               fltPreVe2Ite,
                                               fltPreVe3Ite,
                                               fltPreVe4Ite,
                                               fltPreVe5Ite,
                                               fltPreVe6Ite,
                                               fltPreVe7Ite,
                                               fCalculaPrecoVenda(2, fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDFAT').AsFloat, 2), FieldByName('DET_UNITAR').AsFloat, 0, 0, 0, 0, 0),
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               FieldByName('DET_INCPIS').AsString,
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('DET_QTDFAT').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               FieldByName('DET_ITECHA').AsString,
                                               FieldByName('DET_ITETIN').AsString,
                                               FieldByName('DET_DESCOR').AsString,
                                               FieldByName('DET_TIPPRE').AsString,
                                               FieldByName('DET_LAZQUA').AsInteger,
                                               FieldByName('DET_TIPEMB').AsString,
                                               0,
                                               0,
                                               FieldByName('DET_PRVTIN').AsFloat,
                                               FieldByName('DET_PRCTIN').AsFloat,
                                               FieldByName('DET_FATTIN').AsFloat,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               FieldByName('DET_PROMOC').AsString,
                                               0,
                                               0,
                                               0,
                                               0,
                                               IIF(fEmptyStr(FieldByName('DET_SEQTIN').AsString), '', '2'),
                                               fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(FieldByName('DET_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString),
                                               FieldByName('DET_VOLPRO').AsFloat,
                                               intContador,
                                               '',
                                               FieldByName('DET_CODACA').AsString,
                                               FieldByName('DET_EMPACA').AsString,
                                               FieldByName('DET_PROACA').AsString = 'S',
                                               '',
                                               '',
                                               '',
                                               fltOutValIte, //OUTVAL
                                               0,
                                               fltDesOpeIte, // DESOPE
                                               fltIcmSaiIte, // ICMSAI
                                               fltImpFedIte, // IMPFED
                                               0,
                                               '',
                                               '',
                                               '',
                                               FieldByName('DET_TABPRE').AsString,
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               0.0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               FieldByName('DET_QTDFAT').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',

                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDFAT').AsFloat, 2),
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               strLotAnt,
                                               strNumLot,
                                               '',
                                               '',
                                               False,
                                               'N',
                                               'NOR',
                                               0,
                                               '',
                                               qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               1,
                                               True,
                                               '',
                                               '',
                                               '',
                                               0,
                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('DET_QTDFAT').AsFloat,
                                               FieldByName('DET_VAL_RT').AsFloat,
                                               FieldByName('DET_TAXJUR').AsFloat,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               False,
                                               False,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               'N',
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                               0.00,
                                               '',
                                               '',
                                               '',
                                               'S',
                                               'N',
                                               '',
                                               '',
                                               '',
                                               '',
                                               False,
                                               -1,
                                               -1,
                                               'N',
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               False,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               'N',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

          If Not Assigned(fatVenda.dicDocs) Then
            fatVenda.dicDocs := TDicionario.Create;

          fatVenda.dicDocs.AdicionarObjeto(cdsVenda.FieldByName('AUTOINCREM').AsString, objConsig);
        End;

        Next;

      End;

      EnableControls;
    End;

    Result := TRUE;

    FreeAndNil(qryGenIte);

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fIncluiItens]');
    End;

  End;


end;

procedure TfrmFatFaturaRemessa.FormCreate(Sender: TObject);
begin
  inherited;

  blnPostandoPai          := False;
  blnPostandoFilho        := False;
  blnSempreRelerBanco     := False;
  blnSelecionaComEspaco   := True;
  blnQuoteLista           := False;
  blnMarcaTodos           := False;

  lflLastField.intIndCol  := 0;
  lflLastField.strNomCam  := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol  := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam  := ftString;

  qryCadCli               := fCriaQuery(Self);

  pCriarCdsVenda(Self);

  fatVenda                := TFatVenda.CreateInstance('VN');
  fatVenda.strOpcDocTrue  := 'EM';
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';

  cdsAnalitico            := TZClient.Create(Self, fSQLAnalitico);
  cdsAnalitico.IndexFieldNames := 'DET_ESPDOC;DET_NUMDOC';
  cdsAnalitico.AfterPost  := pAfterPostAnalitico;
  cdsAnalitico.BeforePost := pBeforePostAnalitico;
  cdsAnalitico.AfterInsert:= pAfterInsertAnalitico;

  dbgAnalitico.DataSource := cdsAnalitico.dtsSource;

  pnlEnv.Color := COR_ENV;
  pnlDev.Color := COR_DEV;
  pnlPen.Color := COR_PEN;
  pnlFat.Color := COR_FAT;

  pnlEnvTotSin.Color := COR_ENV;
  pnlDevTotSin.Color := COR_DEV;
  pnlPenTotSin.Color := COR_PEN;
  pnlFatTotSin.Color := COR_FAT;

  pnlEnvTotAnl.Color := COR_ENV;
  pnlDevTotAnl.Color := COR_DEV;
  pnlPenTotAnl.Color := COR_PEN;
  pnlFatTotAnl.Color := COR_FAT;
end;

procedure TfrmFatFaturaRemessa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fatVenda);
  FreeAndNil(cdsAnalitico);
end;

procedure TfrmFatFaturaRemessa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of

    VK_RETURN: Begin
                 If ((ActiveControl) = dbgConsulta) Then
                 Begin
                   If cdsConsulta.State = dsEdit Then
                   Begin
                     cdsConsulta.Post;
                     cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
                   End
                   Else If cdsConsulta.Active And (Not SameText(dbgConsulta.SelectedField.FieldName,'DET_QTDFAT')) Then
                   Begin
                     cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
                   End;
                 End
                 Else If ((ActiveControl) = dbgAnalitico) Then
                 Begin
                   If cdsAnalitico.State = dsEdit Then
                   Begin
                     cdsAnalitico.Post;
                     cdsAnalitico.FieldByName('DET_QTDFAT').FocusControl;
                   End
                   Else If cdsAnalitico.Active And (Not SameText(dbgAnalitico.SelectedField.FieldName,'DET_QTDFAT')) Then
                   Begin
                     cdsAnalitico.FieldByName('DET_QTDFAT').FocusControl;
                   End;
                 End;
               End;

    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else If ((ActiveControl) = mskDtaIni) Then
               Begin
                 pSetFocus(mskDtaIni);
               End
               Else inherited;

    VK_F6 : btnMarcaTodos.Click;

    VK_F7 : btnDesmarcaTodos.Click;

    VK_F10: btnConfirma.Click;

    Else inherited;
  End;
end;

procedure TfrmFatFaturaRemessa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

function TfrmFatFaturaRemessa.fPedeDadosFiscais: Boolean;
begin
  Try
    pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
    frmFatDadosFiscais.fatVenda := fatVenda;
    frmFatDadosFiscais.blnPodeCancelar := True;
    frmFatDadosFiscais.ShowModal;
    Result := frmFatDadosFiscais.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmFatFaturaConsignacao.fPedeDadosFiscais]');
    End;
  End;
  pFreeAndNil(frmFatDadosFiscais);
end;

function TfrmFatFaturaRemessa.fSetParametros: Boolean;
  Var
    strClaEnv : String;
Begin
  strClaEnv := '5' + fCfgSis('CFRSAI') + '_' + '6' + fCfgSis('CFRSAI') + '_' + '5' + fCfgSis('CFRSAS') + '_' + '6' + fCfgSis('CFRSAS') + '_';

  With qryConsulta Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;

  With cdsAnalitico.qryQuery Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  Result := True;
End;

function TfrmFatFaturaRemessa.fSQLAnalitico: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  D.DET_NUMDOC, ';
  strSQL := strSQL + '  D.DET_ESPDOC, ';
  strSQL := strSQL + '  D.DET_CODEMP, ';
  strSQL := strSQL + '  D.DET_NUMLOT, ';
  strSQL := strSQL + '  D.DET_IDEPRO, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  D.DET_UNIDAD, ';
  strSQL := strSQL + '  D.DET_CODMAR, ';
  strSQL := strSQL + '  D.DET_CODFOR, ';
  strSQL := strSQL + '  D.DET_REFERE, ';
  strSQL := strSQL + '  T.DET_VAL_RT, ';
  strSQL := strSQL + '  D.DET_UNIORI, ';
  strSQL := strSQL + '  T.DET_UNIVIS, ';
  strSQL := strSQL + '  T.DET_TAXJUR, ';
  strSQL := strSQL + '  D.DET_DESCON, ';
  strSQL := strSQL + '  D.DET_DESESP, ';
  strSQL := strSQL + '  D.DET_TOTCUS, ';
  strSQL := strSQL + '  D.DET_INCPIS, ';
  strSQL := strSQL + '  D.DET_ITECHA, ';
  strSQL := strSQL + '  D.DET_ITETIN, ';
  strSQL := strSQL + '  D.DET_DESCOR, ';
  strSQL := strSQL + '  D.DET_TIPPRE, ';
  strSQL := strSQL + '  D.DET_LAZQUA, ';
  strSQL := strSQL + '  D.DET_TIPEMB, ';
  strSQL := strSQL + '  D.DET_PRVTIN, ';
  strSQL := strSQL + '  D.DET_PRCTIN, ';
  strSQL := strSQL + '  D.DET_FATTIN, ';
  strSQL := strSQL + '  D.DET_PROMOC, ';
  strSQL := strSQL + '  D.DET_SEQTIN, ';
  strSQL := strSQL + '  D.DET_VOLPRO, ';
  strSQL := strSQL + '  D.DET_CODACA, ';
  strSQL := strSQL + '  D.DET_EMPACA, ';
  strSQL := strSQL + '  D.DET_PROACA, ';
  strSQL := strSQL + '  D.DET_TABPRE, ';
  strSQL := strSQL + '  D.DET_TOTCU2, ';
  strSQL := strSQL + '  P.ITE_PRECUS, ';
  strSQL := strSQL + '  D.DET_CODITE, ';
  strSQL := strSQL + '  D.DET_DESCRI, ';
  strSQL := strSQL + '  D.DET_UNITAR, ';

  If blnMarcaTodos Then
  Begin
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0)) AS DET_QTDFAT, ';
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0)) * D.DET_UNITAR AS DET_VALFAT, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDFAT, ';
    strSQL := strSQL + '  0.00 AS DET_VALFAT, ';
  End;

  strSQL := strSQL + '  IFNULL(R.CON_DESESP,0.0) AS CON_DESESP, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) AS DET_QTDENV, ';
  strSQL := strSQL + '  IFNULL(R.CON_QTDITE,0.0) AS DET_QTFARE, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) AS DET_QTDPEN, ';
  strSQL := strSQL + '  IFNULL(D.DET_UNITAR,0.0) * IFNULL(D.DET_QTDITE,0.0) AS DET_TOTITE, ';
  strSQL := strSQL + '  IFNULL(D.DET_UNITAR,0.0) * (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0)) AS DET_TOTPEN, ';
  strSQL := strSQL + '  IFNULL(D.DET_UNITAR,0.0) * IFNULL(R.CON_QTDITE,0.0) AS DET_TOTFAT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER P ON P.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  LEFT  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  LEFT  JOIN (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, SUM(CON_QTDITE) AS CON_QTDITE, SUM(CON_DESESP) AS CON_DESESP  ';
  strSQL := strSQL + '              FROM (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_QTDITE, CON_DESESP FROM MOVCON ';
  strSQL := strSQL + '                    UNION ALL ';
  strSQL := strSQL + '                    SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_QTDITE, CON_DESESP FROM NOTCON) AS A ';
  strSQL := strSQL + '              GROUP BY CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE) AS R ';
  strSQL := strSQL + '               ON R.CON_NUMDOC = D.DET_NUMDOC ';
  strSQL := strSQL + '              AND R.CON_ESPDOC = D.DET_ESPDOC ';
  strSQL := strSQL + '              AND R.CON_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + '              AND R.CON_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '              AND ((R.CON_AUTICS = D.AUTOINCREM) OR (IFNULL(R.CON_AUTICS, "") = "")) ';
  strSQL := strSQL + 'LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  ((D.DET_ESPDOC = "NF" AND ';
  strSQL := strSQL + '    LOCATE(D.DET_CLAFIS,:CLAENV) > 0) OR (D.DET_ESPDOC = "ER")) AND ';

  strSQL := strSQL + ' D.DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + ' D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' P.ITE_CODEMP = :CODEMP ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '    AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' ORDER BY D.DET_NUMDOC ';

  Result := strSQL;
end;

function TfrmFatFaturaRemessa.fSQLSintetico: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  fExecutaSQL('SET @AUTOINCREM := 0;');

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  lPAD(@AUTOINCREM := @AUTOINCREM + 1,20,"0") AS AUTOINCREM, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  DET_CODFOR, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_VAL_RT, ';
  strSQL := strSQL + '  DET_UNIORI, ';
  strSQL := strSQL + '  DET_UNIVIS, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  SUM(DET_DESESP) AS DET_DESESP, ';
  strSQL := strSQL + '  SUM(CON_DESESP) AS DET_DESBAI, ';
  strSQL := strSQL + '  DET_TOTCUS, ';
  strSQL := strSQL + '  DET_INCPIS, ';
  strSQL := strSQL + '  DET_ITECHA, ';
  strSQL := strSQL + '  DET_ITETIN, ';
  strSQL := strSQL + '  DET_DESCOR, ';
  strSQL := strSQL + '  DET_TIPPRE, ';
  strSQL := strSQL + '  DET_LAZQUA, ';
  strSQL := strSQL + '  DET_TIPEMB, ';
  strSQL := strSQL + '  DET_PRVTIN, ';
  strSQL := strSQL + '  DET_PRCTIN, ';
  strSQL := strSQL + '  DET_FATTIN, ';
  strSQL := strSQL + '  DET_PROMOC, ';
  strSQL := strSQL + '  DET_SEQTIN, ';
  strSQL := strSQL + '  DET_VOLPRO, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_PROACA, ';
  strSQL := strSQL + '  DET_TABPRE, ';
  strSQL := strSQL + '  DET_TOTCU2, ';
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNITAR, ';

  If blnMarcaTodos Then
  Begin
    strSQL := strSQL + '  SUM(DET_QTDENV - DET_QTFARE) AS DET_QTDFAT, ';
    strSQL := strSQL + '  SUM(DET_QTDENV - DET_QTFARE) * SUM(DET_UNITAR) AS DET_VALFAT, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDFAT, ';
    strSQL := strSQL + '  0.00 AS DET_VALFAT, ';
  End;

  strSQL := strSQL + '  SUM(DET_QTDENV) AS DET_QTDENV, ';
  strSQL := strSQL + '  SUM(DET_QTFARE) AS DET_QTFARE, ';
  strSQL := strSQL + '  SUM(DET_QTDPEN) AS DET_QTDPEN, ';
  strSQL := strSQL + '  SUM(DET_TOTITE) AS DET_TOTITE, ';
  strSQL := strSQL + '  SUM(DET_TOTFAT) AS DET_TOTFAT, ';
  strSQL := strSQL + '  SUM(DET_TOTPEN) AS DET_TOTPEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '   ( ' + fSQLAnalitico + ' ) AS A ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  A.DET_CODITE, A.DET_DESCRI, A.DET_UNIDAD, A.DET_UNITAR ';
  strSQL := strSQL + 'HAVING SUM(IFNULL(DET_QTDPEN,0.0)) > 0.0 ';

  Result := strSQL;
end;


function TfrmFatFaturaRemessa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      mskDtaFin.Clear;
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;

    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If fValidaCliente(edtCodCliente.Text) Then
        fAbreConsulta(TRUE);

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatFaturaRemessa.fValidaCliente(strCodCli: String): Boolean;
begin
  Result := True;

  If fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtDesCliente.Clear;
    fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
    Result := FALSE;
  End
  Else
  Begin
    pCarregaCliente;
    If fEmptyStr(edtDesCliente.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
      Result := FALSE;
    End;
  End;

  If (Not Result) Then
  Begin
    cdsConsulta.Close;
    cdsAnalitico.Close;
  End;
end;

procedure TfrmFatFaturaRemessa.mskDtaIniEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  cdsAnalitico.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtDesCliente.Clear;
end;

procedure TfrmFatFaturaRemessa.pAfterInsertAnalitico(DataSet: TDataSet);
begin
  If (Not blnPodeIncluir) And (cdsAnalitico.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatFaturaRemessa.pAfterPostAnalitico(DataSet: TDataSet);
  Var
    fltQtdFat : Double;
    strNumDoc,
    strEspDoc,
    strCodEmp : String;
begin

  //Filho
  If (Not blnPostandoPai) Then
  Begin
    blnPostandoFilho := True;
    Try
      strNumDoc := cdsAnalitico.FieldByName('DET_NUMDOC').AsString;
      strEspDoc := cdsAnalitico.FieldByName('DET_ESPDOC').AsString;
      strCodEmp := cdsAnalitico.FieldByName('DET_CODEMP').AsString;

      fltQtdFat := 0;
      With cdsAnalitico do
      Begin
        First;
        While Not Eof Do
        Begin
          fltQtdFat := fltQtdFat + FieldByName('DET_QTDFAT').AsFloat;
          Next;
        End;

        Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP', VarArrayOf([strNumDoc,strEspDoc,strCodEmp]), []);
      End;

      With cdsConsulta do
      Begin
        Edit;
        FieldByName('DET_QTDFAT').AsFloat := fltQtdFat;
        Post;
      End;

      pCalculaTotais;
    Finally
      blnPostandoFilho := False;
    End;
  End;

End;

procedure TfrmFatFaturaRemessa.pBeforePostAnalitico(DataSet: TDataSet);
begin
  pSetFocus(dbgAnalitico);

  With DataSet Do
  Begin
    If (FieldByName('DET_QTDFAT').AsFloat < 0) Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDFAT').FocusControl;
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('DET_QTDFAT').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDFAT').FocusControl;
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else
      FieldByName('DET_VALFAT').AsFloat := FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNITAR').AsFloat;
  End;
end;

procedure TfrmFatFaturaRemessa.pCalculaTotais(chrTip: Char='T');
  Var
    cdsDados : TUniClientDataSet;
    fltEnv,
    fltDev,
    fltPen,
    fltFat: Double;

  procedure pSetTotais(chrTip: Char);
  begin
    If chrTip = 'A' Then
    Begin
      pnlEnvTotAnl.Caption := FormatFloat('#,##0.00', fltEnv);
      pnlDevTotAnl.Caption := FormatFloat('#,##0.00', fltDev);
      pnlPenTotAnl.Caption := FormatFloat('#,##0.00', fltPen);
      pnlFatTotAnl.Caption := FormatFloat('#,##0.00', fltFat);
    End
    Else
    Begin
      pnlEnvTotSin.Caption := FormatFloat('#,##0.00', fltEnv);;
      pnlDevTotSin.Caption := FormatFloat('#,##0.00', fltDev);;
      pnlPenTotSin.Caption := FormatFloat('#,##0.00', fltPen);;
      pnlFatTotSin.Caption := FormatFloat('#,##0.00', fltFat);;
    End
  end;

  procedure pZera;
  begin
    fltEnv := 0;
    fltDev := 0;
    fltPen := 0;
    fltFat := 0;
  end;

begin
  If (CharInSet(chrTip, ['T','S'])) Then
  Begin
    pZera;
    cdsDados := TUniClientDataSet.Create(Self);
    Try
      If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
      Begin
        pCloneDataSet(cdsDados, cdsConsulta);
        With cdsDados Do
        Begin
           First;
           While Not Eof Do
           Begin
             fltEnv := fltEnv + FieldByName('DET_TOTITE').AsFloat;
             fltDev := fltDev + FieldByName('DET_TOTFAT').AsFloat;
             fltPen := fltPen + FieldByName('DET_TOTPEN').AsFloat;
             fltFat := fltFat + FieldByName('DET_VALFAT').AsFloat;
             Next;
           End;
        End;
      End;
    Finally
      pSetTotais('S');
      FreeAndNil(cdsDados);
    End;
  End;

  If (CharInSet(chrTip, ['T','A'])) Then
  Begin
    pZera;
    cdsDados := TUniClientDataSet.Create(Self);
    Try
      If (cdsAnalitico.Active) And (Not cdsAnalitico.IsEmpty) Then
      Begin
        pCloneDataSet(cdsDados, cdsAnalitico);
        cdsDados.Filter := cdsAnalitico.Filter;
        cdsDados.Filtered := True;
        With cdsDados Do
        Begin
           First;
           While Not Eof Do
           Begin
             fltEnv := fltEnv + FieldByName('DET_TOTITE').AsFloat;
             fltDev := fltDev + FieldByName('DET_TOTFAT').AsFloat;
             fltPen := fltPen + FieldByName('DET_TOTPEN').AsFloat;
             fltFat := fltFat + FieldByName('DET_VALFAT').AsFloat;
             Next;
           End;
        End;
      End;
    Finally
      pSetTotais('A');
      FreeAndNil(cdsDados);
    End;
  End;
end;

procedure TfrmFatFaturaRemessa.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text, True, False, EmptyStr, 'EM');
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
end;

function TfrmFatFaturaRemessa.fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    blnConfirma: Boolean;
    blnMosDup  : Boolean;
    arrDatas   : TDateArray;
    arrDuplic  : TDigDuplicArray;

    procedure pAcertaDesEspItens;
      Var
        intIndex: Integer;
        objConsig: TConsignacoes;
    begin
      for intIndex := Low(fatvenda.arrMatItens) to High(fatvenda.arrMatItens) do
      begin
        With fatvenda, dicDocs, arrMatItens[intIndex] Do
          objConsig := TConsignacoes(RetornaObjeto(intToStr(intAutInc)));

        fatvenda.arrMatItens[intIndex].fltDesEsp :=  objConsig.fGetTotalDesEsp;
      end;
    end;
begin
  Result := False;

  pnlHeader.Enabled := False;
  cdsConsulta.DisableControls;
  Try
    Try
      If (Not fValidaCliente(edtCodCliente.Text)) Then
      Begin
        pSetFocus(edtCodCliente);
        Exit;
      End;

      If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há dados para confirmar!', ['&OK']);
        Exit;
      End;

      fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);
      pInicializaTemporaria;

      fatVenda.strOpcDoc := 'EM';

      fatVenda.strCodVen := fatVenda.strCodOpe;
      fatVenda.strCodDig := fatVenda.strCodOpe;
      fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);

      blnConfirma := fIncluiItens(fatVenda);

      If (blnConfirma) Then
      Begin
        fatVenda.pCarregaAliquotasRetencao;

        fatVenda.pPreencheMatrizFechamento;

        fatVenda.pCalculaPesBruLiq;

        fatVenda.pCalculaTotGer(False, False);

        If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
        Begin
          If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
            fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        End;

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;

        fatVenda.pCalculaTotGer(False, False);

        fatVenda.pCalculaTotGer;

        If Not fGetCndPagto(fatVenda) Then
        Begin
          pInicializaTemporaria;
          Exit;
        End;

        If Not fGetTipoFaturamento(fatVenda) Then
        Begin
          pInicializaTemporaria;
          Exit;
        End;

        If (Pos(fatVenda.strEspDoc, 'NF_EL_NS_') > 0) Then
        Begin
          If (Not fPedeDadosFiscais) Then
          Begin
            pInicializaTemporaria;
            Exit;
          End;
        End;

        fatVenda.pCalculaTotalParaCadRec;

        If (Not fatVenda.fDigitaDuplicata(blnMosDup,
                                          arrDatas,
                                          VS_Date,
                                          False,
                                          arrDuplic)) Then
        Begin
          Exit;
        End;

        fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        fatVenda.pRateiaValores;

        pAcertaDesEspItens;

        Result := fatVenda.fGravaArquivos;

        pInicializaTemporaria;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatFaturaRemessa.fConfirma]');
        pInicializaTemporaria;
      End;
    End;
  Finally
    cdsConsulta.EnableControls;
    pnlHeader.Enabled := True;
    pCalculaTotais;
  End;
end;

procedure TfrmFatFaturaRemessa.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  blnPostandoPai     := False;
  blnPostandoFilho   := False;
end;

function TfrmFatFaturaRemessa.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    blnMarcaTodos := False;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);
  Except
    Result := False;
  End;
end;

function TfrmFatFaturaRemessa.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    blnMarcaTodos := True;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);
  Except
    Result := False;
  End;
end;

end.
