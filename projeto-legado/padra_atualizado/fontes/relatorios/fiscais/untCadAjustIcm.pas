unit untCadAjustIcm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.Grids, DBGridCitel, DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Vcl.AppEvnts, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Uni, strUtils,
  frxClass, frxExportCSVTestabilidade, untTypesSistema, EditFocus,
  Datasnap.DBClient, untCadDetAjustIcm, UniClientDataSet;

type
  TfrmCadAjustIcm = class(TfrmPaiCad)
    dbgrdAjuIcm: TDBGridCitel;
    Label40: TLabel;
    Label1: TLabel;
    edtdbeMesAno: TDBEditFocus;
    edtValAju: TDBEditFocus;
    dtsAjuIcm: TDataSource;
    Label7: TLabel;
    edtObserv: TDBEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodAju: TEditFocus;
    edtDesAju: TEditFocus;
    Label2: TLabel;
    Label14: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    cdsAdiAju: TUniClientDataSet;
    cdsAdiAjuAJU_CODEMP: TStringField;
    cdsAdiAjuAJU_MESANO: TStringField;
    cdsAdiAjuAJU_NUMDAE: TStringField;
    cdsAdiAjuAJU_NUMPAV: TStringField;
    cdsAdiAjuAJU_INDORI: TStringField;
    cdsAdiAjuAJU_DESAJU: TStringField;
    cdsAdiAjuAJU_COMPLE: TStringField;
    cdsAdiAjuAUTOINCREM: TStringField;
    btnInfAdic: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dtsAjuIcmStateChange(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrdAjuIcmKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdAjuIcmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodAjuExit(Sender: TObject);
    procedure edtCodAjuKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtSerieExit(Sender: TObject);
    procedure edtEspDocExit(Sender: TObject);
    procedure btnInfAdicClick(Sender: TObject);
  private
    blnTravouValidacao: Boolean;
    blnPesquisaTrue: Boolean;
    blnEntrouAdiAju: Boolean;
    arrEmp: TConsultasArray;
    arrAju: TConsultasArray;
    strAUTOINCREM : String;
    objDetAjustIcm: TfrmCadDetAjustIcm;
    procedure pCarregaDoc;
    procedure pCarregaAdiAju;
    procedure pGravaDetAju;
  const
    intTAMDOC = 12;
  public
    procedure pAtualizaCampoEmpresaEAjuste(DataSet: TDataSet);
    procedure pInicializaIndices; override;
    procedure pFormataCampos;
    function fRetNomEmp(strCodEmp: String): String;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadAjustIcm: TfrmCadAjustIcm;

implementation

uses untIFuncoes, untFuncoesSimples, DbAccess, untFuncoesConsulta, untConsultas;

{$R *.dfm}

{ TfrmCadAjustIcm }

procedure TfrmCadAjustIcm.btnInfAdicClick(Sender: TObject);
begin
  inherited;
  objDetAjustIcm := TfrmCadDetAjustIcm.Create(Nil);
  Try
    If (Not blnEntrouAdiAju) Or (Not (dtsAjuIcm.State in [dsInsert, dsEdit])) Then
      pCarregaAdiAju;
    objDetAjustIcm.cdsAdiAju := Self.cdsAdiAju;
    objDetAjustIcm.blnEdicao := (dtsAjuIcm.State in [dsInsert, dsEdit]);
    objDetAjustIcm.ShowModal;
  Finally
    Self.cdsAdiAju := objDetAjustIcm.cdsAdiAju;
    blnEntrouAdiAju := True;
    objDetAjustIcm.Free;
  End;
end;

procedure TfrmCadAjustIcm.btnAlterarClick(Sender: TObject);
begin
  inherited;

  blnEntrouAdiAju := False;
  pSetFocus(edtdbeMesAno);

  pnlInfo.Caption := '';
end;

procedure TfrmCadAjustIcm.btnCancelaClick(Sender: TObject);
begin
  inherited;

  blnEntrouAdiAju := False;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadAjustIcm.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustIcm.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    cdsAdiAju.EmptyDataSet;
    blnEntrouAdiAju := False;
  End
  Else
    fRollBack;

end;

procedure TfrmCadAjustIcm.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
  If dtsAjuIcm.State in [dsInsert] Then
  Begin
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AJUICM', edtCodEmpresa.Text);
    qryTabela.FieldByName('AJU_CODEMP').AsString := edtCodEmpresa.Text;
    qryTabela.FieldByName('AJU_CODAJU').AsString := edtCodAju.Text;
    qryTabela.FieldByName('AJU_NUMNOT').AsString := Iif(fEmptyStr(edtNumDoc.Text), '', edtNumdoc.Text + strAUTOINCREM);
  End;

  If dtsAjuIcm.State in [dsEdit] Then
  begin
    qryTabela.FieldByName('AJU_CODAJU').AsString := edtCodAju.Text;
    qryTabela.FieldByName('AJU_OBSERV').AsString := edtObserv.Text;
    qryTabela.FieldByName('AJU_NUMNOT').AsString := Iif(fEmptyStr(edtNumDoc.Text), '', edtNumdoc.Text + strAUTOINCREM);
  end;

  inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustIcm.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    pGravaDetAju;
    blnEntrouAdiAju := False;
  End
  Else
    fRollBack;

  pSetFocus(dbgrdAjuIcm);

  If Not blnTravouValidacao Then
    pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadAjustIcm.btnIncluirClick(Sender: TObject);
begin
  inherited;

  cdsAdiAju.EmptyDataSet;
  blnEntrouAdiAju := False;
  pSetFocus(edtdbeMesAno);
  pnlInfo.Caption := '';
end;

procedure TfrmCadAjustIcm.pCarregaAdiAju;
var
  qryAdiAju: TUniQuery;
begin
  cdsAdiAju.EmptyDataSet;

  Try
    qryAdiAju := fCriarQuery('SELECT A.* FROM ADIAJU A JOIN DETAJU D ON A.AUTOINCREM = D.AJU_SEQADI WHERE D.AJU_SEQAJU = "' + qryTabela.FieldByName('AUTOINCREM').AsString + '"', Self);
    qryAdiAju.Open;
    While Not qryAdiAju.Eof Do
    Begin
      cdsAdiAju.Insert;
      cdsAdiAju.FieldByName('AUTOINCREM').AsString := qryAdiAju.FieldByName('AUTOINCREM').AsString;
      cdsAdiAju.FieldByName('AJU_CODEMP').AsString := qryAdiAju.FieldByName('AJU_CODEMP').AsString;
      cdsAdiAju.FieldByName('AJU_MESANO').AsString := qryAdiAju.FieldByName('AJU_MESANO').AsString;
      cdsAdiAju.FieldByName('AJU_NUMDAE').AsString := qryAdiAju.FieldByName('AJU_NUMDAE').AsString;
      cdsAdiAju.FieldByName('AJU_NUMPAV').AsString := qryAdiAju.FieldByName('AJU_NUMPAV').AsString;
      cdsAdiAju.FieldByName('AJU_INDORI').AsString := qryAdiAju.FieldByName('AJU_INDORI').AsString;
      cdsAdiAju.FieldByName('AJU_DESAJU').AsString := qryAdiAju.FieldByName('AJU_DESAJU').AsString;
      cdsAdiAju.FieldByName('AJU_COMPLE').AsString := qryAdiAju.FieldByName('AJU_COMPLE').AsString;
      cdsAdiAju.Post;
      qryAdiAju.Next;
    End;
  Finally
    FreeAndNil(qryAdiAju);
  End;
end;

procedure TfrmCadAjustIcm.pGravaDetAju;
var
  qryDetAju: TUniQuery;
begin
  If Not cdsAdiAju.IsEmpty Then
  Begin
    Try
      qryDetAju := fCriaQuery(Nil);
      qryDetAju.Close;
      qryDetAju.SQL.Clear;
      qryDetAju.SQL.Add('DELETE FROM DETAJU WHERE AJU_SEQAJU = "' + qryTabela.FieldByName('AUTOINCREM').AsString + '"');
      qryDetAju.ExecSQL;
      cdsAdiAju.First;
      While Not cdsAdiAju.Eof Do
      Begin
        qryDetAju.Close;
        qryDetAju.SQL.Clear;
        qryDetAju.SQL.Add('INSERT INTO DETAJU (AUTOINCREM, AJU_SEQAJU, AJU_SEQADI) VALUES (:AUTINC, :SEQAJU, :SEQADI)');
        qryDetAju.Params.ParamByName('AUTINC').AsString := fRetAutoIncrem('DETAJU', VS_strCodEmp);
        qryDetAju.Params.ParamByName('SEQAJU').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryDetAju.Params.ParamByName('SEQADI').AsString := cdsAdiAju.FieldByName('AUTOINCREM').AsString;
        qryDetAju.ExecSQL;
        cdsAdiAju.Next;
      End;
    Finally
      FreeAndNil(qryDetAju);
    End;
  End;
end;

procedure TfrmCadAjustIcm.btnPesquisaClick(Sender: TObject);
var
  arrSel: TConsultasArray;
  qryConsulta: TUniQuery;
  chrKey : Char;
begin
  chrKey := '/';

  Try
    qryConsulta := fCriaQuery;
    If fPesqAjustIcm(Self, qryConsulta, chrKey, arrSel) Then
    Begin
      qryTabela.Locate('AJU_MESANO;AJU_CODEMP;AUTOINCREM', VarArrayOf([qryConsulta.FieldByName('AJU_MESANO').AsString,
                                                                       qryConsulta.FieldByName('AJU_CODEMP').AsString,
                                                                       qryConsulta.FieldByName('AUTOINCREM').AsString]), []);

      edtdbeMesAno.Text  := qryConsulta.FieldByName('AJU_MESANO').AsString;
      edtCodAju.Text     := qryConsulta.FieldByName('AJU_CODAJU').AsString;
      edtDesAju.Text     := fRetDesAjuIcm(qryConsulta.FieldByName('AJU_CODAJU').AsString);
      edtValAju.Text     := FloatToStrF(qryConsulta.FieldByName('AJU_VALAJU').AsFloat, ffNumber, 015, 002);
      edtObserv.Text     := qryConsulta.FieldByName('AJU_OBSERV').AsString;
      edtNumDoc.Text     := Copy(qryConsulta.FieldByName('AJU_NUMNOT').AsString,  1, 12);
      edtCodEmpresa.Text := qryConsulta.FieldByName('AJU_CODEMP').AsString;
      edtDesEmpresa.Text := fRetNomEmp(qryConsulta.FieldByName('AJU_CODEMP').AsString);

      btnAlterarClick(Sender);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadAjustIcm.dbgrdAjuIcmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

procedure TfrmCadAjustIcm.dbgrdAjuIcmKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #13 Then
    btnAlterarClick(Sender);
end;

procedure TfrmCadAjustIcm.dtsAjuIcmStateChange(Sender: TObject);
begin
  inherited;
  If dtsAjuIcm.State in [dsBrowse] Then
    dbgrdAjuIcm.Enabled := True
  Else
    dbgrdAjuIcm.Enabled := False;
end;

procedure TfrmCadAjustIcm.edtCodAjuExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAju, edtDesAju, arrAju, fRetDesAjuIcm, Nil, 'do ajuste');
end;

procedure TfrmCadAjustIcm.edtCodAjuKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqAju(Self, edtCodAju, edtDesAju, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodAju, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAjustIcm.edtCodEmpresaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmCadAjustIcm.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmCadAjustIcm.edtEspDocExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtEspDoc.Text)) Then
    pCarregaDoc;
end;

procedure TfrmCadAjustIcm.edtNumDocExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDoc.Text)) Then
    pCarregaDoc;
end;

procedure TfrmCadAjustIcm.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  qryGen        : TUniQuery;
  arrSel        : TConsultasArray;
begin

  If (fEntraCons(Key)) Then
  Begin
    blnPesquisaTrue := False;

    Key := '?';

    Try
      qryGen :=  fCriaQuery(Self);

      If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, conGeral, '', '', '', '', False, 0, 0, True, VS_strCodEmp) Then
      Begin
        edtNumDoc.Text      := qryGen.FieldByName('FIS_NUMDOC').AsString;
        edtSerie.Text       := qryGen.FieldByName('FIS_SERIE_').AsString;
        edtEspDoc.Text      := qryGen.FieldByName('FIS_ESPDOC').AsString;
        strAUTOINCREM       := qryGen.FieldByName('AUTOINCREM').AsString;
        blnPesquisaTrue     := True;
        SelectNext(ActiveControl, True, True);
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;

end;


procedure TfrmCadAjustIcm.edtSerieExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtSerie.Text)) Then
    pCarregaDoc;
end;

procedure TfrmCadAjustIcm.FormCreate(Sender: TObject);
begin
  inherited;

  If fTabelaExiste('AJUICM', True)  Then
  Begin
    pVerificaProCod;
    pValidaProCod('AJUICM');
  End;

  strNomeTabela := 'AJUICM';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM AJUICM ', Self);

  qryTabela.FieldByName('AJU_MESANO').EditMask := '99/9999';

  pFormataCampos;

  dtsAjuIcm.DataSet := qryTabela;

  qryTabela.AfterScroll := pAtualizaCampoEmpresaEAjuste;

  cdsAdiAju.CreateDataSet;

  blnEntrouAdiAju := False;
end;

procedure TfrmCadAjustIcm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_INSERT) And (dtsAjuIcm.State in [dsBrowse]) Then
    btnIncluirClick(Sender);
end;

procedure TfrmCadAjustIcm.FormShow(Sender: TObject);
begin
  inherited;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.sql.Text := 'SELECT CAST(CONCAT(RIGHT(AJU_MESANO, 04), LEFT(AJU_MESANO, 02), "01") AS DATE) NOVA_DATA, AJUICM.* FROM AJUICM ORDER BY NOVA_DATA DESC ';
  qryTabela.FieldByName('AJU_MESANO').EditMask := '99/9999';

  pFormataCampos;

  qryTabela.Open;

  pSetFocus(btnIncluir);

  blnPesquisaTrue := False;
  strAUTOINCREM   := '';
end;

function TfrmCadAjustIcm.fRetNomEmp(strCodEmp: String): String;
  Var
    qryAux: TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ';
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := FieldByName('EMP_NOMEMP').AsString;
    End;
  Finally
    qryAux.Free;
  End;
end;

function TfrmCadAjustIcm.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  blnTravouValidacao := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

      Try
        StrToDate('01/' + edtdbeMesAno.Text);
      Except
        fMensagem('', 'Valor inválido para o campo Mês / Ano!', ['&Ok']);
        blnTravouValidacao := True;
        Result := False;
      End;

      Try
        strToInt(RightStr(edtdbeMesAno.Text, 04));
        strToInt(LeftStr(edtdbeMesAno.Text, 02));
      Except
        fMensagem('', 'Informe o mês com dois dígitos e o ano com quatro dígitos, no formato 99/9999!', ['&Ok']);
        blnTravouValidacao := True;
        Result := False;
      End;

    If Sender = edtCodAju Then
    Begin
      If fEmptyStr(edtCodAju.Text) Then
      Begin
        fMensagem('', 'É necessário informar um Código de Ajuste!', ['&Ok']);
        blnTravouValidacao := True;
        Result := False;
      End;
    End;

    If (fStrToFloat(edtValaJU.Text) < 0) Then
    Begin
      fMensagem('', 'Valor do Ajuste não pode ser negativo!', ['&Ok']);
      blnTravouValidacao := True;
      Result := False;
    End;

    If Sender = edtCodEmpresa Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('', 'É necessário informar uma empresa válida!', ['&Ok']);
        blnTravouValidacao := True;
        Result := False;
      End;
    End;

    If (Sender = edtNumDoc) Or
       (Sender = edtEspDoc) Or
       (Sender = edtSerie) Then
    Begin
      pCarregaDoc;
    End;

    pSetFocus(Sender);
  End;

end;

procedure TfrmCadAjustIcm.pAtualizaCampoEmpresaEAjuste(DataSet: TDataSet);
  Var
    qryAux: TUniQuery;
    strTMP: String;
begin
  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ';
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('AJU_CODEMP').AsString;
      Open;

      edtCodEmpresa.Text := qryTabela.FieldByName('AJU_CODEMP').AsString;
      edtDesEmpresa.Text := FieldByName('EMP_NOMEMP').AsString;
    End;

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT AJU_DESAJU FROM AJUSTE WHERE AJU_CODAJU = :CODAJU ';
      ParamByName('CODAJU').AsString := qryTabela.FieldByName('AJU_CODAJU').AsString;
      Open;

      edtCodAju.Text := qryTabela.FieldByName('AJU_CODAJU').AsString;
      edtDesAju.Text := FieldByName('AJU_DESAJU').AsString;

      edtNumDoc.Text := Copy(qryTabela.FieldByName('AJU_NUMNOT').AsString,  1, 12);
      strTMP         := Copy(qryTabela.FieldByName('AJU_NUMNOT').AsString, 13, 32);
      strAUTOINCREM  := strTMP;

      If (Not fEmptyStr(strTMP)) And (strTMP <> '00000000000000000000') Then
      Begin
        edtSerie.Text  := fCampoTabela('FIS_SERIE_', 'CADFIS', ['AUTOINCREM'], [strTMP]);
        edtEspDoc.Text := fCampoTabela('FIS_ESPDOC', 'CADFIS', ['AUTOINCREM'], [strTMP]);
      End
      Else
      Begin
        edtSerie.Clear;
        edtEspDoc.Clear;
      End;

    End;

  Finally
    qryAux.Free;
  End;
end;

procedure TfrmCadAjustIcm.pCarregaDoc;
  Var
    qryGen: TUniQuery;
begin

  If (Not fEmptyStr(edtNumDoc.Text)) And
     (Not fEmptyStr(edtSerie.Text)) And
     (Not fEmptyStr(edtEspDoc.Text)) And
     (Not blnPesquisaTrue) Then
  Begin
    Try
      strAUTOINCREM := '';

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' SELECT DISTINCT ');
      qryGen.SQL.Add('   FIS_FORCLI, ');
      qryGen.SQL.Add('   FIS_TIP_FC, ');
      qryGen.SQL.Add('   FIS_CODEMP, ');
      qryGen.SQL.Add('   FIS_NUMDOC, ');
      qryGen.SQL.Add('   FIS_ESPDOC, ');
      qryGen.SQL.Add('   FIS_SERIE_, ');
      qryGen.SQL.Add('   FIS_DTADOC, ');
      qryGen.SQL.Add('   FIS_ACESSO, ');
      qryGen.SQL.Add('   FIS_ENTSAI, ');
      qryGen.SQL.Add('   AUTOINCREM ');
      qryGen.SQL.Add(' FROM CADFIS ');
      qryGen.SQL.Add(' WHERE TRUE ');
      qryGen.SQL.Add('     AND FIS_ESPDOC = :ESPDOC ');

      qryGen.SQL.Add('     AND FIS_CODEMP = ' + AnsiQuotedStr(VS_strCodEmp, '"'));
      qryGen.SQL.Add('     AND FIS_NUMDOC = :NUMDOC ');
      qryGen.SQL.Add('     AND IFNULL(FIS_SERIE_, "") = :SERIE ');

      qryGen.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      qryGen.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryGen.ParamByName('SERIE').AsString  := edtSerie.Text;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        fMensagem('', 'Documento não encontrado!', ['&Ok']);
        edtNumDoc.Clear;
        edtEspDoc.Clear;
        edtSerie.Clear;
      End
      Else If qryGen.RecordCount > 1 Then
      Begin
        fMensagem('', 'Encontrado mais de um documento, utilize a pesquisa para definição!', ['&Ok']);
        edtNumDoc.Clear;
        edtEspDoc.Clear;
        edtSerie.Clear;
      End
      Else
      Begin
        strAUTOINCREM := qryGen.FieldByName('AUTOINCREM').AsString;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TfrmCadAjustIcm.pFormataCampos;
begin
  TFloatField(qryTabela.FieldByName('AJU_VALAJU')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJU_VALAJU')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadAjustIcm.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AJU_MESANO');
  stlCampos.Add('AJU_VALAJU');
  stlCampos.Add('AJU_CODAJU');
  stlCampos.Add('AJU_CODEMP');
  stlCampos.Add('AJU_OBSERV');
  stlCampos.Add('AJU_NUMNOT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJU_CODEMP');
  stlCamInd.Add('AJU_MESANO');
end;

end.
