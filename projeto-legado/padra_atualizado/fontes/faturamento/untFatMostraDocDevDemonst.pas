unit untFatMostraDocDevDemonst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DB, Grids, DBGridCitel, DBGrids, EditFocus, UniClientDataSet, Mask, MaskEditFocus, strUtils, UniDataSetProvider, Uni, untFuncFat,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMostraDocDevDemonst = class(TfrmPaiSimples)
    dbgDocume: TDBGridCitel;
    pnlBotao: TPanel;
    dtsDocume: TDataSource;
    btnMarTud: TBitBtnLocked;
    btnDesTud: TBitBtnLocked;
    btnSelDoc: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    edtQtdDocSel: TEditFocus;
    edtTotGerSel: TEditFocus;
    GroupBox1: TGroupBox;
    Shape3: TShape;
    Label10: TLabel;
    Shape4: TShape;
    Label13: TLabel;
    pnlFiltros: TPanel;
    Label18: TLabel;
    edtNumDoc: TEditFocus;
    Label19: TLabel;
    edtEspDoc: TEditFocus;
    Label15: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label20: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelDocClick(Sender: TObject);
    procedure dbgDocumeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnMarTudClick(Sender: TObject);
    procedure btnDesTudClick(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryDocume: TUniQuery;
    procedure pMarcaDesmarca;
    procedure pMarcaDesmarcaTudo;
    procedure pCalculaTotalSelecionado;
    procedure pCarregaDocumento;
    procedure pLimpaTela;
    function  fGetSQL: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    fatVenda   : TFatVenda;
    blnConfirma: Boolean;
    strCodCli  : String;
  end;

var
  frmFatMostraDocDevDemonst: TfrmFatMostraDocDevDemonst;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraDocDevDemonst.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (StrToIntDef(edtQtdDocSel.Text, 0) = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum documento selecionado!', ['&O k']);
    pSetFocus(dbgDocume);
    Exit;
  End
  Else
  Begin
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmFatMostraDocDevDemonst.btnDesTudClick(Sender: TObject);
begin
  inherited;
  If (fatVenda.cdsDocDem.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um documento!', ['&Ok']);
    Exit;
  End;
  pMarcaDesmarcaTudo;
end;

procedure TfrmFatMostraDocDevDemonst.btnMarTudClick(Sender: TObject);
begin
  inherited;
  If (fatVenda.cdsDocDem.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário carregar ao menos um documento!', ['&Ok']);
    Exit;
  End;
  pMarcaDesmarcaTudo;
end;

procedure TfrmFatMostraDocDevDemonst.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraDocDevDemonst.btnSelDocClick(Sender: TObject);
begin
  inherited;
  If (fatVenda.cdsDocDem.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário carregar ao menos um documento!', ['&Ok']);
    Exit;
  End;
  pMarcaDesmarca;
  pCalculaTotalSelecionado;
end;

procedure TfrmFatMostraDocDevDemonst.dbgDocumeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  blnSelected: Boolean;
begin
  inherited;
  blnSelected := ((State = [gdSelected..gdFocused]) Or ((State = [gdSelected]))) And (dbgDocume.Focused);

  If fatVenda.cdsDocDem.FieldByName('MARDES').AsString = 'M' Then
  Begin
    If (blnSelected) Then
      dbgDocume.Canvas.Font.Color := clLime
    Else
      dbgDocume.Canvas.Font.Color := clBlue;
  End;

  dbgDocume.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatMostraDocDevDemonst.dbgDocumeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    btnSelDoc.Click;
end;

procedure TfrmFatMostraDocDevDemonst.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmFatMostraDocDevDemonst.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryDocume);
end;

procedure TfrmFatMostraDocDevDemonst.FormCreate(Sender: TObject);
begin
  inherited;
  qryDocume := fCriaQuery(Self);
  blnConfirma := False;
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
end;

procedure TfrmFatMostraDocDevDemonst.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_F7) Then
    btnMarTud.Click
  Else If (Key = VK_F8) Then
    btnDesTud.Click
  Else If (Key = VK_ESCAPE) Then
  Begin
    If (dbgDocume.Focused) Then
      pLimpaTela
    Else
      btnSairConf.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else
    inherited;  
end;

procedure TfrmFatMostraDocDevDemonst.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(fatVenda.cdsDocDem) then FreeAndNil(fatVenda.cdsDocDem);
  if Assigned(fatVenda.dspDocDem) then FreeAndNil(fatVenda.dspDocDem);

  fatVenda.cdsDocDem := TUniClientDataSet.Create(Nil);
  fatVenda.dspDocDem := TUniDataSetProvider.Create(Nil);

  edtQtdDocSel.Text := '0';
  edtTotGerSel.Text := '0,00';

  edtCodCli.Text := strCodCli;
  edtNomCli.Text := fRetNomCliente(strCodCli);

  mskDtaIni.Enabled := False;
  mskDtaFin.Enabled := False;
end;

function TfrmFatMostraDocDevDemonst.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEspDoc) Then
    Begin

      If (fEmptyStr(edtEspDoc.Text)) And (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie do documento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(edtEspDoc.Text)) And (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número do documento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fEmptyStr(edtEspDoc.Text)) And (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        mskDtaIni.Enabled := True;
        mskDtaFin.Enabled := True;
      End
      Else
      Begin
        mskDtaIni.Clear;
        mskDtaFin.Clear;

        mskDtaIni.Enabled := False;
        mskDtaFin.Enabled := False;

        pCarregaDocumento;
      End;
    End

    Else If (Sender = mskDtaIni) And (mskDtaIni.Enabled) Then
    Begin
      If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin
      If (fEmptyDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        pSetFocus(mskDtaIni);
        blnMudarFoco := False;
      End
      Else If (StrToDateDef(mskDtaFin.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
        pSetFocus(mskDtaIni);
        blnMudarFoco := False;
      End
      Else
        pCarregaDocumento;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatMostraDocDevDemonst.pCalculaTotalSelecionado;
Var
  cdsDocTmp: TUniClientDataSet;
  intQtdSel: Integer;
  fltTotSel: Double;
begin

  Try
    If (fatVenda.cdsDocDem.IsEmpty) Then
      Exit;

    cdsDocTmp      := TUniClientDataSet.Create(Self);
    cdsDocTmp.Data := fatVenda.cdsDocDem.Data;
    cdsDocTmp.Open;
    cdsDocTmp.Filter := 'MARDES = ''M''';
    cdsDocTmp.Filtered := True;

    intQtdSel := 0;
    fltTotSel := 0.00;

    With cdsDocTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        Inc(intQtdSel);
        fltTotSel := fltTotSel + FieldByName('VLRCON').AsFloat;
        Next;
      End;
    End;

    edtQtdDocSel.Text := intToStr(intQtdSel);
    edtTotGerSel.Text := FormatFloat('#,##0.00', fltTotSel);

  Finally
    FreeAndNil(cdsDocTmp);
  End;

end;

procedure TfrmFatMostraDocDevDemonst.pCarregaDocumento;
begin

  Try
    {********************************************************************************}
    {* TRYING TO MODIFY READONLY                                                    *}
    {* TAVA NO SHOW COLOQUEI NO  MOMENTO QUE VAI CARREGAR POR CAUSA DO ERRO ACIMA.  *}
    {******************************************************************************LE}
    if Assigned(fatVenda.cdsDocDem) then FreeAndNil(fatVenda.cdsDocDem);
    if Assigned(fatVenda.dspDocDem) then FreeAndNil(fatVenda.dspDocDem);

    fatVenda.cdsDocDem := TUniClientDataSet.Create(Nil);
    fatVenda.dspDocDem := TUniDataSetProvider.Create(Nil);

    fatVenda.dspDocDem.DataSet := qryDocume;
    fatVenda.cdsDocDem.SetProvider(fatVenda.dspDocDem);
    dtsDocume.DataSet          := fatVenda.cdsDocDem;
    dbgDocume.DataSource       := dtsDocume;

    With qryDocume Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQL);

      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End
      Else
      Begin
        ParamByName('DTAINI').AsDate := StrToDateDef(mskDtaIni.Text, 0);
        ParamByName('DTAFIN').AsDate := StrToDateDef(mskDtaFin.Text, 0);
      End;

      ParamByName('CODCLI').AsString := edtCodCli.Text;

      Open;
      pSetaClient(qryDocume);

      fatVenda.cdsDocDem.Close;
      fatVenda.cdsDocDem.SetProvider(fatVenda.dspDocDem);
      fatVenda.cdsDocDem.Open;
      pSetaClient(fatVenda.cdsDocDem);

      TFloatField(fatVenda.cdsDocDem.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.message, '[TfrmFatMostraDocDevDemonst.pCarregaDocumento]');
  End;


end;

procedure TfrmFatMostraDocDevDemonst.pLimpaTela;
begin
  If (fatVenda.cdsDocDem.IsEmpty) Then
    Exit;

  fatVenda.cdsDocDem.EmptyDataSet;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  pSetFocus(edtNumDoc);
end;

procedure TfrmFatMostraDocDevDemonst.pMarcaDesmarca;
begin
  If (fatVenda.cdsDocDem.IsEmpty) Then
    Exit;

  fatVenda.cdsDocDem.Edit;

  If (fatVenda.cdsDocDem.FieldByName('MARDES').AsString = 'M') Then
    fatVenda.cdsDocDem.FieldByName('MARDES').AsString := 'D'
  Else
    fatVenda.cdsDocDem.FieldByName('MARDES').AsString := 'M';

  fatVenda.cdsDocDem.Post;
end;

procedure TfrmFatMostraDocDevDemonst.pMarcaDesmarcaTudo;
Var
  intPosAtu: Integer;
begin

  With fatVenda.cdsDocDem Do
  Begin
    intPosAtu := RecNo;
    First;

    While Not Eof Do
    Begin
      pMarcaDesmarca;
      Next;
    End;

    RecNo := intPosAtu;

    pCalculaTotalSelecionado;
  End;

end;

function TfrmFatMostraDocDevDemonst.fGetSQL: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '/* frmFatMostraDocDevDemonst */ ';

  strSQL := strSQL + 'SELECT        ';
  strSQL := strSQL + '  "D"        AS MARDES, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,  ';
  strSQL := strSQL + '  FIS_ACESSO  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  MOVGER      ';
  //strSQL := strSQL + '  INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVGER.GER_NUMDOC AND ';
  strSQL := strSQL + '                      CADFIS.FIS_ESPDOC = MOVGER.GER_ESPDOC AND ';
  strSQL := strSQL + '                      CADFIS.FIS_SERIE_ = MOVGER.GER_SERIE_ AND ';
  strSQL := strSQL + '                      CADFIS.FIS_CODEMP = MOVGER.GER_CODEMP AND ';
  strSQL := strSQL + '                      CADFIS.FIS_FORCLI = MOVGER.GER_CODCLI AND ';
  strSQL := strSQL + '                      CADFIS.FIS_TIP_FC = MOVGER.GER_TIP_FC ';
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI        ';
  strSQL := strSQL + 'WHERE                                                 ';

  If (Not fEmptyStr(edtNumDoc.Text)) Then
  Begin
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC           AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC           AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP           AND ';
  End
  Else
  Begin
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  End;

  strSQL := strSQL + '  GER_CODCLI = :CODCLI             AND ';
  strSQL := strSQL + '  GER_ESPDOC IN ("NF", "EL", "NV") AND ';
  strSQL := strSQL + '  (LOCATE(RIGHT(GER_CLAFIS,3), "' + VS_strClaDem + '") > 0) AND ';
  strSQL := strSQL + '  LEFT(GER_CLAFIS,1) >= 5          AND ';
  strSQL := strSQL + '  GER_JAFATU = 0                       ';

  Result := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
End;

end.

