unit untAltPrecoGlobalTPO;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask, untTypesSistema,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, untFuncoesSimples,
  DB, AppEvnts, QColorLabel, UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmAltPrecoGlobalTPO = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    dbgTiposAlt: TDBGridCitel;
    pnlDadosAlt: TPanel;
    lblCamAlt: TLabel;
    edtCamAlt: TEditFocus;
    pnlBotoesEnt: TPanel;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodFor: TEditFocus;
    pgbProgresso: TProgressBar;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    Label5: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    Label7: TLabel;
    edtClaIPI: TEditFocus;
    rdgTipAlt: TRadioGroup;
    cbbTabOrigem: TComboBox;
    lbl1: TLabel;
    Label9: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    cdsAltGlo: TUniClientDataSet;
    cdsAltGloITE_DESCAM: TStringField;
    cdsAltGloITE_VALCAM: TStringField;
    cdsAltGloITE_MASCAM: TStringField;
    cdsAltGloITE_NOMCAM: TStringField;
    cdsAltGloITE_DESABR: TStringField;
    cdsAltGloITE_LIMCAM: TIntegerField;
    cdsAltGloITE_TIPCAM: TStringField;
    cdsAltGloITE_ALTERA: TStringField;
    dtsAltGlo: TDataSource;
    dspIteGlo: TUniDataSetProvider;
    cdsIteGlo: TUniClientDataSet;
    cdsAltGloITE_ORIGEM: TStringField;
    btnConfirma: TBitBtnLocked;
    btnConfirmaAlt: TBitBtnLocked;
    btnCancelaAlt: TBitBtnLocked;
    btnSairAlt: TBitBtnLocked;
    chkPenRec: TCheckBox;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    Label10: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    Label15: TLabel;
    edtAbfPis: TEditFocus;
    edtDesPis: TEditFocus;
    Label16: TLabel;
    edtAbfCof: TEditFocus;
    edtDesCof: TEditFocus;
    lblCodDep: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    procedure edtAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfPisExit(Sender: TObject);
    procedure edtAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfCofExit(Sender: TObject);

    procedure btnSairAltClick(Sender: TObject);
    procedure dbgTiposAltKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure dbgTiposAltDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaAltClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTiposAltDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    qryConAbf: TUniQuery;
    qryAbfIcm: TUniQuery;

    qryConMar: TUniQuery;
    qryConGru: TUniQuery;
    qryConUni: TUniQuery;
    blnTabPrd: Boolean;
    arrCamposGlobal: Array Of TCampoGlobal;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: TArrCampoGlobal;

    intDecUni: Integer;

    blnValPer: Boolean;

    strEstEmp : String;

    arrAbfIPI,
    arrAbfFis,
    arrMarca,
    arrAbfPis,
    arrAbfCof,
    arrFornec,
    arrGrupoPro,
    arrGruCmp,
    arrLinGrp,
    arrCodUni,
    arrCodGpr: TConsultasArray;
    arrCodDep: TConsultasArray;

    blnHouveAlteracaoPorCusto: Boolean;

    procedure pLimparTela;

    procedure pGeraClient;

    function fGeraVetorCampos: Boolean;
    procedure pCriaTabelaItens;
    function  fGeraTabelaItens: Boolean;

    procedure pAlteraValorTabelaItens(strCodIte: String; Var arrCampos: Array Of TCampoGlobal);

    
    procedure pAtribuiTabelas;

    procedure pDesmarcaCampo;
    procedure pCarregaInfoAlteracao;
    procedure pGravaValor;

    procedure pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String; varValor: Variant; strTabOri: String = '');

    function fRetornaNumeric(strMascara: String): String;
    function fRetornaCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String): TCampoGlobal;
    function fTamanhoCampo(strCampo: String):Boolean;
    procedure pMontaGrid;
    function fValidaAlteracaoAbreviacaoFiscal: Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAltPorFator: Boolean;
  end;

var
  frmAltPrecoGlobalTPO: TfrmAltPrecoGlobalTPO;

implementation

uses untPesqAux, untAltPrecoGlobalItens, untConstantes, untIcmsSTParteVenda,
     untParCalculaPrecoCusto,  untConsultas, untTConfiguracao, untFuncoesConsulta;

{$R *.dfm}

function TfrmAltPrecoGlobalTPO.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
    fltCamAlt: Double;
begin
  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        edtDesGru.Text := 'TODOS';
      End
    End

    Else If (Sender = edtCodAbr) Then
    Begin
      If fEmptyStr(edtCodAbr.Text) Then
      Begin
        edtDesAbr.Text := 'TODOS';
      End;
    End

    Else If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Text := 'TODOS';
      End;
    End

    Else If (Sender = edtCodDep) Then
    Begin
      If fEmptyStr(edtCodDep.Text) Then
      Begin
        edtDesDep.Text := 'TODOS';
      End;
    End
    {******************************************}
    {* VALIDAÇÕES DO CAMPO ONDE SÃO DIGITADOS *}
    {* OS VALORES                             *}
    {***************************************MV*}
    Else If (Sender = edtCamAlt) Then
    Begin
      {**********************************}
      {* CASO O TIPO FOR PERCETUAL  E O *}
      {* VALOR FOR NEGATIVO ZERA        *}
      {*******************************JB*}
      If (fStrToFloat(edtCamAlt.Text) < 0) And (blnValPer) Then
        edtCamAlt.Text := '0';

      strNomCam := cdsAltGlo.FieldByName('ITE_NOMCAM').AsString;
      strMasCam := cdsAltGlo.FieldByName('ITE_MASCAM').AsString;

      If (strNomCam = 'ITE_PREVE1') Or
         (strNomCam = 'ITE_PREVE2') Or
         (strNomCam = 'ITE_PREVE3') Or
         (strNomCam = 'ITE_PREVE4') Or
         (strNomCam = 'ITE_PREVE5') Or
         (strNomCam = 'ITE_PREVE6') Or
         (strNomCam = 'ITE_PREVE7') Then
      Begin

        If (Not fEmptyStr(edtCamAlt.Text)) Then
        Begin
          fltCamAlt := fStrToFloat(edtCamAlt.Text);
          edtCamAlt.Text := FormatFloat(strMasCam, fltCamAlt);

          If blnAltPorFator Then
          Begin
            If (Int(fStrToFloat(edtCamAlt.Text)) < 0) Then
            Begin
              Result := False;
            End;
          End;

        End;

      End

      Else If (Not fEmptyStr(edtCamAlt.Text)) And
              (Not fEmptyStr(strMasCam))      Then
      Begin
        edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));
      End;

    End

    Else If Sender = edtStatus Then
    Begin

      If Pos(edtStatus.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltPrecoGlobalTPO.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlBotoesEnt) Or
     (ActiveControl.Parent = pnlDadosAlt)  Then
  Begin
    btnCancelaAlt.Click;
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pGeraClient;
  Var
    intContador: Integer;
begin
  If cdsAltGlo.Active Then
    cdsAltGlo.EmptyDataSet;

  cdsAltGlo.Open;
  pSetaClient(cdsAltGlo);

  With cdsAltGlo Do
  For intContador := 0 To Length(arrCamposGlobal) -1 Do
  Begin

    If (Pos('ITE_MARBR', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    If (Pos('ITE_PRECUS', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    Append;
    FieldByName('ITE_DESCAM').AsString  := arrCamposGlobal[intContador].strDesCam;
    FieldByName('ITE_VALCAM').Value     := arrCamposGlobal[intContador].varValCam;
    FieldByName('ITE_MASCAM').AsString  := arrCamposGlobal[intContador].strMasCam;
    FieldByName('ITE_NOMCAM').AsString  := arrCamposGlobal[intContador].strNomCam;
    FieldByName('ITE_DESABR').AsString  := arrCamposGlobal[intContador].strDesAbr;
    FieldByName('ITE_ORIGEM').AsString  := arrCamposGlobal[intContador].strOrigem;
    FieldByName('ITE_LIMCAM').AsInteger := arrCamposGlobal[intContador].intLimCam;
    FieldByName('ITE_TIPCAM').AsString  := arrCamposGlobal[intContador].strTipCam;
    Post;
    
  End;

  cdsAltGlo.First;
end;

procedure TfrmAltPrecoGlobalTPO.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);
  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConAbf := qryAbfIcm;
end;

procedure TfrmAltPrecoGlobalTPO.btnSairAltClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoGlobalTPO.dbgTiposAltKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin

    pSetFocus(mskLinGru);

  End
  Else If (Key = VK_Return) Then
  Begin

    If cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S' Then
      pDesmarcaCampo
    Else
      pCarregaInfoAlteracao;

  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pGravaValor;
begin
  With cdsAltGlo Do
  Begin
    Edit;

    FieldByName('ITE_VALCAM').AsString := edtCamAlt.Text;

    If fEmptyStr(edtCamAlt.Text) Then
      FieldByName('ITE_ALTERA').AsString := 'N'
    Else
      FieldByName('ITE_ALTERA').AsString := 'S';

    If cbbTabOrigem.ItemIndex >= 0 Then
      FieldByName('ITE_ORIGEM').AsString := cbbTabOrigem.Text;

    Post;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.btnConfirmaAltClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(edtCamAlt, False) Then
  Begin

    {*******************************************}
    {* VERIFICA SE FOI INFORMADO ALGUMA TABELA *}
    {****************************************IV*}
    If cbbTabOrigem.ItemIndex = -1 Then
    Begin
      pSetFocus(cbbTabOrigem);
      Exit;
    End;

    {*******************************************}
    {* VERIFICA O TAMANHO DO CAMPO PARA PODER  *}
    {* GRAVAR CORRETAMENTO.                    *}
    {****************************************AC*}
    If (Not fTamanhoCampo(edtCamAlt.Text)) Then
    Begin
      pSetFocus(edtCamAlt);
      Exit;
    End;

    pGravaValor;
    pSetFocus(dbgTiposAlt);
    lblCamAlt.Caption := '';
    edtCamAlt.Clear;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pCarregaInfoAlteracao;
begin
  With cdsAltGlo Do
  Begin

    lblCamAlt.Caption := FieldByName('ITE_DESCAM').AsString;
    edtCamAlt.Clear;

    {**********************************************}
    {* VERIFICAR SE O TIPO DE VALOR EH PERCENTUAL *}
    {*******************************************JB*}
    blnValPer := LeftStr(FieldByName('ITE_DESCAM').AsString, 1) = '%';

    If (Not fEmptyStr(FieldByName('ITE_MASCAM').AsString)) Or (FieldByName('ITE_TIPCAM').AsString = 'INTEGER') Then
      edtCamAlt.TipoTexto := ttNumerico
    Else
      edtCamAlt.TipoTexto := ttAlfanumerico;

    edtCamAlt.MaxLength := FieldByName('ITE_LIMCAM').AsInteger;

    pSetFocus(cbbTabOrigem);

  End;
end;

procedure TfrmAltPrecoGlobalTPO.dbgTiposAltDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not cdsAltGlo.Active Then
    Exit;
  With cdsAltGlo Do
  Begin
    If FieldByName('ITE_ALTERA').AsString = 'S' Then
      dbgTiposAlt.Canvas.Font.Color := clBlue;
  End;
  dbgTiposAlt.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmAltPrecoGlobalTPO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryAbfIcm);
  FreeAndNil(cdsAltGlo);
  FreeAndNil(cdsIteGlo);
end;

procedure TfrmAltPrecoGlobalTPO.pDesmarcaCampo;
begin
  pGravaValor; //Grava em branco.
end;

procedure TfrmAltPrecoGlobalTPO.btnCancelaAltClick(Sender: TObject);
begin
  inherited;
  lblCamAlt.Caption := '';
  edtCamAlt.Clear;
  pSetFocus(dbgTiposAlt);
end;

procedure TfrmAltPrecoGlobalTPO.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidaAlteracaoAbreviacaoFiscal Then
    Exit;

  blnConfirma := False;

  Screen.Cursor := crHourGlass;

  btnConfirmaAlt.Enabled := False;
  btnConfirma.Enabled    := False;
  btnCancelaAlt.Enabled  := False;
  btnSairAlt.Enabled     := False;

  If cdsIteGlo.Active Then
    cdsIteGlo.EmptyDataSet;

  If (Not fGeraVetorCampos) Then
  Begin
    fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
    btnConfirmaAlt.Enabled := True;
    btnConfirma.Enabled    := True;
    btnCancelaAlt.Enabled  := True;
    btnSairAlt.Enabled     := True;
    Screen.Cursor          := crDefault;
    Exit;
  End;

  pCriaTabelaItens;

  If fGeraTabelaItens Then
  Begin

    Try

      pCriarFormularios(TfrmAltPrecoGlobalItens, frmAltPrecoGlobalItens);
      frmAltPrecoGlobalItens.dtsItens.DataSet := cdsIteGlo;
      frmAltPrecoGlobalItens.blnTrataTPO := True;
      frmAltPrecoGlobalItens.blnTabPrd := blnTabPrd;
      frmAltPrecoGlobalItens.blnMostrarColunaPRECUS := blnHouveAlteracaoPorCusto;
      frmAltPrecoGlobalItens.arrCamposGrid := arrCamposGrid;
      frmAltPrecoGlobalItens.showModal;

      blnConfirma := frmAltPrecoGlobalItens.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAltPrecoGlobalTPO.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmAltPrecoGlobalItens);

  End;

  btnConfirmaAlt.Enabled := True;
  btnConfirma.Enabled    := True;
  btnCancelaAlt.Enabled  := True;
  btnSairAlt.Enabled     := True;
  Screen.Cursor          := crDefault;

  If blnConfirma Then
  Begin
    pLimparTela;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pCriaTabelaItens;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intContador: integer;
begin

  {***************************************************************************************************}
  { AO ALTERAR O SELECT, VALIDAR A UNIT untAltPrecoGlobal - TfrmAltPrecoGlobal.pCriaTabelaItens       }
  { PARA NÃO GERAR ERRO DE FALTA DE CAMPO.                                                            }
  {***************************************************************************************************}

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_UNICOM, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
  strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '      AND I.ITE_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
  strSQL := strSQL + ' AS ITE_POSEMB, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR1", ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR2", ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR3", ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR4", ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR5", ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR6", ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR7", ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
  strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
  strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_CUSVAR", ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';

  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
  strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
  strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
  strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
  strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
  strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
  strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
  strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
  strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
  strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
  strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';
  strSQL := strSQL + '  I.ITE_MLTCOM AS "ITE_MLTCOM_NOV", ';
  strSQL := strSQL + '  I.ITE_MLTVEN AS "ITE_MLTVEN_NOV", ';
  strSQL := strSQL + '  I.ITE_MSGLV1 AS "ITE_MSGLV1_NOV", ';
  strSQL := strSQL + '  I.ITE_MSGLV2 AS "ITE_MSGLV2_NOV", ';
  strSQL := strSQL + '  I.ITE_ITEPIG AS "ITE_ITEPIG_NOV", ';
  strSQL := strSQL + '  I.ITE_CNV_ML AS "ITE_CNV_ML_NOV", ';
  strSQL := strSQL + '  I.ITE_FATCNV AS "ITE_FATCNV_NOV", ';
  strSQL := strSQL + '  I.ITE_PESOIT AS "ITE_PESOIT_NOV", ';
  strSQL := strSQL + '  I.ITE_PESLIQ AS "ITE_PESLIQ_NOV", ';
  strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
  strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
  strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", ';
  strSQL := strSQL + '  I.ITE_CODGPR AS "ITE_CODGPR_NOV", ';
  strSQL := strSQL + '  I.ITE_MENFIS AS "ITE_MENFIS_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPPOK AS "ITE_EXPPOK_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPAPP AS "ITE_EXPAPP_NOV", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", ';
  If blnTabPrd Then
  begin
    For intContador := 1 To Length(VS_strTabPrc) Do
    begin
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")  AS ITE_PREDOL' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")  AS ITE_CODABF' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM)  AS ITE_PRECOM' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01)  AS ITE_DESF01' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02)  AS ITE_DESF02' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03)  AS ITE_DESF03' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04)  AS ITE_DESF04' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05)  AS ITE_DESF05' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06)  AS ITE_DESF06' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT)  AS ITE_ICMENT' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED)  AS ITE_SUBFED' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT)  AS ITE_IPIENT' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT)  AS ITE_FREENT' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE)  AS ITE_VALFRE' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN)  AS ITE_ACRFIN' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB)  AS ITE_DESADB' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS)  AS ITE_PRECUS' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL)  AS ITE_OUTVAL' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI)  AS ITE_ICMSAI' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED)  AS ITE_IMPFED' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE)  AS ITE_DESOPE' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU)  AS ITE_TCIFCU' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST)  AS ITE_TSCUST' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO)  AS ITE_DEPICO' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS)  AS ITE_DEICMS' + IntToStr(intContador) + '_NOV,';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG)  AS ITE_FATREG' + IntToStr(intContador) + '_NOV,';

      strSQL := strSQL + '  IF(IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1))AS ITE_CNVCUS'+ IntToStr(intContador)+',';
      strSQL := strSQL + '  DC' + IntToStr(intContador) + '.DET_SEQDET AS  DETCUS_AUTOINCREM_' + IntToStr(intContador) + ',';
    End;
  End;

  strSQL := strSQL + '  "M" AS ITE_MARDES                 ';
  strSQL := strSQL + ' FROM CADITE I ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE';
  If blnTabPrd Then
  begin
    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + ' LEFT JOIN ITEFOR F' + IntToStr(intContador) + '  ON F' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                 AND F' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + ' LEFT JOIN TABDET D' + IntToStr(intContador) + ' ON D' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + ' LEFT JOIN DETCUS DC' + IntToStr(intContador) + ' ON DC' + IntToStr(intContador) + '.DET_SEQDET = D' + IntToStr(intContador) + '.AUTOINCREM ';
      strSQL := strSQL + '                                                 AND DC' + IntToStr(intContador) + '.DET_TABELA = "' + IntToStr(intContador) + '" ';
    End;
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '  I.ITE_CODITE IS NULL AND ';
  strSQL := strSQL + '  G.ITE_CODEMP IS NULL ';

  qryGen := fCriarQuery(strSQL, Self);
  qryGen.Open;
  pSetaClient(qryGen);
  dspIteGlo.DataSet := qryGen;

  cdsIteGlo.Close;
  cdsIteGlo.Open;

  FreeAndNil(qryGen);
end;

function TfrmAltPrecoGlobalTPO.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
begin
  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';
end;

function TfrmAltPrecoGlobalTPO.fRetornaCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  Fillchar(Result, SizeOf(Result), #0);
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;
end;

{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}
function TfrmAltPrecoGlobalTPO.fGeraTabelaItens: Boolean;
  Var
    strSQL,
    strAbfFis,
    strAbfIPI,
    strMarca,
    strAbfPis,
    strAbfCof,
    strFornec,
    strPrdGru,
    strGruCmp,
    strCodGpr,
    strCodDep,
    strLinGru,
    strCodUni: String;
    intTamMat: Integer;
    qryGenIte: TUniQuery;

    intContador     : Integer;
    strCamAtu       : String;
    strCamOri       : String;
    strTabDes       : String;
    varValAtu       : Variant;
    varValorRegAtual: Variant;

    fltMarBr1Nov: Double;
    fltMarBr2Nov: Double;
    fltMarBr3Nov: Double;
    fltMarBr4Nov: Double;
    fltMarBr5Nov: Double;
    fltMarBr6Nov: Double;
    fltMarBr7Nov: Double;
    strTabela: string;

    arrRegistroAtual: Array Of TCampoGlobal;

    cpcParams : TParCalculaPrecoCusto;

    fltPreComLiq : Double;
    fltIcmsST : Double;
    blnAlterandoPorCusto: Boolean;
    blnCalcSt : Boolean;
    strCodSit : String;

    procedure pAdicionaCampoGrid(strNomeCampo: String);
      Var
        intTamMatCampos: Integer;
        intContadorLocal: integer;
        recGlobal: TCampoGlobal;
    begin
      recGlobal := fRetornaCampoPorNome(arrCamposGlobal, strNomeCampo);

      If Not recGlobal.strNomCam.IsEmpty Then
      Begin
        intTamMatCampos := Length(arrCamposGrid);

        For intContadorLocal := 0 To intTamMatCampos -1 Do
          If arrCamposGrid[intContadorLocal].strNomCam = strNomeCampo Then
            Exit;

        SetLength(arrCamposGrid, intTamMatCampos+1);
        arrCamposGrid[intTamMatCampos] := recGlobal;
      End;
    end;
begin
  Try

    qryGenIte := fCriaQuery(Self);

    blnHouveAlteracaoPorCusto := False;

    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    Result := True;
    
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_UNICOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
    strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '      AND I.ITE_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
    strSQL := strSQL + ' AS ITE_POSEMB, ';

    strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
    strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
    strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
    strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR1, ';
    strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR2, ';
    strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR3, ';
    strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR4, ';
    strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR5, ';
    strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR6, ';
    strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR7, ';
    strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB1, ';
    strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB2, ';
    strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB3, ';
    strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB4, ';
    strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB5, ';
    strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB6, ';
    strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB7, ';
    strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';

    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
    strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
    strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
    strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
    strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
    strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
    strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
    strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
    strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
    strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
    strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
    strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
    strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';
    strSQL := strSQL + '  I.ITE_MLTCOM AS "ITE_MLTCOM_NOV", ';
    strSQL := strSQL + '  I.ITE_MLTVEN AS "ITE_MLTVEN_NOV", ';
    strSQL := strSQL + '  I.ITE_MSGLV1 AS "ITE_MSGLV1_NOV", ';
    strSQL := strSQL + '  I.ITE_MSGLV2 AS "ITE_MSGLV2_NOV", ';
    strSQL := strSQL + '  I.ITE_ITEPIG AS "ITE_ITEPIG_NOV", ';
    strSQL := strSQL + '  I.ITE_CNV_ML AS "ITE_CNV_ML_NOV", ';
    strSQL := strSQL + '  I.ITE_FATCNV AS "ITE_FATCNV_NOV", ';
    strSQL := strSQL + '  I.ITE_PESOIT AS "ITE_PESOIT_NOV", ';
    strSQL := strSQL + '  I.ITE_PESLIQ AS "ITE_PESLIQ_NOV", ';
    strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
    strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP_NOV", ';
    strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", ';
    strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", ';
    strSQL := strSQL + '  I.ITE_CODGPR AS "ITE_CODGPR_NOV", ';
    strSQL := strSQL + '  I.ITE_MENFIS AS "ITE_MENFIS_NOV", ';
    strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT_NOV", ';
    strSQL := strSQL + '  I.ITE_EXPPOK AS "ITE_EXPPOK_NOV", ';
    strSQL := strSQL + '  I.ITE_EXPAPP AS "ITE_EXPAPP_NOV", ';
    If blnTabPrd Then
    begin
      For intContador := 1 To Length(VS_strTabPrc) Do
      begin
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")  AS ITE_PREDOL' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")  AS ITE_CODABF' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM)  AS ITE_PRECOM' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01)  AS ITE_DESF01' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02)  AS ITE_DESF02' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03)  AS ITE_DESF03' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04)  AS ITE_DESF04' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05)  AS ITE_DESF05' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06)  AS ITE_DESF06' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT)  AS ITE_ICMENT' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED)  AS ITE_SUBFED' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT)  AS ITE_IPIENT' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT)  AS ITE_FREENT' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE)  AS ITE_VALFRE' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN)  AS ITE_ACRFIN' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB)  AS ITE_DESADB' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS)  AS ITE_PRECUS' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL)  AS ITE_OUTVAL' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI)  AS ITE_ICMSAI' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED)  AS ITE_IMPFED' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE)  AS ITE_DESOPE' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU)  AS ITE_TCIFCU' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST)  AS ITE_TSCUST' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO)  AS ITE_DEPICO' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS)  AS ITE_DEICMS' + IntToStr(intContador) + '_NOV,';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG)  AS ITE_FATREG' + IntToStr(intContador) + '_NOV,';

        strSQL := strSQL + '  IF(IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1))AS ITE_CNVCUS'+ IntToStr(intContador)+',';
        strSQL := strSQL + '  DC' + IntToStr(intContador) + '.DET_SEQDET AS  DETCUS_AUTOINCREM_' + IntToStr(intContador) + ',';
      End;
    End;

    strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV"  ';

    strSQL := strSQL + ' FROM CADITE I ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
    If blnTabPrd Then
    begin
      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        strSQL := strSQL + ' LEFT JOIN ITEFOR F' + IntToStr(intContador) + ' ON F' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
        strSQL := strSQL + '                                                AND F' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
        strSQL := strSQL + ' LEFT JOIN TABDET D' + IntToStr(intContador) + ' ON D' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
        strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
        strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
        strSQL := strSQL + ' LEFT JOIN DETCUS DC' + IntToStr(intContador) + ' ON DC' + IntToStr(intContador) + '.DET_SEQDET = D' + IntToStr(intContador) + '.AUTOINCREM ';
        strSQL := strSQL + '                                                 AND DC' + IntToStr(intContador) + '.DET_TABELA = "' + IntToStr(intContador) + '" ';
      End;
    End;

    strSQL := strSQL + 'WHERE ';

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      strSQL := strSQL + '  I.ITE_DESITE LIKE :DESITE AND ';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      strSQL := strSQL + '  I.ITE_REFERE LIKE :REFERE AND ';
    End;

    If (chkPenRec.Checked) Then
      strSQL := strSQL + ' G.ITE_PEFAVE = "N" AND ';


    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP ';

    If (Pos(edtStatus.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = :ITEATI ';

    If fCfgSIs('TPABPC') = '1' Then
      strSQL := strSQL + fStrLocate(edtAbfPis, arrAbfPis, 'I.ITE_ABFPIS', 'ABFPIS')
    Else
      strSQL := strSQL + fStrLocate(edtAbfPis, arrAbfPis, 'G.ITE_ABFPIS', 'ABFPIS');

    If fCfgSIs('TPABPC') = '1' Then
      strSQL := strSQL + fStrLocate(edtAbfCof, arrAbfCof, 'I.ITE_ABFCOF', 'ABFCOF')
    Else
      strSQL := strSQL + fStrLocate(edtAbfCof, arrAbfCof, 'G.ITE_ABFCOF', 'ABFCOF');

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + fStrLocate(edtCodAbr, arrAbfFis, 'I.ITE_CODABF', 'CODABF')
    Else
      strSQL := strSQL + fStrLocate(edtCodAbr, arrAbfFis, 'G.ITE_CODABF', 'CODABF');

    strSQL := strSQL + fStrLocate(edtClaIPI, arrAbfIPI, 'I.ITE_CLAIPI', 'CLAIPI');
    strSQL := strSQL + fStrLocate(edtCodMar,  arrMarca, 'I.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtCodFor , arrFornec,   'I.ITE_CODFOR', 'CODFOR');
    strSQL := strSQL + fStrLocate(edtPrdGru , arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');
    strSQL := strSQL + fStrLocate(edtGruCmp , arrGruCmp  , 'I.ITE_GRUCMP', 'GRUCMP');
    strSQL := strSQL + fStrLocate(edtCodGpr , arrCodGpr  , 'I.ITE_CODGPR', 'CODGPR');
    strSQL := strSQL + fStrLocate(edtCodDep , arrCodDep  , 'I.ITE_CODDEP', 'CODDEP');
    strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGrp, 'ITE_CODGRU','CODGRU');
    strSQL := strSQL + fStrLocate(edtCodUni , arrCodUni  , 'I.ITE_CODUNI', 'CODUNI');


    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtDesIte.Text) Then
      Begin
        ParamByName('DESITE').AsString := edtDesIte.Text + '%';
      End;

      If Not fEmptyStr(edtRefere.Text) Then
      Begin
        ParamByName('REFERE').AsString := edtRefere.Text;
      End;

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Pos(edtStatus.Text, 'SN') > 0) Then
        ParamByName('ITEATI').AsString := edtStatus.Text;


      pSetaParam(edtCodMar.Text   , arrMarca,   strMarca,  'CODMAR', qryGenIte);
      pSetaParam(edtCodAbr.Text   , arrAbfFis,  strAbfFis, 'CODABF', qryGenIte);
      pSetaParam(edtClaIPI.Text   , arrAbfIPI,  strAbfIPI, 'CLAIPI', qryGenIte);

      pSetaParam(edtCodFor.Text   , arrFornec,     strFornec, 'CODFOR', qryGenIte);
      pSetaParam(edtPrdGru.Text   , arrGrupoPro,   strPrdGru, 'PRDGRU', qryGenIte);
      pSetaParam(edtGruCmp.Text   , arrGruCmp,     strGruCmp, 'GRUCMP', qryGenIte);
      pSetaParam(edtCodGpr.Text   , arrCodGpr,     strCodGpr, 'CODGPR', qryGenIte);
      pSetaParam(edtCodDep.Text   , arrCodDep,     strCodDep, 'CODDEP', qryGenIte);
      pSetaParam(edtAbfPis.Text   , arrAbfPis,     strAbfPis, 'ABFPIS', qryGenIte);
      pSetaParam(edtAbfCof.Text   , arrAbfPis,     strAbfCof, 'ABFCOF', qryGenIte);
      pSetaParam(mskLinGru.Text   , arrLinGrp,     strLinGru, 'CODGRU', qryGenIte);
      pSetaParam(edtCodUni.Text   , arrCodUni,     strCodUni, 'CODUNI', qryGenIte);

      Open;
      pSetaClient(qryGenIte);

      {*****************************************}
      {* CASO NÃO HAJA ITENS COM O FILTRO      *}
      {**************************************MV*}
      If IsEmpty Then
      Begin
        Result := False;
        fMensagem('', 'Não há dados itens para serem alterados!', ['&O k']);
        Exit;
      End;

      pgbProgresso.Visible := True;
      pgbProgresso.Max     := (RecordCount * Length(arrCamposTabela));

      While Not Eof Do
      Begin

        SetLength(arrRegistroAtual, 0);

        For intContador := 0 To FieldCount -1 Do
        Begin

          intTamMat := Length(arrRegistroAtual);
          SetLength(arrRegistroAtual, intTamMat+1);
          arrRegistroAtual[intTamMat].strNomCam := Fields[intContador].FieldName;
          arrRegistroAtual[intTamMat].varValCam := Fields[intContador].Value;

          If (Fields[intContador].DataType = ftString) Then
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR';
          End
          Else
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';
          End;

          If arrRegistroAtual[intTamMat].varValCam = Null Then
          Begin
            If (Fields[intContador].DataType = ftString) Then
            Begin
              arrRegistroAtual[intTamMat].varValCam := ''
            End
            Else
            Begin
              arrRegistroAtual[intTamMat].varValCam := 0.0;
            End;
          End;

        End;

        intTamMat := Length(arrCamposTabela);

        intContador := 0;

        While intContador < intTamMat Do
        Begin

          strCamAtu := arrCamposTabela[intContador].strNomCam;
          blnAlterandoPorCusto := False;
          If arrCamposTabela[intContador].strOrigem = 'Preço de custo' then
          Begin
            blnAlterandoPorCusto := True;
            If Not blnHouveAlteracaoPorCusto Then
              blnHouveAlteracaoPorCusto := True;

            strCamOri := RightStr(strCamAtu, 1);
          End
          Else
            strCamOri := RightStr(arrCamposTabela[intContador].strOrigem, 1);
          varValAtu := arrCamposTabela[intContador].varValCam;

          pAdicionaCampoGrid(strCamAtu);
          varValorRegAtual := fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PREVE' + strCamOri + '_NOV').varValCam;

          strTabela := RightStr(strCamAtu, 1);

          If blnTabPrd Then
          Begin
            fltPreComLiq := fCalculaPrecoCompraLiq(fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECOM'+strTabela+'_NOV').varValCam /
                                                      fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+strTabela).varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF01'+strTabela+'_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF02'+strTabela+'_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF03'+strTabela+'_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF04'+strTabela+'_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF05'+strTabela+'_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF06'+strTabela+'_NOV').varValCam,
                                                   intDecUni,
                                                   (fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PREDOL'+strTabela+'_NOV').varValCam = 'S'));

            strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CODABF'+strTabela+'_NOV').varValCam, strEstEmp]);
            fltIcmsST := fGetIcmsSTParteVenda(fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CODABF_NOV').varValCam,
                                              '_SAI_CCO', strCodSit, strEstEmp,
                                              fltPreComLiq, fRetornaCampoPorNome(arrRegistroAtual, 'ITE_IPIENT'+strTabela+'_NOV').varValCam,
                                              fRetornaCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+strTabela+'_NOV').varValCam,
                                              strEstEmp, blnCalcSt);

            {*****************************************}
            {* RECALCULA O PREÇO DE VENDA 1          *}
            {**************************************MV*}




            If Pos(strCamAtu, 'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7') > 0 Then // ver (not blnAltPreve1)
            Begin
              If blnAlterandoPorCusto Then

                pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV',  (fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECUS'+strTabela+'_NOV').varValCam /
                                                                                     fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+strTabela).varValCam)
                                                                                     * varValAtu)
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV', varValorRegAtual * varValAtu);

              fltMarBr1Nov := fCalculaPrecoVenda(2, ((fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECUS'+strTabela+'_NOV').varValCam +
                                                      fRetornaCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL'+strTabela+'_NOV').varValCam) /
                                                      fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+strTabela).varValCam),
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_MARBR'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_IMPFED'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESOPE'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_COMTB'+strTabela+'_NOV').varValCam,
                                                    '',
                                                    '',
                                                    -1,
                                                    fltIcmsST,
                                                    blnCalcSt);


              pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR'+strTabela+'_NOV', fltMarBr1Nov);
              pAdicionaCampoGrid('ITE_MARBR'+strTabela);
            End;
          End
          Else
          Begin
            fltPreComLiq := fCalculaPrecoCompraLiq(fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECOM_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF01_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF02_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF03_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF04_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF05_NOV').varValCam,
                                                   fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESF06_NOV').varValCam,
                                                   intDecUni,
                                                   (fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PREDOL_NOV').varValCam = 'S'));

            strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CODABF_NOV').varValCam, strEstEmp]);
            fltIcmsST := fGetIcmsSTParteVenda(fRetornaCampoPorNome(arrRegistroAtual, 'ITE_CODABF_NOV').varValCam,
                                              '_SAI_CCO', strCodSit, strEstEmp,
                                              fltPreComLiq, fRetornaCampoPorNome(arrRegistroAtual, 'ITE_IPIENT_NOV').varValCam,
                                              fRetornaCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam,
                                              strEstEmp, blnCalcSt);

            {*****************************************}
            {* RECALCULA O PREÇO DE VENDA 1          *}
            {**************************************MV*}




            If Pos(strCamAtu, 'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7') > 0 Then // ver (not blnAltPreve1)
            Begin
              strTabela := RightStr(strCamAtu, 1);
              If blnAlterandoPorCusto Then

                pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV',  fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECUS_NOV').varValCam * varValAtu)
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV', varValorRegAtual * varValAtu);

              fltMarBr1Nov := fCalculaPrecoVenda(2, fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PRECUS_NOV').varValCam +
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_PREVE'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_MARBR'+strTabela+'_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_IMPFED_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_DESOPE_NOV').varValCam,
                                                    fRetornaCampoPorNome(arrRegistroAtual, 'ITE_COMTB'+strTabela+'_NOV').varValCam,
                                                    '',
                                                    '',
                                                    -1,
                                                    fltIcmsST,
                                                    blnCalcSt);


              pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR'+strTabela+'_NOV', fltMarBr1Nov);
              pAdicionaCampoGrid('ITE_MARBR'+strTabela);


            End;
          End;

          pgbProgresso.StepBy(1);
          Inc(intContador);
          Application.ProcessMessages;

        End;

        pAlteraValorTabelaItens(FieldByName('ITE_CODITE').AsString, arrRegistroAtual);

        Next;

      End;
      Close;

    End;

    pgbProgresso.Position := 0;
    pgbProgresso.Visible  := False;

  Finally
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenIte);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant; strTabOri: String = '');
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;

  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      arrCampos[intContador].varValCam := varValor;

      If strTabOri <> '' Then
        arrCampos[intContador].strOrigem := strTabOri;

      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltPrecoGlobalTPO.fGeraVetorCampos: Boolean;
  Var
    intTamMat: Integer;
begin
  SetLength(arrCamposTabela, 0);
  SetLength(arrCamposGrid, 0);

  With cdsAltGlo Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin

      If (FieldByName('ITE_ALTERA').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      pAtualizaValorCampo( arrCamposGlobal, FieldByName('ITE_NOMCAM').AsString,
                           FieldByName('ITE_VALCAM').Value, FieldByName('ITE_ORIGEM').AsString );

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := FieldByName('ITE_DESCAM').AsString;
      arrCamposTabela[intTamMat].varValCam := FieldByName('ITE_VALCAM').Value;
      arrCamposTabela[intTamMat].strMasCam := FieldByName('ITE_MASCAM').AsString;
      arrCamposTabela[intTamMat].strNomCam := FieldByName('ITE_NOMCAM').AsString;
      arrCamposTabela[intTamMat].strDesAbr := FieldByName('ITE_DESABR').AsString;
      arrCamposTabela[intTamMat].strOrigem := FieldByName('ITE_ORIGEM').AsString;
      arrCamposTabela[intTamMat].intLimCam := FieldByName('ITE_LIMCAM').AsInteger;
      arrCamposTabela[intTamMat].strTipCam := FieldByName('ITE_TIPCAM').AsString;

      Next;

    End;

    EnableControls;
  End;

  Result := (Length(arrCamposTabela) > 0);
end;

procedure TfrmAltPrecoGlobalTPO.pAlteraValorTabelaItens(strCodIte: String;
  Var arrCampos: Array Of TCampoGlobal);
  Var
    intContador: Integer;
    intTamMat  : Integer;
begin
  intTamMat := Length(arrCampos);
  intContador := 0;

  With cdsIteGlo Do
  Begin
    Append;
    FieldByName('ITE_MARDES').AsString := 'M';

    While intContador < intTamMat Do
    Begin
      If Pos('CHAR', arrCampos[intContador].strTipCam) > 0 Then
        FieldByName(arrCampos[intContador].strNomCam).AsString := arrCampos[intContador].varValCam

      Else If FieldByName(arrCampos[intContador].strNomCam).DataType = ftFloat Then
        FieldByName(arrCampos[intContador].strNomCam).AsFloat := fStrToFloat(arrCampos[intContador].varValCam)

      Else If FieldByName(arrCampos[intContador].strNomCam).DataType = ftInteger Then
        FieldByName(arrCampos[intContador].strNomCam).AsInteger := Trunc(fStrToFloat(arrCampos[intContador].varValCam));

      Inc(intContador);
    End;

    Post;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGrp, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAltPrecoGlobalTPO.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinGrp, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobalTPO.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, nil, arrCodUni ,fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmAltPrecoGlobalTPO.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, qryConUni, Key, arrCodUni, False) Then
  Begin
    if fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobalTPO.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobalTPO.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmAltPrecoGlobalTPO.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAltPrecoGlobalTPO.edtCodGprKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.dbgTiposAltDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgTiposAltKeyDown(Sender, Key, State);
end;

procedure TfrmAltPrecoGlobalTPO.FormShow(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  lblCamAlt.Caption := '';
  pAtribuiTabelas;

  For intCont := 1 to 7 do
    If VS_strTabPrc[intCont] = 'S' Then
      cbbTabOrigem.AddItem('Tabela ' + IntToStr(intCont), Self);

  If Not blnTabPrd Then
    cbbTabOrigem.AddItem('Preço de custo', Self);
  pMontaGrid;

  chkPenRec.Visible := fCfgSis('CLPVDI', varBoolean);

  strEstEmp := fCadEmp('ESTADO');
end;

procedure TfrmAltPrecoGlobalTPO.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

    If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then    
    Begin
      pSetFocus(edtRefere);
    End;

end;

procedure TfrmAltPrecoGlobalTPO.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAltPrecoGlobalTPO.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAltPrecoGlobalTPO.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAltPrecoGlobalTPO.fTamanhoCampo(strCampo: String): Boolean;
  Var
    intTamanho: Integer;
begin
  intTamanho := cdsAltGlo.FieldByName('ITE_LIMCAM').AsInteger;

  If Length(strCampo) > intTamanho Then
  Begin
    fMensagem('ATENÇÃO!', 'Número Máximo de Caracteres tem que ser igual á : '+ IntToStr(intTamanho), ['&O k']);
    Result := False;
  End
  Else
    Result := True;
end;

procedure TfrmAltPrecoGlobalTPO.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, qryConAbf, Key, arrAbfFis, false) Then
  Begin
    If fValidaCampos(edtCodAbr, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmAltPrecoGlobalTPO.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep,    arrCodGpr, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmAltPrecoGlobalTPO.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pMontaGrid;
  Var
    intPosMat: Integer;
    strMasVal: String;
    strMasFat: String;
    strMasPer: String;
    strMasInt: String;
    strMasMar: String;
    strMasMBr: String;

  function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;
begin
  strMasVal := '#,##0.0000';
  strMasFat := '#,##0.0000';
  strMasMar := '#,##0.000';
  strMasMBr := '#,##0.000';
  strMasPer := '#,##0.00';
  strMasInt := '#,##0';

  If fRetPrecisaoMargemItem > 2 Then
    strMasMBr := fMskDigitos(fRetPrecisaoMargemItem);

  {******************************************}
  {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
  {* SER ALTERADOS                          *}
  {***************************************JB*}
  intPosMat := 0;
  SetLength(arrCamposGlobal, 1);

  arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECUS';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Custo';
  arrCamposGlobal[intPosMat].strOrigem := 'Preço de Custo';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
  SetLength(arrCamposGlobal, fSoma(intPosMat));

  {*******************************************}
  {* PREÇO 1 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[1] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 1';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE1';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 1';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 1';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 2 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[2] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 2';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;      
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE2';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 2';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 2';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 3 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[3] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 3';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;      
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE3';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 3';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 3';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 4 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************LU*}
  If VS_strTabPrc[4] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 4';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE4';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 4';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 4';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 5 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************LU*}
  If VS_strTabPrc[5] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 5';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE5';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 5';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 5';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 6 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************LU*}
  If VS_strTabPrc[6] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 6';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE6';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 6';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 6';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 7 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************LU*}
  If VS_strTabPrc[7] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda 7';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE7';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda 7';
    arrCamposGlobal[intPosMat].strOrigem := 'Tabela 7';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 1 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[1] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 1';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;

    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR1';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 1';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 2 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[2] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 2';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;      
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR2';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 2';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 3 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[3] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 3';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR3';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 3';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 4 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[4] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 4';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR4';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 4';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 5 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[5] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 5';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR5';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 5';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 6 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[6] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 6';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR6';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 6';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  {*******************************************}
  {* PREÇO 7 - CASO ESTEJA NA CONFIGURAÇÃO   *}
  {****************************************JB*}
  If VS_strTabPrc[7] = 'S' Then
  Begin
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta 7';
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      edtCamAlt.TipoTexto                  := ttNumerico;
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
      edtCamAlt.TipoTexto                  := ttAlfanumerico;
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR7';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta 7';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  SetLength(arrCamposGlobal, intPosMat);
  pGeraClient;
end;

procedure TfrmAltPrecoGlobalTPO.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If  btnConfirmaAlt.Enabled And (ActiveControl.Name = 'cbbTabOrigem') Then
  Begin
    If (Key = VK_RETURN) Then
    Begin
      pSetFocus(edtCamAlt);
    End
    Else If (Key = VK_ESCAPE) Then
    Begin
      pSetFocus(dbgTiposAlt);
    End;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.edtClaIPIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  edtClaIPI.Clear;
  If fPesqClaIPI(Self, edtClaIPI, nil, Key, arrAbfIPI, false) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.pLimparTela;
  Var
    IntCont: Integer;
begin
  For IntCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[IntCont] Is TEditFocus Then
      (Self.Components[IntCont] As TEditFocus).Clear;
  End;

  mskLinGru.Clear;
  edtStatus.Text := 'T';

  pGeraClient;

  rdgTipAlt.ItemIndex := 2;
  pMontaGrid;

  Self.SelectFirst;
end;

procedure TfrmAltPrecoGlobalTPO.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  intDecUni := fCfgSis('DECUNI', varInteger);
  blnTabPrd := fCfgSis('TABPRD', VarBoolean);
  cdsAltGlo.CreateDataSet;
end;

function TfrmAltPrecoGlobalTPO.fValidaAlteracaoAbreviacaoFiscal: Boolean;
  Var
    strFilter : String;
    intRecNo : Integer;
    blnFiltered : Boolean;
begin
  Result := True;

  If chkPenRec.Checked Then
    Exit;

  If (fCfgSis('CLPVDI', varBoolean)) Then
  Begin
    strFilter := cdsAltGlo.Filter;
    blnFiltered := cdsAltGlo.Filtered;
    intRecNo := cdsAltGlo.RecNo;
    Try
      cdsAltGlo.Filtered := False;
      cdsAltGlo.Filter := 'ITE_NOMCAM = ' + QuotedStr('ITE_CODABF');
      cdsAltGlo.Filtered := True;

      If ((Not cdsAltGlo.IsEmpty) And (cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S')) Then
      Begin
        If fMensagem('', MSG_ALTERACAO_PRECO_VENDA_DINAMICA, ['&Sim', '&Não'], 1) = 2 Then
          Result := False;
      End;
    Finally
      cdsAltGlo.Filter := strFilter;
      cdsAltGlo.Filtered := blnFiltered;
      cdsAltGlo.RecNo := intRecNo;
    End;
  End;
end;

procedure TfrmAltPrecoGlobalTPO.edtAbfCofExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfCof, edtDesCof, arrAbfCof, fRetDesAbfCof, Nil, 'da abreviação de COFINS');
end;

procedure TfrmAltPrecoGlobalTPO.edtAbfCofKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCofSai(Self, edtAbfCof, edtDesCof, Nil, Key, arrAbfCof, False) Then
  Begin
    If fValidaCampos(edtAbfCof, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobalTPO.edtAbfPisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfPis, edtDesPis, arrAbfPis, fRetDesAbfPis, Nil, 'da abreviação de PIS');
end;

procedure TfrmAltPrecoGlobalTPO.edtAbfPisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPisSai(Self, edtAbfPis, edtDesPis, Nil, Key, arrAbfPis, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.


