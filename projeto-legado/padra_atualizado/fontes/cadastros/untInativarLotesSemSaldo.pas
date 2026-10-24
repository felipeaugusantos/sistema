unit untInativarLotesSemSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, EditFocus, untZClient, cxCheckBox;

type
  TfrmInativarLotesSemSaldo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxgCadLotDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgCadLotLevel: TcxGridLevel;
    cxgCadLot: TcxGridCitel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtRuaIni: TEditFocus;
    edtPredioIni: TEditFocus;
    edtAndarIni: TEditFocus;
    edtApartamentoIni: TEditFocus;
    edtCodLse: TEditFocus;
    edtDesLse: TEditFocus;
    edtRuaFin: TEditFocus;
    edtPredioFin: TEditFocus;
    edtAndarFin: TEditFocus;
    edtApartamentoFin: TEditFocus;
    btnBuscar: TBitBtnLocked;
    Label1: TLabel;
    Label7: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label8: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cxgCadLotDBTableViewCitelCODITE: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelDESITE: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelDTAVAL: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelLOCFIS: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelCRITIC: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelPICKIN: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelNUMLOT: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelCODLSE: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelLSEDES: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelR_U_A_: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelPREDIO: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelANDAR_: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelAPARTA: TcxGridDBColumn;
    cxgCadLotDBTableViewCitelMARCA: TcxGridDBColumn;
    BitBtnLocked1: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    Label14: TLabel;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodLseExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FMarca   : String;
    cdsCadLot: TZClient;

    arrCodIte: TConsultasArray;
    arrCodFor: TConsultasArray;
    arrLinGru: TConsultasArray;
    arrCodLse: TConsultasArray;

    function fGetSQL : String;
    procedure pSetaCampos;
    procedure pAlterarMarcacaoTodos;
    procedure pAtualizarLotes;
    procedure pLimparTela;

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesConsulta, untFuncoesSimples, untConsultas, untCfgLocFis,
  untGravando, untHelperCitel, untConstantes;

{$R *.dfm}

procedure TfrmInativarLotesSemSaldo.edtCodLseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLse, edtDesLse, arrCodLse, nil, fRetLocSep, 'do local de separação');
end;

procedure TfrmInativarLotesSemSaldo.edtCodLseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocSep(Self, edtCodLse, edtDesLse, nil, key, arrCodLse, False) Then
  Begin
    If fValidaCampos(edtCodLSe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInativarLotesSemSaldo.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  FMarca := 'S';
  TfrmGravando.fExecutarModal(pAlterarMarcacaoTodos, 'Aguarde...', '');
end;

procedure TfrmInativarLotesSemSaldo.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  FMarca := 'N';
  TfrmGravando.fExecutarModal(pAlterarMarcacaoTodos, 'Aguarde...', '');
end;

procedure TfrmInativarLotesSemSaldo.btnBuscarClick(Sender: TObject);
  Var
    strCodIte : String;
begin
  inherited;
  cdsCadLot.qryQuery.Close;
  cdsCadLot.qryQuery.SQL.Text := fGetSQL;

  cdsCadLot.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  pSetaParam(edtCodIte.Text, arrCodIte, strCodIte, 'CODITE', cdsCadLot.qryQuery);
  pSetaParam(edtCodFor.Text, arrCodFor, strCodIte, 'CODFOR', cdsCadLot.qryQuery);
  pSetaParam(edtCodLse.Text, arrCodLse, strCodIte, 'CODLSE', cdsCadLot.qryQuery);
  pSetaParam(mskLingru.Text, arrLingru, strCodIte, 'CODGRU', cdsCadLot.qryQuery);

  If cdsCadLot.qryQuery.FindParam('RUAINI') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('RUAINI').AsString := edtRuaIni.Text;

  If cdsCadLot.qryQuery.FindParam('RUAFIN') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('RUAFIN').AsString := edtRuaFin.Text;

  If cdsCadLot.qryQuery.FindParam('PREINI') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('PREINI').AsString := edtPredioIni.Text;

  If cdsCadLot.qryQuery.FindParam('PREFIN') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('PREFIN').AsString := edtPredioFin.Text;

  If cdsCadLot.qryQuery.FindParam('ANDINI') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('ANDINI').AsString := edtAndarIni.Text;

  If cdsCadLot.qryQuery.FindParam('ANDFIN') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('ANDFIN').AsString := edtAndarFin.Text;

  If cdsCadLot.qryQuery.FindParam('APTINI') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('APTINI').AsString := edtApartamentoIni.Text;

  If cdsCadLot.qryQuery.FindParam('APTFIN') <> Nil Then
    cdsCadLot.qryQuery.ParamByName('APTFIN').AsString := edtApartamentoFin.Text;

  cdsCadLot.fAbreClient(True, '', False, True);
  cxgCadLotDBTableViewCitel.ApplyBestFit();
  pSetFocus(cxgCadLot);

end;

procedure TfrmInativarLotesSemSaldo.btnConfirmaClick(Sender: TObject);
  Var
    blnLimpa : Boolean;
begin
//  inherited;
  if (not cdsCadLot.Active) Or (cdsCadLot.RecordCount <= 0) Then
  Begin
    fMensagem('','Não existe registros para confirmar!', ['&OK']);
    Exit;
  End;

  if not fEmptyStr(cxgCadLotDBTableViewCitel.DataController.Filter.FilterText) Then
  Begin
    fMensagem('', 'Existe um filtro aplicado no grid, a operação não será realizada! ' + #13 + 'O filtro será removido para você confirmar novamente os lotes que serão inativados!', ['&OK'] );
    cxgCadLotDBTableViewCitel.DataController.Filter.Clear;
    Exit;
  End;

  blnLimpa := False;
  Try
    cdsCadLot.DisableControls;
    cdsCadLot.Filter := 'MARCA = ' + QuotedStr('S');
    cdsCadLot.Filtered := True;

    If cdsCadLot.RecordCount = 0 Then
    Begin
      fMensagem('','Não existe registro marcado para confirmar!', ['&OK']);
      Exit;
    End;

    If fMensagem('', 'Deseja atualizar todos os lotes selecionados?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      TfrmGravando.fExecutarModal(pAtualizarLotes, 'Atualizando lotes...', '');
      blnLimpa := True;
    End

  Finally
    cdsCadLot.Filtered := False;
    cdsCadLot.Filter := '';
    cdsCadLot.First;
    cdsCadLot.EnableControls;

    if blnLimpa Then
    Begin
      pLimparTela()
    End;
  End;

end;

procedure TfrmInativarLotesSemSaldo.pLimparTela();
Begin
  cdsCadLot.Close;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodFor.Clear;
  edtDesFor.Clear;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodLse.Clear;
  edtDesLse.Clear;
  edtRuaIni.Clear;
  edtRuaFin.Clear;
  edtPredioIni.Clear;
  edtPredioFin.Clear;
  edtAndarIni.Clear;
  edtAndarFin.Clear;
  edtApartamentoIni.Clear;
  edtApartamentoFin.Clear;

  pSetFocus(edtCodIte);
End;

procedure TfrmInativarLotesSemSaldo.pAtualizarLotes;
Begin
  frmGravandoGenericProcedure.pgbStatus.Visible := True;
  frmGravandoGenericProcedure.pgbStatus.Properties.Max := cdsCadLot.RecordCount;
  While Not cdsCadLot.Eof Do
  Begin
    fExecutaSQL('UPDATE CADLOT SET LOT_STATUS = "N" WHERE AUTOINCREM = ' + QuotedStr(cdsCadLot.FieldByName('AUTOINCREM').AsString));
    cdsCadLot.Next;
    frmGravandoGenericProcedure.pgbStatus.pStep;
    Application.ProcessMessages;
  End;
End;

procedure TfrmInativarLotesSemSaldo.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmInativarLotesSemSaldo.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmInativarLotesSemSaldo.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmInativarLotesSemSaldo.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmInativarLotesSemSaldo.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT "S" AS MARCA,         ';
  Result := Result + '        CADLOT.AUTOINCREM,    ';
  Result := Result + '        LOT_CODEMP AS CODEMP, ';
  Result := Result + '        LOT_CODITE AS CODITE, ';
  Result := Result + '        ITE_DESITE AS DESITE, ';
  Result := Result + '        LOT_DTAVAL AS DTAVAL, ';
  Result := Result + '        LOT_LOCFIS AS LOCFIS, ';
  Result := Result + '        IF(LOC_CRITIC = "S", "SIM", "NÃO") AS CRITIC, ';
  Result := Result + '        IF(LOC_PICKIN = "S", "SIM", "NÃO") AS PICKIN, ';
  Result := Result + '        LOT_NUMLOT AS NUMLOT, ';
  Result := Result + '        LOC_CODLSE AS CODLSE, ';
  Result := Result + '        LSE_DESCRI AS LSEDES, ';
  Result := Result + '        LOC_R_U_A_ AS R_U_A_, ';
  Result := Result + '        LOC_PREDIO AS PREDIO, ';
  Result := Result + '        LOC_ANDAR_ AS ANDAR_, ';
  Result := Result + '        LOC_APARTA AS APARTA  ';
  Result := Result + ' FROM CADLOT                  ';
  Result := Result + '   LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ';
  Result := Result + '   LEFT  JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ';
  Result := Result + ' WHERE LOT_SALDOS = 0 ';
  Result := Result + '   AND LOT_CODEMP = :CODEMP ';
  Result := Result + '   AND LOT_STATUS = "S" ';
  Result := Result + '   AND LOT_NUMLOT <> "' + string(STR_A_DEFINIR) + '" ';
  Result := Result + '   AND LOT_GARPRI <> "S" ';
  Result := Result + '   AND LOT_ARMPRI <> "S" ';

  Result := Result + fStrLocate(edtCodIte, arrCodIte, 'LOT_CODITE', 'CODITE');
  Result := Result + fStrLocate(edtCodFor, arrCodFor, 'ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodLse, arrCodLse, 'LOC_CODLSE', 'CODLSE');
  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU', 'CODGRU');

  If not fEmptyStr(edtRuaIni.Text) Then
  Begin
    If not fEmptyStr(edtRuaFin.Text) Then
    Begin
      Result := Result + ' AND LOC_R_U_A_ BETWEEN :RUAINI AND :RUAFIN '
    End
    Else
      Result := Result + ' AND LOC_R_U_A_ = :RUAINI ';
  End;

  If not fEmptyStr(edtPredioIni.Text) Then
  Begin
    If not fEmptyStr(edtPredioFin.Text) Then
    Begin
      Result := Result + ' AND LOC_PREDIO BETWEEN :PREINI AND :PREFIN '
    End
    Else
      Result := Result + ' AND LOC_PREDIO = :PREINI ';
  End;

  If not fEmptyStr(edtAndarIni.Text) Then
  Begin
    If not fEmptyStr(edtAndarFin.Text) Then
    Begin
      Result := Result + ' AND LOC_ANDAR_ BETWEEN :ANDINI AND :ANDFIN '
    End
    Else
      Result := Result + ' AND LOC_ANDAR_ = :ANDINI ';
  End;

  If not fEmptyStr(edtApartamentoIni.Text) Then
  Begin
    If not fEmptyStr(edtApartamentoFin.Text) Then
    Begin
      Result := Result + ' AND LOC_APARTA BETWEEN :APTINI AND :APTFIN '
    End
    Else
      Result := Result + ' AND LOC_APARTA = :APTINI ';
  End;


end;

procedure TfrmInativarLotesSemSaldo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if cdsCadLot.Active And (cdsCadLot.RecordCount > 0) Then
  Begin
    If fMensagem('', 'Deseja cancelar a Operação?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      pLimparTela();
    End;

    Action := caNone;
  End;

  inherited;
end;

procedure TfrmInativarLotesSemSaldo.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  pSetaCodLse(edtCodLse);

  cdsCadLot := TZClient.Create(Self,'');
  cxgCadLotDBTableViewCitel.DataController.DataSource := cdsCadLot.dtsSource;
  pSetaCampos;

end;

procedure TfrmInativarLotesSemSaldo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCadLot);
  inherited;
end;

function TfrmInativarLotesSemSaldo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte, arrCodIte);
    End

    Else
    If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrCodFor);
    End

    Else
    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru,'',6);
    End

    Else
    If (Sender = edtRuaIni) Then
    Begin
      edtRuaFin.Enabled := not fEmptyStr(edtRuaIni.Text);
      If Not edtRuaFin.Enabled Then
        edtRuaFin.Clear;
    End

    Else
    If (Sender = edtPredioIni) Then
    Begin
      edtPredioFin.Enabled := not fEmptyStr(edtPredioIni.Text);
      If Not edtPredioFin.Enabled Then
        edtPredioFin.Clear;
    End

    Else
    If (Sender = edtAndarIni) Then
    Begin
      edtAndarFin.Enabled := not fEmptyStr(edtAndarIni.Text);
      If Not edtAndarFin.Enabled Then
        edtAndarFin.Clear;
    End

    Else
    If (Sender = edtApartamentoIni) Then
    Begin
      edtApartamentoFin.Enabled := not fEmptyStr(edtApartamentoIni.Text);
      If Not edtApartamentoFin.Enabled Then
        edtApartamentoFin.Clear;
    End;

  End;

end;

procedure TfrmInativarLotesSemSaldo.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmInativarLotesSemSaldo.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInativarLotesSemSaldo.pAlterarMarcacaoTodos;
begin
  Try
    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := cdsCadLot.RecordCount;
    cdsCadLot.DisableControls;

    cdsCadLot.Filter := cxgCadLotDBTableViewCitel.DataController.Filter.FilterText;
    cdsCadLot.Filtered := True;

    cdsCadLot.First;
    While Not cdsCadLot.Eof Do
    Begin
      cdsCadLot.Edit;
      cdsCadLot.FieldByName('MARCA').AsString := FMarca;
      cdsCadLot.Post;
      cdsCadLot.Next;

      frmGravandoGenericProcedure.pgbStatus.pStep;
      Application.ProcessMessages;
    End;

  Finally
    cdsCadLot.Filtered := False;
    cdsCadLot.Filter := '';
    cdsCadLot.First;
    cdsCadLot.EnableControls;
  End;

end;

procedure TfrmInativarLotesSemSaldo.pSetaCampos;
  Var
    objCampo     : TCfgLocFis;
    objCfgLocFis : TCamposCfgLocFis;
Begin
  objCfgLocFis := TCamposCfgLocFis.Create;
  Try

    For objCampo in objCfgLocFis Do
    Begin

      If objCampo.strNomCam = 'LOC_CODLSE' Then
        Continue;

      With objCampo Do
      Begin
        If strNomCam = 'LOC_R_U_A_' Then
        Begin
          pSetaConfiguracoes(edtRuaIni);
          pSetaConfiguracoes(edtRuaFin);
        End

        Else
        If strNomCam = 'LOC_PREDIO' Then
        Begin
          pSetaConfiguracoes(edtPredioIni);
          pSetaConfiguracoes(edtPredioFin);
        End

        Else
        If strNomCam = 'LOC_ANDAR_' Then
        Begin
          pSetaConfiguracoes(edtAndarIni);
          pSetaConfiguracoes(edtAndarFin);
        End

        Else
        If strNomCam = 'LOC_APARTA' Then
        Begin
          pSetaConfiguracoes(edtApartamentoIni);
          pSetaConfiguracoes(edtApartamentoFin);
        End;
      End;
    End;
  Finally
    FreeAndNil(objCfgLocFis);
  End;

End;

end.
