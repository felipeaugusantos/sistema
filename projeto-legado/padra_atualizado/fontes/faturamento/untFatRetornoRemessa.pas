unit untFatRetornoRemessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  StrUtils, untFuncFat, untZClient, cxProgressBar, untGravando,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatRetornoRemessa = class(TfrmPaiOrdena)
    pnlDocs: TPanel;
    Label2: TLabel;
    pnlPen: TPanel;
    pnlDev: TPanel;
    pnlEnv: TPanel;
    pnlRet: TPanel;
    pnlEnvTotSin: TPanel;
    pnlDevTotSin: TPanel;
    pnlPenTotSin: TPanel;
    pnlRetTotSin: TPanel;
    dbgAnalitico: TDBGridCitel;
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl3: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtCodCliente: TEditFocus;
    Label1: TLabel;
    edtDesCliente: TEditFocus;
    img1: TImage;
    lbl2: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    pnlEnvTotAnl: TPanel;
    pnlDevTotAnl: TPanel;
    pnlPenTotAnl: TPanel;
    pnlRetTotAnl: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnSelecao: TBitBtnLocked;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure mskDtaIniEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure dbgAnaliticoColEnter(Sender: TObject);
    procedure dbgAnaliticoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaColEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelecaoClick(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
    procedure dbgAnaliticoExit(Sender: TObject);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    cdsAnalitico: TZClient;

    blnMarcaTodos : Boolean;
    blnHabilitaScroll: Boolean;

    blnPostandoPai   : Boolean;
    blnPostandoFilho : Boolean;

    procedure pCalculaTotais(chrTip: Char='T');
    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    function fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function  fExisteItemSelecionado: Boolean;
    function  fIncluiItens(fatVenda: TFatVenda): Boolean;
    Function  fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    Function  fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function  fSQLSintetico: String;
    function  fSQLAnalitico: String;
    procedure pAfterPostAnalitico(DataSet: TDataSet);
    procedure pBeforePostAnalitico(DataSet: TDataSet);
    procedure pAfterInsertAnalitico(DataSet: TDataSet);
    procedure pSelecionaItensAutomatico;
    function  fSQLAnaliticoItensAut(strNumdoc, strCodVen, strCodCli, strCodEmp, strEspDoc: string;
      strCodTra: string=''): string;
    function  fSQLSinteticoItensAut(strNumdoc, strCodVen, strCodCli, strCodEmp, strEspDoc: string;
      strCodTra: string=''): string;

    function fMarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure pCancelaCdsConsulta;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;
  public
    { Public declarations }
    blnNfeOutrasEntradas: Boolean;
  end;

const
  COR_ENV = 13434828;
  COR_DEV = 16768959;
  COR_PEN = 10944511;
  COR_RET = $00A8D3FF;

implementation

uses untFatTipoFaturamento, untFuncFatTypes, untFuncoesSimples,
     untConsultas, untPesqAux, untFuncoes, untTypesSistema, untDuplicatas,
  untFatDigRemessaItens, untFatItensRetornoRemessa;

{$R *.dfm}

{ TfrmFatRetornoRemessa }

procedure TfrmFatRetornoRemessa.btnAdicionarClick(Sender: TObject);
var
  blnAbreConsulta : Boolean;
begin
  inherited;
  btnSelecao.Visible := False;
  blnAbreConsulta    := fValidaCampos(edtCodCliente, True);

  If (blnAbreConsulta) And
     (fCfgSis('MDLVFE', varString) = '2') Then
    blnAbreConsulta := fValidaCampos(edtNumDoc, False);

  If blnAbreConsulta Then
  Begin
    fAbreConsulta(TRUE);
    If (Not cdsAnalitico.IsEmpty) Then
    Begin
      btnSelecao.Visible := True;
    End;
  End;

end;

procedure TfrmFatRetornoRemessa.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  pCriarFormularios(TfrmGravando, frmAguarde);
  Try
    frmAguarde.fExecutarAcao       := fConfirma;
    frmAguarde.lblGravando.Caption := 'Aguarde, Faturando Retorno...';
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

procedure TfrmFatRetornoRemessa.btnDesmarcaTodosClick(Sender: TObject);
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

procedure TfrmFatRetornoRemessa.btnMarcaTodosClick(Sender: TObject);
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

procedure TfrmFatRetornoRemessa.btnSelecaoClick(Sender: TObject);
begin
  inherited;
  pSelecionaItensAutomatico;
end;

procedure TfrmFatRetornoRemessa.cdsConsultaAfterPost(DataSet: TDataSet);
  Var
    fltQtdRes : Double;
begin
  inherited;

  If (fCfgSis('MDLVFE',varString) = '2') Then
    Exit;

  //Pai
  If (Not blnPostandoFilho) Then
  Begin
    blnPostandoPai := True;
    Try
      fltQtdRes := cdsConsulta.FieldByName('DET_QTDRET').AsFloat;

      Try
        With cdsAnalitico do
        Begin
          {**************************************************}
          {* LIMPA A QTDE DE RETORNO EM TODOS OS DOCUMENTOS *}
          {* RELACIONADOS AO PRODUTO SELECIONADO.           *}
          {***********************************************MM*}
          First;
          While Not EOF Do
          Begin
            Edit;
            FieldByName('DET_QTDRET').AsFloat := 0;
            Post;
            Next;
          End;

          {**********************************************}
          {* RATEIA A QUANTIDADE DE PRODUTOS RETORNADOS *}
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
                FieldByName('DET_QTDRET').AsFloat := FieldByName('DET_QTDPEN').AsFloat;
                fltQtdRes                         := fltQtdRes - FieldByName('DET_QTDPEN').AsFloat;
              End
              Else
              Begin
                FieldByName('DET_QTDRET').AsFloat := fltQtdRes;
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

      If Not blnMarcaTodos Then
        pCalculaTotais;
    Finally
      blnPostandoPai := False;
      blnHabilitaScroll := True;
    End;
  End;

End;

procedure TfrmFatRetornoRemessa.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (Not blnHabilitaScroll) Then
    Exit;

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

procedure TfrmFatRetornoRemessa.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (fCfgSis('MDLVFE',varString) = '2') Then
    Begin
      cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
      pCancelaCdsConsulta;
      Abort;
    End
    Else
    Begin
      If (FieldByName('DET_QTDRET').AsFloat < 0) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
        fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
        pCancelaCdsConsulta;
        Abort;
      End
      Else If (FieldByName('DET_QTDRET').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
        fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
        pCancelaCdsConsulta;
        Abort;
      End
      Else
        FieldByName('DET_VALRET').AsFloat := FieldByName('DET_QTDRET').AsFloat * FieldByName('DET_UNITAR').AsFloat;
    End;
  End;

  blnHabilitaScroll := False;
end;

procedure TfrmFatRetornoRemessa.dbgAnaliticoColEnter(Sender: TObject);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
end;

procedure TfrmFatRetornoRemessa.dbgAnaliticoDrawColumnCell(Sender: TObject;
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

    If Pos(Column.FieldName, 'DET_QTDRET_DET_VALRET_') > 0 Then
      dbgAnalitico.Canvas.Brush.Color := COR_RET;

  End;

  dbgAnalitico.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatRetornoRemessa.dbgAnaliticoExit(Sender: TObject);
begin
  inherited;

  If (cdsAnalitico.State In [dsEdit]) Then
    cdsAnalitico.Post;
end;

procedure TfrmFatRetornoRemessa.dbgConsultaColEnter(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
end;

procedure TfrmFatRetornoRemessa.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
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

    If Pos(Column.FieldName, 'DET_QTDRET_DET_VALRET_') > 0 Then
      dbgConsulta.Canvas.Brush.Color := COR_RET;

  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatRetornoRemessa.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  If (cdsConsulta.State In [dsEdit]) Then
    cdsConsulta.Post;
end;

procedure TfrmFatRetornoRemessa.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRemessas: TConsultasArray;
  strCodCli: string;
begin
  inherited;
  If fPesqRetornoRemessa(Self, edtNumDoc, strCodCli, Key, arrRemessas) Then
  Begin
    edtCodCliente.Text := strCodCli;
    pCarregaCliente;
  End;
end;

procedure TfrmFatRetornoRemessa.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;

  if Length(edtCodCliente.Text) = 8 then
  begin
    pCarregaCliente;
    If fEmptyStr(edtDesCliente.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
      edtCodCliente.Clear;
      pSetFocus(edtCodCliente);
      Exit;
    End;
  end;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, True, Nil, False, EmptyStr, 'ET') Then
  Begin
    fValidaCampos(edtCodCliente, True);
  End;
end;

function TfrmFatRetornoRemessa.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  stlListSelecao.Clear;

  blnHabilitaScroll := False;

  Try
    Result := inherited fAbreConsulta(blnLike);

    If (Result) Then
    Begin
      (cdsConsulta.FieldByName('DET_QTDENV') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTFARE') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTDPEN') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTDRET') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.0000';
      (cdsConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_VALRET') As TFloatField).DisplayFormat := '#,##0.00';

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
          (FieldByName('DET_QTDRET') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.0000';
          (FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_VALRET') As TFloatField).DisplayFormat := '#,##0.00';
        End;
      End
      Else
      Begin
        cdsAnalitico.Close;
        pnlDocs.Caption := '';
      End;

      pCalculaTotais;
    End;
  Finally
    blnHabilitaScroll := True;
    //força o evento AfterScroll para filtrar os documentos do primeiro item
    cdsConsultaAfterScroll(cdsConsulta);
  End;
end;

function TfrmFatRetornoRemessa.fExisteItemSelecionado: Boolean;
Var
  blnFilter: Boolean;
  strFilter: String;
begin
  strFilter := cdsConsulta.Filter;
  blnFilter := cdsConsulta.Filtered;

  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'DET_QTDRET > 0';
  cdsConsulta.Filtered := True;

  Result := cdsConsulta.RecordCount > 0;

  cdsConsulta.Filter   := strFilter;
  cdsConsulta.Filtered := blnFilter;
end;

function TfrmFatRetornoRemessa.fGetItem(qryGenIte: TUniQuery;
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
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + ' JOIN ABFICM A ON I.ITE_CODABF = A.ABF_CODABF '
    Else
      strSQL := strSQL + ' JOIN ABFICM A ON G.ITE_CODABF = A.ABF_CODABF ';

    strSQL := strSQL + 'WHERE ';
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


function TfrmFatRetornoRemessa.fGetSql(blnLike: Boolean): String;
begin
  Result := fSQLSintetico;
end;

function TfrmFatRetornoRemessa.fGetTipoFaturamento(
  fatVenda: TFatVenda): Boolean;
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

  If not blnNfeOutrasEntradas Then
  Begin
    arrOpcoes[1].strDesCri := 'Retorno de Remessa';
    arrOpcoes[1].strEspDoc := 'ET';
    arrOpcoes[1].strOpcLet := 'R';
    arrOpcoes[1].strMosMen := 'N';
  End;

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;
      fatVenda.blnRcOutEnt := blnNfeOutrasEntradas;

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

function TfrmFatRetornoRemessa.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strNumLot   : String;
    strLotAnt   : String;
    objConsig   : TConsignacoes;
    intPosicao  : Integer;
    strAutIncRemessa : String;
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
        If FieldByName('DET_QTDRET').AsFloat > 0 Then
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
                If FieldByName('DET_QTDRET').AsFloat > 0 Then
                Begin
                  SetLength(objConsig.arrConsignacoes, Length(objConsig.arrConsignacoes) + 1);

                  intPosicao := Length(objConsig.arrConsignacoes) - 1;

                  objConsig.arrConsignacoes[intPosicao].strNumDoc := FieldByName('DET_NUMDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strEspDoc := FieldByName('DET_ESPDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodIte := FieldByName('DET_CODITE').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodEmp := FieldByName('DET_CODEMP').AsString;
                  objConsig.arrConsignacoes[intPosicao].fltQtdIte := FieldByName('DET_QTDRET').AsFloat;
                  objConsig.arrConsignacoes[intPosicao].strAutInc := FieldByName('AUTOINCREM').AsString;
                  objConsig.arrConsignacoes[intPosicao].tmTipoDeMovimento := tmDevolucaoDefinitiva;

                  If (FieldByName('DET_QTDPEN').AsFloat = FieldByName('DET_QTDRET').AsFloat) Then
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
                                                                                     FieldByName('DET_QTDRET').AsFloat, 2);

                    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fFormataFloat(FieldByName('DET_DESESP').AsFloat /
                                                                             FieldByName('DET_QTDENV').AsFloat *
                                                                             FieldByName('DET_QTDRET').AsFloat, 2);
                  End;

                  pIncrementaListaStr(objConsig.arrConsignacoes[intPosicao].strAutInc, strAutIncRemessa, True);
                End;

                Next;
              End;
            End;
          End;

          strNumLot := FieldByName('DET_NUMLOT').AsString;
          strLotAnt := '';

          fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

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
                                               FieldByName('DET_QTDRET').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat*FieldByName('DET_QTDRET').AsFloat,
                                               'E',
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2),
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                               fCalculaPrecoVenda(2, fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2), FieldByName('DET_UNITAR').AsFloat, 0, 0, 0, 0, 0),
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
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('DET_QTDRET').AsFloat,
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
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
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
                                               FieldByName('DET_QTDRET').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',

                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2),
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
                                               FieldByName('ITE_PRECUS').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('DET_QTDRET').AsFloat,
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

    fatVenda.pPreencheReferenciaRemessa(strAutIncRemessa);

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

procedure TfrmFatRetornoRemessa.FormCreate(Sender: TObject);
begin
  inherited;

  blnPostandoPai          := False;
  blnPostandoFilho        := False;

  blnNfeOutrasEntradas    := False;
  blnSempreRelerBanco     := False;
  blnSelecionaComEspaco   := True;
  blnQuoteLista           := False;
  blnMarcaTodos           := (fCfgSis('MDLVFE', varString) = '2');
  blnHabilitaScroll       := True;

  lflLastField.intIndCol  := 0;
  lflLastField.strNomCam  := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol  := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam  := ftString;

  qryCadCli               := fCriaQuery(Self);

  pCriarCdsVenda(Self);

  fatVenda                := TFatVenda.CreateInstance('DV');
  fatVenda.strOpcDocTrue  := 'ET';
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
  pnlRet.Color := COR_RET;

  pnlEnvTotSin.Color := COR_ENV;
  pnlDevTotSin.Color := COR_DEV;
  pnlPenTotSin.Color := COR_PEN;
  pnlRetTotSin.Color := COR_RET;

  pnlEnvTotAnl.Color := COR_ENV;
  pnlDevTotAnl.Color := COR_DEV;
  pnlPenTotAnl.Color := COR_PEN;
  pnlRetTotAnl.Color := COR_RET;

  btnMarcaTodos.Visible    := (fCfgSis('MDLVFE', varString) = '1');
  btnMarcaTodos.Enabled    := (fCfgSis('MDLVFE', varString) = '1');
  btnDesmarcaTodos.Visible := (fCfgSis('MDLVFE', varString) = '1');
  btnDesmarcaTodos.Enabled := (fCfgSis('MDLVFE', varString) = '1');
end;

procedure TfrmFatRetornoRemessa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fatVenda);
  FreeAndNil(cdsAnalitico);
end;

procedure TfrmFatRetornoRemessa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of

    VK_RETURN: Begin
                 If ((ActiveControl) = dbgConsulta) Then
                 Begin
                   If cdsConsulta.State = dsEdit Then
                   Begin
                     cdsConsulta.Post;
                     cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
                   End
                   Else If cdsConsulta.Active And (Not SameText(dbgConsulta.SelectedField.FieldName,'DET_QTDRET')) Then
                   Begin
                     cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
                   End;
                 End
                 Else If ((ActiveControl) = dbgAnalitico) Then
                 Begin
                   If cdsAnalitico.State = dsEdit Then
                   Begin
                     cdsAnalitico.Post;
                     cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
                   End
                   Else If cdsAnalitico.Active And (Not SameText(dbgAnalitico.SelectedField.FieldName,'DET_QTDRET')) Then
                   Begin
                     cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
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

    VK_F8: if btnSelecao.Visible then
           begin
             btnSelecao.Click;
           end;
  End;
end;

procedure TfrmFatRetornoRemessa.FormShow(Sender: TObject);
begin
  inherited;
  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;
  btnSelecao.Visible   := False;
  pSetFocus(mskDtaIni);

  If fCfgSis('MDLVFE', varString) = '2' Then
    pnlDev.Caption := 'Retornados';
end;

function TfrmFatRetornoRemessa.fSetParametros: Boolean;
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

    if not fEmptyStr(edtNumDoc.Text) then
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;

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

    if not fEmptyStr(edtNumDoc.Text) then
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  Result := True;
End;

function TfrmFatRetornoRemessa.fSQLAnalitico: String;
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
  strSQL := strSQL + '  D.DET_FORITE AS DET_CODFOR, ';
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
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0)) AS DET_QTDRET, ';
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0)) * D.DET_UNITAR AS DET_VALRET, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDRET, ';
    strSQL := strSQL + '  0.00 AS DET_VALRET, ';
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
  strSQL := strSQL + '  LEFT  JOIN (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, SUM(CON_QTDITE) AS CON_QTDITE, SUM(CON_DESESP) AS CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '              FROM (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_QTDITE, CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '                      FROM MOVCON ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + '                     INNER JOIN MOVDET ON MOVDET.AUTOINCREM = MOVCON.CON_SEQGER ';

  strSQL := strSQL + '                    UNION ALL ';
  strSQL := strSQL + '                    SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_QTDITE, CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '                      FROM NOTCON ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + '                     INNER JOIN NOTDET ON NOTDET.AUTOINCREM = NOTCON.CON_SEQGER ';

  strSQL := strSQL + '             ) AS A GROUP BY CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ', DET_CODCLI ';

  strSQL := strSQL + '              ) AS R ';
  strSQL := strSQL + '               ON R.CON_NUMDOC = D.DET_NUMDOC ';
  strSQL := strSQL + '              AND R.CON_ESPDOC = D.DET_ESPDOC ';
  strSQL := strSQL + '              AND R.CON_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + '              AND R.CON_CODITE = D.DET_CODITE ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + '              AND R.DET_CODCLI = D.DET_CODCLI ';

  strSQL := strSQL + '              AND ((R.CON_AUTICS = D.AUTOINCREM) OR (IFNULL(R.CON_AUTICS, "") = "")) ';
  strSQL := strSQL + 'LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  ((D.DET_ESPDOC = "NF" AND ';
  strSQL := strSQL + '    LOCATE(D.DET_CLAFIS,:CLAENV) > 0) OR (D.DET_ESPDOC = "ER")) ';

  strSQL := strSQL + ' AND D.DET_CODCLI = :CODCLI ';
  strSQL := strSQL + ' AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + ' AND P.ITE_CODEMP = :CODEMP ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '    AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  if not fEmptyStr(edtNumDoc.Text) then
    strSQL := strSQL + ' AND D.DET_NUMDOC = :NUMDOC ';

  strSQL := strSQL + ' ORDER BY D.DET_NUMDOC ';

  Result := strSQL;
end;

function TfrmFatRetornoRemessa.fSQLAnaliticoItensAut(strNumdoc, strCodVen,
strCodCli, strCodEmp,strEspDoc,strCodTra: string): string;
begin
  Result := '';
  Result := Result + 'SELECT D.DET_NUMDOC, C.CLI_NOMCLI, O.OPE_NOMOPE, D.DET_DTAENT, D.DET_CODEMP, ';
  Result := Result + '       D.DET_ESPDOC, D.DET_CODITE, I.ITE_DESITE, D.DET_QTDITE, G.GER_CODTRA, ';
  Result := Result + '       T.TRA_NOMTRA ';
  Result := Result + 'FROM MOVDET D ';
  Result := Result + 'INNER JOIN CADCLI C ';
  Result := Result + 'ON(D.DET_CODCLI = C.CLI_CODCLI) ';
  Result := Result + 'INNER JOIN CADOPE O ';
  Result := Result + 'ON(D.DET_CODVEN = O.OPE_CODOPE) ';
  Result := Result + 'INNER JOIN CADITE I ';
  Result := Result + 'ON(D.DET_CODITE = I.ITE_CODITE) ';
  Result := Result + 'INNER JOIN MOVGER G ';
  Result := Result + 'ON(D.DET_SEQGER = G.AUTOINCREM) ';
  Result := Result + 'LEFT JOIN CADTRA T ';
  Result := Result + 'ON(T.TRA_CODTRA = G.GER_CODTRA) ';
  Result := Result + 'WHERE D.DET_TIP_FC = "C" ';
  Result := Result + 'AND D.DET_ORIDOC = "V" ';
  Result := Result + 'AND D.DET_PROEMB <> "S" ';
  Result := Result + 'AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  Result := Result + 'AND D.DET_CODCLI NOT IN ('+VS_strCliFil+') ';
  Result := Result + 'AND ((LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaVen)+') > 0) OR (LOCATE(DET_CLAFIS, '+QuotedStr(VS_strClaDev)+') > 0)) ';
  Result := Result + 'AND (LOCATE(D.DET_ESPDOC, "TM_ML_PR_RO_") <= 0) ';

  if not fEmptyStr(strEspDoc) then
  begin
    Result := Result + 'AND D.DET_ESPDOC = '+QuotedStr(strEspDoc)+' ';
  end;

  if not fEmptyStr(strCodVen) then
  begin
    Result := Result + 'AND D.DET_CODVEN = '+QuotedStr(strCodVen)+' ';
  end;

  if not fEmptyStr(strCodEmp) then
  begin
    Result := Result + 'AND D.DET_CODEMP = '+QuotedStr(strCodEmp)+' ';
  end;

  if not fEmptyStr(strCodCli) then
  begin
    Result := Result + 'AND D.DET_CODCLI = '+QuotedStr(strCodCli)+' ';
  end;

  if not fEmptyStr(strNumdoc) then
  begin
    Result := Result + 'AND D.DET_NUMDOC = '+QuotedStr(strNumdoc)+' ';
  end;

  If Not fEmptyStr(strCodTra) Then
  Begin
    Result := Result + 'AND G.GER_CODTRA = '+QuotedStr(strCodTra)+' ';
  End;
end;

function TfrmFatRetornoRemessa.fSQLSintetico: String;
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
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
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
    strSQL := strSQL + '  SUM(DET_QTDENV - DET_QTFARE) AS DET_QTDRET, ';
    strSQL := strSQL + '  SUM(DET_QTDENV - DET_QTFARE) * (DET_UNITAR) AS DET_VALRET, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDRET, ';
    strSQL := strSQL + '  0.00 AS DET_VALRET, ';
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

function TfrmFatRetornoRemessa.fSQLSinteticoItensAut(strNumdoc,strCodVen,
         strCodCli, strCodEmp, strEspDoc, strCodTra: string): string;
begin
  Result := '';
  Result := Result + ' SELECT DET_CODITE, SUM(DET_QTDITE) AS DET_TOTITE ';
  Result := Result + ' FROM( ';
  Result := Result + fSQLAnaliticoItensAut(strNumdoc, strCodVen, strCodCli, strCodEmp, strEspDoc, strCodTra);
  Result := Result + ' ) AS TABELA ';
  Result := Result + ' GROUP BY DET_CODITE ';
end;

function TfrmFatRetornoRemessa.fValidaCampos(Sender: TWinControl;
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

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
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

      End

    End

    Else If (Sender = edtNumDoc) Then
    Begin

      If (fEmptyStr(edtNumDoc.Text)) And
         (fCfgSis('MDLVFE',varString) = '2') Then
      Begin
        fMensagem('ATENÇÃO!', 'No modelo 2 (CFG_MDLVFE) é obrigatório informar o número da nota de remessa.', ['&Ok']);
        Result := FALSE;
      End

    End;

    If (Result) And
       (Not blnBuscaPorChave) And
       (fCfgSis('MDLVFE',varString) = '2') Then
    Begin
      fMensagem('ATENÇÃO!', 'Antes de finalizar o retorno verifique se todos os faturamentos '+
                            'já foram gerados pois após emitir a nota de retorno não é mais '+
                            'permitido fazer faturamentos da remessa vinculada.', ['&Ok']);
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatRetornoRemessa.mskDtaIniEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  cdsAnalitico.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtDesCliente.Clear;
  edtNumDoc.Clear;
end;

procedure TfrmFatRetornoRemessa.pAfterInsertAnalitico(DataSet: TDataSet);
begin
  If (Not blnPodeIncluir) And (cdsAnalitico.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatRetornoRemessa.pAfterPostAnalitico(DataSet: TDataSet);
  Var
    fltQtdRet : Double;
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

      fltQtdRet := 0;
      With cdsAnalitico do
      Begin
        First;
        While Not Eof Do
        Begin
          fltQtdRet := fltQtdRet + FieldByName('DET_QTDRET').AsFloat;
          Next;
        End;

        Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP', VarArrayOf([strNumDoc,strEspDoc,strCodEmp]), []);
      End;

      With cdsConsulta do
      Begin
        Edit;
        FieldByName('DET_QTDRET').AsFloat := fltQtdRet;
        Post;
      End;

      pCalculaTotais;
    Finally
      blnPostandoFilho := False;
      blnHabilitaScroll := True;
    End;
  End;

End;

procedure TfrmFatRetornoRemessa.pBeforePostAnalitico(DataSet: TDataSet);
begin
  pSetFocus(dbgAnalitico);

  With DataSet Do
  Begin
    If (fCfgSis('MDLVFE',varString) = '2') Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
      Cancel;
      Abort;
    End
    Else
    Begin
      If (FieldByName('DET_QTDRET').AsFloat < 0) Then
      Begin
        cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
        fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
        Cancel;
        Abort;
      End
      Else If (FieldByName('DET_QTDRET').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
      Begin
        cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
        fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
        Cancel;
        Abort;
      End
      Else
        FieldByName('DET_VALRET').AsFloat := FieldByName('DET_QTDRET').AsFloat * FieldByName('DET_UNITAR').AsFloat;
    End;
  End;

  blnHabilitaScroll := False;
end;

procedure TfrmFatRetornoRemessa.pCalculaTotais(chrTip: Char);
  Var
    cdsDados : TUniClientDataSet;
    fltEnv,
    fltDev,
    fltPen,
    fltRet: Double;

  procedure pSetTotais(chrTip: Char);
  begin
    If chrTip = 'A' Then
    Begin
      pnlEnvTotAnl.Caption := FormatFloat('#,##0.00', fltEnv);
      pnlDevTotAnl.Caption := FormatFloat('#,##0.00', fltDev);
      pnlPenTotAnl.Caption := FormatFloat('#,##0.00', fltPen);
      pnlRetTotAnl.Caption := FormatFloat('#,##0.00', fltRet);
    End
    Else
    Begin
      pnlEnvTotSin.Caption := FormatFloat('#,##0.00', fltEnv);;
      pnlDevTotSin.Caption := FormatFloat('#,##0.00', fltDev);;
      pnlPenTotSin.Caption := FormatFloat('#,##0.00', fltPen);;
      pnlRetTotSin.Caption := FormatFloat('#,##0.00', fltRet);;
    End
  end;

  procedure pZera;
  begin
    fltEnv := 0;
    fltDev := 0;
    fltPen := 0;
    fltRet := 0;
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
             fltRet := fltRet + FieldByName('DET_VALRET').AsFloat;
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
             fltRet := fltRet + FieldByName('DET_VALRET').AsFloat;
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

procedure TfrmFatRetornoRemessa.pCancelaCdsConsulta;
begin
  blnHabilitaScroll := False;
  cdsConsulta.Cancel;
  blnHabilitaScroll := True;
end;

procedure TfrmFatRetornoRemessa.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text, True, False, EmptyStr, 'ET');
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
end;

function TfrmFatRetornoRemessa.fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    blnConfirma: Boolean;

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
      If Not cdsConsulta.Active Then
        Exit;

      If (Not fExisteItemSelecionado) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade para retorno não foi informada!', ['&O k']);
        Exit;
      End;

      fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);
      pInicializaTemporaria;

      fatVenda.strOpcDoc := 'ET';

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

        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                                 FAlse, False, False, VS_Date, False);

        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        fatVenda.pCalculaTotalParaCadRec;

        fatVenda.pRateiaValores;

        pAcertaDesEspItens;

        If Not fGetTipoFaturamento(fatVenda) Then
        Begin
          pInicializaTemporaria;
          Exit;
        End;

        If blnNfeOutrasEntradas Then
        Begin
          With fatVenda Do
          Begin
            dtaDtaEnt := fRetDataServidor;
            dtaDtaOri := dtaDtaEnt;
            strEntFat := 'N';
            strOriDoc := 'V';
          End;
        End;

        Result := fatVenda.fGravaArquivos;

        pInicializaTemporaria;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatRetornoRemessa.fConfirma]');
        pInicializaTemporaria;
      End;
    End;
  Finally
    cdsConsulta.EnableControls;
    pnlHeader.Enabled := True;
    pCalculaTotais;
  End;
end;

procedure TfrmFatRetornoRemessa.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  blnPostandoPai     := False;
  blnPostandoFilho   := False;
end;

procedure TfrmFatRetornoRemessa.pSelecionaItensAutomatico;
var
  dtaDataIni,
  dtaDataFin: TDate;
  strNumDoc,
  strCodVen,
  strCodCli,
  strCodEmp,
  strEspDoc,
  strCodTra: string;
  qryItensRetorno: TUniQuery;
  frmFatDigRemessaItens: TfrmFatDigRemessaItens;
  frmFatItensRetornoRemessa: TfrmFatItensRetornoRemessa;
begin
  pCriarFormularios(TfrmFatDigRemessaItens, frmFatDigRemessaItens);
  try
    frmFatDigRemessaItens.ShowModal;
    if frmFatDigRemessaItens.ModalResult = mrOK then
    begin
      dtaDataIni := StrToDate(frmFatDigRemessaItens.mskDtaIni.Text);
      dtaDataFin := StrToDate(frmFatDigRemessaItens.mskDtaFin.Text);
      strNumDoc := frmFatDigRemessaItens.edtNumDoc.Text;
      strCodVen := frmFatDigRemessaItens.edtCodVen.Text;
      strCodCli := frmFatDigRemessaItens.edtCodCliente.Text;
      strCodEmp := frmFatDigRemessaItens.edtCodEmp.Text;
      strEspDoc := frmFatDigRemessaItens.edtEspDoc.Text;
      strCodTra := frmFatDigRemessaItens.edtCodTra.Text;

      pCriarFormularios(TfrmFatItensRetornoRemessa, frmFatItensRetornoRemessa);
      qryItensRetorno := fCriaQuery;
      try
        qryItensRetorno.Close;
        qryItensRetorno.SQL.Clear;
        qryItensRetorno.SQL.Add(fSQLAnaliticoItensAut(strNumDoc,strCodVen,strCodCli,strCodEmp,strEspDoc,strCodTra));
        qryItensRetorno.ParamByName('DTAINI').AsDate := dtaDataIni;
        qryItensRetorno.ParamByName('DTAFIN').AsDate := dtaDataFin;
        qryItensRetorno.Open;

        while not qryItensRetorno.Eof do
        begin
          frmFatItensRetornoRemessa.cdsItens.Append;
          frmFatItensRetornoRemessa.cdsItensDET_NUMDOC.AsString   := qryItensRetorno.FieldByName('DET_NUMDOC').AsString;
          frmFatItensRetornoRemessa.cdsItensCLI_NOMCLI.AsString   := qryItensRetorno.FieldByName('CLI_NOMCLI').AsString;
          frmFatItensRetornoRemessa.cdsItensOPE_NOMOPE.AsString   := qryItensRetorno.FieldByName('OPE_NOMOPE').AsString;
          frmFatItensRetornoRemessa.cdsItensDET_DTAENT.AsDateTime := qryItensRetorno.FieldByName('DET_DTAENT').AsDateTime;
          frmFatItensRetornoRemessa.cdsItensDET_CODEMP.AsString   := qryItensRetorno.FieldByName('DET_CODEMP').AsString;
          frmFatItensRetornoRemessa.cdsItensDET_ESPDOC.AsString   := qryItensRetorno.FieldByName('DET_ESPDOC').AsString;
          frmFatItensRetornoRemessa.cdsItensDET_CODITE.AsString   := qryItensRetorno.FieldByName('DET_CODITE').AsString;
          frmFatItensRetornoRemessa.cdsItensDET_DESITE.AsString   := qryItensRetorno.FieldByName('ITE_DESITE').AsString;
          frmFatItensRetornoRemessa.cdsItensDET_QTDITE.AsFloat    := qryItensRetorno.FieldByName('DET_QTDITE').AsFloat;
          frmFatItensRetornoRemessa.cdsItensGER_CODTRA.AsString   := qryItensRetorno.FieldByName('GER_CODTRA').AsString;
          frmFatItensRetornoRemessa.cdsItensTRA_NOMTRA.AsString   := qryItensRetorno.FieldByName('TRA_NOMTRA').AsString;
          frmFatItensRetornoRemessa.cdsItens.Post;

          qryItensRetorno.Next;
        end;

        frmFatItensRetornoRemessa.cdsItens.Open;

        if frmFatItensRetornoRemessa.cdsItens.RecordCount > 0 then
        begin
          frmFatItensRetornoRemessa.ShowModal;
          if frmFatItensRetornoRemessa.ModalResult = mrOk then
          begin
            qryItensRetorno.Close;
            qryItensRetorno.SQL.Clear;
            qryItensRetorno.SQL.Add(fSQLSinteticoItensAut(strNumDoc,strCodVen,strCodCli,strCodEmp,strEspDoc,strCodTra));
            qryItensRetorno.ParamByName('DTAINI').AsDate := dtaDataIni;
            qryItensRetorno.ParamByName('DTAFIN').AsDate := dtaDataFin;
            qryItensRetorno.Open;

            while not qryItensRetorno.Eof do
            begin
              pSetFocus(btnSelecao);
              if cdsConsulta.Locate('DET_CODITE', qryItensRetorno.FieldByName('DET_CODITE').AsString, []) then
              begin
                if qryItensRetorno.FieldByName('DET_TOTITE').AsFloat > cdsConsulta.FieldByName('DET_QTDPEN').AsFloat then
                begin
                  cdsConsulta.Edit;
                  cdsConsulta.FieldByName('DET_QTDRET').AsFloat := cdsConsulta.FieldByName('DET_QTDPEN').AsFloat;
                  cdsConsulta.Post;
                end
                else
                begin
                  cdsConsulta.Edit;
                  cdsConsulta.FieldByName('DET_QTDRET').AsFloat := qryItensRetorno.FieldByName('DET_TOTITE').AsFloat;
                  cdsConsulta.Post;
                end;
              end;

              qryItensRetorno.Next;
            end;
          end;
        end
        else
        begin
          fMensagem('ATENÇÃO!', 'Não existe registros com os filtros informados!', ['&Ok']);
          Exit;
        end;
      finally
        FreeAndNil(qryItensRetorno);
        pFreeAndNil(frmFatItensRetornoRemessa);
      end;
    end;
  finally
    pFreeAndNil(frmFatDigRemessaItens);
  end;
end;

function TfrmFatRetornoRemessa.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  If fCfgSis('MDLVFE', varString) = '2' Then
    Exit(False);

  Result := True;

  Try
    blnMarcaTodos := False;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);
  Except
    Result := False;
  End;
end;

function TfrmFatRetornoRemessa.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  If fCfgSis('MDLVFE', varString) = '2' Then
    Exit(False);

  Result := True;

  Try
    blnMarcaTodos := True;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);
    blnMarcaTodos := False;
  Except
    Result := False;
  End;
end;

end.
