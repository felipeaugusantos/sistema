unit untCadMetasVendLinhaGrupoProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, untTypesSistema,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  QColorLabel;

type
  TfrmCadMetasVendLinhaGrupoProd = class(TfrmPaiOrdena)
    pnlDados: TPanel;
    lblLinhaGrupo: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    edtUnidade: TEditFocus;
    edtQuantidade: TEditFocus;
    pnlFiltro: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    lblTipOpe: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    mskDtaAtual: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    btnCopiarMetas: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    ColorLabel27: TColorLabel;
    Label28: TLabel;
    edtLinhaGrupoChave: TEditFocus;
    edtComissao: TEditFocus;
    cdsConsultaVLG_CODVEN: TStringField;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaVLG_CODEMP: TStringField;
    cdsConsultaVLG_MESANO: TStringField;
    cdsConsultaVLG_CODUNI: TStringField;
    cdsConsultaVLG_CODGRU: TStringField;
    cdsConsultaVLG_QTDVEN: TFloatField;
    cdsConsultaVLG_PERCOM: TFloatField;
    cdsConsultaVLG_CHAVE_: TStringField;
    cdsConsultaLINHA_GRUPO: TStringField;
    qryCadGru: TUniQuery;
    qryCadGruGRU_CODGRU: TStringField;
    qryCadUni: TUniQuery;
    qryCadGruLINHA_GRUPO: TStringField;
    qryCadUniUNI_CODUNI: TStringField;
    qryCadUniUNI_DESUNI: TStringField;
    cdsConsultaUNI_DESUNI: TStringField;
    qryCadGruGRU_DESGRU: TStringField;
    qryConsultaVLG_CODVEN: TStringField;
    qryConsultaAUTOINCREM: TStringField;
    qryConsultaVLG_CODEMP: TStringField;
    qryConsultaVLG_MESANO: TStringField;
    qryConsultaVLG_CODUNI: TStringField;
    qryConsultaVLG_CODGRU: TStringField;
    qryConsultaVLG_QTDVEN: TFloatField;
    qryConsultaVLG_PERCOM: TFloatField;
    qryConsultaVLG_CHAVE_: TStringField;
    qryConsultaLINHA_GRUPO: TStringField;
    qryConsultaUNI_DESUNI: TStringField;
    qryConsultaGRUPO: TStringField;
    cdsConsultaGRUPO: TStringField;
    Label7: TLabel;
    edtDesUni: TEditFocus;
    edtCodFornecedor: TEditFocus;
    edtNomeFornecedor: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtValorMinimoParaComissao: TEditFocus;
    Label10: TLabel;
    ColorLabel1: TColorLabel;
    edtMetaPor: TEditFocus;
    cdsConsultaVLG_CODFOR: TStringField;
    cdsConsultaVLG_VLRMIN: TFloatField;
    cdsConsultaVLG_TIPMET: TStringField;
    qryCadFor: TUniQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    cdsConsultaFOR_DESCRI: TStringField;
    qryConsultaVLG_CODFOR: TStringField;
    qryConsultaVLG_VLRMINVLG_VLRMIN: TFloatField;
    qryConsultaVLG_TIPMET: TStringField;
    qryConsultaFOR_DESCRI: TStringField;
    pnlMesAnoOrigem: TPanel;
    Label4: TLabel;
    mskDtaOrigem: TMaskEditFocus;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);

    //

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtMetaPorExit(Sender: TObject);

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  private
    { Private declarations }
    qryCadOpe: TUniQuery;
    qryConEmp: TUniQuery;
    arrLinGru: TConsultasArray;
    arrUnidad: TConsultasArray;
    strMesAno: String;
    strMesAnoOri: String;
    arrFornec : TConsultasArray;
    procedure pCarregaVendedor(strCodVen: String);
    procedure pAdicionaRegistro;
    procedure pCarregaCabecalho;
    procedure pCarregaEmpresa;
    procedure pCarregaRegistro;
    procedure pLimpaFiltro;
    procedure pLimpaRegistro;
    procedure pHabilitaDigitacaoDeptos;
    procedure pCopiaMeta;
    procedure pCopiaMetaMetVlg;
    procedure pAbreCadGru;
    procedure pAbreCadUni;
    procedure pAbreCadFor;
    //
    procedure pDeletaRegistro;
    procedure pLimparEdits(Panel: TPanel);
  public
    { Public declarations }
  end;

implementation

uses
  StrUtils, untPesqAux, untFuncoesConsulta, untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmCadMetasVendLinhaGrupoProd.btnConfirmarClick(Sender: TObject);
  Var
    intNroErr: Integer;
    LJaInformou : Boolean;
begin
  inherited;
  If (Not btnConfirmar.Visible) Or (Not btnConfirmar.Enabled) Or (pnlFiltro.Enabled) Then
    Exit;

  If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
    Exit;

  LJaInformou := False;
  if (cdsConsulta.Recordcount <> 0) then
  Begin
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    Begin
      if cdsConsulta.FieldByName('VLG_TIPMET').AsString <> edtMetaPor.Text then
      Begin
        if not LJaInformou then
        Begin
          fMensagem('','O Tipo de Meta aplicada no filtro da tela difere do já gravado para este '+
          'vendedor, empresa e mês\ano. O mesmo será aplicado para todos os registros listados.',['&Ok']);
          LJaInformou := True;
        End;

        cdsConsulta.Edit;
        cdsConsulta.FieldByName('VLG_TIPMET').AsString := edtMetaPor.Text;
        cdsConsulta.Post;
      End;

      cdsConsulta.Next;
    End;
    cdsConsulta.EnableControls;
  End;

  Try
    fStartTransaction;

    intNroErr := cdsConsulta.ApplyUpdates(-1);

   If intNroErr = 0 Then
    Begin
      fCommit;
      fMensagem('INFORMAÇÃO','Registros gravados com sucesso !',['&Ok']);
      pLimpaRegistro;
      pLimpaFiltro;
      btnCopiarMetas.Enabled := False;
      pnlDados.Enabled       := False;
      cdsConsulta.Close;
    End
    Else
      fRollBack;

  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pGravarMetas]');
    End;
  End;

  pnlMesAnoOrigem.Visible := False;
  pnlFiltro.Enabled := True;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If (Not btnCopiarMetas.Visible) Or (Not btnCopiarMetas.Enabled) Then
    Exit;

  pnlMesAnoOrigem.Visible := True;
  pSetFocus(mskDtaOrigem);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.cdsConsultaAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  TFloatField(cdsConsulta.FieldByName('VLG_PERCOM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('VLG_QTDVEN')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadMetasVendLinhaGrupoProd.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistro;
                 pSetFocus(mskLinhaGrupo);
               End;
    VK_DELETE: pDeletaRegistro;
    VK_ESCAPE: Begin
                 pLimparEdits(pnlDados);
                 pSetFocus(mskLinhaGrupo);
               End;
    Else Inherited;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFornecedor, edtNomeFornecedor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtNomeFornecedor, Nil, Key, arrFornec, True) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVen) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtMetaPorExit(Sender: TObject);
begin
  inherited;
  If edtMetaPor.Text = 'P' then
    label7.Caption := '%'
  Else
    label7.Caption := 'R$';
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade, edtDesUni, arrUnidad, fRetNomUnidade,Nil,'da unidade',6);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrUnidades: TConsultasArray;
begin
  inherited;
  if fPesqUnidade(Self, edtUnidade, edtDesUni, Nil, Nil, Key, arrUnidades) then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadMetasVendLinhaGrupoProd.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT METVLG.AUTOINCREM, ';
  Result := Result + '        VLG_CODVEN, ';
  Result := Result + '        VLG_CODEMP, ';
  Result := Result + '        VLG_MESANO, ';
  Result := Result + '	      VLG_CODGRU, ';
  Result := Result + '	      VLG_CODUNI, ';
  Result := Result + '	      VLG_QTDVEN, ';
  Result := Result + '	      VLG_PERCOM, ';
  Result := Result + '	      VLG_CHAVE_, ';
  Result := Result + '	      VLG_CODFOR, ';
  Result := Result + '	      VLG_VLRMIN, ';
  Result := Result + '	      VLG_TIPMET  ';
  Result := Result + '   FROM METVLG ';
  Result := Result + '  WHERE VLG_CODVEN = :CODVEN ';
  Result := Result + '    AND VLG_CODEMP = :CODEMP ';
  Result := Result + '    AND VLG_MESANO = :MESANO ';
end;

procedure TfrmCadMetasVendLinhaGrupoProd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryCadOpe) Then
    FreeAndNil(qryCadOpe);
  If Assigned(qryConEmp) Then
    FreeAndNil(qryConEmp);
  qryCadGru.Close;
  qryCadUni.Close;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadOpe := fCriaQuery(Self);
  qryConEmp := fCriaQuery(Self);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And
     (((ActiveControl) = dbgConsulta) Or (ActiveControl.Parent = pnlDados) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupo.Text)))) Then
  Begin
    pLimparEdits(pnlDados);
    pSetFocus(mskLinhaGrupo);
  End
  Else If (Key = VK_ESCAPE) And (pnlDados.Enabled) Then
  Begin
    If fMensagem('','Deseja cancelar a operação?',['&Sim','&Não']) = 1 Then
    Begin
      pLimparEdits(pnlDados);
      pLimparEdits(pnlFiltro);
      pHabilitaDigitacaoDeptos;

      lblTipOpe.Visible := False;
      cdsConsulta.Close;
      mskDtaOrigem.Clear;
      mskDtaOrigem.Clear;
      pnlMesAnoOrigem.Visible := False;
      pCarregaCabecalho;
      pSetFocus(edtCodVen);
    End
    Else
      pSetFocus(mskLinhaGrupo);
  End
  Else If (Key = VK_ESCAPE) And ((ActiveControl) <> dbgConsulta) Then
  begin
    Close;
  End
  Else If (Key = VK_F10) Then
  Begin
    If btnConfirmar.Visible Then
      btnConfirmar.Click;
  End
  Else If (Key = VK_F11) Then
  Begin
    btnCopiarMetas.Click;
  End
  Else
    Inherited;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCabecalho;
  pAbreCadGru;
  pAbreCadUni;
  pAbreCadFor;
  pSetFocus(edtCodVen);
  btnPesquisar.Visible := False;
  btnMudaOrdem.Visible := False;
  btnCopiarMetas.Enabled := False;
  pnlDados.Enabled       := False;
  blnFecharComEscape := False;
end;

function TfrmCadMetasVendLinhaGrupoProd.fSetParametros: Boolean;
begin
  Result := true;

  try
    qryConsulta.ParamByName('CODVEN').AsString := edtCodVen.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text
    Else
      qryConsulta.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

    qryConsulta.ParamByName('MESANO').AsString := strMesAno;

  except
    Result := false;
  end;
end;


function TfrmCadMetasVendLinhaGrupoProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

var
  strCodGru,
  strDesGru: String;

  function fPossuiLinhaGrupoChave: Boolean;
  Begin
    Result := False;

    If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CHAVE_',
               VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''), edtLinhaGrupoChave.text]), []) Then
    Begin
      fMensagem('ATENÇÃO','Já existe uma chave cadastrada neste mês!',['&O K']);
      Result := True;
    End;
  End;

begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O código do vendedor deve ser preenchido!',['&O K']);
        edtNomVen.Clear;
        lblTipOpe.Visible := False;
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor(edtCodVen.Text);
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','O código da empresa deve ser preenchido!',['&OK']);
        edtNomEmp.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(qryConEmp.FieldByName('EMP_CODEMP').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskLinhaGrupo) And (blnBuscaPorChave) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupo.Text)) Then
      Begin
        fMensagem('', 'Informe o Grupo de Produtos para a meta!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        strCodGru := fTiraCaracEspeciais(mskLinhaGrupo.Text);
        strDesGru := fRetNomeLinhaGrupo(strCodGru);

        If fEmptyStr(strDesGru) Then
        Begin
          fMensagem('', 'Grupo de Produtos não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (sender = edtQuantidade) Then
    Begin
      If fEmptyStr(edtQuantidade.Text) Then
      Begin
        fMensagem('', 'O campo "Quantidade" deve ser preenchido!', ['&O K']);
        Result := False;
      end
      Else If fStrToFloat(edtQuantidade.Text) <= 0 Then
      Begin
        fMensagem('', 'O campo "Quantidade" deve ser maior que zero!', ['&O K']);
        Result := False;
      End;
    End
    Else If (sender = edtComissao) Then
    Begin
      If fEmptyStr(edtComissao.Text) Then
      Begin
        fMensagem('', 'O campo "Comissão" deve ser preenchido!', ['&O K']);
        Result := False;
      end
      Else If fStrToFloat(edtComissao.Text) <= 0 Then
      Begin
        fMensagem('', 'O campo "Comissão" deve ser maior que zero!', ['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtLinhaGrupoChave) Then
    Begin
      If fEmptyStr(edtLinhaGrupoChave.Text) Then
      Begin
        fMensagem('', 'Informar Linha/Grupo chave !', ['&O k']);
        Result := False;
      End
      Else
      If Pos(edtLinhaGrupoChave.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Linha/Grupo chave" ' +
                              'deve ser preenchido com "S" ou "N"!', ['&Ok']);
        Result := False;
      End;
      If Result Then
      Begin
        If (edtLinhaGrupoChave.text = 'S') And (fPossuiLinhaGrupoChave) Then
        Begin
          Result := False;
        End;
      End;
      If Result And (blnBuscaPorChave) Then
        pAdicionaRegistro;
    End
    Else If (Sender = mskDtaAtual) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyDate(mskDtaAtual.Text)) And (Not fValidaDataStr('01/' + mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'O mês / ano atual informado é inválido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaAtual.Text := FormatDateTime('MM/YYYY', strToDate('01/' + mskDtaAtual.Text));

        If Not fEmptyStr(edtCodVen.Text) Then
        Begin
          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
          Begin
            strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
            cdsConsulta.Close;
          End;

          If fAbreConsulta Then
            pHabilitaDigitacaoDeptos
          Else
            Result := False;
        End;
      End;
    End
    Else If (Sender = mskDtaOrigem) And (blnBuscaPorChave) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyDate(mskDtaOrigem.Text)) And (Not fValidaDataStr('01/' + mskDtaOrigem.Text)) Then
      Begin
        fMensagem('', 'O mês / ano de origem informado é inválido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaOrigem.Text := FormatDateTime('MM/YYYY', strToDate('01/' + mskDtaOrigem.Text));
        strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/','');
        pCopiaMeta;
      End;
    End

    Else If (Sender = edtCodFornecedor) Then
    Begin
      If not fEmptyStr(edtCodFornecedor.Text) Then
      Begin
        pEdtCodSelectExit(edtCodFornecedor, edtNomeFornecedor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
        if fEmptyStr(edtNomeFornecedor.Text) then
          Result := False;
      End;
    End

    Else If (Sender = edtMetaPor) Then
    Begin
      If fEmptyStr(edtMetaPor.Text) Then
      Begin
        fMensagem('', 'Informar o tipo de meta!', ['&O k']);
        Result := False;
      End
      Else
      If Pos(edtMetaPor.Text, 'P_V_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Meta por" deve ser preenchido com "P" ou "V"!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtValorMinimoParaComissao) Then
    Begin
      If not fEmptyStr(edtValorMinimoParaComissao.Text) And
      (fStrToFloat(edtValorMinimoParaComissao.Text) < 0)   Then
      Begin
        fMensagem('', 'Valor mínimo de faturamento para pagamento da comissão não pode ser negativo!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fvalidaCampos(mskLinhaGrupo,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMetasVendLinhaGrupoProd.pAbreCadUni;
begin
  With qryCadUni Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT UNI_CODUNI, ');
    SQL.Add(' CONCAT(UNI_CODUNI, "  ", UNI_DESUNI) AS UNI_DESUNI ');
    SQL.Add(' FROM CADUNI ');
    Open;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pAbreCadFor;
begin
  With qryCadFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT FOR_CODFOR, CONCAT(FOR_CODFOR, '' - '', FOR_NOMFOR) FOR_DESCRI FROM CADFOR ');
    Open;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pAbreCadGru;
begin
  With qryCadGru Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT GRU_CODGRU, ');
    SQL.Add(' GRU_DESGRU, ');
    SQL.Add(' CONCAT(GRU_CODGRU, "  ",  GRU_DESGRU) AS LINHA_GRUPO ');
    SQL.Add(' FROM CADGRU ');
    Open;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pAdicionaRegistro;

  function fValidaCamposInterna: Boolean;
  begin
    Result := fValidaCampos(mskLinhaGrupo, True);
    If Result Then
      Result := fValidaCampos(edtUnidade, True);
    If Result Then
      Result := fValidaCampos(edtQuantidade, True);
    If Result Then
      Result := fValidaCampos(edtComissao, True);
    If Result Then
      Result := fValidaCampos(edtLinhaGrupoChave, False);
    If Result Then
      Result := fValidaCampos(edtCodFornecedor, False);
    If Result Then
      Result := fValidaCampos(edtValorMinimoParaComissao, False);
    If Result Then
      Result := fValidaCampos(edtMetaPor, False);
  end;

  function fPossuiLinhaGrupoUnidadeEFornecedorVazios: Boolean;
  Begin
    Result := False;
    If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI;VLG_CODFOR',
               VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''), fTiraCaracEspeciais(mskLinhaGrupo.text), '', '']), []) Then
    Begin
      fMensagem('ATENÇÃO!', 'Existe uma meta lançada sem o preenchimento do campo "Unidade" e "Fornecedor" para o Grupo/Linha selecionado. ', ['&O K']);
      Result := True;
    End;
  End;

  function fPossuiLinhaGrupoUnidadeEFornecedor: Boolean;
  Begin
    Result := False;
    If Not fEmptyStr(edtUnidade.text) And Not fEmptyStr(edtCodFornecedor.Text) Then
    Begin
      If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI;VLG_CODFOR',
                 VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                             fTiraCaracEspeciais(mskLinhaGrupo.text), edtUnidade.text,
                             edtCodFornecedor.Text]), []) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os campos  "Linha/Grupo", "Unidade" e "Fornecedor" já cadastrados. ', ['&O K']);
        Exit(True);
      End;

      If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI;VLG_CODFOR',
                 VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                             fTiraCaracEspeciais(mskLinhaGrupo.text), edtUnidade.text, '']), []) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os campos  "Linha/Grupo" e "Unidade"  já cadastrados. ', ['&O K']);
        Exit(True);
      End;

      If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI;VLG_CODFOR',
                 VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                             fTiraCaracEspeciais(mskLinhaGrupo.text), '', edtCodFornecedor.Text]), []) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os campos  "Linha/Grupo" e "Fornecedor"  já cadastrados. ', ['&O K']);
        Exit(True);
      End;
    End
    Else if (Not fEmptyStr(edtUnidade.text)) or (Not fEmptyStr(edtCodFornecedor.Text)) then
    Begin
      If Not fEmptyStr(edtUnidade.text) Then
      Begin
        If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI',
                   VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                               fTiraCaracEspeciais(mskLinhaGrupo.text), edtUnidade.text]), []) Then
        Begin
          fMensagem('ATENÇÃO!', 'Os campos  "Linha/Grupo", "Unidade" já cadastrados. ', ['&O K']);
          Exit(True);
        End;
      End;

      If Not fEmptyStr(edtCodFornecedor.Text) Then
      Begin
        If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODFOR',
                   VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                               fTiraCaracEspeciais(mskLinhaGrupo.text), edtCodFornecedor.Text]), []) Then
        Begin
          fMensagem('ATENÇÃO!', 'Os campos  "Linha/Grupo" e "Fornecedor" já cadastrados. ', ['&O K']);
          Exit(True);
        End;
      End;
    End
    Else If cdsConsulta.Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU',
               VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''), fTiraCaracEspeciais(mskLinhaGrupo.text)]), []) Then
    Begin
      fMensagem('ATENÇÃO!', 'A mesma "Linha/Grupo" não pode conter "Unidade" e "Fornecedor" vazios pois já esta vinculada '+
                'há alguma "Unidade" e "Fornecedor". ', ['&O K']);
      Exit(True);
    End;

  End;

begin
  if not (cdsConsulta.Active) then
    cdsConsulta.open;

  if fPossuiLinhaGrupoUnidadeEFornecedorVazios then
  begin
    pSetFocus(pnlDados);
    Exit;
  end;

  If fPossuiLinhaGrupoUnidadeEFornecedor then
  Begin
    pSetFocus(pnlDados);
    Exit;
  End;

  With cdsConsulta Do
  If Locate('VLG_CODEMP;VLG_CODVEN;VLG_MESANO;VLG_CODGRU;VLG_CODUNI;VLG_CHAVE_;VLG_CODFOR',
    VarArrayOf([edtCodEmp.Text,edtCodVen.Text,AnsiReplaceStr(mskDtaAtual.Text, '/', ''),
                fTiraCaracEspeciais(mskLinhaGrupo.Text), edtUnidade.text, edtLinhaGrupoChave.text,
                edtCodFornecedor.Text]), []) Then
  Begin
    Edit;
    FieldByName('VLG_CODUNI').AsString := edtUnidade.Text;
    FieldByName('VLG_QTDVEN').AsString := edtQuantidade.Text;
    FieldByName('VLG_PERCOM').AsFloat  := fStrToFloat(edtComissao.Text);
    FieldByName('VLG_CHAVE_').AsString := edtLinhaGrupoChave.Text;
    FieldByName('VLG_PERCOM').AsFloat  := fStrToFloat(edtComissao.Text);
    FieldByName('VLG_CODFOR').AsString := edtCodFornecedor.Text;
    if fEmptyStr(edtCodFornecedor.Text) then
        FieldByName('VLG_CODFOR').Clear;
    FieldByName('VLG_VLRMIN').AsFloat  := fStrToFloat(edtValorMinimoParaComissao.Text);
    Post;
  End
  Else
  Begin
    If fValidaCamposInterna Then
    Begin

      blnPodeIncluir := True;
      Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('METVLG', VS_strCodEmp);
      FieldByName('VLG_CODVEN').AsString  := edtCodVen.Text;
      FieldByName('VLG_CODEMP').AsString  := edtCodEmp.Text;
      FieldByName('VLG_MESANO').AsString  := strMesAno;
      FieldByName('VLG_CODGRU').AsString  := fTiraCaracEspeciais(mskLinhaGrupo.Text);
      FieldByName('VLG_CODUNI').AsString  := edtUnidade.Text;
      FieldByName('VLG_QTDVEN').AsFloat   := fStrToFloat(edtQuantidade.Text);
      FieldByName('VLG_CHAVE_').AsString  := edtLinhaGrupoChave.Text;
      FieldByName('VLG_PERCOM').AsFloat   := fStrToFloat(edtComissao.Text);
      FieldByName('VLG_CODFOR').AsString  := edtCodFornecedor.Text;
      if fEmptyStr(edtCodFornecedor.Text) then
        FieldByName('VLG_CODFOR').Clear;
      FieldByName('VLG_TIPMET').AsString  := edtMetaPor.Text;
      FieldByName('VLG_VLRMIN').AsFloat   := fStrToFloat(edtValorMinimoParaComissao.Text);
      Post;
      blnPodeIncluir := False;
    End
    Else
      Cancel;
  End;

  pLimpaRegistro;
  pSetFocus(pnlDados);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pCarregaCabecalho;
begin

end;

procedure TfrmCadMetasVendLinhaGrupoProd.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pCarregaRegistro;
begin
  With cdsConsulta Do
  Begin
    mskLinhaGrupo.Text := FieldByName('VLG_CODGRU').AsString;
    edtDesGrupo.Text := fCampoTabela('GRU_DESGRU','CADGRU',['GRU_CODGRU'],[fTiraCaracEspeciais(mskLinhaGrupo.Text)]);
    edtDesUni.Text   := fCampoTabela('UNI_DESUNI','CADUNI',['UNI_CODUNI'],[fTiraCaracEspeciais(mskLinhaGrupo.Text)]);
    edtUnidade.Text := FieldByName('VLG_CODUNI').AsString;
    edtQuantidade.Text := FloatToStr(FieldByName('VLG_QTDVEN').AsFloat);
    edtComissao.Text := FloatToStr(FieldByName('VLG_PERCOM').AsFloat);
    edtLinhaGrupoChave.Text := FieldByName('VLG_CHAVE_').AsString;
    edtCodFornecedor.Text := FieldByName('VLG_CODFOR').AsString;
    edtValorMinimoParaComissao.Text := FloatToStr(FieldByName('VLG_VLRMIN').AsFloat);
  End;
  cdsConsulta.Delete;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pCarregaVendedor(strCodVen: String);
begin
  pPesquisaCadOpe(Nil, qryCadOpe, edtCodVen.Text);
  edtNomVen.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;

  lblTipOpe.Visible := True;
  If qryCadOpe.FieldByName('OPE_INTEXT').AsString = 'G' Then
    lblTipOpe.Caption := 'Gerente'
  Else If qryCadOpe.FieldByName('OPE_INTEXT').AsString = 'S' Then
    lblTipOpe.Caption := 'Sub-gerente'
  Else
    lblTipOpe.Visible := False;
end;


procedure TfrmCadMetasVendLinhaGrupoProd.pCopiaMeta;
begin
  Try
    cdsConsulta.DisableControls;
    Try

      pCopiaMetaMetVlg;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[pCopiaMeta]');
      End;
    End;
    cdsConsulta.First;
  Finally
   cdsConsulta.EnableControls;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pCopiaMetaMetVlg;
  Var
    qryMetVlg: TUniQuery;
Begin

  Try
    qryMetVlg := fCriaQuery;
    With qryMetVlg, SQL Do
    Begin
      Clear;
      Add(' SELECT VLG_CODVEN, ');
      Add('        VLG_CODEMP, ');
      Add('        VLG_MESANO, ');
      Add('        VLG_CODGRU, ');
      Add('        VLG_CODUNI, ');
      Add('        VLG_CODGRU, ');
      Add('        VLG_QTDVEN, ');
      Add('        VLG_PERCOM, ');
      Add('        VLG_CHAVE_, ');
      Add('	       VLG_CODFOR, ');
      Add('	       VLG_VLRMIN, ');
      Add('	       VLG_TIPMET  ');
      Add('   FROM METVLG ');
      Add('  WHERE VLG_MESANO = :MESANO AND ');
      Add('        VLG_CODEMP = :CODEMP AND ');
      Add('        VLG_CODVEN = :CODVEN     ');

      ParamByName('MESANO').AsString := strMesAnoOri;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('CODVEN').AsString := edtCodVen.Text;

      Open;
    End;

    If Not qryMetVlg.IsEmpty Then
    Begin
      With cdsConsulta Do
      Begin
        DisableControls;
        Tag := 1;

        Filtered := False;

        First;
        While Not Eof Do
          Delete;

        Filtered := True;

        While Not qryMetVlg.Eof Do
        Begin

          Insert;
          FieldByName('VLG_CODVEN').AsString := qryMetVlg.FieldByName('VLG_CODVEN').AsString;
          FieldByName('VLG_CODEMP').AsString := qryMetVlg.FieldByName('VLG_CODEMP').AsString;
          FieldByName('VLG_CODGRU').AsString := qryMetVlg.FieldByName('VLG_CODGRU').AsString;
          FieldByName('VLG_CODUNI').AsString := qryMetVlg.FieldByName('VLG_CODUNI').AsString;
          FieldByName('VLG_QTDVEN').AsFloat  := qryMetVlg.FieldByName('VLG_QTDVEN').AsFloat;
          FieldByName('VLG_PERCOM').AsFloat  := qryMetVlg.FieldByName('VLG_PERCOM').AsFloat;
          FieldByName('VLG_CHAVE_').AsString := qryMetVlg.FieldByName('VLG_CHAVE_').AsString;
          FieldByName('VLG_CODFOR').AsString := qryMetVlg.FieldByName('VLG_CODFOR').AsString;
          if fEmptyStr(qryMetVlg.FieldByName('VLG_CODFOR').AsString) then
              FieldByName('VLG_CODFOR').Clear;
          FieldByName('VLG_TIPMET').AsString := qryMetVlg.FieldByName('VLG_TIPMET').AsString;
          FieldByName('VLG_VLRMIN').AsFloat  := qryMetVlg.FieldByName('VLG_VLRMIN').AsFloat;

          FieldByName('VLG_MESANO').AsString := strMesAno;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METVLG', VS_strCodEmp);
          Post;

          qryMetVlg.Next;
        End;

        Tag := 0;

        EnableControls;
        mskDtaOrigem.Clear;
        pnlMesAnoOrigem.Visible := False;
        pSetFocus(dbgConsulta);

        pMensagemOk('Metas copiadas com sucesso!');
      End;
    End
    Else
    Begin
      fMensagem('INFORMAÇÃO','Não existem metas para esse vendedor para esse período de origem: ' + LeftStr(strMesAnoOri, 2) + '/' + RightStr(strMesAnoOri, 4),['&Ok']);
      pSetFocus(mskDtaOrigem);
      blnMudarFoco := False;
    End;
  Finally
    FreeAndNil(qryMetVlg);
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pDeletaRegistro;
begin
  With cdsConsulta Do
  Begin
    If Not IsEmpty Then
      If RecordCount >= 1 Then
      Begin
        If fMensagem('QUESTÃO','Deseja realmente excluir esse registro ?',['&Sim','&Não']) = 1 Then
        Begin
          Delete;
        End;
      End;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pHabilitaDigitacaoDeptos;
Var
  blnCabecalhoPreenchido: Boolean;
begin
  blnCabecalhoPreenchido := (Not fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text))) And
                            (Not fEmptyStr(edtNomVen.Text)) And
                            (Not fEmptyStr(edtNomEmp.Text)) And
                            (fValidaCampos(edtMetaPor));

  pnlDados.Enabled        := blnCabecalhoPreenchido;
  pnlFiltro.Enabled       := Not blnCabecalhoPreenchido;
  btnCopiarMetas.Enabled  := blnCabecalhoPreenchido;

  If blnCabecalhoPreenchido Then
    pSetFocus(mskLinhaGrupo);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pLimpaFiltro;
begin
  edtCodVen.Clear;
  edtNomVen.Clear;
  lblTipOpe.Visible := False;
  edtMetaPor.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pLimparEdits(Panel: TPanel);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Panel.ControlCount -1 Do
  Begin
    If (Panel.Controls[intCnt] Is TEditFocus) Then
      TEditFocus(Panel.Controls[intCnt]).Clear;
    If (Panel.Controls[intCnt] Is TMaskEditFocus) Then
      TMaskEditFocus(Panel.Controls[intCnt]).Clear;
  End;
end;

procedure TfrmCadMetasVendLinhaGrupoProd.pLimpaRegistro;
begin
  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtDesUni.Clear;
  edtUnidade.Clear;
  edtQuantidade.Clear;
  edtComissao.Clear;
  edtLinhaGrupoChave.Text := 'N';
  mskDtaOrigem.Clear;
  pnlMesAnoOrigem.Visible := False;
  edtCodFornecedor.Clear;
  edtNomeFornecedor.Clear;
  edtValorMinimoParaComissao.Clear;
  pSetFocus(mskLinhaGrupo);
end;

end.
