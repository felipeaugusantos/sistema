unit untCadComFatMarDepart;

interface

uses
  Windows, Classes, Controls,
  untPaiCad, StdCtrls, EditFocus, DBCtrls, DBEditFocus, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Uni,
  BitBtnLockedIncrem, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadComFatMarDepart = class(TfrmPaiCad)
    pnl1: TPanel;
    pnlTopo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    dbeCodTab: TDBEditFocus;
    dbeDesTab: TDBEditFocus;
    pnlComDep: TPanel;
    lbl7: TLabel;
    edtPerCom: TEditFocus;
    grdComDep: TDBGridCitel;
    dtsComDep: TDataSource;
    dtsTabela: TDataSource;
    cdsComDep: TUniClientDataSet;
    cdsComDepAUTOIN: TStringField;
    cdsComDepSEQCOM: TStringField;
    cdsComDepPERCOM: TFloatField;
    lblCodDep: TLabel;
    edtDesDep: TEditFocus;
    Label1: TLabel;
    edtMarIni: TEditFocus;
    Label2: TLabel;
    edtMarFin: TEditFocus;
    cdsComDepMARINI: TFloatField;
    cdsComDepMARFIN: TFloatField;
    edtCodDep: TDBEditFocus;
    btnAdicionar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdComDepKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryComFat: TUniQuery;
    procedure pCarregaGrid;
    procedure pLimparPanelComDep;
    procedure pDeletaFaixa;
    procedure pHabilitaCampos(blnHabilita: Boolean);

    function fInserirComDep: Boolean;
    function fGravarComDep(strSeqCom: String): Boolean;
    function fFaixaCadastrada(fltMarIni, fltMarFin: Double): Boolean;
	function fValidarPodeFocarBotaoAlterar: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

var
  frmCadComFatMarDepart: TfrmCadComFatMarDepart;

implementation

uses SysUtils, Forms, untConstantes, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadComFatMarDepart.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Or
     (Not fValidaCampos(edtMarFin, True)) Then
    Exit;
  If fInserirComDep Then
    pLimparPanelComDep;
end;

procedure TfrmCadComFatMarDepart.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(True);
  pHabilitaCodigo(dbeCodTab, dbeCodTab, True);
end;

procedure TfrmCadComFatMarDepart.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.Active Then
    pCarregaGrid;

  pHabilitaCampos(edtCodDep.Enabled);
end;

procedure TfrmCadComFatMarDepart.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComFatMarDepart.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    cdsComDep.EmptyDataSet;
    fCommit
  End
  Else
    fRollBack;
end;

procedure TfrmCadComFatMarDepart.btnGravarClick(Sender: TObject);
  Var
    strAutoIn: String;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fEmptyStr(edtCodDep.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O departamento deve ser preenchido!', ['&Ok']);
    pSetFocus(edtCodDep);
    Exit;
  End;

  If Not fValidaCampos(edtCodDep, True) Then
    Exit;

  qryTabela.FieldByName('COM_CODDEP').AsString := edtCodDep.Text;

  Try
    inherited;

    If blnGravou Then
    Begin
      strAutoIn := qryTabela.FieldByName('AUTOINCREM').AsString;
      fGravarComDep(strAutoIn);
      pHabilitaCampos(False);
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadComFatMarDepart.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(True);
  pHabilitaCodigo(dbeCodTab, dbeCodTab, True);
  cdsComDep.EmptyDataSet;
end;

procedure TfrmCadComFatMarDepart.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqComissaoFatMarDepart(conSimples,
                               Self,
                               nil,
                               nil,
                               qryTabela,
                               chrKey,
                               arrSel) Then
  Begin
    If fValidarPodeFocarBotaoAlterar Then
      pSetFocus(btnAlterar);

    fValidaCampos(edtCodDep, True);
  End;
  If qryTabela.Active Then
    pCarregaGrid;
end;

function TfrmCadComFatMarDepart.fValidarPodeFocarBotaoAlterar: Boolean;
begin
  Result := False;
  
  If (not btnAlterar.Enabled) then  
    Exit;
  
  If (not btnAlterar.Visible) Then
    Exit;
	
  Result := True;
end;

procedure TfrmCadComFatMarDepart.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFatMarDepart.FormCreate(Sender: TObject);
begin
  inherited;
  qryComFat           := fCriaQuery(Self);
  strNomeTabela       := 'COMDMG';
  strNomeCampo        := 'COM_CODTAB';
  qryTabela           := qryComFat;
  dtsTabela.DataSet   := qryTabela;
  cdsComDep.CreateDataSet;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0]   := dbeCodTab;
end;

procedure TfrmCadComFatMarDepart.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(False);
end;

function TfrmCadComFatMarDepart.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try

    If Sender = dbeCodTab Then
    Begin
      If fEmptyStr(dbeCodTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDesTab Then
    Begin
      If fEmptyStr(dbeDesTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtMarIni) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtMarIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de margem inicial deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtMarFin) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtMarFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de margem final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtMarIni.Text) > fStrToFloat(edtMarFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de margem final não pode ser menor que o percentual de margem inicial!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodDep) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodDep.Text) Then
      Begin
        edtDesDep.Clear;
        pSetFocus(btnGravar);
        blnMudarFoco := False;
      End
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [edtCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerCom) And blnBuscaPorChave And (Not fEmptyStr(edtCodDep.Text)) Then
    Begin
      If fEmptyStr(edtPerCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de comissão deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
			pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComFatMarDepart.grdComDepKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then
    pDeletaFaixa;
end;

procedure TfrmCadComFatMarDepart.pCarregaGrid;
  Var
    strSQL   : String;
    qryComDep: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT          ';
    strSQL := strSQL + '  C.AUTOINCREM, ';
    strSQL := strSQL + '  C.COM_SEQCOM, ';
    strSQL := strSQL + '  C.COM_MARINI, ';
    strSQL := strSQL + '  C.COM_MARFIN, ';
    strSQL := strSQL + '  C.COM_PERCOM  ';
    strSQL := strSQL + 'FROM            ';
    strSQL := strSQL + '  COMDMD C      ';
    strSQL := strSQL + 'WHERE           ';
    strSQL := strSQL + '  C.COM_SEQCOM = :AUTOIN ';

    qryComDep := fCriaQuery(Self);

    qryComDep.Close;
    qryComDep.SQL.Text := strSQL;
    qryComDep.ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryComDep.Open;
    cdsComDep.EmptyDataSet;
    While Not qryComDep.Eof Do
    Begin
      cdsComDep.Append;
      cdsComDepAUTOIN.AsString := qryComDep.FieldByName('AUTOINCREM').AsString;
      cdsComDepSEQCOM.AsString := qryComDep.FieldByName('COM_SEQCOM').AsString;
      cdsComDepMARINI.AsFloat  := qryComDep.FieldByName('COM_MARINI').AsFloat;
      cdsComDepMARFIN.AsFloat  := qryComDep.FieldByName('COM_MARFIN').AsFloat;
      cdsComDepPERCOM.AsFloat  := qryComDep.FieldByName('COM_PERCOM').AsFloat;
      cdsComDep.Post;
      qryComDep.Next;
    End;
    cdsComDep.IndexFieldNames := 'MARINI;MARFIN';
  Finally
    FreeAndNil(qryComDep);
  End;
end;

procedure TfrmCadComFatMarDepart.pDeletaFaixa;
begin
  If (cdsComDep.IsEmpty) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente excluir essa faixa?', ['&S i m', '&N ã o'], 2) = 1) Then
    cdsComDep.Delete;
end;

procedure TfrmCadComFatMarDepart.pHabilitaCampos(blnHabilita: Boolean);
begin
  pnlComDep.Enabled := blnHabilita;
  grdComDep.Enabled := blnHabilita
end;

procedure TfrmCadComFatMarDepart.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_FATINI');
  stlCampos.Add('COM_FATFIN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadComFatMarDepart.fFaixaCadastrada(fltMarIni,
  fltMarFin: Double): Boolean;
Var
  cdsFaiTmp: TUniClientDataSet;
begin

  Result := False;

  Try

    cdsFaiTmp := TUniClientDataSet.Create(Self);
    cdsFaiTmp.Data := cdsComDep.Data;
    cdsFaiTmp.Open;
    
    cdsFaiTmp.First;

    While Not cdsFaiTmp.Eof Do
    Begin
      If (cdsFaiTmp.FieldByName('MARINI').AsFloat = fltMarIni) And
         (cdsFaiTmp.FieldByName('MARFIN').AsFloat = fltMarFin) Then
      Begin
        Result := True;
        Break;
      End;

      cdsFaiTmp.Next;
    End;

  Finally
    FreeAndNil(cdsFaiTmp);
  End;

end;

function TfrmCadComFatMarDepart.fGravarComDep(strSeqCom: String): Boolean;
  Var
    strSQL   : String;
    qryComDep: TUniQuery;
begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  COMDMD    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COM_SEQCOM = :AUTOIN ';
    qryComDep := fCriaQuery(Self);

    qryComDep.Close;
    qryComDep.SQL.Text := strSQL;
    qryComDep.ParamByName('AUTOIN').AsString := strSeqCom;
    qryComDep.ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO   ';
    strSQL := strSQL + '  COMDMD     (';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  COM_SEQCOM, ';
    strSQL := strSQL + '  COM_MARINI, ';
    strSQL := strSQL + '  COM_MARFIN, ';
    strSQL := strSQL + '  COM_PERCOM) ';
    strSQL := strSQL + 'VALUES       (';
    strSQL := strSQL + '  :AUTOIN,    ';
    strSQL := strSQL + '  :SEQCOM,    ';
    strSQL := strSQL + '  :MARINI,    ';
    strSQL := strSQL + '  :MARFIN,    ';
    strSQL := strSQL + '  :PERCOM)    ';

    cdsComDep.First;
    While Not cdsComDep.Eof Do
    Begin
      qryComDep.Close;
      qryComDep.SQL.Text := strSQL;
      qryComDep.ParamByName('AUTOIN').AsString := fRetAutoIncrem('COMDMD',VS_strCodEmp);
      qryComDep.ParamByName('SEQCOM').AsString := strSeqCom;
      qryComDep.ParamByName('MARINI').AsFloat  := cdsComDepMARINI.AsFloat;
      qryComDep.ParamByName('MARFIN').AsFloat  := cdsComDepMARFIN.AsFloat;
      qryComDep.ParamByName('PERCOM').AsFloat  := cdsComDepPERCOM.AsFloat;
      qryComDep.ExecSQL;
      cdsComDep.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCadComFatMarDepart.fInserirComDep: Boolean;
begin
  If fEmptyStr(edtCodDep.Text) Then
  Begin
    Result := True;
    Exit;
  End;
  Result := True;
  If (fFaixaCadastrada(fStrToFloat(edtMarIni.Text), fStrToFloat(edtMarFin.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'Departamento já cadastrado para esta Faixa!', ['&Ok']);
    pLimparPanelComDep;
    Result := False;
  End
  Else
  Begin
    cdsComDep.Append;
    cdsComDepSEQCOM.AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    cdsComDepMARINI.AsFloat  := fStrToFloat(edtMarIni.Text);
    cdsComDepMARFIN.AsFloat  := fStrToFloat(edtMarFin.Text);
    cdsComDepPERCOM.AsFloat  := fStrToFloat(edtPerCom.Text);
    cdsComDep.Post;
  End;
end;

procedure TfrmCadComFatMarDepart.pLimparPanelComDep;
begin
  edtMarIni.Text := '0,00';
  edtMarFin.Text := '0,00';
  edtPerCom.Text := '0,0000';

  pSetFocus(edtMarIni);
    
end;



end.

