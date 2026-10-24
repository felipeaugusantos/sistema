unit Faturamento.View.ExclusaoVendasPerdidas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  Vcl.DBCtrls, DBEditFocus, untTypesSistema, untConsultas, DateUtils, untFuncoesSimples;

type
  TChaveVP = record
    strCodEmp: string;
    strCodigo: string;
  end;

  TfrmFatExclusaoVendasPerdidas = class(TfrmPaiOrdena)
    Label2: TLabel;
    Label3: TLabel;
    lblLinGru: TLabel;
    Label1: TLabel;
    lblProduto: TLabel;
    Label5: TLabel;
    lblFornecedor: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodMot: TEditFocus;
    edtDesMot: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    btnCarregarProdutos: TBitBtnLocked;
    Label6: TLabel;
    dbeDocume: TDBEditFocus;
    Label7: TLabel;
    dbeUnitar: TDBEditFocus;
    Label8: TLabel;
    dbeTotIte: TDBEditFocus;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    lblEmpresa: TLabel;
    edtDesEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    procedure btnCarregarProdutosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    procedure pLimparTela;
    procedure pExcluirProdutosSelecionados;
    procedure pPadraoPesquisa;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;

implementation

{$R *.dfm}

procedure TfrmFatExclusaoVendasPerdidas.btnCarregarProdutosClick(
  Sender: TObject);
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  fAbreConsulta(True);
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('Atenção!', 'Não há produtos de vendas perdidas com estes dados.', ['&Ok']);
    pSetFocus(mskDtaIni);
    Exit;
  End;

  TFloatField(cdsConsulta.FieldByName('VPD_QTDITE')).DisplayFormat := '#,##0.' + StringOfChar('0', fCfgSis('DECQTD', varInteger));
  TFloatField(cdsConsulta.FieldByName('VPD_UNITAR')).DisplayFormat := '#,##0.' + StringOfChar('0', fCfgSis('DECUNI', varInteger));
  TFloatField(cdsConsulta.FieldByName('VPD_TOTITE')).DisplayFormat := '#,##0.00';

  cdsConsulta.IndexFieldNames := 'VPD_DESITE;VPG_DTACAD';
end;

procedure TfrmFatExclusaoVendasPerdidas.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  pDesmarcaTodos;
end;

procedure TfrmFatExclusaoVendasPerdidas.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (stlListSelecao.Count <= 0) Then
  Begin
    fMensagem('Atenção!', 'É necessário selecionar pelo menos 1 Produto para a Exclusão.', ['&Ok']);
    pSetFocus(dbgConsulta);
    Exit;
  End;

  If (fMensagem('Atenção!','------------------------------------------------------------------------------------------------------' + #13 +
                           'Estes registros de Venda Perdida serão removidos permanentemente.' + #13 +
                           'Desta forma os relatórios não apresentarão este movimento, e não ' + #13 +
                           'influenciará mais no pedido de compras.                          ' + #13 +
                           '------------------------------------------------------------------------------------------------------' + #13 +
                           '                     Confirma a exclusão ?                       ' + #13 +
                           '                                                                 ',
                           ['&Sim', 'Não'], 2) = 1) Then
    pExcluirProdutosSelecionados;
end;

procedure TfrmFatExclusaoVendasPerdidas.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodForKeyPress(Sender: TObject; var Key: Char);
var
  arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodIteKeyPress(Sender: TObject; var Key: Char);
var
  qryConGen: TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin
    qryConGen := fCriaQuery;
    Try
      Try
        if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConGen, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
        Begin
          If fValidaCampos(edtCodIte, True) Then
            Self.SelectNext(ActiveControl, True, True);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmFatExclusaoVendasPerdidas.edtCodIteKeyPress]');
        End;
      End;
    Finally
      FreeAndNil(qryConGen);
    End;
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodMarKeyPress(Sender: TObject; var Key: Char);
var
  arrMarca : TConsultasArray;
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodMotKeyPress(Sender: TObject; var Key: Char);
var
  arrMotivo: TConsultasArray;
begin
  inherited;

  If fPesqMotVendasPerdidas(Self, edtCodMot, edtDesMot, Nil, Key, arrMotivo) Then
  Begin
    if fValidaCampos(edtCodMot, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.edtCodVenKeyPress(Sender: TObject; var Key: Char);
var
  arrVend: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodven, edtNomVen, nil, Key, arrVend, False) Then
  Begin
    If fValidaCampos(edtCodven, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatExclusaoVendasPerdidas.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  MOVVPD.AUTOINCREM, ';
  Result := Result + '  VPG_CODEMP, ';
  Result := Result + '  VPG_CODIGO, ';
  Result := Result + '  VPG_DTACAD, ';
  Result := Result + '  VPD_CODITE, ';
  Result := Result + '  VPD_DESITE, ';
  Result := Result + '  ITE_CODUNI, ';
  Result := Result + '  VPD_QTDITE, ';
  Result := Result + '  VPG_CODVEN, ';
  Result := Result + '  MOT_DESMOT, ';
  Result := Result + '  CONCAT(VPG_NUMDOC, "-", VPG_ESPDOC) AS DOCUME, ';
  Result := Result + '  VPD_UNITAR, ';
  Result := Result + '  VPD_TOTITE ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVVPD ';
  Result := Result + '  INNER JOIN MOVVPG ON VPD_CODIGO = VPG_CODIGO AND VPD_CODEMP = VPG_CODEMP ';
  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = VPD_CODITE ';
  Result := Result + '  LEFT JOIN MOTVPD ON MOT_CODMOT = VPD_CODMOT ';
  Result := Result + 'WHERE ';
  Result := Result + '  VPG_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  if (not fEmptyStr(edtCodIte.Text)) then
    Result := Result + '  AND VPD_CODITE = :CODITE ';
  if (not fEmptyStr(mskLinGru.Text)) then
    Result := Result + '  AND ITE_CODGRU = :CODGRU ';
  if (not fEmptyStr(edtCodFor.Text)) then
    Result := Result + '  AND ITE_CODFOR = :CODFOR ';
  if (not fEmptyStr(edtCodMar.Text)) then
    Result := Result + '  AND ITE_CODMAR = :CODMAR ';
  if (not fEmptyStr(edtCodVen.Text)) then
    Result := Result + '  AND VPG_CODVEN = :CODVEN ';
  if (not fEmptyStr(edtCodMot.Text)) then
    Result := Result + '  AND VPD_CODMOT = :CODMOT ';
  if (not fEmptyStr(edtCodEmp.Text)) then
    Result := Result + '  AND VPG_CODEMP = :CODEMP ';

end;

procedure TfrmFatExclusaoVendasPerdidas.FormCreate(Sender: TObject);
begin
  inherited;

  blnSelecionaComEspaco := True;
end;

procedure TfrmFatExclusaoVendasPerdidas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    If dbgConsulta.Focused Then
    Begin
      If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pLimparTela;
      End;
    End
    Else
      inherited;
  End
  Else If Key = VK_F10 Then
  Begin
    btnGravar.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    btnMarcaTodos.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    btnDesmarcaTodos.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatExclusaoVendasPerdidas.FormShow(Sender: TObject);
begin
  inherited;
  edtCodIte.TamCampo := fTamCodIte;
  edtCodEmp.text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  pPadraoPesquisa;
end;

function TfrmFatExclusaoVendasPerdidas.fSetParametros: Boolean;
begin
  qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  if (not fEmptyStr(edtCodIte.Text)) then
    qryConsulta.ParamByName('CODITE').AsString := edtCodIte.Text;
  if (not fEmptyStr(mskLinGru.Text)) then
    qryConsulta.ParamByName('CODGRU').AsString := mskLinGru.Text;
  if (not fEmptyStr(edtCodFor.Text)) then
    qryConsulta.ParamByName('CODFOR').AsString := edtCodFor.Text;
  if (not fEmptyStr(edtCodMar.Text)) then
    qryConsulta.ParamByName('CODMAR').AsString := edtCodMar.Text;
  if (not fEmptyStr(edtCodVen.Text)) then
    qryConsulta.ParamByName('CODVEN').AsString := edtCodVen.Text;
  if (not fEmptyStr(edtCodMot.Text)) then
    qryConsulta.ParamByName('CODMOT').AsString := edtCodMot.Text;
  if (not fEmptyStr(edtCodEmp.Text)) then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  Result := True;
end;

procedure TfrmFatExclusaoVendasPerdidas.pPadraoPesquisa;
begin
  mskDtaIni.Text := DateToStr(VS_Date - 29);
  mskDtaFin.Text := DateToStr(VS_Date);
  pnlPesquisa.Visible := False;
  pSetFocus(edtCodIte);
end;

function TfrmFatExclusaoVendasPerdidas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaIni.Text, 0) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial inválida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser menor ou igual a Data Final!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaFin.Text, 0) = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final inválida!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
        edtDesIte.Text := 'TODOS'
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Produto não encontrado!', ['&O k']);
          Result := False;
        End
      End
    End

    Else If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(mskLinGru.Text) Then
        edtDesGru.Text := 'TODOS'
      Else
      Begin
        edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);
        If fEmptyStr(edtDesGru.Text)  Then
        Begin
          fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
          Result := False;
        End
      End
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
        edtNomFor.Text := 'TODOS'
      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fornecedor não encontrado!', ['&O k']);
          Result := False;
        End
      End
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
        edtDesMar.Text := 'TODOS'
      Else
      Begin
        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
        If fEmptyStr(edtDesMar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Marca não encontrada!', ['&O k']);
          Result := False;
        End
      End
    End

    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
        edtNomVen.Text := 'TODOS'
      Else
      Begin
        edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Vendedor não encontrado!', ['&O k']);
          Result := False;
        End
      End
    End

    Else If (Sender = edtCodMot) Then
    Begin
      If fEmptyStr(edtCodMot.Text) Then
        edtDesMot.Text := 'TODOS'
      Else
      Begin
        edtDesMot.Text := fRetMotivoVendasPerdidas(edtCodMot.Text);
        If fEmptyStr(edtDesMot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Motivo não encontrado!', ['&O k']);
          Result := False;
        End
      End
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
        edtDesEmp.Text := 'TODOS'
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End
      End
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatExclusaoVendasPerdidas.mskLinGruKeyPress(Sender: TObject; var Key: Char);
var
  arrGrupos: TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.pExcluirProdutosSelecionados;
var
  strSQL: string;
  qryExclusao: TUniQuery;
  arrVendasPerdidas: Array of TChaveVP;
  strCodEmp: string;
  strCodigo: string;
  intTamArr: Integer;
  intCont: Integer;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVVPD ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM IN (' + stlListSelecao.CommaText + ') ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  VPD_CODEMP, VPD_CODIGO ';

  Try
    qryExclusao := fCriaQuery();

    Try
      qryExclusao.SQL.Add(strSQL);
      qryExclusao.Open;

      intTamArr := 0;

      fStartTransaction();

      While not qryExclusao.Eof Do
      Begin
        if (strCodEmp <> qryExclusao.FieldByName('VPD_CODEMP').AsString) or
           (strCodigo <> qryExclusao.FieldByName('VPD_CODIGO').AsString) then
        Begin
          strCodEmp := qryExclusao.FieldByName('VPD_CODEMP').AsString;
          strCodigo := qryExclusao.FieldByName('VPD_CODIGO').AsString;

          Inc(intTamArr);
          SetLength(arrVendasPerdidas, intTamArr);

          arrVendasPerdidas[intTamArr - 1].strCodEmp := strCodEmp;
          arrVendasPerdidas[intTamArr - 1].strCodigo := strCodigo;
        End;

        fVerificaIntegridade(Self.Name, 'MOVVPD', qryExclusao);
        qryExclusao.Delete;
      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  MOVVPG.* ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVVPG ';
      strSQL := strSQL + '  LEFT JOIN MOVVPD ON VPD_CODEMP = VPG_CODEMP AND VPD_CODIGO = VPG_CODIGO ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  VPD_CODIGO IS NULL ';
      strSQL := strSQL + '  AND VPG_CODEMP = :CODEMP ';
      strSQL := strSQL + '  AND VPG_CODIGO = :CODIGO ';

      qryExclusao.Close;
      qryExclusao.SQL.Clear;
      qryExclusao.SQL.Add(strSQL);

      For intCont := 0 to (intTamArr - 1) Do
      Begin
        qryExclusao.Close;
        qryExclusao.ParamByName('CODEMP').AsString := arrVendasPerdidas[intCont].strCodEmp;
        qryExclusao.ParamByName('CODIGO').AsString := arrVendasPerdidas[intCont].strCodigo;
        qryExclusao.Open;

        If not qryExclusao.IsEmpty Then
        Begin
          fVerificaIntegridade(Self.Name, 'MOVVPG', qryExclusao);
          qryExclusao.Delete;
        End;
      End;

      fCommit();
      pLimparTela;
    Finally
      FreeAndNil(qryExclusao);
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, '[TfrmFatExclusaoVendasPerdidas.edtCodIteKeyPress]');
    End;
  End;
end;

procedure TfrmFatExclusaoVendasPerdidas.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodMot.Clear;
  edtDesMot.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  pPadraoPesquisa;
end;

end.
