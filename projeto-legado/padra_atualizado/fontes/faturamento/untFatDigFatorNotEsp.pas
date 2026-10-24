{***********************}
{* qryConEmp -> CADEMP *}
{********************JB*}

unit untFatDigFatorNotEsp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Mask, MaskEditFocus, untTypesSistema,
  untZClient, UniClientDataSet;

type
  TTipoTela = (ttPorDocumento, ttPorPeriodo);

  TTipoTelaHelper = record helper for TTipoTela
    function GetIndex : Integer;
  end;

type
  TfrmFatDigFatorNotEsp = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    rdgOpcoes: TRadioGroup;
    pnlCentral: TPanel;
    Notebook: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblFatCal: TLabel;
    lblTipoFator: TLabel;
    clbTipoFator: TColorLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtNomEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtFatCal: TEditFocus;
    edtTipoFator: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    lbl1: TLabel;
    Label6: TLabel;
    edtCodEmp_: TEditFocus;
    edtNomEmp_: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnPesquisa: TBitBtnLocked;
    dbgDocumentos: TDBGridCitel;
    edtEspDoc_: TEditFocus;
    pnlRodape: TPanel;
    Label8: TLabel;
    lblTipoFator_: TLabel;
    clbTipoFator_: TColorLabel;
    Label10: TLabel;
    Label9: TLabel;
    edtFatCal_: TEditFocus;
    edtTipoFator_: TEditFocus;
    edtCodCli_: TEditFocus;
    edtNomCli_: TEditFocus;
    edtTotItensSelecionados: TEditFocus;
    dtsDocumentos: TDataSource;
    edtSerDoc_: TEditFocus;
    lblSerDoc_: TLabel;
    lblSerDoc: TLabel;
    edtSerDoc: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edtFatCalEnter(Sender: TObject);
    procedure rdgOpcoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodEmp_KeyPress(Sender: TObject; var Key: Char);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDocumentosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCli_KeyPress(Sender: TObject; var Key: Char);
    procedure edtTipoFator_Enter(Sender: TObject);
    procedure edtTipoFatorEnter(Sender: TObject);
    procedure edtFatCal_Enter(Sender: TObject);
  private

    TipoTela : TTipoTela;
    DocumentosSelecionados : TArrDocumentos;

    qryConEmp     : TUniQuery;
    qryConCli     : TUniQuery;
    fltFatValAnt  : Double;
    fltFatValAnt_ : Double;
    strFatTipAnt  : String;
    strFatTipAnt_ : String;
    cdsDocumentos : TZClient;

    procedure pCarregaEmpresa;
    function  fDocumentoExiste(strNumDoc, strEspDoc, strCodEmp, strSerie: String; Var strCodCli: String): Boolean;
    procedure pCarregaFatorNFEspecialCliente(strCodCli: String);
    procedure pCarregarCliente(strCodCli: String);

    procedure pCriarClientDataSetDocumentos;
    procedure pDestruirClientDataSetDocumentos;
    procedure pSetarTipoTela(ATipoTela : TTipoTela);
    function  fGetSQLPorPeriodo : String;
    procedure pMarcarDesmarcar;
    procedure pCarregarDocumentosSelecionados;
    procedure pValidaBloqueioBotaoF10PorPeriodo;
    procedure pCalcularTotalDeItensSelecionado;
    function fAlgumDocumentoJahFoiSelecionado : Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnNotaDeRemessa: Boolean;
    blnExibeFiltroSerie : Boolean;
    function fEhPorDocumento : Boolean;
    function fRetornaDocumentosSelecionados : TArrDocumentos;
  end;

const
  MARCADO    = 'M';
  DESMARCADO = 'D';

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, StrUtils,
     untLiberacao, untFuncFat;

{$R *.dfm}

{ TfrmFatDigFatorNotEsp }

function TfrmFatDigFatorNotEsp.fRetornaDocumentosSelecionados: TArrDocumentos;
begin
  Result := DocumentosSelecionados;
end;

function TfrmFatDigFatorNotEsp.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strCodCli: String;
  objLiberacao : TLiberacao;
begin

  Result := True;

  If (TipoTela = ttPorDocumento) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O documento deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If (fEmptyStr(edtEspDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtEspDoc.Text, 'MI_FF_') <= 0) And (Not blnNotaDeRemessa) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser MI ou FF!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtEspDoc.Text, 'NF_EL_') <= 0) And (blnNotaDeRemessa) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser NF!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (blnExibeFiltroSerie) and (Sender = edtSerDoc) Then
    Begin

      If (fEmptyStr(edtSerDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A série deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A empresa deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Not fDocumentoExiste(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtSerDoc.Text, strCodCli)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse documento não existe!', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          pCarregarCliente(strCodCli);
          pCarregaFatorNFEspecialCliente(strCodCli);
        End
      End;
    End

    Else If (Sender = edtFatCal) Then
    Begin

      If (fEmptyStr(edtFatCal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtFatCal.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

      {TRATAR A LIBERAÇÃO PARA A DIMINUIÇÃO DO FATOR - KM}
      If (Result) And (fCfgSis('FATNSP',varBoolean)) Then
      Begin
        If (fltFatValAnt > fStrToFloat(edtFatCal.Text)) And (Not fEmptyStr(edtFatCal.Text)) Then
        Try
          objLiberacao := TLiberacao.Create;

          objLiberacao.objMsgLibera.pAddTexto('Permissão para diminuir o fator de nota especial');
          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Fator Digitado', FloatToStrF(StrToFloat(edtFatCal.Text), ffNumber, 12, 3));
          objLiberacao.objMsgLibera.pAddTextoCaption('Fator Anterior', FloatToStrF(fltFatValAnt, ffNumber, 12, 3));
          objLiberacao.strDirAce  := 'DIMFNE';
          objLiberacao.strSenLib  := fCfgSis('SENLBD');
          objLiberacao.strMsgSen  := 'Liberacao de Diminuição do Fator de Nota Especial';
          objLiberacao.blnMosMen  := True;
          objLiberacao.strCodOpe  := strLoginUsuarioLogado;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
          objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);
          objLiberacao.blnUsarSenhaFixa         := False;
          objLiberacao.blnSempreVariavelUsuario := True;
          Result := objLiberacao.fLibera;

          If (not Result) then
            edtFatCal.Text := FloatToStrF(fltFatValAnt, ffNumber, 12, 3)
          Else
            fltFatValAnt   := fStrToFloat(edtFatCal.Text);
        Finally
          FreeAndNil(objLiberacao);
        End;
      End;

    End

    Else If (Sender = edtTipoFator) And (edtTipoFator.Visible) Then
    Begin
      If Pos(edtTipoFator.Text, 'V_Q_') <= 0 Then
      Begin
        fMensagem('','O tipo de fator deve ser (V)alor ou (Q)uantidade, verifique!', ['&Ok']);
        Result := False;
      End;

      If (Result) And (fCfgSis('TFANSP',varBoolean)) Then
      Begin
        If (strFatTipAnt <> edtTipoFator.Text) And (Not fEmptyStr(edtTipoFator.Text)) Then
        Begin
          objLiberacao := TLiberacao.Create;

          Try
            objLiberacao.objMsgLibera.pAddTexto('Permissão para alterar o tipo do fator de nota especial');
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Digitado', edtTipoFator.Text);
            objLiberacao.objMsgLibera.pAddTextoCaption('TIpo Anterior', strFatTipAnt);
            objLiberacao.strDirAce  := 'TFANSP';
            objLiberacao.strSenLib  := fCfgSis('SENLBD');
            objLiberacao.strMsgSen  := 'Liberacao de Alteração do Tipo do Fator de Nota Especial';
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;
            objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
            objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);
            objLiberacao.blnUsarSenhaFixa         := False;
            objLiberacao.blnSempreVariavelUsuario := True;
            Result := objLiberacao.fLibera;

            If (not Result) then
              edtTipoFator.Text := strFatTipAnt
            Else
              strFatTipAnt   := edtTipoFator.Text;
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If (fEmptyStr(edtCodCli.Text)) Then
      Begin
        edtNomCli.Clear;
        fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregarCliente(edtCodCli.Text);

        If (fEmptyStr(edtNomCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (blnBuscaPorChave) Then
          pCarregaFatorNFEspecialCliente(edtCodCli.Text);
      End;
    End;

  End
  Else If (TipoTela = ttPorPeriodo) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
         (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtEspDoc_) Then
    Begin
      If (fEmptyStr(edtEspDoc_.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtEspDoc_.Text, 'MI_FF_') <= 0) And (Not blnNotaDeRemessa) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser MI ou FF!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtEspDoc_.Text, 'NF_EL_') <= 0) And (blnNotaDeRemessa) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie deve ser NF!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (blnExibeFiltroSerie) and (Sender = edtSerDoc_) Then
    Begin

      If (fEmptyStr(edtSerDoc_.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A série deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmp_) Then
    Begin
      If (fEmptyStr(edtCodEmp_.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A empresa deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli_) And (pnlRodape.Enabled) Then
    Begin
      If fEmptyStr(edtCodCli_.Text) Then
      Begin
        edtNomCli_.Clear;
        edtFatCal_.Clear;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        pCarregarCliente(edtCodCli_.Text);
        pCarregaFatorNFEspecialCliente(edtCodCli_.Text);
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigFatorNotEsp.pCalcularTotalDeItensSelecionado;
var
  cdsClone           : TUniClientDataSet;
  intTotSelecionados : Integer;
begin

  cdsClone           := TUniClientDataSet.Create(Nil);
  intTotSelecionados := 0;

  Try

    pCloneDataSet(cdsClone, cdsDocumentos);

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin
      If (cdsClone.FieldByName('MARCADO').AsString = MARCADO) Then
        intTotSelecionados := intTotSelecionados +
                              cdsClone.FieldByName('TOTITENS').AsInteger;
      cdsClone.Next;
    End;

    edtTotItensSelecionados.Text := intTotSelecionados.ToString();

  Finally
    FreeAndNil(cdsClone);
  End;

end;

procedure TfrmFatDigFatorNotEsp.pCarregarCliente(strCodCli: String);
begin

  If (TipoTela = ttPorDocumento) Then
  Begin
    edtCodCli.Text := strCodCli;
    edtNomCli.Text := fRetNomCliente(strCodCli);
  End

  Else If (TipoTela = ttPorPeriodo) Then
  Begin
    edtCodCli_.Text := strCodCli;
    edtNomCli_.Text := fRetNomCliente(strCodCli);
  End;

end;

procedure TfrmFatDigFatorNotEsp.pCarregaEmpresa;
begin

  If (TipoTela = ttPorDocumento) Then
  Begin
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
    edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
  End

  Else If (TipoTela = ttPorPeriodo) Then
  Begin
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp_.Text);
    edtNomEmp_.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
  End;

end;

procedure TfrmFatDigFatorNotEsp.btnPesquisaClick(Sender: TObject);
begin

  inherited;

  If Not(fVerificaCampos) Then
    Exit;

  pCriarClientDataSetDocumentos;

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  cdsDocumentos.DisableControls;

  Try

    cdsDocumentos.qryQuery.Close;
    cdsDocumentos.qryQuery.SQL.Clear;
    cdsDocumentos.qryQuery.SQL.Add(fGetSQLPorPeriodo);

    cdsDocumentos.qryQuery.ParamByName('CODEMP').AsString := edtCodEmp_.Text;
    cdsDocumentos.qryQuery.ParamByName('ESPDOC').AsString := edtEspDoc_.Text;

    If blnExibeFiltroSerie Then
      cdsDocumentos.qryQuery.ParamByName('SERDOC').AsString := edtSerDoc_.Text;

    cdsDocumentos.qryQuery.ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    cdsDocumentos.qryQuery.ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    cdsDocumentos.fAbreClient(True, 'TfrmFatDigFatorNotEsp.btnPesquisaClick');
    cdsDocumentos.pFormataDecimal('GER_VLRCON', 2);

    pnlRodape.Enabled := Not cdsDocumentos.IsEmpty;

    If Not pnlRodape.Enabled Then
    Begin
      edtCodCli_.Clear;
      edtNomCli_.Clear;
      edtFatCal_.Clear;
      edtTipoFator_.Text := 'V';
    End;

    If cdsDocumentos.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Nenhum documento encontrado!', ['&Ok']);
      Exit;
    End;

    cdsDocumentos.IndexFieldNames := 'GER_DTAENT;GER_CODEMP;GER_NUMDOC';

  Finally
    pValidaBloqueioBotaoF10PorPeriodo;
    cdsDocumentos.EnableControls;
    Screen.Cursor := crDefault;
  End;

end;

procedure TfrmFatDigFatorNotEsp.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar;
end;

procedure TfrmFatDigFatorNotEsp.dbgDocumentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If cdsDocumentos.IsEmpty Then
    Exit;

  If (cdsDocumentos.FieldByName('MARCADO').AsString = MARCADO) Then
  Begin
    dbgDocumentos.Canvas.Font.Color  := clWhite;
    dbgDocumentos.Canvas.Brush.Color := clBlue;
  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatDigFatorNotEsp.dbgDocumentosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = chr(VK_SPACE)) Or ((Key = chr(VK_RETURN))) Then
    pMarcarDesmarcar;
end;

procedure TfrmFatDigFatorNotEsp.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var arrSel: TConsultasArray;
begin
  inherited;

  If (Not edtCodCli.ReadOnly) Then
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSel) And
       fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigFatorNotEsp.edtCodCli_KeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin

  inherited;

  If (Not edtCodCli_.ReadOnly) Then
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodCli_, edtNomCli_, Nil, Key, arrSel) Then
      If fValidaCampos(edtCodCli_) Then
        SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigFatorNotEsp.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigFatorNotEsp.edtCodEmp_KeyPress(Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp_, edtNomEmp_, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp_) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigFatorNotEsp.edtFatCalEnter(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtFatCal.Text)) Then
    fltFatValAnt := fStrToFloat(edtFatCal.Text)
  Else
    fltFatValAnt := 0.000;
end;

procedure TfrmFatDigFatorNotEsp.edtFatCal_Enter(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtFatCal_.Text)) Then
    fltFatValAnt_ := fStrToFloat(edtFatCal_.Text)
  Else
    fltFatValAnt := 0.000;
end;

procedure TfrmFatDigFatorNotEsp.edtTipoFatorEnter(Sender: TObject);
begin
  inherited;
  strFatTipAnt := edtTipoFator.Text;
end;

procedure TfrmFatDigFatorNotEsp.edtTipoFator_Enter(Sender: TObject);
begin
  inherited;
  strFatTipAnt_ := edtTipoFator_.Text;
end;

procedure TfrmFatDigFatorNotEsp.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmFatDigFatorNotEsp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConCli);
end;

procedure TfrmFatDigFatorNotEsp.FormCreate(Sender: TObject);
begin
  inherited;
  blnNotaDeRemessa := False;
  blnExibeFiltroSerie := False;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  pSetarTipoTela(ttPorPeriodo);
  edtCodEmp_.Text := VS_strCodEmp;
  pCarregaEmpresa;

  pSetarTipoTela(ttPorDocumento);
  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  strFatTipAnt := '';
  strFatTipAnt_ := '';
end;

procedure TfrmFatDigFatorNotEsp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) And (btnConfirmaDados.Enabled) Then
    btnConfirmaDados.Click;
end;

procedure TfrmFatDigFatorNotEsp.btnConfirmaDadosClick(Sender: TObject);
var
  strInformacao : String;
  objLiberacao : TLiberacao;
  blnLiberado : Boolean;
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (TipoTela = ttPorPeriodo) Then
    Begin

      If (pnlRodape.Enabled) Then
      Begin

        If (fEmptyStr(edtCodCli_.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!', ['&Ok']);
          pSetFocus(edtCodCli_);
          Exit;
        End;

        If (fEmptyStr(edtFatCal_.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O fator deve ser preenchido!', ['&Ok']);
          pSetFocus(edtFatCal_);
          Exit;
        End
        Else If (fStrToFloat(edtFatCal_.Text) <= 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O fator deve ser maior que Zero!', ['&Ok']);
          pSetFocus(edtFatCal_);
          Exit;
        End
        Else If (fCfgSis('FATNSP',varBoolean)) Then
        Begin
          If (fltFatValAnt_ > fStrToFloat(edtFatCal_.Text)) And (Not fEmptyStr(edtFatCal_.Text)) Then
          Begin
            Try
              objLiberacao := TLiberacao.Create;

              objLiberacao.objMsgLibera.pAddTexto('Permissão para diminuir o fator de nota especial');
              objLiberacao.objMsgLibera.pAddSeparador(100);
              objLiberacao.objMsgLibera.pAddTextoCaption('Fator Digitado', FloatToStrF(StrToFloat(edtFatCal_.Text), ffNumber, 12, 3));
              objLiberacao.objMsgLibera.pAddTextoCaption('Fator Anterior', FloatToStrF(fltFatValAnt_, ffNumber, 12, 3));
              objLiberacao.strDirAce  := 'DIMFNE';
              objLiberacao.strSenLib  := fCfgSis('SENLBD');
              objLiberacao.strMsgSen  := 'Liberacao de Diminuição do Fator de Nota Especial';
              objLiberacao.blnMosMen  := True;
              objLiberacao.strCodOpe  := strLoginUsuarioLogado;
              objLiberacao.strCodDig  := strLoginUsuarioLogado;
              objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
              objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);
              objLiberacao.blnUsarSenhaFixa         := False;
              objLiberacao.blnSempreVariavelUsuario := True;
              blnLiberado := objLiberacao.fLibera;

              If (not blnLiberado) then
                edtFatCal_.Text := FloatToStrF(fltFatValAnt_, ffNumber, 12, 3)
              Else
                fltFatValAnt_   := fStrToFloat(edtFatCal_.Text);
            Finally
              FreeAndNil(objLiberacao);
            End;
          End;
        End;

        If (edtTipoFator_.Visible) Then
        Begin
          If Pos(edtTipoFator_.Text, 'V_Q_') <= 0 Then
          Begin
            fMensagem('','O tipo de fator deve ser (V)alor ou (Q)uantidade, verifique!', ['&Ok']);
            pSetFocus(edtTipoFator_);
            Exit;
          End;

          If (fCfgSis('TFANSP',varBoolean)) Then
          Begin
            If (strFatTipAnt_ <> edtTipoFator_.Text) And (Not fEmptyStr(edtTipoFator_.Text)) Then
            Begin
              objLiberacao := TLiberacao.Create;

              Try
                objLiberacao.objMsgLibera.pAddTexto('Permissão para alterar o tipo do fator de nota especial');
                objLiberacao.objMsgLibera.pAddSeparador(100);
                objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Digitado', edtTipoFator_.Text);
                objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Anterior', strFatTipAnt_);
                objLiberacao.strDirAce  := 'TFANSP';
                objLiberacao.strSenLib  := fCfgSis('SENLBD');
                objLiberacao.strMsgSen  := 'Liberacao de Alteração do Tipo do Fator de Nota Especial';
                objLiberacao.blnMosMen  := True;
                objLiberacao.strCodOpe  := strLoginUsuarioLogado;
                objLiberacao.strCodDig  := strLoginUsuarioLogado;
                objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
                objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);
                objLiberacao.blnUsarSenhaFixa         := False;
                objLiberacao.blnSempreVariavelUsuario := True;
                blnLiberado := objLiberacao.fLibera;

                If (not blnLiberado) then
                  edtTipoFator_.Text := strFatTipAnt_
                Else
                  strFatTipAnt_   := edtTipoFator_.Text;
              Finally
                FreeAndNil(objLiberacao);
              End;
            End;
          End;
        End;

      End;

      pCarregarDocumentosSelecionados;
      If (Length(DocumentosSelecionados) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhum documento foi selecionado!', ['&Ok']);
        Exit;
      End;

      If TFatVenda.fUltrapassouLimiteItensNFe(StrToInt(edtTotItensSelecionados.Text),
                                              '',
                                              strInformacao) Then
      Begin
        fMensagem('ATENÇÃO!', strInformacao, ['&Ok']);
        Exit;
      End;

    End;

    Close;
    ModalResult := mrOk;
  End;
end;

function TfrmFatDigFatorNotEsp.fAlgumDocumentoJahFoiSelecionado: Boolean;
begin

  Result := False;

  If Not Assigned(cdsDocumentos) Then
    Exit;

  If (cdsDocumentos.IsEmpty) Then
    Exit;

  pCarregarDocumentosSelecionados;
  If (Length(DocumentosSelecionados) <= 0) Then
    Exit;

  Result := True;

end;

function TfrmFatDigFatorNotEsp.fDocumentoExiste(strNumDoc, strEspDoc,
  strCodEmp, strSerie: String; var strCodCli: String): Boolean;
  Var
    strSQL: String;
    strAux: String;
    strMov: String;
    strNot: String;
    qryGenGer: TUniQuery;

begin

  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODCLI, AUX_CLICEO, COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ( ';

    strAux := '';
    strAux := strAux + ' SELECT ';
    strAux := strAux + '   DISTINCT GER_CODCLI, AUX_CLICEO ';
    strAux := strAux + ' FROM ';
    strAux := strAux + '   MOVGER ';
    strAux := strAux + '   LEFT JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
    strAux := strAux + '   LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strAux := strAux + '   LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
    strAux := strAux + ' WHERE ';
    strAux := strAux + '   GER_NUMDOC = :NUMDOC AND ';
    strAux := strAux + '   GER_ESPDOC = :ESPDOC AND ';
    strAux := strAux + '   GER_CODEMP = :CODEMP AND ';

    If blnExibeFiltroSerie Then
      strAux := strAux + '   GER_SERIE_ = :SERDOC AND ';

    strAux := strAux + '   CODIGOEXTERNO ';

    IF (blnNotaDeRemessa) Then
      strAux := strAux + '   AND GER_TIP_FC = "C" AND GER_ORIDOC = "V" ';

    strMov := strAux;
    strNot := strAux;

    strMov := AnsiReplaceStr(strMov,'CODIGOEXTERNO', 'IFNULL(DET_CODEXT,"") = ""');
    strNot := AnsiReplaceStr(strNot,'CODIGOEXTERNO', 'TRUE');

    strNot := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strNot,'MOVGER','NOTGER'), 'MOVDET','NOTDET'), 'MOVTRI','NOTTRI');
    strNot := AnsiReplaceStr(strNot,'AUXMOV','AUXNOT');

    strAux := strMov + ' UNION ALL ' + strNot;

    strSQL := strSQL + strAux + ' ) A GROUP BY GER_CODCLI ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      If blnExibeFiltroSerie Then
        ParamByName('SERDOC').AsString := strSerie;

      Open;

      Result := (FieldByName('QTD').AsInteger > 0);

      If Result Then
      begin
        strCodCli := FieldByName('GER_CODCLI').AsString;

        If (fCfgSis('EXICOR', varBoolean)) And
           (fCfgSis('PCOORD', varBoolean)) And
           (Not fEmptyStr(FieldByName('AUX_CLICEO').AsString)) And
           (fEhPorDocumento) Then
          strCodCLi := FieldByName('AUX_CLICEO').AsString;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function TfrmFatDigFatorNotEsp.fEhPorDocumento: Boolean;
begin
  Result := (TipoTela = ttPorDocumento);
end;

function TfrmFatDigFatorNotEsp.fGetSQLPorPeriodo: String;
var
  strMov: String;
  strNot: String;
begin

  Result := '';
  Result := Result + 'SELECT DISTINCT   ';
  Result := Result + '  "D" AS MARCADO, ';
  Result := Result + '  GER_DTAENT, ';
  Result := Result + '  GER_NUMDOC, ';
  Result := Result + '  GER_ESPDOC, ';
  Result := Result + '  GER_CODEMP, ';
  Result := Result + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCUMENTO, ';
  Result := Result + '  GER_CODCLI,                                                        ';
  Result := Result + '  CONCAT(GER_CODCLI, "-", (SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = GER_CODCLI)) AS CLIENTE, ';
  Result := Result + '  GER_VLRCON,                                           ';
  Result := Result + '  (SELECT COUNT(*) FROM MOVDET WHERE DET_SEQGER = MOVGER.AUTOINCREM) AS TOTITENS ';
  Result := Result + 'FROM                                                    ';
  Result := Result + '  MOVGER                                                ';
  Result := Result + '  LEFT JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE                                                   ';
  Result := Result + '  NOT EXISTS (SELECT MNO_NUMFAT FROM CNFMNO WHERE MNO_NUMFAT = GER_NUMDOC AND MNO_ESPFAT = GER_ESPDOC AND MNO_EMPFAT = GER_CODEMP) AND ';
  Result := Result + '  (IFNULL(GER_NUMFAT, "") = "") AND                     ';
  Result := Result + '  GER_CODEMP = :CODEMP          AND                     ';
  Result := Result + '  GER_ESPDOC = :ESPDOC          AND                     ';

  If blnExibeFiltroSerie Then
    Result := Result + '  GER_SERIE_ = :SERDOC          AND                     ';

  Result := Result + '  ((GER_DTAENT >= :DTAINI) AND (GER_DTAENT <= :DTAFIN)) AND ';
  Result := Result + '  CODIGOEXTERNO ';

  strMov := Result;
  strNot := Result;

  strMov := AnsiReplaceStr(strMov,'CODIGOEXTERNO', 'IFNULL(DET_CODEXT,"") = ""');
  strNot := AnsiReplaceStr(strNot,'CODIGOEXTERNO', 'TRUE');

  strNot := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strNot,'MOVGER','NOTGER'), 'MOVDET','NOTDET'), 'MOVTRI','NOTTRI');
  Result := strMov + ' UNION ALL ' + strNot;
end;

procedure TfrmFatDigFatorNotEsp.FormShow(Sender: TObject);
begin
  inherited;

  qryConCli := fCriaQuery(Self);   

  edtSerDoc_.Visible := blnExibeFiltroSerie;
  lblSerDoc_.Visible := blnExibeFiltroSerie;
  edtSerDoc.Visible  := blnExibeFiltroSerie;
  lblSerDoc.Visible  := blnExibeFiltroSerie;

  If (blnNotaDeRemessa) Then
  Begin
    Caption := 'Informe a NF de venda';
    edtEspDoc.Text := 'NF';
    edtFatCal.Text := '1,00';

    edtEspDoc.Enabled := False;
    edtFatCal.Visible := False;
    lblFatCal.Visible := False;

  End
  Else
  Begin

    edtTipoFator.Visible := fCfgSis('FTNFES', varBoolean);
    lblTipoFator.Visible := edtTipoFator.Visible;
    clbTipoFator.Visible := edtTipoFator.Visible;

    edtTipoFator_.Visible := fCfgSis('FTNFES', varBoolean);
    lblTipoFator_.Visible := edtTipoFator_.Visible;
    clbTipoFator_.Visible := edtTipoFator_.Visible;

  End;
end;

procedure TfrmFatDigFatorNotEsp.pCarregaFatorNFEspecialCliente(strCodCli: String);
  Var
    qryCliente: TUniQuery;
begin
  qryCliente := fCriaQuery(nil);

  With qryCliente, SQL Do
  Begin
    Add('SELECT CLI_TFTNES, CLI_FTNFES FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    If Not IsEmpty Then
    Begin

      If (TipoTela = ttPorDocumento) Then
      Begin
        edtFatCal.Text    := qryCliente.FieldByName('CLI_FTNFES').AsString;
        edtTipoFator.Text := qryCliente.FieldByName('CLI_TFTNES').AsString;
        edtCodCli.Enabled := False;
      End

      Else

      If (TipoTela = ttPorPeriodo) Then
      Begin
        edtFatCal_.Text    := qryCliente.FieldByName('CLI_FTNFES').AsString;
        edtTipoFator_.Text := qryCliente.FieldByName('CLI_TFTNES').AsString;
      End;
    End;

  End;

  If fEmptyStr(edtTipoFator.Text) Then
    edtTipoFator.Text := 'V';

  If fStrToFloat(edtFatCal.Text) = 0 Then
    edtFatCal.Text := '1,00';

  FreeAndNil(qryCliente);
end;

procedure TfrmFatDigFatorNotEsp.pCarregarDocumentosSelecionados;
var
  Posicao : TBookmark;
begin

  FillChar(DocumentosSelecionados, SizeOf(DocumentosSelecionados), #0);

  If cdsDocumentos.IsEmpty Then
    Exit;

  cdsDocumentos.DisableControls;

  Try

    Posicao := cdsDocumentos.GetBookmark;

    cdsDocumentos.First;
    While Not cdsDocumentos.Eof Do
    Begin
      If (cdsDocumentos.FieldByName('MARCADO').AsString = MARCADO) Then
      Begin
        SetLength(DocumentosSelecionados, Length(DocumentosSelecionados)+1);
        DocumentosSelecionados[Length(DocumentosSelecionados)-1].strNumDoc := cdsDocumentos.FieldByName('GER_NUMDOC').AsString;
        DocumentosSelecionados[Length(DocumentosSelecionados)-1].strEspDoc := cdsDocumentos.FieldByName('GER_ESPDOC').AsString;
        DocumentosSelecionados[Length(DocumentosSelecionados)-1].strCodEmp := cdsDocumentos.FieldByName('GER_CODEMP').AsString;
        DocumentosSelecionados[Length(DocumentosSelecionados)-1].strCliFor := cdsDocumentos.FieldByName('GER_CODCLI').AsString;
      End;
      cdsDocumentos.Next;
    End;

  Finally

    cdsDocumentos.EnableControls;

    If cdsDocumentos.BookmarkValid(Posicao) Then
      cdsDocumentos.GotoBookmark(Posicao);

  End;

end;

procedure TfrmFatDigFatorNotEsp.pCriarClientDataSetDocumentos;
begin
  pDestruirClientDataSetDocumentos;
  cdsDocumentos         := TZClient.Create(Nil);
  dtsDocumentos.DataSet := cdsDocumentos;
end;

procedure TfrmFatDigFatorNotEsp.pDestruirClientDataSetDocumentos;
begin
  If Not Assigned(cdsDocumentos) Then
    Exit;

  dtsDocumentos.DataSet := Nil;
  FreeAndNil(cdsDocumentos);
end;

procedure TfrmFatDigFatorNotEsp.pMarcarDesmarcar;
begin

  If cdsDocumentos.IsEmpty Then
    Exit;

  Try
    cdsDocumentos.Edit;
    cdsDocumentos.FieldByName('MARCADO').AsString := IIF(cdsDocumentos.FieldByName('MARCADO').AsString = MARCADO, DESMARCADO, MARCADO);
    cdsDocumentos.Post;
  Finally
    pValidaBloqueioBotaoF10PorPeriodo;
    pCalcularTotalDeItensSelecionado;
  End;

end;

procedure TfrmFatDigFatorNotEsp.pSetarTipoTela(ATipoTela: TTipoTela);
begin
  TipoTela            := ATipoTela;
  rdgOpcoes.ItemIndex := ATipoTela.GetIndex;
  Notebook.PageIndex  := ATipoTela.GetIndex;
  pValidaBloqueioBotaoF10PorPeriodo;
end;

procedure TfrmFatDigFatorNotEsp.pValidaBloqueioBotaoF10PorPeriodo;
begin

  btnConfirmaDados.Enabled := True;

  If (TipoTela <> ttPorPeriodo) Then
    Exit;

  If (fAlgumDocumentoJahFoiSelecionado) Then
    Exit;

  btnConfirmaDados.Enabled := False;

end;

procedure TfrmFatDigFatorNotEsp.rdgOpcoesClick(Sender: TObject);
begin
  inherited;
  pSetarTipoTela(TTipoTela(rdgOpcoes.ItemIndex));
end;

{ TTipoTelaHelper }

function TTipoTelaHelper.GetIndex: Integer;
begin
  Case Self Of
    ttPorDocumento : Result := 0;
    ttPorPeriodo   : Result := 1;
    Else
      Result := -1;
  End;
end;

end.

