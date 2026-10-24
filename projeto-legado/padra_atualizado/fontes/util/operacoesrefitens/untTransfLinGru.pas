{****************************}
{* qryConGru -> CADGRU      *}
{* qryConUni -> CADUNI      *}
{* qryConMar -> CADMAR      *}
{* qryConFor -> CADFOR      *}
{* qryConIte -> CADITE      *}
{*************************JB*}

{****************************}
{* A TRANSFERENCIA DE LINHA *}
{* E GRUPO SO TRANSFERE O   *}
{* CÓDIGO DA LIN/GRU DO     *}
{* CADASTRO DE PRODUTOS.    *}
{*--------------------------*}
{* ELA NÃO MUDA NADA EM     *}
{* OUTRAS TABELAS, POR ISSO *}
{* NÃO VALIDA INTEGRIDADE   *}
{*************************GB*}

unit untTransfLinGru;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, untZClient,
  EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, {Qt,} Menus, StrUtils,
  AppEvnts, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, untTransfImportAutomatico;


Type
  TCamposGrupo = record
    strNomArq: String;
    strDesCam: String;
    strCamCod: String;
    strNomCam: String;
  End;

type
  TForeignKey = Record
    strCampoOri: String;
    strTabela  : String;
    strCampoRel: String;
End;

type
  TForeignKeyArray = Array of TForeignKey;

type
  TfrmTransfLinGru = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    Label2: TLabel;
    edtDesIte: TEditFocus;
    Label3: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label5: TLabel;
    mskNovGru: TMaskEditFocus;
    pnlBotoesTransf: TPanel;
    pnlProgresso: TPanel;
    pgbProgresso: TProgressBar;
    lsvArqAlterados: TListView;
    Label6: TLabel;
    edtCodIte: TEditFocus;
    Label8: TLabel;
    edtCodMar: TEditFocus;
    Label9: TLabel;
    edtCodFor: TEditFocus;
    Label10: TLabel;
    edtDesGru: TEditFocus;
    edtNovGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnSairTransf: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    frxReport: TfrxReport;
    btnHlpImp: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskNovGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairTransfClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lsvArqAlteradosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
  private
    { Private declarations }

    qryConIte: TUniQuery;
    qryConFor: TUniQuery;
    qryConMar: TUniQuery;
    qryConGru: TUniQuery;
    objExcelTrans: TTransfImportAutomatico;
    arrCamposGrupo: Array Of TCamposGrupo;
    cdsGenIte: TZClient;

    procedure pLimparCabecalho;

    procedure pCarregaLinGru(strCodGru: String; edtGrupo: TEdit);
    procedure pCarregaMarca;
    procedure pCarregaFornecedor;
    procedure pCarregaItem;

    procedure pAtribuiTabelas;

    function fAtualizaGrupo(strNomArq, strCamCod, strNomCam, strCodIte: String;
      intOpcao: Integer): Integer;

    function fAlteraGrupoItens: Boolean;
    function fSelecionaRegistros(cdsDados : TZClient) : Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmTransfLinGru: TfrmTransfLinGru;

implementation

uses  untfuncoesSimples,  untPesqAux, untPai,
      untWaitWindow,
      untCadGru, untConsultas, untTypesSistema, untTransfLinGruSelecao;

{$R *.dfm}

{ TfrmTransfLinGru }

function TfrmTransfLinGru.fSelecionaRegistros(cdsDados: TZClient): Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADITE.*,     ';
  strSQL := strSQL + '  "S" AS MAR_SN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODGRU = :CODGRU ';

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_CODITE = :CODITE ';
  End;

  If Not fEmptyStr(edtDesIte.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_REFERE LIKE :REFERE ';
  End;

  If Not fEmptyStr(edtCodUni.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_CODUNI = :CODUNI ';
  End;

  If Not fEmptyStr(edtCodMar.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_CODMAR = :CODMAR ';
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    strSQL := strSQL + ' AND ITE_CODFOR = :CODFOR ';
  End;

  With cdsDados, qryQuery Do
  Begin
    lsvArqAlterados.Items.Clear;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODGRU').AsString := mskLinGru.Text;

    If Not fEmptyStr(edtCodIte.Text) Then
    Begin
      ParamByName('CODITE').AsString := edtCodIte.Text;
    End;

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      ParamByName('DESITE').AsString := edtDesIte.Text + '%';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      ParamByName('REFERE').AsString := edtRefere.Text + '%';
    End;

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      ParamByName('CODUNI').AsString := edtCodUni.Text;
    End;

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      ParamByName('CODMAR').AsString := edtCodMar.Text;
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      ParamByName('CODFOR').AsString := edtCodFor.Text;
    End;

    fAbreClient(True, 'TfrmTransfLinGru.fAlteraGrupoItens');

    If IsEmpty Then
    Begin
      Result := False;
      Exit;
    End;

  End;

  If Not objExcelTrans.blnExecutandoTransferencia Then
  Begin
    pCriarFormularios(TfrmTransfLinGruSelecao, frmTransfLinGruSelecao);
    Try
      cdsDados.Filtered := False;

      frmTransfLinGruSelecao.cdsCadIte := cdsDados;

      if (frmTransfLinGruSelecao.ShowModal = mrOK) Then
      Begin
        cdsDados.Filter   := ' MAR_SN = ' + QuotedStr('S');
        cdsDados.Filtered := True;
        Result := ( not cdsDados.IsEmpty ) ;
      End
      Else
      Begin
        Result := True;
        cdsDados.Filtered := False;
        cdsDados.Filter   := '';
        cdsDados.Close;
      End;

    Finally
      FreeAndNIl(frmTransfLinGruSelecao);
    End;
  End
  Else
    Result := True;

end;

function TfrmTransfLinGru.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        pCarregaLinGru(mskLinGru.Text, edtDesGru);
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          objExcelTrans.pAddNotificacao('Essa Linha / Grupo não está cadastrada!');
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadGru(mskLinGru.Text) Then
        Begin
          objExcelTrans.pAddNotificacao('Linha / Grupo não é permitido!');
          Result := False;
        End
      End
      Else
      Begin
        objExcelTrans.pAddNotificacao('O Grupo Atual deve ser preenchido!');
        Result := False;
      End;

    End

    Else If (Sender = mskNovGru) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskNovGru.Text)) Then
      Begin
        pCarregaLinGru(mskNovGru.Text, edtNovGru);
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          objExcelTrans.pAddNotificacao('Essa Linha / Grupo não está cadastrada!');
          Result := False;
        End

        Else If Not fValidaLinhaGrupoCadGru(mskNovGru.Text) Then
        Begin
          objExcelTrans.pAddNotificacao('Linha não é permitida!');
          Result := False;
        End

        Else If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
        Begin
          Result       := False;
          blnMudarFoco := False;
          pSetFocus(mskLinGru);
        End

        Else If Trim(mskLinGru.Text) = Trim(mskNovGru.Text) Then
        Begin
          objExcelTrans.pAddNotificacao('O Grupo Atual e o Novo Grupo deve ser diferentes!');
          Result := False;
        End;
      End
      Else
      Begin
        objExcelTrans.pAddNotificacao('O Grupo Atual deve ser preenchido!');
        Result := False;
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin

      If Not fEmptyStr(edtCodIte.Text) Then
      Begin

        pCarregaItem;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          objExcelTrans.pAddNotificacao('Esse produto não está cadastrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtCodUni) Then
    Begin
      If (Not fEmptyStr(edtCodUni.Text)) And fEmptyStr(fRetNomUnidade(edtCodUni.Text)) Then
      Begin
        objExcelTrans.pAddNotificacao('Essa Unidade não está cadastrada!');
        Result := False;
      End;
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          objExcelTrans.pAddNotificacao('Essa Marca não está cadastrada!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          objExcelTrans.pAddNotificacao('Esse Fornecedor não está cadastrado!');
          Result := False;
        End;
      End;

      If Result And blnBuscaPorChave Then
      Begin
        if not fSelecionaRegistros(cdsGenIte) Then
        Begin
          objExcelTrans.pAddNotificacao('Não há itens com esses Dados!');
          Result := False;
          Exit;
        End;
      End;

    End
    
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmTransfLinGru.pAtribuiTabelas;
begin
  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmTransfLinGru.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmTransfLinGru.pCarregaLinGru(strCodGru: String; edtGrupo: TEdit);
begin
  pPesquisaLinGru(qryConGru, qryConGru, strCodGru);
  With qryConGru Do
  Begin
    edtGrupo.Text := FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmTransfLinGru.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, edtCodMar.Text);
  With qryConMar Do
  Begin
    edtDesMar.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmTransfLinGru.pEscapePressed;
begin
  inherited;

end;

procedure TfrmTransfLinGru.FormCreate(Sender: TObject);
  Var
    intPosicao: Integer;
begin
  inherited;
  cdsGenIte := TZClient.Create(Self);
  objExcelTrans := TTransfImportAutomatico.Create;

  pAtribuiTabelas;

  intPosicao := 0;
  SetLength(arrCamposGrupo, succ(intPosicao));
  arrCamposGrupo[intPosicao].strNomArq := 'CADITE';
  arrCamposGrupo[intPosicao].strDesCam := 'Cadastro de Itens - Geral';
  arrCamposGrupo[intPosicao].strNomCam := 'ITE_CODGRU';
  arrCamposGrupo[intPosicao].strCamCod := 'ITE_CODITE';

{  inc(intPosicao);
  SetLength(arrCamposGrupo, succ(intPosicao));
  arrCamposGrupo[intPosicao].strNomArq := 'DETMET';
  arrCamposGrupo[intPosicao].strDesCam := 'Metas - Detalhe';
  arrCamposGrupo[intPosicao].strNomCam := 'MET_CODGRU';
  arrCamposGrupo[intPosicao].strCamCod := 'MET_CODGRU';

  inc(intPosicao);
  SetLength(arrCamposGrupo, succ(intPosicao));
  arrCamposGrupo[intPosicao].strNomArq := 'FORMET';
  arrCamposGrupo[intPosicao].strDesCam := 'Metas - Galonagem';
  arrCamposGrupo[intPosicao].strNomCam := 'MET_CODGRU';
  arrCamposGrupo[intPosicao].strCamCod := 'MET_CODGRU';

  inc(intPosicao);
  SetLength(arrCamposGrupo, succ(intPosicao));
  arrCamposGrupo[intPosicao].strNomArq := 'FORDET';
  arrCamposGrupo[intPosicao].strDesCam := 'Metas Vendedor - Galonagem';
  arrCamposGrupo[intPosicao].strNomCam := 'DET_CODGRU';
  arrCamposGrupo[intPosicao].strCamCod := 'DET_CODGRU';

  inc(intPosicao);
  SetLength(arrCamposGrupo, succ(intPosicao));
  arrCamposGrupo[intPosicao].strNomArq := 'ATIGRU';
  arrCamposGrupo[intPosicao].strDesCam := 'Atividade + Linha/Grupo';
  arrCamposGrupo[intPosicao].strNomCam := 'ATI_CODGRU';
  arrCamposGrupo[intPosicao].strCamCod := 'ATI_CODGRU';}

end;

procedure TfrmTransfLinGru.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsGenIte);
  FreeAndNil(objExcelTrans);
end;

function TfrmTransfLinGru.fAlteraGrupoItens: Boolean;
  Var
    strSQL  : String;
    strItens: String;

    intTamMat      : Integer;
    intContador    : Integer;
    intContador2   : Integer;
    intRecordCount : Integer;
    intRegAlterados: Integer;

begin

  lsvArqAlterados.Items.Clear;

  strItens := '';

  Result    := True;
  intTamMat := Length(arrCamposGrupo);

  Try
    With cdsGenIte Do
    Begin
      If IsEmpty Then
      Begin
        objExcelTrans.pAddNotificacao('Não há itens com esses Dados!');
        Result := False;
        Exit;
      End;

      {********************************************}
      {* PEGA AS TABELAS REFERENTES AO INVENTÁRIO *}
      {* FÍSICO                                   *}
      {*****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SHOW TABLES LIKE "I\_%" ';

      pnlProgresso.Visible  := True;
      pgbProgresso.Max      := RecordCount;
      pgbProgresso.Position := 0;

      intRecordCount := RecordCount;

      While Not Eof Do
      Begin

        strItens := strItens + FieldByName('ITE_CODITE').AsString;

        If RecNo < intRecordCount Then
          strItens := strItens + ', ';

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
        Next;

      End;

      intContador := 0;

      While intContador < intTamMat Do
      Begin

        lsvArqAlterados.Items.Add;
        lsvArqAlterados.Items[intContador].Caption := arrCamposGrupo[intContador].strDesCam;
        lsvArqAlterados.Items[intContador].SubItems.Add('Processando...');
        Inc(intContador);
        Application.ProcessMessages;

      End;

      intContador := 0;

      While intContador < intTamMat Do
      Begin

        Application.ProcessMessages;
        intRegAlterados := 0;

        For intContador2 := 1 To 1 Do
        Begin

          intRegAlterados := intRegAlterados + fAtualizaGrupo(arrCamposGrupo[intContador].strNomArq,
                                                              arrCamposGrupo[intContador].strCamCod,
                                                              arrCamposGrupo[intContador].strNomCam,
                                                              strItens, intContador2);

          Application.ProcessMessages;

        End;
        lsvArqAlterados.Items[intContador].Selected := True;
        lsvArqAlterados.Items[intContador].MakeVisible(False);
        lsvArqAlterados.Items[intContador].SubItems[0] := IntToStr(intRegAlterados);

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
        Inc(intContador);

      End;

      pGravarTabelaLog(mskLinGru.Text, mskNovGru.Text, 'CADGRU', strItens);

    End;

    cdsGenIte.Close;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If objExcelTrans.blnExecutandoTransferencia Then
        objExcelTrans.pAddNotificacao(E.Message)
      Else
        pMensagensErro(E.Message, '[fAlteraGrupoItens]');
    End;
  End;

end;

{*****************************************}
{* OPÇÃO:                                *}
{*                                       *}
{* 1 -> ARQUIVO CAIXA 1                  *}
{* 2 -> ARQUIVO CAIXA 2                  *}
{* 3 -> ARQUIVO DELETADO CAIXA 1         *}
{* 4 -> ARQUIVO DELETADO CAIXA 2         *}
{**************************************MV*}
function TfrmTransfLinGru.fAtualizaGrupo(strNomArq, strCamCod, strNomCam, strCodIte: String;
  intOpcao: Integer): Integer;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    Result := 0;

    qryGenTmp := fCriaQuery(Self);

    If intOpcao = 2 Then
      strNomArq := 'DEL_' + strNomArq;

    If Not fTabelaExiste(strNomArq) Then
      Exit;

    strCodIte := Trim(StrCodIte);
    If (RightStr(strCodIte, 1) = ',') Then
      strCodIte := Copy(strCodIte, 1, Length(strCodIte) - 1);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + strNomArq;
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + strNomCam + ' = :NOVGRU ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCamCod + '  IN (' + strCodIte + ') AND ';
    strSQL := strSQL + strNomCam + '  = :GRUATU ';

    With qryGenTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOVGRU').AsString := mskNovGru.Text;
      ParamByName('GRUATU').AsString := mskLinGru.Text;
      ExecSQL;
      Result := RowsAffected;
      Close;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmTransfLinGru.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  If objExcelTrans.blnExecutandoTransferencia Then
    fSelecionaRegistros(cdsGenIte);

  If not cdsGenIte.Active Then
  Begin
    objExcelTrans.pAddNotificacao('Nenhum Registro foi Selecionado!');
    Exit;
  End;

  If (Sender <> objExcelTrans) And
     (fMensagem('', 'Confirma transferência?', ['&Sim', '&Não'], 2) <> 1) Then
  Begin

    pSetFocus(Self);
    Exit;

  End;

  pSetFocus(Self);

  Screen.Cursor := crHourGlass;

  btnConfirma.Enabled := False;
  btnSairTransf.Enabled := False;

  mskNovGru.Enabled := False;

  Application.ProcessMessages;

  fStartTransaction;

  If fAlteraGrupoItens Then
  Begin
    fCommit;
    pLimparCabecalho;
    If objExcelTrans.blnExecutandoTransferencia Then
      objExcelTrans.pAddNotificacao('Transferência realizada!');
  End
  Else
  Begin
    fRollBack;
  End;


  pnlProgresso.Visible := False;

  pSetFocus(mskLinGru);

  mskNovGru.Enabled := True;
  btnConfirma.Enabled := True;
  btnSairTransf.Enabled := True;

  Screen.Cursor := crDefault;
end;


procedure TfrmTransfLinGru.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrSel) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfLinGru.mskNovGruKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskNovGru, edtNovGru, qryConGru, Key, arrSel) Then
  Begin
    if fValidaCampos(mskNovGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfLinGru.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrSel) Then  
  Begin
    if fValidaCampos(edtCodUni, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfLinGru.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfLinGru.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then  
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfLinGru.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then    
  Begin
    pCarregaItem;

    qryConIte.Close;
  End;

end;

procedure TfrmTransfLinGru.pCarregaItem;
  Var
    blnBuscaCodBar: Boolean;
begin

  blnBuscaCodBar := True;

  If (Length(Trim(edtCodIte.Text)) <= fTamCodIte) Then
  Begin
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConIte, qryConIte, edtCodIte.Text, '', blnBuscaCodBar);
  With qryConIte Do
  Begin
    If blnBuscaCodBar Then
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
  End;

end;

procedure TfrmTransfLinGru.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxReport);
end;

procedure TfrmTransfLinGru.btnImpExcelClick(Sender: TObject);
begin
  inherited;
  objExcelTrans.pAddEditInput(TEdit(mskLinGru), 7, True, True);
  objExcelTrans.pAddEditInput(TEdit(mskNovGru), 7, True, True);
  objExcelTrans.pAddEditInput(edtCodIte, fTamCodIte);
  objExcelTrans.pAddEditInput(edtDesIte);
  objExcelTrans.pAddEditInput(edtRefere);
  objExcelTrans.pAddEditInput(edtCodUni, 2);
  objExcelTrans.pAddEditInput(edtCodMar, 3);
  objExcelTrans.pAddEditInput(edtCodFor, 8);
  objExcelTrans.pEventoQueTransfere := btnConfirma.OnClick;
  objExcelTrans.fExecutar;
end;

procedure TfrmTransfLinGru.btnSairTransfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmTransfLinGru.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmTransfLinGru.pLimparCabecalho;
  Var
    intContador: Integer;
begin

  For intContador := 0 To pnlCabecalho.ControlCount -1 Do
  Begin
    If (pnlCabecalho.Controls[intContador] Is TEdit) Then
      (pnlCabecalho.Controls[intContador] As TEdit).Clear
    Else If (pnlCabecalho.Controls[intContador] Is TMaskEdit) Then
      (pnlCabecalho.Controls[intContador] As TMaskEdit).Clear; 
  End;

  edtDesGru.Clear;
  edtNovGru.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;

end;

procedure TfrmTransfLinGru.lsvArqAlteradosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnSairTransf.Click;
  End;
end;

procedure TfrmTransfLinGru.FormShow(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, Processando ... ';
    frmWaitWindow.tmrWait.Enabled  := False;
    AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;

    frmWaitWindow.Close;
  Except
    On E: Exception Do
    Begin
      If objExcelTrans.blnExecutandoTransferencia Then
        objExcelTrans.pAddNotificacao(E.Message)
      Else
        pMensagensErro(E.Message, '[frmTransfLinGru.pCarregaCadUni]');
    End;
  End;

  pFreeAndNil(frmWaitWindow);
  Screen.Cursor := crDefault;

end;

end.


